Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5AD63DD5B
	for <lists+linux-iio@lfdr.de>; Wed, 30 Nov 2022 19:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiK3S0o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Nov 2022 13:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiK3S0m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Nov 2022 13:26:42 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3565213E16;
        Wed, 30 Nov 2022 10:26:40 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id t62so19646203oib.12;
        Wed, 30 Nov 2022 10:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGjOYqsJ4mpJB2xZwE/rziR8NLFmClSXUULTYa2k8yU=;
        b=oQLpUJp5d/SDEQkPeAmaK3imrtzhoV7AJV8DnSFQ15Ps/WGI8Wnq3bxng6w1oXf52B
         Ze1JTPcyxDqFZwAXPMakP0AN8lf678/PLNK3VCqQCni951cB1NjleZw2ET55E76vu93Z
         q2Wa71GQ2mGHUybOkQyFC3r/j+RoK5qE1xNKydQiUUJiFeu9od+mT+6UQJohzJrc/mXb
         BcwjeaKACY5COJmH05uZa4kwltfedmMO+wttfFM54/82AeB30w2DTCsr0W4szaKKXtGE
         WgP6KjhRAme2ereRGa9bLv0388fkuEnXu83fAR33b5gamiiyQZByunfEi6Mi3DYDGV0w
         NXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGjOYqsJ4mpJB2xZwE/rziR8NLFmClSXUULTYa2k8yU=;
        b=4hrn7RF8v2MzUAzG/kV8XvEE0ffYfgpGDCwsbjCX62APwr3VjrQpG8CtCkcLCNSql6
         rmgyzMIWuea27YxdRoRm2Ttd723T5nEFkrqBwKO6A14fVVM76VQYXjZJ5j8q16OvxgVI
         HYnlsA0juv6yT0sQ4nGz+t31QO0/IcBRvCh1ZJ0X+o6itkh/6YyqCtgRlVAE6fgXEplv
         4hZqq61YlbuY3JYz2pHqWJNNy0CaX3Uit/B+NQf138orUihDOZmZQIPtWmq7AbqQYG2f
         AKrxjeDm/LxxY+QppYj5gj/ekZyFBYhOnlEyHneJgIaaR99jHyU9XH2eUE8bD8NjeFod
         HXow==
X-Gm-Message-State: ANoB5pnnoFDJpJwvB6GoqtZcUrNAbNAj7Bj0arO0gsNAMO7OvVAN5IM0
        ZXNaJ4EXP9dbbFR31xqHatM=
X-Google-Smtp-Source: AA0mqf77snlArXHG8vx98XRaqgtiE/ggXGaDKOCcwT+WvqNStpwv2sxoJQE9dFHM5u3r3Hdkt6Nqng==
X-Received: by 2002:a05:6808:46:b0:35a:ff1:bf0d with SMTP id v6-20020a056808004600b0035a0ff1bf0dmr22742161oic.115.1669832800241;
        Wed, 30 Nov 2022 10:26:40 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:485:4b69:e48f:7d21:8a92:6dc])
        by smtp.gmail.com with ESMTPSA id m24-20020a0568301e7800b006690f65a830sm1209972otr.14.2022.11.30.10.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 10:26:39 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] iio: dac: ad5686: Add support for AD5337
Date:   Wed, 30 Nov 2022 15:26:32 -0300
Message-Id: <20221130182632.3856675-2-festevam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130182632.3856675-1-festevam@gmail.com>
References: <20221130182632.3856675-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

AD5337 belongs to the same family as the AD5338.

The difference is that the AD5337 has 8-bit precision instead of 10-bit.

Add support for the AD5337 chip in the driver.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/iio/dac/Kconfig      | 8 ++++----
 drivers/iio/dac/ad5686.c     | 7 +++++++
 drivers/iio/dac/ad5686.h     | 1 +
 drivers/iio/dac/ad5696-i2c.c | 2 ++
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 80521bd28d0f..e83eb75d87d1 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -162,10 +162,10 @@ config AD5696_I2C
 	depends on I2C
 	select AD5686
 	help
-	  Say yes here to build support for Analog Devices AD5311R, AD5338R,
-	  AD5671R, AD5673R, AD5675R, AD5677R, AD5691R, AD5692R, AD5693, AD5693R,
-	  AD5694, AD5694R, AD5695R, AD5696, and AD5696R Digital to Analog
-	  converters.
+	  Say yes here to build support for Analog Devices AD5311R, AD5337,
+	  AD5338R, AD5671R, AD5673R, AD5675R, AD5677R, AD5691R, AD5692R, AD5693,
+	  AD5693R, AD5694, AD5694R, AD5695R, AD5696, and AD5696R Digital to
+	  Analog converters.
 
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad5696.
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 15361d8bbf94..57cc0f0eedc6 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -258,6 +258,7 @@ static const struct iio_chan_spec name[] = {			\
 
 DECLARE_AD5693_CHANNELS(ad5310r_channels, 10, 2);
 DECLARE_AD5693_CHANNELS(ad5311r_channels, 10, 6);
+DECLARE_AD5338_CHANNELS(ad5337r_channels, 8, 8);
 DECLARE_AD5338_CHANNELS(ad5338r_channels, 10, 6);
 DECLARE_AD5676_CHANNELS(ad5672_channels, 12, 4);
 DECLARE_AD5679_CHANNELS(ad5674r_channels, 12, 4);
@@ -283,6 +284,12 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
 		.num_channels = 1,
 		.regmap_type = AD5693_REGMAP,
 	},
+	[ID_AD5337R] = {
+		.channels = ad5337r_channels,
+		.int_vref_mv = 2500,
+		.num_channels = 2,
+		.regmap_type = AD5686_REGMAP,
+	},
 	[ID_AD5338R] = {
 		.channels = ad5338r_channels,
 		.int_vref_mv = 2500,
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index b7ade3a6b9b6..760f852911df 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -54,6 +54,7 @@
 enum ad5686_supported_device_ids {
 	ID_AD5310R,
 	ID_AD5311R,
+	ID_AD5337R,
 	ID_AD5338R,
 	ID_AD5671R,
 	ID_AD5672R,
diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
index 160e80cf9135..8a95f0278018 100644
--- a/drivers/iio/dac/ad5696-i2c.c
+++ b/drivers/iio/dac/ad5696-i2c.c
@@ -72,6 +72,7 @@ static void ad5686_i2c_remove(struct i2c_client *i2c)
 
 static const struct i2c_device_id ad5686_i2c_id[] = {
 	{"ad5311r", ID_AD5311R},
+	{"ad5337r", ID_AD5337R},
 	{"ad5338r", ID_AD5338R},
 	{"ad5671r", ID_AD5671R},
 	{"ad5673r", ID_AD5673R},
@@ -92,6 +93,7 @@ MODULE_DEVICE_TABLE(i2c, ad5686_i2c_id);
 
 static const struct of_device_id ad5686_of_match[] = {
 	{ .compatible = "adi,ad5311r" },
+	{ .compatible = "adi,ad5337r" },
 	{ .compatible = "adi,ad5338r" },
 	{ .compatible = "adi,ad5671r" },
 	{ .compatible = "adi,ad5675r" },
-- 
2.25.1

