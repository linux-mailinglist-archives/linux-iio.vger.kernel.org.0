Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 001D211ADF1
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2019 15:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbfLKOjT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Dec 2019 09:39:19 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39383 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729686AbfLKOjS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2019 09:39:18 -0500
Received: by mail-pg1-f195.google.com with SMTP id b137so10872609pga.6;
        Wed, 11 Dec 2019 06:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LkssNv9xnqcTUQeW4rk5Aqaqz7M0e85np77FGc2j2Og=;
        b=lKwtyK3LHvPbGuZ5gO2dFqSx3FVmSA3+UiU4qNpfKyLsdS77OrGXzcH5/Tf+cPV7Of
         lSSfjD2joW9Id/QtOjlQMvFEMrCKuiL4KE9Z9Q13/OFjaFSEQEbclJzZ3YFB89hNEa7W
         udzJM2daCneUwMoMb1f1+X//b3YXnOI4rzAi3J8kjldYrNBEjIhzHvgilXdXZ3yFD4wX
         jV92IL3P3Dj9SAge1bXWpRKrim0kDLhQrMvJ3/NLNVufEMdMuC84jcv/nLfxdoPl0tmn
         vLhyuJcPNcQXhSV8cRKclty8GvISXuY2EMyGo7d8RZgOeJEqVTpXhOnO1r9A5iqFLzqj
         TYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LkssNv9xnqcTUQeW4rk5Aqaqz7M0e85np77FGc2j2Og=;
        b=o3mDTX8yWvPjTulDsINtDIMg1Enu0HjON1jmO8bpQviRi9GJZqK9vsNuzcma8VHZNI
         xVA7nOi491aEP0rcvDPYSHBK6DSF/FxU6HIT7/c0/4reClvJvLpMDG8EekCJOreblE7D
         Truqr+csbp7q8ChJZbuSrUuEe99p8p3/KccOBwzgukpsYw9qBNLUgwRpB3y3tPaaVJ/O
         9JnDUhMDhypWRbgIpqTCDCNfKNTpHhpjLI5lNdJSvx1PxSZ5SgaFm1qWLUPfi01BwMHk
         MpQJh682mFQSUs46q5ZiZc9u7tBGWw2qOAKebQdUIvfZGDM07D/XI1yXBR6HxWtHRH81
         z0bA==
X-Gm-Message-State: APjAAAUmp1rA3gpR9Q4yQnIkTOuLzDOLj+PKSZdxeMdDHFVwg41qP7vF
        ihPQvITHL+Qb6JnLmKs89RU5bv6+szo=
X-Google-Smtp-Source: APXvYqxX+IBGqxdzlhJQ/pgZQaqQCCBZodhkOhhvQDd4JZ7+cFq4k8qS4IF5R/U8Rwdx9yb93TYpZg==
X-Received: by 2002:aa7:951c:: with SMTP id b28mr3997505pfp.97.1576075157829;
        Wed, 11 Dec 2019 06:39:17 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id q11sm3444239pff.111.2019.12.11.06.39.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Dec 2019 06:39:16 -0800 (PST)
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
Subject: [PATCH v3 05/12] thermal: int340x: switch to use <linux/units.h> helpers
Date:   Wed, 11 Dec 2019 23:38:12 +0900
Message-Id: <1576075099-3441-6-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
References: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
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
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v3
- rename new header name from <linux/temperature.h> to <linux/units.h>

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

