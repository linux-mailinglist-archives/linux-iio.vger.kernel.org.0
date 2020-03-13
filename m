Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA448183FA5
	for <lists+linux-iio@lfdr.de>; Fri, 13 Mar 2020 04:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgCMD3V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Mar 2020 23:29:21 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42022 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgCMD3V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Mar 2020 23:29:21 -0400
Received: by mail-pf1-f195.google.com with SMTP id x2so3977120pfn.9;
        Thu, 12 Mar 2020 20:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=vu1mPV5qkLwCnUIC3q92piC5wqu0Lr6m+RWkyhwC2Yc=;
        b=Cdd3DkLK6UcsCMaFBHgqJwwqXFvibtSujs8UwceTcyohmIWzLVryFfb9v/InGxoS5P
         1MgO9M/br27LxR5e3eVsZZgUKrjLUjgQ74yBR2otd/bMBY7nQHJEIYWMYsaKQOTBsEyY
         z1XUSoebQli9lGDEgwKVxpJOnJYG4LevF0+4Pb81cNBMvXvkBOsrgUMBBMYcVga36od8
         9XJLkwf8c3g0++Zh+kxyK6Z6tXAxacyZgZhEyS3T+Z7LWtARlUDE3VFFPMvskiVfHnXb
         W+yTTODl+S3Cnc9DCrqAlWyORL/lV1oJJYTwQJnepQFgq/NTliLQ0o83MdIIwC3eSpT7
         3cDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=vu1mPV5qkLwCnUIC3q92piC5wqu0Lr6m+RWkyhwC2Yc=;
        b=tEjtj34G45hUvbm1xLAPBCAMG3Le+lo55IL+wBFm9O01LcaJGUqAMIYQLQLKZy8RBJ
         kC1zsNJgk+WWy2DJ1+UgglagwIIh0dQ7NGj7IVN6/oT8M1NbiRTkNwijSYq5KHzSGnzt
         cINsrQIdijREoV68sr+LH9F/jZ0JOxVpLVS2vIOwbpr2Am8/pcS7vfKQ+7D5FAHdZVqB
         TW72oBOXU7n4Ktx5CRKyeVO25CWsNBWfB0vils4Zd7bDLee816NP26dy9m+0vVZnivNm
         lw83pZjWKhnVdOyuyNhSZJ5ryV1VsAJ78GPszODcTC0WWq8Mjkli4aCMAWTvWNf8iqVb
         Li7w==
X-Gm-Message-State: ANhLgQ1U5Z3bov3gzJodwbvqwy10vexPvfP1skn8rSFW/9lZrc2Ps550
        kSmhRDtz5H7UCF+MdTAoveg=
X-Google-Smtp-Source: ADFU+vvoZ/9VLBpjGCRZTRn32q0wnyM03wQW61IIHlT44brOLEj9kIbI1opDxCPexjrw54elb5kvTQ==
X-Received: by 2002:a62:e306:: with SMTP id g6mr9298330pfh.312.1584070158478;
        Thu, 12 Mar 2020 20:29:18 -0700 (PDT)
Received: from SARKAR ([43.224.157.41])
        by smtp.gmail.com with ESMTPSA id h24sm15017607pfn.49.2020.03.12.20.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 20:29:17 -0700 (PDT)
Message-ID: <5e6afe0d.1c69fb81.25912.f2eb@mx.google.com>
X-Google-Original-Message-ID: <20200313032913.GA28957@rohitsarkar5398@gmail.com>
Date:   Fri, 13 Mar 2020 08:59:13 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, alexandru.Ardelean@analog.com,
        dragos.bogdan@kernel.org
Subject: [PATCH] iio: health: max30100: use generic property handler
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Instead of of_property_read_xxx use device_property_read_xxx as it is
compatible with ACPI too as opposed to only device tree.

Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
---
 drivers/iio/health/max30100.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
index 84010501762d..8249c6b36818 100644
--- a/drivers/iio/health/max30100.c
+++ b/drivers/iio/health/max30100.c
@@ -16,7 +16,7 @@
 #include <linux/irq.h>
 #include <linux/i2c.h>
 #include <linux/mutex.h>
-#include <linux/of.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
@@ -267,11 +267,10 @@ static int max30100_get_current_idx(unsigned int val, int *reg)
 static int max30100_led_init(struct max30100_data *data)
 {
 	struct device *dev = &data->client->dev;
-	struct device_node *np = dev->of_node;
 	unsigned int val[2];
 	int reg, ret;
 
-	ret = of_property_read_u32_array(np, "maxim,led-current-microamp",
+	ret = device_property_read_u32_array(dev, "maxim,led-current-microamp",
 					(unsigned int *) &val, 2);
 	if (ret) {
 		/* Default to 24 mA RED LED, 50 mA IR LED */
-- 
2.23.0.385.gbc12974a89

