Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D0A372F0C
	for <lists+linux-iio@lfdr.de>; Tue,  4 May 2021 19:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbhEDRlT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 May 2021 13:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhEDRlS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 May 2021 13:41:18 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A0EC061574;
        Tue,  4 May 2021 10:40:22 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id g15-20020a9d128f0000b02902a7d7a7bb6eso2233251otg.9;
        Tue, 04 May 2021 10:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W1bW+xGCGzGfjtmnEyUq9A7nbmJVHdQwdYySDEYgEZo=;
        b=QqgITlMY4AjMzCQbisr7rpx9ZndoOL+wlIt0zvny62rW1OEFLVwTtF3ncmelZjuMGp
         EXicrVw7l7F0LU9fLXM7RE69sp6whxaGkOGoc5pG+hU6IJxce3cv8Ypja109VVQWAYnn
         Ry+Z3PLWworNuMwzSFu4L1FcvwB8aLOkT9w8dOC7beUv/HGwzoimYWCiWxoK95MvuQ6o
         MsoFwGV7uIk3r1G3NzJqpXJfsw6nVl7v68d6M1yVmoTk9nt7Zl76Ps77qKhYVely9EBb
         dUwuY5zwWnGgre97RDcADt873GlocSuKeukknYM4WFbMcipz34TZmlN5z37vsTRo3xSk
         nlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=W1bW+xGCGzGfjtmnEyUq9A7nbmJVHdQwdYySDEYgEZo=;
        b=bmqDvmNcCOoj8AJu4oCG+Mxzf1pyFwlITrEVR2HkDsg7YcEwt9ofu9xU77wQxMf9jQ
         hZ6i2GCBkbYmFQMyXWFZnmJDuIZM5TulZjZAdxoj2/KP0J7aq+Phb30/t6olZNA2jtIV
         3doMhm7U7Avdm2/OwK7jatbBbG8NyK/P++smiksQErYgBFlQkbj2xaOULSlid8FEjxUw
         X+oVC2FGOuH/JqdYXesX/wnbJTmu6qAjHWC4ku3SXKBioXPWwrfb5U6hNa+vi4wm1Y0f
         JUm6a+EuX7DNG4DcSGtQl+BeMP6XLd6nVylNpPH36CPufN3QgoqV6HCxRQohMYVnuT4c
         jjhw==
X-Gm-Message-State: AOAM533UclaH90FaB9E6y5lHn6gWMJCKkzqRBofNe9T9/1fwAwMiOnQc
        1/AvBW6pHfJj+IiEK8yVIE0=
X-Google-Smtp-Source: ABdhPJwXFrUn1HOVKl93mjOqqWOWbuO+40FKOYW5TjLFoBfp47prkGbRJHEg5OcOzIXL4n1r+Fi6Mg==
X-Received: by 2002:a9d:53c1:: with SMTP id i1mr20121152oth.245.1620150022361;
        Tue, 04 May 2021 10:40:22 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d6sm852146oom.33.2021.05.04.10.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 10:40:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        kernel test robot <lkp@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH] iio: bme680_i2c: Make bme680_acpi_match depend on CONFIG_ACPI
Date:   Tue,  4 May 2021 10:40:19 -0700
Message-Id: <20210504174019.2134652-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

With CONFIG_ACPI=n and -Werror, 0-day reports:

drivers/iio/chemical/bme680_i2c.c:46:36: error:
	'bme680_acpi_match' defined but not used

Reported-by: kernel test robot <lkp@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Given the other patch, question of course is if this ACPI ID
is real. A Google search suggests that this might not be the case.
Should we remove it as well ? STK8312 has the same problem.

Jonathan, I think this needs your input before I send more patches.

 drivers/iio/chemical/bme680_i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/chemical/bme680_i2c.c b/drivers/iio/chemical/bme680_i2c.c
index 29c0dfa4702b..b5e75f145c19 100644
--- a/drivers/iio/chemical/bme680_i2c.c
+++ b/drivers/iio/chemical/bme680_i2c.c
@@ -42,11 +42,13 @@ static const struct i2c_device_id bme680_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, bme680_i2c_id);
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id bme680_acpi_match[] = {
 	{"BME0680", 0},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, bme680_acpi_match);
+#endif
 
 static const struct of_device_id bme680_of_i2c_match[] = {
 	{ .compatible = "bosch,bme680", },
-- 
2.25.1

