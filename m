Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B5554CBDE
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jun 2022 16:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345218AbiFOOyO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jun 2022 10:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343591AbiFOOyI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jun 2022 10:54:08 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3262727B23;
        Wed, 15 Jun 2022 07:54:07 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x5so16570032edi.2;
        Wed, 15 Jun 2022 07:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3+FpnW+9MOB0iv3pWt/BniZ3+7BgHVeESC7+jb4myQI=;
        b=cuV2ivciKCdxDCxhZZELRYX+jVZbjtEMIdT+Vear7sbkGwU4Qca19QEQcF/olsnRBV
         p9KPhA50Q0XMRWU4CE9Can4dyXruDi43VPMI4REweHkeNMAl0qp64m7CUzDRtVMyod7X
         HSywRzNyG+CmmIb0ovlxjg+2COiqZSUbpU3Akx0Oum5WLx9TNcS3r+ybs5TyFcaT+CzU
         hGpbhmbgwBtK6ajveYdhzyjNluERYr12s212d6Rw3bBWWHW1guMbPNeLrXyfHY8RFgqP
         qEw5DZ7j6JvDCysGEivsWNNY9e1a0L+v4hdTHuqL6WcLo5LD4Em9lJE5+SWhF4PYy+Z6
         XzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3+FpnW+9MOB0iv3pWt/BniZ3+7BgHVeESC7+jb4myQI=;
        b=rApRZ3dteWvqublPiGEzeW2yjrbl0ieYyCOyjE7m/f7sykjFKyAButv+5ocLsiX4pu
         aB1idzEUlyLCheQBjS+AJbA33o2En5SfgapS5wm8771hc7xRS2stfk3ODGdwMM7WED0Y
         RMEqS2vNnHXeG2lp/cvrJdhB27KuG28wrrg184UEwzc2+55f0sFHGTlgEdbjvadKMtnN
         wyxkSHVunYUHDEpZK/+8AzjRjrcrLJXhQPb2YLN8HvObYV34Vyxej1u/segEopxRiEBO
         4QGsD76i9SqSRvJtb3MmdsJn/z1KlCFhu/RWTypbc+kCHJFJ2xXpioxNvnkZRb9TNL47
         TuKg==
X-Gm-Message-State: AJIora9AaYDj0Mig4+F0y5AYCvdZLfjoCsTqzx7cLaIyUIry58mdc+N5
        Xfiz6ABrDRfg2ovi+4lNvReWMXMdaww60w==
X-Google-Smtp-Source: AGRyM1uzuerY1flspbuYVfmgRKSO9X8/XmQGohSIih93KP3rCry6/SneXEu2RsShrYEgbxLhtMHWzw==
X-Received: by 2002:a05:6402:50ce:b0:42e:2208:bd8c with SMTP id h14-20020a05640250ce00b0042e2208bd8cmr162550edb.216.1655304845643;
        Wed, 15 Jun 2022 07:54:05 -0700 (PDT)
Received: from localhost.localdomain (p5dcfe5fe.dip0.t-ipconnect.de. [93.207.229.254])
        by smtp.gmail.com with ESMTPSA id y2-20020a1709063a8200b00706287ba061sm6341665ejd.180.2022.06.15.07.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 07:54:05 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v3 3/6] mfd: mp2629: Add support for mps mp2733 battery charger
Date:   Wed, 15 Jun 2022 16:53:54 +0200
Message-Id: <20220615145357.2370044-4-sravanhome@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615145357.2370044-1-sravanhome@gmail.com>
References: <20220615145357.2370044-1-sravanhome@gmail.com>
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
2.25.1

