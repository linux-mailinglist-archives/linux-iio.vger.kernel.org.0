Return-Path: <linux-iio+bounces-15896-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE383A3E61B
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 21:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FE193BD256
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 20:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2534D2641D4;
	Thu, 20 Feb 2025 20:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWAIn9Wj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA091EA7C1;
	Thu, 20 Feb 2025 20:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740084733; cv=none; b=YdHL+F5BsJxYV8eKiwTdDxCHSuatDnDciBobUV8xwOYXnnQrzPb+GLR5xStIxmZO65hpkTFk6IJ9uGFQG0rNH3mEq1vOPQSfXfXSc8EcMT2a3CK6bhsLN6MNGPl4wZjYc7q+KyxzPRvnMCS4Qu5lI9dy/a44hlP0t48DSsyvC4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740084733; c=relaxed/simple;
	bh=k+515vh40KJXvXhm0qOCfbc8Q1g8Mv1d3EsNcsoWfDY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M2CBPZe18euWNTYmPCrNYCOCKjRBPv0LIK+bBkR8E/qcaL5Sf1uGT7PmgwokB+KmbKFaFIepftmBSY9sWDTEiekyJEu/X2ueqKdL1pkkyuRiw6/hf9o5D73WYjk2tUD1c4glXMOSH8I2COLSYtsX8/6pJOYcoaDNI0+HYTJ0Hk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWAIn9Wj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4384FC4CEE6;
	Thu, 20 Feb 2025 20:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740084733;
	bh=k+515vh40KJXvXhm0qOCfbc8Q1g8Mv1d3EsNcsoWfDY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oWAIn9WjrzvoKt/RBuI5aFqc6j7gzgGkdez4A23dF4lQAnUCw4C0DO8Zbdz/8iYRf
	 MZ3HJZZG3tKO1wi44VEs2XEGzEcEi5t5pbTO+E19E9QliF4/J+ObbGFVyimPyjyMLY
	 SdzatZsozCJWwwHqpAOwJnXpdF/zTNkah157ZoDkXRI1RIXifdNT7WVzIKxkWRZ2DA
	 xENe/j6V6JRXd06Db5RBksKIDflj57AopNiCiVsV6GhC3Y096lHhsVksVphDhE74vg
	 CAnTDblJozXlEIECsfVQMTeY9mZqZFAT/UL7g3dJuFzmRMyi0ZEU1GbujE9yty6hAL
	 U/tBdsw36+gAw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6E1C021B5;
	Thu, 20 Feb 2025 20:52:13 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Thu, 20 Feb 2025 21:52:07 +0100
Subject: [PATCH 2/2] iio: imu: inv_icm42600: add wakeup functionality for
 Wake-on-Motion
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-losd-3-inv-icm42600-add-wom-support-v1-2-9b937f986954@tdk.com>
References: <20250220-losd-3-inv-icm42600-add-wom-support-v1-0-9b937f986954@tdk.com>
In-Reply-To: <20250220-losd-3-inv-icm42600-add-wom-support-v1-0-9b937f986954@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740084731; l=6425;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=8Io0EZ7K8Wv02WRA2dEENs6nrBC8x2QlcG1u9PLvBfA=;
 b=opslEaIOiZYxTBdkrE9ZX8xumphDLqQK/S5q28KGiWwSiCKOmeyNFh7mrLX5WvGz6cMIxwtm9
 vqfww5O9bRzAA/0W3J1wG0/J/H+Ry5kTWK0IccG78C7Zi+0hpVtfNyQ
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

When Wake-on-Motion is on, enable system wakeup and keep chip on for
waking up system with interrupt.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h       |  2 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c |  3 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c  | 89 +++++++++++++++--------
 3 files changed, 63 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 8dfbeaf1c768d7d25cb58ecf9804446f3cbbd465..baf1dcd714800e84ccd21dc1d1e486849c77a9ae 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -151,6 +151,7 @@ struct inv_icm42600_apex {
  *  @map:		regmap pointer.
  *  @vdd_supply:	VDD voltage regulator for the chip.
  *  @vddio_supply:	I/O voltage regulator for the chip.
+ *  @irq:		chip irq.
  *  @orientation:	sensor chip orientation relative to main hardware.
  *  @conf:		chip sensors configurations.
  *  @suspended:		suspended sensors configuration.
@@ -168,6 +169,7 @@ struct inv_icm42600_state {
 	struct regmap *map;
 	struct regulator *vdd_supply;
 	struct regulator *vddio_supply;
+	int irq;
 	struct iio_mount_matrix orientation;
 	struct inv_icm42600_conf conf;
 	struct inv_icm42600_suspended suspended;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 8ce2276b3edc61cc1ea26810198dd0057054ec48..4240e8c576f4d07af5434e9a91dfda532f87ffb9 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -1149,6 +1149,9 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
 	if (ret)
 		return ERR_PTR(ret);
 
+	/* accel events are wakeup capable */
+	device_set_wakeup_capable(&indio_dev->dev, true);
+
 	return indio_dev;
 }
 
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index c0fd2770d66f02d1965fa07f819fd2db9a1d6bd2..f94bda5dc094d6cc85e3facbd480b830bfbaa3f9 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -751,6 +751,7 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
 	mutex_init(&st->lock);
 	st->chip = chip;
 	st->map = regmap;
+	st->irq = irq;
 
 	ret = iio_read_mount_matrix(dev, &st->orientation);
 	if (ret) {
@@ -829,44 +830,56 @@ EXPORT_SYMBOL_NS_GPL(inv_icm42600_core_probe, "IIO_ICM42600");
 static int inv_icm42600_suspend(struct device *dev)
 {
 	struct inv_icm42600_state *st = dev_get_drvdata(dev);
+	struct device *accel_dev;
+	bool wakeup;
+	int accel_conf;
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	st->suspended.gyro = st->conf.gyro.mode;
 	st->suspended.accel = st->conf.accel.mode;
 	st->suspended.temp = st->conf.temp_en;
-	if (pm_runtime_suspended(dev)) {
-		ret = 0;
-		goto out_unlock;
-	}
+	if (pm_runtime_suspended(dev))
+		return 0;
 
 	/* disable FIFO data streaming */
 	if (st->fifo.on) {
 		ret = regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,
 				   INV_ICM42600_FIFO_CONFIG_BYPASS);
 		if (ret)
-			goto out_unlock;
+			return ret;
 	}
 
-	/* disable APEX features */
-	if (st->apex.wom.enable) {
-		ret = inv_icm42600_set_wom(st, false);
-		if (ret)
-			goto out_unlock;
+	/* keep chip on and wake-up capable if APEX and wakeup on */
+	accel_dev = &st->indio_accel->dev;
+	wakeup = (st->apex.on && device_may_wakeup(accel_dev)) ? true : false;
+
+	if (!wakeup) {
+		/* disable APEX features and accel if wakeup disabled */
+		if (st->apex.wom.enable) {
+			ret = inv_icm42600_set_wom(st, false);
+			if (ret)
+				return ret;
+		}
+		accel_conf = INV_ICM42600_SENSOR_MODE_OFF;
+	} else {
+		/* keep accel on and setup irq for wakeup */
+		accel_conf = st->conf.accel.mode;
+		enable_irq_wake(st->irq);
+		disable_irq(st->irq);
 	}
 
 	ret = inv_icm42600_set_pwr_mgmt0(st, INV_ICM42600_SENSOR_MODE_OFF,
-					 INV_ICM42600_SENSOR_MODE_OFF, false,
-					 NULL);
+					 accel_conf, false, NULL);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
-	regulator_disable(st->vddio_supply);
+	/* disable vddio regulator if chip is sleeping */
+	if (!wakeup)
+		regulator_disable(st->vddio_supply);
 
-out_unlock:
-	mutex_unlock(&st->lock);
-	return ret;
+	return 0;
 }
 
 /*
@@ -878,13 +891,25 @@ static int inv_icm42600_resume(struct device *dev)
 	struct inv_icm42600_state *st = dev_get_drvdata(dev);
 	struct inv_icm42600_sensor_state *gyro_st = iio_priv(st->indio_gyro);
 	struct inv_icm42600_sensor_state *accel_st = iio_priv(st->indio_accel);
+	struct device *accel_dev;
+	bool wakeup;
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
-	ret = inv_icm42600_enable_regulator_vddio(st);
-	if (ret)
-		goto out_unlock;
+	/* check wakeup capability */
+	accel_dev = &st->indio_accel->dev;
+	wakeup = (st->apex.on && device_may_wakeup(accel_dev)) ? true : false;
+
+	/* restore vddio if cut off or irq state */
+	if (!wakeup) {
+		ret = inv_icm42600_enable_regulator_vddio(st);
+		if (ret)
+			return ret;
+	} else {
+		enable_irq(st->irq);
+		disable_irq_wake(st->irq);
+	}
 
 	pm_runtime_disable(dev);
 	pm_runtime_set_active(dev);
@@ -895,13 +920,15 @@ static int inv_icm42600_resume(struct device *dev)
 					 st->suspended.accel,
 					 st->suspended.temp, NULL);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
-	/* restore APEX features */
-	if (st->apex.wom.enable) {
-		ret = inv_icm42600_set_wom(st, true);
-		if (ret)
-			goto out_unlock;
+	/* restore APEX features if disabled */
+	if (!wakeup) {
+		if (st->apex.wom.enable) {
+			ret = inv_icm42600_set_wom(st, true);
+			if (ret)
+				return ret;
+		}
 	}
 
 	/* restore FIFO data streaming */
@@ -910,11 +937,11 @@ static int inv_icm42600_resume(struct device *dev)
 		inv_sensors_timestamp_reset(&accel_st->ts);
 		ret = regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,
 				   INV_ICM42600_FIFO_CONFIG_STREAM);
+		if (ret)
+			return ret;
 	}
 
-out_unlock:
-	mutex_unlock(&st->lock);
-	return ret;
+	return 0;
 }
 
 /* Runtime suspend will turn off sensors that are enabled by iio devices. */

-- 
2.48.1



