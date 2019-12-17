Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8170122998
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2019 12:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfLQLMT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Dec 2019 06:12:19 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39470 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfLQLMS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Dec 2019 06:12:18 -0500
Received: by mail-pj1-f66.google.com with SMTP id v11so503677pjb.6;
        Tue, 17 Dec 2019 03:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=J0n454KnKg0Yc+bUS3no/ANTSoAZTXltdRIhNnO6eoo=;
        b=bIesV/oYgstBVWDyuwRFe1X6bV0ShbctC64iI0sR5AKtWNOJBE5AALWlLCl4o72vnP
         q56oRYjZNy2HjQ1jkibmnYdf+SL0qxADvzHAn/hJ1+wF7oHtgs0hEjF/7N2DByTqOTZS
         W+chM93scIqJj1Vg7SguhrGlwDiCOsGeWkTvfbG6GGR0xa0ciBal+cM20HSXWNCcxJPQ
         sEKGRHZ3XMUj1tDGUQ8bMSNAMrRShgezyfTKLq0fNZ+Qv4OOOJ41VauGb7TB7HWt+FmI
         vk5wPe+O1iSF1Qcr45jMRauOIiB/eiUt1/7k+7/2GdiAx0c7H2+qSj9rho7821IeuE0t
         6IdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J0n454KnKg0Yc+bUS3no/ANTSoAZTXltdRIhNnO6eoo=;
        b=c3Sp81wDb2yIhT4KX35GogENm1AKG3mnIuJOb+ONMPdCWVSbcwEVZbvCn+NRnOigb/
         3Bcq5oBWK0ZSRIybE+6jdejllh+G7/xw9A+Eqhw7CSvsE6MjuhcScvPL8wUj9y0r90Cd
         VDICnpMtS3AyOVr3L4+2aTLqP2qWafi208MiTr4MZ1/zIE6632jXZ8gSi9m/H8zu1/Gi
         SaExVHsJuMN5ZZ5dJ+m+HTh9YXv/vhFKO/t9Mii+oBhmoVvxz1J1Yf4/0TzwMUdodtv1
         FGOInHgju2y6oQdl2U6fui1NUbMBFpszaOTqp3UP3RclqOjiVIfRTtjZ66yAfGzwBWyy
         N/xw==
X-Gm-Message-State: APjAAAXxab7O3Xyg8pYpmx/5kzfWQFBu04S8GEr5RN9nhkYA7WJnat0G
        i0q/fnS/aMugIdVB1PeAXO8=
X-Google-Smtp-Source: APXvYqz3ETSIvhjvJN/qT4R3kYd+peU/mNtmbK96NtL5LTuU+DeVmBRk0OVJOE0sPObNFMQbDQHDqQ==
X-Received: by 2002:a17:90a:20c4:: with SMTP id f62mr5470172pjg.70.1576581137900;
        Tue, 17 Dec 2019 03:12:17 -0800 (PST)
Received: from brcpsddjunho-l.padtec.com.br (apolo.padtec.com.br. [200.228.158.130])
        by smtp.gmail.com with ESMTPSA id 81sm25855190pfx.73.2019.12.17.03.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 03:12:17 -0800 (PST)
From:   Daniel Junho <djunho@gmail.com>
To:     "Jonathan Cameron" <jic23@kernel.org>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "lkcamp@lists.libreplanetbr.org" <lkcamp@lists.libreplanetbr.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: [PATCH v3 4/4] iio: adc: ad7923: Add support for the ad7908/ad7918/ad7928
Date:   Tue, 17 Dec 2019 08:11:58 -0300
Message-Id: <20191217111158.30888-5-djunho@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217111158.30888-1-djunho@gmail.com>
References: <20191217111158.30888-1-djunho@gmail.com>
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
 drivers/iio/adc/ad7923.c | 57 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index 6d56fa0b9e30..1077036d1ed8 100644
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
@@ -29,11 +29,13 @@
 #define AD7923_PM_MODE_AS	(1)		/* auto shutdown */
 #define AD7923_PM_MODE_FS	(2)		/* full shutdown */
 #define AD7923_PM_MODE_OPS	(3)		/* normal operation */
-#define AD7923_SEQUENCE_OFF	(0)		/* no sequence fonction */
-#define AD7923_SEQUENCE_PROTECT	(2)		/* no interrupt write cycle */
-#define AD7923_SEQUENCE_ON	(3)		/* continuous sequence */
 
-#define AD7923_MAX_CHAN		4
+#define AD7923_SEQUENCE_OFF	(0x00)		/* no sequence function */
+#define AD7908_SEQUENCE_SHADOW	(0x01)		/* use the shadow register
+						 * for programming
+						 */
+#define AD7923_SEQUENCE_PROTECT	(0x10)		/* no interrupt write cycle */
+#define AD7923_SEQUENCE_ON	(0x11)		/* continuous sequence */
 
 #define AD7923_PM_MODE_WRITE(mode)	((mode) << 4)	 /* write mode */
 #define AD7923_CHANNEL_WRITE(channel)	((channel) << 6) /* write channel */
@@ -74,6 +76,9 @@ enum ad7923_id {
 	AD7904,
 	AD7914,
 	AD7924,
+	AD7908,
+	AD7918,
+	AD7928
 };
 
 #define AD7923_V_CHAN(index, bits)					\
@@ -102,9 +107,25 @@ const struct iio_chan_spec name ## _channels[] = { \
 	IIO_CHAN_SOFT_TIMESTAMP(4), \
 }
 
+#define DECLARE_AD7908_CHANNELS(name, bits) \
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
 static DECLARE_AD7923_CHANNELS(ad7904, 8);
 static DECLARE_AD7923_CHANNELS(ad7914, 10);
 static DECLARE_AD7923_CHANNELS(ad7924, 12);
+static DECLARE_AD7908_CHANNELS(ad7908, 8);
+static DECLARE_AD7908_CHANNELS(ad7918, 10);
+static DECLARE_AD7908_CHANNELS(ad7928, 12);
 
 static const struct ad7923_chip_info ad7923_chip_info[] = {
 	[AD7904] = {
@@ -119,6 +140,18 @@ static const struct ad7923_chip_info ad7923_chip_info[] = {
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
@@ -131,7 +164,11 @@ static int ad7923_update_scan_mode(struct iio_dev *indio_dev,
 	int i, cmd, len;
 
 	len = 0;
-	for_each_set_bit(i, active_scan_mask, AD7923_MAX_CHAN) {
+	/*
+	 * For this driver the last channel is always the software timestamp so
+	 * skip that one.
+	 */
+	for_each_set_bit(i, active_scan_mask, indio_dev->num_channels - 1) {
 		cmd = AD7923_WRITE_CR | AD7923_CHANNEL_WRITE(i) |
 			AD7923_SEQUENCE_WRITE(AD7923_SEQUENCE_OFF) |
 			st->settings;
@@ -344,6 +381,9 @@ static const struct spi_device_id ad7923_id[] = {
 	{"ad7914", AD7914},
 	{"ad7923", AD7924},
 	{"ad7924", AD7924},
+	{"ad7908", AD7908},
+	{"ad7918", AD7918},
+	{"ad7928", AD7928},
 	{}
 };
 MODULE_DEVICE_TABLE(spi, ad7923_id);
@@ -353,6 +393,9 @@ static const struct of_device_id ad7923_of_match[] = {
 	{ .compatible = "adi,ad7914", },
 	{ .compatible = "adi,ad7923", },
 	{ .compatible = "adi,ad7924", },
+	{ .compatible = "adi,ad7908", },
+	{ .compatible = "adi,ad7918", },
+	{ .compatible = "adi,ad7928", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, ad7923_of_match);
@@ -370,5 +413,5 @@ module_spi_driver(ad7923_driver);
 
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_AUTHOR("Patrick Vasseur <patrick.vasseur@c-s.fr>");
-MODULE_DESCRIPTION("Analog Devices AD7904/AD7914/AD7923/AD7924 ADC");
+MODULE_DESCRIPTION("Analog Devices AD7923 and similar ADC");
 MODULE_LICENSE("GPL v2");
-- 
2.24.1

