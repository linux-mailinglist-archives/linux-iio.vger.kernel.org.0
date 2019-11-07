Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4042EF377C
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2019 19:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfKGSqP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Nov 2019 13:46:15 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:10257 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfKGSqO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Nov 2019 13:46:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573152371;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=M0SkY422W77c8+OLI5WPEaw391MF/u1kXF3/i3p3FEc=;
        b=etLkjGloJRYoGSDNNhNN2xj9Wyb0tGGfxhhW4a22gCUT+CYQ6yG0iaDL4DT70S1OSG
        iefnMMCfBUMJTBg7LRax1D2aREJhEaYAp83AyOUIbPVrIhQdQFCm2wjsMeFgi8dRZ+4/
        AcRGbKOw6c4/wCQslcMuCnnB4VKDbRATVYNf0l+2JYf7rn+ROEwS1eWFZKG1PMPtwcTv
        ob+F7f46v++tx4XNEkD0KLvHIh6ohkuim4u9miDfxDSb+d+kHl2Z5/qtmoFL3B1wIZWM
        mAKw+nwOCxMitTA+eATZlHlOcv64fncZqsARJjzb5wdHhK8DNzDa9HCzNOef+RebpgMI
        sidA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXsMnvtxdYcg=="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id e07688vA7IkAoQr
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 7 Nov 2019 19:46:10 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2 2/2] iio: imu: mpu6050: Add support for vdd-supply regulator
Date:   Thu,  7 Nov 2019 19:43:42 +0100
Message-Id: <20191107184342.20361-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191107184342.20361-1-stephan@gerhold.net>
References: <20191107184342.20361-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

MPU6050 has two power supply pins: VDD and VLOGIC, but the
mpu6050 driver only supports enabling one of them at the moment.
In some cases, they may need to be enabled separately.

Add an additional "vdd-supply" that stays enabled for as long as
the driver is loaded. We cannot turn off the VDD regulator during
suspend as this would cause register settings (FSR, sampling rate, ...)
to be lost.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Changes in v2:
  - Keep "vdd-supply" enabled during suspend to prevent register
    settings from getting lost.
  - Revert convertion to bulk regulator API (does not work well
    when regulators need to be enabled/disabled separately)

v1: https://lore.kernel.org/linux-iio/20191106183536.123070-2-stephan@gerhold.net/
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 43 +++++++++++++++++-----
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  4 +-
 2 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 354030e9bed5..661a829478f5 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1140,14 +1140,14 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
 	return result;
 }
 
-static int inv_mpu_core_enable_regulator(struct inv_mpu6050_state *st)
+static int inv_mpu_core_enable_regulator_vddio(struct inv_mpu6050_state *st)
 {
 	int result;
 
 	result = regulator_enable(st->vddio_supply);
 	if (result) {
 		dev_err(regmap_get_device(st->map),
-			"Failed to enable regulator: %d\n", result);
+			"Failed to enable vddio regulator: %d\n", result);
 	} else {
 		/* Give the device a little bit of time to start up. */
 		usleep_range(35000, 70000);
@@ -1156,21 +1156,29 @@ static int inv_mpu_core_enable_regulator(struct inv_mpu6050_state *st)
 	return result;
 }
 
-static int inv_mpu_core_disable_regulator(struct inv_mpu6050_state *st)
+static int inv_mpu_core_disable_regulator_vddio(struct inv_mpu6050_state *st)
 {
 	int result;
 
 	result = regulator_disable(st->vddio_supply);
 	if (result)
 		dev_err(regmap_get_device(st->map),
-			"Failed to disable regulator: %d\n", result);
+			"Failed to disable vddio regulator: %d\n", result);
 
 	return result;
 }
 
 static void inv_mpu_core_disable_regulator_action(void *_data)
 {
-	inv_mpu_core_disable_regulator(_data);
+	struct inv_mpu6050_state *st = _data;
+	int result;
+
+	result = regulator_disable(st->vdd_supply);
+	if (result)
+		dev_err(regmap_get_device(st->map),
+			"Failed to disable vdd regulator: %d\n", result);
+
+	inv_mpu_core_disable_regulator_vddio(st);
 }
 
 int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
@@ -1239,6 +1247,15 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		return -EINVAL;
 	}
 
+	st->vdd_supply = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(st->vdd_supply)) {
+		if (PTR_ERR(st->vdd_supply) != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get vdd regulator %d\n",
+				(int)PTR_ERR(st->vdd_supply));
+
+		return PTR_ERR(st->vdd_supply);
+	}
+
 	st->vddio_supply = devm_regulator_get(dev, "vddio");
 	if (IS_ERR(st->vddio_supply)) {
 		if (PTR_ERR(st->vddio_supply) != -EPROBE_DEFER)
@@ -1248,9 +1265,17 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		return PTR_ERR(st->vddio_supply);
 	}
 
-	result = inv_mpu_core_enable_regulator(st);
-	if (result)
+	result = regulator_enable(st->vdd_supply);
+	if (result) {
+		dev_err(dev, "Failed to enable vdd regulator: %d\n", result);
 		return result;
+	}
+
+	result = inv_mpu_core_enable_regulator_vddio(st);
+	if (result) {
+		regulator_disable(st->vdd_supply);
+		return result;
+	}
 
 	result = devm_add_action_or_reset(dev, inv_mpu_core_disable_regulator_action,
 				 st);
@@ -1352,7 +1377,7 @@ static int inv_mpu_resume(struct device *dev)
 	int result;
 
 	mutex_lock(&st->lock);
-	result = inv_mpu_core_enable_regulator(st);
+	result = inv_mpu_core_enable_regulator_vddio(st);
 	if (result)
 		goto out_unlock;
 
@@ -1370,7 +1395,7 @@ static int inv_mpu_suspend(struct device *dev)
 
 	mutex_lock(&st->lock);
 	result = inv_mpu6050_set_power_itg(st, false);
-	inv_mpu_core_disable_regulator(st);
+	inv_mpu_core_disable_regulator_vddio(st);
 	mutex_unlock(&st->lock);
 
 	return result;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index 52fcf45050a5..4fcf683b9c63 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -130,7 +130,8 @@ struct inv_mpu6050_hw {
  *  @chip_period:	chip internal period estimation (~1kHz).
  *  @it_timestamp:	timestamp from previous interrupt.
  *  @data_timestamp:	timestamp for next data sample.
- *  @vddio_supply	voltage regulator for the chip.
+ *  @vdd_supply:	VDD voltage regulator for the chip.
+ *  @vddio_supply	I/O voltage regulator for the chip.
  *  @magn_disabled:     magnetometer disabled for backward compatibility reason.
  *  @magn_raw_to_gauss:	coefficient to convert mag raw value to Gauss.
  *  @magn_orient:       magnetometer sensor chip orientation if available.
@@ -154,6 +155,7 @@ struct inv_mpu6050_state {
 	s64 chip_period;
 	s64 it_timestamp;
 	s64 data_timestamp;
+	struct regulator *vdd_supply;
 	struct regulator *vddio_supply;
 	bool magn_disabled;
 	s32 magn_raw_to_gauss[3];
-- 
2.23.0

