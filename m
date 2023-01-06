Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAF465FEF2
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jan 2023 11:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjAFK32 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Jan 2023 05:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbjAFK3H (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 6 Jan 2023 05:29:07 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3918714B2
        for <linux-iio@vger.kernel.org>; Fri,  6 Jan 2023 02:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1673000634;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=09It2ljYBaazxm0zebfnB7EPOA3jETp7tGfj4blzItc=;
    b=ZCjW09kC0YESVNMCPBYGp9ExZdb6ehQGPiYDp9DDj5m2E7nRabU0zWKA/6SkEXiJkg
    Y/NyZBo10zL5v4J/uVlsabP3DY0Egx7DDox805cfa+dT4JOu/C0phZr28q6KL4thVxh5
    O1TiZzTT5L7KNRf1Bf+jLGagxwqW+LQ2ZOwoX9f6ezmXTcGp9Y3YwDZdKi51Zk07Pfxu
    OcmB7pvv6gF4+U8CtSgf0wItszEJZmciS9tWBaaaBMqvi5Wm4ow/Yi7bYlZAl2ZtSqi5
    +yTu9QhSE5iCUTsan2dwbH5B30M/MvWMQUtngJTUbJuMQg1o9eFmB/rQ5gwnDlTTrdNL
    d9YQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXTbAOHjRHIRvweFeMkcg="
X-RZG-CLASS-ID: mo02
Received: from droid..
    by smtp.strato.de (RZmta 48.2.1 DYNA|AUTH)
    with ESMTPSA id Yce349z06ANsqz8
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 6 Jan 2023 11:23:54 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Denis Ciocca <denis.ciocca@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 3/3] iio: magnetometer: st_magn: Add LSM303C
Date:   Fri,  6 Jan 2023 11:22:39 +0100
Message-Id: <20230106102239.9647-4-stephan@gerhold.net>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230106102239.9647-1-stephan@gerhold.net>
References: <20230106102239.9647-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The magnetometer part of ST LSM303C is similar (perhaps even identical)
to the already supported standalone LIS3MDL magnetometer, so just
add the new st,lsm303c-magn compatible for the existing definitions.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/iio/magnetometer/Kconfig        | 2 +-
 drivers/iio/magnetometer/st_magn.h      | 1 +
 drivers/iio/magnetometer/st_magn_core.c | 1 +
 drivers/iio/magnetometer/st_magn_i2c.c  | 5 +++++
 drivers/iio/magnetometer/st_magn_spi.c  | 5 +++++
 5 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 467819335588..38532d840f2a 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -119,7 +119,7 @@ config IIO_ST_MAGN_3AXIS
 	select IIO_TRIGGERED_BUFFER if (IIO_BUFFER)
 	help
 	  Say yes here to build support for STMicroelectronics magnetometers:
-	  LSM303DLHC, LSM303DLM, LIS3MDL.
+	  LSM303C, LSM303DLHC, LSM303DLM, LIS3MDL.
 
 	  Also need to enable at least one of I2C and SPI interface drivers
 	  below.
diff --git a/drivers/iio/magnetometer/st_magn.h b/drivers/iio/magnetometer/st_magn.h
index 785b7f7b8b06..89945984d966 100644
--- a/drivers/iio/magnetometer/st_magn.h
+++ b/drivers/iio/magnetometer/st_magn.h
@@ -22,6 +22,7 @@
 #define LIS2MDL_MAGN_DEV_NAME		"lis2mdl"
 #define LSM9DS1_MAGN_DEV_NAME		"lsm9ds1_magn"
 #define IIS2MDC_MAGN_DEV_NAME		"iis2mdc"
+#define LSM303C_MAGN_DEV_NAME		"lsm303c_magn"
 
 #ifdef CONFIG_IIO_BUFFER
 int st_magn_allocate_ring(struct iio_dev *indio_dev);
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index e2fd233b3626..8faa7409d9e1 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -305,6 +305,7 @@ static const struct st_sensor_settings st_magn_sensors_settings[] = {
 		.sensors_supported = {
 			[0] = LIS3MDL_MAGN_DEV_NAME,
 			[1] = LSM9DS1_MAGN_DEV_NAME,
+			[2] = LSM303C_MAGN_DEV_NAME,
 		},
 		.ch = (struct iio_chan_spec *)st_magn_2_16bit_channels,
 		.odr = {
diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
index b4098d3b3813..cc0e0e94b129 100644
--- a/drivers/iio/magnetometer/st_magn_i2c.c
+++ b/drivers/iio/magnetometer/st_magn_i2c.c
@@ -50,6 +50,10 @@ static const struct of_device_id st_magn_of_match[] = {
 		.compatible = "st,iis2mdc",
 		.data = IIS2MDC_MAGN_DEV_NAME,
 	},
+	{
+		.compatible = "st,lsm303c-magn",
+		.data = LSM303C_MAGN_DEV_NAME,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_magn_of_match);
@@ -97,6 +101,7 @@ static const struct i2c_device_id st_magn_id_table[] = {
 	{ LIS2MDL_MAGN_DEV_NAME },
 	{ LSM9DS1_MAGN_DEV_NAME },
 	{ IIS2MDC_MAGN_DEV_NAME },
+	{ LSM303C_MAGN_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_magn_id_table);
diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
index 6ddc4318564a..f203e1f87eec 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -45,6 +45,10 @@ static const struct of_device_id st_magn_of_match[] = {
 		.compatible = "st,iis2mdc",
 		.data = IIS2MDC_MAGN_DEV_NAME,
 	},
+	{
+		.compatible = "st,lsm303c-magn",
+		.data = LSM303C_MAGN_DEV_NAME,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, st_magn_of_match);
@@ -89,6 +93,7 @@ static const struct spi_device_id st_magn_id_table[] = {
 	{ LIS2MDL_MAGN_DEV_NAME },
 	{ LSM9DS1_MAGN_DEV_NAME },
 	{ IIS2MDC_MAGN_DEV_NAME },
+	{ LSM303C_MAGN_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, st_magn_id_table);
-- 
2.39.0

