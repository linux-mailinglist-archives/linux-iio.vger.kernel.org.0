Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA3D6118C0A
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2019 16:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfLJPIc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Dec 2019 10:08:32 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:33675 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfLJPIb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Dec 2019 10:08:31 -0500
Received: by mail-vk1-f195.google.com with SMTP id i78so5725428vke.0;
        Tue, 10 Dec 2019 07:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mpyOSkP/uUPa1SX92MWe4eY79QgSChJ8/QLAMad9TUw=;
        b=de0WqqemPieJnRZL+8/CwoWAkttk3fSQmySfvr86WmDkc4NhCnWGxkzed79DA75R2X
         WAUPwUaRktIJiE5c3agbWmkzp7sJCkkpN7rqbRvHT/OAYxHnq42APSJy2rMRUAm1Jp7Y
         gswgyXlB6vxmqVsWHQozLdh5A/XLiDD0T25DphyJg0s0za07sptTdyQPmRJImh4QWlvi
         M202t+08O2kLo55ypVYvJJLudbj6TF7hk/eGtNeaqO247au9IgnSb14Kdwczszsj0YGW
         v612bRqZLRWvvIQgEnishZNQ09VuB1nIyKQmNYsoOVgjMVvc4IBWTckui4X1HAhNIJSv
         B4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mpyOSkP/uUPa1SX92MWe4eY79QgSChJ8/QLAMad9TUw=;
        b=S/auEWEC7mXHF41MUAhvUywSER6cgHPdYS13q2cFjmfl7f6teL5z37jMkgLmWD0wJf
         mGvU1WHFE3tZYke7xjQb1dl0rFS+q08NocALacn5nOlFtf0p9kxcQUx6iEakUPwkLI3q
         nvu6f5xKlhT9ngHK5lBMPlPm3SAS3libVz250TgWoixWja4q/1UjQ2zOJCc0sM4gHo9K
         b8Sto5tdlIj4vahc5FWvQ1L2/GXw7P//JjrXZT4WL/HRJBi7eOSC9FzSef/k+zITlx6x
         KjWFB0/XiE0d4IhLtS7XRp57bvDIogXPU7BQ9iE27ssLySof4xOE11G3P62fH9C3R+05
         YwNw==
X-Gm-Message-State: APjAAAW8JtgvErmV7taoK4vlk7JQ0NQod6futJzZHATQEMN9IxGjwAbb
        4GNscwUnCURx9SOzwF2JOFY=
X-Google-Smtp-Source: APXvYqwAO6EEmzF2vwfL4wGhuOhT7ZilSXAEzbJCcfPY/DpsP2x1dVNAK19T1sxojSJ1XcwwLKeFMA==
X-Received: by 2002:a1f:3fc1:: with SMTP id m184mr28819342vka.63.1575990509387;
        Tue, 10 Dec 2019 07:08:29 -0800 (PST)
Received: from brcpsddjunho-l.padtec.com.br (apolo.padtec.com.br. [200.228.158.130])
        by smtp.gmail.com with ESMTPSA id k45sm1986139uae.9.2019.12.10.07.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 07:08:28 -0800 (PST)
From:   Daniel Junho <djunho@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Subject: [PATCH v2 4/4] iio: adc: ad7923: Add support for the ad7908/ad7918/ad7928
Date:   Tue, 10 Dec 2019 12:08:11 -0300
Message-Id: <20191210150811.3429-5-djunho@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210150811.3429-1-djunho@gmail.com>
References: <20191210150811.3429-1-djunho@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ad7928 is software compatible with the ad7923.
The ad7908 and ad7918 are the 8 and 10-bit versions of the ad7928.

Signed-off-by: Daniel Junho <djunho@gmail.com>
---
 drivers/iio/adc/ad7923.c | 62 +++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index 6d56fa0b9e30..ae807fcaad76 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * AD7904/AD7914/AD7923/AD7924 SPI ADC driver
+ * AD7904/AD7914/AD7923/AD7924/AD7908/AD7918/AD7928 SPI ADC driver
  *
  * Copyright 2011 Analog Devices Inc (from AD7923 Driver)
  * Copyright 2012 CS Systemes d'Information
@@ -29,11 +29,14 @@
 #define AD7923_PM_MODE_AS	(1)		/* auto shutdown */
 #define AD7923_PM_MODE_FS	(2)		/* full shutdown */
 #define AD7923_PM_MODE_OPS	(3)		/* normal operation */
-#define AD7923_SEQUENCE_OFF	(0)		/* no sequence fonction */
-#define AD7923_SEQUENCE_PROTECT	(2)		/* no interrupt write cycle */
-#define AD7923_SEQUENCE_ON	(3)		/* continuous sequence */
 
-#define AD7923_MAX_CHAN		4
+#define AD7923_SEQUENCE_OFF	(0x00)		/* no sequence function */
+#define AD7923_SEQUENCE_SHADOW	(0x01)		/* use the shadow register
+						 * for programming
+						 * (only AD7908/7918/7928)
+						 */
+#define AD7923_SEQUENCE_PROTECT	(0x10)		/* no interrupt write cycle */
+#define AD7923_SEQUENCE_ON	(0x11)		/* continuous sequence */
 
 #define AD7923_PM_MODE_WRITE(mode)	((mode) << 4)	 /* write mode */
 #define AD7923_CHANNEL_WRITE(channel)	((channel) << 6) /* write channel */
@@ -74,6 +77,9 @@ enum ad7923_id {
 	AD7904,
 	AD7914,
 	AD7924,
+	AD7908,
+	AD7918,
+	AD7928
 };
 
 #define AD7923_V_CHAN(index, bits)					\
@@ -93,7 +99,7 @@ enum ad7923_id {
 		},							\
 	}
 
-#define DECLARE_AD7923_CHANNELS(name, bits) \
+#define DECLARE_AD7923_4CHANNELS(name, bits) \
 const struct iio_chan_spec name ## _channels[] = { \
 	AD7923_V_CHAN(0, bits), \
 	AD7923_V_CHAN(1, bits), \
@@ -102,9 +108,25 @@ const struct iio_chan_spec name ## _channels[] = { \
 	IIO_CHAN_SOFT_TIMESTAMP(4), \
 }
 
-static DECLARE_AD7923_CHANNELS(ad7904, 8);
-static DECLARE_AD7923_CHANNELS(ad7914, 10);
-static DECLARE_AD7923_CHANNELS(ad7924, 12);
+#define DECLARE_AD7923_8CHANNELS(name, bits) \
+const struct iio_chan_spec name ## _channels[] = { \
+	AD7923_V_CHAN(0, bits), \
+	AD7923_V_CHAN(1, bits), \
+	AD7923_V_CHAN(2, bits), \
+	AD7923_V_CHAN(3, bits), \
+	AD7923_V_CHAN(4, bits), \
+	AD7923_V_CHAN(5, bits), \
+	AD7923_V_CHAN(6, bits), \
+	AD7923_V_CHAN(7, bits), \
+	IIO_CHAN_SOFT_TIMESTAMP(8), \
+}
+
+static DECLARE_AD7923_4CHANNELS(ad7904, 8);
+static DECLARE_AD7923_4CHANNELS(ad7914, 10);
+static DECLARE_AD7923_4CHANNELS(ad7924, 12);
+static DECLARE_AD7923_8CHANNELS(ad7908, 8);
+static DECLARE_AD7923_8CHANNELS(ad7918, 10);
+static DECLARE_AD7923_8CHANNELS(ad7928, 12);
 
 static const struct ad7923_chip_info ad7923_chip_info[] = {
 	[AD7904] = {
@@ -119,6 +141,18 @@ static const struct ad7923_chip_info ad7923_chip_info[] = {
 		.channels = ad7924_channels,
 		.num_channels = ARRAY_SIZE(ad7924_channels),
 	},
+	[AD7908] = {
+		.channels = ad7908_channels,
+		.num_channels = ARRAY_SIZE(ad7908_channels),
+	},
+	[AD7918] = {
+		.channels = ad7918_channels,
+		.num_channels = ARRAY_SIZE(ad7918_channels),
+	},
+	[AD7928] = {
+		.channels = ad7928_channels,
+		.num_channels = ARRAY_SIZE(ad7928_channels),
+	},
 };
 
 /**
@@ -131,7 +165,7 @@ static int ad7923_update_scan_mode(struct iio_dev *indio_dev,
 	int i, cmd, len;
 
 	len = 0;
-	for_each_set_bit(i, active_scan_mask, AD7923_MAX_CHAN) {
+	for_each_set_bit(i, active_scan_mask, indio_dev->num_channels - 1) {
 		cmd = AD7923_WRITE_CR | AD7923_CHANNEL_WRITE(i) |
 			AD7923_SEQUENCE_WRITE(AD7923_SEQUENCE_OFF) |
 			st->settings;
@@ -344,6 +378,9 @@ static const struct spi_device_id ad7923_id[] = {
 	{"ad7914", AD7914},
 	{"ad7923", AD7924},
 	{"ad7924", AD7924},
+	{"ad7908", AD7908},
+	{"ad7918", AD7918},
+	{"ad7928", AD7928},
 	{}
 };
 MODULE_DEVICE_TABLE(spi, ad7923_id);
@@ -353,6 +390,9 @@ static const struct of_device_id ad7923_of_match[] = {
 	{ .compatible = "adi,ad7914", },
 	{ .compatible = "adi,ad7923", },
 	{ .compatible = "adi,ad7924", },
+	{ .compatible = "adi,ad7908", },
+	{ .compatible = "adi,ad7918", },
+	{ .compatible = "adi,ad7928", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, ad7923_of_match);
@@ -370,5 +410,5 @@ module_spi_driver(ad7923_driver);
 
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_AUTHOR("Patrick Vasseur <patrick.vasseur@c-s.fr>");
-MODULE_DESCRIPTION("Analog Devices AD7904/AD7914/AD7923/AD7924 ADC");
+MODULE_DESCRIPTION("Analog Devices AD7904/AD7914/AD7923/AD7924/AD7908/AD7918/AD7928 ADC");
 MODULE_LICENSE("GPL v2");
-- 
2.24.0

