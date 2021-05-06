Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5B8374DFE
	for <lists+linux-iio@lfdr.de>; Thu,  6 May 2021 05:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhEFDog (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 May 2021 23:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhEFDog (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 May 2021 23:44:36 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E327AC061574;
        Wed,  5 May 2021 20:43:37 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id s1-20020a4ac1010000b02901cfd9170ce2so962433oop.12;
        Wed, 05 May 2021 20:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XWaMZqY8xGjwY01ObO+7tWazSIgZSXv5o+5YdwDhduo=;
        b=Ie6SoG/w7fgaCh5Qdsv6NzennNv1Z3T8sZpOdkB183H7Wz8wAlZSVhNbuMCGmw1MIL
         Iq6LkvwNOZ9KRU+2fZhlU7tylITEw5dZYliSbkI57jBEGfQdMBsuXVXuBeH7v0Ovvb88
         ryHbk/SQ752+YuZ42L0ykEs0AZxAtxya8VezrF7L6b11m/luViauAKw03jCXa/AfqhSk
         yu9ZzrQj0k5fhX/IzRJNRsiaRq4khzpiMOs30ylj5zf5jgzrnPtSzTXYW7+XghHcpNlP
         ZjHvplq5IUx0nnU5vpAbl5IXEUpk/Gr8ITtUTs8Qrn4qgXXc+3A1ctPNi94e6g+RBPRP
         34iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=XWaMZqY8xGjwY01ObO+7tWazSIgZSXv5o+5YdwDhduo=;
        b=er+COKfu3U/Xjo14d1/3eTg0/eQkadOa19EdlkVCJI5QuOQoC3cU4eU5csffQHzlfN
         vMCxR7Y6Ce9M3A0jF7sIwW3lNOCvoKXnPy688J556ICtjMvS5Ru+jZ6UVnYxiJOXw3Yu
         pfLZb0Ya1rtPLP+C1+skZZGpMXGYS55JJo0KBuieL2ruKRlWgYBL7yzsQzJtLUA6xg+i
         B7zwdHd+N73T1TwG7645STGOxPpJsD1NLB2nDVbKRMLIJeOllSydm+d1CBgTpjAHCLJZ
         UVa4rkIhnK1jMxrhefqmg4UejY2IhFncusVCXRaBKmMNeXKR7Me57EnL3oFRGYkcwpnS
         CtVw==
X-Gm-Message-State: AOAM533HeewKNw/IHbS86zB1S/bWOsl8zTyqEM/Zzhwj0VPLLzSBX7G1
        9cNCCQb4makqSX8ZKMRayzU=
X-Google-Smtp-Source: ABdhPJyIDz3JfVmxiL7PQ9xW5K0DKS8P3dy70x/eTlW8bWVzWrhxO7qw52K/XAcOEacTJGlQqVdc8g==
X-Received: by 2002:a4a:8247:: with SMTP id t7mr1544672oog.53.1620272617285;
        Wed, 05 May 2021 20:43:37 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u207sm229059oie.56.2021.05.05.20.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 20:43:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        kernel test robot <lkp@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2] iio: bme680_i2c: Remove ACPI support
Date:   Wed,  5 May 2021 20:43:32 -0700
Message-Id: <20210506034332.752263-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

With CONFIG_ACPI=n and -Werror, 0-day reports:

drivers/iio/chemical/bme680_i2c.c:46:36: error:
	'bme680_acpi_match' defined but not used

Apparently BME0680 is not a valid ACPI ID. Remove it and with it
ACPI support from the bme680_i2c driver.

Reported-by: kernel test robot <lkp@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Instead of making bme680_acpi_match conditional,
    remove ACPI support entirely since the ACPI ID is
    not valid.

 drivers/iio/chemical/bme680_i2c.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/iio/chemical/bme680_i2c.c b/drivers/iio/chemical/bme680_i2c.c
index 29c0dfa4702b..74cf89c82c0a 100644
--- a/drivers/iio/chemical/bme680_i2c.c
+++ b/drivers/iio/chemical/bme680_i2c.c
@@ -11,7 +11,6 @@
  * Note: SDO pin cannot be left floating otherwise I2C address
  *	 will be undefined.
  */
-#include <linux/acpi.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
@@ -42,12 +41,6 @@ static const struct i2c_device_id bme680_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, bme680_i2c_id);
 
-static const struct acpi_device_id bme680_acpi_match[] = {
-	{"BME0680", 0},
-	{},
-};
-MODULE_DEVICE_TABLE(acpi, bme680_acpi_match);
-
 static const struct of_device_id bme680_of_i2c_match[] = {
 	{ .compatible = "bosch,bme680", },
 	{},
@@ -57,7 +50,6 @@ MODULE_DEVICE_TABLE(of, bme680_of_i2c_match);
 static struct i2c_driver bme680_i2c_driver = {
 	.driver = {
 		.name			= "bme680_i2c",
-		.acpi_match_table       = ACPI_PTR(bme680_acpi_match),
 		.of_match_table		= bme680_of_i2c_match,
 	},
 	.probe = bme680_i2c_probe,
-- 
2.25.1

