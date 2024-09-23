Return-Path: <linux-iio+bounces-9742-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E8997ED65
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2024 16:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937171F2209A
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2024 14:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CCE12C526;
	Mon, 23 Sep 2024 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIDAUuz9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E8777F2F;
	Mon, 23 Sep 2024 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727103211; cv=none; b=q0IRLGa4xh57jAiyNoomysf71d47pTsIArwxW3HvJmmUspP8PznMmnTa99vFzLRsNM4PXNVc8DMSXv/STPSU4y7FkaXojRkSS0s7ix3qdYsTmVBQyIRwZmIp0iZ1YjbMK69VWKpoGLc4dIe+PKpWz4VyKuQ+sAe8lySR+qT5xzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727103211; c=relaxed/simple;
	bh=q/6vWTasDLm0W9z2hsovz3RuFO+UgGAJrDn3blh7EE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q4NtNcSh6fqnBtC6InylaW2IDioKcRTBYmIxuKZJWuavQ0aZwK06aHXpM4obzVUSHhb2zeJGd5tzh9pTCUx8oIKgB6Lkn+i1gjhpbD2DWJ0+bUDFUG2z7ElgAJk8wTEzJtiQ84gL1bTWUrFv4hArLCbxA231RspCu+e6d+4Pni4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIDAUuz9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D229EC4CEC7;
	Mon, 23 Sep 2024 14:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727103210;
	bh=q/6vWTasDLm0W9z2hsovz3RuFO+UgGAJrDn3blh7EE8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VIDAUuz9lXzSxKgM+wqIeYXSLEpLBDlw2y5GiiivR5jr7e8pjyiXn/Ujlfx5nkdsj
	 pcCuX1RXr3V0S0TTl3WIAxtMXi6HtMXDFdPliotU7uPKnPhW0Lj0kKjrLlsoadnK1L
	 nRMlgqsMOIcg27fwvfW0LNOhBlji2ajxkmSfce8KjENGqTTWJqUgXdT5NSH7eRWPC3
	 fWZEEMWnsYP3yUPcx5ZcDnqo47NImQeYKzcI6KVzOHYglawi71CTDCv8LaGnbBH8nZ
	 DcBzwfIaTLL/qBKOWj1tdcBFDZWhCF6dSD9L8E78Y5h0iocU4MclHLJ+uTzl8zHLhh
	 gNZUpw8eFu6LA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E05CF9C74;
	Mon, 23 Sep 2024 14:53:30 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Mon, 23 Sep 2024 16:53:22 +0200
Subject: [PATCH v2 2/2] iio: imu: inv_mpu6050: add support for
 IAM-20680HT/HP
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240923-inv-mpu6050-add-iam20680-ht-hp-v2-2-48290e0b9931@tdk.com>
References: <20240923-inv-mpu6050-add-iam20680-ht-hp-v2-0-48290e0b9931@tdk.com>
In-Reply-To: <20240923-inv-mpu6050-add-iam20680-ht-hp-v2-0-48290e0b9931@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727103209; l=4819;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=/ldj+ehtICzWHkHGTke2yP8V+ZJuIQcCfLCxa5OZgXg=;
 b=OTzZplcLjGZjfqicjharfREu1ibD25Dz1ovfVdAT/MlhsqduSpbnb5d/V+D9KB96DKTJ8xA5O
 ugvQQPeszuuD91dSDs6aamelS+bwSaUFz3ayZrI8H0262EElJ0+66Xa
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

IAM-20680HT & HP are 2 variants of IAM-20680 with better specs,
wider temperature range, and a bigger FIFO (4k).

Fully compatible with IAM-20680, FIFO is 512 bytes by default and
with correct register setting we expand it to full 4k.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 20 ++++++++++++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  | 10 ++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  4 ++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  | 10 ++++++++++
 4 files changed, 44 insertions(+)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 14d95f34e981c8b71dd0892fbeb12735a8857d6c..6b0adb7f9ae301878d9b4d6febec0309bd77a256 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -286,6 +286,24 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
 		.startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
 	},
+	{
+		.whoami = INV_IAM20680HP_WHOAMI_VALUE,
+		.name = "IAM20680HP",
+		.reg = &reg_set_6500,
+		.config = &chip_config_6500,
+		.fifo_size = 4 * 1024,
+		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
+		.startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
+	},
+	{
+		.whoami = INV_IAM20680HT_WHOAMI_VALUE,
+		.name = "IAM20680HT",
+		.reg = &reg_set_6500,
+		.config = &chip_config_6500,
+		.fifo_size = 4 * 1024,
+		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
+		.startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
+	},
 };
 
 static int inv_mpu6050_pwr_mgmt_1_write(struct inv_mpu6050_state *st, bool sleep,
@@ -510,6 +528,8 @@ static int inv_mpu6050_set_accel_lpf_regs(struct inv_mpu6050_state *st,
 		return 0;
 	case INV_ICM20689:
 	case INV_ICM20690:
+	case INV_IAM20680HT:
+	case INV_IAM20680HP:
 		/* set FIFO size to maximum value */
 		val |= INV_ICM20689_BITS_FIFO_SIZE_MAX;
 		break;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index 0e03137fb3d40d4753989522cf5168ef358a1014..7a5926ba6b97d5e5fbdd08e0c90b58afb3f0131a 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -188,6 +188,8 @@ static const struct i2c_device_id inv_mpu_id[] = {
 	{"icm20602", INV_ICM20602},
 	{"icm20690", INV_ICM20690},
 	{"iam20680", INV_IAM20680},
+	{"iam20680hp", INV_IAM20680HP},
+	{"iam20680ht", INV_IAM20680HT},
 	{}
 };
 
@@ -254,6 +256,14 @@ static const struct of_device_id inv_of_match[] = {
 		.compatible = "invensense,iam20680",
 		.data = (void *)INV_IAM20680
 	},
+	{
+		.compatible = "invensense,iam20680hp",
+		.data = (void *)INV_IAM20680HP
+	},
+	{
+		.compatible = "invensense,iam20680ht",
+		.data = (void *)INV_IAM20680HT
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, inv_of_match);
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index e1c0c51468761ab18188a224e44e09f919d81f9a..a6862cf426396cbaf3452bb3451cd58e4f30a4ec 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -85,6 +85,8 @@ enum inv_devices {
 	INV_ICM20602,
 	INV_ICM20690,
 	INV_IAM20680,
+	INV_IAM20680HP,
+	INV_IAM20680HT,
 	INV_NUM_PARTS
 };
 
@@ -424,6 +426,8 @@ struct inv_mpu6050_state {
 #define INV_ICM20602_WHOAMI_VALUE		0x12
 #define INV_ICM20690_WHOAMI_VALUE		0x20
 #define INV_IAM20680_WHOAMI_VALUE		0xA9
+#define INV_IAM20680HP_WHOAMI_VALUE		0xF8
+#define INV_IAM20680HT_WHOAMI_VALUE		0xFA
 
 /* scan element definition for generic MPU6xxx devices */
 enum inv_mpu6050_scan {
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
index 05451ca1580b637a66a30efe82fbd2a2b63e55d5..e6a291fcda958c56e889e58151929a2f602b0426 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -80,6 +80,8 @@ static const struct spi_device_id inv_mpu_id[] = {
 	{"icm20602", INV_ICM20602},
 	{"icm20690", INV_ICM20690},
 	{"iam20680", INV_IAM20680},
+	{"iam20680hp", INV_IAM20680HP},
+	{"iam20680ht", INV_IAM20680HT},
 	{}
 };
 
@@ -142,6 +144,14 @@ static const struct of_device_id inv_of_match[] = {
 		.compatible = "invensense,iam20680",
 		.data = (void *)INV_IAM20680
 	},
+	{
+		.compatible = "invensense,iam20680hp",
+		.data = (void *)INV_IAM20680HP
+	},
+	{
+		.compatible = "invensense,iam20680ht",
+		.data = (void *)INV_IAM20680HT
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, inv_of_match);

-- 
2.34.1



