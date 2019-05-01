Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A76A310E6E
	for <lists+linux-iio@lfdr.de>; Wed,  1 May 2019 23:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfEAVRl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 May 2019 17:17:41 -0400
Received: from da1vs04.rockwellcollins.com ([205.175.227.52]:13920 "EHLO
        da1vs04.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726088AbfEAVRk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 May 2019 17:17:40 -0400
Received: from ofwda1n02.rockwellcollins.com (HELO crulimr01.rockwellcollins.com) ([205.175.227.14])
  by da1vs04.rockwellcollins.com with ESMTP; 01 May 2019 16:17:39 -0500
X-Received: from righttwix.rockwellcollins.com (righttwix.rockwellcollins.com [192.168.141.218])
        by crulimr01.rockwellcollins.com (Postfix) with ESMTP id 93D75600D0;
        Wed,  1 May 2019 16:17:39 -0500 (CDT)
From:   Adam Michaelis <adam.michaelis@rockwellcollins.com>
To:     linux-iio@vger.kernel.org
Cc:     lars@metafoo.de, michael.hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, charles-antoine.couret@essensium.com,
        devicetree@vger.kernel.org, brandon.maier@rockwellcollins.com,
        clayton.shotwell@rockwellcollins.com,
        Adam Michaelis <adam.michaelis@rockwellcollins.com>
Subject: [PATCH 1/6] iio: ad7949: Support internal Vref
Date:   Wed,  1 May 2019 16:16:58 -0500
Message-Id: <1556745423-11368-1-git-send-email-adam.michaelis@rockwellcollins.com>
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
 drivers/iio/adc/ad7949.c | 84 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 66 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index ac0ffff6c5ae..1c49eed298d8 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
+#include <linux/of.h>
 
 #define AD7949_MASK_CHANNEL_SEL		GENMASK(9, 7)
 #define AD7949_MASK_TOTAL		GENMASK(13, 0)
@@ -24,6 +25,18 @@ enum {
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
@@ -41,6 +54,7 @@ struct ad7949_adc_spec {
  * @vref: regulator generating Vref
  * @iio_dev: reference to iio structure
  * @spi: reference to spi structure
+ * @ref_sel: selected reference voltage source
  * @resolution: resolution of the chip
  * @cfg: copy of the configuration register
  * @current_channel: current channel in use
@@ -51,6 +65,7 @@ struct ad7949_adc_chip {
 	struct regulator *vref;
 	struct iio_dev *indio_dev;
 	struct spi_device *spi;
+	enum ad7949_ref_sel ref_sel;
 	u8 resolution;
 	u16 cfg;
 	unsigned int current_channel;
@@ -187,11 +202,20 @@ static int ad7949_spi_read_raw(struct iio_dev *indio_dev,
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
 
@@ -223,10 +247,18 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
 {
 	int ret;
 	int val;
+	u16 adc_config = 0;
 
-	/* Sequencer disabled, CFG readback disabled, IN0 as default channel */
 	ad7949_adc->current_channel = 0;
-	ret = ad7949_spi_write_cfg(ad7949_adc, 0x3C79, AD7949_MASK_TOTAL);
+	ad7949_adc->cfg = 0;
+
+	adc_config = (0x3c << 8);
+	adc_config |= ((ad7949_adc->current_channel & 0x07) << 7);
+	adc_config |= (1 << 6);
+	adc_config |= (ad7949_adc->ref_sel << 3);
+	adc_config |= 1;
+
+	ret = ad7949_spi_write_cfg(ad7949_adc, adc_config, AD7949_MASK_TOTAL);
 
 	/*
 	 * Do two dummy conversions to apply the first configuration setting.
@@ -245,6 +277,7 @@ static int ad7949_spi_probe(struct spi_device *spi)
 	struct ad7949_adc_chip *ad7949_adc;
 	struct iio_dev *indio_dev;
 	int ret;
+	u32 temp;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*ad7949_adc));
 	if (!indio_dev) {
@@ -263,21 +296,34 @@ static int ad7949_spi_probe(struct spi_device *spi)
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
-	}
-
-	ret = regulator_enable(ad7949_adc->vref);
-	if (ret < 0) {
-		dev_err(dev, "fail to enable regulator\n");
-		return ret;
+	ret = of_property_read_u32(ad7949_adc->indio_dev->dev.of_node,
+			"adi,reference-select",
+			&temp);
+	if ((ret == 0) && (temp < AD7949_REF_MAX))
+		ad7949_adc->ref_sel = (enum ad7949_ref_sel)temp;
+	else
+		ad7949_adc->ref_sel = AD7949_REF_EXT_BUF;
+
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
@@ -298,7 +344,8 @@ static int ad7949_spi_probe(struct spi_device *spi)
 
 err:
 	mutex_destroy(&ad7949_adc->lock);
-	regulator_disable(ad7949_adc->vref);
+	if (ad7949_adc->vref)
+		regulator_disable(ad7949_adc->vref);
 
 	return ret;
 }
@@ -310,7 +357,8 @@ static int ad7949_spi_remove(struct spi_device *spi)
 
 	iio_device_unregister(indio_dev);
 	mutex_destroy(&ad7949_adc->lock);
-	regulator_disable(ad7949_adc->vref);
+	if (ad7949_adc->vref)
+		regulator_disable(ad7949_adc->vref);
 
 	return 0;
 }
-- 
1.9.1

