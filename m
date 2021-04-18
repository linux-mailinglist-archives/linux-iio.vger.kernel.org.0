Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B264736384A
	for <lists+linux-iio@lfdr.de>; Mon, 19 Apr 2021 00:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbhDRWuo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Apr 2021 18:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbhDRWuo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Apr 2021 18:50:44 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0CAC06174A;
        Sun, 18 Apr 2021 15:50:15 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id h13so15530018qka.2;
        Sun, 18 Apr 2021 15:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wcWDiwCpYfyH8K6iVxPxXWa9oUIaLJ4C5jPgocQtTJM=;
        b=UXO/9nEbAZqN+HAFONizIKnHQ9c7OPry28nC7S6rFPREijaRAPi80t5pV0oVgSR7CC
         DWWGu1rE24g+v0z1j+ISNIINKYoP528Al5PggpIA8xTyf4eIuTLAyLlmdLSvOymsXHoq
         BcB+HU64/keoS+i+f4BQTTJ7P/0uK02pgpF+J9G9+j4wkjLbcZNNq2CUo+hpYoSk1h6b
         TA9JeEyWWK0h1YbRcZLkiCmd0I2Ys0+rL5cti0o0nA2dCxTH40ib6nUPpYvxmzrRFa+V
         kIC/oSKSEx0/t4YlpiKw0UFqicbSFeOP2saafNH9GPCCd38ccHD+3/DKbyGh/4eHxF1/
         3vnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wcWDiwCpYfyH8K6iVxPxXWa9oUIaLJ4C5jPgocQtTJM=;
        b=H2Uz5oOfPheDU3uet0ppeq/vjtenUBJI/QspzjCYmI6+FkBou9D4bz/CABRGWN6uHh
         jfat4P0QwBvSb6MCIVkikbfWqhSBox8pPuPZKMXQD3i0cxsI2uDqTFnHgIa645ow2jon
         2p+P1baZsQ8R8zAZ5F81Zy0AqwoPjNx6S2DnM9r9NUuGiSJUiz2ADRed0Gfq4sv0Mkn7
         NpT6Afwd69+pbZMCFxP+SO5hHFa4dO5tPkA14B3VlBEaC8eoEiiXLSSHFBDYk1tonGE5
         Zaozyn1wXljgwYpK8RvbkWZLoISa4HgscViIVtQgQ+IiiyNomqbHZKO39vt3TNNjZPpB
         W3Lg==
X-Gm-Message-State: AOAM531L5NJSHvdzVyxOA/fq67DrnTcqpjM4de1zmGrvvBbwkY5HaHg/
        XaSb2r8cyhvtPqsy03Fgicg=
X-Google-Smtp-Source: ABdhPJxvsPAWqwC91PTtKTHRNbJG429ZsUwL6xQuo8e7mJ7qovTlSlh8Y9E2s22RSAwPsLz6Ay6xDQ==
X-Received: by 2002:a37:848:: with SMTP id 69mr391976qki.119.1618786214698;
        Sun, 18 Apr 2021 15:50:14 -0700 (PDT)
Received: from smtp.gmail.com ([2804:14c:73:9a01::1003])
        by smtp.gmail.com with ESMTPSA id l14sm4785974qkp.56.2021.04.18.15.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 15:50:14 -0700 (PDT)
Date:   Sun, 18 Apr 2021 19:50:10 -0300
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 2/2] staging: iio: cdc: ad7746: use dt for capacitive
 channel setup.
Message-ID: <b0132613b82b17d63c8a91556c2c424015f202db.1618785336.git.lucas.p.stankus@gmail.com>
References: <cover.1618785336.git.lucas.p.stankus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618785336.git.lucas.p.stankus@gmail.com>
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

Changes in v2:
Previously this change set was composed of two patches, but it lead to
regressions between the two. Merging them avoids the unwanted behaviour
without having to deal with the special cases.

 drivers/staging/iio/cdc/ad7746.c | 42 +++++++++++++++-----------------
 drivers/staging/iio/cdc/ad7746.h | 28 ---------------------
 2 files changed, 19 insertions(+), 51 deletions(-)
 delete mode 100644 drivers/staging/iio/cdc/ad7746.h

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index dfd71e99e872..c0e84c1cf4f1 100644
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
@@ -66,7 +64,7 @@
 #define AD7746_EXCSETUP_NEXCB		BIT(4)
 #define AD7746_EXCSETUP_EXCA		BIT(3)
 #define AD7746_EXCSETUP_NEXCA		BIT(2)
-#define AD7746_EXCSETUP_EXCLVL(x)	(((x) & 0x3) << 0)
+#define AD7746_EXCSETUP_EXCLVL(x)	(((x) >> 7) & 0x3)
 
 /* Config Register Bit Designations (AD7746_REG_CFG) */
 #define AD7746_CONF_VTFS_SHIFT		6
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
@@ -703,28 +702,25 @@ static int ad7746_probe(struct i2c_client *client,
 	indio_dev->num_channels = ARRAY_SIZE(ad7746_channels);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	if (pdata) {
-		if (pdata->exca_en) {
-			if (pdata->exca_inv_en)
-				regval |= AD7746_EXCSETUP_NEXCA;
-			else
-				regval |= AD7746_EXCSETUP_EXCA;
-		}
-
-		if (pdata->excb_en) {
-			if (pdata->excb_inv_en)
-				regval |= AD7746_EXCSETUP_NEXCB;
-			else
-				regval |= AD7746_EXCSETUP_EXCB;
-		}
+	if (device_property_read_bool(dev, "adi,exca-output-en")) {
+		if (device_property_read_bool(dev, "adi,exca-output-invert"))
+			regval |= AD7746_EXCSETUP_NEXCA;
+		else
+			regval |= AD7746_EXCSETUP_EXCA;
+	}
 
-		regval |= AD7746_EXCSETUP_EXCLVL(pdata->exclvl);
-	} else {
-		dev_warn(&client->dev, "No platform data? using default\n");
-		regval = AD7746_EXCSETUP_EXCA | AD7746_EXCSETUP_EXCB |
-			AD7746_EXCSETUP_EXCLVL(3);
+	if (device_property_read_bool(dev, "adi,excb-output-en")) {
+		if (device_property_read_bool(dev, "adi,excb-output-invert"))
+			regval |= AD7746_EXCSETUP_NEXCB;
+		else
+			regval |= AD7746_EXCSETUP_EXCB;
 	}
 
+	ret = device_property_read_u32(dev, "adi,excitation-vdd-permille",
+				       &vdd_permille);
+	if (!ret)
+		regval |= AD7746_EXCSETUP_EXCLVL(vdd_permille);
+
 	ret = i2c_smbus_write_byte_data(chip->client,
 					AD7746_REG_EXC_SETUP, regval);
 	if (ret < 0)
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

