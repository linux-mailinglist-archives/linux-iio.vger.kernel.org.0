Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E83510FC5F
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2019 12:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfLCLR6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Dec 2019 06:17:58 -0500
Received: from mga03.intel.com ([134.134.136.65]:12408 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfLCLR5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 3 Dec 2019 06:17:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 03:17:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,272,1571727600"; 
   d="scan'208";a="235844986"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 03 Dec 2019 03:17:55 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 432A1115; Tue,  3 Dec 2019 13:17:54 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] iio: adc: ti-ads1025: Get rid of legacy platform data
Date:   Tue,  3 Dec 2019 13:17:52 +0200
Message-Id: <20191203111753.55146-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Platform data is a legacy interface to supply device properties
to the driver. In this case we even don't have in-kernel users
for it. Just remove it for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/ti-ads1015.c          | 18 ++++++++----------
 include/Kbuild                        |  1 -
 include/linux/platform_data/ads1015.h | 23 -----------------------
 3 files changed, 8 insertions(+), 34 deletions(-)
 delete mode 100644 include/linux/platform_data/ads1015.h

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index a550b132cfb7..3b123b4f0b99 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -21,8 +21,6 @@
 #include <linux/mutex.h>
 #include <linux/delay.h>
 
-#include <linux/platform_data/ads1015.h>
-
 #include <linux/iio/iio.h>
 #include <linux/iio/types.h>
 #include <linux/iio/sysfs.h>
@@ -33,6 +31,8 @@
 
 #define ADS1015_DRV_NAME "ads1015"
 
+#define ADS1015_CHANNELS 8
+
 #define ADS1015_CONV_REG	0x00
 #define ADS1015_CFG_REG		0x01
 #define ADS1015_LO_THRESH_REG	0x02
@@ -219,6 +219,12 @@ static const struct iio_event_spec ads1015_events[] = {
 	.datasheet_name = "AIN"#_chan"-AIN"#_chan2,		\
 }
 
+struct ads1015_channel_data {
+	bool enabled;
+	unsigned int pga;
+	unsigned int data_rate;
+};
+
 struct ads1015_thresh_data {
 	unsigned int comp_queue;
 	int high_thresh;
@@ -903,14 +909,6 @@ static void ads1015_get_channels_config(struct i2c_client *client)
 
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct ads1015_data *data = iio_priv(indio_dev);
-	struct ads1015_platform_data *pdata = dev_get_platdata(&client->dev);
-
-	/* prefer platform data */
-	if (pdata) {
-		memcpy(data->channel_data, pdata->channel_data,
-		       sizeof(data->channel_data));
-		return;
-	}
 
 #ifdef CONFIG_OF
 	if (!ads1015_get_channels_config_of(client))
diff --git a/include/Kbuild b/include/Kbuild
index ffba79483cc5..498821e5d9ed 100644
--- a/include/Kbuild
+++ b/include/Kbuild
@@ -443,7 +443,6 @@ header-test-			+= linux/platform_data/ad7793.h
 header-test-			+= linux/platform_data/ad7887.h
 header-test-			+= linux/platform_data/adau17x1.h
 header-test-			+= linux/platform_data/adp8870.h
-header-test-			+= linux/platform_data/ads1015.h
 header-test-			+= linux/platform_data/ads7828.h
 header-test-			+= linux/platform_data/apds990x.h
 header-test-			+= linux/platform_data/arm-ux500-pm.h
diff --git a/include/linux/platform_data/ads1015.h b/include/linux/platform_data/ads1015.h
deleted file mode 100644
index 4cc9ffcafcbf..000000000000
--- a/include/linux/platform_data/ads1015.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Platform Data for ADS1015 12-bit 4-input ADC
- * (C) Copyright 2010
- * Dirk Eibach, Guntermann & Drunck GmbH <eibach@gdsys.de>
- */
-
-#ifndef LINUX_ADS1015_H
-#define LINUX_ADS1015_H
-
-#define ADS1015_CHANNELS 8
-
-struct ads1015_channel_data {
-	bool enabled;
-	unsigned int pga;
-	unsigned int data_rate;
-};
-
-struct ads1015_platform_data {
-	struct ads1015_channel_data channel_data[ADS1015_CHANNELS];
-};
-
-#endif /* LINUX_ADS1015_H */
-- 
2.24.0

