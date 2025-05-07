Return-Path: <linux-iio+bounces-19250-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5B3AAE8E2
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 20:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1AF63B35A1
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 18:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83FE28D832;
	Wed,  7 May 2025 18:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYS6dwEw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308291A0730
	for <linux-iio@vger.kernel.org>; Wed,  7 May 2025 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746641991; cv=none; b=ruPSRncygyyKCA5dRzdOr/h7/yssW3/FNWsAghDgM8NPhOks8f9Kg/vlTlTXyo0LWAztq99gPm0dSrnH6EwqBJmWHlcuIKJ7VWgT6Nh/bAQHgRBzz/hagMPUa3GpHP2P1diJshupzhZLKZUUXzlmXhqUiMDWDr7RAtpPTTTiFuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746641991; c=relaxed/simple;
	bh=J6cTFA9cmYIrN/6mBT75FJGdpBqDd1zWTMsAheZhIqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eXid5a+4I88wcdNHGkkZJEbVIwKLLAcuCH4TugGeJWYtC/PNVPQw7S4dt30WZTpD5ZqRj6M+fKEhDRz/LA4ig0xmlWcr9nl+yWGh9vS3snCVS7lJ4CTtHVqOMM3GMgjMgRG+QQqg6hFJoE2aRlUuks/lhLLH2us2sSUAbaHvjk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYS6dwEw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22e16234307so3040625ad.0
        for <linux-iio@vger.kernel.org>; Wed, 07 May 2025 11:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746641989; x=1747246789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7iocSPif0goC/A8fzQARUe9UWXyrH9PG1jd7CkVVzGE=;
        b=RYS6dwEw7kFUl5M36oho7XR1SRdYpv3g/It5osJDARxK/owGZ3ihjCRomjppN3Rrd1
         welz1vMH8vo12KyxbFospnpXe9LB6pDb1+woPz8sARHRFK1q0cLBPSl1oflmPHi/tm8i
         UXyieDadMWh22jdcSLg5s6FpIUEmce4cHbjFJwOmx+/C3neKrTVJJZ+WP6lYHuWo7yA7
         lpVVMuZ7cgkVJ9EIs5qcrpYEYXv2sWOfn+hxQZG+v89E4C79c2ngk8Ze0MsP4Wl4d9n+
         65RggrrgPznv4KfwPrgZccDtD5QwIC3q1IZfNVhtzbI8plxxz3jx6WqdmFizWLpnisCW
         kFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746641989; x=1747246789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7iocSPif0goC/A8fzQARUe9UWXyrH9PG1jd7CkVVzGE=;
        b=dlI7aREFyQsRUez7VixBVMDjx+52GmZUYRGjGGbRQUaN9h5WLe3r4yKc5svmog8sKW
         tvk3tG+ZgkRP5Cx314N1qIIwBq1Zc6OODLp9B/W1SQ5PIF46sAuSRFsdB2JShBHzsitE
         +JZohzmdUxwnGvmh1nksJb42bUcWwM51OEMtj8cF/Cfai+CPArZOdgwRbproTQMINEBU
         QDbxGKCbwYBdHYZSbj2B464HUh3NYaiYPnrvzInh4e3hoxCzQ2KhYENnKkvKTkiLjL2+
         bYdeMAPesb8XjY5UiKNi0b4M9BuwW6eeiCy9qiqsaHGK7LbWiTr4Ao/3A/iXifFMdFAg
         QjVA==
X-Forwarded-Encrypted: i=1; AJvYcCVa6FR3KlpLs287su+i06kV0CajwvJJihGibjcL2Eq3uNMo+xNd6grpp0El3o5V73KYNPn7tVDi4Ec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ONHB3FSRtM5JrL3cYtqrod/mfDWsaMzrnHWtLyOzFHzEmyqg
	C0vltzDL42Vqhtq8iP3+4PoGQ/Cqy6oVkrV0y+XWaRyq41k9Fv0Hx0aaAOO/d3taIw==
X-Gm-Gg: ASbGncszXpKgmuB9CEH4k282KK+/00KkFrun4N7JkI7oKBpXOsU3CTvU3Ar2MrF4W3n
	QCx4xuFTtaGHTi1Q9ttFB4EcZeNhKreI0x0kFSMF3C0x0u4EIQDBG7VHzzV/Ylrb4HYMTfej8er
	6ngwgYGNxA/KHF1dXjwo9VKcpiAxP1Jah9OYcAnrEIxrDe+IAMrkK1ZxDKKiHzDCmTH6ux7ZJA4
	Fus3/kPZ+JF1s+tpaTRYEQWSzJ0B1kHHPemBnU3tY9iwKraA+o5gfMLdR82XfPxrrbczOx57x4e
	Lupr5Bh5jHXCk9RvgnCSCrzi3ZvV2KiA18nS/pNhHnVbdek6z/0wdmP2tvhbFNVswbB4EPU8OEY
	11YAtYi0qc2Jt
X-Google-Smtp-Source: AGHT+IHHXOEDPZ+GV0rG2ojIhrTyVzPP/gHnzYFLNqVRnCRbplYM83pUSQMZgfLguUdRUYYv8Q/YNw==
X-Received: by 2002:a17:902:ea0e:b0:22e:491b:20d5 with SMTP id d9443c01a7336-22e847990b8mr6535305ad.26.1746641989255;
        Wed, 07 May 2025 11:19:49 -0700 (PDT)
Received: from isabella-caselli-linux.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e188285f8sm88082485ad.46.2025.05.07.11.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 11:19:48 -0700 (PDT)
From: Isabella Caselli <bellacaselli20@gmail.com>
To: jean-baptiste.maneyrol@tdk.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org
Cc: rodrigo.michelassi@usp.br,
	Isabella Caselli <bellacaselli20@gmail.com>
Subject: [PATCH v2] iio: imu: inv_mpu6050: refactor aux read/write to use shared transfer logic
Date: Wed,  7 May 2025 15:15:14 -0300
Message-ID: <20250507181854.49025-1-bellacaselli20@gmail.com>
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
As requested after sending v1, we removed the newly created refactoring function — which
would have only been used inside inv_mpu_aux.c — and moved the duplicated code directly 
into inv_mpu_i2c_master_xfer(), since the status check was always performed immediately 
after its execution in both inv_mpu_aux_read() and inv_mpu_aux_write().
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c | 57 +++++++++--------------
 1 file changed, 22 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c
index de013e034..970cf5c47 100644
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
 
@@ -135,7 +153,8 @@ int inv_mpu_aux_read(const struct inv_mpu6050_state *st, uint8_t addr,
 	if (ret)
 		return ret;
 
-	ret = inv_mpu_aux_exec_xfer(st);
+	/* do i2c xfer, disable i2c slave and check status*/
+	ret = inv_mpu_i2c_master_xfer(st);
 	if (ret)
 		return ret;
 
@@ -173,42 +192,10 @@ int inv_mpu_aux_write(const struct inv_mpu6050_state *st, uint8_t addr,
 	if (ret)
 		return ret;
 
-	ret = inv_mpu_aux_exec_xfer(st);
-	if (ret)
-	return ret;
-
-	return 0;
-}
-
-/**
- * inv_mpu_aux_exec_xfer() - executes i2c auxiliary transfer and checks status
- * @st: driver internal state.
- *
- *  Returns 0 on success, a negative error code otherwise.
- */
-int inv_mpu_aux_exec_xfer(const struct inv_mpu6050_state *st)
-{
-	int ret;
-	unsigned int status;
-
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
 
-error_disable_i2c:
-	regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_CTRL(0), 0);
-	return ret;
+	return 0;
 }
-- 
2.43.0


