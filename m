Return-Path: <linux-iio+bounces-13416-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2345C9F0821
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 10:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26412828B2
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 09:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917291B4152;
	Fri, 13 Dec 2024 09:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="nMeTWqOp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0411B3931;
	Fri, 13 Dec 2024 09:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734082791; cv=none; b=D1m+phfRG67c0h6jgJDHuBSh24k4XBVMlOXmfHTt2MoXRq5DdVxhq+LOI311GUL798r4r2kjBJPje0xTOwodxdUongAsuD42m1VQ+dimTB4RfecwM7igaQBfRY8uBMqspuNtt/rtP9jaCIUcF4Oerf79BlRk6+u9fOadciPaLTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734082791; c=relaxed/simple;
	bh=D7CoA5NbnKw5h5/7xVv5G68wNJMZtsWMWQd4OJ6fJ0M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rW6B0ZvmS0vbzmTf8HendcUIYjeFxRPnIrlGi9RWmnPtzLZNrJdUQM5EpmrPi7pvK2pJLhNtftKhpaKObSGaFOn4MBtBn7iEzymdc0RBPtpzYVtYZsn4Vw2DB1SBFMQMVDXP6oPS7CakardvU481Eed4AsNUAlKxx9XBbZcQisg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=nMeTWqOp; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD60VLS015599;
	Fri, 13 Dec 2024 04:39:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=4cwK3
	SGuYE0WSiU37pV36djFpubOXUObR4W2sHysMRk=; b=nMeTWqOpn2khbRoTUMB3T
	PvnIfQWN/Vvwmj8PsmS1bMXlSzU+OvIdEHu1yN3ZvL54gmyUsmuF0VfJKbshuSNv
	pn8LDRlNtoqHFXZNRTgFWIkyQuyxx3i6xpjis3L+XPgyMTlkuFLaP7M2E0WRRNan
	4+4Q1/fBb1wFMOtrR2nQRv9r2ZhTS5c7fq28k3fSe7ICGl2n3abaDL93AaDM3nlW
	S28hV8cBLv/I7ZasePqC9G2tF5ANk06iT+PtsBcsY+i7EuMST94iHgT+b0aKf4pz
	G2EfgFqpiWgmEru+dmldePLHfoXjd16GCTiaqFqOJc24vgnXIeMJR0edhAhQW0IZ
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 43fbve2d0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 04:39:34 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4BD9dXHB061750
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Dec 2024 04:39:33 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 13 Dec 2024 04:39:33 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 13 Dec 2024 04:39:33 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 13 Dec 2024 04:39:33 -0500
Received: from localhost.localdomain ([10.48.65.12])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4BD9dLXZ028481;
	Fri, 13 Dec 2024 04:39:29 -0500
From: Darius Berghe <darius.berghe@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <corbet@lwn.net>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <darius.berghe@analog.com>
Subject: [PATCH v1 1/2] iio: accel: adxl367: add support for adxl366
Date: Fri, 13 Dec 2024 11:52:00 +0200
Message-ID: <20241213095201.1218145-2-darius.berghe@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241213095201.1218145-1-darius.berghe@analog.com>
References: <20241213095201.1218145-1-darius.berghe@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: D-yAQOR-yoLK5gmuY5iCJUOhQ_g2Wl29
X-Proofpoint-GUID: D-yAQOR-yoLK5gmuY5iCJUOhQ_g2Wl29
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 spamscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130064

Add support for adxl366 Micropower, 3-Axis, +-/2g, +/-4g, +/-8g
Digital Output MEMS Accelerometer into the existing adxl367 iio
subsystem driver.

adxl366 supports all the features of adxl367 but has a few
additional features for which support is added in this patch:
 - built-in step counting (pedometer)
 - non-linearity compensation for Z axis

Signed-off-by: Darius Berghe <darius.berghe@analog.com>
---
 drivers/iio/accel/adxl367.c     | 233 +++++++++++++++++++++++++++++++-
 drivers/iio/accel/adxl367.h     |   5 +
 drivers/iio/accel/adxl367_i2c.c |   6 +-
 drivers/iio/accel/adxl367_spi.c |   6 +-
 4 files changed, 242 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index 90b7ae6d42b7..95fd365c0a27 100644
--- a/drivers/iio/accel/adxl367.c
+++ b/drivers/iio/accel/adxl367.c
@@ -14,6 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/mod_devicetable.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <asm/unaligned.h>
@@ -96,8 +97,17 @@
 #define ADXL367_POWER_CTL_MODE_MASK	GENMASK(1, 0)
 
 #define ADXL367_REG_ADC_CTL		0x3C
-#define ADXL367_REG_TEMP_CTL		0x3D
 #define ADXL367_ADC_EN_MASK		BIT(0)
+#define ADXL367_REG_TEMP_CTL		0x3D
+#define ADXL367_NL_COMP_EN_MASK         BIT(7)
+
+#define ADXL367_REG_PEDOMETER_STEP_CNT_H        0x47
+#define ADXL367_REG_PEDOMETER_CTL               0x49
+#define ADXL367_PEDOMETER_RESET_STEP_MASK       BIT(2)
+#define ADXL367_PEDOMETER_RESET_OF_MASK         BIT(1)
+#define ADXL367_PEDOMETER_EN_MASK               BIT(0)
+#define ADXL367_REG_PEDOMETER_THRESH_H          0x4A
+#define ADXL367_REG_PEDOMETER_SENS_H            0x4C
 
 enum adxl367_range {
 	ADXL367_2G_RANGE,
@@ -177,6 +187,9 @@ struct adxl367_state {
 	unsigned int	fifo_set_size;
 	unsigned int	fifo_watermark;
 
+	int             steps_en;
+	int             nl_comp_en;
+
 	__be16		fifo_buf[ADXL367_FIFO_SIZE] __aligned(IIO_DMA_MINALIGN);
 	__be16		sample_buf;
 	u8		act_threshold_buf[2];
@@ -221,6 +234,13 @@ static const int adxl367_range_scale_factor_tbl[] = {
 	[ADXL367_8G_RANGE] = 4,
 };
 
+enum adxl367_attr_id {
+	ADXL367_PEDOMETER_THRESHOLD,
+	ADXL367_PEDOMETER_SENSITIVITY,
+	ADXL367_PEDOMETER_RESET,
+	ADXL367_Z_NONLINEARITY_COMPENSATION,
+};
+
 enum {
 	ADXL367_X_CHANNEL_INDEX,
 	ADXL367_Y_CHANNEL_INDEX,
@@ -745,6 +765,30 @@ static int adxl367_find_range(struct adxl367_state *st, int val, int val2,
 	return 0;
 }
 
+static int adxl367_read_word(struct adxl367_state *st, int reg, int *val)
+{
+	u8 steps_raw[2];
+	int ret;
+
+	ret = regmap_bulk_read(st->regmap, reg, steps_raw, 2);
+	if (ret)
+		return ret;
+
+	*val = get_unaligned_be16(steps_raw);
+
+	return 0;
+}
+
+static int adxl367_write_word(struct adxl367_state *st, int reg, int *val)
+{
+	u8 steps_raw[2];
+
+	put_unaligned_be16(*val, steps_raw);
+
+	return regmap_bulk_write(st->regmap, reg,
+				steps_raw, 2);
+}
+
 static int adxl367_read_sample(struct iio_dev *indio_dev,
 			       struct iio_chan_spec const *chan,
 			       int *val)
@@ -920,6 +964,17 @@ static int adxl367_read_raw(struct iio_dev *indio_dev,
 		*val2 = adxl367_samp_freq_tbl[st->odr][1];
 		mutex_unlock(&st->lock);
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_PROCESSED:
+		switch (chan->type) {
+		case IIO_STEPS:
+			*val = st->nl_comp_en;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_ENABLE:
+		*val = st->steps_en;
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -951,9 +1006,96 @@ static int adxl367_write_raw(struct iio_dev *indio_dev,
 
 		return adxl367_set_range(indio_dev, range);
 	}
+	case IIO_CHAN_INFO_ENABLE:
+		ret = regmap_update_bits(st->regmap, ADXL367_REG_PEDOMETER_CTL,
+					 ADXL367_PEDOMETER_EN_MASK,
+					 FIELD_PREP(ADXL367_PEDOMETER_EN_MASK, val ? 1 : 0));
+		if (ret)
+			return ret;
+
+		st->steps_en = val ? 1 : 0;
+
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static ssize_t adxl367_read_attr(struct iio_dev *indio_dev,
+				 uintptr_t private,
+				 const struct iio_chan_spec *chan,
+				 char *buf)
+{
+	struct adxl367_state *st = iio_priv(indio_dev);
+	int ret;
+	int val;
+
+	switch (private) {
+	case ADXL367_PEDOMETER_THRESHOLD:
+		ret = adxl367_read_word(st, ADXL367_REG_PEDOMETER_THRESH_H, &val);
+		break;
+	case ADXL367_PEDOMETER_SENSITIVITY:
+		ret = adxl367_read_word(st, ADXL367_REG_PEDOMETER_SENS_H, &val);
+		break;
+	case ADXL367_Z_NONLINEARITY_COMPENSATION:
+		ret = regmap_read(st->regmap, ADXL367_REG_TEMP_CTL, &val);
+		val = FIELD_GET(ADXL367_NL_COMP_EN_MASK, val);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t adxl367_write_attr(struct iio_dev *indio_dev,
+				  uintptr_t private,
+				  const struct iio_chan_spec *chan,
+				  const char *buf, size_t len)
+{
+	struct adxl367_state *st = iio_priv(indio_dev);
+	int ret = 0;
+	unsigned long value;
+	int val;
+
+	ret = kstrtoul(buf, 10, &value);
+	if (ret)
+		return ret;
+	val = value;
+
+	switch (private) {
+	case ADXL367_PEDOMETER_THRESHOLD:
+		ret = adxl367_write_word(st, ADXL367_REG_PEDOMETER_THRESH_H, &val);
+		break;
+	case ADXL367_PEDOMETER_SENSITIVITY:
+		ret = adxl367_write_word(st, ADXL367_REG_PEDOMETER_SENS_H, &val);
+		break;
+	case ADXL367_PEDOMETER_RESET:
+		if (val)
+			ret = regmap_update_bits(st->regmap, ADXL367_REG_PEDOMETER_CTL,
+						 ADXL367_PEDOMETER_RESET_STEP_MASK | ADXL367_PEDOMETER_RESET_OF_MASK,
+						 ADXL367_PEDOMETER_RESET_STEP_MASK | ADXL367_PEDOMETER_RESET_OF_MASK);
+		ret = regmap_update_bits(st->regmap, ADXL367_REG_PEDOMETER_CTL,
+					 ADXL367_PEDOMETER_RESET_STEP_MASK | ADXL367_PEDOMETER_RESET_OF_MASK,
+					 0);
+		break;
+	case ADXL367_Z_NONLINEARITY_COMPENSATION:
+		ret = regmap_update_bits(st->regmap, ADXL367_REG_TEMP_CTL,
+					 ADXL367_NL_COMP_EN_MASK,
+					 val ? ADXL367_NL_COMP_EN_MASK : 0);
+		if (ret)
+			return ret;
+
+		st->nl_comp_en = val ? 1 : 0;
+		break;
 	default:
 		return -EINVAL;
 	}
+
+	return ret ? ret : len;
 }
 
 static int adxl367_write_raw_get_fmt(struct iio_dev *indio_dev,
@@ -1376,6 +1518,37 @@ static const struct iio_event_spec adxl367_events[] = {
 	},
 };
 
+static const struct iio_chan_spec_ext_info adxl367_step_ext_info[] = {
+	{
+		.name = "threshold",
+		.read = adxl367_read_attr,
+		.write = adxl367_write_attr,
+		.private = ADXL367_PEDOMETER_THRESHOLD,
+	},
+	{
+		.name = "sensitivity",
+		.read = adxl367_read_attr,
+		.write = adxl367_write_attr,
+		.private = ADXL367_PEDOMETER_SENSITIVITY,
+	},
+	{
+		.name = "reset",
+		.write = adxl367_write_attr,
+		.private = ADXL367_PEDOMETER_RESET,
+	},
+	{ }
+};
+
+static const struct iio_chan_spec_ext_info adxl367_z_ext_info[] = {
+	{
+		.name = "nl_comp_en",
+		.read = adxl367_read_attr,
+		.write = adxl367_write_attr,
+		.private = ADXL367_Z_NONLINEARITY_COMPENSATION,
+	},
+	{ }
+};
+
 #define ADXL367_ACCEL_CHANNEL(index, reg, axis) {			\
 	.type = IIO_ACCEL,						\
 	.address = (reg),						\
@@ -1424,6 +1597,44 @@ static const struct iio_chan_spec adxl367_channels[] = {
 			IIO_VOLTAGE),
 };
 
+static const struct iio_chan_spec adxl366_channels[] = {
+	ADXL367_ACCEL_CHANNEL(ADXL367_X_CHANNEL_INDEX, ADXL367_REG_X_DATA_H, X),
+	ADXL367_ACCEL_CHANNEL(ADXL367_Y_CHANNEL_INDEX, ADXL367_REG_Y_DATA_H, Y),
+	{
+		.type = IIO_ACCEL,
+		.address = ADXL367_REG_Z_DATA_H,
+		.modified = 1,
+		.channel2 = IIO_MOD_Z,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all_available =
+				BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.event_spec = adxl367_events,
+		.num_event_specs = ARRAY_SIZE(adxl367_events),
+		.scan_index = ADXL367_Z_CHANNEL_INDEX,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 14,
+			.storagebits = 16,
+			.endianness = IIO_BE,
+			},
+		.ext_info = adxl367_z_ext_info,
+	},
+	ADXL367_CHANNEL(ADXL367_TEMP_CHANNEL_INDEX, ADXL367_REG_TEMP_DATA_H,
+			IIO_TEMP),
+	ADXL367_CHANNEL(ADXL367_EX_ADC_CHANNEL_INDEX, ADXL367_REG_EX_ADC_DATA_H,
+			IIO_VOLTAGE),
+	{
+		.type = IIO_STEPS,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_ENABLE),
+		.scan_index = -1, /* No buffer support */
+		.ext_info = adxl367_step_ext_info,
+	},
+};
+
 static int adxl367_verify_devid(struct adxl367_state *st)
 {
 	unsigned int val;
@@ -1479,6 +1690,9 @@ int adxl367_probe(struct device *dev, const struct adxl367_ops *ops,
 	struct iio_dev *indio_dev;
 	struct adxl367_state *st;
 	int ret;
+	enum adxl367_variant variant;
+
+	variant = (uintptr_t)device_get_match_data(dev);
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
@@ -1492,10 +1706,21 @@ int adxl367_probe(struct device *dev, const struct adxl367_ops *ops,
 
 	mutex_init(&st->lock);
 
-	indio_dev->channels = adxl367_channels;
-	indio_dev->num_channels = ARRAY_SIZE(adxl367_channels);
+	switch (variant) {
+	case ADXL366:
+		indio_dev->name = "adxl366";
+		indio_dev->channels = adxl366_channels;
+		indio_dev->num_channels = ARRAY_SIZE(adxl366_channels);
+		break;
+	case ADXL367:
+		indio_dev->name = "adxl367";
+		indio_dev->channels = adxl367_channels;
+		indio_dev->num_channels = ARRAY_SIZE(adxl367_channels);
+		break;
+	default:
+		return -EINVAL;
+	}
 	indio_dev->available_scan_masks = adxl367_channel_masks;
-	indio_dev->name = "adxl367";
 	indio_dev->info = &adxl367_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
diff --git a/drivers/iio/accel/adxl367.h b/drivers/iio/accel/adxl367.h
index 4a42622149b1..21a6b06b774d 100644
--- a/drivers/iio/accel/adxl367.h
+++ b/drivers/iio/accel/adxl367.h
@@ -9,6 +9,11 @@
 
 #include <linux/types.h>
 
+enum adxl367_variant {
+	ADXL366,
+	ADXL367,
+};
+
 struct device;
 struct regmap;
 
diff --git a/drivers/iio/accel/adxl367_i2c.c b/drivers/iio/accel/adxl367_i2c.c
index b595fe94f3a3..b712e038183f 100644
--- a/drivers/iio/accel/adxl367_i2c.c
+++ b/drivers/iio/accel/adxl367_i2c.c
@@ -61,13 +61,15 @@ static int adxl367_i2c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id adxl367_i2c_id[] = {
-	{ "adxl367", 0 },
+	{ "adxl366", ADXL366 },
+	{ "adxl367", ADXL367 },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, adxl367_i2c_id);
 
 static const struct of_device_id adxl367_of_match[] = {
-	{ .compatible = "adi,adxl367" },
+	{ .compatible = "adi,adxl366", .data = (const void *)ADXL366 },
+	{ .compatible = "adi,adxl367", .data = (const void *)ADXL367 },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, adxl367_of_match);
diff --git a/drivers/iio/accel/adxl367_spi.c b/drivers/iio/accel/adxl367_spi.c
index 118c894015a5..ea8c0408281b 100644
--- a/drivers/iio/accel/adxl367_spi.c
+++ b/drivers/iio/accel/adxl367_spi.c
@@ -138,13 +138,15 @@ static int adxl367_spi_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id adxl367_spi_id[] = {
-	{ "adxl367", 0 },
+	{ "adxl366", ADXL366 },
+	{ "adxl367", ADXL367 },
 	{ },
 };
 MODULE_DEVICE_TABLE(spi, adxl367_spi_id);
 
 static const struct of_device_id adxl367_of_match[] = {
-	{ .compatible = "adi,adxl367" },
+	{ .compatible = "adi,adxl366", .data = (const void *)ADXL366 },
+	{ .compatible = "adi,adxl367", .data = (const void *)ADXL367 },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, adxl367_of_match);
-- 
2.46.1


