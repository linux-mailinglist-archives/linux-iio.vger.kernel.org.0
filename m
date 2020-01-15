Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A48C13CB3B
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2020 18:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgAORo3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jan 2020 12:44:29 -0500
Received: from mga18.intel.com ([134.134.136.126]:36161 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728896AbgAORo3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 15 Jan 2020 12:44:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 09:44:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,323,1574150400"; 
   d="scan'208";a="254357316"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jan 2020 09:44:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DCA1D8D; Wed, 15 Jan 2020 19:44:25 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] iio: magnetometer: ak8975: Convert to use device_get_match_data()
Date:   Wed, 15 Jan 2020 19:44:25 +0200
Message-Id: <20200115174425.70728-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200115174425.70728-1-andriy.shevchenko@linux.intel.com>
References: <20200115174425.70728-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert to use device_get_match_data() instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/magnetometer/ak8975.c | 39 +++++++++++++------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 8e50e073bcbf..3c881541ae72 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -203,11 +203,11 @@ static long ak09912_raw_to_gauss(u16 data)
 
 /* Compatible Asahi Kasei Compass parts */
 enum asahi_compass_chipset {
+	AKXXXX		= 0,
 	AK8975,
 	AK8963,
 	AK09911,
 	AK09912,
-	AK_MAX_TYPE
 };
 
 enum ak_ctrl_reg_addr {
@@ -245,7 +245,7 @@ struct ak_def {
 	u8 data_regs[3];
 };
 
-static const struct ak_def ak_def_array[AK_MAX_TYPE] = {
+static const struct ak_def ak_def_array[] = {
 	{
 		.type = AK8975,
 		.raw_to_gauss = ak8975_raw_to_gauss,
@@ -781,19 +781,6 @@ static const struct acpi_device_id ak_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, ak_acpi_match);
 #endif
 
-static const char *ak8975_match_acpi_device(struct device *dev,
-					    enum asahi_compass_chipset *chipset)
-{
-	const struct acpi_device_id *id;
-
-	id = acpi_match_device(dev->driver->acpi_match_table, dev);
-	if (!id)
-		return NULL;
-	*chipset = (int)id->driver_data;
-
-	return dev_name(dev);
-}
-
 static void ak8975_fill_buffer(struct iio_dev *indio_dev)
 {
 	struct ak8975_data *data = iio_priv(indio_dev);
@@ -852,9 +839,11 @@ static int ak8975_probe(struct i2c_client *client,
 	struct ak8975_data *data;
 	struct iio_dev *indio_dev;
 	struct gpio_desc *eoc_gpiod;
+	const void *match;
+	unsigned int i;
 	int err;
+	enum asahi_compass_chipset chipset;
 	const char *name = NULL;
-	enum asahi_compass_chipset chipset = AK_MAX_TYPE;
 
 	/*
 	 * Grab and set up the supplied GPIO.
@@ -884,23 +873,27 @@ static int ak8975_probe(struct i2c_client *client,
 		return err;
 
 	/* id will be NULL when enumerated via ACPI */
-	if (id) {
+	match = device_get_match_data(&client->dev);
+	if (match) {
+		chipset = (enum asahi_compass_chipset)(match);
+		name = dev_name(&client->dev);
+	} else if (id) {
 		chipset = (enum asahi_compass_chipset)(id->driver_data);
 		name = id->name;
-	} else if (ACPI_HANDLE(&client->dev)) {
-		name = ak8975_match_acpi_device(&client->dev, &chipset);
-		if (!name)
-			return -ENODEV;
 	} else
 		return -ENOSYS;
 
-	if (chipset >= AK_MAX_TYPE) {
+	for (i = 0; i < ARRAY_SIZE(ak_def_array); i++)
+		if (ak_def_array[i].type == chipset)
+			break;
+
+	if (i == ARRAY_SIZE(ak_def_array)) {
 		dev_err(&client->dev, "AKM device type unsupported: %d\n",
 			chipset);
 		return -ENODEV;
 	}
 
-	data->def = &ak_def_array[chipset];
+	data->def = &ak_def_array[i];
 
 	/* Fetch the regulators */
 	data->vdd = devm_regulator_get(&client->dev, "vdd");
-- 
2.24.1

