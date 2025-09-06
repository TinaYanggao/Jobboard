<?php
session_start();
include 'job_db.php';

// Handle logout
if (isset($_GET['logout'])) {
    session_unset();
    session_destroy();
    header("Location: index.php");
    exit;
}

// Check if user is logged in
if (!isset($_SESSION['user_id'])) {
    header("Location: index.php");
    exit;
}

// Get current user info
$user       = $_SESSION['full_name'] ?? 'User';
$user_email = $_SESSION['email'] ?? '';
$user_id    = $_SESSION['user_id'] ?? 0;
$role       = $_SESSION['role'] ?? 'user'; // ✅ Get role

// Fetch applications for logged-in user (for regular users)
$applications = [];
if ($role === 'user' && $user_email) {
    $stmt = $conn->prepare("
        SELECT a.*, 
               j.title AS job_title
        FROM applications a
        LEFT JOIN jobs j ON a.job_id = j.id
        WHERE a.applicant_email = ?
        ORDER BY a.applied_at DESC
    ");
    $stmt->bind_param("s", $user_email);
    $stmt->execute();
    $result = $stmt->get_result();
    if ($result->num_rows > 0) {
        $applications = $result->fetch_all(MYSQLI_ASSOC);
    }
    $stmt->close();
}

// Fetch accepted applicants for admin
$accepted_applicants = [];
if ($role === 'admin') {
    $stmt = $conn->prepare("
        SELECT a.*, 
               j.title AS job_title
        FROM applications a
        LEFT JOIN jobs j ON a.job_id = j.id
        WHERE a.status = 'Accepted'
        ORDER BY a.applied_at DESC
    ");
    $stmt->execute();
    $result = $stmt->get_result();
    if ($result->num_rows > 0) {
        $accepted_applicants = $result->fetch_all(MYSQLI_ASSOC);
    }
    $stmt->close();
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>JobEntry Dashboard</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
body { margin: 0; font-family: 'Segoe UI', sans-serif; background-color: #f4f6f9; }
.sidebar { height: 100vh; width: 225px; position: fixed; top: 0; left: 0; background-color: #032D84; padding-top: 20px; box-shadow: 2px 0 10px rgba(0,0,0,0.1); }
.sidebar h2 { color: #ffffff; text-align: center; font-weight: bold; margin-bottom: 30px; }
.sidebar a { padding: 12px 20px; display: block; color: #ffffff; text-decoration: none; font-weight: 500; border-radius: 6px; margin: 5px 10px; transition: all 0.3s ease; }
.sidebar a:hover { background-color: #ffffff; color: #032D84; }
.main-content { margin-left: 225px; padding: 40px; }
.welcome-card { background-color: #032D84; color: #ffffff; padding: 50px; border-radius: 15px; text-align: center; box-shadow: 0 4px 12px rgba(0,0,0,0.15); }
.welcome-card h2 { font-weight: bold; margin-bottom: 15px; }
.welcome-card p { font-size: 1.1rem; margin-bottom: 25px; }
.btn-explore { background-color: #ffffff; color: #032D84; font-weight: 600; padding: 10px 20px; border-radius: 8px; margin-right: 10px; border: 2px solid #ffffff; }
.btn-explore:hover { background-color: #f0f0f0; color: #032D84; }
.btn-hire { background-color: transparent; color: #ffffff; font-weight: 600; padding: 10px 20px; border-radius: 8px; border: 2px solid #ffffff; }
.btn-hire:hover { background-color: #ffffff; color: #032D84; }
.status-badge { padding: 5px 10px; border-radius: 12px; font-size: 0.9rem; font-weight: 600; }
.status-pending { background-color: #ffc107; color: #000; }
.status-accepted { background-color: #28a745; color: #fff; }
.status-rejected { background-color: #dc3545; color: #fff; }
</style>
</head>
<body>

<div class="sidebar">
  <h2>JobEntry</h2>
  <a href="dashboard.php">Dashboard</a>

  <?php if ($role === 'user'): ?>
      <a href="find_job.php">Find Jobs</a>
  <?php elseif ($role === 'admin'): ?>
      <a href="hire_talent.php">Hire Talent</a>
  <?php endif; ?>

  <a href="profile.php">Profile</a>
  <a href="?logout=true" onclick="confirmLogout(event)">Sign Out</a>
</div>

<div class="main-content">
  <div class="welcome-card">
    <h2>Welcome back, <?php echo htmlspecialchars($user); ?>!</h2>
    <p>Discover jobs, connect with top companies, and explore talent opportunities.</p>

    <?php if ($role === 'user'): ?>
      <a href="find_job.php" class="btn btn-explore">Explore Jobs</a>
    <?php elseif ($role === 'admin'): ?>
      <a href="hire_talent.php" class="btn btn-hire">Hire Talent</a>
    <?php endif; ?>
  </div>

  <div class="mt-4">
    <?php if ($role === 'user'): ?>
        <?php if (!empty($applications)): ?>
            <?php foreach ($applications as $app): ?>
                <div class="card mb-3">
                    <div class="card-body">
                        <h5 class="card-title"><?php echo htmlspecialchars($app['job_title']); ?></h5>
                        <p class="mb-1"><strong>Applied on:</strong> <?php echo date('M d, Y', strtotime($app['applied_at'])); ?></p>
                        <p class="mb-2"><strong>Status:</strong> 
                            <?php if ($app['status'] == 'Pending'): ?>
                                <span class="status-badge status-pending">Pending</span>
                            <?php elseif ($app['status'] == 'Accepted'): ?>
                                <span class="status-badge status-accepted">Accepted</span>
                            <?php elseif ($app['status'] == 'Rejected'): ?>
                                <span class="status-badge status-rejected">Rejected</span>
                            <?php else: ?>
                                <span class="status-badge"><?php echo htmlspecialchars($app['status']); ?></span>
                            <?php endif; ?>
                        </p>
                        <?php if (!empty($app['cover_letter'])): ?>
                            <p><strong>Cover Letter:</strong><br><?php echo nl2br(htmlspecialchars($app['cover_letter'])); ?></p>
                        <?php endif; ?>
                        <?php if (!empty($app['resume_path'])): ?>
                            <p><a href="<?php echo htmlspecialchars($app['resume_path']); ?>" target="_blank">View Resume</a></p>
                        <?php endif; ?>
                    </div>
                </div>
            <?php endforeach; ?>
        <?php else: ?>
            <p class="text-muted">You haven't applied to any jobs yet.</p>
        <?php endif; ?>
    <?php elseif ($role === 'admin'): ?>
        <?php if (!empty($accepted_applicants)): ?>
            <h4>Accepted Applicants</h4>
            <?php foreach ($accepted_applicants as $app): ?>
                <div class="card mb-3">
                    <div class="card-body">
                        <h5 class="card-title"><?php echo htmlspecialchars($app['job_title']); ?></h5>
                        <p class="mb-1"><strong>Applicant:</strong> <?php echo htmlspecialchars($app['applicant_name'] ?? $app['applicant_email']); ?></p>
                        <p class="mb-1"><strong>Email:</strong> <?php echo htmlspecialchars($app['applicant_email']); ?></p>
                        <p class="mb-1"><strong>Applied on:</strong> <?php echo date('M d, Y', strtotime($app['applied_at'])); ?></p>
                        <?php if (!empty($app['cover_letter'])): ?>
                            <p><strong>Cover Letter:</strong><br><?php echo nl2br(htmlspecialchars($app['cover_letter'])); ?></p>
                        <?php endif; ?>
                        <?php if (!empty($app['resume_path'])): ?>
                            <p><a href="<?php echo htmlspecialchars($app['resume_path']); ?>" target="_blank">View Resume</a></p>
                        <?php endif; ?>
                    </div>
                </div>
            <?php endforeach; ?>
        <?php else: ?>
            <p class="text-muted">No accepted applicants yet.</p>
        <?php endif; ?>
    <?php endif; ?>
  </div>
</div>

<script>
function confirmLogout(event) {
  if (!confirm("Are you sure you want to sign out?")) {
    event.preventDefault();
  }
}
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
