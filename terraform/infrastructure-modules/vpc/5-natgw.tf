resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gw" {
  subnet_id     = aws_subnet.public_subnet[0].id
  allocation_id = aws_eip.nat_eip.id

  tags = {
    Name = "${var.project}-${var.environment}-nat-gateway"
  }

  depends_on = [aws_internet_gateway.gw]
}