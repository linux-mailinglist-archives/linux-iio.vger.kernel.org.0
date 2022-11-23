Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B676367BB
	for <lists+linux-iio@lfdr.de>; Wed, 23 Nov 2022 18:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238764AbiKWRyy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Nov 2022 12:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238639AbiKWRyx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Nov 2022 12:54:53 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D047064A2C;
        Wed, 23 Nov 2022 09:54:52 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id a1-20020a17090abe0100b00218a7df7789so2764013pjs.5;
        Wed, 23 Nov 2022 09:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POR67NNOWOg5L0ub1cqdpDYlQnLokUngs3/LSYj03K0=;
        b=K88ASrwDTFK4OGChFmDH1LZtBUdGBGKG9j41LYJLOWnAbYk8fe1ZQSE5LLRDKmTLK4
         2s4glEMHtObtvX13izlex/80fofnqLokFZ4+9A4IiuIsLUGCcEPTyRB8d2nrSUVaR+A0
         7zcs8IA96gwwwlifelFXbovvYhS0CaBJwxp73+d9hthMUrCNX1cLieMxkn9rnJ4X0j1K
         ddrQP5jK+LNMNP3IRBVkgG/ISabCdlRckD+suCjBPPDz6xO6UatSyTHzoTGryHFj0VpG
         0h26/Yt0oAY7+wqL8SM6Djt9VXd3bwQnmT0KXwih/PpQsYv4xSiSLndCIM1IMr6oPdey
         Sh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POR67NNOWOg5L0ub1cqdpDYlQnLokUngs3/LSYj03K0=;
        b=D6+zGyl97LtohsGknjS+sy4o04AKA1L9GBq/XxlhU5+phDy2zzK0JyfCD+4d4lv/wr
         nVssvL31GCpj6bKg+QdFT2GVvGjPVabqH24dNwBOGWZ1wDxhHajSz5q3clxFr2X1f8ps
         Q/9WakooWGvTitaGa8KV1LDrJ2cRgIHVzuAsK+eFXHhnmkpkAdinsSDaA1QQMe8o2Gnj
         zm990M2pjBaNqOtoB7DzYgdPDkGItsDJ6LXUEyOwGHe3uaWMeZNSIUNAb+Eidqro3+8t
         KVvTYD4kDDMq9ycjnD+oGMdqXf65f0SsKKJmBhxsTRYJfUt2JhT6N6eSKfukFPfd27PO
         MWJg==
X-Gm-Message-State: ANoB5pm1wL6V7AIcaHJAbRUKmh7CzVKR6HPdXEgkNXd0wQzgUeoBakv3
        +02if2TPPo+r1xD5d6eyPb6AfTUHml4=
X-Google-Smtp-Source: AA0mqf6frPtH2L1iIleqUdyaFNUp/p4wFW/uiXFyonXhv6aMaL1JrFfFIAl1CqOYz8N0iuIwp5PAGQ==
X-Received: by 2002:a17:902:ce82:b0:186:ed91:5086 with SMTP id f2-20020a170902ce8200b00186ed915086mr9795463plg.59.1669226092356;
        Wed, 23 Nov 2022 09:54:52 -0800 (PST)
Received: from discovery.. ([2401:4900:483b:e422:60e:77bf:baa2:9d8b])
        by smtp.gmail.com with ESMTPSA id y76-20020a62644f000000b0057470a06694sm837503pfb.40.2022.11.23.09.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 09:54:51 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee@kernel.org, jic23@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v6 3/7] mfd: mp2629: introduce chip id machanism to distinguish chip
Date:   Wed, 23 Nov 2022 18:54:21 +0100
Message-Id: <20221123175425.564042-4-sravanhome@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221123175425.564042-1-sravanhome@gmail.com>
References: <20221123175425.564042-1-sravanhome@gmail.com>
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

Introduce chip id machanism to distinguish chip

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/mfd/mp2629.c       | 4 +++-
 include/linux/mfd/mp2629.h | 5 +++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/mp2629.c b/drivers/mfd/mp2629.c
index f4c5aa06f38c..a3fc02ad5ec1 100644
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
@@ -60,7 +62,7 @@ static int mp2629_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id mp2629_of_match[] = {
-	{ .compatible = "mps,mp2629"},
+	{ .compatible = "mps,mp2629", .data = (void *)CHIP_ID_MP2629 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mp2629_of_match);
diff --git a/include/linux/mfd/mp2629.h b/include/linux/mfd/mp2629.h
index 89b706900b57..072c8181b48b 100644
--- a/include/linux/mfd/mp2629.h
+++ b/include/linux/mfd/mp2629.h
@@ -9,9 +9,14 @@
 #include <linux/device.h>
 #include <linux/regmap.h>
 
+enum mp2xx_chip_id {
+	CHIP_ID_MP2629,
+};
+
 struct mp2629_data {
 	struct device *dev;
 	struct regmap *regmap;
+	enum mp2xx_chip_id chip_id;
 };
 
 enum mp2629_adc_chan {
-- 
2.34.1

