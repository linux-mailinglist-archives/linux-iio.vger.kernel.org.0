Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5282260B31F
	for <lists+linux-iio@lfdr.de>; Mon, 24 Oct 2022 18:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbiJXQ4N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Oct 2022 12:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbiJXQzi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2022 12:55:38 -0400
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDFF20BD3;
        Mon, 24 Oct 2022 08:36:29 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id o12so17349407lfq.9;
        Mon, 24 Oct 2022 08:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dEUdYH2IOK4Sv9uUCxei2ji2lQPqttekINckKjP4e8=;
        b=pKdY04PVa7KzU5j5KpYTQgyufQJqQQAqX0xxLZmGJ861xYsrflmL/WopHbWTcz4UAn
         N2vuNASVoKq7pnoedCv98RrECU5fmV3h5WQ0azO8g1K+4RX+GvROPZZ4AMVgM9C9ZW6R
         x2G14hZlamiKeezO2/C87M3lo6F0GZcVVn4V1e4nzxaMcCY38zBR7Gvc5BuyX7JQvkjt
         d+bJ1iubDj/lyUd+fsYoxSbYtVHGAMSV4KOvmJFIawcogmEljymppTCVekP3lo0Q8hVx
         1ZDGWIvuqQd7NNt12+7MzCQ3snGFz7akKAJVS7rybKhRc+Xe7lpix735ZLRWKyeI5xY6
         V33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dEUdYH2IOK4Sv9uUCxei2ji2lQPqttekINckKjP4e8=;
        b=IZE/Ua4M/t5ptwOVPv9x3AhV9kA7WDD+76B8+KJ2VVs228pejzbeByzsDYF9QS+aFT
         dFMq26rxydee6ZeLNu8BOAvqhY4Zbjmm6EKl4VLVuoIq9WmZ0MVGlukBh1CTr8wOoiZ4
         ykn7JVDkLLnpBrmQJRJM0098HXlBacG+If00qmzcwn/TjzpXRYc5gMapJLNe3tO4Vahh
         blemC3+hZZ+GHZBMrd7xP4kUfN9R9D3FFwXeJEiD7ojGsBYiw3a0c4JzLHAJMv3StGjZ
         Jn/afhkdFEs2Qd4NDJN70pHt6fX/Yw6ruZtT2rvb3pQV0Oh8cr3r/ZWZUb9sT1L/1Z73
         XRDw==
X-Gm-Message-State: ACrzQf1TBB/3eycQUKGHZhvnArQE7IlsHb+PVSbJXtzhWYK0h25WSc7d
        q/Xbpk0pZMULegPx6Dd99+FID/625f0=
X-Google-Smtp-Source: AMsMyM7M/0vyYZ6EerjqtAwEA7qKq+RAd7hMP2WFYVk+1+1oDCXgyAFn2yvL7zrF3OumgreOBLPoLw==
X-Received: by 2002:a17:907:7e9e:b0:78d:f3b0:fc78 with SMTP id qb30-20020a1709077e9e00b0078df3b0fc78mr28125405ejc.478.1666618084008;
        Mon, 24 Oct 2022 06:28:04 -0700 (PDT)
Received: from discovery.. (p5dcfeede.dip0.t-ipconnect.de. [93.207.238.222])
        by smtp.gmail.com with ESMTPSA id l20-20020a056402231400b00457c5637578sm18243818eda.63.2022.10.24.06.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 06:28:03 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v4 2/8] mfd: mp2629: Add support for mps mp2733 battery charger
Date:   Mon, 24 Oct 2022 15:27:51 +0200
Message-Id: <20221024132757.3345400-3-sravanhome@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221024132757.3345400-1-sravanhome@gmail.com>
References: <20221024132757.3345400-1-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
---
 drivers/mfd/mp2629.c       | 5 ++++-
 include/linux/mfd/mp2629.h | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/mp2629.c b/drivers/mfd/mp2629.c
index 16840ec5fd1c..f59c97e70f83 100644
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

