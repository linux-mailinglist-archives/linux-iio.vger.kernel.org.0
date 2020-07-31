Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCEC23499A
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jul 2020 18:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387556AbgGaQtt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Jul 2020 12:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733091AbgGaQtC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Jul 2020 12:49:02 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481B7C06179F
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2020 09:49:02 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id g19so20211596ioh.8
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2020 09:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RgjKsJ/JPsYNKlD2x2wTWCtu2t/OkQtd2UQoMK7szBQ=;
        b=VDUylHw0pzeNeA046zmOyuq5ZQOKM31CadNiZObdUZTtHvoH9bEAKeuo16GU1elr/v
         UcvL3AY1CL26t9RCboBHSgPzIrgGIIZmUJU17QgLjQXEt6pDtS6fORMLnCJyRKevFmQo
         l0aFn8N7+fvQtNV5cKwQ7RjZFNWlMFE+YFFO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RgjKsJ/JPsYNKlD2x2wTWCtu2t/OkQtd2UQoMK7szBQ=;
        b=fHAGlrtFfKGwbJQ4c/SA9NxLuW3mIOYpDg6eKHrb1gGmM7uE0jZmjEOPQkaz5V4AAD
         1cLNVJHTNF6vmMugxC+M9+KSXyxR9Y+lyEVMdE+r2uW9ytGPde8qQhWu/YU1iCGen19f
         NGKNpn9HkurEYU2ymtNsMVAPWwWN7oxPzV5TPo/rjVeadRmcOF49TTN0JXZqrqpwecGy
         EWQhj0J+12A2Cikjeablt0pfVwq+11CsRvI6cXrNvIIwEVel154S2YvFI5yrf52I7S9r
         wPDgipqnHpAM1lVT+gg5av6EnCH6+lsqgKronZ0ONE+2lWpaFCHWSqAwr4ZwncC4Yom+
         fCog==
X-Gm-Message-State: AOAM531cDE2qD5xPpCqCtmwkbvjCaJ5YkVxWMKmNZi8zrO0qBe7TzWKy
        pRJKvq/CMF0x9me2d9YkQVKwZA==
X-Google-Smtp-Source: ABdhPJwnfDE5+ese/5K+QCB69TQqRvvsEKhyp1n82sHzcFfQReen0AyMP7MmyprjNCRebh6tTj2a4g==
X-Received: by 2002:a6b:185:: with SMTP id 127mr4494397iob.153.1596214141677;
        Fri, 31 Jul 2020 09:49:01 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id e84sm5122083ill.60.2020.07.31.09.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 09:49:01 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        kbuild test robot <lkp@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH v3 04/15] iio: sx9310: Remove acpi and of table macros
Date:   Fri, 31 Jul 2020 10:48:41 -0600
Message-Id: <20200731104555.v3.4.I9bf713a86d6076b44441ef5f534f9c240271699a@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200731164853.3020946-1-campello@chromium.org>
References: <20200731164853.3020946-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Avoids unused warnings due to acpi/of table macros.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Daniel Campello <campello@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v3: None
Changes in v2:
 - Added #include <linux/mod_devicetable.h>

 drivers/iio/proximity/sx9310.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index c7a27c21c20cd1..66f7050d63ae97 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -15,8 +15,8 @@
 #include <linux/i2c.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -1052,8 +1052,8 @@ MODULE_DEVICE_TABLE(i2c, sx9310_id);
 static struct i2c_driver sx9310_driver = {
 	.driver = {
 		.name	= "sx9310",
-		.acpi_match_table = ACPI_PTR(sx9310_acpi_match),
-		.of_match_table = of_match_ptr(sx9310_of_match),
+		.acpi_match_table = sx9310_acpi_match,
+		.of_match_table = sx9310_of_match,
 		.pm = &sx9310_pm_ops,
 	},
 	.probe		= sx9310_probe,
-- 
2.28.0.163.g6104cc2f0b6-goog

