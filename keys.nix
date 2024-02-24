let
  rsa_2018 = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDiVRMtzvDh51MRb4B+bgllVC5nct8nYoaYoMYmILfXn0H9T+G1Ua4fEpZtVMH9fpHRYc1KT7zMv4ltYqAptO6wnqAM7MOY4M5Ur2wSOl36Vwv8JnWmP46W6b1vLNTJpGBOZPtRzg/mTPY5ZpDw3s6uCGBb3EUFhznLPbZIFvo2R9jyCXej5EDw5vKJ+zXSaCbT3pRvMcMR7NU+tV2GPYDZNAHimaKdLdSGVZqnq1VqLQ74RDDnMaNsf1cfYay6Xlyzns5vSrrbtUDQgHIJzn32OEuukEDzFyiJYsyI6obdOWMjdy5Yn8CBq1zb3Q/x5Tre1y6uRh635sTvA5X+Mnn985PPCPwbej/gelNkwgk/eC9exJPRdMztvunsxStvkGu0XDG85qBksDq6a222aOLn3lom4KQrZS5PG1feAQDgE+d/t78AISb7fAcDOk7d8lhkwYiDfL6fCk3gkvZSO9LKwcpq8UxtgLhTTCzGnMZuTsCtuRitPkiZcVC7x/qDUB+7TxU90tUFHsecEqmtuPwev+0qheM98md6lZhXrqeSYhBIWi2x4Hnm9vP1Hz7n9kNDuNF5U7VvAg/ibCgk/DbQjaeptvFYSfdjW7fZzjOTFftbqlFr6cNkHEDT209JGdpN5s7+hc7iQn8rW4FjuKI908FdktC9PB7X+pPa+GVrqQ==";
  ed25519_2023 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH6AxoagkDHpRMWHaBsl/xKnxf56ewz32cuLgXMeNMPk";
in rec {
  ssh = rec {
    old_machines = rsa_2018;
    modern_machines = ed25519_2023;
    signing = modern_machines;
  };
  users = {
    romi = ssh.modern_machines;
  };
  hosts = {
    macbook-pro-m1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG9BGCOKZl4hv4d6lDmEB2UVRsxruWwUhX2kookNYVNc";
    innocence = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHNYn7MJQtRWn0MYZEezFInO8yYSAzOkBefkTj7YMiEl";
    yuri = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIId1NY/bptjhoZ4d8VDNangFlavdR2Ee6hJEyA0rgv0Q";
  };
}
