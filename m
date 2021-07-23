Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B360E3D372D
	for <lists+linux-iio@lfdr.de>; Fri, 23 Jul 2021 10:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhGWISE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Jul 2021 04:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhGWISD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Jul 2021 04:18:03 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC5AC061757;
        Fri, 23 Jul 2021 01:58:36 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q3so1597075wrx.0;
        Fri, 23 Jul 2021 01:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TFqPeTJizFnfUZM7Q40k9J0nA9MRhn5b8J6dQsSbkSU=;
        b=JAWByEhHAkQv/lzD0WR5ne7Ev6FCgoRB56jWgTLjSI69EbqeUFU9vQnE19CibgPPn/
         ZGny8yVpbkvdZ1wnPwhJ1VDzU6GXogq+6jh2h9UJa57Juv5Tu5GiiALFh4gyWt+VS50W
         1GstGAvF5HGx4y2hhT5dqQSE8q+qMgmhvcGawTC82D33q/4/kUW2wx2kGKp7BaLqTvKn
         UyecvklcVBjKQx1IolI6IPRK9TpkCCpShsP7HcWm+nmpyU4A0+az4b85qfNKGuavN/CS
         1nRCwIbNmBpq6eJJR/4JwGh5dAj9DKzS1VEb3N4cCk+ZR6UTVvoVUB/4XxKXh6nEVMDo
         HjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TFqPeTJizFnfUZM7Q40k9J0nA9MRhn5b8J6dQsSbkSU=;
        b=BNUAnuApGZ3mlvjZLSrw8e8JJO6De/4CPe0qfY1PeRgEbmBR6LqgNpXyhuvgFB23xo
         6SOZ70MhKCSan6xkwFE2wQlWqk9EkmcR9QvQ+mfk9bEiLibnsEX6BfyAs+BCW3oXCTVC
         3fpF7YeWqj8b8DGith92xOPR//wVjg0LBoFPiZg1Szat69uZRLia1OYunx9ZGy5xf0dq
         t2ZgihChsoXsHosWZQ0CXD19hVH9vcEryfMHu7BhIAmDTht3Nky9SbncKaZp6AggNMa3
         8Al7d4YjJDgsoQcMY8EIjWJtAK5Ghjm4dgHLrN2GDzH73UMjNtk3fcI1GbS/u8Pk1Iw+
         gz0Q==
X-Gm-Message-State: AOAM530dKZ+Rc9Zi2gtDmKdflX/9RXfh3lRsjHgRUsBxpXGhgfXAYIuM
        j6uPLZ5TP6lDpsSp4wsgLkOt1MQyD+/cmyKs
X-Google-Smtp-Source: ABdhPJyyNG10iIo8RxseG38jkYxRJLgxywxuij/wB6xqXeJqlercNgez8+i2a+Umjon2bD7TyTFtEQ==
X-Received: by 2002:a5d:434e:: with SMTP id u14mr4013143wrr.378.1627030715116;
        Fri, 23 Jul 2021 01:58:35 -0700 (PDT)
Received: from monk.home (astrasbourg-157-1-7-84.w90-40.abo.wanadoo.fr. [90.40.218.84])
        by smtp.gmail.com with ESMTPSA id l23sm17503607wme.22.2021.07.23.01.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 01:58:34 -0700 (PDT)
From:   Christophe Branchereau <cbranchereau@gmail.com>
To:     paul@crapouillou.net
Cc:     jic23@kernel.org, lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu,
        Christophe Branchereau <cbranchereau@gmail.com>
Subject: [PATCH V2 1/5] iio/adc: ingenic: rename has_aux2 to has_aux_md
Date:   Fri, 23 Jul 2021 10:58:09 +0200
Message-Id: <20210723085813.1523934-2-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210723085813.1523934-1-cbranchereau@gmail.com>
References: <893d6165-0f12-d0da-44be-449a4ae96ac2@roeck-us.net>
 <20210723085813.1523934-1-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

