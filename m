Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3064111F5F2
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2019 06:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfLOFRZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Dec 2019 00:17:25 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39916 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfLOFRZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Dec 2019 00:17:25 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so3758321pfx.6;
        Sat, 14 Dec 2019 21:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yyoE/kJT7Za8oOamE8LAfuYOwDLTmHlQFdtd0CuJ34k=;
        b=N4CbPu6fl9qY4tyGJ0tQFP8vj5OWJLuktbW6f/YyYtElFDPg0L6iPbWlqQakJuy8e7
         tTzV3KjkXuGVcoQt5Emmir0+p/P7qL/ZZBZhJmhwP6oL1nwdkjxUMHjusjoJPgdRGx9z
         /XQVX5oH5xkWXa9NBmnAYiU/+CrOqduGAcw2UeJvDaYOirsO0IyoYt1Wt/e+Zs1JUNly
         xLiu7BZXozvgfoYzc8bdKq3Rg+il2wTHFloMdTvVHeTEFZ7tUQZ3w5JHXt5ZMpYdDCn8
         6UsGDqNo/rYSrt05bQT6p21UdUXssIDE92iyshielrqWwUEdSC/qQvE1gmRAixv4nl51
         e1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yyoE/kJT7Za8oOamE8LAfuYOwDLTmHlQFdtd0CuJ34k=;
        b=IeBi9GUYYZQdCHWGxqmuR2RkQCByOu8tP5vc1grP1krxXUDBdF3k6iB+AE91G8X5wg
         vL2sKBKvoChQ2VD1vmssosYxBg0LjIPrRxCZ+HDpOMU2YLENugEso7/wVH/lfpW69O/F
         /Zye2CZ+LSE5ysTlmyn8qh8OyqgSVe6sR/Qz4iHSaLrdlE9VR1eEHuYGYPGX+3DnmiOe
         tfCZQKdN9mEHlOeprSNyoFUePcy5hW8yr/EeYKCz4JDuILdHHRj0kY1BuuQqFqfcDwTe
         spOoR5xNH3HajZtGCD+f79m4DWGnMh5FS1Mdl30ltS1dlSsl5xumRU+xMx8zeuyUgORy
         akIA==
X-Gm-Message-State: APjAAAXigSFFaBNmrB7PklYXvLh5cFCT4y42izcEFUaFh9nD0kaA7fND
        WybGMytjcYI6gBmh+ZPfI5M=
X-Google-Smtp-Source: APXvYqx3VkY0cSg/7bN0Y0W5G2/U6JBARCdKWa0nOQSgon43lbz4BsIfhgC4OCM7Owt5n+zvtJvdnQ==
X-Received: by 2002:a63:cc4f:: with SMTP id q15mr10235784pgi.159.1576387044564;
        Sat, 14 Dec 2019 21:17:24 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id u10sm16596528pgg.41.2019.12.14.21.17.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 14 Dec 2019 21:17:23 -0800 (PST)
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
Subject: [PATCH v4 07/12] nvme: hwmon: switch to use <linux/units.h> helpers
Date:   Sun, 15 Dec 2019 14:16:10 +0900
Message-Id: <1576386975-7941-8-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
References: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
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
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v4
- add Reviewed-by tags

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

