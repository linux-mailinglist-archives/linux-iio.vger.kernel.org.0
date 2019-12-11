Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA0811ADB1
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2019 15:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbfLKOjC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Dec 2019 09:39:02 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42107 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbfLKOjC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2019 09:39:02 -0500
Received: by mail-pl1-f195.google.com with SMTP id x13so1495116plr.9;
        Wed, 11 Dec 2019 06:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aMYza2espJ/tsAfz58SlTUu9MiIVLwdjN+KGLUAdlkE=;
        b=ZmbMzGAVOLos2wnlXjV4De+DkX0AUl8htzrbUZXvcjTz41yV8mzhq2Xh3m+J/Zla9j
         55zJVO5QiBpZCbAs5gWpCCsy+rg/HZoWpr+sH5Mc9Ta5lAH/sOM7w/jAraSQS00LxkBX
         leXm7xaBC3XzleVMz6N9sVnthNhRcEqBY9guO4Y8rron4wVUh/cRu5XLZlPWqg/CTfga
         qK8D9y9qP9Cjqee46+FsICfy275Kte5NsrseywAt/0CQPNuSjgeKzhcme9IG10ccZTZx
         E/YRyK1J/JHwi2MS1QQpaB6/kwzWG1JAR9P+yNptzg1tMglqfgGaypUnmwaibnbJmKyU
         hbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aMYza2espJ/tsAfz58SlTUu9MiIVLwdjN+KGLUAdlkE=;
        b=ltCnwWNzp9QeQnSLQdtSN8JjgI2yUP6Znd/0R6k+UMlYLzMhS+O7Gb9UZAnpuXJ3YR
         5T/0sZVoOGIDOBeGQC9XBMmPCuX4UV3XFcvB1JL8hKIRIkG6O31kfIfZADEiFho3yn68
         lDwL1XRCPT8DItb+EBV+PVGQNuTEHw7Uu5TvTqvkQ5m+BflB9Tlswvv4n+r5PF1quwxF
         av2zRKkhGUviZRCV5xm12zJlmlAC5LZU3mNN7v6dTmFNf6JWXU0lSumJXRBBpiFe49bc
         Fzm/W5bdekzX4Yy0NAHGeGUBIDPjO4BQkJ5ABnlhR10/wKc+IP/7AFSQmLU2UmPdy3ir
         56sw==
X-Gm-Message-State: APjAAAWhIHkpauRjQyl1aL5jm8fPbzAbFtNA5DI9QNYEYyfSz5u6Vrjb
        /iq8Ab0Uo8Frpcd4BjRGxB0=
X-Google-Smtp-Source: APXvYqy6Lr7fbZ/IBRJirlmpGo6SxC7Xb8FPSycy3BjYlrj9ONpGAPdSZREbQPlLJFCiCP7CrAkBZg==
X-Received: by 2002:a17:90b:4396:: with SMTP id in22mr3702546pjb.111.1576075141056;
        Wed, 11 Dec 2019 06:39:01 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id q11sm3444239pff.111.2019.12.11.06.38.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Dec 2019 06:39:00 -0800 (PST)
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
Subject: [PATCH v3 02/12] ACPI: thermal: switch to use <linux/units.h> helpers
Date:   Wed, 11 Dec 2019 23:38:09 +0900
Message-Id: <1576075099-3441-3-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
References: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This switches the ACPI thermal zone driver to use celsius_to_deci_kelvin(),
deci_kelvin_to_celsius(), and deci_kelvin_to_millicelsius_with_offset() in
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

 drivers/acpi/thermal.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index d831a61..8a436f5 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -24,6 +24,7 @@
 #include <linux/reboot.h>
 #include <linux/device.h>
 #include <linux/thermal.h>
+#include <linux/units.h>
 #include <linux/acpi.h>
 #include <linux/workqueue.h>
 #include <linux/uaccess.h>
@@ -172,7 +173,7 @@ struct acpi_thermal {
 	struct acpi_handle_list devices;
 	struct thermal_zone_device *thermal_zone;
 	int tz_enabled;
-	int kelvin_offset;
+	int kelvin_offset;	/* in millidegrees */
 	struct work_struct thermal_check_work;
 };
 
@@ -297,7 +298,9 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 			if (crt == -1) {
 				tz->trips.critical.flags.valid = 0;
 			} else if (crt > 0) {
-				unsigned long crt_k = CELSIUS_TO_DECI_KELVIN(crt);
+				unsigned long crt_k =
+					celsius_to_deci_kelvin(crt);
+
 				/*
 				 * Allow override critical threshold
 				 */
@@ -333,7 +336,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 		if (psv == -1) {
 			status = AE_SUPPORT;
 		} else if (psv > 0) {
-			tmp = CELSIUS_TO_DECI_KELVIN(psv);
+			tmp = celsius_to_deci_kelvin(psv);
 			status = AE_OK;
 		} else {
 			status = acpi_evaluate_integer(tz->device->handle,
@@ -413,7 +416,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 					break;
 				if (i == 1)
 					tz->trips.active[0].temperature =
-						CELSIUS_TO_DECI_KELVIN(act);
+						celsius_to_deci_kelvin(act);
 				else
 					/*
 					 * Don't allow override higher than
@@ -421,9 +424,9 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 					 */
 					tz->trips.active[i - 1].temperature =
 						(tz->trips.active[i - 2].temperature <
-						CELSIUS_TO_DECI_KELVIN(act) ?
+						celsius_to_deci_kelvin(act) ?
 						tz->trips.active[i - 2].temperature :
-						CELSIUS_TO_DECI_KELVIN(act));
+						celsius_to_deci_kelvin(act));
 				break;
 			} else {
 				tz->trips.active[i].temperature = tmp;
@@ -519,7 +522,7 @@ static int thermal_get_temp(struct thermal_zone_device *thermal, int *temp)
 	if (result)
 		return result;
 
-	*temp = DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(tz->temperature,
+	*temp = deci_kelvin_to_millicelsius_with_offset(tz->temperature,
 							tz->kelvin_offset);
 	return 0;
 }
@@ -624,7 +627,7 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 
 	if (tz->trips.critical.flags.valid) {
 		if (!trip) {
-			*temp = DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(
+			*temp = deci_kelvin_to_millicelsius_with_offset(
 				tz->trips.critical.temperature,
 				tz->kelvin_offset);
 			return 0;
@@ -634,7 +637,7 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 
 	if (tz->trips.hot.flags.valid) {
 		if (!trip) {
-			*temp = DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(
+			*temp = deci_kelvin_to_millicelsius_with_offset(
 				tz->trips.hot.temperature,
 				tz->kelvin_offset);
 			return 0;
@@ -644,7 +647,7 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 
 	if (tz->trips.passive.flags.valid) {
 		if (!trip) {
-			*temp = DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(
+			*temp = deci_kelvin_to_millicelsius_with_offset(
 				tz->trips.passive.temperature,
 				tz->kelvin_offset);
 			return 0;
@@ -655,7 +658,7 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE &&
 		tz->trips.active[i].flags.valid; i++) {
 		if (!trip) {
-			*temp = DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(
+			*temp = deci_kelvin_to_millicelsius_with_offset(
 				tz->trips.active[i].temperature,
 				tz->kelvin_offset);
 			return 0;
@@ -672,7 +675,7 @@ static int thermal_get_crit_temp(struct thermal_zone_device *thermal,
 	struct acpi_thermal *tz = thermal->devdata;
 
 	if (tz->trips.critical.flags.valid) {
-		*temperature = DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(
+		*temperature = deci_kelvin_to_millicelsius_with_offset(
 				tz->trips.critical.temperature,
 				tz->kelvin_offset);
 		return 0;
@@ -692,7 +695,7 @@ static int thermal_get_trend(struct thermal_zone_device *thermal,
 
 	if (type == THERMAL_TRIP_ACTIVE) {
 		int trip_temp;
-		int temp = DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(
+		int temp = deci_kelvin_to_millicelsius_with_offset(
 					tz->temperature, tz->kelvin_offset);
 		if (thermal_get_trip_temp(thermal, trip, &trip_temp))
 			return -EINVAL;
@@ -1043,9 +1046,9 @@ static void acpi_thermal_guess_offset(struct acpi_thermal *tz)
 {
 	if (tz->trips.critical.flags.valid &&
 	    (tz->trips.critical.temperature % 5) == 1)
-		tz->kelvin_offset = 2731;
+		tz->kelvin_offset = 273100;
 	else
-		tz->kelvin_offset = 2732;
+		tz->kelvin_offset = 273200;
 }
 
 static void acpi_thermal_check_fn(struct work_struct *work)
@@ -1087,7 +1090,8 @@ static int acpi_thermal_add(struct acpi_device *device)
 	INIT_WORK(&tz->thermal_check_work, acpi_thermal_check_fn);
 
 	pr_info(PREFIX "%s [%s] (%ld C)\n", acpi_device_name(device),
-		acpi_device_bid(device), DECI_KELVIN_TO_CELSIUS(tz->temperature));
+		acpi_device_bid(device),
+		deci_kelvin_to_celsius(tz->temperature));
 	goto end;
 
 free_memory:
-- 
2.7.4

