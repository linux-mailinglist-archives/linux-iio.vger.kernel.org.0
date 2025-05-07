Return-Path: <linux-iio+bounces-19252-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 838DBAAE996
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 20:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E703A381F
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 18:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548721F4629;
	Wed,  7 May 2025 18:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0J9ZRCN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1EA29A0
	for <linux-iio@vger.kernel.org>; Wed,  7 May 2025 18:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746643579; cv=none; b=aqf5E8DLR+ADG4TIh3oWw5hSOrUhS42o3AFWRNgPtdS4IPSYPvi0eVyIW3Tsn99Me75pn/OKH0aGlTJNBp6LR+U3rqICASNWBssXuAAG2kXdm4UMNV/3PbOXhq+V/2KsdDjUOnBgP4eLFdvOuILsmRSUeSe1DbP884Tz+5F/5JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746643579; c=relaxed/simple;
	bh=1xQXmpnGJeg0xL12vq/guEQFMMeQ6wrEMsHajwAJPIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lmUL4e/UUTl6kqFjpGnmoLZ9qunXZHWWoDVsLvPFERyweVmxjPsgLglfEYnlgj8cb7wdU1S02yOyq3xUYwkF/wzKM7hi/QbcOtV+gzJIUtOw9rj34pbyzcfGGkhzatQI5xgvqtpLIS4mv+Am8cgrxppyaoJRLKN/Pn9WSeKvLWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0J9ZRCN; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7403f3ece96so400653b3a.0
        for <linux-iio@vger.kernel.org>; Wed, 07 May 2025 11:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746643577; x=1747248377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Omkq5PWSLMf+cnddCT9B1IskxgpHcOAM775/K6xvosQ=;
        b=X0J9ZRCN86u5n+A6wn33dtX08gj7f7qWGGm7KGrd2i11ujlBAtIjxQ4+ssy464D6Tx
         Zv+zNsIRCebNL/HcWz9EJnUV/9Fyxno50E086cFCUW91zUPqdTxWh7T3nm09hdlfFjAq
         FvJUQeH4FBqEsCeF4cHVSon6ZyJ5Uces5IJ3zpZkcdjJdcPH7o/ELwIGgx+FV2j1U+8W
         STBPSr0qimbfbnM/my7p1hhN6AWxHT9MePv/nuG5+IxASP7uW8U9J+13JNQmorc1CoXw
         N8+8WwfgXoU1homcu7+YmiobNxU4FpQMk/b6x3QsEpbIylNR3nuGnmdD4+6XGizykM2P
         Rfhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746643577; x=1747248377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Omkq5PWSLMf+cnddCT9B1IskxgpHcOAM775/K6xvosQ=;
        b=LheCBXJZDQ4lWrFLIO0zmTc4FPKgqF/dnSuPW07ATHyw0gYeilBED8wP05zPNJdgSi
         5gWmgwrbOAmjusBbj68TajNtW63z+Nx44E4gjOoMu/77/1Y3SyDDbrgbBSbxGmarj3/M
         4r5FuQiAFY3yA6epygy1AgdA0lwvvhC5czIIVIBw2MKra4onhNYQ/ZYwDHEQY0d4bVgJ
         DGPKpkkz/6t/xu0BaGyAc4TzOVtrw84vAZJ3wmUNpLprr9P8fKpEljZcC0572veHHi1h
         ikLRI4ytcDSKG+16HltbD3KWvP6Q2sBJ+ZheLgo7d7TK0/bihAbYZfe9hHbbu954duXH
         dDlA==
X-Forwarded-Encrypted: i=1; AJvYcCU7lbE5EXwIrf7QRtmVIZGDGh2tEWrl0hfRfJ8nUjM7+J6P0VJuEbT+NEAoWmuXyxoTVFBDGm9xots=@vger.kernel.org
X-Gm-Message-State: AOJu0YysX3HIK/+6k3Og88af2cFAzasKvpnzXTpDyTm5SqJ3pp2glypZ
	5bbIKdPY31NadjgxNLSAdgxqHE5wAQjbwLukC3JI030OGUqIsdQLj39Szqn8kXT9kA==
X-Gm-Gg: ASbGnctr362crw8OV+WJxl3KHsRtvdno/11w3+FwED7ODMx9AZ2jZznspOEl1pBUwgM
	Pf1RbCJCsgl5d6ZVcpvFijxtu9ebZPiv33B0nDYCwdhjZbjQlW4AP958PywJMfHy66OA7+OFDCq
	NlckmfVs2XXoXLbYlr5yQYo2T7/Hyu++HmBDOq90j68vxFuNvWFJxG+AZgH9RN7F0HTVc/IR5fO
	QTjR+52UBmlw/PlDZyMO6IsbgW3/CYmhU1S1y/l8DH5/Z9aIctum6MZQGVVD7zkHkdAfs5BQ7k5
	GAcPTsgs92zpCoMqsxKvKcVfrUCBdR80JEBzQ61JqBj72teznNLesKdPqkMkSmfaANQZ9B5Mm8s
	sjk30TJXnV/rp
X-Google-Smtp-Source: AGHT+IGWI3s0upMGM0JdMBv6zET6F1y5tvIBXLSJmjLRLNIRwMCK+2+7Gh/6GMJ6XIoGaoIK8KjmMQ==
X-Received: by 2002:a05:6a00:450f:b0:73e:23bb:e750 with SMTP id d2e1a72fcca58-7409cfef42amr6411496b3a.23.1746643576615;
        Wed, 07 May 2025 11:46:16 -0700 (PDT)
Received: from isabella-caselli-linux.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058dbb804sm11957509b3a.52.2025.05.07.11.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 11:46:16 -0700 (PDT)
From: Isabella Caselli <bellacaselli20@gmail.com>
To: jean-baptiste.maneyrol@tdk.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org
Cc: rodrigo.michelassi@usp.br,
	Isabella Caselli <bellacaselli20@gmail.com>
Subject: [PATCH v3] iio: imu: inv_mpu6050: refactor aux read/write to use shared xfer logic
Date: Wed,  7 May 2025 15:39:39 -0300
Message-ID: <20250507184539.54658-1-bellacaselli20@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Refactors inv_mpu_aux_read() and inv_mpu_aux_write() to extract the common
I2C transfer sequence into inv_mpu_i2c_master_xfer(), which now handles
starting and stopping the I2C master, waiting for completion, disabling
SLV0, and checking for NACK errors.

This refactoring removes code duplication and improves maintainability.
No functional changes are intended.

Signed-off-by: Isabella Caselli <bellacaselli20@gmail.com>
Co-developed-by: Rodrigo Michelassi <rodrigo.michelassi@usp.br>
Signed-off-by: Rodrigo Michelassi <rodrigo.michelassi@usp.br>
---
Sorry about the diff in v2 capturing the changes proposed in v1.
Just to remember the actual changes made after v1:
As requested after sending v1, we removed the newly created refactoring function — which
would have only been used inside inv_mpu_aux.c — and moved the duplicated code directly
into inv_mpu_i2c_master_xfer(), since the status check was always performed immediately
after its execution in both inv_mpu_aux_read() and inv_mpu_aux_write().
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c | 56 ++++++++---------------
 1 file changed, 20 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c
index 8a7f29119..970cf5c47 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c
@@ -14,6 +14,8 @@
 /*
  * i2c master auxiliary bus transfer function.
  * Requires the i2c operations to be correctly setup before.
+ * Disables SLV0 and checks for NACK status internally.
+ * Assumes that only SLV0 is used for transfers.
  */
 static int inv_mpu_i2c_master_xfer(const struct inv_mpu6050_state *st)
 {
@@ -23,6 +25,7 @@ static int inv_mpu_i2c_master_xfer(const struct inv_mpu6050_state *st)
 	uint8_t d;
 	unsigned int user_ctrl;
 	int ret;
+	unsigned int status;
 
 	/* set sample rate */
 	d = INV_MPU6050_FIFO_RATE_TO_DIVIDER(freq);
@@ -51,12 +54,27 @@ static int inv_mpu_i2c_master_xfer(const struct inv_mpu6050_state *st)
 	if (ret)
 		goto error_restore_rate;
 
+	/* disable i2c slave */
+	ret = regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_CTRL(0), 0);
+	if (ret)
+		goto error_disable_i2c;
+
+	/* check i2c status */
+	ret = regmap_read(st->map, INV_MPU6050_REG_I2C_MST_STATUS, &status);
+	if (ret)
+		return ret;
+
+	if (status & INV_MPU6050_BIT_I2C_SLV0_NACK)
+		return -EIO;
+
 	return 0;
 
 error_stop_i2c:
 	regmap_write(st->map, st->reg->user_ctrl, st->chip_config.user_ctrl);
 error_restore_rate:
 	regmap_write(st->map, st->reg->sample_rate_div, st->chip_config.divider);
+error_disable_i2c:
+	regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_CTRL(0), 0);
 	return ret;
 }
 
@@ -117,7 +135,6 @@ int inv_mpu_aux_init(const struct inv_mpu6050_state *st)
 int inv_mpu_aux_read(const struct inv_mpu6050_state *st, uint8_t addr,
 		     uint8_t reg, uint8_t *val, size_t size)
 {
-	unsigned int status;
 	int ret;
 
 	if (size > 0x0F)
@@ -136,30 +153,14 @@ int inv_mpu_aux_read(const struct inv_mpu6050_state *st, uint8_t addr,
 	if (ret)
 		return ret;
 
-	/* do i2c xfer */
+	/* do i2c xfer, disable i2c slave and check status*/
 	ret = inv_mpu_i2c_master_xfer(st);
-	if (ret)
-		goto error_disable_i2c;
-
-	/* disable i2c slave */
-	ret = regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_CTRL(0), 0);
-	if (ret)
-		goto error_disable_i2c;
-
-	/* check i2c status */
-	ret = regmap_read(st->map, INV_MPU6050_REG_I2C_MST_STATUS, &status);
 	if (ret)
 		return ret;
-	if (status & INV_MPU6050_BIT_I2C_SLV0_NACK)
-		return -EIO;
 
 	/* read data in registers */
 	return regmap_bulk_read(st->map, INV_MPU6050_REG_EXT_SENS_DATA,
 				val, size);
-
-error_disable_i2c:
-	regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_CTRL(0), 0);
-	return ret;
 }
 
 /**
@@ -174,7 +175,6 @@ int inv_mpu_aux_read(const struct inv_mpu6050_state *st, uint8_t addr,
 int inv_mpu_aux_write(const struct inv_mpu6050_state *st, uint8_t addr,
 		      uint8_t reg, uint8_t val)
 {
-	unsigned int status;
 	int ret;
 
 	/* setup i2c SLV0 control: i2c addr, register, value, enable + size */
@@ -192,26 +192,10 @@ int inv_mpu_aux_write(const struct inv_mpu6050_state *st, uint8_t addr,
 	if (ret)
 		return ret;
 
-	/* do i2c xfer */
+	/* do i2c xfer, disable i2c slave and check status*/
 	ret = inv_mpu_i2c_master_xfer(st);
-	if (ret)
-		goto error_disable_i2c;
-
-	/* disable i2c slave */
-	ret = regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_CTRL(0), 0);
-	if (ret)
-		goto error_disable_i2c;
-
-	/* check i2c status */
-	ret = regmap_read(st->map, INV_MPU6050_REG_I2C_MST_STATUS, &status);
 	if (ret)
 		return ret;
-	if (status & INV_MPU6050_BIT_I2C_SLV0_NACK)
-		return -EIO;
 
 	return 0;
-
-error_disable_i2c:
-	regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_CTRL(0), 0);
-	return ret;
 }
-- 
2.43.0


