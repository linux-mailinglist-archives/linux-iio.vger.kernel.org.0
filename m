Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D318411ADBF
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2019 15:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbfLKOjN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Dec 2019 09:39:13 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44945 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730052AbfLKOjM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2019 09:39:12 -0500
Received: by mail-pl1-f196.google.com with SMTP id bh2so1487933plb.11;
        Wed, 11 Dec 2019 06:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wO3jkH+pH7VdbFARKta9bxoSsbke4b8Zl03d1mXFCcM=;
        b=TD38CrYzoOsQjlzXB2cRRd9HRMMDxp/xytFAH/OIzDUwWaAkxa4/eFqTBtP/67AZPk
         4Cb+kTlTIFDeKa5EbUk3bL883UV4w4DnKx5+iIGYC5bjeArB1QqBJeKqt/SXfFn7m2XF
         XqX/7RxhHaTIJTZn7f8PKyerSkxDJR6+DutaZhebcyVWAmtxb6L0DPh/mspVZQkW5qyP
         WtpwxDzi8FXsr2Bg0te7lsyN58AUxi/7W7OGFKQawgqAdVsWF+TKZLpXZocEiHDha8j8
         0LQWIchLb46fnZagkhhjL/h/ZgywDXrQ9noPfS9l3XIPha4u59zKcCe2mCmy52hJnNNr
         gfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wO3jkH+pH7VdbFARKta9bxoSsbke4b8Zl03d1mXFCcM=;
        b=eQVzYgdKg9TXOaGGavFEyGB7LB5wuhAgTzM2LZ9ekCPP1jCWvU11Vo/mRU+UJLYenv
         wwFd8BcPH7b9iMrMwPEl6OMcC+BmmFVrsWNWRhJk+yistN+SIQ8+GNQD3Ry9E1ENjcQH
         npQK7C+pNzUreuXtn+CaGLY5keNcQGZscs/EkDAq2up0xtIY+XaIZ65ImY2yiDymF4p7
         5M40/sldd4XvmwowqeM5alCm+Tx510EX2Ku+HXs1Q2lIvru0Uc2xPqwT6aDVWFa7XW1T
         2Am/ZVV1I9DgNbQ6x2daBdlGqxZ3u2SnDUT0ZyVP4U1d1AlSdt+N1VZZt82ohY0+p0EB
         Bqxg==
X-Gm-Message-State: APjAAAV6TfchqUoaYiWIzoHp4s6cncj2IRG5wOwIbL96KVC0nY9s170j
        17tQoXU0M4kVvLNl3b6/CB/wT4zhMMc=
X-Google-Smtp-Source: APXvYqxT+/d6//9eH3ZYvjUMxrZPNz60pNUqUzbihUXUSGTG82cKy/Rxgy6yRUUjVA8t32UcmaqAxw==
X-Received: by 2002:a17:902:8d83:: with SMTP id v3mr3552557plo.205.1576075151675;
        Wed, 11 Dec 2019 06:39:11 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id q11sm3444239pff.111.2019.12.11.06.39.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Dec 2019 06:39:10 -0800 (PST)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v3 04/12] platform/x86: intel_menlow: switch to use <linux/units.h> helpers
Date:   Wed, 11 Dec 2019 23:38:11 +0900
Message-Id: <1576075099-3441-5-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
References: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This switches the intel_menlow driver to use deci_kelvin_to_celsius() and
celsius_to_deci_kelvin() in <linux/units.h> instead of helpers in
<linux/thermal.h>.

This is preparation for centralizing the kelvin to/from Celsius conversion
helpers in <linux/units.h>.

This also removes a trailing space, while we're at it.

Cc: Sujith Thomas <sujith.thomas@intel.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amit.kucheria@verdurent.com>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v3
- rename new header name from <linux/temperature.h> to <linux/units.h>

 drivers/platform/x86/intel_menlow.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel_menlow.c b/drivers/platform/x86/intel_menlow.c
index b102f6d..101d7e7 100644
--- a/drivers/platform/x86/intel_menlow.c
+++ b/drivers/platform/x86/intel_menlow.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/thermal.h>
 #include <linux/types.h>
+#include <linux/units.h>
 
 MODULE_AUTHOR("Thomas Sujith");
 MODULE_AUTHOR("Zhang Rui");
@@ -302,8 +303,10 @@ static ssize_t aux_show(struct device *dev, struct device_attribute *dev_attr,
 	int result;
 
 	result = sensor_get_auxtrip(attr->handle, idx, &value);
+	if (result)
+		return result;
 
-	return result ? result : sprintf(buf, "%lu", DECI_KELVIN_TO_CELSIUS(value));
+	return sprintf(buf, "%lu", deci_kelvin_to_celsius(value));
 }
 
 static ssize_t aux0_show(struct device *dev,
@@ -332,8 +335,8 @@ static ssize_t aux_store(struct device *dev, struct device_attribute *dev_attr,
 	if (value < 0)
 		return -EINVAL;
 
-	result = sensor_set_auxtrip(attr->handle, idx, 
-				    CELSIUS_TO_DECI_KELVIN(value));
+	result = sensor_set_auxtrip(attr->handle, idx,
+				    celsius_to_deci_kelvin(value));
 	return result ? result : count;
 }
 
-- 
2.7.4

