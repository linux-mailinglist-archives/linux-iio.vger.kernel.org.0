Return-Path: <linux-iio+bounces-9081-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2132696A474
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 18:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54B441C236E7
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 16:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554D918BC12;
	Tue,  3 Sep 2024 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1lUIJA+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B627718890E;
	Tue,  3 Sep 2024 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725381190; cv=none; b=ev4P2kWRLWrzuI1aOcw9OV6B4bcsuxZlYZwaUp0H87sXeP0MdqYeFdT5dKfgQGyZH8FLQw4HO6HVIUSG2awr3U5eIdIXRbuYSlvljZbpjKEvSzl6n8QCVV2lXSGpF8MVVpf28+Abv4h7F3pYva2LTj0ekBnwkQOl9tYTxtpBiDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725381190; c=relaxed/simple;
	bh=pIhX0IT6r5JcRPOzYVkoe01H/JdmjmsvWHGLTn6H6eo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FqCTF47mn16DdiquvXrjOtJpm7hfms6lsEkLYg9dvd37EJzM5gPD/KUJ5n3g3UtSzobnDbJNjbewXgVsrMJycmBZwk51CA03HlTdOjscxxFH+uD80FKssmX4cv8Hqf/H8zWvk+OZMt5Dfh9isoje+mnKj5A7vfErmHZG0/IhIGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1lUIJA+; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7cd9cfe4748so3530261a12.2;
        Tue, 03 Sep 2024 09:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725381188; x=1725985988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FvpKNdlfemMmZ8Art8R6B2GS4pQO0vGI3Mh0V4MGsMs=;
        b=A1lUIJA+qQ9b2yIBhjZIN/Mq2E+pJKeMLTTYhvXLkWcvkZ5ccNGtFlUBsLzQinzApR
         VlvzQ6c7Rvuu/uXZgmu8NTxKLDVs0+GyEdbQrmhaXNg4qexSXN4AbHl61XRq9Um935VQ
         F4EuLAnJpasbyGrleX6LjDsX0QMkd8vyHjwYIEyDYxTJKWujGyBL39pu4O6NyguXxfQo
         bS19hcP3XLJU2fH/aFUXOysZ7+PBG4lw9bttmYzyOSlO4SmRL1HuUfaoX/lWxq+SSZsr
         t16k3D4bA/lv/7X1qaBIVC5VRlzKDx0Gw8zl4LwiV9qPcURn4ZcYKJHJu6C/Mr6hN22T
         OdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725381188; x=1725985988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FvpKNdlfemMmZ8Art8R6B2GS4pQO0vGI3Mh0V4MGsMs=;
        b=uKi/cr6Hd3U3LKmiNgw+idaF8Kh+PXs3+RHGtC2QXHY+x8Q58FLUBRSIqsElno6fSD
         K9M86AtHDzuY317pre7mLIJ9l4Eowb+IfE6o8OytEi11MBYrBHe5F5Xe7SHFysmtPvXQ
         KAObtTQroX/wD/B37kRa/QJiw2h8q/2EPnNRpnDMMS184o8dzjZc5ixVZysePGeKoXOf
         efIiNRhG8CG44soQGsivyRDCw/tB8Q3Ai2r2wzavk0fpIUw+dX6pE2y+AP24uedm+BFf
         2vBSXxNyKCvzMbp6W9ogK5+s6w34dcfx4ULgbcpLTvJrB9cDlXt3B8cddcKBU4eDuRkf
         1C1w==
X-Forwarded-Encrypted: i=1; AJvYcCXWUKnFtz/kF1DR94S7gpXA0YoOXp0suHMCmOSnXeVAUtF+uUpqBWnbWjpdqsDFa+DWUYxxMlNTMQnuSOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxpNsvWDl0hFqn1ASx378TRIXaMp93boo7Z9TC7nr4dqffl+se
	nfzdrE4yBXr7EC6ZBJ0Z7/XOn7gJFIP5g/8JTSHVMlYuejnKcy0mwrrgO/43y3w=
X-Google-Smtp-Source: AGHT+IExLiq2Ze2vPQRrln/6fnhDwsqeig5MNW2DTjAYB2kP2HiUDUQ6tGfYIszBtQDPkCNihNgJcA==
X-Received: by 2002:a17:90b:1906:b0:2c9:61ad:dcd9 with SMTP id 98e67ed59e1d1-2da55a43fd6mr3850899a91.27.1725381187997;
        Tue, 03 Sep 2024 09:33:07 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8ebca0055sm4062458a91.42.2024.09.03.09.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 09:33:07 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gyeyoung Baek <gye976@gmail.com>
Subject: [PATCH] iio: imu: inv_mpu6050: Move setting 'wom_bits' to probe function
Date: Wed,  4 Sep 2024 01:33:02 +0900
Message-Id: <20240903163302.105268-1-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'wom_bits' variable is defined by chip type, 
and chip type is statically defined by device tree.
so 'wom_bits' need to be set once during probe function.

but before code set it every time using 'switch statement' during
threaded irq handler, so i move that to probe function.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 16 +++++++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  1 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 20 ++-----------------
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 14d95f34e981..322ae664adc0 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -2076,6 +2076,22 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		return result;
 	}
 
+	switch (chip_type) {
+	case INV_MPU6050:
+	case INV_MPU6500:
+	case INV_MPU6515:
+	case INV_MPU6880:
+	case INV_MPU6000:
+	case INV_MPU9150:
+	case INV_MPU9250:
+	case INV_MPU9255:
+		st->wom_bits = INV_MPU6500_BIT_WOM_INT;
+		break;
+	default:
+		st->wom_bits = INV_ICM20608_BIT_WOM_INT;
+		break;
+	}
+
 	return 0;
 
 error_power_off:
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index e1c0c5146876..a91b9c2b26e4 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -212,6 +212,7 @@ struct inv_mpu6050_state {
 	bool level_shifter;
 	u8 *data;
 	s64 it_timestamp;
+	unsigned int wom_bits;
 };
 
 /*register and associated bit definition*/
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index 84273660ca2e..b19556df1801 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -243,26 +243,10 @@ static irqreturn_t inv_mpu6050_interrupt_handle(int irq, void *p)
 {
 	struct iio_dev *indio_dev = p;
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
-	unsigned int int_status, wom_bits;
+	unsigned int int_status;
 	u64 ev_code;
 	int result;
 
-	switch (st->chip_type) {
-	case INV_MPU6050:
-	case INV_MPU6500:
-	case INV_MPU6515:
-	case INV_MPU6880:
-	case INV_MPU6000:
-	case INV_MPU9150:
-	case INV_MPU9250:
-	case INV_MPU9255:
-		wom_bits = INV_MPU6500_BIT_WOM_INT;
-		break;
-	default:
-		wom_bits = INV_ICM20608_BIT_WOM_INT;
-		break;
-	}
-
 	scoped_guard(mutex, &st->lock) {
 		/* ack interrupt and check status */
 		result = regmap_read(st->map, st->reg->int_status, &int_status);
@@ -272,7 +256,7 @@ static irqreturn_t inv_mpu6050_interrupt_handle(int irq, void *p)
 		}
 
 		/* handle WoM event */
-		if (st->chip_config.wom_en && (int_status & wom_bits)) {
+		if (st->chip_config.wom_en && (int_status & st->wom_bits)) {
 			ev_code = IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X_OR_Y_OR_Z,
 						     IIO_EV_TYPE_ROC, IIO_EV_DIR_RISING);
 			iio_push_event(indio_dev, ev_code, st->it_timestamp);
-- 
2.34.1


