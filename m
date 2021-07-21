Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4FA3D0DD0
	for <lists+linux-iio@lfdr.de>; Wed, 21 Jul 2021 13:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238287AbhGUKx3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Jul 2021 06:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240075AbhGUKNW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Jul 2021 06:13:22 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69124C061786;
        Wed, 21 Jul 2021 03:53:36 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u1so1710140wrs.1;
        Wed, 21 Jul 2021 03:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VY/9svY8ri8J4HJB23mBSJ/+qTZUMwQ0pz41nlKr5Ho=;
        b=YWnO+USkjnO5T2m5gLAxX67ySUlO6++H2MCylJvm2p79QjAH8L51dWHjdB5aVay9kG
         JyO6dJQmu9Z1SguNUh7w+2oqP0Uxiz1XaoOaWmBk1pM9RGJMYGnS64YPoZBgKBNGhfnI
         t5IrU8t994999JKdPGzdSduTI9MSkq8PMhGJwQC0+fVBGDU3VjGFgH/3oXQW/mJzI8Gv
         ZyUCCXVwU9yMnoqU6DXigfdHsGQPFu+PQDZEfGdMgtowZFdSCoPHZehxB62LbfTLnQkP
         N2nTFlyarBGtaVZ1tAchYBJmt1VIFNGye1mxm+OlOre0PdhN3um+wYENiaUP1vL3OfFB
         w47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VY/9svY8ri8J4HJB23mBSJ/+qTZUMwQ0pz41nlKr5Ho=;
        b=XSVOfQ3Iseyr41EZnSEY9DiL+/xQIJpFH14pq/vHvskgfY0bk7vanCxg8mL6fXxzvJ
         kO1jwr1N7eattUpKHexN6JSB0u/ienTHoiUnkKm7CoLh5cBmXgefs2Qwuz+bv6Xlu+U5
         HF2XVRlbLH8vtpcPf+MDxb+K6ymQ7Di9cACWpjUzChPv2+2ud1hKpWBclEod2/onRfs7
         Rkg96LthTArilsFcZVJrwVWou/F1J/LhCX03tvxBPSVHrrRmhBJz4rgf41HwxfdoCtMv
         KixMYearZMGYf+hbfoWKOk6wbV13PwHnzhsQ7TBfrzUSqvJaf0fsj3naVnHRDrCg28j8
         UP8w==
X-Gm-Message-State: AOAM533YuHQCvuE/+va3YVC2wZViIyhCAnjJtDlrbx4kRdC84ZHQeRNH
        ojL9tTnUMnF71AN1kzanTO0=
X-Google-Smtp-Source: ABdhPJwEM7tQ+AFc/Peod8XhYAnaYCA6Afxl9x/dhxCyZk4i9BVstPwidcDJ1SLPirxcdROow7YB8w==
X-Received: by 2002:a5d:64cc:: with SMTP id f12mr16661084wri.201.1626864814868;
        Wed, 21 Jul 2021 03:53:34 -0700 (PDT)
Received: from monk.home (astrasbourg-157-1-7-84.w90-40.abo.wanadoo.fr. [90.40.218.84])
        by smtp.gmail.com with ESMTPSA id o14sm26933641wrj.66.2021.07.21.03.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 03:53:34 -0700 (PDT)
From:   citral23 <cbranchereau@gmail.com>
To:     paul@crapouillou.net
Cc:     jic23@kernel.org, lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu, citral23 <cbranchereau@gmail.com>
Subject: [PATCH 3/6] iio/adc: ingenic: add JZ4760 support to the sadc driver
Date:   Wed, 21 Jul 2021 12:53:14 +0200
Message-Id: <20210721105317.36742-4-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210721105317.36742-1-cbranchereau@gmail.com>
References: <20210721105317.36742-1-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: citral23 <cbranchereau@gmail.com>
---
 drivers/iio/adc/ingenic-adc.c | 64 +++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index 40f2d8c2cf72..285e7aa8e37a 100644
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
@@ -339,6 +344,8 @@ static int jz4725b_adc_init_clk_div(struct device *dev, struct ingenic_adc *adc)
 	return 0;
 }
 
+
+
 static int jz4770_adc_init_clk_div(struct device *dev, struct ingenic_adc *adc)
 {
 	struct clk *parent_clk;
@@ -400,6 +407,47 @@ static const struct iio_chan_spec jz4740_channels[] = {
 	},
 };
 
+static const struct iio_chan_spec jz4760_channels[] = {
+	{
+		.extend_name = "aux0",
+		.type = IIO_VOLTAGE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.indexed = 1,
+		.channel = INGENIC_ADC_AUX0,
+		.scan_index = -1,
+	},
+	{
+		.extend_name = "aux",
+		.type = IIO_VOLTAGE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.indexed = 1,
+		.channel = INGENIC_ADC_AUX,
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
+	{
+		.extend_name = "aux2",
+		.type = IIO_VOLTAGE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.indexed = 1,
+		.channel = INGENIC_ADC_AUX2,
+		.scan_index = -1,
+	},
+};
+
 static const struct iio_chan_spec jz4770_channels[] = {
 	{
 		.type = IIO_VOLTAGE,
@@ -526,6 +574,20 @@ static const struct ingenic_adc_soc_data jz4740_adc_soc_data = {
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
@@ -621,6 +683,7 @@ static int ingenic_adc_read_raw(struct iio_dev *iio_dev,
 		return ingenic_adc_read_chan_info_raw(iio_dev, chan, val);
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->channel) {
+		case INGENIC_ADC_AUX0:
 		case INGENIC_ADC_AUX:
 		case INGENIC_ADC_AUX2:
 			*val = JZ_ADC_AUX_VREF;
@@ -832,6 +895,7 @@ static int ingenic_adc_probe(struct platform_device *pdev)
 static const struct of_device_id ingenic_adc_of_match[] = {
 	{ .compatible = "ingenic,jz4725b-adc", .data = &jz4725b_adc_soc_data, },
 	{ .compatible = "ingenic,jz4740-adc", .data = &jz4740_adc_soc_data, },
+	{ .compatible = "ingenic,jz4760-adc", .data = &jz4760_adc_soc_data, },
 	{ .compatible = "ingenic,jz4770-adc", .data = &jz4770_adc_soc_data, },
 	{ },
 };
-- 
2.30.2

