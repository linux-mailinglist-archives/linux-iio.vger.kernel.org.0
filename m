Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D3654B46C
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jun 2022 17:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356426AbiFNPRn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jun 2022 11:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356485AbiFNPRj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jun 2022 11:17:39 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A1C1015;
        Tue, 14 Jun 2022 08:17:37 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id o7so17859244eja.1;
        Tue, 14 Jun 2022 08:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mcUh8Ttt2EV4t5RWIjLziuOHMtsZJXTRmkC2HnKv3Xs=;
        b=UtfKWA4KnkVsHjOhMizCboqlSLRty8vhgMNz+W3dLrIhThUO9oo7v1bXdxVkZjftOq
         NAcIUeOV0xLODuvD/RUKnaTWUNx0zJzKJaazF9v8X2DKtAZw7QZ5Y3paIBT18a2kWq78
         YYmaJoA8E91bTS6pmwthYFsr/cumlMaGFDnRv84fBS0xKXXpwVIPTLfr2FJ3fsGOhRh2
         25t8KBjoNKV1KEtXkFtayLnoXCbe3m4Lx278gt7ubSOV4qJfk6RymRbrVKNbAXvg2h3q
         a7CYZ3HxpxV2rgu2lc2ODPpY8jL5cl03zIxO5NVkHgZx+kd+czqGwd4teJ+6WIFe4f+t
         Y6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mcUh8Ttt2EV4t5RWIjLziuOHMtsZJXTRmkC2HnKv3Xs=;
        b=fWJ6IDA14FsqWFk7aAPe0IYMt7OTkalMDrBW2/GQmbUGc9f9MXEzT2wSGDIhuRcLW1
         RghuRvYa19X25kwxA/qoRrCYst2dLQ+zj2R+q1ZJRdIzDmu1K6LC8Q/YqPB7j7UZACoC
         PhnHP+aJXrnbj0+VCDOWn/IEE6j6XijJWphChesM+juKdX+aO6Bc+tmUfx0wH2fEPUVv
         0yoQW21arLphnBhaGCidliv+soAM1UOoAhx6/e49drySX+ugRfVxvavcSNQmZ8gpG4x6
         B5gW42a7eC5dPJwmxwrXEa5t5tjED2LpVxHhZwB/35JCDvN/f58/KhUAZQXl/3TOEkls
         idBg==
X-Gm-Message-State: AOAM5335P0Fnh9M4Q50884Df58qS3/yeIVcwGibBzo6OKYS4YEV0wJ4H
        yaP2AjUMOhpx+cOkiXQpfbw=
X-Google-Smtp-Source: ABdhPJxDIKrZbteL1Hg1Oom4h08UpV/Q4uLAb2CkQ8SK9FSXOPdLYS+BVN7hVEh2Da2PYqLIQPfuow==
X-Received: by 2002:a17:907:72d2:b0:703:9177:7d1f with SMTP id du18-20020a17090772d200b0070391777d1fmr4681881ejc.144.1655219856279;
        Tue, 14 Jun 2022 08:17:36 -0700 (PDT)
Received: from localhost.localdomain (p5b3f7f9c.dip0.t-ipconnect.de. [91.63.127.156])
        by smtp.gmail.com with ESMTPSA id f1-20020a50d541000000b0042dd7e13391sm7198180edj.45.2022.06.14.08.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 08:17:34 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH 3/6] mfd: mp2629: Add support for mps mp2733 battery charger
Date:   Tue, 14 Jun 2022 17:17:19 +0200
Message-Id: <20220614151722.2194936-3-sravanhome@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220614151722.2194936-1-sravanhome@gmail.com>
References: <20220614151722.2194936-1-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

mp2733 is updated version of mp2629 battery charge management
device for single-cell Li-ion or Li-polymer battery. Additionally
supports usb fast-charge and higher range of input voltage.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 drivers/mfd/mp2629.c       | 31 +++++++++++++++++++++++--------
 include/linux/mfd/mp2629.h |  6 ++++++
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/mp2629.c b/drivers/mfd/mp2629.c
index 16840ec5fd1c..e0bbba9ca853 100644
--- a/drivers/mfd/mp2629.c
+++ b/drivers/mfd/mp2629.c
@@ -12,6 +12,7 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/mp2629.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -33,16 +34,36 @@ static const struct regmap_config mp2629_regmap_config = {
 	.max_register = 0x17,
 };
 
-static int mp2629_probe(struct i2c_client *client)
+static const struct of_device_id mp2629_of_match[] = {
+	{ .compatible = "mps,mp2629", .data = (void *)CHIP_ID_MP2629 },
+	{ .compatible = "mps,mp2733", .data = (void *)CHIP_ID_MP2733 },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mp2629_of_match);
+
+static int mp2629_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
 {
 	struct mp2629_data *ddata;
+	enum mp2xx_chip_id chip_id;
+	const struct of_device_id *of_id;
 	int ret;
 
+	if (client->dev.of_node) {
+		of_id = of_match_device(mp2629_of_match, &client->dev);
+		if (!of_id) {
+			dev_err(&client->dev, "Failed to match device\n");
+			return -ENODEV;
+		}
+		chip_id = (enum mp2xx_chip_id)of_id->data;
+	}
+
 	ddata = devm_kzalloc(&client->dev, sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
 		return -ENOMEM;
 
 	ddata->dev = &client->dev;
+	ddata->chip_id = chip_id;
 	i2c_set_clientdata(client, ddata);
 
 	ddata->regmap = devm_regmap_init_i2c(client, &mp2629_regmap_config);
@@ -59,18 +80,12 @@ static int mp2629_probe(struct i2c_client *client)
 	return ret;
 }
 
-static const struct of_device_id mp2629_of_match[] = {
-	{ .compatible = "mps,mp2629"},
-	{ }
-};
-MODULE_DEVICE_TABLE(of, mp2629_of_match);
-
 static struct i2c_driver mp2629_driver = {
 	.driver = {
 		.name = "mp2629",
 		.of_match_table = mp2629_of_match,
 	},
-	.probe_new	= mp2629_probe,
+	.probe	= mp2629_probe,
 };
 module_i2c_driver(mp2629_driver);
 
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
2.25.1

