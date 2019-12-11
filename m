Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5FB11ADCB
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2019 15:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfLKOjY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Dec 2019 09:39:24 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:33631 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729686AbfLKOjX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2019 09:39:23 -0500
Received: by mail-pj1-f65.google.com with SMTP id r67so9022996pjb.0;
        Wed, 11 Dec 2019 06:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=30ClsBWVMQFbgwDIq9w8WCwwNMvj/q4ymjJp8oUF1J0=;
        b=iPTNp0EdadO4y2qivxFKBUpzEsaPwhGKdyaPxOlJenJBVxrjZDK77cuy1xm8y3/vwo
         XAU33lFCH4T/3DEpnMyPFn6xvlTZdCX8Y/G3vVNDBizKWUagtzlppvbFHBKxI8/Qzgli
         056XNDvIhN4ii1itJlKwXt80wjd295T2EeFmuKxHDcesF1kjQH1DUsdulYHgs8J8gmp8
         InGX15hisePqvBdSawpSkTi5rAQXLdhUlmEHERSnfwz5Z3FiZ+nZFa1WP1exJSLOjypP
         wqQIAcTsATodjUx32eYVG4H6IPzbyD7WHdjJLcss5z7w5GHfOtNx7Sjbyizgieki1RVz
         OCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=30ClsBWVMQFbgwDIq9w8WCwwNMvj/q4ymjJp8oUF1J0=;
        b=XEnL7GaPaeT21ukAOLDLbrJCEIffd1/pPBntbnnXFAx4vEYN2D/vWSwyFzBOHJ4WjQ
         yumsvPYHa4/Ts8WVryCkexOC7coPFEj1nn27uPMIgXV1JJtlLTX0yt/gp/ckkHBMTZdv
         2OX+34wjKinNvqzUHQhv3BivkieG+B5hVM6Vd2XjYCvJI9/hsNOKQDyTizrwH+BTceDu
         a8EfZAWzNKywDBaSAQbWhmNAxUsu+4OKJXcgWJ411txVWq9YuAOUQupG5W0eTEIkQhyG
         TCFR00OxBaB0ZRE1XxmWCYahGzsTzR61u1ReDF44ZAKQsbQLv5CK4xJeyxBLqaWqPRHM
         Z44A==
X-Gm-Message-State: APjAAAUr1L3avFoJiqi83vC+lHapLRatgs+dzI2/CzW/13krHTeRuJoc
        p7rOo/LKCBJtJ5sIMteceXDfmWQatkc=
X-Google-Smtp-Source: APXvYqyPc4UFSiMgsD4yZYd76DuxU8U2qOWD+TGrVH0/E0V5787xpYx4yK1YXlYV7OTuxTKh7/rsHg==
X-Received: by 2002:a17:902:8507:: with SMTP id bj7mr3489251plb.69.1576075163124;
        Wed, 11 Dec 2019 06:39:23 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id q11sm3444239pff.111.2019.12.11.06.39.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Dec 2019 06:39:22 -0800 (PST)
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
Subject: [PATCH v3 06/12] thermal: intel_pch: switch to use <linux/units.h> helpers
Date:   Wed, 11 Dec 2019 23:38:13 +0900
Message-Id: <1576075099-3441-7-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
References: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This switches the intel pch thermal driver to use
deci_kelvin_to_millicelsius() in <linux/units.h> instead of helpers in
<linux/thermal.h>.

This is preparation for centralizing the kelvin to/from Celsius conversion
helpers in <linux/units.h>.

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
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v3
- rename new header name from <linux/temperature.h> to <linux/units.h>

 drivers/thermal/intel/intel_pch_thermal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index 4f0bb8f..b118611 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -13,6 +13,7 @@
 #include <linux/pci.h>
 #include <linux/acpi.h>
 #include <linux/thermal.h>
+#include <linux/units.h>
 #include <linux/pm.h>
 
 /* Intel PCH thermal Device IDs */
@@ -92,7 +93,7 @@ static void pch_wpt_add_acpi_psv_trip(struct pch_thermal_device *ptd,
 		if (ACPI_SUCCESS(status)) {
 			unsigned long trip_temp;
 
-			trip_temp = DECI_KELVIN_TO_MILLICELSIUS(r);
+			trip_temp = deci_kelvin_to_millicelsius(r);
 			if (trip_temp) {
 				ptd->psv_temp = trip_temp;
 				ptd->psv_trip_id = *nr_trips;
-- 
2.7.4

