Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5079711FE7
	for <lists+linux-iio@lfdr.de>; Thu,  2 May 2019 18:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfEBQOs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 May 2019 12:14:48 -0400
Received: from secvs01.rockwellcollins.com ([205.175.225.240]:27143 "EHLO
        secvs01.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726278AbfEBQOp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 May 2019 12:14:45 -0400
Received: from ofwgwc03.rockwellcollins.com (HELO ciulimr02.rockwellcollins.com) ([205.175.225.12])
  by secvs01.rockwellcollins.com with ESMTP; 02 May 2019 11:14:42 -0500
X-Received: from righttwix.rockwellcollins.com (righttwix.rockwellcollins.com [192.168.141.218])
        by ciulimr02.rockwellcollins.com (Postfix) with ESMTP id 96C072007E;
        Thu,  2 May 2019 11:14:42 -0500 (CDT)
From:   Adam Michaelis <adam.michaelis@rockwellcollins.com>
To:     linux-iio@vger.kernel.org
Cc:     lars@metafoo.de, michael.hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, charles-antoine.couret@essensium.com,
        devicetree@vger.kernel.org, brandon.maier@rockwellcollins.com,
        clayton.shotwell@rockwellcollins.com,
        Adam Michaelis <adam.michaelis@rockwellcollins.com>
Subject: [PATCH v2 1/6] iio: ad7949: Support internal Vref
Date:   Thu,  2 May 2019 11:14:27 -0500
Message-Id: <1556813672-49861-1-git-send-email-adam.michaelis@rockwellcollins.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Adding configurable (via device tree) options to select either an external
reference voltage (default, original implementation) or one of the two
internal reference voltages provided by the AD7949 part family.

Signed-off-by: Adam Michaelis <adam.michaelis@rockwellcollins.com>
---
	V2: Add some defines to reduce use of magic numbers.
---
 drivers/iio/adc/ad7949.c | 135 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 108 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index ac0ffff6c5ae..afc1361af5fb 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -11,12 +11,27 @@
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
+
+#define AD7949_CFG_REG_SIZE_BITS           14
+#define AD7949_CFG_MASK_TOTAL              GENMASK(13, 0)
+#define AD7949_CFG_OVERWRITE_SHIFT         13
+#define AD7949_CFG_CHAN_CFG_UNIPOLAR_GND   0x7
+#define AD7949_CFG_CHAN_CFG_MASK           GENMASK(12, 10)
+#define AD7949_CFG_CHAN_CFG_SHIFT          10
+#define AD7949_CFG_CHAN_SEL_MASK           GENMASK(9, 7)
+#define AD7949_CFG_CHAN_SEL_SHIFT          7
+#define AD7949_CFG_BW_FULL                 1
+#define AD7949_CFG_BW_SHIFT                6
+#define AD7949_CFG_BW_MASK                 GENMASK(6, 6)
+#define AD7949_CFG_REF_SEL_MASK            GENMASK(5, 3)
+#define AD7949_CFG_REF_SEL_SHIFT           3
+#define AD7949_CFG_SEQ_DISABLED            0x0
+#define AD7949_CFG_SEQ_SHIFT               1
+#define AD7949_CFG_SEQ_MASK                GENMASK(2, 1)
+#define AD7949_CFG_READBACK_EN             0
+#define AD7949_CFG_READBACK_DIS            1
+#define AD7949_CFG_READBACK_MASK           GENMASK(0, 0)
 
 enum {
 	ID_AD7949 = 0,
@@ -24,6 +39,18 @@ enum {
 	ID_AD7689,
 };
 
+enum ad7949_ref_sel {
+	AD7949_REF_2V5 = 0, /* 2.5V internal ref + temp sensor */
+	AD7949_REF_4V0, /* 4.096V internal ref + temp sensor */
+	AD7949_REF_EXT_TEMP, /* External ref + temp sensor, no buffer */
+	AD7949_REF_EXT_TEMP_BUF, /* External ref + temp sensor + buffer */
+	AD7949_REF_RSRV_4,
+	AD7949_REF_RSRV_5,
+	AD7949_REF_EXT, /* External ref, no temp, no buffer */
+	AD7949_REF_EXT_BUF, /* External ref + buffer, no temp */
+	AD7949_REF_MAX,
+};
+
 struct ad7949_adc_spec {
 	u8 num_channels;
 	u8 resolution;
@@ -41,6 +68,7 @@ struct ad7949_adc_spec {
  * @vref: regulator generating Vref
  * @iio_dev: reference to iio structure
  * @spi: reference to spi structure
+ * @ref_sel: selected reference voltage source
  * @resolution: resolution of the chip
  * @cfg: copy of the configuration register
  * @current_channel: current channel in use
@@ -51,6 +79,7 @@ struct ad7949_adc_chip {
 	struct regulator *vref;
 	struct iio_dev *indio_dev;
 	struct spi_device *spi;
+	enum ad7949_ref_sel ref_sel;
 	u8 resolution;
 	u16 cfg;
 	unsigned int current_channel;
@@ -59,7 +88,7 @@ struct ad7949_adc_chip {
 
 static bool ad7949_spi_cfg_is_read_back(struct ad7949_adc_chip *ad7949_adc)
 {
-	if (!(ad7949_adc->cfg & AD7949_CFG_READ_BACK))
+	if (!(ad7949_adc->cfg & AD7949_CFG_READBACK_MASK))
 		return true;
 
 	return false;
@@ -91,7 +120,7 @@ static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
 	};
 
 	ad7949_adc->cfg = (val & mask) | (ad7949_adc->cfg & ~mask);
-	ad7949_adc->buffer = ad7949_adc->cfg << shift;
+	ad7949_adc->buffer = (ad7949_adc->cfg & AD7949_CFG_MASK_TOTAL) << shift;
 	spi_message_init_with_transfers(&msg, tx, 1);
 	ret = spi_sync(ad7949_adc->spi, &msg);
 
@@ -119,8 +148,8 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
 	};
 
 	ret = ad7949_spi_write_cfg(ad7949_adc,
-				   channel << AD7949_OFFSET_CHANNEL_SEL,
-				   AD7949_MASK_CHANNEL_SEL);
+				   channel << AD7949_CFG_CHAN_SEL_SHIFT,
+				   AD7949_CFG_CHAN_SEL_MASK);
 	if (ret)
 		return ret;
 
@@ -187,11 +216,20 @@ static int ad7949_spi_read_raw(struct iio_dev *indio_dev,
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
 
@@ -209,7 +247,7 @@ static int ad7949_spi_reg_access(struct iio_dev *indio_dev,
 		*readval = ad7949_adc->cfg;
 	else
 		ret = ad7949_spi_write_cfg(ad7949_adc,
-			writeval & AD7949_MASK_TOTAL, AD7949_MASK_TOTAL);
+			writeval & AD7949_CFG_MASK_TOTAL, AD7949_CFG_MASK_TOTAL);
 
 	return ret;
 }
@@ -223,10 +261,33 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
 {
 	int ret;
 	int val;
+	u16 adc_config = 0;
 
-	/* Sequencer disabled, CFG readback disabled, IN0 as default channel */
 	ad7949_adc->current_channel = 0;
-	ret = ad7949_spi_write_cfg(ad7949_adc, 0x3C79, AD7949_MASK_TOTAL);
+	ad7949_adc->cfg = 0;
+
+	/*
+	 * 14-bit configuration register (pg 12 of AD7949 Datasheet):
+	 * | 13  | 12 - 10 | 9 - 7 | 6  | 5 -3 | 2 - 1 | 0  |
+	 * | CFG | INCC    | INx   | BW | REF  | SEQ   | RB |
+	 */
+	adc_config = 1 << AD7949_CFG_OVERWRITE_SHIFT;
+	adc_config |=
+		(AD7949_CFG_CHAN_CFG_UNIPOLAR_GND << AD7949_CFG_CHAN_CFG_SHIFT)
+			& AD7949_CFG_CHAN_CFG_MASK;
+	adc_config |= (ad7949_adc->current_channel << AD7949_CFG_CHAN_SEL_SHIFT)
+			& AD7949_CFG_CHAN_SEL_MASK;
+	adc_config |= (AD7949_CFG_BW_FULL << AD7949_CFG_BW_SHIFT) &
+			AD7949_CFG_BW_MASK;
+	adc_config |= (ad7949_adc->ref_sel << AD7949_CFG_REF_SEL_SHIFT) &
+			AD7949_CFG_REF_SEL_MASK;
+	adc_config |= (AD7949_CFG_SEQ_DISABLED << AD7949_CFG_SEQ_SHIFT) &
+			AD7949_CFG_SEQ_MASK;
+	adc_config |= AD7949_CFG_READBACK_DIS;
+
+	ret = ad7949_spi_write_cfg(ad7949_adc,
+			adc_config,
+			AD7949_CFG_MASK_TOTAL);
 
 	/*
 	 * Do two dummy conversions to apply the first configuration setting.
@@ -245,6 +306,7 @@ static int ad7949_spi_probe(struct spi_device *spi)
 	struct ad7949_adc_chip *ad7949_adc;
 	struct iio_dev *indio_dev;
 	int ret;
+	u32 temp;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*ad7949_adc));
 	if (!indio_dev) {
@@ -263,21 +325,38 @@ static int ad7949_spi_probe(struct spi_device *spi)
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
+	if ((ret == 0) && (temp < AD7949_REF_MAX) &&
+			(temp != AD7949_REF_RSRV_4) &&
+			(temp != AD7949_REF_RSRV_5)) {
+		ad7949_adc->ref_sel = (enum ad7949_ref_sel)temp;
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
@@ -298,7 +377,8 @@ static int ad7949_spi_probe(struct spi_device *spi)
 
 err:
 	mutex_destroy(&ad7949_adc->lock);
-	regulator_disable(ad7949_adc->vref);
+	if (ad7949_adc->vref)
+		regulator_disable(ad7949_adc->vref);
 
 	return ret;
 }
@@ -310,7 +390,8 @@ static int ad7949_spi_remove(struct spi_device *spi)
 
 	iio_device_unregister(indio_dev);
 	mutex_destroy(&ad7949_adc->lock);
-	regulator_disable(ad7949_adc->vref);
+	if (ad7949_adc->vref)
+		regulator_disable(ad7949_adc->vref);
 
 	return 0;
 }
-- 
1.9.1

