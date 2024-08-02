resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}


resource "aws_s3_bucket" "mybucket" {
  bucket = "statefilestore"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.mybucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.mybucket.id
  versioning_configuration {
    status = "Disabled"
  }
}

#DynamoDB Table
resource "aws_dynamodb_table" "statelock" {
  name           = "locktable"
  billing_mode   = "PAY_PER_REQUEST"
   hash_key       = "LockID"

   attribute {
     name = "LockID"
     type = "S"
   }
  }
