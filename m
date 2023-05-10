Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D97E6FDB97
	for <lists+linux-iio@lfdr.de>; Wed, 10 May 2023 12:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236603AbjEJKXl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 May 2023 06:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236605AbjEJKXf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 May 2023 06:23:35 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA4F6597;
        Wed, 10 May 2023 03:23:30 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 127D386046;
        Wed, 10 May 2023 12:23:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683714206;
        bh=V2gCP1JQKiP2Q62kgi8JEznvs51An9SWl74pIaFIAqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zg5VFE217DUswDx/AdDLVAnQ+Y9LDwJH3whsnnLhNKKpDNxLSFyun7xjiRqEE5D0c
         h7u0o5gj2MUsdfH6lJG+23xKMwWBn7ay3JqUpKnrv/H5W5Bp7z/PZceZ3QmnWUZhBQ
         jHFCBeOLPC1SIpSIw3nSYJTTzX6J/ZA54eZgaNjcXim4u2QwzAhE2XFzpJSAPCtKEr
         t+8UNDS019tlz/CuJ8514hAGaN3lE26mYhlZ6UUW662rcbQ75XvG2K5OlQ3wOmsqy/
         RGRh7arf7i1GKjeeq7hSMza6D4/pj/19qEX5iV1RcjdvhzIio8nAYae3x+IHKyTrI4
         gJ4n+5nkakmQg==
From:   Marek Vasut <marex@denx.de>
To:     linux-iio@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Crt Mori <cmo@melexis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v3 6/6] iio: mlx90614: Add MLX90615 support
Date:   Wed, 10 May 2023 12:22:51 +0200
Message-Id: <20230510102251.10118-6-marex@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230510102251.10118-1-marex@denx.de>
References: <20230510102251.10118-1-marex@denx.de>
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

The IIR filter coefficients were provided by Melexis as follows:
0b0000 - Forbidden value
0b0001 - 100% - settling time = refresh rate = 205ms (around 5Hz)
0b0010 - 50% - settling time = 2050ms (around 0.5Hz)
0b0011 - 33% - settling time = 36900ms (around 0.3Hz)
0b0100 - 25% - settling time = 5125ms (around 0.2Hz)
0b0101 - 20% - settling time = 6355ms (around 0.15Hz)
0b0110 - 17% - settling time = 7790ms (around 0.13Hz)
0b0111 - 14% - settling time = 9225ms (around 0.1Hz)

Signed-off-by: Marek Vasut <marex@denx.de>
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
V3: Drop emissivity_res, update IIR filter coefficients per Melexis input
---
 drivers/iio/temperature/mlx90614.c | 48 +++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index 3aa108a652bb4..b2affcb795e00 100644
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
@@ -305,8 +317,8 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
 			*val2 = ret * NSEC_PER_SEC / chip_info->emissivity_max;
 		}
 		return IIO_VAL_INT_PLUS_NANO;
-	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY: /* IIR setting with
-							     FIR = 1024 */
+	/* IIR setting with FIR=1024 (MLX90614) or FIR=65536 (MLX90615) */
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		ret = mlx90614_power_get(data, false);
 		if (ret < 0)
 			return ret;
@@ -664,14 +676,42 @@ static const struct mlx_chip_info mlx90614_chip_info = {
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
+	.fir_config_mask		= 0,	/* MLX90615 FIR is fixed */
+	.iir_config_mask		= MLX90615_CONFIG_IIR_MASK,
+	/* IIR value 0 is FORBIDDEN COMBINATION on MLX90615 */
+	.iir_valid_offset		= 1,
+	.iir_values			= { 500, 50, 30, 20, 15, 13, 10 },
+	.iir_freqs			= {
+		{ 0, 100000 },	/* 14% ~= 0.10 Hz */
+		{ 0, 130000 },	/* 17% ~= 0.13 Hz */
+		{ 0, 150000 },	/* 20% ~= 0.15 Hz */
+		{ 0, 200000 },	/* 25% ~= 0.20 Hz */
+		{ 0, 300000 },	/* 33% ~= 0.30 Hz */
+		{ 0, 500000 },	/* 50% ~= 0.50 Hz */
+		{ 5, 000000 },	/* 100% ~= 5.00 Hz */
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

