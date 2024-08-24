Return-Path: <linux-iio+bounces-8767-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4763F95DE45
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 16:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99D21F22338
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 14:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CC61714B7;
	Sat, 24 Aug 2024 14:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAZQZaXA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6280B1EA80;
	Sat, 24 Aug 2024 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724508700; cv=none; b=F+Cf0IdN+ypueBqnenHr7PsBcOZrCpQVicc+e7XRNWLrMqyuc+UVIJnV7RLFX1weETCFVss4PXtBLjdG+IoeJVCtXpbnQFDdMD1m4OTA6qgkXItPEZEZsCOcYQd0mdnxlr8TSYEiSV1bR5aSJucBTSUzzE8dFRZ0QY68I6t6f68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724508700; c=relaxed/simple;
	bh=Wf0Mn9chndIo2h8mdCV35hARRU7Q9WQAHn6/o9fwofU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AHjzST3eiHlHt1xjxFKDq9Q/Ux8428hOLZLCuGqzPe6rH7PhJR+pNmBs+42EQQQ3YZDzYuiOrD75xQ4wsboGpVNkb877JNPUpaRDpTa0YcSiBaZXHukHzhu4FcFFkhirSZXqH8sXSReyH4vebMgM+YQJGnbuMAhY1uu6ZumJ5dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAZQZaXA; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37189d8e637so1585041f8f.3;
        Sat, 24 Aug 2024 07:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724508697; x=1725113497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AhmHve+mnr3q92I9fHvwx5bpFy/8zq8+Ha3er/FumU=;
        b=BAZQZaXAIuWSw7h0ziY/Olrdl1ApJNe6tL73BXlAev7YSy6BZagSb0ZwqnJYDSNiDl
         pzjVWja8CsQR9FbWneEF3Q0zGZPHScd2niu6LS1DiS9LYqophQEO71zw6sJZ/rA8teZF
         Np5xpbSxOWg5KglDRjtotOl0bQk5QKrW9D+z7GDkAcl+B6TBAAtOgNNXqUENdQbGzDrH
         99SOPMTMF4gmvQMrXKgeXaS5FQ4vBj0t3LMA/wAWjmw/ob6Fh9f5SCaHbSQopaS32xL2
         REB3nrSFongit0j/5KjwQJczHgL5UuzQ5z+q8W+O3UZcsopNTfkaDHrISSpDD1rxbWkY
         Jlug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724508697; x=1725113497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+AhmHve+mnr3q92I9fHvwx5bpFy/8zq8+Ha3er/FumU=;
        b=VINP+t4WyAp6oDKVg8gxkgH1oEl+373Jn4v4mubXnQc5knxZRMaU//E1g0XCIqUFgF
         A/sMRmDS7T8HTj1ScjTQzFIpMZ7wgSsu9cltrKRvuW+RlH3SKDYB8D9lKG9dz8V3ivxh
         j991bEGMMl+4i341CP6VKVSTOLovJMZTS3DRTmB75tMEs54dKY6BP4V4HcQGOy/5kZlM
         Xo7xI6RhCxZ2uA33i1xd0+nlvzGm4ocRG2ni6GWDVv6/qSs2QYDoi3tmiwgIXKuNfJAe
         LguD+mrhTQBJRHfpxgu3Py4S1APBtFtBYquItAfd7J6X02qNS0K66JEQD2+AnySQA7dv
         OMPg==
X-Forwarded-Encrypted: i=1; AJvYcCUoLDcNPvI3xWJS/YAVZXM2W40jdks/U0zETkj9Hweznw3i3SlZbmA/2ljXx/MkECrNeID5UV9qK9A=@vger.kernel.org, AJvYcCXy9RLHHnUzPluMKbvyzRKLXHVmK/fHvq/E2quJeqVw97cvOrRemrbZRasDMUZ2f9oWrNBvjIm06CuAhc6G@vger.kernel.org
X-Gm-Message-State: AOJu0YxxrQ3tb8gbAAq4cclDD9A37BNuF4vRZxIUaZ+mmzvLj9PYSLI5
	GJC0R2C7Mc7JNLouJPv6Ohlp2ZDaW7JvwVXToUUwcGPTsr4O2Uac
X-Google-Smtp-Source: AGHT+IFEI8dsCCysbCF3beeuMMxlT4spZg9cRd+pbWoBsaWN5yUUSzpmDVljplcTMIN5/bwA95Rt2Q==
X-Received: by 2002:adf:f451:0:b0:371:8748:cb19 with SMTP id ffacd0b85a97d-373118ee926mr3367079f8f.56.1724508696497;
        Sat, 24 Aug 2024 07:11:36 -0700 (PDT)
Received: from localhost.localdomain ([151.95.114.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730821ab05sm6591427f8f.98.2024.08.24.07.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 07:11:36 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jagath Jog J <jagathjog1996@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D . Jones" <luke@ljones.dev>,
	Jonathan LoBue <jlobue10@gmail.com>,
	Denis Benato <benato.denis96@gmail.com>
Subject: [PATCH v3 1/1] iio: bmi323: peripheral in lowest power state on suspend
Date: Sat, 24 Aug 2024 16:11:22 +0200
Message-ID: <20240824141122.334620-2-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240824141122.334620-1-benato.denis96@gmail.com>
References: <20240823192921.7df291f8@jic23-huawei>
 <20240824141122.334620-1-benato.denis96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bmi323 is mounted on some devices that are powered
by an internal battery: help in reducing system overall power drain
while the system is in s2idle or the imu driver is not loaded
by resetting it in its lowest power draining state.

Signed-off-by: Denis Benato <benato.denis96@gmail.com>
---
 drivers/iio/imu/bmi323/bmi323_core.c | 155 ++++++++++++++++++++++++++-
 1 file changed, 153 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
index 4b2b211a3e88..57be22c97cb9 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -118,6 +118,38 @@ static const struct bmi323_hw bmi323_hw[2] = {
 	},
 };
 
+static const unsigned int bmi323_reg_savestate[] = {
+	BMI323_INT_MAP1_REG,
+	BMI323_INT_MAP2_REG,
+	BMI323_IO_INT_CTR_REG,
+	BMI323_IO_INT_CONF_REG,
+	BMI323_ACC_CONF_REG,
+	BMI323_GYRO_CONF_REG,
+	BMI323_FEAT_IO0_REG,
+	BMI323_FIFO_WTRMRK_REG,
+	BMI323_FIFO_CONF_REG
+};
+
+static const unsigned int bmi323_ext_reg_savestate[] = {
+	BMI323_GEN_SET1_REG,
+	BMI323_TAP1_REG,
+	BMI323_TAP2_REG,
+	BMI323_TAP3_REG,
+	BMI323_FEAT_IO0_S_TAP_MSK,
+	BMI323_STEP_SC1_REG,
+	BMI323_ANYMO1_REG,
+	BMI323_NOMO1_REG,
+	BMI323_ANYMO1_REG + BMI323_MO2_OFFSET,
+	BMI323_NOMO1_REG + BMI323_MO2_OFFSET,
+	BMI323_ANYMO1_REG + BMI323_MO3_OFFSET,
+	BMI323_NOMO1_REG + BMI323_MO3_OFFSET
+};
+
+struct bmi323_regs_runtime_pm {
+	unsigned int reg_settings[ARRAY_SIZE(bmi323_reg_savestate)];
+	unsigned int ext_reg_settings[ARRAY_SIZE(bmi323_ext_reg_savestate)];
+};
+
 struct bmi323_data {
 	struct device *dev;
 	struct regmap *regmap;
@@ -130,6 +162,7 @@ struct bmi323_data {
 	u32 odrns[BMI323_SENSORS_CNT];
 	u32 odrhz[BMI323_SENSORS_CNT];
 	unsigned int feature_events;
+	struct bmi323_regs_runtime_pm runtime_pm_status;
 
 	/*
 	 * Lock to protect the members of device's private data from concurrent
@@ -1972,6 +2005,11 @@ static void bmi323_disable(void *data_ptr)
 
 	bmi323_set_mode(data, BMI323_ACCEL, ACC_GYRO_MODE_DISABLE);
 	bmi323_set_mode(data, BMI323_GYRO, ACC_GYRO_MODE_DISABLE);
+
+	/*
+	 * Place the peripheral in its lowest power consuming state.
+	 */
+	regmap_write(data->regmap, BMI323_CMD_REG, BMI323_RST_VAL);
 }
 
 static int bmi323_set_bw(struct bmi323_data *data,
@@ -2030,6 +2068,13 @@ static int bmi323_init(struct bmi323_data *data)
 		return dev_err_probe(data->dev, -EINVAL,
 				     "Sensor power error = 0x%x\n", val);
 
+	return 0;
+}
+
+static int bmi323_init_reset(struct bmi323_data *data)
+{
+	int ret;
+
 	/*
 	 * Set the Bandwidth coefficient which defines the 3 dB cutoff
 	 * frequency in relation to the ODR.
@@ -2078,12 +2123,18 @@ int bmi323_core_probe(struct device *dev)
 	data = iio_priv(indio_dev);
 	data->dev = dev;
 	data->regmap = regmap;
+	data->irq_pin = BMI323_IRQ_DISABLED;
+	data->state = BMI323_IDLE;
 	mutex_init(&data->mutex);
 
 	ret = bmi323_init(data);
 	if (ret)
 		return -EINVAL;
 
+	ret = bmi323_init_reset(data);
+	if (ret)
+		return -EINVAL;
+
 	if (!iio_read_acpi_mount_matrix(dev, &data->orientation, "ROTM")) {
 		ret = iio_read_mount_matrix(dev, &data->orientation);
 		if (ret)
@@ -2117,7 +2168,7 @@ int bmi323_core_probe(struct device *dev)
 		return dev_err_probe(data->dev, ret,
 				     "Unable to register iio device\n");
 
-	return 0;
+	return bmi323_fifo_disable(data);
 }
 EXPORT_SYMBOL_NS_GPL(bmi323_core_probe, IIO_BMI323);
 
@@ -2125,13 +2176,113 @@ EXPORT_SYMBOL_NS_GPL(bmi323_core_probe, IIO_BMI323);
 static int bmi323_core_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct bmi323_data *data = iio_priv(indio_dev);
+	struct bmi323_regs_runtime_pm *savestate = &data->runtime_pm_status;
+	int ret;
+
+	guard(mutex)(&data->mutex);
+
+	ret = iio_device_suspend_triggering(indio_dev);
+	if (ret)
+		return ret;
+
+	/* Save registers meant to be restored by resume pm callback. */
+	for (unsigned int i = 0; i < ARRAY_SIZE(bmi323_reg_savestate); i++) {
+		ret = regmap_read(data->regmap, bmi323_reg_savestate[i],
+			   &savestate->reg_settings[i]);
+		if (ret) {
+			dev_err(data->dev, "Error reading bmi323 reg 0x%x: %d\n",
+				  bmi323_reg_savestate[i], ret);
+			return ret;
+		}
+	}
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(bmi323_ext_reg_savestate); i++) {
+		ret = bmi323_read_ext_reg(data, bmi323_reg_savestate[i],
+			   &savestate->reg_settings[i]);
+		if (ret) {
+			dev_err(data->dev, "Error reading bmi323 external reg 0x%x: %d\n",
+				  bmi323_reg_savestate[i], ret);
+			return ret;
+		}
+	}
+
+	/* Perform soft reset to place the device in its lowest power state. */
+	ret = regmap_write(data->regmap, BMI323_CMD_REG, BMI323_RST_VAL);
+	if (ret)
+		return ret;
 
-	return iio_device_suspend_triggering(indio_dev);
+	return 0;
 }
 
 static int bmi323_core_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct bmi323_data *data = iio_priv(indio_dev);
+	struct bmi323_regs_runtime_pm *savestate = &data->runtime_pm_status;
+	unsigned int val;
+	int ret;
+
+	guard(mutex)(&data->mutex);
+
+	/*
+	 * Perform the device power-on and initial setup once again
+	 * after being reset in the lower power state by runtime-pm.
+	 */
+	ret = bmi323_init(data);
+	if (!ret)
+		return ret;
+
+	/* Register must be cleared before changing an active config */
+	ret = regmap_write(data->regmap, BMI323_FEAT_IO0_REG, 0);
+	if (ret) {
+		dev_err(data->dev, "Error stopping feature engine\n");
+		return ret;
+	}
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(bmi323_ext_reg_savestate); i++) {
+		ret = bmi323_write_ext_reg(data, bmi323_reg_savestate[i],
+			  savestate->reg_settings[i]);
+		if (ret) {
+			dev_err(data->dev, "Error writing bmi323 external reg 0x%x: %d\n",
+				  bmi323_reg_savestate[i], ret);
+			return ret;
+		}
+	}
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(bmi323_reg_savestate); i++) {
+		ret = regmap_write(data->regmap, bmi323_reg_savestate[i],
+			  savestate->reg_settings[i]);
+		if (ret) {
+			dev_err(data->dev, "Error writing bmi323 reg 0x%x: %d\n",
+				  bmi323_reg_savestate[i], ret);
+			return ret;
+		}
+	}
+
+	/*
+	 * Clear old FIFO samples that might be generated before suspend
+	 * or generated from a peripheral state not equal to the saved one.
+	 */
+	if (data->state == BMI323_BUFFER_FIFO) {
+		ret = regmap_write(data->regmap, BMI323_FIFO_CTRL_REG,
+			   BMI323_FIFO_FLUSH_MSK);
+		if (ret) {
+			dev_err(data->dev, "Error flushing FIFO buffer: %d\n", ret);
+			return ret;
+		}
+	}
+
+	ret = regmap_read(data->regmap, BMI323_ERR_REG, &val);
+	if (ret) {
+		dev_err(data->dev, "Error reading bmi323 error register: %d\n", ret);
+		return ret;
+	}
+
+	if (val) {
+		dev_err(data->dev, "Sensor power error in PM = 0x%x\n", val);
+		return -EINVAL;
+	}
 
 	return iio_device_resume_triggering(indio_dev);
 }
-- 
2.46.0


