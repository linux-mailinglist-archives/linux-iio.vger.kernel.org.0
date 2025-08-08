Return-Path: <linux-iio+bounces-22476-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 772E5B1ECA7
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 17:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA74179313
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 15:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868632868B0;
	Fri,  8 Aug 2025 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="tKt5Ef9I"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC60287249
	for <linux-iio@vger.kernel.org>; Fri,  8 Aug 2025 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668689; cv=none; b=RSuURcT3xAKxx927YJlBZx01XSv/t+Gn2iV6LKKkCUfDXLr7aMapIMd+ujatEjl3FQiRi3LD1lC9Sn1Gu6gERVlmCdDmUz/tCTvuF0n8QW9JmZyOdE3dR4FvxhY0S6WA39m/TUvHhsMrbNWhx4Vufsz2/umWR3FXuJnFaICxwC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668689; c=relaxed/simple;
	bh=VlR1RGNnD4IEMBjMzMVabP+MObfwMXuyj/dNymvqJls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=isNntfjhyQMrS74rfPlHMzuI1G1rNwXciI5Fr2MITThp0SNMSGqkYCwHnFMgRAiyDgMzVy1d56nepSm1B0RqT7NC+e8HLIpC2PJ2yu9LME60Y8fFnf8SXG6gam2XHtysNPd9BmgsUuirxBvPTfGBDLsb06GvZEHeW3lGqX3VU5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=tKt5Ef9I; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1754668677; x=1754927877;
	bh=JJ31uYs28q0YM2qlOujyLMfEI3sbvQ5uz3Sp7TuvQp0=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=tKt5Ef9IE5SmXUmimx73uK73RAyNNXcebVk6gYiqUj2VQ1wif4dj7UUAX9cbBymmJ
	 ZNe5TJfNKkpwO+YVeyJSc/xbDJx4n1gzo5XPm6JFd4mjShNxMHKS+J1qTuGIpXviea
	 Tz/v9uuwGz0srkVmYpcXR9xtuKRuon1/6Sc1Ec9DfyjrHPt1RjPbs3W4BZzCDV1GIR
	 RaTV7U1XlVQMvcQnrickC6jWZD6X/0bqbqI5ybMOhs6I3IQ1UyXkN+6t8bxHWVRteI
	 IBEhT71Lg7SYkt/5iAEkwp8VEROJEtMYcnMpacbhWyQuDsN1o+fbJhC0BAq7orXQQP
	 Owwaf531JSmHg==
X-Pm-Submission-Id: 4bz7wM16Zpz1DDBr
From: Sean Nyekjaer <sean@geanix.com>
Date: Fri, 08 Aug 2025 17:57:45 +0200
Subject: [PATCH v2 5/5] iio: imu: inv_icm42600: use guard() to release
 mutexes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-icm42pmreg-v2-5-a480279e7721@geanix.com>
References: <20250808-icm42pmreg-v2-0-a480279e7721@geanix.com>
In-Reply-To: <20250808-icm42pmreg-v2-0-a480279e7721@geanix.com>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2

Replace explicit mutex_lock() and mutex_unlock() with the guard() macro
for cleaner and safer mutex handling.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  | 11 ++----
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 27 ++++++--------
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   | 43 +++++++++-------------
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   | 11 ++----
 4 files changed, 36 insertions(+), 56 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 7a28051330b79098bfa94b8c8c78c2bce20b7230..1e58253b3ddc0028d0899ec04cabbc65c6bf2b72 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -562,11 +562,10 @@ static int inv_icm42600_accel_write_scale(struct iio_dev *indio_dev,
 	conf.fs = idx / 2;
 
 	pm_runtime_get_sync(dev);
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	ret = inv_icm42600_set_accel_conf(st, &conf, NULL);
 
-	mutex_unlock(&st->lock);
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
@@ -993,13 +992,11 @@ static int inv_icm42600_accel_hwfifo_set_watermark(struct iio_dev *indio_dev,
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	st->fifo.watermark.accel = val;
 	ret = inv_icm42600_buffer_update_watermark(st);
 
-	mutex_unlock(&st->lock);
-
 	return ret;
 }
 
@@ -1012,14 +1009,12 @@ static int inv_icm42600_accel_hwfifo_flush(struct iio_dev *indio_dev,
 	if (count == 0)
 		return 0;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	ret = inv_icm42600_buffer_hwfifo_flush(st, count);
 	if (!ret)
 		ret = st->fifo.nb.accel;
 
-	mutex_unlock(&st->lock);
-
 	return ret;
 }
 
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 7c4ed981db043b4e8f3967b0802655d34f863954..d052b7069dc5c99dfea634415c107e188994c995 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -292,9 +292,8 @@ static int inv_icm42600_buffer_preenable(struct iio_dev *indio_dev)
 
 	pm_runtime_get_sync(dev);
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	inv_sensors_timestamp_reset(ts);
-	mutex_unlock(&st->lock);
 
 	return 0;
 }
@@ -308,7 +307,7 @@ static int inv_icm42600_buffer_postenable(struct iio_dev *indio_dev)
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	/* exit if FIFO is already on */
 	if (st->fifo.on) {
@@ -320,30 +319,29 @@ static int inv_icm42600_buffer_postenable(struct iio_dev *indio_dev)
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
 
@@ -352,7 +350,7 @@ static int inv_icm42600_buffer_predisable(struct iio_dev *indio_dev)
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	/* exit if there are several sensors using the FIFO */
 	if (st->fifo.on > 1) {
@@ -364,25 +362,24 @@ static int inv_icm42600_buffer_predisable(struct iio_dev *indio_dev)
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
index 52f61e90fec3e08effc1d398293bece5413406d1..82e6c8b3fba5b63d4eebb0a68bd88b950dbe881d 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -441,15 +441,13 @@ int inv_icm42600_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	if (readval)
 		ret = regmap_read(st->map, reg, readval);
 	else
 		ret = regmap_write(st->map, reg, writeval);
 
-	mutex_unlock(&st->lock);
-
 	return ret;
 }
 
@@ -820,20 +818,21 @@ static int inv_icm42600_suspend(struct device *dev)
 	int accel_conf;
 	int ret = 0;
 
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
@@ -849,7 +848,7 @@ static int inv_icm42600_suspend(struct device *dev)
 		if (st->apex.wom.enable) {
 			ret = inv_icm42600_disable_wom(st);
 			if (ret)
-				goto out_unlock;
+				return ret;
 		}
 		accel_conf = INV_ICM42600_SENSOR_MODE_OFF;
 	}
@@ -857,14 +856,12 @@ static int inv_icm42600_suspend(struct device *dev)
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
 	return ret;
 }
 
@@ -881,10 +878,11 @@ static int inv_icm42600_resume(struct device *dev)
 	bool wakeup;
 	int ret = 0;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
-	if (pm_runtime_suspended(dev))
-		goto out_unlock;
+	ret = pm_runtime_suspended(dev);
+	if (ret)
+		return ret;
 
 	/* check wakeup capability */
 	accel_dev = &st->indio_accel->dev;
@@ -896,7 +894,7 @@ static int inv_icm42600_resume(struct device *dev)
 	} else {
 		ret = inv_icm42600_enable_regulator_vddio(st);
 		if (ret)
-			goto out_unlock;
+			return ret;
 	}
 
 	/* restore sensors state */
@@ -904,13 +902,13 @@ static int inv_icm42600_resume(struct device *dev)
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
@@ -921,8 +919,6 @@ static int inv_icm42600_resume(struct device *dev)
 				   INV_ICM42600_FIFO_CONFIG_STREAM);
 	}
 
-out_unlock:
-	mutex_unlock(&st->lock);
 	return ret;
 }
 
@@ -932,19 +928,17 @@ static int inv_icm42600_runtime_suspend(struct device *dev)
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
 	return ret;
 }
 
@@ -954,11 +948,10 @@ static int inv_icm42600_runtime_resume(struct device *dev)
 	struct inv_icm42600_state *st = dev_get_drvdata(dev);
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	ret = inv_icm42600_enable_regulator_vddio(st);
 
-	mutex_unlock(&st->lock);
 	return ret;
 }
 
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index 9ba6f13628e6af5e19d047476ae93754f07aa95f..875e48748d70678bcd3963187be6de8c5a2b2fcc 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -278,11 +278,10 @@ static int inv_icm42600_gyro_write_scale(struct iio_dev *indio_dev,
 	conf.fs = idx / 2;
 
 	pm_runtime_get_sync(dev);
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	ret = inv_icm42600_set_gyro_conf(st, &conf, NULL);
 
-	mutex_unlock(&st->lock);
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
@@ -695,13 +694,11 @@ static int inv_icm42600_gyro_hwfifo_set_watermark(struct iio_dev *indio_dev,
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
 
@@ -714,14 +711,12 @@ static int inv_icm42600_gyro_hwfifo_flush(struct iio_dev *indio_dev,
 	if (count == 0)
 		return 0;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	ret = inv_icm42600_buffer_hwfifo_flush(st, count);
 	if (!ret)
 		ret = st->fifo.nb.gyro;
 
-	mutex_unlock(&st->lock);
-
 	return ret;
 }
 

-- 
2.50.1


