Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95D34CFFFD
	for <lists+linux-iio@lfdr.de>; Mon,  7 Mar 2022 14:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242854AbiCGN1f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Mar 2022 08:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242848AbiCGN13 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Mar 2022 08:27:29 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4D18BF20;
        Mon,  7 Mar 2022 05:26:34 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id r187-20020a1c2bc4000000b003810e6b192aso9298148wmr.1;
        Mon, 07 Mar 2022 05:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rdaEZMqv2GSMQQnd5hqogE9zXTY4aEMT25ROidyBmtU=;
        b=j1KP4sqvyD+fCi/WMy5DrTcZZxUXlyLB8zoCO1Rki3+nu2rjpJgOe1jbihjlnjLomG
         vxULRyc99MrXqUrGHUDPXHoqwUkibxrenaxDbRMRSOJlBG3lIc9xWq8BBoYasTtokdv9
         mKq+aVJpwOnpwzniWxPINgnEsrgJh4+31MTqj14ss7Ax6xnE4NcEpRkPQdnz7rcmfFrZ
         LhQ7IlOtdcP8MJTqqDjRQNcg60WieKCu6xxdIObRQJQIzZsS0aNzGSn0Yi/1AHLfg0Yi
         gDwVAdqVRqXHPiNfRBRehTleGZ5S8nefWtL+pXpMSSzwzd7cdAfK1jwWMYLxwchHPp+N
         YWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rdaEZMqv2GSMQQnd5hqogE9zXTY4aEMT25ROidyBmtU=;
        b=6HvSC/Nx5++tGbNHfXR+6YfdHb+dGDk5csXegyj1TrgtFpMlx55PJHFFDJBnXF/F/y
         C3mXRa7r1wNg2TwO+AFUMaGXoQogpJJ/xJWvEBSN9pkVKn1jc8t0AEb5kQGd7MUwWZsV
         xl+0nAuLtdyR+tQnFHvgUSTUmtW+Btep3wKbU74GwJdH2B3syAH6w5TWKBGnq3/JuclY
         bPpqkZ5AW1jnKwrOfPOH06T9DfZxhxsCJWSh8iuqaP7Lq7P/iF5eGrz8xvc8gepidTFG
         JSZ3ZQ3zBwA9M2RwJEbXKxjyBsDebHHqFEtMhF24xwpqZLlXNlEhiMPg0lkhK6EHznPF
         7Ogg==
X-Gm-Message-State: AOAM533GLschLAJQUoFGrq5nd5yCtCwaNybACf0xq2H+Fg2jzrU3imSf
        2K99768pZvY2ZnIDvCXRaTo8DGqjbRriSE3cOQQ=
X-Google-Smtp-Source: ABdhPJxMhhK7t4QDHB08En6k7VicnOqjaJ0OsR8b3Fh/hUe4qlLaGgdzj9bppyxbVR6MKvMKxjBAbg==
X-Received: by 2002:a1c:4c13:0:b0:389:a4ab:df7c with SMTP id z19-20020a1c4c13000000b00389a4abdf7cmr4210993wmf.14.1646659592776;
        Mon, 07 Mar 2022 05:26:32 -0800 (PST)
Received: from tpt440p.steeds.sam ([41.84.249.145])
        by smtp.gmail.com with ESMTPSA id r2-20020a5d6942000000b001f0485057c4sm11524965wrw.74.2022.03.07.05.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 05:26:32 -0800 (PST)
From:   "Sicelo A. Mhlongo" <absicsz@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Denis Ciocca <denis.ciocca@st.com>, linux-iio@vger.kernel.org
Cc:     devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        maemo-leste@lists.dyne.org, "Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH v3 3/3] iio: accel: add support for LIS302DL variant
Date:   Mon,  7 Mar 2022 15:25:02 +0200
Message-Id: <20220307132502.73854-4-absicsz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220307132502.73854-1-absicsz@gmail.com>
References: <20220307132502.73854-1-absicsz@gmail.com>
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

Add support for STMicroelectronics LIS302DL accelerometer to the st_accel
framework.

Datasheet: https://www.st.com/resource/en/datasheet/lis302dl.pdf

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
---
 drivers/iio/accel/st_accel.h      | 1 +
 drivers/iio/accel/st_accel_core.c | 1 +
 drivers/iio/accel/st_accel_i2c.c  | 5 +++++
 drivers/iio/accel/st_accel_spi.c  | 5 +++++
 4 files changed, 12 insertions(+)

diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
index 969cc7faca07..0e79dc100ce5 100644
--- a/drivers/iio/accel/st_accel.h
+++ b/drivers/iio/accel/st_accel.h
@@ -36,6 +36,7 @@
 #define LIS3DE_ACCEL_DEV_NAME		"lis3de"
 #define LIS2DE12_ACCEL_DEV_NAME		"lis2de12"
 #define LIS2HH12_ACCEL_DEV_NAME		"lis2hh12"
+#define LIS302DL_ACCEL_DEV_NAME		"lis302dl"
 
 #ifdef CONFIG_IIO_BUFFER
 int st_accel_allocate_ring(struct iio_dev *indio_dev);
diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 31ea19d0ba71..2a353c51c84a 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -444,6 +444,7 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
 		.sensors_supported = {
 			[0] = LIS331DL_ACCEL_DEV_NAME,
+			[1] = LIS302DL_ACCEL_DEV_NAME,
 		},
 		.ch = (struct iio_chan_spec *)st_accel_8bit_channels,
 		.odr = {
diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index c0ce78eebad9..086e8af89e18 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -107,6 +107,10 @@ static const struct of_device_id st_accel_of_match[] = {
 		.compatible = "st,lis2hh12",
 		.data = LIS2HH12_ACCEL_DEV_NAME,
 	},
+	{
+		.compatible = "st,lis302dl",
+		.data = LIS302DL_ACCEL_DEV_NAME,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_accel_of_match);
@@ -142,6 +146,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
 	{ LIS3DE_ACCEL_DEV_NAME },
 	{ LIS2DE12_ACCEL_DEV_NAME },
 	{ LIS2HH12_ACCEL_DEV_NAME },
+	{ LIS302DL_ACCEL_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index b74a1c6d03de..5d77521a8d1e 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -92,6 +92,10 @@ static const struct of_device_id st_accel_of_match[] = {
 		.compatible = "st,lis3de",
 		.data = LIS3DE_ACCEL_DEV_NAME,
 	},
+	{
+		.compatible = "st,lis302dl",
+		.data = LIS302DL_ACCEL_DEV_NAME,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, st_accel_of_match);
@@ -147,6 +151,7 @@ static const struct spi_device_id st_accel_id_table[] = {
 	{ LIS2DW12_ACCEL_DEV_NAME },
 	{ LIS3DHH_ACCEL_DEV_NAME },
 	{ LIS3DE_ACCEL_DEV_NAME },
+	{ LIS302DL_ACCEL_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, st_accel_id_table);
-- 
2.35.1

