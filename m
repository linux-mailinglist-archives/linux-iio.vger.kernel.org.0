Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13115460950
	for <lists+linux-iio@lfdr.de>; Sun, 28 Nov 2021 20:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236497AbhK1T1B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Nov 2021 14:27:01 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47672 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357518AbhK1TZB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Nov 2021 14:25:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D435A61119
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 19:21:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0434AC53FC1;
        Sun, 28 Nov 2021 19:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638127304;
        bh=fqvgG67gaFaU5kuikL+9PoOSbs/qczqO7rdqitpKIpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DizsVaEgBGfNyiTL6r/11zuVkWu6L2AEtTPv0xJp85kwHnJ6Iny1KCrUpYaK/j4Kj
         csCupURMHXNSj37QX/K3g/FGaCn2oVJo8a1wgo+Cn0GygjH76U2dNxztRAdc55xKyk
         2tCeaJTLS5oL7AlHERHZpvrGeselTfMDzR1byKpKwrns6SAkGqYD2xxYPzEl6Xl7LX
         /d7BNsCkxETzz7X/EzyakT16RBAhTuX2bmLKPotQYIwgfQHyb/uDf7iT11hdBhYzmG
         onLKnAW+RjlnvDPv4FZyohW36cdQHOMVg3oROagL1D5h/5JJI3Ac0BnnykVUbuaSV0
         3SYBfKOXaFCjQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Signed-off-by : Lars-Peter Clausen" <lars@metafoo.de>
Subject: [PATCH 01/12] iio:dac:ad5755: Switch to generic firmware properties.
Date:   Sun, 28 Nov 2021 19:26:24 +0000
Message-Id: <20211128192635.2724359-2-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211128192635.2724359-1-jic23@kernel.org>
References: <20211128192635.2724359-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Done by inspection only.  Mostly completely mechanical with the
exception of a few places where default value handling is
cleaner done by first setting the value, then calling the
firmware reading function but and not checking the return value,
as opposed to reading firmware then setting the default if an error
occurs.

Part of general attempt to move all of IIO over to generic
device properties, both to enable other firmware types and
to remove drivers that can be the source of of_ specific
behaviour in new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/dac/ad5755.c | 47 ++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index cabc38d54085..d6d3a03afee4 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -13,7 +13,7 @@
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/delay.h>
-#include <linux/of.h>
+#include <linux/property.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/platform_data/ad5755.h>
@@ -111,7 +111,6 @@ enum ad5755_type {
 	ID_AD5737,
 };
 
-#ifdef CONFIG_OF
 static const int ad5755_dcdc_freq_table[][2] = {
 	{ 250000, AD5755_DC_DC_FREQ_250kHZ },
 	{ 410000, AD5755_DC_DC_FREQ_410kHZ },
@@ -154,7 +153,6 @@ static const int ad5755_slew_step_table[][2] = {
 	{ 2, AD5755_SLEW_STEP_SIZE_2 },
 	{ 1, AD5755_SLEW_STEP_SIZE_1 },
 };
-#endif
 
 static int ad5755_write_unlocked(struct iio_dev *indio_dev,
 	unsigned int reg, unsigned int val)
@@ -604,11 +602,9 @@ static const struct ad5755_platform_data ad5755_default_pdata = {
 	},
 };
 
-#ifdef CONFIG_OF
-static struct ad5755_platform_data *ad5755_parse_dt(struct device *dev)
+static struct ad5755_platform_data *ad5755_parse_fw(struct device *dev)
 {
-	struct device_node *np = dev->of_node;
-	struct device_node *pp;
+	struct fwnode_handle *pp;
 	struct ad5755_platform_data *pdata;
 	unsigned int tmp;
 	unsigned int tmparray[3];
@@ -619,15 +615,13 @@ static struct ad5755_platform_data *ad5755_parse_dt(struct device *dev)
 		return NULL;
 
 	pdata->ext_dc_dc_compenstation_resistor =
-	    of_property_read_bool(np, "adi,ext-dc-dc-compenstation-resistor");
+	    device_property_read_bool(dev, "adi,ext-dc-dc-compenstation-resistor");
 
-	if (!of_property_read_u32(np, "adi,dc-dc-phase", &tmp))
-		pdata->dc_dc_phase = tmp;
-	else
-		pdata->dc_dc_phase = AD5755_DC_DC_PHASE_ALL_SAME_EDGE;
+	pdata->dc_dc_phase = AD5755_DC_DC_PHASE_ALL_SAME_EDGE;
+	device_property_read_u32(dev, "adi,dc-dc-phase", &pdata->dc_dc_phase);
 
 	pdata->dc_dc_freq = AD5755_DC_DC_FREQ_410kHZ;
-	if (!of_property_read_u32(np, "adi,dc-dc-freq-hz", &tmp)) {
+	if (!device_property_read_u32(dev, "adi,dc-dc-freq-hz", &tmp)) {
 		for (i = 0; i < ARRAY_SIZE(ad5755_dcdc_freq_table); i++) {
 			if (tmp == ad5755_dcdc_freq_table[i][0]) {
 				pdata->dc_dc_freq = ad5755_dcdc_freq_table[i][1];
@@ -641,7 +635,7 @@ static struct ad5755_platform_data *ad5755_parse_dt(struct device *dev)
 	}
 
 	pdata->dc_dc_maxv = AD5755_DC_DC_MAXV_23V;
-	if (!of_property_read_u32(np, "adi,dc-dc-max-microvolt", &tmp)) {
+	if (!device_property_read_u32(dev, "adi,dc-dc-max-microvolt", &tmp)) {
 		for (i = 0; i < ARRAY_SIZE(ad5755_dcdc_maxv_table); i++) {
 			if (tmp == ad5755_dcdc_maxv_table[i][0]) {
 				pdata->dc_dc_maxv = ad5755_dcdc_maxv_table[i][1];
@@ -654,25 +648,23 @@ static struct ad5755_platform_data *ad5755_parse_dt(struct device *dev)
 	}
 
 	devnr = 0;
-	for_each_child_of_node(np, pp) {
+	device_for_each_child_node(dev, pp) {
 		if (devnr >= AD5755_NUM_CHANNELS) {
 			dev_err(dev,
 				"There are too many channels defined in DT\n");
 			goto error_out;
 		}
 
-		if (!of_property_read_u32(pp, "adi,mode", &tmp))
-			pdata->dac[devnr].mode = tmp;
-		else
-			pdata->dac[devnr].mode = AD5755_MODE_CURRENT_4mA_20mA;
+		pdata->dac[devnr].mode = AD5755_MODE_CURRENT_4mA_20mA;
+		fwnode_property_read_u32(pp, "adi,mode", &pdata->dac[devnr].mode);
 
 		pdata->dac[devnr].ext_current_sense_resistor =
-		    of_property_read_bool(pp, "adi,ext-current-sense-resistor");
+		    fwnode_property_read_bool(pp, "adi,ext-current-sense-resistor");
 
 		pdata->dac[devnr].enable_voltage_overrange =
-		    of_property_read_bool(pp, "adi,enable-voltage-overrange");
+		    fwnode_property_read_bool(pp, "adi,enable-voltage-overrange");
 
-		if (!of_property_read_u32_array(pp, "adi,slew", tmparray, 3)) {
+		if (!fwnode_property_read_u32_array(pp, "adi,slew", tmparray, 3)) {
 			pdata->dac[devnr].slew.enable = tmparray[0];
 
 			pdata->dac[devnr].slew.rate = AD5755_SLEW_RATE_64k;
@@ -715,13 +707,6 @@ static struct ad5755_platform_data *ad5755_parse_dt(struct device *dev)
 	devm_kfree(dev, pdata);
 	return NULL;
 }
-#else
-static
-struct ad5755_platform_data *ad5755_parse_dt(struct device *dev)
-{
-	return NULL;
-}
-#endif
 
 static int ad5755_probe(struct spi_device *spi)
 {
@@ -751,8 +736,8 @@ static int ad5755_probe(struct spi_device *spi)
 
 	mutex_init(&st->lock);
 
-	if (spi->dev.of_node)
-		pdata = ad5755_parse_dt(&spi->dev);
+	if (dev_fwnode(&spi->dev))
+		pdata = ad5755_parse_fw(&spi->dev);
 	else
 		pdata = spi->dev.platform_data;
 
-- 
2.34.1

