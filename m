Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC463D0DD4
	for <lists+linux-iio@lfdr.de>; Wed, 21 Jul 2021 13:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238500AbhGUKxg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Jul 2021 06:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240074AbhGUKNW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Jul 2021 06:13:22 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7499C0613E4;
        Wed, 21 Jul 2021 03:53:34 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id f9so1670871wrq.11;
        Wed, 21 Jul 2021 03:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lwqqgfe+46GMK+Di/kXbABZcUvyvwaUzvFfRwi5tfrA=;
        b=oaXzlAEuBCyvPp3+cfoCWgzw8cEPJfPpK+7YMyI5LjHEC4boWtQm7EHLDuxEURQh+n
         fVzEzzKhZXv4NhDDLlJoVf9ueNXllQmDF+SGhYMEVt5KXDCY7+ZOUAxwzcdZIQEGZzTt
         dun/m2Z/0iGOLy2W4ufXbScjNeYtIgB5au1C/lqWpEd+tpgqu4LryHW2MFHpi8H1k20B
         REPwymgxfWgcDUqnsOQWD8Yh2LOFT3kwLgHqgCfF0by+e/YhoijjuYBVe1dp+oOf+eJE
         IT5RpHCRGgDK5PtgNF5qW6u5RGy5HthhKtiiCDdLqt1542Mav447kbcF6D7wIYRbs+T4
         EqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lwqqgfe+46GMK+Di/kXbABZcUvyvwaUzvFfRwi5tfrA=;
        b=WM/pM0ysaYNpf4us+ywh+0BKPvdqVQwXFORMYGtAAZc0tomgYHptwhQaXeQVQiOFLW
         Sw4NzbVw8qztw48ChfL0589tnVPEs2720wd/IrEab60r5Qz95S/sKsr1F1vH4vDGbkZy
         yigRWPvQdejzw81SonSloDP38SMJlF3NMMZqAVatYg4gxJccBRPj9GTaBrkAf0kqaXXc
         l8CyEqIhnfY3PRuVL2vcY73xbsiK2zf1JcDfcKAHKfIr2tqLZxE25vauAH1E3fPI+zv1
         aW4ZsLMbJQJ1/1l9NguPD/DDrc7g51IRV1s/HW4te1q35kL5b+2TIQC7A2vlqzXnH9zR
         PjCA==
X-Gm-Message-State: AOAM533VP6oZiGplG5VEom507ulqTpF4l9+LYRjY5FUL8P129KsxjUTD
        dguQi1geBB2W4AF40Rt2X3g=
X-Google-Smtp-Source: ABdhPJxuoy7H65TPPpbytdGkDdgvVYWAeKRSXJhVRUvPa6xYtd+q5oqqmdUrE+qwDgqBbcscP56jAw==
X-Received: by 2002:a5d:6b8e:: with SMTP id n14mr40850901wrx.96.1626864813315;
        Wed, 21 Jul 2021 03:53:33 -0700 (PDT)
Received: from monk.home (astrasbourg-157-1-7-84.w90-40.abo.wanadoo.fr. [90.40.218.84])
        by smtp.gmail.com with ESMTPSA id o14sm26933641wrj.66.2021.07.21.03.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 03:53:33 -0700 (PDT)
From:   citral23 <cbranchereau@gmail.com>
To:     paul@crapouillou.net
Cc:     jic23@kernel.org, lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu, citral23 <cbranchereau@gmail.com>
Subject: [PATCH 1/6] iio/adc: ingenic: rename has_aux2 to has_aux_md
Date:   Wed, 21 Jul 2021 12:53:12 +0200
Message-Id: <20210721105317.36742-2-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210721105317.36742-1-cbranchereau@gmail.com>
References: <20210721105317.36742-1-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The purpose of this property is to set the AUX_MD bits if true, no to describe the hardware.
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

