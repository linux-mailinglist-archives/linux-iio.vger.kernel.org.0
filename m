Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F340F374E24
	for <lists+linux-iio@lfdr.de>; Thu,  6 May 2021 05:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhEFD6A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 May 2021 23:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbhEFD57 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 May 2021 23:57:59 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB70C061574;
        Wed,  5 May 2021 20:57:02 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id z3so3095754oib.5;
        Wed, 05 May 2021 20:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fb7g2E4p16Bv98KyBPLGHeYuLk+5q+sEUbPLsjTLLHk=;
        b=LqZpqiAg6EjfakLBXvDRzNV8ll0mhXt3RTvkQFlsjholqchimOSHdVjQHhTmmPqS8J
         YTHSjI/ro7NfGSXZp7A021z+MpB/r1evoPxCNQGYvk28F5f3iDpSf4cKcb/wApDFzG1j
         4J2Wt37ixsY46KEcKva/Zp6uulFub3dzlw+6aFE7rUYZspgogdecvM7iL0XXI6Aw4M/R
         R0O29gCGmwvw8szaCEyw8ixgGeJTIy3Asr18Df3Xp9CIR3KddJ8L/rta3x4/AsToGZxU
         mnwA41+HlsbdYnE/njTpi+mUJyOc4iPqMvKS/bdiGcOG3l/jcs4Ld5htEB5e6K8960PY
         Ca/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Fb7g2E4p16Bv98KyBPLGHeYuLk+5q+sEUbPLsjTLLHk=;
        b=BtWuKSxokvfKfjh2SX+cj7VYztlmEVXimwe8Uc+8TAeJjLQBEYhX9FEyyg1o2p4Smx
         DM4RJHQ1ZGXM6S3cptxZQOlY/IsHB9MFEycte/+SHtUvEM1dqWAmbieE1c0bYhia+SGb
         5V4MwALfb+vYvAGVbWVFAwaDask3JvgMtbwCgyWy6ATushEKslbdlBuZqfzfh7pQIvVK
         x1MzQMRsWsBzsJjAO1wlE6KWYXFCJH3INtVFL1FpQZDnRZvmmXXuMTgiHawnhQoW13cQ
         48zJOHRwlGNWVuET/v/CnZinFi8X4OeNRt0l0ekByeSXNIOrgX+kSfigYcEuC+pjcbu8
         XRSQ==
X-Gm-Message-State: AOAM531usAKT8ffvbSbvUxUf/h4fJgS/V047PhLFoN0qrVR1xeXxBJJo
        Tg4OP7Qg4JfM+2pfdyxFWFw=
X-Google-Smtp-Source: ABdhPJx6PQAHklNzbcJ/pA8TWo8g5lgkbtrE29LUFDwAOl4k/YCS72mNY2sAO8s6rr7sO9ajbpGq4A==
X-Received: by 2002:aca:3385:: with SMTP id z127mr1550908oiz.23.1620273421909;
        Wed, 05 May 2021 20:57:01 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q1sm338354otm.26.2021.05.05.20.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 20:57:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        kernel test robot <lkp@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] iio:accel:stk8312: Remove ACPI support
Date:   Wed,  5 May 2021 20:56:59 -0700
Message-Id: <20210506035659.765109-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

With CONFIG_ACPI=n, W=1 and -Werror, 0-day reports:

drivers/iio/accel/stk8312.c:644:36: error:
	'stk8312_acpi_id' defined but not used

Apparently STK8312 is not a valid ACPI ID. Remove it and with it
ACPI support from the stk8312 driver.

Reported-by: kernel test robot <lkp@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
There is another patch pending which makes whitespace changes in struct
acpi_device_id stk8312_acpi_id. This will result in a conflict if this
patch is applied. In that patch, it is claimed that the driver would
possibly only be used based on its ACPI ID (even though that ACPI device
ID is not official).
Link: https://patchwork.kernel.org/project/linux-iio/patch/20210401144226.225928-1-jic23@kernel.org/
I can not determine if that claim has any truth in it. Still, it appears
that the device ID is not an official device ID.  

 drivers/iio/accel/stk8312.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index 157d8faefb9e..2fc30cfe1457 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -7,7 +7,6 @@
  * IIO driver for STK8312; 7-bit I2C address: 0x3D.
  */
 
-#include <linux/acpi.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -640,18 +639,10 @@ static const struct i2c_device_id stk8312_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, stk8312_i2c_id);
 
-static const struct acpi_device_id stk8312_acpi_id[] = {
-	{"STK8312", 0},
-	{}
-};
-
-MODULE_DEVICE_TABLE(acpi, stk8312_acpi_id);
-
 static struct i2c_driver stk8312_driver = {
 	.driver = {
 		.name = STK8312_DRIVER_NAME,
 		.pm = STK8312_PM_OPS,
-		.acpi_match_table = ACPI_PTR(stk8312_acpi_id),
 	},
 	.probe =            stk8312_probe,
 	.remove =           stk8312_remove,
-- 
2.25.1

