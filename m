Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D657F3D5574
	for <lists+linux-iio@lfdr.de>; Mon, 26 Jul 2021 10:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbhGZHkP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Jul 2021 03:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbhGZHkM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Jul 2021 03:40:12 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA56C061757;
        Mon, 26 Jul 2021 01:20:41 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j2so9967301wrx.9;
        Mon, 26 Jul 2021 01:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XxDmsHfj67NCzf6dLeWTql1O3Ja9txcQv/HFjj1gt5A=;
        b=RPDDm3/vx/HKd6ktjpdc7BQVkU3/ZR9PJQSeW7UsaZO+h2oW1WElm5x4OIQm0Lrt2q
         IdBsiKhrFavIpmASGxK+Zn0YCH/Ij4x357iDXd8DzZm7KsRgx6PXcbXygRDe0lnnFtSm
         xYDXc6cP14FFseAIKZ8QZJgTfhU0k5ZPq5yk1EqkNKzhzTlKhlSR11Ms6cQYxyq4m9Ht
         y8sTgdyvjNpFiMgqOsj27sFQNzkLPPDtBg57R2QG/uvShVpAUdblYUeAYIrlJe6eE7UX
         hjuQ6Adp//cGUE97RovSrlhgYXhxYHP5on/kvqhIZGnJsTZFXlMGJbydJSP5bzZY4+zZ
         NPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XxDmsHfj67NCzf6dLeWTql1O3Ja9txcQv/HFjj1gt5A=;
        b=kpfy1Eg3a3svzFbTfoy6qd/a9DYl8uKGOlc0ugVFUKjyAAXk/utyjmOKP5yyddiJs1
         O/NVxdffqxGH7ns7i74X1NA0SjaL/lNiKqapMfMmQa/2EZh1uTNAr/AxIGegSdb/I8fG
         gAgnoWhWWNs+9A7Pkrn+eBHxX3oJII9iWlg+uKvORSb809+ThFMnurC/NFzKv+eqv6a4
         02wvPajfp8lMO4exKiJR+BnkrLxdzyPPF5058eOKZIVpHJ6QIVKVJB54QGFxNoJksV2X
         xSJaJ2qiWp8yCukzfcg6965kr7ZFDMz11pvpA0jtGBuR6h4JdrvPRhz/k5ZpCKrYAQe6
         9feA==
X-Gm-Message-State: AOAM533zhgDAMmmyVdZDvp6Icd6yO8rCCFo4V8oYr4sqvKD+ROk15UvK
        uUANY1yFxZMp1Wx8/YHxCn8=
X-Google-Smtp-Source: ABdhPJxQUM3eFL4Q+ytRpT2iqyXZihfZ+oK81GxUtpbXcE9UmsxzUi/2eACzN7r6MQEp7JUha130Cw==
X-Received: by 2002:adf:f411:: with SMTP id g17mr17671595wro.160.1627287639855;
        Mon, 26 Jul 2021 01:20:39 -0700 (PDT)
Received: from monk.home (astrasbourg-157-1-7-84.w90-40.abo.wanadoo.fr. [90.40.218.84])
        by smtp.gmail.com with ESMTPSA id w13sm4799464wru.72.2021.07.26.01.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 01:20:39 -0700 (PDT)
From:   Christophe Branchereau <cbranchereau@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu, paul@crapouillou.net,
        Christophe Branchereau <cbranchereau@gmail.com>
Subject: [PATCH v4 3/5] iio/adc: ingenic: add JZ4760 support to the sadc driver
Date:   Mon, 26 Jul 2021 10:20:31 +0200
Message-Id: <20210726082033.351533-4-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726082033.351533-1-cbranchereau@gmail.com>
References: <20210726082033.351533-1-cbranchereau@gmail.com>
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

Reviewed-by: Paul Cercueil <paul@crapouillou.net>
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

