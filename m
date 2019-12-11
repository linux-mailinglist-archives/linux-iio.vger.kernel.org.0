Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56B0F11ADCF
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2019 15:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbfLKOja (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Dec 2019 09:39:30 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37527 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729686AbfLKOj3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2019 09:39:29 -0500
Received: by mail-pf1-f193.google.com with SMTP id p14so1916118pfn.4;
        Wed, 11 Dec 2019 06:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G8HIqSOZSM7ZlLEzj0GZfcJL15LCKkAAkMEEiYP0HJ8=;
        b=EoL2MEKylC7MRqf5P3y3JFnFsr/PlSKtVjomV2dX1/7ZSkV2+sxGzrxZgEuNx091fk
         BKawpY7SEcgPihrYuDNS8X4ilRtwzzhvRNz/AIAys5SXt6tk57NEE4iu7lnfD69q1MaW
         lM+ROlYqmBV7vWcGEdg+EBFfrBzoG9BnscbToBGTv0UUqVM6tRuIYW9y0G9yUItH0IDI
         78hDdjc9KWP8qvsmAJWrfJQaJT2vvOr/fukTIe3fuetky7ZWaSF0Tm9w6MNghRv5gt0H
         CFFT98TRV57WRqjS6Teyv1JeMDWtMguVNnparclOk16OHVcOW1sbOMoEhNquGUAmPP7k
         A6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G8HIqSOZSM7ZlLEzj0GZfcJL15LCKkAAkMEEiYP0HJ8=;
        b=h+fjDRRZOS8kdz1D0mifxJx+LorQGbU8YcWYRxv3lb6uRH2ibrzkZ9UdxzFaJJEJpM
         odAqH6ZPeK1LhKEVEzzoINCW2v5h1hDbNGdxvbjzQxIIZdn60QhzONdDkDcsRgzkxK8w
         3kxbvYgB4c9Ymo3hUfXnhizKFvHmI7l27bPAfJCMy6/60J0W97I8tWfp+w4aRbgdC/NL
         eOQ41eL7CT/WEoixu0Vf76l5nMAZ0aXvWACRd6Imx3L/FCFK5Gfp3xfrk4OrtZC8r3We
         T49oy7Urkza7szc6d8WX4EIIaOaNZUxkriqIllXRxKq1cgbP6LIL1FIcAJFmZeiXW+YG
         bQFQ==
X-Gm-Message-State: APjAAAVvLrtd+P8p61wQmLpwAZpw63Xe517N4UpJH88SYqjrYqqL8vIJ
        yRp+oVmzGD2yav0DXJNfDRM=
X-Google-Smtp-Source: APXvYqzLIbq4qGAJSSgC9xZ/3+iluFA3br6Tz1ZQ92AYrpH9YCceKsABt6khTNhi4u+9CunGqaDYTg==
X-Received: by 2002:a63:6507:: with SMTP id z7mr4631816pgb.322.1576075169052;
        Wed, 11 Dec 2019 06:39:29 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id q11sm3444239pff.111.2019.12.11.06.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Dec 2019 06:39:28 -0800 (PST)
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
Subject: [PATCH v3 07/12] nvme: hwmon: switch to use <linux/units.h> helpers
Date:   Wed, 11 Dec 2019 23:38:14 +0900
Message-Id: <1576075099-3441-8-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
References: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This switches the nvme driver to use kelvin_to_millicelsius() and
millicelsius_to_kelvin() in <linux/units.h>.

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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v3
- rename new header name from <linux/temperature.h> to <linux/units.h>

 drivers/nvme/host/hwmon.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
index a5af21f..2e6477e 100644
--- a/drivers/nvme/host/hwmon.c
+++ b/drivers/nvme/host/hwmon.c
@@ -5,14 +5,11 @@
  */
 
 #include <linux/hwmon.h>
+#include <linux/units.h>
 #include <asm/unaligned.h>
 
 #include "nvme.h"
 
-/* These macros should be moved to linux/temperature.h */
-#define MILLICELSIUS_TO_KELVIN(t) DIV_ROUND_CLOSEST((t) + 273150, 1000)
-#define KELVIN_TO_MILLICELSIUS(t) ((t) * 1000L - 273150)
-
 struct nvme_hwmon_data {
 	struct nvme_ctrl *ctrl;
 	struct nvme_smart_log log;
@@ -35,7 +32,7 @@ static int nvme_get_temp_thresh(struct nvme_ctrl *ctrl, int sensor, bool under,
 		return -EIO;
 	if (ret < 0)
 		return ret;
-	*temp = KELVIN_TO_MILLICELSIUS(status & NVME_TEMP_THRESH_MASK);
+	*temp = kelvin_to_millicelsius(status & NVME_TEMP_THRESH_MASK);
 
 	return 0;
 }
@@ -46,7 +43,7 @@ static int nvme_set_temp_thresh(struct nvme_ctrl *ctrl, int sensor, bool under,
 	unsigned int threshold = sensor << NVME_TEMP_THRESH_SELECT_SHIFT;
 	int ret;
 
-	temp = MILLICELSIUS_TO_KELVIN(temp);
+	temp = millicelsius_to_kelvin(temp);
 	threshold |= clamp_val(temp, 0, NVME_TEMP_THRESH_MASK);
 
 	if (under)
@@ -88,7 +85,7 @@ static int nvme_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 	case hwmon_temp_min:
 		return nvme_get_temp_thresh(data->ctrl, channel, true, val);
 	case hwmon_temp_crit:
-		*val = KELVIN_TO_MILLICELSIUS(data->ctrl->cctemp);
+		*val = kelvin_to_millicelsius(data->ctrl->cctemp);
 		return 0;
 	default:
 		break;
@@ -105,7 +102,7 @@ static int nvme_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 			temp = get_unaligned_le16(log->temperature);
 		else
 			temp = le16_to_cpu(log->temp_sensor[channel - 1]);
-		*val = KELVIN_TO_MILLICELSIUS(temp);
+		*val = kelvin_to_millicelsius(temp);
 		break;
 	case hwmon_temp_alarm:
 		*val = !!(log->critical_warning & NVME_SMART_CRIT_TEMPERATURE);
-- 
2.7.4

