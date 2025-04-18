Return-Path: <linux-iio+bounces-18275-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B83A93ACD
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 18:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59503BB88F
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 16:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74156214A7D;
	Fri, 18 Apr 2025 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8e7P7sf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEC81C5F2C;
	Fri, 18 Apr 2025 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744993152; cv=none; b=CMRzsAlz36vcs+j8p/M9eodzaDA4kjBOFXU/+z7VckfrAEZAzifFRhQFTEwBhQF6qNnb1/mpUdSTjbdFDsdDj6+4WWEy9Gf5vP7apysiNR363fMpig36DQH4fnCNh/IfUXX1F6Fu7I3pgc3s/lo0drUckLA9OQNeLJKcSFOs6tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744993152; c=relaxed/simple;
	bh=L2H2qwEikwOMKTi1crbWBetmTg4lpjWT87FK3LEBMHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p12ZaggJjUn5UVAZYX3OQdhUyWfjhEBMsaajlcevEJHqdbOlRJ5sVzJG6GhoTQ72EYNxUGOmSd1JkryV/WYvTd3Is3/kPKit44s/lEDZzXxYscer6HSf+u093astk9kpnBs/9sNM2hqpOqsDrKm2hSTCtfdHiLzIdAvBNKRQK90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8e7P7sf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9F0DC4CEED;
	Fri, 18 Apr 2025 16:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744993151;
	bh=L2H2qwEikwOMKTi1crbWBetmTg4lpjWT87FK3LEBMHE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=N8e7P7sfnJQT1A9qpyVmkNlOqpKVXwnBeq5viNTmihhLJ1aybr/vP0iz0Me8BV3oc
	 eIGSiSjNPSF6TfvnkW2q0dOUxGmHE9WjMIaRFMci2FAiT4abKFGWQoqj8YihIiN6SX
	 K8KDF2xaGHdvWRGx7HsMBKbN2wUnioMaH4uHM9Ws0UPUt4Ddal7T0gAvNIXV1s5bj9
	 YxM7op73jKrOeYMmAVJ069jjzJMjXXqA+jP/5fN3IoKJcWytmS4n3akXzY6sqLJa+q
	 DhGeNbGKCX2k73lG0YwMxZUeQKl4Cd+hPh4/BEUyn5jhEkjQA5sBmM8hE/cuglKA+C
	 e60fhJOaV4ZIg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E2CC369D0;
	Fri, 18 Apr 2025 16:19:11 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Fri, 18 Apr 2025 18:19:03 +0200
Subject: [PATCH v3 2/2] iio: imu: inv_icm42600: add wakeup functionality
 for Wake-on-Motion
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-losd-3-inv-icm42600-add-wom-support-v3-2-7a180af02bfe@tdk.com>
References: <20250418-losd-3-inv-icm42600-add-wom-support-v3-0-7a180af02bfe@tdk.com>
In-Reply-To: <20250418-losd-3-inv-icm42600-add-wom-support-v3-0-7a180af02bfe@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744993145; l=5298;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=l+/OriOlddQy/5l7bvQyqKy4EbXw047VAx/9mPsXfSc=;
 b=k5iydP5CdiiQGlCc4VZdZzv78qGOH+5y9JiLpAyCDBzxgV/BggVZEm2FQ2LaG63C2ujSIJUZG
 5Vt51QKWSCJBSW9zbdwqy+3tHCxDoJlKukOvDfeNucRVdQrygRsiGYj
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
index bcf588a048836f909c26908f0677833303a94ef9..dcdacc21f0a7f0bdc305f1fded4ec69bc68f5955 100644
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
index 9c21d0855f95ec0c085d29bb67da934ca1a8d339..a4aeee972cd773e85129fd11568e382f613fd4db 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -1161,6 +1161,9 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
 	if (ret)
 		return ERR_PTR(ret);
 
+	/* accel events are wakeup capable */
+	device_set_wakeup_capable(&indio_dev->dev, true);
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



