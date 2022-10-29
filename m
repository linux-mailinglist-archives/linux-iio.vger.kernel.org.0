Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47EE96121D2
	for <lists+linux-iio@lfdr.de>; Sat, 29 Oct 2022 11:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiJ2JaO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 05:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJ2JaL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 05:30:11 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D165C59E95;
        Sat, 29 Oct 2022 02:30:09 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id t1so777431wmi.4;
        Sat, 29 Oct 2022 02:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3goYbsJDZwsx1DqCHZmmtgFkfTgwpdzB6nk55vcDFfg=;
        b=jBs97ucoqcakG2D5kdyfEMhnORwaVEPiplFRWhoi0pMNqJ40VPSKoG5gHifjC/Y31P
         gTNE3gzHVkNvOzaUCBHUpRy2RbT2vw1hb+jL1QwHCF2FdQyNWfkQDOzexmamvp2OUVYQ
         r0h5k3561u9xwRayDlgTl/WcEgYBZcyAfa85rKEeNKPtCc6fvNEEWP0XL/iCfurh78f3
         Md7u2Tv2qkClNLYMheBvDOsal+LnE4jJOm+YXApgFeNyYYjjXyiINKM0avVqZdAQ5xGZ
         RQzFXTX4SKR78gDAjIwXcLdC0DdgjC+KOIIB3IQvubrUgbeBL7OEhHHIvamNndJl58Gd
         2dKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3goYbsJDZwsx1DqCHZmmtgFkfTgwpdzB6nk55vcDFfg=;
        b=kFjAiXupUDWn/U7H1hB6JW138l0nE4xdE5yHNt+uX2UeFnx1OTMg/cNy0cT726hOdW
         7TBlqzPGlPrY6gz9YIv4WITKgJN08DKqI8dzGl3yKZl9GtEA5lo2yvOe08nT63l6Iru7
         mSCHqfYp7gkD4ifvI5k8JT4Hl4wjh15aNqa95zaVKvrGKrwjZPRVEFXWkbg+0FDjWZeA
         SlpJIoV41+cLnN3azCBpIQ3pjM8xGdyjuJhilJ3KtgOcXY2fgRrkocNxGM8YNh2njf9j
         UPG9GT2/bkk+0TmpXuMJ+bvyM8+7vtW5ZmkVqe2/W1CDegCS+47J+aw9v90IKQQvyJIv
         z1QA==
X-Gm-Message-State: ACrzQf0mJWYsyWQfmI6kLKAZ+yHx1BiCTdF7jSSHX65OGsU1jW4ePxo5
        ZQGnjhxn20fmR4TYsfobeJ4=
X-Google-Smtp-Source: AMsMyM4QH4xVzn8ngRL3c6gJ1pn31cQeLg/S/ZE1z+mdZ+xGo2JXIfbkenWtKysM0m+kJBCqb4T0PA==
X-Received: by 2002:a05:600c:1987:b0:3c6:fd37:7776 with SMTP id t7-20020a05600c198700b003c6fd377776mr12390070wmq.72.1667035808379;
        Sat, 29 Oct 2022 02:30:08 -0700 (PDT)
Received: from discovery.. (p5b3f76b5.dip0.t-ipconnect.de. [91.63.118.181])
        by smtp.gmail.com with ESMTPSA id f7-20020adff987000000b0022e6178bd84sm1068187wrr.8.2022.10.29.02.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 02:30:08 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Saravanan Sekar <sravanhome@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v5 5/8] mfd: mp2629: Add support for mps mp2733 battery charger
Date:   Sat, 29 Oct 2022 11:29:57 +0200
Message-Id: <20221029093000.45451-6-sravanhome@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221029093000.45451-1-sravanhome@gmail.com>
References: <20221029093000.45451-1-sravanhome@gmail.com>
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

mp2733 is updated version of mp2629 battery charge management
device for single-cell Li-ion or Li-polymer battery. Additionally
supports USB fast-charge and higher range of input voltage.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/mfd/mp2629.c       | 5 ++++-
 include/linux/mfd/mp2629.h | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/mp2629.c b/drivers/mfd/mp2629.c
index f4c5aa06f38c..57db0f5009b9 100644
--- a/drivers/mfd/mp2629.c
+++ b/drivers/mfd/mp2629.c
@@ -13,6 +13,7 @@
 #include <linux/mfd/mp2629.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
@@ -43,6 +44,7 @@ static int mp2629_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	ddata->dev = &client->dev;
+	ddata->chip_id = (uintptr_t)device_get_match_data(&client->dev);
 	i2c_set_clientdata(client, ddata);
 
 	ddata->regmap = devm_regmap_init_i2c(client, &mp2629_regmap_config);
@@ -60,7 +62,8 @@ static int mp2629_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id mp2629_of_match[] = {
-	{ .compatible = "mps,mp2629"},
+	{ .compatible = "mps,mp2629", .data = (void *)CHIP_ID_MP2629 },
+	{ .compatible = "mps,mp2733", .data = (void *)CHIP_ID_MP2733 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mp2629_of_match);
diff --git a/include/linux/mfd/mp2629.h b/include/linux/mfd/mp2629.h
index 89b706900b57..ee0e65720c75 100644
--- a/include/linux/mfd/mp2629.h
+++ b/include/linux/mfd/mp2629.h
@@ -9,9 +9,15 @@
 #include <linux/device.h>
 #include <linux/regmap.h>
 
+enum mp2xx_chip_id {
+	CHIP_ID_MP2629,
+	CHIP_ID_MP2733,
+};
+
 struct mp2629_data {
 	struct device *dev;
 	struct regmap *regmap;
+	enum mp2xx_chip_id chip_id;
 };
 
 enum mp2629_adc_chan {
-- 
2.32.0

