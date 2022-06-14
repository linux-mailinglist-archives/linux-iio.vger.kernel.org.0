Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59AF354BAC1
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jun 2022 21:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245396AbiFNTmh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jun 2022 15:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiFNTmg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jun 2022 15:42:36 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7CF1AF11;
        Tue, 14 Jun 2022 12:42:35 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id n10so19154340ejk.5;
        Tue, 14 Jun 2022 12:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oYPUCPpmxpyEx42uQE8MmC44ye7jAfGebCzFBDxBGfk=;
        b=iEXSYdiBWaLdBCUYldspwmvfN9OdfW6aYTrBwMkQB2QU53/BLVhomXFC3CW/mmPefM
         7TIt6DIx5jijYPpDFYE5qp0WssDS6XfIk8Tg9jRXlEn+eafUdLTWN4Od6VmEgnjyS5/4
         sHXr8Htxj9eg6MTUQ1eXABFy+1L9T2eWklhlbycOAkV86kwHzUDtZX7UGb2W2EC7Gh2U
         BwL9tMIcj+rJWvxcMA7XFBrqT/ffbrXmKp7Vq0NnbGZesrjDaQ4I7VAFpnvVWXRuirE3
         oqz8iDVxc5QRt5AfuMFaHumJq9ivpfFS9UHxCRYTxgpyJWqp8FAY6xCZ6chX465rfRzn
         9UUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oYPUCPpmxpyEx42uQE8MmC44ye7jAfGebCzFBDxBGfk=;
        b=A/kXb4ZqHv3zXtJJLRLvx2sRbUXVmwKGCdth1gFnZhW+PthKnXlFOhURNIMVK+IgoD
         1xOOWqV3kathG+ga6htgkqspws0nxa7wZigkKfBNozb5SoyeL8hdJn9erHiIf5DBltOA
         HCNbOjH8pzh4z+nh/R992y5S7eWcZpP8mRVYjJemhkCsi2jo2WDWU8gDYFzp8KAq+heA
         LjvF/4JKVmv21MczZnkADfzCxB5OCN0KYUWLIFKB/Q7/Z1aAFoXcY2HvPMhZXO5jAnD5
         OnLVRdyWJvlfexeE4ulXXRD8YydYG+PeAF+tQbprP1WUD5DFFWwUljrTbklfWsBj0S+G
         FvVA==
X-Gm-Message-State: AOAM530rwzwiMz4ro+4YUjpVCNMmXop93bAK4ajuFKFblNoVBeLWXIBk
        c/PN5BDo6whXbLGuGeqBUMM+arbrHXxQJw9b
X-Google-Smtp-Source: ABdhPJx0BzhFdxFNd0KSOCMUDpab8aoaYbBp0VpBfwaiMX7znUHo9mGkZ9ddST3AsWI73z3E/F1Dyg==
X-Received: by 2002:a17:906:7484:b0:712:1178:dbf3 with SMTP id e4-20020a170906748400b007121178dbf3mr5623038ejl.72.1655235753895;
        Tue, 14 Jun 2022 12:42:33 -0700 (PDT)
Received: from localhost.localdomain (p5b3f7f9c.dip0.t-ipconnect.de. [91.63.127.156])
        by smtp.gmail.com with ESMTPSA id vw5-20020a170907058500b00712057b037fsm5306699ejb.167.2022.06.14.12.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 12:42:33 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v2 3/6] mfd: mp2629: Add support for mps mp2733 battery charger
Date:   Tue, 14 Jun 2022 21:42:22 +0200
Message-Id: <20220614194225.2226447-3-sravanhome@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220614194225.2226447-1-sravanhome@gmail.com>
References: <20220614194225.2226447-1-sravanhome@gmail.com>
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

