Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC49913CB3A
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2020 18:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAORo2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jan 2020 12:44:28 -0500
Received: from mga04.intel.com ([192.55.52.120]:15614 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbgAORo2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 15 Jan 2020 12:44:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 09:44:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,323,1574150400"; 
   d="scan'208";a="248485904"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 15 Jan 2020 09:44:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D1055BD; Wed, 15 Jan 2020 19:44:25 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] iio: magnetometer: ak8975: Get rid of platform data
Date:   Wed, 15 Jan 2020 19:44:24 +0200
Message-Id: <20200115174425.70728-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since IIO framework supports device property API and driver has been moved
already to the use of GPIO descriptors the logical continuation is to
get rid of platform data completely. We are on the safe side here since
there are no users of it in the kernel.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/magnetometer/ak8975.c       | 14 +++-----------
 include/linux/iio/magnetometer/ak8975.h | 15 ---------------
 2 files changed, 3 insertions(+), 26 deletions(-)
 delete mode 100644 include/linux/iio/magnetometer/ak8975.h

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 55cffaa82456..8e50e073bcbf 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -28,8 +28,6 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
-#include <linux/iio/magnetometer/ak8975.h>
-
 /*
  * Register definitions, as well as various shifts and masks to get at the
  * individual fields of the registers.
@@ -857,8 +855,6 @@ static int ak8975_probe(struct i2c_client *client,
 	int err;
 	const char *name = NULL;
 	enum asahi_compass_chipset chipset = AK_MAX_TYPE;
-	const struct ak8975_platform_data *pdata =
-		dev_get_platdata(&client->dev);
 
 	/*
 	 * Grab and set up the supplied GPIO.
@@ -883,13 +879,9 @@ static int ak8975_probe(struct i2c_client *client,
 	data->eoc_gpiod = eoc_gpiod;
 	data->eoc_irq = 0;
 
-	if (!pdata) {
-		err = iio_read_mount_matrix(&client->dev, "mount-matrix",
-					    &data->orientation);
-		if (err)
-			return err;
-	} else
-		data->orientation = pdata->orientation;
+	err = iio_read_mount_matrix(&client->dev, "mount-matrix", &data->orientation);
+	if (err)
+		return err;
 
 	/* id will be NULL when enumerated via ACPI */
 	if (id) {
diff --git a/include/linux/iio/magnetometer/ak8975.h b/include/linux/iio/magnetometer/ak8975.h
deleted file mode 100644
index df3697183800..000000000000
--- a/include/linux/iio/magnetometer/ak8975.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __IIO_MAGNETOMETER_AK8975_H__
-#define __IIO_MAGNETOMETER_AK8975_H__
-
-#include <linux/iio/iio.h>
-
-/**
- * struct ak8975_platform_data - AK8975 magnetometer driver platform data
- * @orientation: mounting matrix relative to main hardware
- */
-struct ak8975_platform_data {
-	struct iio_mount_matrix orientation;
-};
-
-#endif
-- 
2.24.1

