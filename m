Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F82372D1A
	for <lists+linux-iio@lfdr.de>; Tue,  4 May 2021 17:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhEDPir (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 May 2021 11:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhEDPir (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 May 2021 11:38:47 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F65C061574;
        Tue,  4 May 2021 08:37:51 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id c8-20020a9d78480000b0290289e9d1b7bcso8592997otm.4;
        Tue, 04 May 2021 08:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QlDyXERSA3mqDt2SGmoa9P7kir9FDUTLkXcYxUPKU9c=;
        b=c/v8xnMOy4JB5kzPFInCWiJU21cDQZBGzjbN0itH3QLhqCiwXxzOwiGJgfxdxnU0bx
         4Ns+eZjm7d/qWyBjgi8iwsC+TD1XX4CMU/5BNgiPqcBOj70aBq0l2LvSNXZT7wtLGK2G
         0SQuIkz6C6fWUqTCgrd8aAJTqQmSXrNtQofBp4eIEt5wQ5nACLjHxq/QkllisSIiV+7F
         y3TxWoJokes5M0v1k17ii3kJ/JXrNCVF3WflTS7Cww/vShYi2iFJ9gD4T4ehoqcvGs7h
         p+sOy3y63DmeTREwNkWQu8Qlu+aFy9MerXRsgOMWnjkCMX8tpOVj7HBrSR+vZcO2/6UN
         GHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=QlDyXERSA3mqDt2SGmoa9P7kir9FDUTLkXcYxUPKU9c=;
        b=QIWVflBi24t4qOyZtEIHR4v4WEGfCEJm0u0babnuBEG1qXqASTDg4bdxmxhr0oIugC
         dNSglbND7CS5sfglY72Dt1AtZnPWusj+PuZ3FEwVHo4hshMj6Do55NXRciJk+t3C0OHf
         7BYwrFJVv3YbExOw0GB0rUn4947WRl0cqUI34RhFOxN/yBzbDkHwcxSRJofUy6q0oVBj
         0Cu1mdoHs0aAidWIlbyISJYtntcevmYRKHjMvNoe5zNkGjmWS990oR/G548+nOuEguUU
         a+2/Aqac44xGDrTvYla/+72C2jsQlJGiqtF82MPq1DClp6mR3ELphI1gGNSC2+oEt5ZQ
         425g==
X-Gm-Message-State: AOAM530UoaFjPfQgGhz5zlUY+hFrrw91xfvYEm417oM8qKbal3mu0n9t
        WknwlcKxugsN1g5hxBeuIas=
X-Google-Smtp-Source: ABdhPJyG9G6OYaagCoWJrnF9GqfMipPU4WzAUT+rRVrmRYtoDBttqMJJqu3m0NSB+q30frPOLFxsiw==
X-Received: by 2002:a9d:4f03:: with SMTP id d3mr18674826otl.361.1620142670829;
        Tue, 04 May 2021 08:37:50 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c25sm870419otf.22.2021.05.04.08.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 08:37:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        kernel test robot <lkp@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2] iio: am2315: Remove ACPI support
Date:   Tue,  4 May 2021 08:37:46 -0700
Message-Id: <20210504153746.2129428-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

With CONFIG_ACPI=n and -Werror, 0-day reports:

drivers/iio/humidity/am2315.c:259:36: error:
	'am2315_acpi_id' defined but not used

According to Andy Shevchenko, the ACPI ID used in this driver is fake
and does not really exist. Remove it and with it ACPI support from
the driver.

Reported-by: kernel test robot <lkp@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Instead of making am2315_acpi_id depend on CONFIG_ACPI,
    remove ACPI support entirely.

 drivers/iio/humidity/am2315.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
index 23bc9c784ef4..8d7ec2f5acf8 100644
--- a/drivers/iio/humidity/am2315.c
+++ b/drivers/iio/humidity/am2315.c
@@ -7,7 +7,6 @@
  * 7-bit I2C address: 0x5C.
  */
 
-#include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/kernel.h>
@@ -256,17 +255,9 @@ static const struct i2c_device_id am2315_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, am2315_i2c_id);
 
-static const struct acpi_device_id am2315_acpi_id[] = {
-	{"AOS2315", 0},
-	{}
-};
-
-MODULE_DEVICE_TABLE(acpi, am2315_acpi_id);
-
 static struct i2c_driver am2315_driver = {
 	.driver = {
 		.name = "am2315",
-		.acpi_match_table = ACPI_PTR(am2315_acpi_id),
 	},
 	.probe =            am2315_probe,
 	.id_table =         am2315_i2c_id,
-- 
2.25.1

