Return-Path: <linux-iio+bounces-21169-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49197AEE7BA
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 21:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D98217F44F
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 19:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F4E2E6130;
	Mon, 30 Jun 2025 19:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CT0XWJUc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE2328D8C1;
	Mon, 30 Jun 2025 19:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751312853; cv=none; b=nTwnGtbXh8WJBXUz+JQAXo0bF+pX5BVqb1UKFKZZMw7+2uvRLAJnbGdwdUPSH2IJ1SxlmF3bibxnF9kblVznSAcfZZ3cRYJA3WUSOOVAwUVxMsr2R9XEcWRcw3kmMdNEd2V8w1j0dl6fdegS7zvQURX57rL0LURvKtDItyOWch8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751312853; c=relaxed/simple;
	bh=yQzwGTfoQW42Q3ttrqDuIZAauSAP0gUZF8vh0ehDdrU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ow8Xv3u4g84SkOHY1jdhltg4GSkwUvZX2TuJciPqrhwDTC1dPqZQDmEPekmr7kq0UWG069EJHhE4pICBjKzq8Fu4sZOxDCy1eFjiuLf/aDMd7j0wU4SH02shGZddNCvf6YUa0JH03+MpbpU9jX23dk+R1ujZbtz3FcOlUBykqw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CT0XWJUc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5539EC4AF0B;
	Mon, 30 Jun 2025 19:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751312853;
	bh=yQzwGTfoQW42Q3ttrqDuIZAauSAP0gUZF8vh0ehDdrU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CT0XWJUcprPtjCM0zeKtPozAMhp2P/MnDiu7L4pL5468Yhg69abajiDd/mNVRQMkX
	 xW7XjtfKGUmjAe0kNNOzMGOUh7M4fGS2ElLIhDPLCnO7Ekabw4W6fNtWniZWJWihjL
	 epvXtJSP0bNlhRhYaxW83ACJhvGWFAECMA/zTzs8ymbBBWsb4OyTz2lK1HqEC0uCAA
	 7z5LylM+6WhpCati1MoJKQcxy8QejBgexw/p27uPvR7zcVe7Om4C8mIUQTDpUzk3Hz
	 p2Lq4OnOddcclh6Me7djhVry38CirGliMSvZ6OyzotonBDnNlEVpAWdkCZb4WKK7Ke
	 BVJyQnnTMjkPg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46838C8303B;
	Mon, 30 Jun 2025 19:47:33 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Mon, 30 Jun 2025 21:47:31 +0200
Subject: [PATCH v6 3/3] iio: imu: inv_icm42600: add wakeup functionality
 for Wake-on-Motion
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-losd-3-inv-icm42600-add-wom-support-v6-3-5bb0c84800d9@tdk.com>
References: <20250630-losd-3-inv-icm42600-add-wom-support-v6-0-5bb0c84800d9@tdk.com>
In-Reply-To: <20250630-losd-3-inv-icm42600-add-wom-support-v6-0-5bb0c84800d9@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751312852; l=5335;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=SaLakCKt+NqOOSEferE17zBIRIXDHhlZGgHzBhvkUV8=;
 b=zZ7hA/4X8TCUv3Nk5Y4+xNr75IgVEOxgL9UBuG3UrY7x/gRXJt2T4hGi9DyNvOdoTkRUgYg/A
 mUPlqtPCK6cBzGSHdqcsZKR4J4z5fo+US5M2mpJdiK5x4BXzkhf3rgn
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
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c |  5 +++
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c  | 53 +++++++++++++++++------
 3 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 6af96df9f0ed195a211c40ca0075678f80b9424f..1430ab4f1dea5d5ba6277d74275fc44a6cd30eb8 100644
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
index c52d77cab040dcfb11bc1f9430a3b1dfd52660a9..7a28051330b79098bfa94b8c8c78c2bce20b7230 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -1206,6 +1206,11 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
 	if (ret)
 		return ERR_PTR(ret);
 
+	/* accel events are wakeup capable */
+	ret = devm_device_init_wakeup(&indio_dev->dev);
+	if (ret)
+		return ERR_PTR(ret);
+
 	return indio_dev;
 }
 
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 283483ed82ff42b4f9b80d99084c118786054c37..a4d42e7e21807f7954def431e9cf03dffaa5bd5e 100644
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



