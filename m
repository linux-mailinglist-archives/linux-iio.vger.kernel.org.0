Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541F96F9B02
	for <lists+linux-iio@lfdr.de>; Sun,  7 May 2023 20:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjEGSrN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 May 2023 14:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjEGSrL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 May 2023 14:47:11 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CAF12491;
        Sun,  7 May 2023 11:47:09 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 063558267E;
        Sun,  7 May 2023 20:47:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683485228;
        bh=u1gATl9B69gtbKY0ZuXg7NBBYCJScRsLDewITVDA7TU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bn5J5eO4hGSwY74FJQwufaszigAjwr6ZQkexoJk6lEMwoovno9SoZwI1A2YG6lWaM
         gkRu09HnEJ049zH4laJc7NavyauEA38hvAqKnOF94OQqfm29o2OS6G3K9LUllkWAXR
         ReErWc4qFY1Utdc4XHasq/i4XRNY+ZL/fJhRVI0/5XQObSjWoz7G06B8suTqlk2AMZ
         5WboB5+4Mv/GqgZ7AUnuPSkKPf1bKzMvoIQe6BTwNz+5eVdQcqByFdNwEDtdipr8PA
         whZM6CnChjyjgSaMk7VDMI+4c91Mo45vlVFT6O7P9M4LTaK+kOPcBMWf0hCFnXhKi9
         uyOT59aAMSWfw==
From:   Marek Vasut <marex@denx.de>
To:     linux-iio@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Crt Mori <cmo@melexis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 5/5] iio: mlx90614: Add MLX90615 support
Date:   Sun,  7 May 2023 20:46:49 +0200
Message-Id: <20230507184649.39290-5-marex@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230507184649.39290-1-marex@denx.de>
References: <20230507184649.39290-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for MLX90615 Infra Red Thermometer, which seems to be
the predecesor of MLX90614 . There are significant differences in
the register layout compared to MLX90614, but the functionality
of the device is virtually identical.

The following differences have been identified:
- RAM/EEPROM/SLEEP access opcodes are different
- RAM/EEPROM registers are at different offsets
- EEPROM emissivity and configuration registers are at different offsets
- EEPROM configuration register bits are shuffled around
- EEPROM emissivity settings are 14 bit on MLX90615 , 16 bit on MLX90614
- MLX90615 can only ever support one sensor, MLX90614 could support two
- FIR filter is set to fixed settings on MLX90615
- IIR filter coefficients are different

This patch fills in the MLX90615 specific description and quirk handling.

Signed-off-by: Marek Vasut <marex@denx.de>
---
NOTE: The IIR coefficients need to be checked
---
Cc: Crt Mori <cmo@melexis.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Marek Vasut <marex@denx.de>
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-iio@vger.kernel.org
---
V2: Split the patch up into cleanups, abstraction and MLX90615 addition
---
 drivers/iio/temperature/mlx90614.c | 49 +++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index d6d2a5afaf8c0..5bcd323921db5 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -1,12 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * mlx90614.c - Support for Melexis MLX90614 contactless IR temperature sensor
+ * mlx90614.c - Support for Melexis MLX90614/MLX90615 contactless IR temperature sensor
  *
  * Copyright (c) 2014 Peter Meerwald <pmeerw@pmeerw.net>
  * Copyright (c) 2015 Essensium NV
  * Copyright (c) 2015 Melexis
  *
- * Driver for the Melexis MLX90614 I2C 16-bit IR thermopile sensor
+ * Driver for the Melexis MLX90614/MLX90615 I2C 16-bit IR thermopile sensor
+ *
+ * MLX90614 - 17-bit ADC + MLX90302 DSP
+ * MLX90615 - 16-bit ADC + MLX90325 DSP
  *
  * (7-bit I2C slave address 0x5a, 100KHz bus speed only!)
  *
@@ -35,6 +38,10 @@
 #define MLX90614_OP_EEPROM	0x20
 #define MLX90614_OP_SLEEP	0xff
 
+#define MLX90615_OP_EEPROM	0x10
+#define MLX90615_OP_RAM		0x20
+#define MLX90615_OP_SLEEP	0xc6
+
 /* Control bits in configuration register */
 #define MLX90614_CONFIG_IIR_SHIFT 0 /* IIR coefficient */
 #define MLX90614_CONFIG_IIR_MASK (0x7 << MLX90614_CONFIG_IIR_SHIFT)
@@ -43,11 +50,16 @@
 #define MLX90614_CONFIG_FIR_SHIFT 8 /* FIR coefficient */
 #define MLX90614_CONFIG_FIR_MASK (0x7 << MLX90614_CONFIG_FIR_SHIFT)
 
+#define MLX90615_CONFIG_IIR_SHIFT 12 /* IIR coefficient */
+#define MLX90615_CONFIG_IIR_MASK (0x7 << MLX90615_CONFIG_IIR_SHIFT)
+
 /* Timings (in ms) */
 #define MLX90614_TIMING_EEPROM 20 /* time for EEPROM write/erase to complete */
 #define MLX90614_TIMING_WAKEUP 34 /* time to hold SDA low for wake-up */
 #define MLX90614_TIMING_STARTUP 250 /* time before first data after wake-up */
 
+#define MLX90615_TIMING_WAKEUP 22 /* time to hold SCL low for wake-up */
+
 #define MLX90614_AUTOSLEEP_DELAY 5000 /* default autosleep delay */
 
 /* Magic constants */
@@ -306,8 +318,8 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
 			*val2 = ret * chip_info->emissivity_res;
 		}
 		return IIO_VAL_INT_PLUS_NANO;
-	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY: /* IIR setting with
-							     FIR = 1024 */
+	/* IIR setting with FIR=1024 (MLX90614) or FIR=65536 (MLX90615) */
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		ret = mlx90614_power_get(data, false);
 		if (ret < 0)
 			return ret;
@@ -666,14 +678,43 @@ static const struct mlx_chip_info mlx90614_chip_info = {
 	},
 };
 
+static const struct mlx_chip_info mlx90615_chip_info = {
+	.op_eeprom_emissivity		= MLX90615_OP_EEPROM | 0x03,
+	.op_eeprom_config1		= MLX90615_OP_EEPROM | 0x02,
+	.op_ram_ta			= MLX90615_OP_RAM | 0x06,
+	.op_ram_tobj1			= MLX90615_OP_RAM | 0x07,
+	.op_ram_tobj2			= MLX90615_OP_RAM | 0x08,
+	.op_sleep			= MLX90615_OP_SLEEP,
+	.dual_channel			= false,
+	.wakeup_delay_ms		= MLX90615_TIMING_WAKEUP,
+	.emissivity_max			= 16383,
+	.emissivity_res			= 1000000000 / 16383,
+	.fir_config_mask		= 0,	/* MLX90615 FIR is fixed */
+	.iir_config_mask		= MLX90615_CONFIG_IIR_MASK,
+	/* IIR value 0 is FORBIDDEN COMBINATION on MLX90615 */
+	.iir_valid_offset		= 1,
+	.iir_values			= { 723, 77, 42, 31, 28, 20, 18 },
+	.iir_freqs			= {
+		{ 0, 180000 },	/* 14% ~= 0.18 Hz */
+		{ 0, 200000 },	/* 17% ~= 0.20 Hz */
+		{ 0, 280000 },	/* 20% ~= 0.28 Hz */
+		{ 0, 310000 },	/* 25% ~= 0.31 Hz */
+		{ 0, 420000 },	/* 33% ~= 0.42 Hz */
+		{ 0, 770000 },	/* 50% ~= 0.77 Hz */
+		{ 7, 230000 },	/* 100% ~= 7.23 Hz */
+	},
+};
+
 static const struct i2c_device_id mlx90614_id[] = {
 	{ "mlx90614", .driver_data = (kernel_ulong_t)&mlx90614_chip_info },
+	{ "mlx90615", .driver_data = (kernel_ulong_t)&mlx90615_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mlx90614_id);
 
 static const struct of_device_id mlx90614_of_match[] = {
 	{ .compatible = "melexis,mlx90614", .data = &mlx90614_chip_info },
+	{ .compatible = "melexis,mlx90615", .data = &mlx90615_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mlx90614_of_match);
-- 
2.39.2

