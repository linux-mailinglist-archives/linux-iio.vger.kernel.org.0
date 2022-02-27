Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6034C5F75
	for <lists+linux-iio@lfdr.de>; Sun, 27 Feb 2022 23:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiB0Wh1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Feb 2022 17:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiB0Wh0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Feb 2022 17:37:26 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E9A53732
        for <linux-iio@vger.kernel.org>; Sun, 27 Feb 2022 14:36:48 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id h15so15042773edv.7
        for <linux-iio@vger.kernel.org>; Sun, 27 Feb 2022 14:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=0MIS8mZRf6AwfXxkTGIOqZXzbEmruvhZqQy0CTXqLXw=;
        b=AWFB0j6wuuH7Yg6REll0KGyI/SR/S1y9ariuZjT7g/9TA4Bw4AsHqj5EEFER6xdKuy
         rHB7ePhOBIOUzxncsZgQtFOtAbFLLId27ubkw7pDGuqDKZVfyNdGA/VdXPB3EIwXsvoL
         zj7zpv3cauWFG2GfntCwFiyQki6BTOMfADskGJIQhu5782S4/HQ0UJFXkDsJ3gwSefDH
         ZyMsXGBp7hsH4meLrYlfk4yr5RZgYJi06sA2pd8eg3LSh5HRWMA2BA4vgrjF8puyLT1j
         Qm580bKvZCVZyPnbMKHFsTk7WfVDR9Hr/OUDTUrDGsN19Yn+C5cuZUnbwdkEGGOXbiOu
         22rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=0MIS8mZRf6AwfXxkTGIOqZXzbEmruvhZqQy0CTXqLXw=;
        b=uu+ZTMT9Arnpw/PMexxt6x2mny6wQv/VRIieHE3crHsGLguSNP9LDZmkUqcavUITYt
         ex51DFnOI84VNupjPaAT2bi4vRTB9tbXjUc8InboqSzWAEVESJwF47xTwg2rEl5b75f1
         IW0FemYfFJkIt7hzLRw2Wk4u0l1FIRLBV5uvabJX4FKC4UTjGpxDg14YFzsgoH8cfXgE
         QA2klCWaPFLecEbLpFEyiNX2sxEbZwawMTEGcBmiic1Z3fN656TGuEEv/ZdvZ50A0fV4
         2J67zdRjPS63tLRkEVq2Cbxyvb2D0rXumGislHCppVV5xIhFF9CihPitj9OIGzBpeHKt
         v40Q==
X-Gm-Message-State: AOAM531FuAilx4fd/HHtHYOkVRfT3oc9nAIaN8WWVj7IMn4g8JV/A6hK
        LbbZlMR57hqK7nIWGXimeDs=
X-Google-Smtp-Source: ABdhPJyrBL+uDZl8QwNE7IfsK0KkwRq0JCqefzEvhhZnCCmuPqPdXRdwqWts69SOnjn6q1fNEh60Og==
X-Received: by 2002:a50:d75e:0:b0:413:60fc:f97d with SMTP id i30-20020a50d75e000000b0041360fcf97dmr15620357edj.137.1646001407294;
        Sun, 27 Feb 2022 14:36:47 -0800 (PST)
Received: from tp440p.steeds.sam ([69.63.75.250])
        by smtp.gmail.com with ESMTPSA id n19-20020a170906165300b006a625c583b9sm3818093ejd.155.2022.02.27.14.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 14:36:46 -0800 (PST)
Date:   Mon, 28 Feb 2022 00:36:42 +0200
From:   "Sicelo A. Mhlongo" <absicsz@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/2] iio: accel: add support for LIS302DL variant
Message-ID: <Yhv8+py8uAj2j6FX@tp440p.steeds.sam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

https://www.st.com/resource/en/datasheet/lis302dl.pdf

Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
---
 drivers/iio/accel/st_accel.h      | 2 ++
 drivers/iio/accel/st_accel_core.c | 1 +
 drivers/iio/accel/st_accel_i2c.c  | 5 +++++
 3 files changed, 8 insertions(+)

diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
index 8750dea56fcb..15f4b7944362 100644
--- a/drivers/iio/accel/st_accel.h
+++ b/drivers/iio/accel/st_accel.h
@@ -37,6 +37,7 @@ enum st_accel_type {
 	LIS2DE12,
 	LIS2HH12,
 	ST_ACCEL_MAX,
+	LIS302DL,
 };
 
 #define H3LIS331DL_ACCEL_DEV_NAME	"h3lis331dl_accel"
@@ -61,6 +62,7 @@ enum st_accel_type {
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
-- 
2.35.1

