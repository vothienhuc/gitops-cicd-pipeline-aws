window.addEventListener('DOMContentLoaded', () => {
  if (typeof mysqlConnected !== 'undefined') {
    const mysqlStatus = document.getElementById('mysqlStatus');
    mysqlStatus.querySelector('.status-text').textContent =
      mysqlConnected ? '✅ Connected successfully' : '❌ Failed to connect';
    if (mysqlConnected) {
      mysqlStatus.querySelector('img').classList.add('animated');
      mysqlStatus.querySelector('img').classList.remove('hidden');
    }
  }

  if (typeof redisConnected !== 'undefined') {
    const redisStatus = document.getElementById('redisStatus');
    redisStatus.querySelector('.status-text').textContent =
      redisConnected ? '✅ Connected successfully' : '❌ Failed to connect';
    if (redisConnected) {
      redisStatus.querySelector('img').classList.add('animated');
      redisStatus.querySelector('img').classList.remove('hidden');
    }
  }
});
