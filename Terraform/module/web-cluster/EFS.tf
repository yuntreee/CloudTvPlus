resource "aws_efs_file_system" "efs" {
  creation_token = "ctp-efs-${var.region_name}"
  encrypted = true
  tags = {
    Name = "ctp-efs-${var.region_name}"
  }
}

resource "aws_efs_mount_target" "efs-mount-target1" {
  file_system_id = aws_efs_file_system.efs.id
  subnet_id      = var.pri_subnet_a
  security_groups = [aws_security_group.efs_sg.id]
}

resource "aws_efs_mount_target" "efs-mount-target2" {
  file_system_id = aws_efs_file_system.efs.id
  subnet_id      = var.pri_subnet_c
  security_groups = [aws_security_group.efs_sg.id]
}

resource "aws_efs_backup_policy" "efs-backup-policy" {
  file_system_id = aws_efs_file_system.efs.id
  backup_policy {
    status = "ENABLED"
  }
}