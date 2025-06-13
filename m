Return-Path: <linux-iio+bounces-20577-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E38DAD8414
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 09:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A2F87A90FD
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 07:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033F62C3774;
	Fri, 13 Jun 2025 07:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhZi7imR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD6E1EA7E1;
	Fri, 13 Jun 2025 07:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800072; cv=none; b=p+3Q/8fNGO0Pcuy1rdSr4AYdob0iQs1pvXm7aTMtT7gsKZPqvbu0O/14aNA3rWEAAhcFIXkNUMzusCuWQf9mLXUtqF5n2mYLHRMVm2LJZrwW7Hsr04yJqDRb43A3nAfK7V+un6x3eIo4uZCCa8PzzLyAOj+yWWuUVw97CahwJhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800072; c=relaxed/simple;
	bh=T8pIxKQmOw7lVpBaKtcVaZ2RyDzlv50gApXra5EGrds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H+L7g0Uqzu9WYvPAPQBYXj3pms2jsF1ZGwFwBVHGHzgixGSmsfFRvMkVQ4423aphJS6lOMYJxCRnPGRlvfPRKiCwz0+qocPqFp22phDzn8EtFVYXbEqs+nOC7KlCcxGV3dPHenuptbN6oKmdXeePJ75XBSIlaKJ1NDB6bfrzsdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhZi7imR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C114C4CEF1;
	Fri, 13 Jun 2025 07:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749800072;
	bh=T8pIxKQmOw7lVpBaKtcVaZ2RyDzlv50gApXra5EGrds=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YhZi7imReP6DsVavfNzcXVzimklVTWt3Z3Z/iFvNEfpjicqL5qQWzVLTQp9mryH8j
	 d12APyLhUv5Ol6+x1mm9DszwJSH8HKAK2yHqjeaZ4njTr5bbEsktUQGhyj3UGGeWh7
	 2H9u9i0swYaynKY+sD8KfxchMZK9x4fTRVuL9m3eNXmFJQovsEgN6wc9p7yRuQtiQt
	 SL3iGVv0uDAkTA2X2yYDVWIUkIJZAV+31t8pRvHd3JWxyjq7QmkSUbewZBUsvUwXtC
	 ar7vbMVe2RCc2+aWI61A+vvq3lgVsEK9OaRYPZTtPqUKLmP/vJmrgzG39Ot9SbL10Z
	 OQZsNl+iIeeFw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AA2C71135;
	Fri, 13 Jun 2025 07:34:32 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Fri, 13 Jun 2025 09:34:27 +0200
Subject: [PATCH v4 2/2] iio: imu: inv_icm42600: add wakeup functionality
 for Wake-on-Motion
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-losd-3-inv-icm42600-add-wom-support-v4-2-7e5f554201bf@tdk.com>
References: <20250613-losd-3-inv-icm42600-add-wom-support-v4-0-7e5f554201bf@tdk.com>
In-Reply-To: <20250613-losd-3-inv-icm42600-add-wom-support-v4-0-7e5f554201bf@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749800071; l=5290;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=KDCTv7gpEv39CHX+r2t6f3t7cUBXM4lGf6ce0mTmS5s=;
 b=R95RMBpi7F8u7Ndrqsm2evDBTuHKFYPyd6cQKR7GCzDK8vNe+M67j7xxE6Jmp722V/UCjFhYj
 eMy52BA3rDaCQPEgnQCsaQ2zum9ZVUYakH7CO1AZZivKiVODhS8P1Ti
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

When Wake-on-Motion is on, enable system wakeup and keep the chip on
for waking up the system with an interrupt.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h       |  2 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c |  3 ++
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c  | 53 +++++++++++++++++------
 3 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 413a15493bcb880dc00b20da3b3168d5addd32a9..67f5c1a611988776d0bdf4d43a46f2fda43e3e44 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -151,6 +151,7 @@ struct inv_icm42600_apex {
  *  @map:		regmap pointer.
  *  @vdd_supply:	VDD voltage regulator for the chip.
  *  @vddio_supply:	I/O voltage regulator for the chip.
+ *  @irq:		chip irq, required to enable/disable and set wakeup
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
index 9a2089527a9426b70eb796d4e9c234d8804c508b..ddc04fdf1d4ed3afaa8c0c9385ed9739cec39a4b 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -1171,6 +1171,9 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
 	if (ret)
 		return ERR_PTR(ret);
 
+	/* accel events are wakeup capable */
+	devm_device_init_wakeup(&indio_dev->dev);
+
 	return indio_dev;
 }
 
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 9a2150ab9e874f17d7fda731cb131c3f688a75a3..0809561b8119d1ff5cf4b36ff571f9c8dc4050a0 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -765,6 +765,7 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip,
 	mutex_init(&st->lock);
 	st->chip = chip;
 	st->map = regmap;
+	st->irq = irq;
 
 	ret = iio_read_mount_matrix(dev, &st->orientation);
 	if (ret) {
@@ -843,6 +844,9 @@ EXPORT_SYMBOL_NS_GPL(inv_icm42600_core_probe, "IIO_ICM42600");
 static int inv_icm42600_suspend(struct device *dev)
 {
 	struct inv_icm42600_state *st = dev_get_drvdata(dev);
+	struct device *accel_dev;
+	bool wakeup;
+	int accel_conf;
 	int ret;
 
 	mutex_lock(&st->lock);
@@ -863,20 +867,32 @@ static int inv_icm42600_suspend(struct device *dev)
 			goto out_unlock;
 	}
 
-	/* disable APEX features */
-	if (st->apex.wom.enable) {
-		ret = inv_icm42600_disable_wom(st);
-		if (ret)
-			goto out_unlock;
+	/* keep chip on and wake-up capable if APEX and wakeup on */
+	accel_dev = &st->indio_accel->dev;
+	wakeup = st->apex.on && device_may_wakeup(accel_dev);
+	if (wakeup) {
+		/* keep accel on and setup irq for wakeup */
+		accel_conf = st->conf.accel.mode;
+		enable_irq_wake(st->irq);
+		disable_irq(st->irq);
+	} else {
+		/* disable APEX features and accel if wakeup disabled */
+		if (st->apex.wom.enable) {
+			ret = inv_icm42600_disable_wom(st);
+			if (ret)
+				goto out_unlock;
+		}
+		accel_conf = INV_ICM42600_SENSOR_MODE_OFF;
 	}
 
 	ret = inv_icm42600_set_pwr_mgmt0(st, INV_ICM42600_SENSOR_MODE_OFF,
-					 INV_ICM42600_SENSOR_MODE_OFF, false,
-					 NULL);
+					 accel_conf, false, NULL);
 	if (ret)
 		goto out_unlock;
 
-	regulator_disable(st->vddio_supply);
+	/* disable vddio regulator if chip is sleeping */
+	if (!wakeup)
+		regulator_disable(st->vddio_supply);
 
 out_unlock:
 	mutex_unlock(&st->lock);
@@ -892,13 +908,24 @@ static int inv_icm42600_resume(struct device *dev)
 	struct inv_icm42600_state *st = dev_get_drvdata(dev);
 	struct inv_icm42600_sensor_state *gyro_st = iio_priv(st->indio_gyro);
 	struct inv_icm42600_sensor_state *accel_st = iio_priv(st->indio_accel);
+	struct device *accel_dev;
+	bool wakeup;
 	int ret;
 
 	mutex_lock(&st->lock);
 
-	ret = inv_icm42600_enable_regulator_vddio(st);
-	if (ret)
-		goto out_unlock;
+	/* check wakeup capability */
+	accel_dev = &st->indio_accel->dev;
+	wakeup = st->apex.on && device_may_wakeup(accel_dev);
+	/* restore irq state or vddio if cut off */
+	if (wakeup) {
+		enable_irq(st->irq);
+		disable_irq_wake(st->irq);
+	} else {
+		ret = inv_icm42600_enable_regulator_vddio(st);
+		if (ret)
+			goto out_unlock;
+	}
 
 	pm_runtime_disable(dev);
 	pm_runtime_set_active(dev);
@@ -911,8 +938,8 @@ static int inv_icm42600_resume(struct device *dev)
 	if (ret)
 		goto out_unlock;
 
-	/* restore APEX features */
-	if (st->apex.wom.enable) {
+	/* restore APEX features if disabled */
+	if (!wakeup && st->apex.wom.enable) {
 		ret = inv_icm42600_enable_wom(st);
 		if (ret)
 			goto out_unlock;

-- 
2.49.0



