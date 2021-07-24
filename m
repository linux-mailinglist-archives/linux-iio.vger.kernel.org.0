Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8CF3D4954
	for <lists+linux-iio@lfdr.de>; Sat, 24 Jul 2021 21:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhGXSY6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Jul 2021 14:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhGXSY6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Jul 2021 14:24:58 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BB5C061757;
        Sat, 24 Jul 2021 12:05:28 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z7so5927123wrn.11;
        Sat, 24 Jul 2021 12:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TFqPeTJizFnfUZM7Q40k9J0nA9MRhn5b8J6dQsSbkSU=;
        b=g5nY822zTiAYbbkQ4YvFuTxrqBbrNXQb0J6QLorJ6+V4lidZ71xypTmFB5e/wdlDmv
         Z+S+OLK1FmyQGep01xTB9/9vn1uhuGI15sgbW8RtkRAmwMqqd/9Nr6kTLFB/sVD89NBN
         GHmttZTJEYENNoHHQu//YH1hsPWfQwXbsz3xoVJY/20eomOzxcPzl0AaNFTgiKwY552B
         Ea6wuEb/61dxpYp1AbFlCR8kKoW7UyP/W++yhJL/uNRP6DJknEGKGRZ3sjI8qthxEr7z
         Ecw1XE4wmkW2iui+tO7c2Ngx6ArEqnijunxPClK1wF44rkXMuOdPnLF3JX3jG2D5SjrE
         IxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TFqPeTJizFnfUZM7Q40k9J0nA9MRhn5b8J6dQsSbkSU=;
        b=R+1PviGawqTnxE/gmNIJ4cQ5PLSYy+zPRkHlHTJrv5vnnfBm/q6P1uiUU6gZzR7I5C
         geoupOK+U7rgoAZ/0eDWD4lzKjsiLNdxWhuTLKeO6iEdWYYjpbAT46TzfpZPWYRTEEYJ
         mvW5Sq9LXebzF4HeXTsDtYOYgQBsevNJB4Ub3zYgJ42TYaVjTDD7setmmt/4zp8xydxi
         o43PV6HQtxz+78aL0z4bBF9JqBFArJ093H4ABtCXDUYQ+JnixQTGYrLbjNWISXjT5gJH
         WRl6+oBLapXx4qi27JuBhUvUJGYsqo/4AsfowFr/UbWSU6COrzDGoPPqhEZoDX9DwKiB
         0NNQ==
X-Gm-Message-State: AOAM530q+9UHp3WaLC8frgU6DYJYAO6U5Oy3fxDXyMKYdt20aw2wOpol
        xOBxtbAWFY4qbbLbqc7NpaQ=
X-Google-Smtp-Source: ABdhPJyER3AGOSAzaJBWOSY3FIvCmfsIuvtui436ER79FTl14zfHObSDGR1r7fovxH8clCA5FgzmBg==
X-Received: by 2002:a5d:4a4c:: with SMTP id v12mr10875840wrs.256.1627153527415;
        Sat, 24 Jul 2021 12:05:27 -0700 (PDT)
Received: from monk.home (astrasbourg-157-1-7-84.w90-40.abo.wanadoo.fr. [90.40.218.84])
        by smtp.gmail.com with ESMTPSA id j15sm1117798wms.20.2021.07.24.12.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 12:05:27 -0700 (PDT)
From:   Christophe Branchereau <cbranchereau@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu, paul@crapouillou.net,
        Christophe Branchereau <cbranchereau@gmail.com>
Subject: [PATCH v3 1/5] iio/adc: ingenic: rename has_aux2 to has_aux_md
Date:   Sat, 24 Jul 2021 21:04:45 +0200
Message-Id: <20210724190449.221894-2-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210724190449.221894-1-cbranchereau@gmail.com>
References: <20210724190449.221894-1-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The jz4760(b) socs have 3 aux channels.

The purpose of has_aux2 is to set the MD bits used to select
the AUX channel to be sampled, not to describe the hardware.

Rename it to a more appropriate name.

Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
---
 drivers/iio/adc/ingenic-adc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index 34c03a264f74..40f2d8c2cf72 100644
--- a/drivers/iio/adc/ingenic-adc.c
+++ b/drivers/iio/adc/ingenic-adc.c
@@ -92,7 +92,7 @@ struct ingenic_adc_soc_data {
 	const int *battery_scale_avail;
 	size_t battery_scale_avail_size;
 	unsigned int battery_vref_mode: 1;
-	unsigned int has_aux2: 1;
+	unsigned int has_aux_md: 1;
 	const struct iio_chan_spec *channels;
 	unsigned int num_channels;
 	int (*init_clk_div)(struct device *dev, struct ingenic_adc *adc);
@@ -506,7 +506,7 @@ static const struct ingenic_adc_soc_data jz4725b_adc_soc_data = {
 	.battery_scale_avail = jz4725b_adc_battery_scale_avail,
 	.battery_scale_avail_size = ARRAY_SIZE(jz4725b_adc_battery_scale_avail),
 	.battery_vref_mode = true,
-	.has_aux2 = false,
+	.has_aux_md = false,
 	.channels = jz4740_channels,
 	.num_channels = ARRAY_SIZE(jz4740_channels),
 	.init_clk_div = jz4725b_adc_init_clk_div,
@@ -520,7 +520,7 @@ static const struct ingenic_adc_soc_data jz4740_adc_soc_data = {
 	.battery_scale_avail = jz4740_adc_battery_scale_avail,
 	.battery_scale_avail_size = ARRAY_SIZE(jz4740_adc_battery_scale_avail),
 	.battery_vref_mode = true,
-	.has_aux2 = false,
+	.has_aux_md = false,
 	.channels = jz4740_channels,
 	.num_channels = ARRAY_SIZE(jz4740_channels),
 	.init_clk_div = NULL, /* no ADCLK register on JZ4740 */
@@ -534,7 +534,7 @@ static const struct ingenic_adc_soc_data jz4770_adc_soc_data = {
 	.battery_scale_avail = jz4770_adc_battery_scale_avail,
 	.battery_scale_avail_size = ARRAY_SIZE(jz4770_adc_battery_scale_avail),
 	.battery_vref_mode = false,
-	.has_aux2 = true,
+	.has_aux_md = true,
 	.channels = jz4770_channels,
 	.num_channels = ARRAY_SIZE(jz4770_channels),
 	.init_clk_div = jz4770_adc_init_clk_div,
@@ -581,7 +581,7 @@ static int ingenic_adc_read_chan_info_raw(struct iio_dev *iio_dev,
 
 	/* We cannot sample AUX/AUX2 in parallel. */
 	mutex_lock(&adc->aux_lock);
-	if (adc->soc_data->has_aux2 && engine == 0) {
+	if (adc->soc_data->has_aux_md && engine == 0) {
 		bit = BIT(chan->channel == INGENIC_ADC_AUX2);
 		ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_AUX_MD, bit);
 	}
-- 
2.30.2

