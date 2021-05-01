Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446BB370737
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 14:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhEAMds (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 08:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbhEAMds (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 May 2021 08:33:48 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A87EC06174A;
        Sat,  1 May 2021 05:32:58 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id 197so569376qkl.12;
        Sat, 01 May 2021 05:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kPtNXjXvjkrqon+4H86GtiLH1axTObT0uyPlkm/H220=;
        b=tLA24VRrlFrINRcCb6JlqNKPNqPq4XNfYV4R7Cu5bIWw6YCQNtHM/LZmejRf+Hyrcc
         zNubA9mAH34e/RhVcuyHeUXWzSNi1bnFj/aOdp7TOGV4rzgxYH54A4PdqEmBm99/EnXC
         BUbE0qpnJsrgaMF0IZjFVwBPYpdc9Rcg1jDEjrj4pYq7o/s5j3btKzr0gVdmmrtojqEx
         8wbKkZpBByN0d/iMn3s3cFrJKWVSOuFJKuOPFnQY5o+tm346Rr0yv7mpVb9sWeT8x1U9
         SPAttUFz8BqJ3E7NjYIkOylngZ0pqH4z8X7gtysbf6R2yZQ+9aISpIMTcRFqDKoM6dB0
         pL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kPtNXjXvjkrqon+4H86GtiLH1axTObT0uyPlkm/H220=;
        b=lkqz5Q1BbHSbD9EQJRJW0qw4VLKQmnZBayXFUiX6ZKaZf9s/DeS0wfdr1x0NBb9r1Y
         B6CxAszv6bZ8ETpx9+MIODOlm2XM4rwEFbcnRPlS4jdIRP5aIyClptuJ10gzIuxbPaLd
         szfurlUfOfjj56Y1knr5GLSbghTfyeRpDpapIZENqreMUWw+18PynWws9okcoABJZsCV
         Y0/mMxeWdUYwuP5QPHBwujWCbH6nosIMZsNVxmChW5DLyXMUzwkin4pjNCh/MvOfhPgc
         UUEjzlPcSJNsfHsflyjmN1g7ZLjU/uhpO3SgWIssDkMN4PihLt7VPh9mNda1PJacX0zT
         cgmw==
X-Gm-Message-State: AOAM531B80OLcFQZzs1y4xFIhXBctvqfZ6Bs58oMNQCnyVyC2ts6sien
        eFQaXh1cDTVbEB2MAlSvhQ5ZmYN83mQcdSKU
X-Google-Smtp-Source: ABdhPJy6LjkvImlLa098W6SbeaZfLI6+Z3nKozTVLO/pDe82cTZtDLc0bqx7C0Y+JXWHbOIXERuGbw==
X-Received: by 2002:a05:620a:389:: with SMTP id q9mr1279091qkm.16.1619872377484;
        Sat, 01 May 2021 05:32:57 -0700 (PDT)
Received: from smtp.gmail.com ([2804:14c:73:9a01::1001])
        by smtp.gmail.com with ESMTPSA id f7sm4275201qtv.53.2021.05.01.05.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 May 2021 05:32:57 -0700 (PDT)
Date:   Sat, 1 May 2021 09:32:53 -0300
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 2/2] staging: iio: cdc: ad7746: use dt for capacitive
 channel setup.
Message-ID: <3e7f2a0a8960cece185f518ff2b7ceb87891edcd.1619841953.git.lucas.p.stankus@gmail.com>
References: <cover.1619841953.git.lucas.p.stankus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1619841953.git.lucas.p.stankus@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Ditch platform_data fields in favor of device tree properties for
configuring EXCA and EXCB output pins and setting the capacitive channel
excitation level.

As this covers all current use cases for the platform_data struct, remove
ad7746.h header file since it's no longer needed.

Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
---
 drivers/staging/iio/cdc/ad7746.c | 54 +++++++++++++++++++-------------
 drivers/staging/iio/cdc/ad7746.h | 28 -----------------
 2 files changed, 33 insertions(+), 49 deletions(-)
 delete mode 100644 drivers/staging/iio/cdc/ad7746.h

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index dfd71e99e872..531f1b96dea2 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -18,8 +18,6 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-#include "ad7746.h"
-
 /*
  * AD7746 Register Definition
  */
@@ -676,10 +674,11 @@ static const struct iio_info ad7746_info = {
 static int ad7746_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
-	struct ad7746_platform_data *pdata = client->dev.platform_data;
+	struct device *dev = &client->dev;
 	struct ad7746_chip_info *chip;
 	struct iio_dev *indio_dev;
 	unsigned char regval = 0;
+	unsigned int vdd_permille;
 	int ret = 0;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
@@ -703,26 +702,39 @@ static int ad7746_probe(struct i2c_client *client,
 	indio_dev->num_channels = ARRAY_SIZE(ad7746_channels);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	if (pdata) {
-		if (pdata->exca_en) {
-			if (pdata->exca_inv_en)
-				regval |= AD7746_EXCSETUP_NEXCA;
-			else
-				regval |= AD7746_EXCSETUP_EXCA;
-		}
+	if (device_property_read_bool(dev, "adi,exca-output-en")) {
+		if (device_property_read_bool(dev, "adi,exca-output-invert"))
+			regval |= AD7746_EXCSETUP_NEXCA;
+		else
+			regval |= AD7746_EXCSETUP_EXCA;
+	}
 
-		if (pdata->excb_en) {
-			if (pdata->excb_inv_en)
-				regval |= AD7746_EXCSETUP_NEXCB;
-			else
-				regval |= AD7746_EXCSETUP_EXCB;
-		}
+	if (device_property_read_bool(dev, "adi,excb-output-en")) {
+		if (device_property_read_bool(dev, "adi,excb-output-invert"))
+			regval |= AD7746_EXCSETUP_NEXCB;
+		else
+			regval |= AD7746_EXCSETUP_EXCB;
+	}
 
-		regval |= AD7746_EXCSETUP_EXCLVL(pdata->exclvl);
-	} else {
-		dev_warn(&client->dev, "No platform data? using default\n");
-		regval = AD7746_EXCSETUP_EXCA | AD7746_EXCSETUP_EXCB |
-			AD7746_EXCSETUP_EXCLVL(3);
+	ret = device_property_read_u32(dev, "adi,excitation-vdd-permille",
+				       &vdd_permille);
+	if (!ret) {
+		switch (vdd_permille) {
+		case 125:
+			regval |= AD7746_EXCSETUP_EXCLVL(0);
+			break;
+		case 250:
+			regval |= AD7746_EXCSETUP_EXCLVL(1);
+			break;
+		case 375:
+			regval |= AD7746_EXCSETUP_EXCLVL(2);
+			break;
+		case 500:
+			regval |= AD7746_EXCSETUP_EXCLVL(3);
+			break;
+		default:
+			break;
+		}
 	}
 
 	ret = i2c_smbus_write_byte_data(chip->client,
diff --git a/drivers/staging/iio/cdc/ad7746.h b/drivers/staging/iio/cdc/ad7746.h
deleted file mode 100644
index 8bdbd732dbbd..000000000000
--- a/drivers/staging/iio/cdc/ad7746.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * AD7746 capacitive sensor driver supporting AD7745, AD7746 and AD7747
- *
- * Copyright 2011 Analog Devices Inc.
- */
-
-#ifndef IIO_CDC_AD7746_H_
-#define IIO_CDC_AD7746_H_
-
-/*
- * TODO: struct ad7746_platform_data needs to go into include/linux/iio
- */
-
-#define AD7466_EXCLVL_0		0 /* +-VDD/8 */
-#define AD7466_EXCLVL_1		1 /* +-VDD/4 */
-#define AD7466_EXCLVL_2		2 /* +-VDD * 3/8 */
-#define AD7466_EXCLVL_3		3 /* +-VDD/2 */
-
-struct ad7746_platform_data {
-	unsigned char exclvl;	/*Excitation Voltage Level */
-	bool exca_en;		/* enables EXCA pin as the excitation output */
-	bool exca_inv_en;	/* enables /EXCA pin as the excitation output */
-	bool excb_en;		/* enables EXCB pin as the excitation output */
-	bool excb_inv_en;	/* enables /EXCB pin as the excitation output */
-};
-
-#endif /* IIO_CDC_AD7746_H_ */
-- 
2.31.1

