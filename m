Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B876696867
	for <lists+linux-iio@lfdr.de>; Tue, 14 Feb 2023 16:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjBNPsM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Feb 2023 10:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbjBNPsL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Feb 2023 10:48:11 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0107F2B62F;
        Tue, 14 Feb 2023 07:47:43 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso13976658wmp.3;
        Tue, 14 Feb 2023 07:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fm2/SUb2lF2wvyRiNYJZC21IgBGnaGjbT93F/GV9Cow=;
        b=dAwjA/sWLsNkKtFXv5yQdJAP/9IOFaPgMAcbYfAqJ/Z3T8ZQFYI3qF12D6mxYQnfhU
         fYx+ow1LVC4kpWW1BPF26MZEu7O15lkxOBLQvfcBB2GWhEL307OnukTq4Igjei7SfPRa
         nux81I5euviiuBiUE8JT76lF7deo5rHIwzyyJ2uIMziT4HNBSIz3m7IoJq84FIo2w/4F
         T5PMncbR0+vclVA3VNxcbzqZsUDMf6CwEItgrbDh/JuQmYCEHBV5SP+4EpvtbX4WMMU7
         S44wsnM8xXUjHJdAjB8kyXZC16aQaF2rIiu6Bxl+ozsCV3111IxgvX5RMpDhPi/hugQz
         69Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fm2/SUb2lF2wvyRiNYJZC21IgBGnaGjbT93F/GV9Cow=;
        b=aBKJtWZ3wy6LBZLkMLTc3g+wvqG8faBGiwgydVT7DSYb3D5F6OmsZc5dcRiyFfS9jO
         Zl/YiFdgaB1cQlGo9A2cqbGjcf3pKHTicAnBeYo/2kFXc6PrfeU3NNbnEBdvpKvFxQKC
         jh1HkSz9r0uML7WWGfkGIO0nb+1Ue7HPMTbSTkSGCJisUP4K5pGDE+9y7WOTsSlW6iL1
         ePLpWcnwCXuD3Uw29LbT/BErZQCz8+u0qGtGxGOdRK3XqRBYmHiT9ZCUT33fmxZt9CD3
         vmCpqxBZloLaRsvKmau068mnGGEyu2y4+oCTKd2diJCTk2nif092Mtkqqw0a4VGCgSEg
         ZHfQ==
X-Gm-Message-State: AO0yUKUTY/ggrsAVOuYjFWHZHiirxsmQrIsOec9R/CDS5+Nef9kAwyTK
        tvOZkE5sf4i7slE701kXPC4=
X-Google-Smtp-Source: AK7set+TIQE1j9EuKB5ZbCEey4WQc0C6Jv98jIuoeZU2ESTqJg08IqO6lXAJs9YUTbynGCyaFBFI3w==
X-Received: by 2002:a05:600c:511f:b0:3df:9858:c03a with SMTP id o31-20020a05600c511f00b003df9858c03amr13268wms.15.1676389654849;
        Tue, 14 Feb 2023 07:47:34 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id be7-20020a05600c1e8700b003dff2b493c8sm22283715wmb.36.2023.02.14.07.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 07:47:34 -0800 (PST)
Date:   Tue, 14 Feb 2023 18:47:30 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Haibo Chen <haibo.chen@nxp.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: adc: imx93: fix a signedness bug in imx93_adc_read_raw()
Message-ID: <Y+utEvjfjQRQo2QB@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The problem is these lines:

	ret = vref_uv = regulator_get_voltage(adc->vref);
	if (ret < 0)

The "ret" variable is type long and "vref_uv" is u32 so that means
the condition can never be true on a 64bit system.  A negative error
code from regulator_get_voltage() would be cast to a high positive
u32 value and then remain a high positive value when cast to a long.

The "ret" variable only ever stores ints so it should be declared as
an int.  We can delete the "vref_uv" variable and use "ret" directly.

Fixes: 7d02296ac8b8 ("iio: adc: add imx93 adc support")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/iio/adc/imx93_adc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/imx93_adc.c b/drivers/iio/adc/imx93_adc.c
index d8de8284e13d..8c68f0cd48f2 100644
--- a/drivers/iio/adc/imx93_adc.c
+++ b/drivers/iio/adc/imx93_adc.c
@@ -236,8 +236,7 @@ static int imx93_adc_read_raw(struct iio_dev *indio_dev,
 {
 	struct imx93_adc *adc = iio_priv(indio_dev);
 	struct device *dev = adc->dev;
-	long ret;
-	u32 vref_uv;
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -253,10 +252,10 @@ static int imx93_adc_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
-		ret = vref_uv = regulator_get_voltage(adc->vref);
+		ret = regulator_get_voltage(adc->vref);
 		if (ret < 0)
 			return ret;
-		*val = vref_uv / 1000;
+		*val = ret / 1000;
 		*val2 = 12;
 		return IIO_VAL_FRACTIONAL_LOG2;
 
-- 
2.35.1

