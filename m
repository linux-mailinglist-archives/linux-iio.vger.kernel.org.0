Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA0A1B92B
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2019 16:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730961AbfEMOxx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 May 2019 10:53:53 -0400
Received: from da1vs02.rockwellcollins.com ([205.175.227.29]:9882 "EHLO
        da1vs02.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730954AbfEMOxx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 May 2019 10:53:53 -0400
Received: from ofwda1n02.rockwellcollins.com (HELO ciulimr01.rockwellcollins.com) ([205.175.227.14])
  by da1vs02.rockwellcollins.com with ESMTP; 13 May 2019 09:53:51 -0500
X-Received: from righttwix.rockwellcollins.com (righttwix.rockwellcollins.com [192.168.141.218])
        by ciulimr01.rockwellcollins.com (Postfix) with ESMTP id 3B09460112;
        Mon, 13 May 2019 09:53:51 -0500 (CDT)
From:   Adam Michaelis <adam.michaelis@rockwellcollins.com>
To:     linux-iio@vger.kernel.org
Cc:     lars@metafoo.de, michael.hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, charles-antoine.couret@essensium.com,
        devicetree@vger.kernel.org, brandon.maier@rockwellcollins.com,
        clayton.shotwell@rockwellcollins.com,
        Adam Michaelis <adam.michaelis@rockwellcollins.com>
Subject: [PATCH v3 2/5] iio: ad7949: Support internal Vref
Date:   Mon, 13 May 2019 09:53:02 -0500
Message-Id: <1557759185-167857-2-git-send-email-adam.michaelis@rockwellcollins.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1557759185-167857-1-git-send-email-adam.michaelis@rockwellcollins.com>
References: <1557759185-167857-1-git-send-email-adam.michaelis@rockwellcollins.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Adding configurable (via device tree) options to select one of the two
external reference voltages (REFIN as default, original implementation)
or one of the two internal reference voltages provided by the AD7949
part family.

Signed-off-by: Adam Michaelis <adam.michaelis@rockwellcollins.com>
---
	V2:
	- Add some defines to reduce use of magic numbers.
	V3:
	- Add bitfield.h macros throughout.
	- Re-think usage of device tree parameter to focus on the
	actual reference sources instead of the raw hardware
	configuration.
---
 drivers/iio/adc/ad7949.c | 138 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 111 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index c7fe27aa2519..b648b1ab9559 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -11,12 +11,23 @@
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
-
-#define AD7949_MASK_CHANNEL_SEL		GENMASK(9, 7)
-#define AD7949_MASK_TOTAL		GENMASK(13, 0)
-#define AD7949_OFFSET_CHANNEL_SEL	7
-#define AD7949_CFG_READ_BACK		0x1
-#define AD7949_CFG_REG_SIZE_BITS	14
+#include <linux/of.h>
+#include <linux/bitfield.h>
+
+#define AD7949_CFG_REG_SIZE_BITS           14
+#define AD7949_CFG_MASK_TOTAL              GENMASK(13, 0)
+#define AD7949_CFG_APPLY                   BIT(13)
+#define AD7949_CFG_CHAN_CFG                GENMASK(12, 10)
+#define AD7949_CFG_CHAN_CFG_UNIPOLAR_GND   0x7
+#define AD7949_CFG_CHAN_SEL                GENMASK(9, 7)
+#define AD7949_CFG_BW                      BIT(6)
+#define AD7949_CFG_BW_FULL                 1
+#define AD7949_CFG_REF_SEL                 GENMASK(5, 3)
+#define AD7949_CFG_SEQ                     GENMASK(2, 1)
+#define AD7949_CFG_SEQ_DISABLED            0x0
+#define AD7949_CFG_READBACK                BIT(0)
+#define AD7949_CFG_READBACK_EN             0
+#define AD7949_CFG_READBACK_DIS            1
 
 enum {
 	ID_AD7949 = 0,
@@ -24,6 +35,18 @@ enum {
 	ID_AD7689,
 };
 
+enum ad7949_ref_sel {
+	AD7949_REF_2V5 = 0, /* 2.5V internal ref + temp sensor */
+	AD7949_REF_4V0, /* 4.096V internal ref + temp sensor */
+	AD7949_REF_EXT_TEMP, /* REF + temp sensor */
+	AD7949_REF_EXT_TEMP_BUF, /* REFIN + temp sensor */
+	AD7949_REF_RSRV_4,
+	AD7949_REF_RSRV_5,
+	AD7949_REF_EXT, /* REF, no temp */
+	AD7949_REF_EXT_BUF, /* REFIN, no temp */
+	AD7949_REF_MAX,
+};
+
 struct ad7949_adc_spec {
 	u8 num_channels;
 	u8 resolution;
@@ -41,6 +64,7 @@ struct ad7949_adc_spec {
  * @vref: regulator generating Vref
  * @iio_dev: reference to iio structure
  * @spi: reference to spi structure
+ * @ref_sel: selected reference voltage source
  * @resolution: resolution of the chip
  * @cfg: copy of the configuration register
  * @current_channel: current channel in use
@@ -51,6 +75,7 @@ struct ad7949_adc_chip {
 	struct regulator *vref;
 	struct iio_dev *indio_dev;
 	struct spi_device *spi;
+	enum ad7949_ref_sel ref_sel;
 	u8 resolution;
 	u16 cfg;
 	unsigned int current_channel;
@@ -59,7 +84,7 @@ struct ad7949_adc_chip {
 
 static bool ad7949_spi_cfg_is_read_back(struct ad7949_adc_chip *ad7949_adc)
 {
-	if (!(ad7949_adc->cfg & AD7949_CFG_READ_BACK))
+	if (!(ad7949_adc->cfg & AD7949_CFG_READBACK))
 		return true;
 
 	return false;
@@ -91,7 +116,7 @@ static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
 	};
 
 	ad7949_adc->cfg = (val & mask) | (ad7949_adc->cfg & ~mask);
-	ad7949_adc->buffer = ad7949_adc->cfg << shift;
+	ad7949_adc->buffer = (ad7949_adc->cfg & AD7949_CFG_MASK_TOTAL) << shift;
 	spi_message_init_with_transfers(&msg, tx, 1);
 	ret = spi_sync(ad7949_adc->spi, &msg);
 
@@ -136,8 +161,8 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
 	};
 
 	ret = ad7949_spi_write_cfg(ad7949_adc,
-				   channel << AD7949_OFFSET_CHANNEL_SEL,
-				   AD7949_MASK_CHANNEL_SEL);
+				   FIELD_PREP(AD7949_CFG_CHAN_SEL, channel),
+				   AD7949_CFG_CHAN_SEL);
 	if (ret)
 		return ret;
 
@@ -204,11 +229,20 @@ static int ad7949_spi_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
-		ret = regulator_get_voltage(ad7949_adc->vref);
-		if (ret < 0)
-			return ret;
+		if (ad7949_adc->vref) {
+			ret = regulator_get_voltage(ad7949_adc->vref);
+			if (ret < 0)
+				return ret;
+
+			*val = ret / 5000;
+		} else if (ad7949_adc->ref_sel == AD7949_REF_2V5) {
+			*val = 2500;
+		} else if (ad7949_adc->ref_sel == AD7949_REF_4V0) {
+			*val = 4096;
+		} else {
+			return -EINVAL;
+		}
 
-		*val = ret / 5000;
 		return IIO_VAL_INT;
 	}
 
@@ -226,7 +260,8 @@ static int ad7949_spi_reg_access(struct iio_dev *indio_dev,
 		*readval = ad7949_adc->cfg;
 	else
 		ret = ad7949_spi_write_cfg(ad7949_adc,
-			writeval & AD7949_MASK_TOTAL, AD7949_MASK_TOTAL);
+			writeval & AD7949_CFG_MASK_TOTAL,
+			AD7949_CFG_MASK_TOTAL);
 
 	return ret;
 }
@@ -240,10 +275,24 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
 {
 	int ret;
 	int val;
+	u16 adc_config = 0;
 
-	/* Sequencer disabled, CFG readback disabled, IN0 as default channel */
 	ad7949_adc->current_channel = 0;
-	ret = ad7949_spi_write_cfg(ad7949_adc, 0x3C79, AD7949_MASK_TOTAL);
+	ad7949_adc->cfg = 0;
+
+	adc_config |= FIELD_PREP(AD7949_CFG_APPLY, 1);
+	adc_config |= FIELD_PREP(AD7949_CFG_CHAN_CFG,
+			AD7949_CFG_CHAN_CFG_UNIPOLAR_GND);
+	adc_config |= FIELD_PREP(AD7949_CFG_CHAN_SEL,
+			ad7949_adc->current_channel);
+	adc_config |= FIELD_PREP(AD7949_CFG_BW, AD7949_CFG_BW_FULL);
+	adc_config |= FIELD_PREP(AD7949_CFG_REF_SEL, ad7949_adc->ref_sel);
+	adc_config |= FIELD_PREP(AD7949_CFG_SEQ, AD7949_CFG_SEQ_DISABLED);
+	adc_config |= FIELD_PREP(AD7949_CFG_READBACK, AD7949_CFG_READBACK_DIS);
+
+	ret = ad7949_spi_write_cfg(ad7949_adc,
+			adc_config,
+			AD7949_CFG_MASK_TOTAL);
 
 	/*
 	 * Do a dummy conversion to apply the first configuration setting.
@@ -261,6 +310,7 @@ static int ad7949_spi_probe(struct spi_device *spi)
 	struct ad7949_adc_chip *ad7949_adc;
 	struct iio_dev *indio_dev;
 	int ret;
+	u32 temp;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*ad7949_adc));
 	if (!indio_dev) {
@@ -279,21 +329,53 @@ static int ad7949_spi_probe(struct spi_device *spi)
 	ad7949_adc = iio_priv(indio_dev);
 	ad7949_adc->indio_dev = indio_dev;
 	ad7949_adc->spi = spi;
+	ad7949_adc->vref = NULL;
 
 	spec = &ad7949_adc_spec[spi_get_device_id(spi)->driver_data];
 	indio_dev->num_channels = spec->num_channels;
 	ad7949_adc->resolution = spec->resolution;
 
-	ad7949_adc->vref = devm_regulator_get(dev, "vref");
-	if (IS_ERR(ad7949_adc->vref)) {
-		dev_err(dev, "fail to request regulator\n");
-		return PTR_ERR(ad7949_adc->vref);
+	ret = of_property_read_u32(ad7949_adc->indio_dev->dev.of_node,
+			"adi,reference-select",
+			&temp);
+	if (ret == 0) {
+		switch (temp) {
+		case 0:
+			ad7949_adc->ref_sel = AD7949_REF_2V5;
+			break;
+		case 1:
+			ad7949_adc->ref_sel = AD7949_REF_4V0;
+			break;
+		case 2:
+			ad7949_adc->ref_sel = AD7949_REF_EXT;
+			break;
+		case 3:
+			ad7949_adc->ref_sel = AD7949_REF_EXT_BUF;
+			break;
+		default:
+			ad7949_adc->ref_sel = AD7949_REF_EXT_BUF;
+			dev_warn(dev,
+				"unknown reference-select value, using REFIN external Vref (3) by default\n");
+		}
+	} else {
+		ad7949_adc->ref_sel = AD7949_REF_EXT_BUF;
+		dev_warn(dev, "using external Vref by default\n");
 	}
 
-	ret = regulator_enable(ad7949_adc->vref);
-	if (ret < 0) {
-		dev_err(dev, "fail to enable regulator\n");
-		return ret;
+	/* Check whether using external Vref */
+	if ((ad7949_adc->ref_sel != AD7949_REF_2V5) &&
+			(ad7949_adc->ref_sel != AD7949_REF_4V0)) {
+		ad7949_adc->vref = devm_regulator_get(dev, "vref");
+		if (IS_ERR(ad7949_adc->vref)) {
+			dev_err(dev, "fail to request regulator\n");
+			return PTR_ERR(ad7949_adc->vref);
+		}
+
+		ret = regulator_enable(ad7949_adc->vref);
+		if (ret < 0) {
+			dev_err(dev, "fail to enable regulator\n");
+			return ret;
+		}
 	}
 
 	mutex_init(&ad7949_adc->lock);
@@ -314,7 +396,8 @@ static int ad7949_spi_probe(struct spi_device *spi)
 
 err:
 	mutex_destroy(&ad7949_adc->lock);
-	regulator_disable(ad7949_adc->vref);
+	if (ad7949_adc->vref)
+		regulator_disable(ad7949_adc->vref);
 
 	return ret;
 }
@@ -326,7 +409,8 @@ static int ad7949_spi_remove(struct spi_device *spi)
 
 	iio_device_unregister(indio_dev);
 	mutex_destroy(&ad7949_adc->lock);
-	regulator_disable(ad7949_adc->vref);
+	if (ad7949_adc->vref)
+		regulator_disable(ad7949_adc->vref);
 
 	return 0;
 }
-- 
1.9.1

