Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1203C5AD3BB
	for <lists+linux-iio@lfdr.de>; Mon,  5 Sep 2022 15:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237600AbiIENVZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Sep 2022 09:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237692AbiIENVO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Sep 2022 09:21:14 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705B0481F6;
        Mon,  5 Sep 2022 06:21:01 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 285CXr14022594;
        Mon, 5 Sep 2022 09:20:57 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jc3u5vt71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 09:20:57 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 285DKu2W029097
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Sep 2022 09:20:56 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 5 Sep 2022
 09:20:55 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 5 Sep 2022 09:20:54 -0400
Received: from george-precision5560.ad.analog.com ([10.48.65.141])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 285DKaY9000352;
        Mon, 5 Sep 2022 09:20:46 -0400
From:   George Mois <george.mois@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lucas.p.stankus@gmail.com>, George Mois <george.mois@analog.com>
Subject: [PATCH v4 2/2] drivers: iio: accel: adxl312 and adxl314 support
Date:   Mon, 5 Sep 2022 16:20:18 +0300
Message-ID: <20220905132018.364900-2-george.mois@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220905132018.364900-1-george.mois@analog.com>
References: <20220905132018.364900-1-george.mois@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: yn4aejqsmmD9tiyx_91wkTaxq0fCuta2
X-Proofpoint-ORIG-GUID: yn4aejqsmmD9tiyx_91wkTaxq0fCuta2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-05_09,2022-09-05_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209050063
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

ADXL312 and ADXL314 are small, thin, low power, 3-axis accelerometers
with high resolution (13-bit) measurement up to +/-12 g and +/- 200 g
respectively.

Implement support for ADXL312 and ADXL314 by extending the ADXL313
driver.

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL312.pdf
Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL314.pdf
Signed-off-by: George Mois <george.mois@analog.com>
---
changes in v4:
 - remove blank line after Datasheet
 - rename adxl312_adxl314_check_id() after first supported part
 - handle part ID check via callback functions
 - move the adxl313_data structure to adxl313.h header for addition
 of callbacks to device specific information
 - add pointer to device specific data to the device id structures
 - get chip_data for either registration path
 - use chip_data in the core_probe() call
 - replace chip_type from regmap_config with chip_data->type
 - move the .data member on the same line with .compatible in the
 module device table
 drivers/iio/accel/adxl313.h      |  35 +++++-
 drivers/iio/accel/adxl313_core.c | 202 ++++++++++++++++++++++---------
 drivers/iio/accel/adxl313_i2c.c  |  74 +++++++----
 drivers/iio/accel/adxl313_spi.c  |  63 +++++++---
 4 files changed, 281 insertions(+), 93 deletions(-)

diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
index 4415f2fc07e1..72f624af4686 100644
--- a/drivers/iio/accel/adxl313.h
+++ b/drivers/iio/accel/adxl313.h
@@ -8,6 +8,8 @@
 #ifndef _ADXL313_H_
 #define _ADXL313_H_
 
+#include <linux/iio/iio.h>
+
 /* ADXL313 register definitions */
 #define ADXL313_REG_DEVID0		0x00
 #define ADXL313_REG_DEVID1		0x01
@@ -26,6 +28,7 @@
 #define ADXL313_REG_FIFO_STATUS		0x39
 
 #define ADXL313_DEVID0			0xAD
+#define ADXL313_DEVID0_ADXL312_314	0xE5
 #define ADXL313_DEVID1			0x1D
 #define ADXL313_PARTID			0xCB
 #define ADXL313_SOFT_RESET		0x52
@@ -37,18 +40,46 @@
 #define ADXL313_MEASUREMENT_MODE	BIT(3)
 
 #define ADXL313_RANGE_MSK		GENMASK(1, 0)
-#define ADXL313_RANGE_4G		3
+#define ADXL313_RANGE_MAX		3
 
 #define ADXL313_FULL_RES		BIT(3)
 #define ADXL313_SPI_3WIRE		BIT(6)
 #define ADXL313_I2C_DISABLE		BIT(6)
 
+extern const struct regmap_access_table adxl312_readable_regs_table;
 extern const struct regmap_access_table adxl313_readable_regs_table;
+extern const struct regmap_access_table adxl314_readable_regs_table;
 
+extern const struct regmap_access_table adxl312_writable_regs_table;
 extern const struct regmap_access_table adxl313_writable_regs_table;
+extern const struct regmap_access_table adxl314_writable_regs_table;
+
+enum adxl313_device_type {
+	ADXL312,
+	ADXL313,
+	ADXL314,
+};
+
+struct adxl313_data {
+	struct regmap	*regmap;
+	const struct adxl313_chip_info *chip_info;
+	struct mutex	lock; /* lock to protect transf_buf */
+	__le16		transf_buf __aligned(IIO_DMA_MINALIGN);
+};
+
+struct adxl313_chip_info {
+	const char			*name;
+	enum adxl313_device_type	type;
+	int				scale_factor;
+	bool				variable_range;
+	bool				soft_reset;
+	int (*check_id)(struct device *dev, struct adxl313_data *data);
+};
+
+extern const struct adxl313_chip_info adxl31x_chip_info[];
 
 int adxl313_core_probe(struct device *dev,
 		       struct regmap *regmap,
-		       const char *name,
+		       const struct adxl313_chip_info *chip_info,
 		       int (*setup)(struct device *, struct regmap *));
 #endif /* _ADXL313_H_ */
diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index afeef779e1d0..ee8a71abbae9 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -8,12 +8,18 @@
  */
 
 #include <linux/bitfield.h>
-#include <linux/iio/iio.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 
 #include "adxl313.h"
 
+static const struct regmap_range adxl312_readable_reg_range[] = {
+	regmap_reg_range(ADXL313_REG_DEVID0, ADXL313_REG_DEVID0),
+	regmap_reg_range(ADXL313_REG_OFS_AXIS(0), ADXL313_REG_OFS_AXIS(2)),
+	regmap_reg_range(ADXL313_REG_THRESH_ACT, ADXL313_REG_ACT_INACT_CTL),
+	regmap_reg_range(ADXL313_REG_BW_RATE, ADXL313_REG_FIFO_STATUS),
+};
+
 static const struct regmap_range adxl313_readable_reg_range[] = {
 	regmap_reg_range(ADXL313_REG_DEVID0, ADXL313_REG_XID),
 	regmap_reg_range(ADXL313_REG_SOFT_RESET, ADXL313_REG_SOFT_RESET),
@@ -22,12 +28,109 @@ static const struct regmap_range adxl313_readable_reg_range[] = {
 	regmap_reg_range(ADXL313_REG_BW_RATE, ADXL313_REG_FIFO_STATUS),
 };
 
+const struct regmap_access_table adxl312_readable_regs_table = {
+	.yes_ranges = adxl312_readable_reg_range,
+	.n_yes_ranges = ARRAY_SIZE(adxl312_readable_reg_range),
+};
+EXPORT_SYMBOL_NS_GPL(adxl312_readable_regs_table, IIO_ADXL313);
+
 const struct regmap_access_table adxl313_readable_regs_table = {
 	.yes_ranges = adxl313_readable_reg_range,
 	.n_yes_ranges = ARRAY_SIZE(adxl313_readable_reg_range),
 };
 EXPORT_SYMBOL_NS_GPL(adxl313_readable_regs_table, IIO_ADXL313);
 
+const struct regmap_access_table adxl314_readable_regs_table = {
+	.yes_ranges = adxl312_readable_reg_range,
+	.n_yes_ranges = ARRAY_SIZE(adxl312_readable_reg_range),
+};
+EXPORT_SYMBOL_NS_GPL(adxl314_readable_regs_table, IIO_ADXL313);
+
+static int adxl312_check_id(struct device *dev,
+			    struct adxl313_data *data)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(data->regmap, ADXL313_REG_DEVID0, &regval);
+	if (ret)
+		return ret;
+
+	if (regval != ADXL313_DEVID0_ADXL312_314)
+		dev_warn(dev, "Invalid manufacturer ID: %#02x\n", regval);
+
+	return 0;
+}
+
+static int adxl313_check_id(struct device *dev,
+			    struct adxl313_data *data)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(data->regmap, ADXL313_REG_DEVID0, &regval);
+	if (ret)
+		return ret;
+
+	if (regval != ADXL313_DEVID0)
+		dev_warn(dev, "Invalid manufacturer ID: 0x%02x\n", regval);
+
+	/* Check DEVID1 and PARTID */
+	if (regval == ADXL313_DEVID0) {
+		ret = regmap_read(data->regmap, ADXL313_REG_DEVID1, &regval);
+		if (ret)
+			return ret;
+
+		if (regval != ADXL313_DEVID1)
+			dev_warn(dev, "Invalid mems ID: 0x%02x\n", regval);
+
+		ret = regmap_read(data->regmap, ADXL313_REG_PARTID, &regval);
+		if (ret)
+			return ret;
+
+		if (regval != ADXL313_PARTID)
+			dev_warn(dev, "Invalid device ID: 0x%02x\n", regval);
+	}
+
+	return 0;
+}
+
+const struct adxl313_chip_info adxl31x_chip_info[] = {
+	[ADXL312] = {
+		.name = "adxl312",
+		.type = ADXL312,
+		.scale_factor = 28425072,
+		.variable_range = true,
+		.soft_reset = false,
+		.check_id = &adxl312_check_id,
+	},
+	[ADXL313] = {
+		.name = "adxl313",
+		.type = ADXL313,
+		.scale_factor = 9576806,
+		.variable_range = true,
+		.soft_reset = true,
+		.check_id = &adxl313_check_id,
+	},
+	[ADXL314] = {
+		.name = "adxl314",
+		.type = ADXL314,
+		.scale_factor = 478858719,
+		.variable_range = false,
+		.soft_reset = false,
+		.check_id = &adxl312_check_id,
+	}
+};
+EXPORT_SYMBOL_NS_GPL(adxl31x_chip_info, IIO_ADXL313);
+
+static const struct regmap_range adxl312_writable_reg_range[] = {
+	regmap_reg_range(ADXL313_REG_OFS_AXIS(0), ADXL313_REG_OFS_AXIS(2)),
+	regmap_reg_range(ADXL313_REG_THRESH_ACT, ADXL313_REG_ACT_INACT_CTL),
+	regmap_reg_range(ADXL313_REG_BW_RATE, ADXL313_REG_INT_MAP),
+	regmap_reg_range(ADXL313_REG_DATA_FORMAT, ADXL313_REG_DATA_FORMAT),
+	regmap_reg_range(ADXL313_REG_FIFO_CTL, ADXL313_REG_FIFO_CTL),
+};
+
 static const struct regmap_range adxl313_writable_reg_range[] = {
 	regmap_reg_range(ADXL313_REG_SOFT_RESET, ADXL313_REG_SOFT_RESET),
 	regmap_reg_range(ADXL313_REG_OFS_AXIS(0), ADXL313_REG_OFS_AXIS(2)),
@@ -37,17 +140,23 @@ static const struct regmap_range adxl313_writable_reg_range[] = {
 	regmap_reg_range(ADXL313_REG_FIFO_CTL, ADXL313_REG_FIFO_CTL),
 };
 
+const struct regmap_access_table adxl312_writable_regs_table = {
+	.yes_ranges = adxl312_writable_reg_range,
+	.n_yes_ranges = ARRAY_SIZE(adxl312_writable_reg_range),
+};
+EXPORT_SYMBOL_NS_GPL(adxl312_writable_regs_table, IIO_ADXL313);
+
 const struct regmap_access_table adxl313_writable_regs_table = {
 	.yes_ranges = adxl313_writable_reg_range,
 	.n_yes_ranges = ARRAY_SIZE(adxl313_writable_reg_range),
 };
 EXPORT_SYMBOL_NS_GPL(adxl313_writable_regs_table, IIO_ADXL313);
 
-struct adxl313_data {
-	struct regmap	*regmap;
-	struct mutex	lock; /* lock to protect transf_buf */
-	__le16		transf_buf __aligned(IIO_DMA_MINALIGN);
+const struct regmap_access_table adxl314_writable_regs_table = {
+	.yes_ranges = adxl312_writable_reg_range,
+	.n_yes_ranges = ARRAY_SIZE(adxl312_writable_reg_range),
 };
+EXPORT_SYMBOL_NS_GPL(adxl314_writable_regs_table, IIO_ADXL313);
 
 static const int adxl313_odr_freqs[][2] = {
 	[0] = { 6, 250000 },
@@ -156,12 +265,10 @@ static int adxl313_read_raw(struct iio_dev *indio_dev,
 		*val = sign_extend32(ret, chan->scan_type.realbits - 1);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		/*
-		 * Scale for any g range is given in datasheet as
-		 * 1024 LSB/g = 0.0009765625 * 9.80665 = 0.009576806640625 m/s^2
-		 */
 		*val = 0;
-		*val2 = 9576806;
+
+		*val2 = data->chip_info->scale_factor;
+
 		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_CHAN_INFO_CALIBBIAS:
 		ret = regmap_read(data->regmap,
@@ -170,7 +277,7 @@ static int adxl313_read_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		/*
-		 * 8-bit resolution at +/- 0.5g, that is 4x accel data scale
+		 * 8-bit resolution at minimum range, that is 4x accel data scale
 		 * factor at full resolution
 		 */
 		*val = sign_extend32(regval, 7) * 4;
@@ -198,7 +305,7 @@ static int adxl313_write_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBBIAS:
 		/*
-		 * 8-bit resolution at +/- 0.5g, that is 4x accel data scale
+		 * 8-bit resolution at minimum range, that is 4x accel data scale
 		 * factor at full resolution
 		 */
 		if (clamp_val(val, -128 * 4, 127 * 4) != val)
@@ -223,14 +330,18 @@ static const struct iio_info adxl313_info = {
 static int adxl313_setup(struct device *dev, struct adxl313_data *data,
 			 int (*setup)(struct device *, struct regmap *))
 {
-	unsigned int regval;
 	int ret;
 
-	/* Ensures the device is in a consistent state after start up */
-	ret = regmap_write(data->regmap, ADXL313_REG_SOFT_RESET,
-			   ADXL313_SOFT_RESET);
-	if (ret)
-		return ret;
+	/*
+	 * If sw reset available, ensures the device is in a consistent
+	 * state after start up
+	 */
+	if (data->chip_info->soft_reset) {
+		ret = regmap_write(data->regmap, ADXL313_REG_SOFT_RESET,
+				   ADXL313_SOFT_RESET);
+		if (ret)
+			return ret;
+	}
 
 	if (setup) {
 		ret = setup(dev, data->regmap);
@@ -238,46 +349,25 @@ static int adxl313_setup(struct device *dev, struct adxl313_data *data,
 			return ret;
 	}
 
-	ret = regmap_read(data->regmap, ADXL313_REG_DEVID0, &regval);
+	ret = data->chip_info->check_id(dev, data);
 	if (ret)
 		return ret;
 
-	if (regval != ADXL313_DEVID0) {
-		dev_err(dev, "Invalid manufacturer ID: 0x%02x\n", regval);
-		return -ENODEV;
-	}
-
-	ret = regmap_read(data->regmap, ADXL313_REG_DEVID1, &regval);
-	if (ret)
-		return ret;
-
-	if (regval != ADXL313_DEVID1) {
-		dev_err(dev, "Invalid mems ID: 0x%02x\n", regval);
-		return -ENODEV;
-	}
-
-	ret = regmap_read(data->regmap, ADXL313_REG_PARTID, &regval);
-	if (ret)
-		return ret;
+	/* Sets the range to maximum, full resolution, if applicable */
+	if (data->chip_info->variable_range) {
+		ret = regmap_update_bits(data->regmap, ADXL313_REG_DATA_FORMAT,
+					 ADXL313_RANGE_MSK,
+					 FIELD_PREP(ADXL313_RANGE_MSK, ADXL313_RANGE_MAX));
+		if (ret)
+			return ret;
 
-	if (regval != ADXL313_PARTID) {
-		dev_err(dev, "Invalid device ID: 0x%02x\n", regval);
-		return -ENODEV;
+		/* Enables full resolution */
+		ret = regmap_update_bits(data->regmap, ADXL313_REG_DATA_FORMAT,
+					 ADXL313_FULL_RES, ADXL313_FULL_RES);
+		if (ret)
+			return ret;
 	}
 
-	/* Sets the range to +/- 4g */
-	ret = regmap_update_bits(data->regmap, ADXL313_REG_DATA_FORMAT,
-				 ADXL313_RANGE_MSK,
-				 FIELD_PREP(ADXL313_RANGE_MSK, ADXL313_RANGE_4G));
-	if (ret)
-		return ret;
-
-	/* Enables full resolution */
-	ret = regmap_update_bits(data->regmap, ADXL313_REG_DATA_FORMAT,
-				 ADXL313_FULL_RES, ADXL313_FULL_RES);
-	if (ret)
-		return ret;
-
 	/* Enables measurement mode */
 	return regmap_update_bits(data->regmap, ADXL313_REG_POWER_CTL,
 				  ADXL313_POWER_CTL_MSK,
@@ -288,7 +378,7 @@ static int adxl313_setup(struct device *dev, struct adxl313_data *data,
  * adxl313_core_probe() - probe and setup for adxl313 accelerometer
  * @dev:	Driver model representation of the device
  * @regmap:	Register map of the device
- * @name:	Device name buffer reference
+ * @chip_info:	Structure containing device specific data
  * @setup:	Setup routine to be executed right before the standard device
  *		setup, can also be set to NULL if not required
  *
@@ -296,7 +386,7 @@ static int adxl313_setup(struct device *dev, struct adxl313_data *data,
  */
 int adxl313_core_probe(struct device *dev,
 		       struct regmap *regmap,
-		       const char *name,
+		       const struct adxl313_chip_info *chip_info,
 		       int (*setup)(struct device *, struct regmap *))
 {
 	struct adxl313_data *data;
@@ -309,9 +399,11 @@ int adxl313_core_probe(struct device *dev,
 
 	data = iio_priv(indio_dev);
 	data->regmap = regmap;
+	data->chip_info = chip_info;
+
 	mutex_init(&data->lock);
 
-	indio_dev->name = name;
+	indio_dev->name = chip_info->name;
 	indio_dev->info = &adxl313_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = adxl313_channels;
diff --git a/drivers/iio/accel/adxl313_i2c.c b/drivers/iio/accel/adxl313_i2c.c
index c329765dbf60..dd7113258824 100644
--- a/drivers/iio/accel/adxl313_i2c.c
+++ b/drivers/iio/accel/adxl313_i2c.c
@@ -14,42 +14,72 @@
 
 #include "adxl313.h"
 
-static const struct regmap_config adxl313_i2c_regmap_config = {
-	.reg_bits	= 8,
-	.val_bits	= 8,
-	.rd_table	= &adxl313_readable_regs_table,
-	.wr_table	= &adxl313_writable_regs_table,
-	.max_register	= 0x39,
-};
-
-static int adxl313_i2c_probe(struct i2c_client *client)
-{
-	struct regmap *regmap;
-
-	regmap = devm_regmap_init_i2c(client, &adxl313_i2c_regmap_config);
-	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Error initializing i2c regmap: %ld\n",
-			PTR_ERR(regmap));
-		return PTR_ERR(regmap);
+static const struct regmap_config adxl31x_i2c_regmap_config[] = {
+	[ADXL312] = {
+		.reg_bits	= 8,
+		.val_bits	= 8,
+		.rd_table	= &adxl312_readable_regs_table,
+		.wr_table	= &adxl312_writable_regs_table,
+		.max_register	= 0x39,
+	},
+	[ADXL313] = {
+		.reg_bits	= 8,
+		.val_bits	= 8,
+		.rd_table	= &adxl313_readable_regs_table,
+		.wr_table	= &adxl313_writable_regs_table,
+		.max_register	= 0x39,
+	},
+	[ADXL314] = {
+		.reg_bits	= 8,
+		.val_bits	= 8,
+		.rd_table	= &adxl314_readable_regs_table,
+		.wr_table	= &adxl314_writable_regs_table,
+		.max_register	= 0x39,
 	}
-
-	return adxl313_core_probe(&client->dev, regmap, client->name, NULL);
-}
+};
 
 static const struct i2c_device_id adxl313_i2c_id[] = {
-	{ "adxl313" },
+	{ .name = "adxl312", .driver_data = (kernel_ulong_t)&adxl31x_chip_info[ADXL312] },
+	{ .name = "adxl313", .driver_data = (kernel_ulong_t)&adxl31x_chip_info[ADXL312] },
+	{ .name = "adxl314", .driver_data = (kernel_ulong_t)&adxl31x_chip_info[ADXL312] },
 	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, adxl313_i2c_id);
 
 static const struct of_device_id adxl313_of_match[] = {
-	{ .compatible = "adi,adxl313" },
+	{ .compatible = "adi,adxl312", .data = &adxl31x_chip_info[ADXL312] },
+	{ .compatible = "adi,adxl313", .data = &adxl31x_chip_info[ADXL313] },
+	{ .compatible = "adi,adxl314", .data = &adxl31x_chip_info[ADXL314] },
 	{ }
 };
 
 MODULE_DEVICE_TABLE(of, adxl313_of_match);
 
+static int adxl313_i2c_probe(struct i2c_client *client)
+{
+	const struct adxl313_chip_info *chip_data;
+	struct regmap *regmap;
+
+	/*
+	 * Retrieves device specific data as a pointer to a
+	 * adxl313_chip_info structure
+	 */
+	chip_data = device_get_match_data(&client->dev);
+	if (!chip_data)
+		chip_data = (const struct adxl313_chip_info *)i2c_match_id(adxl313_i2c_id, client)->driver_data;
+
+	regmap = devm_regmap_init_i2c(client,
+				      &adxl31x_i2c_regmap_config[chip_data->type]);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "Error initializing i2c regmap: %ld\n",
+			PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	return adxl313_core_probe(&client->dev, regmap, chip_data, NULL);
+}
+
 static struct i2c_driver adxl313_i2c_driver = {
 	.driver = {
 		.name	= "adxl313_i2c",
diff --git a/drivers/iio/accel/adxl313_spi.c b/drivers/iio/accel/adxl313_spi.c
index a3c6d553462d..86328dfdce73 100644
--- a/drivers/iio/accel/adxl313_spi.c
+++ b/drivers/iio/accel/adxl313_spi.c
@@ -11,17 +11,38 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
+#include <linux/property.h>
 
 #include "adxl313.h"
 
-static const struct regmap_config adxl313_spi_regmap_config = {
-	.reg_bits	= 8,
-	.val_bits	= 8,
-	.rd_table	= &adxl313_readable_regs_table,
-	.wr_table	= &adxl313_writable_regs_table,
-	.max_register	= 0x39,
-	 /* Setting bits 7 and 6 enables multiple-byte read */
-	.read_flag_mask	= BIT(7) | BIT(6),
+static const struct regmap_config adxl31x_spi_regmap_config[] = {
+	[ADXL312] = {
+		.reg_bits	= 8,
+		.val_bits	= 8,
+		.rd_table	= &adxl312_readable_regs_table,
+		.wr_table	= &adxl312_writable_regs_table,
+		.max_register	= 0x39,
+		/* Setting bits 7 and 6 enables multiple-byte read */
+		.read_flag_mask	= BIT(7) | BIT(6),
+	},
+	[ADXL313] = {
+		.reg_bits	= 8,
+		.val_bits	= 8,
+		.rd_table	= &adxl313_readable_regs_table,
+		.wr_table	= &adxl313_writable_regs_table,
+		.max_register	= 0x39,
+		/* Setting bits 7 and 6 enables multiple-byte read */
+		.read_flag_mask	= BIT(7) | BIT(6),
+	},
+	[ADXL314] = {
+		.reg_bits	= 8,
+		.val_bits	= 8,
+		.rd_table	= &adxl314_readable_regs_table,
+		.wr_table	= &adxl314_writable_regs_table,
+		.max_register	= 0x39,
+		/* Setting bits 7 and 6 enables multiple-byte read */
+		.read_flag_mask	= BIT(7) | BIT(6),
+	}
 };
 
 static int adxl313_spi_setup(struct device *dev, struct regmap *regmap)
@@ -42,7 +63,7 @@ static int adxl313_spi_setup(struct device *dev, struct regmap *regmap)
 
 static int adxl313_spi_probe(struct spi_device *spi)
 {
-	const struct spi_device_id *id = spi_get_device_id(spi);
+	const struct adxl313_chip_info *chip_data;
 	struct regmap *regmap;
 	int ret;
 
@@ -51,26 +72,40 @@ static int adxl313_spi_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	regmap = devm_regmap_init_spi(spi, &adxl313_spi_regmap_config);
+	/*
+	 * Retrieves device specific data as a pointer to a
+	 * adxl313_chip_info structure
+	 */
+	chip_data = device_get_match_data(&spi->dev);
+	if (!chip_data)
+		chip_data = (const struct adxl313_chip_info *)spi_get_device_id(spi)->driver_data;
+
+	regmap = devm_regmap_init_spi(spi,
+				      &adxl31x_spi_regmap_config[chip_data->type]);
+
 	if (IS_ERR(regmap)) {
 		dev_err(&spi->dev, "Error initializing spi regmap: %ld\n",
 			PTR_ERR(regmap));
 		return PTR_ERR(regmap);
 	}
 
-	return adxl313_core_probe(&spi->dev, regmap, id->name,
-				  &adxl313_spi_setup);
+	return adxl313_core_probe(&spi->dev, regmap,
+				  chip_data, &adxl313_spi_setup);
 }
 
 static const struct spi_device_id adxl313_spi_id[] = {
-	{ "adxl313" },
+	{ .name = "adxl312", .driver_data = (kernel_ulong_t)&adxl31x_chip_info[ADXL312] },
+	{ .name = "adxl313", .driver_data = (kernel_ulong_t)&adxl31x_chip_info[ADXL313] },
+	{ .name = "adxl314", .driver_data = (kernel_ulong_t)&adxl31x_chip_info[ADXL314] },
 	{ }
 };
 
 MODULE_DEVICE_TABLE(spi, adxl313_spi_id);
 
 static const struct of_device_id adxl313_of_match[] = {
-	{ .compatible = "adi,adxl313" },
+	{ .compatible = "adi,adxl312", .data = &adxl31x_chip_info[ADXL312] },
+	{ .compatible = "adi,adxl313", .data = &adxl31x_chip_info[ADXL313] },
+	{ .compatible = "adi,adxl314", .data = &adxl31x_chip_info[ADXL314] },
 	{ }
 };
 
-- 
2.30.2

