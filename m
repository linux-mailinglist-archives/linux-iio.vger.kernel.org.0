Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F593D4961
	for <lists+linux-iio@lfdr.de>; Sat, 24 Jul 2021 21:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhGXSZM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Jul 2021 14:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhGXSZA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Jul 2021 14:25:00 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FB3C061757;
        Sat, 24 Jul 2021 12:05:30 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n11so2753099wmd.2;
        Sat, 24 Jul 2021 12:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r4l4X9Ml9axxQp0KFzsTd5BH2EID20QmHeunm7jfaaI=;
        b=EFbKtpEYqM0JbnaWCyMfLkzsjfqn+6n7VqWYEVhYWZ/1W5/DVxhg3o2JDUl8Zv4B5U
         +RYeF229YNGBTT6REqUCSa0+KeFGYlPVdJaMXozsXgVFl5CyyEt1mCVVh+vto+9VTf8t
         QJa4+/Sv4R7SgCaI0Xzll8rlQHeBndnCiG/akrLu60rEe89PGtmbwjGACuseUPAh+Ryf
         tsbYE+6UaBvxD5WmGriGe7inXieEf34KE57VRSj26MAez9w4n7VRQhwQgQPTXopYnTPl
         6lB+SGXJEmwvjahEOgl4kpvn+GmvcaNd2NkJxo+Y7fqACiaqvfWCmP7vWItp7Td7KYxa
         WDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r4l4X9Ml9axxQp0KFzsTd5BH2EID20QmHeunm7jfaaI=;
        b=I0nGJqd6Z+DiSj14vuvRElXSIBECu2Xe2Rqdv5XhSs8cXgkSQ1fydDfxGle64TUuv5
         QowUqgTBOPsn9tTdc7ldqsP2Zp8EZYooL8ITkXbC82P5T0qiZ6MUSKjhLA9zcJmt2OXG
         3cErj/1nWdyxLlU9XLZb07BWBwCo4eocwebzVV4Nc83myBnLvILYSybBE446WgYYja/W
         qtq1YY/rTVmgeoBA0tjwo0Jvs5Sm1U0cvhBf7MportC/7MsgYrMjPo+1BCnsabKUuUcl
         NbPr/iJ3BQB+GIRV0tBCmXGy9pSBFjUN8Thazuon85SlFJ439Qp4Ns8D04QoXJqdKhzF
         tSzQ==
X-Gm-Message-State: AOAM530R5NJClGI78x2Fev9InlSZMEY0n9+vEpIXMeHVufZu1zu85KSc
        DUVNgBny8L96dOZTsB55vb0=
X-Google-Smtp-Source: ABdhPJyf2ox5QLWxNIExZYLr3mmgGNJUkVFz4luV6S7JpaNeRe7Kp9Gm/Ag1xINQHYWW1pl0n2wKXg==
X-Received: by 2002:a1c:26c4:: with SMTP id m187mr325127wmm.71.1627153529062;
        Sat, 24 Jul 2021 12:05:29 -0700 (PDT)
Received: from monk.home (astrasbourg-157-1-7-84.w90-40.abo.wanadoo.fr. [90.40.218.84])
        by smtp.gmail.com with ESMTPSA id j15sm1117798wms.20.2021.07.24.12.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 12:05:28 -0700 (PDT)
From:   Christophe Branchereau <cbranchereau@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu, paul@crapouillou.net,
        Christophe Branchereau <cbranchereau@gmail.com>
Subject: [PATCH v3 3/5] iio/adc: ingenic: add JZ4760 support to the sadc driver
Date:   Sat, 24 Jul 2021 21:04:47 +0200
Message-Id: <20210724190449.221894-4-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210724190449.221894-1-cbranchereau@gmail.com>
References: <20210724190449.221894-1-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The jz4760 sadc is very similar to the jz4770 one, but has a VREF of 2.5V
and 3 aux channels.

modify ingenic_adc_read_chan_info_raw() needs a change to account for it.

Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
---
 drivers/iio/adc/ingenic-adc.c | 82 +++++++++++++++++++++++++++++++++--
 1 file changed, 78 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index 40f2d8c2cf72..6b9af0530590 100644
--- a/drivers/iio/adc/ingenic-adc.c
+++ b/drivers/iio/adc/ingenic-adc.c
@@ -71,6 +71,7 @@
 #define JZ4725B_ADC_BATTERY_HIGH_VREF_BITS	10
 #define JZ4740_ADC_BATTERY_HIGH_VREF		(7500 * 0.986)
 #define JZ4740_ADC_BATTERY_HIGH_VREF_BITS	12
+#define JZ4760_ADC_BATTERY_VREF			2500
 #define JZ4770_ADC_BATTERY_VREF			1200
 #define JZ4770_ADC_BATTERY_VREF_BITS		12
 
@@ -295,6 +296,10 @@ static const int jz4740_adc_battery_scale_avail[] = {
 	JZ_ADC_BATTERY_LOW_VREF, JZ_ADC_BATTERY_LOW_VREF_BITS,
 };
 
+static const int jz4760_adc_battery_scale_avail[] = {
+	JZ4760_ADC_BATTERY_VREF, JZ4770_ADC_BATTERY_VREF_BITS,
+};
+
 static const int jz4770_adc_battery_raw_avail[] = {
 	0, 1, (1 << JZ4770_ADC_BATTERY_VREF_BITS) - 1,
 };
@@ -400,6 +405,47 @@ static const struct iio_chan_spec jz4740_channels[] = {
 	},
 };
 
+static const struct iio_chan_spec jz4760_channels[] = {
+	{
+		.extend_name = "aux",
+		.type = IIO_VOLTAGE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.indexed = 1,
+		.channel = INGENIC_ADC_AUX0,
+		.scan_index = -1,
+	},
+	{
+		.extend_name = "aux1",
+		.type = IIO_VOLTAGE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.indexed = 1,
+		.channel = INGENIC_ADC_AUX,
+		.scan_index = -1,
+	},
+	{
+		.extend_name = "aux2",
+		.type = IIO_VOLTAGE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.indexed = 1,
+		.channel = INGENIC_ADC_AUX2,
+		.scan_index = -1,
+	},
+	{
+		.extend_name = "battery",
+		.type = IIO_VOLTAGE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_RAW) |
+						BIT(IIO_CHAN_INFO_SCALE),
+		.indexed = 1,
+		.channel = INGENIC_ADC_BATTERY,
+		.scan_index = -1,
+	},
+};
+
 static const struct iio_chan_spec jz4770_channels[] = {
 	{
 		.type = IIO_VOLTAGE,
@@ -526,6 +572,20 @@ static const struct ingenic_adc_soc_data jz4740_adc_soc_data = {
 	.init_clk_div = NULL, /* no ADCLK register on JZ4740 */
 };
 
+static const struct ingenic_adc_soc_data jz4760_adc_soc_data = {
+	.battery_high_vref = JZ4760_ADC_BATTERY_VREF,
+	.battery_high_vref_bits = JZ4770_ADC_BATTERY_VREF_BITS,
+	.battery_raw_avail = jz4770_adc_battery_raw_avail,
+	.battery_raw_avail_size = ARRAY_SIZE(jz4770_adc_battery_raw_avail),
+	.battery_scale_avail = jz4760_adc_battery_scale_avail,
+	.battery_scale_avail_size = ARRAY_SIZE(jz4760_adc_battery_scale_avail),
+	.battery_vref_mode = false,
+	.has_aux_md = true,
+	.channels = jz4760_channels,
+	.num_channels = ARRAY_SIZE(jz4760_channels),
+	.init_clk_div = jz4770_adc_init_clk_div,
+};
+
 static const struct ingenic_adc_soc_data jz4770_adc_soc_data = {
 	.battery_high_vref = JZ4770_ADC_BATTERY_VREF,
 	.battery_high_vref_bits = JZ4770_ADC_BATTERY_VREF_BITS,
@@ -569,7 +629,7 @@ static int ingenic_adc_read_chan_info_raw(struct iio_dev *iio_dev,
 					  struct iio_chan_spec const *chan,
 					  int *val)
 {
-	int bit, ret, engine = (chan->channel == INGENIC_ADC_BATTERY);
+	int cmd, ret, engine = (chan->channel == INGENIC_ADC_BATTERY);
 	struct ingenic_adc *adc = iio_priv(iio_dev);
 
 	ret = clk_enable(adc->clk);
@@ -579,11 +639,22 @@ static int ingenic_adc_read_chan_info_raw(struct iio_dev *iio_dev,
 		return ret;
 	}
 
-	/* We cannot sample AUX/AUX2 in parallel. */
+	/* We cannot sample the aux channels in parallel. */
 	mutex_lock(&adc->aux_lock);
 	if (adc->soc_data->has_aux_md && engine == 0) {
-		bit = BIT(chan->channel == INGENIC_ADC_AUX2);
-		ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_AUX_MD, bit);
+		switch (chan->channel) {
+		case INGENIC_ADC_AUX0:
+			cmd = 0;
+			break;
+		case INGENIC_ADC_AUX:
+			cmd = 1;
+			break;
+		case INGENIC_ADC_AUX2:
+			cmd = 2;
+			break;
+		}
+
+		ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_AUX_MD, cmd);
 	}
 
 	ret = ingenic_adc_capture(adc, engine);
@@ -591,6 +662,7 @@ static int ingenic_adc_read_chan_info_raw(struct iio_dev *iio_dev,
 		goto out;
 
 	switch (chan->channel) {
+	case INGENIC_ADC_AUX0:
 	case INGENIC_ADC_AUX:
 	case INGENIC_ADC_AUX2:
 		*val = readw(adc->base + JZ_ADC_REG_ADSDAT);
@@ -621,6 +693,7 @@ static int ingenic_adc_read_raw(struct iio_dev *iio_dev,
 		return ingenic_adc_read_chan_info_raw(iio_dev, chan, val);
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->channel) {
+		case INGENIC_ADC_AUX0:
 		case INGENIC_ADC_AUX:
 		case INGENIC_ADC_AUX2:
 			*val = JZ_ADC_AUX_VREF;
@@ -832,6 +905,7 @@ static int ingenic_adc_probe(struct platform_device *pdev)
 static const struct of_device_id ingenic_adc_of_match[] = {
 	{ .compatible = "ingenic,jz4725b-adc", .data = &jz4725b_adc_soc_data, },
 	{ .compatible = "ingenic,jz4740-adc", .data = &jz4740_adc_soc_data, },
+	{ .compatible = "ingenic,jz4760-adc", .data = &jz4760_adc_soc_data, },
 	{ .compatible = "ingenic,jz4770-adc", .data = &jz4770_adc_soc_data, },
 	{ },
 };
-- 
2.30.2

