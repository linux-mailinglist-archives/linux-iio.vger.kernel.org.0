Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B983035A625
	for <lists+linux-iio@lfdr.de>; Fri,  9 Apr 2021 20:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbhDISvC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Apr 2021 14:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbhDISvC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Apr 2021 14:51:02 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A459EC061762;
        Fri,  9 Apr 2021 11:50:47 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id f12so4977636qtf.2;
        Fri, 09 Apr 2021 11:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x5UZWC8zVAh94JSKCovtgfLgGs7oIt1cZDdRs8Arpcc=;
        b=mz1SSsG7XNZLlQ6clNY1SSAcig7F9uj6Fk38/Fomw/Nho88ffCzoo0OAQR3FUuS7EP
         5ZYEliG11XcYlQfQJ4s9rKZvb2KwZkS1HOEA+j3bzMbouTn/dILs+d7XXpKyXEai41CQ
         XPDKTXPj8feMcTCJgAg6kwCe30awp6TMOjn1r3c0o7qYQQjdes+FB33cldMAnOFCxHac
         kTuYDSrdJC+qd9pJgGURRDAdC5Fm6S3friCfhLA5UauNE7xSWoDbR6/XratCUULLzXuM
         YNaQ6SfWomeNgo9yBT15De1JsZKwYtgmaUVE36Ti+e9NKdCmsgEq+b2bHLyBSzpQBc6N
         Oj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x5UZWC8zVAh94JSKCovtgfLgGs7oIt1cZDdRs8Arpcc=;
        b=Crgn9Nwdj9tjsyqkzVeG33doDhuWBs3Na42Lb6EA5UcR40kofgI7CHpbC14NJlUfV1
         w79w35nrTVcSXUjL7+beNn3fuMjLcThrMHaJzjlqhIr341eBYXCh2Kya1tAeoD1Yr/nt
         P3zMoy53hfO4HmRYifE/DKWx4N/+92R9+l7VSAPaj8z4JWFJEJ+Bh7fDbJGzDJKCCbdO
         kBzocBHSf0HFYifr7lEgnZwRV/5l0N3EKhYCc13+4jgIflzsT/9lkLiDP53UQorggOPN
         Y4n64GTcHxhUvaKho1eF7vxVTmtR0nVigf3dZ+KyrnJ7tRGEcqQpMy2xmIiT9ruYHd6n
         dSqg==
X-Gm-Message-State: AOAM532zlX4aNAg9cbH9vGtXVOvxmaxBEDXxcpbW3eE6iHbOJlg/ri3Q
        ZDMjrnYG83BFwT09YwBvAKY=
X-Google-Smtp-Source: ABdhPJy273/ixAJu7iZq8qTlqMCsfrqWgXHmiFQOfi8j6E2Ns1onoQVgkb52060W1ljv4Gty9/KdUA==
X-Received: by 2002:ac8:6c5d:: with SMTP id z29mr14302222qtu.99.1617994246940;
        Fri, 09 Apr 2021 11:50:46 -0700 (PDT)
Received: from smtp.gmail.com ([2804:14c:73:9a01:86f3:17eb:e23c:86fd])
        by smtp.gmail.com with ESMTPSA id 184sm2376583qki.97.2021.04.09.11.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:50:46 -0700 (PDT)
Date:   Fri, 9 Apr 2021 15:50:42 -0300
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 3/3] staging: iio: cdc: ad7746: use dt binding to set the
 excitation level
Message-ID: <07b173e1d823dbdde40dc9ea31bb699b48043278.1617993776.git.lucas.p.stankus@gmail.com>
References: <cover.1617993776.git.lucas.p.stankus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617993776.git.lucas.p.stankus@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Set device excitation level using properties from device tree binding
instead of using platform_data.
As this replaces the last instance where the platform_data struct was
used, remove ad7746.h header file since it's no longer needed.

Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
---
 drivers/staging/iio/cdc/ad7746.c | 16 ++++++----------
 drivers/staging/iio/cdc/ad7746.h | 24 ------------------------
 2 files changed, 6 insertions(+), 34 deletions(-)
 delete mode 100644 drivers/staging/iio/cdc/ad7746.h

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 63041b164dbe..3c75d147c3dd 100644
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
@@ -676,11 +674,10 @@ static const struct iio_info ad7746_info = {
 static int ad7746_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
-	struct ad7746_platform_data *pdata = client->dev.platform_data;
 	struct device_node *np = client->dev.of_node;
 	struct ad7746_chip_info *chip;
 	struct iio_dev *indio_dev;
-	unsigned int exca_en, excb_en;
+	unsigned int exca_en, excb_en, exclvl;
 	unsigned char regval = 0;
 	int ret = 0;
 
@@ -721,12 +718,11 @@ static int ad7746_probe(struct i2c_client *client,
 			regval |= AD7746_EXCSETUP_NEXCB;
 	}
 
-	if (pdata) {
-		regval |= AD7746_EXCSETUP_EXCLVL(pdata->exclvl);
-	} else {
-		dev_warn(&client->dev, "No platform data? using default\n");
-		regval = AD7746_EXCSETUP_EXCLVL(3);
-	}
+	ret = of_property_read_u32(np, "adi,excitation-voltage-level", &exclvl);
+	if (!ret)
+		regval |= AD7746_EXCSETUP_EXCLVL(exclvl);
+	else
+		regval |= AD7746_EXCSETUP_EXCLVL(3);
 
 	ret = i2c_smbus_write_byte_data(chip->client,
 					AD7746_REG_EXC_SETUP, regval);
diff --git a/drivers/staging/iio/cdc/ad7746.h b/drivers/staging/iio/cdc/ad7746.h
deleted file mode 100644
index 6cae4ecf779e..000000000000
--- a/drivers/staging/iio/cdc/ad7746.h
+++ /dev/null
@@ -1,24 +0,0 @@
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
-};
-
-#endif /* IIO_CDC_AD7746_H_ */
-- 
2.31.1

