Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DC36AC9F3
	for <lists+linux-iio@lfdr.de>; Mon,  6 Mar 2023 18:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjCFRY6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Mar 2023 12:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjCFRYn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Mar 2023 12:24:43 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31B319BB;
        Mon,  6 Mar 2023 09:24:14 -0800 (PST)
Received: from stefanw-SCHENKER ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MCbR7-1phj0q3Nit-009jEz; Mon, 06 Mar 2023 18:23:15 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     linux-imx@nxp.com, Li Yang <leoyang.li@nxp.com>,
        Denis Ciocca <denis.ciocca@st.com>, soc@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 5/8] iio: accel: add support for IIS328DQ variant
Date:   Mon,  6 Mar 2023 18:22:46 +0100
Message-Id: <20230306172249.74003-6-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230306172249.74003-1-stefan.wahren@i2se.com>
References: <20230306172249.74003-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8pOSVs5pr3qo5I8gRJ4mnb4mzsthHgbkNTMbUsy+rAaH8Tcqei4
 1nJJeYoOAlsnTs5CYx7U1BlLvzhb8SGehE1/OZn5fRLsm9jU7byYi5dcZ1jyaoaxkBZd9IX
 NTz7ElNVj2hIwUyMvNtjnSUwD5Mv7zp5Bs1Z4R96niKL6ZS5TiZ+mKuPzUecb38L5hShpV1
 G9g7EXMnmqV+QmXt86snA==
UI-OutboundReport: notjunk:1;M01:P0:fM4cGhjX5pQ=;mYVjZZF4EHnRj4w9nP3pgwXdpQo
 Uu4UFtqJ0Z4bLWHJXbmPytqy+ZKE9PjjuQceU78q38Le8d7IBTY4FqbAmSsiUJCWw95FX67Uu
 k1sSLcuA988IPrv/sVwaWInbnb9FlnpYsrMAsducYLcSbSXywXfV2SHR5l5btL1/kUMEFZRfL
 gzbLun9b77TJ43q99SwbNnSdbrwAmHtVaRXnxuzENv6hQnyPFVGUwdYsQshPSlEimuxrW7zoT
 M4wSc72OHiDvK96uc2jVH3V4dR1jTMvJiuUjyv9UwC9B8OetEsDJ4dccJBR7qioi7VjLkBKs/
 xrN5mZPPFDXLO/8T3xE9TUxxxRLvn0NIlBCcrXDxm99bRioftulHqhMr8ROdJN+3FvUik9jQ1
 3rQYQruPeoWnig2Ko97ykVaeJRy9Zu9JS3871qVabbnfqJjQnHlSQwJ6wuSYx/klTGOJtT6qp
 rohdMEC48DeUb5ImxmpafLOIgA8PsDzeWCD9kRxdOsdnppOrgMJ8axVN2zlp8E+hSuO9izGro
 fPBKAISUdP6CcCPjGn6E5JXyeGMqA+r3pYvBr2TLGIPN15cJHWlOHebnnCOLYP9e8FthgVunV
 gME1geY/bYGTiRF04z02WNMpud89Tpw3/aOwGxr9I4Hp/FIV3Q+adjohlkGfsUR30tN20sMQ6
 ohriQqezf6Ssj3TCNuf1nwtkVAoCr0Z14dSlWUO2Kg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Stefan Wahren <stefan.wahren@chargebyte.com>

Add support for ST IIS328DQ accelerometer to the st_accel framework.
The chip is compatible to the LIS331DL.

Link: https://www.st.com/resource/en/datasheet/iis328dq.pdf
Signed-off-by: Stefan Wahren <stefan.wahren@chargebyte.com>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/iio/accel/st_accel.h      | 1 +
 drivers/iio/accel/st_accel_core.c | 1 +
 drivers/iio/accel/st_accel_i2c.c  | 5 +++++
 drivers/iio/accel/st_accel_spi.c  | 5 +++++
 4 files changed, 12 insertions(+)

diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
index 56ed0c776d4a..e7525615712b 100644
--- a/drivers/iio/accel/st_accel.h
+++ b/drivers/iio/accel/st_accel.h
@@ -39,6 +39,7 @@
 #define LIS302DL_ACCEL_DEV_NAME		"lis302dl"
 #define LSM303C_ACCEL_DEV_NAME		"lsm303c_accel"
 #define SC7A20_ACCEL_DEV_NAME		"sc7a20"
+#define IIS328DQ_ACCEL_DEV_NAME		"iis328dq"
 
 
 #ifdef CONFIG_IIO_BUFFER
diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 6b8562f684d5..5f7d81b44b1d 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -517,6 +517,7 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
 		.sensors_supported = {
 			[0] = H3LIS331DL_ACCEL_DEV_NAME,
+			[1] = IIS328DQ_ACCEL_DEV_NAME,
 		},
 		.ch = (struct iio_chan_spec *)st_accel_12bit_channels,
 		.odr = {
diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index 3f02fd5d5946..fb9e2d6f4210 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -119,6 +119,10 @@ static const struct of_device_id st_accel_of_match[] = {
 		.compatible = "silan,sc7a20",
 		.data = SC7A20_ACCEL_DEV_NAME,
 	},
+	{
+		.compatible = "st,iis328dq",
+		.data = IIS328DQ_ACCEL_DEV_NAME,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_accel_of_match);
@@ -157,6 +161,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
 	{ LIS302DL_ACCEL_DEV_NAME },
 	{ LSM303C_ACCEL_DEV_NAME },
 	{ SC7A20_ACCEL_DEV_NAME },
+	{ IIS328DQ_ACCEL_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index 5740dc1820bd..f72a24f45322 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -100,6 +100,10 @@ static const struct of_device_id st_accel_of_match[] = {
 		.compatible = "st,lsm303c-accel",
 		.data = LSM303C_ACCEL_DEV_NAME,
 	},
+	{
+		.compatible = "st,iis328dq",
+		.data = IIS328DQ_ACCEL_DEV_NAME,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, st_accel_of_match);
@@ -157,6 +161,7 @@ static const struct spi_device_id st_accel_id_table[] = {
 	{ LIS3DE_ACCEL_DEV_NAME },
 	{ LIS302DL_ACCEL_DEV_NAME },
 	{ LSM303C_ACCEL_DEV_NAME },
+	{ IIS328DQ_ACCEL_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, st_accel_id_table);
-- 
2.34.1

