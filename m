Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6124D3D5570
	for <lists+linux-iio@lfdr.de>; Mon, 26 Jul 2021 10:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbhGZHkN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Jul 2021 03:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbhGZHkL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Jul 2021 03:40:11 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA273C061760;
        Mon, 26 Jul 2021 01:20:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o5-20020a1c4d050000b02901fc3a62af78so7575063wmh.3;
        Mon, 26 Jul 2021 01:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RnAVrRuSO8xn5HvUZpk7kDzVOfbRU41FvjhfmnuD5zk=;
        b=cqgXH7se9cr4LyNFyzgkgtfvzHXcNSowKUMrO6zCMpYq9bv8IL1k0MJMPdN+9qBqRd
         WG1juJab5DxxO1TvIJXihSY9Umi0lg5njusD1853eJkSZLVPaExdZORNhwkPWfgskLvG
         854quh3hAe3bSd/nbEiBYkoTF49wSskIgmI8z/QONTTNR641qOKgHveqQrSmPSq3/EFY
         EMVTZyynB8xz70pYKUbK5iIEm78iC86x3B8Pw3ok95M+qTHCK7oININ+Wst8m7ygmDFg
         dlkS284DKvRAYYNT6CKN75BlGMDgkVsoTOkQD73LhVK13o02f/5Qc1Lpjrz+jE88y4hQ
         9cpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RnAVrRuSO8xn5HvUZpk7kDzVOfbRU41FvjhfmnuD5zk=;
        b=KEWsIE8szeC/pHpR3Hc+4wc1z54M+dRC54yx+xYed/tP5Kuf5M4Wn/YJKUiHkJgYMU
         dFF+g/ufrNLxoSU3YLUXyaQHJ+1q+F9dWs+xcrV/yyUfshAjRdDsh50YrDOAUrAp02oO
         5RuinKgkf9rG9P4lxEYbnjczp5N0SrAA6p3oaHUSknTglrNjC9+amEnz8lklQnqDHGcd
         bdX7CVCy7qWeg4cuMzJBO1CUgrfJ3v7iejeg5CKFzYq+wKQdi+6ZVevnJs1OhCBwy0B0
         l/P+VCfDHDUoSdGsC9WS3pyq1Kt6L4/16hwqMIGt4VEd/CZ8W9W1tAOg/N/dGJJtqB12
         AIbw==
X-Gm-Message-State: AOAM531xK/wmFUksbbPD8Rdl/9QeXSdhncCAKv0mH3iKRHawaFIFxKCB
        fsD/+CkjbclBwar4d0VH+OA=
X-Google-Smtp-Source: ABdhPJwQvzOe/zun1pWS30iHTeU4FjezqsO+0P9tYp0BivA1Ljhfvo9jHzaH+fjHwzAhUp39sBx70Q==
X-Received: by 2002:a1c:a4c1:: with SMTP id n184mr4158796wme.8.1627287638170;
        Mon, 26 Jul 2021 01:20:38 -0700 (PDT)
Received: from monk.home (astrasbourg-157-1-7-84.w90-40.abo.wanadoo.fr. [90.40.218.84])
        by smtp.gmail.com with ESMTPSA id w13sm4799464wru.72.2021.07.26.01.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 01:20:37 -0700 (PDT)
From:   Christophe Branchereau <cbranchereau@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu, paul@crapouillou.net,
        Christophe Branchereau <cbranchereau@gmail.com>
Subject: [PATCH v4 1/5] iio/adc: ingenic: rename has_aux2 to has_aux_md
Date:   Mon, 26 Jul 2021 10:20:29 +0200
Message-Id: <20210726082033.351533-2-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726082033.351533-1-cbranchereau@gmail.com>
References: <20210726082033.351533-1-cbranchereau@gmail.com>
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

Reviewed-by: Paul Cercueil <paul@crapouillou.net>
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

