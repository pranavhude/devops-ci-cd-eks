output "public_ip" {
  description = "Public IP address of the Jenkins EC2 instance"
  value       = aws_instance.this.public_ip
}
