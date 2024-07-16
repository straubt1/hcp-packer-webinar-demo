resource "random_pet" "random" {}


resource "aws_s3_bucket" "example" {
  bucket = random_pet.random.id

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
output "debug" {
  value = aws_s3_bucket.example.id
}
