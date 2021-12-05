Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9878468D2C
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 21:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238493AbhLEUZk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 15:25:40 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38536 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238388AbhLEUZj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 15:25:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5BC56114B
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 20:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5C6C00446;
        Sun,  5 Dec 2021 20:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638735731;
        bh=N3TBDHapqgjafH4k+vkzsbglLQApCnMO8ew+GoLd6N4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bJ4kDJAssbfU61yZuDQSWJnJB1AhDNahSGSv4bzDrHpJ/GXOUagimm/Dx49q67jwI
         G+fdVEMGjHA7czYkK+BHnFXOwvCtHvEG4Nwu67fADGfTKpTJKtQ3eMahvaWDD1sBXB
         hwXnePd70lvqQg8JuAoMd81CFRxR6n7OLCaAJOdADJEJ/5soihaz4hi5sVG/kUaXv4
         qC48celbzH9jNEEEn7cyxp/9sX3dJlapvWXCyXe4SSV5fRovWwr6IUX3pW147s6N2w
         DJgMC3SCVfRvJBajz5hOtyxg0+j4/hY7LVxQXP0VWkWSri1VJL/jFeNl0ck4KcFew9
         l4RprR1ldiFIw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>
Cc:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 02/17] staging:iio:adc:ad7280a: Register define cleanup.
Date:   Sun,  5 Dec 2021 20:26:55 +0000
Message-Id: <20211205202710.2847005-3-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205202710.2847005-1-jic23@kernel.org>
References: <20211205202710.2847005-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

1. Postfix register addresses with _REG to distinguish them from
   fields within the registers
2. Switch to using FIELD_PREP and masks to aid readability.
3. Shorten a few defines to make the lines remain a sensible length.
4. Fix an issue whether where an CTRL_LB field is set in CTRL_HB.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/adc/ad7280a.c | 299 ++++++++++++++++--------------
 1 file changed, 161 insertions(+), 138 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 20183b2ea127..d169c8a7b5f1 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/spi/spi.h>
+#include <linux/bitfield.h>
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
@@ -23,78 +24,86 @@
 #include "ad7280a.h"
 
 /* Registers */
-#define AD7280A_CELL_VOLTAGE_1		0x0  /* D11 to D0, Read only */
-#define AD7280A_CELL_VOLTAGE_2		0x1  /* D11 to D0, Read only */
-#define AD7280A_CELL_VOLTAGE_3		0x2  /* D11 to D0, Read only */
-#define AD7280A_CELL_VOLTAGE_4		0x3  /* D11 to D0, Read only */
-#define AD7280A_CELL_VOLTAGE_5		0x4  /* D11 to D0, Read only */
-#define AD7280A_CELL_VOLTAGE_6		0x5  /* D11 to D0, Read only */
-#define AD7280A_AUX_ADC_1		0x6  /* D11 to D0, Read only */
-#define AD7280A_AUX_ADC_2		0x7  /* D11 to D0, Read only */
-#define AD7280A_AUX_ADC_3		0x8  /* D11 to D0, Read only */
-#define AD7280A_AUX_ADC_4		0x9  /* D11 to D0, Read only */
-#define AD7280A_AUX_ADC_5		0xA  /* D11 to D0, Read only */
-#define AD7280A_AUX_ADC_6		0xB  /* D11 to D0, Read only */
-#define AD7280A_SELF_TEST		0xC  /* D11 to D0, Read only */
-#define AD7280A_CONTROL_HB		0xD  /* D15 to D8, Read/write */
-#define AD7280A_CONTROL_LB		0xE  /* D7 to D0, Read/write */
-#define AD7280A_CELL_OVERVOLTAGE	0xF  /* D7 to D0, Read/write */
-#define AD7280A_CELL_UNDERVOLTAGE	0x10 /* D7 to D0, Read/write */
-#define AD7280A_AUX_ADC_OVERVOLTAGE	0x11 /* D7 to D0, Read/write */
-#define AD7280A_AUX_ADC_UNDERVOLTAGE	0x12 /* D7 to D0, Read/write */
-#define AD7280A_ALERT			0x13 /* D7 to D0, Read/write */
-#define AD7280A_CELL_BALANCE		0x14 /* D7 to D0, Read/write */
-#define AD7280A_CB1_TIMER		0x15 /* D7 to D0, Read/write */
-#define AD7280A_CB2_TIMER		0x16 /* D7 to D0, Read/write */
-#define AD7280A_CB3_TIMER		0x17 /* D7 to D0, Read/write */
-#define AD7280A_CB4_TIMER		0x18 /* D7 to D0, Read/write */
-#define AD7280A_CB5_TIMER		0x19 /* D7 to D0, Read/write */
-#define AD7280A_CB6_TIMER		0x1A /* D7 to D0, Read/write */
-#define AD7280A_PD_TIMER		0x1B /* D7 to D0, Read/write */
-#define AD7280A_READ			0x1C /* D7 to D0, Read/write */
-#define AD7280A_CNVST_CONTROL		0x1D /* D7 to D0, Read/write */
-
-/* Bits and Masks */
-#define AD7280A_CTRL_HB_CONV_INPUT_ALL			0
-#define AD7280A_CTRL_HB_CONV_INPUT_6CELL_AUX1_3_4	BIT(6)
-#define AD7280A_CTRL_HB_CONV_INPUT_6CELL		BIT(7)
-#define AD7280A_CTRL_HB_CONV_INPUT_SELF_TEST		(BIT(7) | BIT(6))
-#define AD7280A_CTRL_HB_CONV_RES_READ_ALL		0
-#define AD7280A_CTRL_HB_CONV_RES_READ_6CELL_AUX1_3_4	BIT(4)
-#define AD7280A_CTRL_HB_CONV_RES_READ_6CELL		BIT(5)
-#define AD7280A_CTRL_HB_CONV_RES_READ_NO		(BIT(5) | BIT(4))
-#define AD7280A_CTRL_HB_CONV_START_CNVST		0
-#define AD7280A_CTRL_HB_CONV_START_CS			BIT(3)
-#define AD7280A_CTRL_HB_CONV_AVG_DIS			0
-#define AD7280A_CTRL_HB_CONV_AVG_2			BIT(1)
-#define AD7280A_CTRL_HB_CONV_AVG_4			BIT(2)
-#define AD7280A_CTRL_HB_CONV_AVG_8			(BIT(2) | BIT(1))
-#define AD7280A_CTRL_HB_CONV_AVG(x)			((x) << 1)
-#define AD7280A_CTRL_HB_PWRDN_SW			BIT(0)
-
-#define AD7280A_CTRL_LB_SWRST				BIT(7)
-#define AD7280A_CTRL_LB_ACQ_TIME_400ns			0
-#define AD7280A_CTRL_LB_ACQ_TIME_800ns			BIT(5)
-#define AD7280A_CTRL_LB_ACQ_TIME_1200ns			BIT(6)
-#define AD7280A_CTRL_LB_ACQ_TIME_1600ns			(BIT(6) | BIT(5))
-#define AD7280A_CTRL_LB_ACQ_TIME(x)			((x) << 5)
-#define AD7280A_CTRL_LB_MUST_SET			BIT(4)
-#define AD7280A_CTRL_LB_THERMISTOR_EN			BIT(3)
-#define AD7280A_CTRL_LB_LOCK_DEV_ADDR			BIT(2)
-#define AD7280A_CTRL_LB_INC_DEV_ADDR			BIT(1)
-#define AD7280A_CTRL_LB_DAISY_CHAIN_RB_EN		BIT(0)
-
-#define AD7280A_ALERT_GEN_STATIC_HIGH			BIT(6)
-#define AD7280A_ALERT_RELAY_SIG_CHAIN_DOWN		(BIT(7) | BIT(6))
 
+#define AD7280A_CELL_VOLTAGE_1_REG		0x0  /* D11 to D0, Read only */
+#define AD7280A_CELL_VOLTAGE_2_REG		0x1  /* D11 to D0, Read only */
+#define AD7280A_CELL_VOLTAGE_3_REG		0x2  /* D11 to D0, Read only */
+#define AD7280A_CELL_VOLTAGE_4_REG		0x3  /* D11 to D0, Read only */
+#define AD7280A_CELL_VOLTAGE_5_REG		0x4  /* D11 to D0, Read only */
+#define AD7280A_CELL_VOLTAGE_6_REG		0x5  /* D11 to D0, Read only */
+#define AD7280A_AUX_ADC_1_REG			0x6  /* D11 to D0, Read only */
+#define AD7280A_AUX_ADC_2_REG			0x7  /* D11 to D0, Read only */
+#define AD7280A_AUX_ADC_3_REG			0x8  /* D11 to D0, Read only */
+#define AD7280A_AUX_ADC_4_REG			0x9  /* D11 to D0, Read only */
+#define AD7280A_AUX_ADC_5_REG			0xA  /* D11 to D0, Read only */
+#define AD7280A_AUX_ADC_6_REG			0xB  /* D11 to D0, Read only */
+#define AD7280A_SELF_TEST_REG			0xC  /* D11 to D0, Read only */
+
+#define AD7280A_CTRL_HB_REG			0xD  /* D15 to D8, Read/write */
+#define   AD7280A_CTRL_HB_CONV_INPUT_MSK		GENMASK(7, 6)
+#define     AD7280A_CTRL_HB_CONV_INPUT_ALL			0
+#define     AD7280A_CTRL_HB_CONV_INPUT_6CELL_AUX1_3_4		1
+#define     AD7280A_CTRL_HB_CONV_INPUT_6CELL			2
+#define     AD7280A_CTRL_HB_CONV_INPUT_SELF_TEST		3
+#define   AD7280A_CTRL_HB_CONV_RREAD_MSK		GENMASK(5, 4)
+#define     AD7280A_CTRL_HB_CONV_RREAD_ALL			0
+#define     AD7280A_CTRL_HB_CONV_RREAD_6CELL_AUX1_3_4		1
+#define     AD7280A_CTRL_HB_CONV_RREAD_6CELL			2
+#define     AD7280A_CTRL_HB_CONV_RREAD_NO		        3
+#define   AD7280A_CTRL_HB_CONV_START_MSK		BIT(3)
+#define     AD7280A_CTRL_HB_CONV_START_CNVST			0
+#define     AD7280A_CTRL_HB_CONV_START_CS			1
+#define   AD7280A_CTRL_HB_CONV_AVG_MSK			GENMASK(2, 1)
+#define     AD7280A_CTRL_HB_CONV_AVG_DIS			0
+#define     AD7280A_CTRL_HB_CONV_AVG_2				1
+#define     AD7280A_CTRL_HB_CONV_AVG_4			        2
+#define     AD7280A_CTRL_HB_CONV_AVG_8			        3
+#define   AD7280A_CTRL_HB_PWRDN_SW			BIT(0)
+
+#define AD7280A_CTRL_LB_REG			0xE  /* D7 to D0, Read/write */
+#define   AD7280A_CTRL_LB_SWRST_MSK			BIT(7)
+#define   AD7280A_CTRL_LB_ACQ_TIME_MSK			GENMASK(6, 5)
+#define     AD7280A_CTRL_LB_ACQ_TIME_400ns			0
+#define     AD7280A_CTRL_LB_ACQ_TIME_800ns			1
+#define     AD7280A_CTRL_LB_ACQ_TIME_1200ns			2
+#define     AD7280A_CTRL_LB_ACQ_TIME_1600ns			3
+#define   AD7280A_CTRL_LB_MUST_SET			BIT(4)
+#define   AD7280A_CTRL_LB_THERMISTOR_MSK		BIT(3)
+#define   AD7280A_CTRL_LB_LOCK_DEV_ADDR_MSK		BIT(2)
+#define   AD7280A_CTRL_LB_INC_DEV_ADDR_MSK		BIT(1)
+#define   AD7280A_CTRL_LB_DAISY_CHAIN_RB_MSK		BIT(0)
+
+#define AD7280A_CELL_OVERVOLTAGE_REG		0xF  /* D7 to D0, Read/write */
+#define AD7280A_CELL_UNDERVOLTAGE_REG		0x10 /* D7 to D0, Read/write */
+#define AD7280A_AUX_ADC_OVERVOLTAGE_REG		0x11 /* D7 to D0, Read/write */
+#define AD7280A_AUX_ADC_UNDERVOLTAGE_REG	0x12 /* D7 to D0, Read/write */
+
+#define AD7280A_ALERT_REG			0x13 /* D7 to D0, Read/write */
+#define   AD7280A_ALERT_GEN_STATIC_HIGH			BIT(6)
+#define   AD7280A_ALERT_RELAY_SIG_CHAIN_DOWN		(BIT(7) | BIT(6))
+
+#define AD7280A_CELL_BALANCE_REG		0x14 /* D7 to D0, Read/write */
+#define AD7280A_CB1_TIMER_REG			0x15 /* D7 to D0, Read/write */
+#define  AD7280A_CB_TIMER_VAL_MSK			GENMASK(7, 3)
+#define AD7280A_CB2_TIMER_REG			0x16 /* D7 to D0, Read/write */
+#define AD7280A_CB3_TIMER_REG			0x17 /* D7 to D0, Read/write */
+#define AD7280A_CB4_TIMER_REG			0x18 /* D7 to D0, Read/write */
+#define AD7280A_CB5_TIMER_REG			0x19 /* D7 to D0, Read/write */
+#define AD7280A_CB6_TIMER_REG			0x1A /* D7 to D0, Read/write */
+#define AD7280A_PD_TIMER_REG			0x1B /* D7 to D0, Read/write */
+#define AD7280A_READ_REG			0x1C /* D7 to D0, Read/write */
+#define   AD7280A_READ_ADDR_MSK				GENMASK(7, 2)
+#define AD7280A_CNVST_CTRL_REG			0x1D /* D7 to D0, Read/write */
+
+/* Magic value used to indicate this special case */
 #define AD7280A_ALL_CELLS				(0xAD << 16)
 
 #define AD7280A_MAX_SPI_CLK_HZ		700000 /* < 1MHz */
 #define AD7280A_MAX_CHAIN		8
 #define AD7280A_CELLS_PER_DEV		6
 #define AD7280A_BITS			12
-#define AD7280A_NUM_CH			(AD7280A_AUX_ADC_6 - \
-					AD7280A_CELL_VOLTAGE_1 + 1)
+#define AD7280A_NUM_CH			(AD7280A_AUX_ADC_6_REG - \
+					AD7280A_CELL_VOLTAGE_1_REG + 1)
 
 #define AD7280A_CALC_VOLTAGE_CHAN_NUM(d, c) (((d) * AD7280A_CELLS_PER_DEV) + \
 					     (c))
@@ -222,23 +231,28 @@ static int ad7280_read(struct ad7280_state *st, unsigned int devaddr,
 	unsigned int tmp;
 
 	/* turns off the read operation on all parts */
-	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CONTROL_HB, 1,
-			   AD7280A_CTRL_HB_CONV_INPUT_ALL |
-			   AD7280A_CTRL_HB_CONV_RES_READ_NO |
+	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CTRL_HB_REG, 1,
+			   FIELD_PREP(AD7280A_CTRL_HB_CONV_INPUT_MSK,
+				      AD7280A_CTRL_HB_CONV_INPUT_ALL) |
+			   FIELD_PREP(AD7280A_CTRL_HB_CONV_RREAD_MSK,
+				      AD7280A_CTRL_HB_CONV_RREAD_NO) |
 			   st->ctrl_hb);
 	if (ret)
 		return ret;
 
 	/* turns on the read operation on the addressed part */
-	ret = ad7280_write(st, devaddr, AD7280A_CONTROL_HB, 0,
-			   AD7280A_CTRL_HB_CONV_INPUT_ALL |
-			   AD7280A_CTRL_HB_CONV_RES_READ_ALL |
+	ret = ad7280_write(st, devaddr, AD7280A_CTRL_HB_REG, 0,
+			   FIELD_PREP(AD7280A_CTRL_HB_CONV_INPUT_MSK,
+				      AD7280A_CTRL_HB_CONV_INPUT_ALL) |
+			   FIELD_PREP(AD7280A_CTRL_HB_CONV_RREAD_MSK,
+				      AD7280A_CTRL_HB_CONV_RREAD_ALL) |
 			   st->ctrl_hb);
 	if (ret)
 		return ret;
 
 	/* Set register address on the part to be read from */
-	ret = ad7280_write(st, devaddr, AD7280A_READ, 0, addr << 2);
+	ret = ad7280_write(st, devaddr, AD7280A_READ_REG, 0,
+			   FIELD_PREP(AD7280A_READ_ADDR_MSK, addr));
 	if (ret)
 		return ret;
 
@@ -261,21 +275,27 @@ static int ad7280_read_channel(struct ad7280_state *st, unsigned int devaddr,
 	int ret;
 	unsigned int tmp;
 
-	ret = ad7280_write(st, devaddr, AD7280A_READ, 0, addr << 2);
+	ret = ad7280_write(st, devaddr, AD7280A_READ_REG, 0,
+			   FIELD_PREP(AD7280A_READ_ADDR_MSK, addr));
 	if (ret)
 		return ret;
 
-	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CONTROL_HB, 1,
-			   AD7280A_CTRL_HB_CONV_INPUT_ALL |
-			   AD7280A_CTRL_HB_CONV_RES_READ_NO |
+	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CTRL_HB_REG, 1,
+			   FIELD_PREP(AD7280A_CTRL_HB_CONV_INPUT_MSK,
+				      AD7280A_CTRL_HB_CONV_INPUT_ALL) |
+			   FIELD_PREP(AD7280A_CTRL_HB_CONV_RREAD_MSK,
+				      AD7280A_CTRL_HB_CONV_RREAD_NO) |
 			   st->ctrl_hb);
 	if (ret)
 		return ret;
 
-	ret = ad7280_write(st, devaddr, AD7280A_CONTROL_HB, 0,
-			   AD7280A_CTRL_HB_CONV_INPUT_ALL |
-			   AD7280A_CTRL_HB_CONV_RES_READ_ALL |
-			   AD7280A_CTRL_HB_CONV_START_CS |
+	ret = ad7280_write(st, devaddr, AD7280A_CTRL_HB_REG, 0,
+			   FIELD_PREP(AD7280A_CTRL_HB_CONV_INPUT_MSK,
+				      AD7280A_CTRL_HB_CONV_INPUT_ALL) |
+			   FIELD_PREP(AD7280A_CTRL_HB_CONV_RREAD_MSK,
+				      AD7280A_CTRL_HB_CONV_RREAD_ALL) |
+			   FIELD_PREP(AD7280A_CTRL_HB_CONV_START_MSK,
+				      AD7280A_CTRL_HB_CONV_START_CS) |
 			   st->ctrl_hb);
 	if (ret)
 		return ret;
@@ -301,15 +321,18 @@ static int ad7280_read_all_channels(struct ad7280_state *st, unsigned int cnt,
 	int i, ret;
 	unsigned int tmp, sum = 0;
 
-	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_READ, 1,
-			   AD7280A_CELL_VOLTAGE_1 << 2);
+	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_READ_REG, 1,
+			   AD7280A_CELL_VOLTAGE_1_REG << 2);
 	if (ret)
 		return ret;
 
-	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CONTROL_HB, 1,
-			   AD7280A_CTRL_HB_CONV_INPUT_ALL |
-			   AD7280A_CTRL_HB_CONV_RES_READ_ALL |
-			   AD7280A_CTRL_HB_CONV_START_CS |
+	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CTRL_HB_REG, 1,
+			   FIELD_PREP(AD7280A_CTRL_HB_CONV_INPUT_MSK,
+				      AD7280A_CTRL_HB_CONV_INPUT_ALL) |
+			   FIELD_PREP(AD7280A_CTRL_HB_CONV_RREAD_MSK,
+				      AD7280A_CTRL_HB_CONV_RREAD_ALL) |
+			   FIELD_PREP(AD7280A_CTRL_HB_CONV_START_MSK,
+				      AD7280A_CTRL_HB_CONV_START_CS) |
 			   st->ctrl_hb);
 	if (ret)
 		return ret;
@@ -327,7 +350,7 @@ static int ad7280_read_all_channels(struct ad7280_state *st, unsigned int cnt,
 		if (array)
 			array[i] = tmp;
 		/* only sum cell voltages */
-		if (((tmp >> 23) & 0xF) <= AD7280A_CELL_VOLTAGE_6)
+		if (((tmp >> 23) & 0xF) <= AD7280A_CELL_VOLTAGE_6_REG)
 			sum += ((tmp >> 11) & 0xFFF);
 	}
 
@@ -338,7 +361,7 @@ static void ad7280_sw_power_down(void *data)
 {
 	struct ad7280_state *st = data;
 
-	ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CONTROL_HB, 1,
+	ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CTRL_HB_REG, 1,
 		     AD7280A_CTRL_HB_PWRDN_SW | st->ctrl_hb);
 }
 
@@ -347,25 +370,26 @@ static int ad7280_chain_setup(struct ad7280_state *st)
 	unsigned int val, n;
 	int ret;
 
-	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CONTROL_LB, 1,
-			   AD7280A_CTRL_LB_DAISY_CHAIN_RB_EN |
-			   AD7280A_CTRL_LB_LOCK_DEV_ADDR |
+	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CTRL_LB_REG, 1,
+			   FIELD_PREP(AD7280A_CTRL_LB_DAISY_CHAIN_RB_MSK, 1) |
+			   FIELD_PREP(AD7280A_CTRL_LB_LOCK_DEV_ADDR_MSK, 1) |
 			   AD7280A_CTRL_LB_MUST_SET |
-			   AD7280A_CTRL_LB_SWRST |
+			   FIELD_PREP(AD7280A_CTRL_LB_SWRST_MSK, 1) |
 			   st->ctrl_lb);
 	if (ret)
 		return ret;
 
-	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CONTROL_LB, 1,
-			   AD7280A_CTRL_LB_DAISY_CHAIN_RB_EN |
-			   AD7280A_CTRL_LB_LOCK_DEV_ADDR |
+	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CTRL_LB_REG, 1,
+			   FIELD_PREP(AD7280A_CTRL_LB_DAISY_CHAIN_RB_MSK, 1) |
+			   FIELD_PREP(AD7280A_CTRL_LB_LOCK_DEV_ADDR_MSK, 1) |
 			   AD7280A_CTRL_LB_MUST_SET |
+			   FIELD_PREP(AD7280A_CTRL_LB_SWRST_MSK, 0) |
 			   st->ctrl_lb);
 	if (ret)
 		goto error_power_down;
 
-	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_READ, 1,
-			   AD7280A_CONTROL_LB << 2);
+	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_READ_REG, 1,
+			   FIELD_PREP(AD7280A_READ_ADDR_MSK, AD7280A_CTRL_LB_REG));
 	if (ret)
 		goto error_power_down;
 
@@ -390,7 +414,7 @@ static int ad7280_chain_setup(struct ad7280_state *st)
 	ret = -EFAULT;
 
 error_power_down:
-	ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CONTROL_HB, 1,
+	ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CTRL_HB_REG, 1,
 		     AD7280A_CTRL_HB_PWRDN_SW | st->ctrl_hb);
 
 	return ret;
@@ -434,7 +458,7 @@ static ssize_t ad7280_store_balance_sw(struct device *dev,
 	else
 		st->cb_mask[devaddr] &= ~(1 << (ch + 2));
 
-	ret = ad7280_write(st, devaddr, AD7280A_CELL_BALANCE,
+	ret = ad7280_write(st, devaddr, AD7280A_CELL_BALANCE_REG,
 			   0, st->cb_mask[devaddr]);
 	mutex_unlock(&st->lock);
 
@@ -459,7 +483,7 @@ static ssize_t ad7280_show_balance_timer(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	msecs = (ret >> 3) * 71500;
+	msecs = FIELD_GET(AD7280A_CB_TIMER_VAL_MSK, ret) * 71500;
 
 	return sprintf(buf, "%u\n", msecs);
 }
@@ -486,8 +510,8 @@ static ssize_t ad7280_store_balance_timer(struct device *dev,
 
 	mutex_lock(&st->lock);
 	ret = ad7280_write(st, this_attr->address >> 8,
-			   this_attr->address & 0xFF,
-			   0, (val & 0x1F) << 3);
+			   this_attr->address & 0xFF, 0,
+			   FIELD_PREP(AD7280A_CB_TIMER_VAL_MSK, val));
 	mutex_unlock(&st->lock);
 
 	return ret ? ret : len;
@@ -559,10 +583,10 @@ static void ad7280_init_dev_channels(struct ad7280_state *st, int dev, int *cnt)
 	int addr, ch, i;
 	struct iio_chan_spec *chan;
 
-	for (ch = AD7280A_CELL_VOLTAGE_1; ch <= AD7280A_AUX_ADC_6; ch++) {
+	for (ch = AD7280A_CELL_VOLTAGE_1_REG; ch <= AD7280A_AUX_ADC_6_REG; ch++) {
 		chan = &st->channels[*cnt];
 
-		if (ch < AD7280A_AUX_ADC_1) {
+		if (ch < AD7280A_AUX_ADC_1_REG) {
 			i = AD7280A_CALC_VOLTAGE_CHAN_NUM(dev, ch);
 			ad7280_voltage_channel_init(chan, i);
 		} else {
@@ -634,7 +658,7 @@ static int ad7280_init_dev_attrs(struct ad7280_state *st, int dev, int *cnt)
 	struct iio_dev_attr *iio_attr;
 	struct device *sdev = &st->spi->dev;
 
-	for (ch = AD7280A_CELL_VOLTAGE_1; ch <= AD7280A_CELL_VOLTAGE_6; ch++) {
+	for (ch = AD7280A_CELL_VOLTAGE_1_REG; ch <= AD7280A_CELL_VOLTAGE_6_REG; ch++) {
 		iio_attr = &st->iio_attr[*cnt];
 		addr = ad7280a_devaddr(dev) << 8 | ch;
 		i = dev * AD7280A_CELLS_PER_DEV + ch;
@@ -647,7 +671,7 @@ static int ad7280_init_dev_attrs(struct ad7280_state *st, int dev, int *cnt)
 
 		(*cnt)++;
 		iio_attr = &st->iio_attr[*cnt];
-		addr = ad7280a_devaddr(dev) << 8 | (AD7280A_CB1_TIMER + ch);
+		addr = ad7280a_devaddr(dev) << 8 | (AD7280A_CB1_TIMER_REG + ch);
 
 		ret = ad7280_balance_timer_attr_init(iio_attr, sdev, addr, i);
 		if (ret < 0)
@@ -691,16 +715,16 @@ static ssize_t ad7280_read_channel_config(struct device *dev,
 	unsigned int val;
 
 	switch (this_attr->address) {
-	case AD7280A_CELL_OVERVOLTAGE:
+	case AD7280A_CELL_OVERVOLTAGE_REG:
 		val = 1000 + (st->cell_threshhigh * 1568) / 100;
 		break;
-	case AD7280A_CELL_UNDERVOLTAGE:
+	case AD7280A_CELL_UNDERVOLTAGE_REG:
 		val = 1000 + (st->cell_threshlow * 1568) / 100;
 		break;
-	case AD7280A_AUX_ADC_OVERVOLTAGE:
+	case AD7280A_AUX_ADC_OVERVOLTAGE_REG:
 		val = (st->aux_threshhigh * 196) / 10;
 		break;
-	case AD7280A_AUX_ADC_UNDERVOLTAGE:
+	case AD7280A_AUX_ADC_UNDERVOLTAGE_REG:
 		val = (st->aux_threshlow * 196) / 10;
 		break;
 	default:
@@ -727,12 +751,12 @@ static ssize_t ad7280_write_channel_config(struct device *dev,
 		return ret;
 
 	switch (this_attr->address) {
-	case AD7280A_CELL_OVERVOLTAGE:
-	case AD7280A_CELL_UNDERVOLTAGE:
+	case AD7280A_CELL_OVERVOLTAGE_REG:
+	case AD7280A_CELL_UNDERVOLTAGE_REG:
 		val = ((val - 1000) * 100) / 1568; /* LSB 15.68mV */
 		break;
-	case AD7280A_AUX_ADC_OVERVOLTAGE:
-	case AD7280A_AUX_ADC_UNDERVOLTAGE:
+	case AD7280A_AUX_ADC_OVERVOLTAGE_REG:
+	case AD7280A_AUX_ADC_UNDERVOLTAGE_REG:
 		val = (val * 10) / 196; /* LSB 19.6mV */
 		break;
 	default:
@@ -743,16 +767,16 @@ static ssize_t ad7280_write_channel_config(struct device *dev,
 
 	mutex_lock(&st->lock);
 	switch (this_attr->address) {
-	case AD7280A_CELL_OVERVOLTAGE:
+	case AD7280A_CELL_OVERVOLTAGE_REG:
 		st->cell_threshhigh = val;
 		break;
-	case AD7280A_CELL_UNDERVOLTAGE:
+	case AD7280A_CELL_UNDERVOLTAGE_REG:
 		st->cell_threshlow = val;
 		break;
-	case AD7280A_AUX_ADC_OVERVOLTAGE:
+	case AD7280A_AUX_ADC_OVERVOLTAGE_REG:
 		st->aux_threshhigh = val;
 		break;
-	case AD7280A_AUX_ADC_UNDERVOLTAGE:
+	case AD7280A_AUX_ADC_UNDERVOLTAGE_REG:
 		st->aux_threshlow = val;
 		break;
 	}
@@ -781,17 +805,19 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 		goto out;
 
 	for (i = 0; i < st->scan_cnt; i++) {
-		if (((channels[i] >> 23) & 0xF) <= AD7280A_CELL_VOLTAGE_6) {
-			if (((channels[i] >> 11) & 0xFFF) >=
-			    st->cell_threshhigh) {
+		unsigned int val;
+
+		val = FIELD_GET(AD7280A_TRANS_READ_CONV_DATA_MSK, channels[i]);
+		if (FIELD_GET(AD7280A_TRANS_READ_CONV_CHANADDR_MSK, channels[i])
+			<= AD7280A_CELL_VOLTAGE_6_REG) {
+			if (val >= st->cell_threshhigh) {
 				u64 tmp = IIO_EVENT_CODE(IIO_VOLTAGE, 1, 0,
 							 IIO_EV_DIR_RISING,
 							 IIO_EV_TYPE_THRESH,
 							 0, 0, 0);
 				iio_push_event(indio_dev, tmp,
 					       iio_get_time_ns(indio_dev));
-			} else if (((channels[i] >> 11) & 0xFFF) <=
-				   st->cell_threshlow) {
+			} else if (val <= st->cell_threshlow) {
 				u64 tmp = IIO_EVENT_CODE(IIO_VOLTAGE, 1, 0,
 							 IIO_EV_DIR_FALLING,
 							 IIO_EV_TYPE_THRESH,
@@ -800,15 +826,13 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 					       iio_get_time_ns(indio_dev));
 			}
 		} else {
-			if (((channels[i] >> 11) & 0xFFF) >=
-			    st->aux_threshhigh) {
+			if (val >= st->aux_threshhigh) {
 				u64 tmp = IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
 							IIO_EV_TYPE_THRESH,
 							IIO_EV_DIR_RISING);
 				iio_push_event(indio_dev, tmp,
 					       iio_get_time_ns(indio_dev));
-			} else if (((channels[i] >> 11) & 0xFFF) <=
-				st->aux_threshlow) {
+			} else if (val <= st->aux_threshlow) {
 				u64 tmp = IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
 							IIO_EV_TYPE_THRESH,
 							IIO_EV_DIR_FALLING);
@@ -833,26 +857,26 @@ static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
 			     0644,
 			     ad7280_read_channel_config,
 			     ad7280_write_channel_config,
-			     AD7280A_CELL_UNDERVOLTAGE);
+			     AD7280A_CELL_UNDERVOLTAGE_REG);
 
 static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
 			     in_voltage-voltage_thresh_high_value,
 			     0644,
 			     ad7280_read_channel_config,
 			     ad7280_write_channel_config,
-			     AD7280A_CELL_OVERVOLTAGE);
+			     AD7280A_CELL_OVERVOLTAGE_REG);
 
 static IIO_DEVICE_ATTR(in_temp_thresh_low_value,
 		       0644,
 		       ad7280_read_channel_config,
 		       ad7280_write_channel_config,
-		       AD7280A_AUX_ADC_UNDERVOLTAGE);
+		       AD7280A_AUX_ADC_UNDERVOLTAGE_REG);
 
 static IIO_DEVICE_ATTR(in_temp_thresh_high_value,
 		       0644,
 		       ad7280_read_channel_config,
 		       ad7280_write_channel_config,
-		       AD7280A_AUX_ADC_OVERVOLTAGE);
+		       AD7280A_AUX_ADC_OVERVOLTAGE_REG);
 
 static struct attribute *ad7280_event_attributes[] = {
 	&iio_dev_attr_in_thresh_low_value.dev_attr.attr,
@@ -892,7 +916,7 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		if ((chan->address & 0xFF) <= AD7280A_CELL_VOLTAGE_6)
+		if ((chan->address & 0xFF) <= AD7280A_CELL_VOLTAGE_6_REG)
 			*val = 4000;
 		else
 			*val = 5000;
@@ -942,10 +966,9 @@ static int ad7280_probe(struct spi_device *spi)
 	st->spi->mode = SPI_MODE_1;
 	spi_setup(st->spi);
 
-	st->ctrl_lb = AD7280A_CTRL_LB_ACQ_TIME(pdata->acquisition_time & 0x3);
-	st->ctrl_hb = AD7280A_CTRL_HB_CONV_AVG(pdata->conversion_averaging
-			& 0x3) | (pdata->thermistor_term_en ?
-			AD7280A_CTRL_LB_THERMISTOR_EN : 0);
+	st->ctrl_lb = FIELD_PREP(AD7280A_CTRL_LB_ACQ_TIME_MSK, pdata->acquisition_time) |
+		FIELD_PREP(AD7280A_CTRL_LB_THERMISTOR_MSK, pdata->thermistor_term_en);
+	st->ctrl_hb = FIELD_PREP(AD7280A_CTRL_HB_CONV_AVG_MSK, pdata->conversion_averaging);
 
 	ret = ad7280_chain_setup(st);
 	if (ret < 0)
@@ -998,13 +1021,13 @@ static int ad7280_probe(struct spi_device *spi)
 
 	if (spi->irq > 0) {
 		ret = ad7280_write(st, AD7280A_DEVADDR_MASTER,
-				   AD7280A_ALERT, 1,
+				   AD7280A_ALERT_REG, 1,
 				   AD7280A_ALERT_RELAY_SIG_CHAIN_DOWN);
 		if (ret)
 			return ret;
 
 		ret = ad7280_write(st, ad7280a_devaddr(st->slave_num),
-				   AD7280A_ALERT, 0,
+				   AD7280A_ALERT_REG, 0,
 				   AD7280A_ALERT_GEN_STATIC_HIGH |
 				   (pdata->chain_last_alert_ignore & 0xF));
 		if (ret)
-- 
2.34.1

