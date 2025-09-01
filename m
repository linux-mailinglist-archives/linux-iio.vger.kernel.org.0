Return-Path: <linux-iio+bounces-23570-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4ABB3DB7D
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 09:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 722163BF344
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 07:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755952853E2;
	Mon,  1 Sep 2025 07:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="bpnyXVAk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8B72F068F
	for <linux-iio@vger.kernel.org>; Mon,  1 Sep 2025 07:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756712987; cv=none; b=GOlBcH2rZlKjuHTZrUaZ/NE8ofxJ/AJvslUyjZ/WDHVTMsdiPHDTaf/wYH9xa8+b5PZpU6E22d4CiatDRYrcYxG10agBV95Mtb1AuENZ5ssX8D7MmPgFt2JgY6PPCxA9MRNi9IICmldF9CrzYog4SCWuxJV8keUzua5NBQmHYj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756712987; c=relaxed/simple;
	bh=uSVzrvRQzSyDXw7sVSepTzV/9XtTv41XpieSLxkwxTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SQMJe72K9nPILwz/DrRQVIQ0pXjHqJFpX2bunJ/GllIFZpSzbujIwAsgvg6iytTCezNYafPS6bYerexGxGBHnkGJakjUzykEEqLD7vL+SSKSDaehHcqt1/PRKHr9ZXRfTNfBiz64+Xyj5C7ZZmrhEhAZKO8/U4XzaLbyP1TJXTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=bpnyXVAk; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail2; t=1756712977; x=1756972177;
	bh=8HEq7geS3PB7I0Eqv8tYlAjSKY29gpA1QalLQ3uvKTE=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=bpnyXVAkNDBrjt6eEOppoqdfRBDIpL0494zkpYm7GNiOpUIe03D/eASk0YBjNTaIU
	 nU69GB/n4xX1PfZdJbZV75QyHEcDC+1vmoO2VkN//D6iOvpLJMkJq5lW3kb3pi0/xt
	 dqLdgmHyuY7Nrf5fv56fbSCSqgSxLVWnkETU5Bxr3tlfQM9trR07p89rlLEZevqk18
	 Qqt4jK4BLEbX7ZQam7fkDH86jM5WUADLaxqGA2+u+pPfzPAs4d9bEaZmMBROZpFj0Q
	 iUn+1lrKLYrn3cHbwb48ZXXRrIXcKA2+dBbAPK0GtI5IxbqKVC+duli+dE3hJZfBCK
	 30fdlFfg67TRA==
X-Pm-Submission-Id: 4cFgxq4v4Gz1DDC3
From: Sean Nyekjaer <sean@geanix.com>
Date: Mon, 01 Sep 2025 09:49:17 +0200
Subject: [PATCH v3 5/5] iio: imu: inv_icm42600: use guard() to release
 mutexes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-icm42pmreg-v3-5-ef1336246960@geanix.com>
References: <20250901-icm42pmreg-v3-0-ef1336246960@geanix.com>
In-Reply-To: <20250901-icm42pmreg-v3-0-ef1336246960@geanix.com>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 rafael@kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2

Replace explicit mutex_lock() and mutex_unlock() with the guard() macro
for cleaner and safer mutex handling.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  | 25 +++------
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 27 ++++-----
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   | 65 +++++++++-------------
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   | 20 +++----
 4 files changed, 55 insertions(+), 82 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 48014b61ced335eb2c8549cfc2e79ccde1934308..fbed6974ef04ac003c9b7bd38f87bd77f4b55509 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -561,11 +561,11 @@ static int inv_icm42600_accel_write_scale(struct iio_dev *indio_dev,
 	conf.fs = idx / 2;
 
 	pm_runtime_get_sync(dev);
-	mutex_lock(&st->lock);
 
-	ret = inv_icm42600_set_accel_conf(st, &conf, NULL);
+	scoped_guard(mutex, &st->lock) {
+		ret = inv_icm42600_set_accel_conf(st, &conf, NULL);
+	}
 
-	mutex_unlock(&st->lock);
 	pm_runtime_put_autosuspend(dev);
 
 	return ret;
@@ -986,16 +986,11 @@ static int inv_icm42600_accel_hwfifo_set_watermark(struct iio_dev *indio_dev,
 						   unsigned int val)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
-	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	st->fifo.watermark.accel = val;
-	ret = inv_icm42600_buffer_update_watermark(st);
-
-	mutex_unlock(&st->lock);
-
-	return ret;
+	return inv_icm42600_buffer_update_watermark(st);
 }
 
 static int inv_icm42600_accel_hwfifo_flush(struct iio_dev *indio_dev,
@@ -1007,15 +1002,13 @@ static int inv_icm42600_accel_hwfifo_flush(struct iio_dev *indio_dev,
 	if (count == 0)
 		return 0;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	ret = inv_icm42600_buffer_hwfifo_flush(st, count);
-	if (!ret)
-		ret = st->fifo.nb.accel;
-
-	mutex_unlock(&st->lock);
+	if (ret)
+		return ret;
 
-	return ret;
+	return st->fifo.nb.accel;
 }
 
 static int inv_icm42600_accel_read_event_config(struct iio_dev *indio_dev,
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 36d69a0face655bf2dc9229c52d07448e9b2ca02..64534ab9e96fd3798bee7eace5a5968eec63570b 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -283,9 +283,8 @@ static int inv_icm42600_buffer_preenable(struct iio_dev *indio_dev)
 
 	pm_runtime_get_sync(dev);
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	inv_sensors_timestamp_reset(ts);
-	mutex_unlock(&st->lock);
 
 	return 0;
 }
@@ -299,7 +298,7 @@ static int inv_icm42600_buffer_postenable(struct iio_dev *indio_dev)
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	/* exit if FIFO is already on */
 	if (st->fifo.on) {
@@ -311,30 +310,29 @@ static int inv_icm42600_buffer_postenable(struct iio_dev *indio_dev)
 	ret = regmap_set_bits(st->map, INV_ICM42600_REG_INT_SOURCE0,
 			      INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	/* flush FIFO data */
 	ret = regmap_write(st->map, INV_ICM42600_REG_SIGNAL_PATH_RESET,
 			   INV_ICM42600_SIGNAL_PATH_RESET_FIFO_FLUSH);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	/* set FIFO in streaming mode */
 	ret = regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,
 			   INV_ICM42600_FIFO_CONFIG_STREAM);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	/* workaround: first read of FIFO count after reset is always 0 */
 	ret = regmap_bulk_read(st->map, INV_ICM42600_REG_FIFO_COUNT, st->buffer, 2);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 out_on:
 	/* increase FIFO on counter */
 	st->fifo.on++;
-out_unlock:
-	mutex_unlock(&st->lock);
+
 	return ret;
 }
 
@@ -343,7 +341,7 @@ static int inv_icm42600_buffer_predisable(struct iio_dev *indio_dev)
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	/* exit if there are several sensors using the FIFO */
 	if (st->fifo.on > 1) {
@@ -355,25 +353,24 @@ static int inv_icm42600_buffer_predisable(struct iio_dev *indio_dev)
 	ret = regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,
 			   INV_ICM42600_FIFO_CONFIG_BYPASS);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	/* flush FIFO data */
 	ret = regmap_write(st->map, INV_ICM42600_REG_SIGNAL_PATH_RESET,
 			   INV_ICM42600_SIGNAL_PATH_RESET_FIFO_FLUSH);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	/* disable FIFO threshold interrupt */
 	ret = regmap_clear_bits(st->map, INV_ICM42600_REG_INT_SOURCE0,
 				INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 out_off:
 	/* decrease FIFO on counter */
 	st->fifo.on--;
-out_unlock:
-	mutex_unlock(&st->lock);
+
 	return ret;
 }
 
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 4bf436c46f1cfd7e7e1bb911d94a0a566d63e791..4db8bc68075a30c59e6e358bb0b73b1e6b9175ea 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -439,18 +439,13 @@ int inv_icm42600_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
 			     unsigned int writeval, unsigned int *readval)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
-	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	if (readval)
-		ret = regmap_read(st->map, reg, readval);
+		return regmap_read(st->map, reg, readval);
 	else
-		ret = regmap_write(st->map, reg, writeval);
-
-	mutex_unlock(&st->lock);
-
-	return ret;
+		return regmap_write(st->map, reg, writeval);
 }
 
 static int inv_icm42600_set_conf(struct inv_icm42600_state *st,
@@ -820,22 +815,23 @@ static int inv_icm42600_suspend(struct device *dev)
 	struct device *accel_dev;
 	bool wakeup;
 	int accel_conf;
-	int ret = 0;
+	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	st->suspended.gyro = st->conf.gyro.mode;
 	st->suspended.accel = st->conf.accel.mode;
 	st->suspended.temp = st->conf.temp_en;
-	if (pm_runtime_suspended(dev))
-		goto out_unlock;
+	ret = pm_runtime_suspended(dev);
+	if (ret)
+		return ret;
 
 	/* disable FIFO data streaming */
 	if (st->fifo.on) {
 		ret = regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,
 				   INV_ICM42600_FIFO_CONFIG_BYPASS);
 		if (ret)
-			goto out_unlock;
+			return ret;
 	}
 
 	/* keep chip on and wake-up capable if APEX and wakeup on */
@@ -851,7 +847,7 @@ static int inv_icm42600_suspend(struct device *dev)
 		if (st->apex.wom.enable) {
 			ret = inv_icm42600_disable_wom(st);
 			if (ret)
-				goto out_unlock;
+				return ret;
 		}
 		accel_conf = INV_ICM42600_SENSOR_MODE_OFF;
 	}
@@ -859,15 +855,13 @@ static int inv_icm42600_suspend(struct device *dev)
 	ret = inv_icm42600_set_pwr_mgmt0(st, INV_ICM42600_SENSOR_MODE_OFF,
 					 accel_conf, false, NULL);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	/* disable vddio regulator if chip is sleeping */
 	if (!wakeup)
 		regulator_disable(st->vddio_supply);
 
-out_unlock:
-	mutex_unlock(&st->lock);
-	return ret;
+	return 0;
 }
 
 /*
@@ -881,12 +875,13 @@ static int inv_icm42600_resume(struct device *dev)
 	struct inv_icm42600_sensor_state *accel_st = iio_priv(st->indio_accel);
 	struct device *accel_dev;
 	bool wakeup;
-	int ret = 0;
+	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
-	if (pm_runtime_suspended(dev))
-		goto out_unlock;
+	ret = pm_runtime_suspended(dev);
+	if (ret)
+		return ret;
 
 	/* check wakeup capability */
 	accel_dev = &st->indio_accel->dev;
@@ -898,7 +893,7 @@ static int inv_icm42600_resume(struct device *dev)
 	} else {
 		ret = inv_icm42600_enable_regulator_vddio(st);
 		if (ret)
-			goto out_unlock;
+			return ret;
 	}
 
 	/* restore sensors state */
@@ -906,13 +901,13 @@ static int inv_icm42600_resume(struct device *dev)
 					 st->suspended.accel,
 					 st->suspended.temp, NULL);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	/* restore APEX features if disabled */
 	if (!wakeup && st->apex.wom.enable) {
 		ret = inv_icm42600_enable_wom(st);
 		if (ret)
-			goto out_unlock;
+			return ret;
 	}
 
 	/* restore FIFO data streaming */
@@ -923,9 +918,7 @@ static int inv_icm42600_resume(struct device *dev)
 				   INV_ICM42600_FIFO_CONFIG_STREAM);
 	}
 
-out_unlock:
-	mutex_unlock(&st->lock);
-	return ret;
+	return 0;
 }
 
 /* Runtime suspend will turn off sensors that are enabled by iio devices. */
@@ -934,34 +927,28 @@ static int inv_icm42600_runtime_suspend(struct device *dev)
 	struct inv_icm42600_state *st = dev_get_drvdata(dev);
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	/* disable all sensors */
 	ret = inv_icm42600_set_pwr_mgmt0(st, INV_ICM42600_SENSOR_MODE_OFF,
 					 INV_ICM42600_SENSOR_MODE_OFF, false,
 					 NULL);
 	if (ret)
-		goto error_unlock;
+		return ret;
 
 	regulator_disable(st->vddio_supply);
 
-error_unlock:
-	mutex_unlock(&st->lock);
-	return ret;
+	return 0;
 }
 
 /* Sensors are enabled by iio devices, no need to turn them back on here. */
 static int inv_icm42600_runtime_resume(struct device *dev)
 {
 	struct inv_icm42600_state *st = dev_get_drvdata(dev);
-	int ret;
 
-	mutex_lock(&st->lock);
-
-	ret = inv_icm42600_enable_regulator_vddio(st);
+	guard(mutex)(&st->lock);
 
-	mutex_unlock(&st->lock);
-	return ret;
+	return inv_icm42600_enable_regulator_vddio(st);
 }
 
 EXPORT_NS_GPL_DEV_PM_OPS(inv_icm42600_pm_ops, IIO_ICM42600) = {
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index 8a7cc91276319f0b1714ad11d46e409688b258c4..865f6052a4b6278b59390fc7fcefd1bc7ecef076 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -277,11 +277,11 @@ static int inv_icm42600_gyro_write_scale(struct iio_dev *indio_dev,
 	conf.fs = idx / 2;
 
 	pm_runtime_get_sync(dev);
-	mutex_lock(&st->lock);
 
-	ret = inv_icm42600_set_gyro_conf(st, &conf, NULL);
+	scoped_guard(mutex, &st->lock) {
+		ret = inv_icm42600_set_gyro_conf(st, &conf, NULL);
+	}
 
-	mutex_unlock(&st->lock);
 	pm_runtime_put_autosuspend(dev);
 
 	return ret;
@@ -690,13 +690,11 @@ static int inv_icm42600_gyro_hwfifo_set_watermark(struct iio_dev *indio_dev,
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	st->fifo.watermark.gyro = val;
 	ret = inv_icm42600_buffer_update_watermark(st);
 
-	mutex_unlock(&st->lock);
-
 	return ret;
 }
 
@@ -709,15 +707,13 @@ static int inv_icm42600_gyro_hwfifo_flush(struct iio_dev *indio_dev,
 	if (count == 0)
 		return 0;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	ret = inv_icm42600_buffer_hwfifo_flush(st, count);
-	if (!ret)
-		ret = st->fifo.nb.gyro;
-
-	mutex_unlock(&st->lock);
+	if (ret)
+		return ret;
 
-	return ret;
+	return st->fifo.nb.gyro;
 }
 
 static const struct iio_info inv_icm42600_gyro_info = {

-- 
2.50.1


