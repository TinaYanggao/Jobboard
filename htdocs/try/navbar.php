<?php
session_start(); // make sure session is started

// default role if not logged in
$role = isset($_SESSION['role']) ? $_SESSION['role'] : null;
?>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="dashboard.php">JobEntry</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
      aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">

        <!-- Always visible -->
        <li class="nav-item">
          <a class="nav-link" href="dashboard.php">Dashboard</a>
        </li>

        <?php if ($role === 'user'): ?>
          <!-- User Menu -->
          <li class="nav-item">
            <a class="nav-link" href="find_jobs.php">Find Jobs</a>
          </li>
        <?php elseif ($role === 'admin'): ?>
          <!-- Admin Menu -->
          <li class="nav-item">
            <a class="nav-link" href="hire_talent.php">Hire Talent</a>
          </li>
        <?php endif; ?>

        <!-- Always visible -->
        <li class="nav-item">
          <a class="nav-link" href="profile.php">Profile</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="logout.php">Logout</a>
        </li>
      </ul>
    </div>
  </div>
</nav>
