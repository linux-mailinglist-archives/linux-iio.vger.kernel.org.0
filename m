Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 602C411F5DB
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2019 06:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfLOFQ5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Dec 2019 00:16:57 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38975 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfLOFQ4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Dec 2019 00:16:56 -0500
Received: by mail-pg1-f194.google.com with SMTP id b137so1723509pga.6;
        Sat, 14 Dec 2019 21:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+ni+XvUfeKyfzr2yd/pJZb0s5CL2FQmAH0qUgXjirMQ=;
        b=f/OUThotWQpXaPGbzZ5R2FFLQ9ZUuy00n1PH97c9VUEl75bjGc9e0sh4S8N0ybzh2n
         qMJB8Bm9YAiCGqFwp3vDbHJ0xpZ8jEdF/uLy4Alyt3KKPeEo7fQwbL4cnyGigGd5bc8u
         GtiocPYRjuw8KZon5ULZi9jVlmgPoADTR2ntVtsAUdxzVQq/7iWq5Meu4KkHjL8w60FI
         iBeFKiN4y48MNQW7DYPIU/98OSOoGsJXtRB8hq4I65KzxdtwjprvTSRnZarEskRf5+by
         /tVG6bXx5Qn/RUBGtMlwu/9C7yUUCmvHm/Bhsa/AihPo04Ym0Xqdn8C+FjS5DQuavmxk
         ymsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+ni+XvUfeKyfzr2yd/pJZb0s5CL2FQmAH0qUgXjirMQ=;
        b=Z2DaRucLW8jLkOKf5XErl5TccVBPOPmSkQqq3RkWHNGNkGbZc1AdxMTuIQVrQz23Ev
         oOE+AjMMFpsbfQ2VjfgzY2aUxFkNbt32848sixxQgRUbYlO31BMPd2bStvwoOm7qauP4
         mSbiyX3WIPhiMvsX82Cc/vSvSohAU0QWPDNxbQLpDtNMVAxhHN0ETjliS/jt6eNb8YOQ
         n3q7F2NgndMNxKM6BcU8WCkM4KAiP/HBpz4Z34Ioc/V3MvGcSXj23VccIKv9BCu24N7V
         Lgx0+4oI4JRXFl03lLNTFeUx/v4gNjAjml/Jp/ughziykna3b4VE9ovjoPx44sHlem3y
         U1Ew==
X-Gm-Message-State: APjAAAU6G4jIh56R2x4bQSUB0hXZdgScLzCxBeY7M0wunk7SGBOx0dCA
        4mHn1ljsZS4wwhM3Wscvxxc=
X-Google-Smtp-Source: APXvYqxRB7OPbFfVEFAxX9HKfb1NP04PbmHKjMIQqfZChZstN8X4ZFRN9baeNaRgyvH4MwVUoPUBEw==
X-Received: by 2002:a63:d544:: with SMTP id v4mr9985261pgi.288.1576387015843;
        Sat, 14 Dec 2019 21:16:55 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id u10sm16596528pgg.41.2019.12.14.21.16.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 14 Dec 2019 21:16:55 -0800 (PST)
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
Subject: [PATCH v4 02/12] ACPI: thermal: switch to use <linux/units.h> helpers
Date:   Sun, 15 Dec 2019 14:16:05 +0900
Message-Id: <1576386975-7941-3-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
References: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
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
* v4
- change include order
- keep the line over 80 characters because this change doesn't make it longer

 drivers/acpi/thermal.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index d831a61..19067a5 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -27,6 +27,7 @@
 #include <linux/acpi.h>
 #include <linux/workqueue.h>
 #include <linux/uaccess.h>
+#include <linux/units.h>
 
 #define PREFIX "ACPI: "
 
@@ -172,7 +173,7 @@ struct acpi_thermal {
 	struct acpi_handle_list devices;
 	struct thermal_zone_device *thermal_zone;
 	int tz_enabled;
-	int kelvin_offset;
+	int kelvin_offset;	/* in millidegrees */
 	struct work_struct thermal_check_work;
 };
 
@@ -297,7 +298,8 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 			if (crt == -1) {
 				tz->trips.critical.flags.valid = 0;
 			} else if (crt > 0) {
-				unsigned long crt_k = CELSIUS_TO_DECI_KELVIN(crt);
+				unsigned long crt_k = celsius_to_deci_kelvin(crt);
+
 				/*
 				 * Allow override critical threshold
 				 */
@@ -333,7 +335,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 		if (psv == -1) {
 			status = AE_SUPPORT;
 		} else if (psv > 0) {
-			tmp = CELSIUS_TO_DECI_KELVIN(psv);
+			tmp = celsius_to_deci_kelvin(psv);
 			status = AE_OK;
 		} else {
 			status = acpi_evaluate_integer(tz->device->handle,
@@ -413,7 +415,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 					break;
 				if (i == 1)
 					tz->trips.active[0].temperature =
-						CELSIUS_TO_DECI_KELVIN(act);
+						celsius_to_deci_kelvin(act);
 				else
 					/*
 					 * Don't allow override higher than
@@ -421,9 +423,9 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
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
@@ -519,7 +521,7 @@ static int thermal_get_temp(struct thermal_zone_device *thermal, int *temp)
 	if (result)
 		return result;
 
-	*temp = DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(tz->temperature,
+	*temp = deci_kelvin_to_millicelsius_with_offset(tz->temperature,
 							tz->kelvin_offset);
 	return 0;
 }
@@ -624,7 +626,7 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 
 	if (tz->trips.critical.flags.valid) {
 		if (!trip) {
-			*temp = DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(
+			*temp = deci_kelvin_to_millicelsius_with_offset(
 				tz->trips.critical.temperature,
 				tz->kelvin_offset);
 			return 0;
@@ -634,7 +636,7 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 
 	if (tz->trips.hot.flags.valid) {
 		if (!trip) {
-			*temp = DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(
+			*temp = deci_kelvin_to_millicelsius_with_offset(
 				tz->trips.hot.temperature,
 				tz->kelvin_offset);
 			return 0;
@@ -644,7 +646,7 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 
 	if (tz->trips.passive.flags.valid) {
 		if (!trip) {
-			*temp = DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(
+			*temp = deci_kelvin_to_millicelsius_with_offset(
 				tz->trips.passive.temperature,
 				tz->kelvin_offset);
 			return 0;
@@ -655,7 +657,7 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE &&
 		tz->trips.active[i].flags.valid; i++) {
 		if (!trip) {
-			*temp = DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(
+			*temp = deci_kelvin_to_millicelsius_with_offset(
 				tz->trips.active[i].temperature,
 				tz->kelvin_offset);
 			return 0;
@@ -672,7 +674,7 @@ static int thermal_get_crit_temp(struct thermal_zone_device *thermal,
 	struct acpi_thermal *tz = thermal->devdata;
 
 	if (tz->trips.critical.flags.valid) {
-		*temperature = DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(
+		*temperature = deci_kelvin_to_millicelsius_with_offset(
 				tz->trips.critical.temperature,
 				tz->kelvin_offset);
 		return 0;
@@ -692,7 +694,7 @@ static int thermal_get_trend(struct thermal_zone_device *thermal,
 
 	if (type == THERMAL_TRIP_ACTIVE) {
 		int trip_temp;
-		int temp = DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(
+		int temp = deci_kelvin_to_millicelsius_with_offset(
 					tz->temperature, tz->kelvin_offset);
 		if (thermal_get_trip_temp(thermal, trip, &trip_temp))
 			return -EINVAL;
@@ -1043,9 +1045,9 @@ static void acpi_thermal_guess_offset(struct acpi_thermal *tz)
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
@@ -1087,7 +1089,7 @@ static int acpi_thermal_add(struct acpi_device *device)
 	INIT_WORK(&tz->thermal_check_work, acpi_thermal_check_fn);
 
 	pr_info(PREFIX "%s [%s] (%ld C)\n", acpi_device_name(device),
-		acpi_device_bid(device), DECI_KELVIN_TO_CELSIUS(tz->temperature));
+		acpi_device_bid(device), deci_kelvin_to_celsius(tz->temperature));
 	goto end;
 
 free_memory:
-- 
2.7.4

