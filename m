Return-Path: <linux-iio+bounces-18779-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7BEA9F248
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 15:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2D6E189ED23
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 13:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0495B26A091;
	Mon, 28 Apr 2025 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqllou+U"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F04F266B4E
	for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 13:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745846767; cv=none; b=cdHf7+3e23Y560e7eFRuXeA+JLBpJ++sbhqrafacOkSbLgInP4JiP4P6mmix5bbwDSc1hQdPpgKIYQcyX5NtDmT4adeDhlRd/O1i6dCLtJFBCnJNu67+u/zR5PoO8vt4eAzTAQHVyF10hH+U3JUz2e+8MsaQMctvnb0deVqHIKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745846767; c=relaxed/simple;
	bh=lAYTyIPR/GD6fdqRLKDuZq42HPEa89XlAjdHAZsGOms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UjA76kQQ1oLfN424cIDfJMdHUU749wRMNwwhm9ZZZ9YW4d3QzcA00Q9CdTo583azTOvhOKvmGlMgA8u767oZZIscsgHaX7yxjL6t26fjjk4ErBbLUvp2x9zsZlolTn/pun1TN0QEC3FxwDhNEkC7NZVPJstEcnxpTy9yZM9qjzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqllou+U; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso6469861b3a.2
        for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 06:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745846765; x=1746451565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=deQvuJtSgm2zMpBEd1F1GpqFNCCMBMLOXG10FnTDnXU=;
        b=dqllou+U1i1bdFD2bfCInNgmZtyzVpKuqnO6DNvMFZNGjnEET0xnlWwm8sz0wzyLge
         W5XB6n7+LRC8RHn5g1QuUJR2lxCPWLBiWAk00g8Is8KfvP0Xbf7feRRWFofoErETwyPi
         c/0TyXbeHNJ6W3kQ8Po8rHGSR5dOoR4/BW0m89dE2Ubu0ugZJ9Waiq95ZKdSHRkyZrTL
         aL/oiDmR7NcTne/hpNbHmn6uLMf0G9cDRGu3BccAY0MvESWDaIka1cA0udb9HQ85QahX
         GaqbZKPpFmC+6B+3JBBOFOzDPFf+rzK0qW9RidOcmrbi5eNS7T6OqwNhC/f6CjyZzoSY
         wlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745846765; x=1746451565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=deQvuJtSgm2zMpBEd1F1GpqFNCCMBMLOXG10FnTDnXU=;
        b=dnWVkPJykBqZMEtfESHsNkyTCmvr3BEyRZiIUBU0t7Ddi+5s/yjM+L0rH+eWtabBX3
         U5Na2fy2FOvvG6J6idCPU3ABF1AQwfa8Rtt2hYYmfwgx/e0mo6xKvvt/xrz9GrxPchWi
         /8mUSTEXYJlcQY/UFlAXq+IWkIMus4YHQ9grX1+zQhYf0UJsTeb6DTF2PQqWES1HiZq5
         1bhVrh2Z7Ym3AHNVruQ5oOrXpKdYdw0tFqXDIO+UWpMeaYUwLH5r2/AmOkL1nIKCHTFI
         qbYhJpHEjqDP5bQ+4lPsNnt9dLAXpgWXrPTNTaEURg7T2/XKdqv7NdflfV0JpkdWDz2t
         C6Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVM1oV99/JKYbSPZ4d4EzidoCVq2qkLNUxUL58tWZPQBTQa9b9iaKM/cRjJGVa+PhbKYVbF9Cldk5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOLNFHACvMAxOvR8Y0LcveYos9zda9YHG2SP9l0jmhWqmMh19P
	aSq3/WJsCdP5paNZnq0vaYecqr1OyiHzBkFJOXxHx8QYLVHqS593
X-Gm-Gg: ASbGnctXLdYgixVzh3eRTEQuG2FUQ41/4UAiISLyDEOTcDjT7AEXFkJUqGbImURsZVe
	u0+aSF1Ic8hpjvKGcViGbH/vpvfyjX7yNlxKAg9rQHE1LdGEWXrTGlYnToDH4TPwxHxKCdXJ0HL
	TsdE4ANc3IIthhea94EqsJ7RqMG2DdBN4rmobij9RAn9+h6CtuUTTxlOs/3N2bxCykRJEaB/KyG
	aOlQdj9g3H9AyiDl1dMMU73wgdYESHZTuwYB6sPdF5EEMslTuIdTuFjez5q24V8U4dC9NRDKILN
	Ikd+q9I5jAaA9Vqd+UN83EMR4acW9GFsZIj/WtbOzmGWax97j/9uptTB04WJb3iXox0me60Y7B8
	L+w==
X-Google-Smtp-Source: AGHT+IGE3Y0a7SvssvOTQMI7aA19mo2S30llJgG9FiPcIjQWZf6V97w3CKnPjEFkWDUv16foJVfHUg==
X-Received: by 2002:a05:6a00:2e22:b0:736:6d4d:ffa6 with SMTP id d2e1a72fcca58-73fd89798f5mr14314843b3a.15.1745846765489;
        Mon, 28 Apr 2025 06:26:05 -0700 (PDT)
Received: from isabella-caselli-linux.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a6a8ebsm8160970b3a.92.2025.04.28.06.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 06:26:05 -0700 (PDT)
From: Isabella Caselli <bellacaselli20@gmail.com>
To: jean-baptiste.maneyrol@tdk.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org
Cc: rodrigo.michelassi@usp.br,
	marcelo.schmitt1@gmail.com,
	Isabella Caselli <bellacaselli20@gmail.com>
Subject: [PATCH] iio: imu: inv_mpu6050: refactor aux read/write to use shared xfer logic
Date: Mon, 28 Apr 2025 10:25:43 -0300
Message-ID: <20250428132551.176788-1-bellacaselli20@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract common transfer logic from inv_mpu_aux_read() and
inv_mpu_aux_write() into a new helper function,
inv_mpu_aux_exec_xfer(), which performs the I2C transfer.

This refactoring removes code duplication and improves maintainability.
No functional changes are intended.

Signed-off-by: Isabella Caselli <bellacaselli20@gmail.com>
Co-developed-by: Rodrigo Michelassi <rodrigo.michelassi@usp.br>
Signed-off-by: Rodrigo Michelassi <rodrigo.michelassi@usp.br>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c | 41 +++++++++++------------
 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h |  2 ++
 2 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c
index 8a7f29119..de013e034 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c
@@ -117,7 +117,6 @@ int inv_mpu_aux_init(const struct inv_mpu6050_state *st)
 int inv_mpu_aux_read(const struct inv_mpu6050_state *st, uint8_t addr,
 		     uint8_t reg, uint8_t *val, size_t size)
 {
-	unsigned int status;
 	int ret;
 
 	if (size > 0x0F)
@@ -136,30 +135,13 @@ int inv_mpu_aux_read(const struct inv_mpu6050_state *st, uint8_t addr,
 	if (ret)
 		return ret;
 
-	/* do i2c xfer */
-	ret = inv_mpu_i2c_master_xfer(st);
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
+	ret = inv_mpu_aux_exec_xfer(st);
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
@@ -174,7 +156,6 @@ int inv_mpu_aux_read(const struct inv_mpu6050_state *st, uint8_t addr,
 int inv_mpu_aux_write(const struct inv_mpu6050_state *st, uint8_t addr,
 		      uint8_t reg, uint8_t val)
 {
-	unsigned int status;
 	int ret;
 
 	/* setup i2c SLV0 control: i2c addr, register, value, enable + size */
@@ -192,6 +173,24 @@ int inv_mpu_aux_write(const struct inv_mpu6050_state *st, uint8_t addr,
 	if (ret)
 		return ret;
 
+	ret = inv_mpu_aux_exec_xfer(st);
+	if (ret)
+	return ret;
+
+	return 0;
+}
+
+/**
+ * inv_mpu_aux_exec_xfer() - executes i2c auxiliary transfer and checks status
+ * @st: driver internal state.
+ *
+ *  Returns 0 on success, a negative error code otherwise.
+ */
+int inv_mpu_aux_exec_xfer(const struct inv_mpu6050_state *st)
+{
+	int ret;
+	unsigned int status;
+
 	/* do i2c xfer */
 	ret = inv_mpu_i2c_master_xfer(st);
 	if (ret)
@@ -209,8 +208,6 @@ int inv_mpu_aux_write(const struct inv_mpu6050_state *st, uint8_t addr,
 	if (status & INV_MPU6050_BIT_I2C_SLV0_NACK)
 		return -EIO;
 
-	return 0;
-
 error_disable_i2c:
 	regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_CTRL(0), 0);
 	return ret;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h
index b66997545..0353103aa 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h
@@ -16,4 +16,6 @@ int inv_mpu_aux_read(const struct inv_mpu6050_state *st, uint8_t addr,
 int inv_mpu_aux_write(const struct inv_mpu6050_state *st, uint8_t addr,
 		      uint8_t reg, uint8_t val);
 
+int inv_mpu_aux_exec_xfer(const struct inv_mpu6050_state *st);
+
 #endif		/* INV_MPU_AUX_H_ */
-- 
2.43.0


