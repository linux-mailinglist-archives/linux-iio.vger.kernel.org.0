Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79D7311F5EA
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2019 06:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfLOFRO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Dec 2019 00:17:14 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38989 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfLOFRN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Dec 2019 00:17:13 -0500
Received: by mail-pg1-f196.google.com with SMTP id b137so1723691pga.6;
        Sat, 14 Dec 2019 21:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HoM44YO7jKpFM5Bt686W03V+vIzdOR1TWUFJVxsK0iw=;
        b=bQvf50MvBu50bzcy5vOGO4uBYMf9uKla1LUKwxCJkyto5/NGMdf3Tp91MzlfL6sBET
         UfJH9M5g0IhJWYBxQR3K2+zKcF8+fIfQbNn+U7Q/bO5oZGY7JJicPp13WCP49M2D1xZ5
         4pMI9mLCDH1Qrx09uoA9y5Di16KiupsO7XuXUUC90JSJaXmRY0XGJePvIwZ62u1YmLP9
         UR1lezZtd6rQnu3n0XftzclCqSsnTRT5UMe5bZFvV+9Lg4iJDykx6336E/FzikHd+NUi
         6GKCu9ETSkaLNyn1vRk/sIVbMQHLuKvweESCi9ro4XeddFzJS1kvkligms8YTC0+aX0M
         s/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HoM44YO7jKpFM5Bt686W03V+vIzdOR1TWUFJVxsK0iw=;
        b=ZH+TxRut6yerSJs4JWHOOjpqzm7vOLXq+WkTOWFkeWFEWKRzJ+QKrpoGxtUUUSKo88
         QuvfrglKUT8QLD1lF1YEtYDkWGYj2lBba4jv7wQRYYV6wWXboja2Fu0Nr5Lk3p1a/bDU
         n8aXXvwYEOIxmYlP1Fd6P/yYGMSCOPBafEjNj+ogr+gAThCEeUijmcTWgUT2wqmjjfQA
         /xU86s6UOwYTeW5PWCGMAyjT1yIJcS3YGxTFgvMhxzzEnE6q7aWS3vS1iuT4UQE2g8/c
         OQfxsPu23YInjxf5RvvSQapU3TTjMMXrfjfbsBOMUqX0sWwz7yB6nnDxXwou9yiVYl9a
         5Amg==
X-Gm-Message-State: APjAAAW5ix+PuXR+ZCOHZijWivbhMoo86X9NsZzKbyCHKbWpTqD00vCi
        4K/9WNG6tdZ51P09U8aYk7E=
X-Google-Smtp-Source: APXvYqxw27ngbpk0CKdXZvBZxaaAZi+AM67S8O8H2tETPVHPLmfGtOrWh4fm4fGLIcNlgSc4KcQahg==
X-Received: by 2002:a63:5162:: with SMTP id r34mr10283755pgl.227.1576387033003;
        Sat, 14 Dec 2019 21:17:13 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id u10sm16596528pgg.41.2019.12.14.21.17.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 14 Dec 2019 21:17:12 -0800 (PST)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
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
Subject: [PATCH v4 05/12] thermal: int340x: switch to use <linux/units.h> helpers
Date:   Sun, 15 Dec 2019 14:16:08 +0900
Message-Id: <1576386975-7941-6-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
References: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This switches the int340x thermal zone driver to use
deci_kelvin_to_millicelsius() and millicelsius_to_deci_kelvin() in
<linux/units.h> instead of helpers in <linux/thermal.h>.

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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v4
- add Reviewed-by tag

 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
index 75484d6..4322132 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -8,6 +8,7 @@
 #include <linux/init.h>
 #include <linux/acpi.h>
 #include <linux/thermal.h>
+#include <linux/units.h>
 #include "int340x_thermal_zone.h"
 
 static int int340x_thermal_get_zone_temp(struct thermal_zone_device *zone,
@@ -34,7 +35,7 @@ static int int340x_thermal_get_zone_temp(struct thermal_zone_device *zone,
 		*temp = (unsigned long)conv_temp * 10;
 	} else
 		/* _TMP returns the temperature in tenths of degrees Kelvin */
-		*temp = DECI_KELVIN_TO_MILLICELSIUS(tmp);
+		*temp = deci_kelvin_to_millicelsius(tmp);
 
 	return 0;
 }
@@ -116,7 +117,7 @@ static int int340x_thermal_set_trip_temp(struct thermal_zone_device *zone,
 
 	snprintf(name, sizeof(name), "PAT%d", trip);
 	status = acpi_execute_simple_method(d->adev->handle, name,
-			MILLICELSIUS_TO_DECI_KELVIN(temp));
+			millicelsius_to_deci_kelvin(temp));
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
@@ -163,7 +164,7 @@ static int int340x_thermal_get_trip_config(acpi_handle handle, char *name,
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
-	*temp = DECI_KELVIN_TO_MILLICELSIUS(r);
+	*temp = deci_kelvin_to_millicelsius(r);
 
 	return 0;
 }
-- 
2.7.4

