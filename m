Return-Path: <linux-iio+bounces-26403-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 65681C7F8F5
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 10:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53C154E6497
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 09:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830A42F5A18;
	Mon, 24 Nov 2025 09:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zIAhG8j7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05800253944;
	Mon, 24 Nov 2025 09:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975940; cv=none; b=QRCRhCZy05eENrPR97YKR4yQSeSRDJhxZrgEbnzNutJGIOEaGluWpJEFDkSeyHRDIkQq9rxICfUEyaF2nFxFvmdj27lZTnKDgz+cByGSOkRFFOMPMG7J9ZuSsxv4KspxVpzvAphTSEgWQibRDjjKrc3kTTfiXfMjzJC10+NJudA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975940; c=relaxed/simple;
	bh=Wk7gLhilBrNjV30tFr+fJqwITrbCgsMg+UdrRGR20DQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=O2LuycxTawgIbz6T+Q1MxK+1hkEm9CeVlF9xq1KdO7PTzf69sCVp9Qzx2IWHeZhTELk2zMjGDvC07ALxQZ08H8fQ/hWih0XIIfhXL9F3yop8wvGKkWSu6xHUGBXYK6cHCzy0B/6vl4XoaHLOdGuaeIAJckk0esSFXla03PdbICA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zIAhG8j7; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AO50SDT1958046;
	Mon, 24 Nov 2025 04:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=wU5xp
	uTfIclZQgqqXRbs6B4w9y66KkOmHcXncTuEElc=; b=zIAhG8j7Svu6hz1Q0SsQv
	x7H/po1nB3W6WLGKjSYb7Y24ZswQ/YMXeSsF1qQGUR/FycIeDbHFydrTSg8UF0eH
	4Gj27zxkKTR7tX7f7jGEf/WXkU44MLBKF0qDqo/TFKsZR4HoMHAitZMiEyPPeYBJ
	J/xnKknbrI3UeKrWC947up4OlvwIirEa/+m8+pnrqMQ/eSRYfQnOZRy8AaPCU5T9
	HwMu0uBN54J942OfubRd9m5HaQ4+pKCWpTLtTa6mCDfnGkqD3nbmVt2VFx8Nk2Ri
	MkrrL8WFEBlJ7MLBJEm7n0IVVXy1G0EokIkix9UaOl5SkPXQhyaXyvLKqKNWtaye
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4akay688fj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 04:18:41 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 5AO9Ie1s007661
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Nov 2025 04:18:40 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 24 Nov
 2025 04:18:40 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 24 Nov 2025 04:18:40 -0500
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.82])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AO9I8VQ024016;
	Mon, 24 Nov 2025 04:18:33 -0500
From: Jorge Marques <jorge.marques@analog.com>
Date: Mon, 24 Nov 2025 10:18:06 +0100
Subject: [PATCH v2 7/9] iio: adc: ad4062: Add IIO Events support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251124-staging-ad4062-v2-7-a375609afbb7@analog.com>
References: <20251124-staging-ad4062-v2-0-a375609afbb7@analog.com>
In-Reply-To: <20251124-staging-ad4062-v2-0-a375609afbb7@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Jorge Marques <jorge.marques@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763975888; l=16524;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=Wk7gLhilBrNjV30tFr+fJqwITrbCgsMg+UdrRGR20DQ=;
 b=Ksb8NczD6AqHy/kvypbhX42P0nGJ2yGlfAv2VLde7xcAEFbVkzs1vro6d4Gu79EfZpmn+c/q/
 SFNoe2fJIx1AyuTiiK+REfHa5akpwSRrbx3u6B9RMCXW7yUM5i6lFoI
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: BimPvK-uJNflDH-eWWA6hkflShuzNnWj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDA4MSBTYWx0ZWRfX6A2FcSEpS1mT
 x8tRAx2FWJQrK6J3XjKqlgddLnFUz4Y5SyGw7PfwsejM2zcXRPFQUiKi1Xd3pc7IRnbOTFjyvSV
 4FhD9lS/T6uU+uxUO0NT5o64amIHyf4t7ORhZDaUkwkpqS2jgr+o/YwgBhU7fvJk53U1ovXDodq
 YbW/lto+OYnW7VpfCvyV6n7zKmZTJj/N1b8rO2tC0d2Ja9iHJ++rHEz3okdDpRYkYqHc8ynz4OX
 IJGE7ztBly/EniSJIbsRXSeLXtt9spfSCsK4jvNMgsLxCs+tBhYB1K4/BUgMtvoAy29m32fRYfC
 y99xD2qPDVPmwd3pD9cjGMYOnbS5plStN2H4P1xaBYd8qV6MY3eSWhrWmAoq3o5qXnuvKggDc6B
 NHpHG+nhTObK5Zo6zYi74SQcBlHiuQ==
X-Authority-Analysis: v=2.4 cv=f8lFxeyM c=1 sm=1 tr=0 ts=692422f1 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gAnH3GRIAAAA:8 a=G_0orfQ0byHZzXNulvsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: BimPvK-uJNflDH-eWWA6hkflShuzNnWj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_03,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240081

Adds support for IIO Events. Optionally, gp0 is assigned as Threshold
Either signal, if not present, fallback to an I3C IBI with the same
role.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 drivers/iio/adc/ad4062.c | 394 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 378 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/ad4062.c b/drivers/iio/adc/ad4062.c
index 4e4be7358047f..3df7dbf29ae4a 100644
--- a/drivers/iio/adc/ad4062.c
+++ b/drivers/iio/adc/ad4062.c
@@ -13,6 +13,7 @@
 #include <linux/i3c/device.h>
 #include <linux/i3c/master.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
@@ -51,14 +52,22 @@
 #define     AD4062_REG_ADC_CONFIG_SCALE_EN_MSK		BIT(4)
 #define AD4062_REG_AVG_CONFIG				0x23
 #define AD4062_REG_GP_CONF				0x24
+#define     AD4062_REG_GP_CONF_MODE_MSK_0		GENMASK(2, 0)
 #define     AD4062_REG_GP_CONF_MODE_MSK_1		GENMASK(6, 4)
 #define AD4062_REG_INTR_CONF				0x25
+#define     AD4062_REG_INTR_CONF_EN_MSK_0		GENMASK(1, 0)
 #define     AD4062_REG_INTR_CONF_EN_MSK_1		GENMASK(5, 4)
 #define AD4062_REG_TIMER_CONFIG				0x27
 #define     AD4062_REG_TIMER_CONFIG_FS_MASK		GENMASK(7, 4)
+#define AD4062_REG_MAX_LIMIT				0x29
+#define AD4062_REG_MIN_LIMIT				0x2B
+#define AD4062_REG_MAX_HYST				0x2C
+#define AD4062_REG_MIN_HYST				0x2D
 #define AD4062_REG_MON_VAL				0x2F
 #define AD4062_REG_ADC_IBI_EN				0x31
 #define AD4062_REG_ADC_IBI_EN_CONV_TRIGGER		BIT(2)
+#define AD4062_REG_ADC_IBI_EN_MAX			BIT(1)
+#define AD4062_REG_ADC_IBI_EN_MIN			BIT(0)
 #define AD4062_REG_FUSE_CRC				0x40
 #define AD4062_REG_DEVICE_STATUS			0x41
 #define     AD4062_REG_DEVICE_STATUS_DEVICE_RESET	BIT(6)
@@ -76,8 +85,10 @@
 #define AD4062_MAX_AVG		0xB
 #define AD4062_MON_VAL_MAX_GAIN		1999970
 #define AD4062_MON_VAL_MIDDLE_POINT	0x8000
+#define AD4062_GP_INTR		0x1
 #define AD4062_GP_DRDY		0x2
 #define AD4062_INTR_EN_NEITHER	0x0
+#define AD4062_INTR_EN_EITHER	0x3
 #define AD4062_TCONV_NS		270
 
 enum ad4062_operation_mode {
@@ -146,6 +157,8 @@ struct ad4062_state {
 	struct i3c_device *i3cdev;
 	struct regmap *regmap;
 	u16 sampling_frequency;
+	u16 events_frequency;
+	bool wait_event;
 	int vref_uv;
 	int samp_freqs[ARRAY_SIZE(ad4062_conversion_freqs)];
 	u8 oversamp_ratio;
@@ -184,6 +197,26 @@ static const struct regmap_access_table ad4062_regmap_wr_table = {
 	.n_yes_ranges = ARRAY_SIZE(ad4062_regmap_wr_ranges),
 };
 
+static const struct iio_event_spec ad4062_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE) |
+				      BIT(IIO_EV_INFO_HYSTERESIS),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE) |
+				      BIT(IIO_EV_INFO_HYSTERESIS),
+	},
+};
+
 static int ad4062_conversion_frequency_set(struct ad4062_state *st, u8 val)
 {
 	return regmap_write(st->regmap, AD4062_REG_TIMER_CONFIG,
@@ -201,6 +234,8 @@ static int ad4062_conversion_frequency_set(struct ad4062_state *st, u8 val)
 	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
 	.indexed = 1,									\
 	.channel = 0,									\
+	.event_spec = ad4062_events,							\
+	.num_event_specs = ARRAY_SIZE(ad4062_events),					\
 	.has_ext_scan_type = 1,								\
 	.ext_scan_type = ad4062_scan_type_##bits##_s,					\
 	.num_ext_scan_type = ARRAY_SIZE(ad4062_scan_type_##bits##_s),			\
@@ -220,6 +255,70 @@ static const struct ad4062_chip_info ad4062_chip_info = {
 	.max_avg = AD4062_MAX_AVG,
 };
 
+static ssize_t ad4062_events_frequency_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct ad4062_state *st = iio_priv(dev_to_iio_dev(dev));
+
+	return sysfs_emit(buf, "%d\n", ad4062_conversion_freqs[st->events_frequency]);
+}
+
+static ssize_t ad4062_events_frequency_store(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ad4062_state *st = iio_priv(indio_dev);
+	int val, ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+	if (st->wait_event) {
+		ret = -EBUSY;
+		goto out_release;
+	}
+
+	ret = kstrtoint(buf, 10, &val);
+	if (ret < 0)
+		goto out_release;
+
+	st->events_frequency = find_closest_descending(val, ad4062_conversion_freqs,
+						       ARRAY_SIZE(ad4062_conversion_freqs));
+	ret = 0;
+
+out_release:
+	iio_device_release_direct(indio_dev);
+	return ret ? ret : len;
+}
+
+static IIO_DEVICE_ATTR(sampling_frequency, 0644, ad4062_events_frequency_show,
+		       ad4062_events_frequency_store, 0);
+
+static ssize_t sampling_frequency_available_show(struct device *dev,
+						 struct device_attribute *attr,
+						 char *buf)
+{
+	int ret = 0;
+
+	for (u8 i = 0; i < ARRAY_SIZE(ad4062_conversion_freqs); i++)
+		ret += sysfs_emit_at(buf, ret, "%d%s", ad4062_conversion_freqs[i],
+				     i != (ARRAY_SIZE(ad4062_conversion_freqs) - 1) ? " " : "\n");
+	return ret;
+}
+
+static IIO_DEVICE_ATTR_RO(sampling_frequency_available, 0);
+
+static struct attribute *ad4062_event_attributes[] = {
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
+	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group ad4062_event_attribute_group = {
+	.attrs = ad4062_event_attributes,
+};
+
 static int ad4062_set_oversampling_ratio(struct ad4062_state *st, unsigned int val)
 {
 	int ret;
@@ -369,9 +468,12 @@ static int ad4062_setup(struct iio_dev *indio_dev, struct iio_chan_spec const *c
 	if (IS_ERR(scan_type))
 		return PTR_ERR(scan_type);
 
-	val = FIELD_PREP(AD4062_REG_GP_CONF_MODE_MSK_1, AD4062_GP_DRDY);
+	val = FIELD_PREP(AD4062_REG_GP_CONF_MODE_MSK_0, AD4062_GP_INTR) |
+	      FIELD_PREP(AD4062_REG_GP_CONF_MODE_MSK_1, AD4062_GP_DRDY);
+
 	ret = regmap_update_bits(st->regmap, AD4062_REG_GP_CONF,
-				 AD4062_REG_GP_CONF_MODE_MSK_1, val);
+				 AD4062_REG_GP_CONF_MODE_MSK_1 | AD4062_REG_GP_CONF_MODE_MSK_0,
+				 val);
 	if (ret)
 		return ret;
 
@@ -387,9 +489,11 @@ static int ad4062_setup(struct iio_dev *indio_dev, struct iio_chan_spec const *c
 	if (ret)
 		return ret;
 
-	val = FIELD_PREP(AD4062_REG_INTR_CONF_EN_MSK_1, AD4062_INTR_EN_NEITHER);
+	val = FIELD_PREP(AD4062_REG_INTR_CONF_EN_MSK_0, AD4062_INTR_EN_EITHER) |
+	      FIELD_PREP(AD4062_REG_INTR_CONF_EN_MSK_1, AD4062_INTR_EN_NEITHER);
 	ret = regmap_update_bits(st->regmap, AD4062_REG_INTR_CONF,
-				 AD4062_REG_INTR_CONF_EN_MSK_1, val);
+				 AD4062_REG_INTR_CONF_EN_MSK_0 | AD4062_REG_INTR_CONF_EN_MSK_1,
+				 val);
 	if (ret)
 		return ret;
 
@@ -398,6 +502,19 @@ static int ad4062_setup(struct iio_dev *indio_dev, struct iio_chan_spec const *c
 				 &st->buf.be16, sizeof(st->buf.be16));
 }
 
+static irqreturn_t ad4062_irq_handler_thresh(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+
+	iio_push_event(indio_dev,
+		       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, 0,
+					    IIO_EV_TYPE_THRESH,
+					    IIO_EV_DIR_EITHER),
+		       iio_get_time_ns(indio_dev));
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t ad4062_irq_handler_drdy(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
@@ -416,10 +533,18 @@ static void ad4062_ibi_handler(struct i3c_device *i3cdev,
 {
 	struct ad4062_state *st = i3cdev_get_drvdata(i3cdev);
 
-	if (iio_buffer_enabled(st->indio_dev))
-		iio_trigger_poll_nested(st->trigger);
-	else
-		complete(&st->completion);
+	if (st->wait_event) {
+		iio_push_event(st->indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_EITHER),
+			       iio_get_time_ns(st->indio_dev));
+	} else {
+		if (iio_buffer_enabled(st->indio_dev))
+			iio_trigger_poll_nested(st->trigger);
+		else
+			complete(&st->completion);
+	}
 }
 
 static void ad4062_trigger_work(struct work_struct *work)
@@ -506,6 +631,24 @@ static int ad4062_request_irq(struct iio_dev *indio_dev)
 	struct device *dev = &st->i3cdev->dev;
 	int ret;
 
+	ret = fwnode_irq_get_byname(dev_fwnode(&st->i3cdev->dev), "gp0");
+	if (ret == -EPROBE_DEFER) {
+		return ret;
+	} else if (ret < 0) {
+		ret = regmap_update_bits(st->regmap, AD4062_REG_ADC_IBI_EN,
+					 AD4062_REG_ADC_IBI_EN_MAX | AD4062_REG_ADC_IBI_EN_MIN,
+					 AD4062_REG_ADC_IBI_EN_MAX | AD4062_REG_ADC_IBI_EN_MIN);
+		if (ret)
+			return ret;
+	} else {
+		ret = devm_request_threaded_irq(dev, ret, NULL,
+						ad4062_irq_handler_thresh,
+						IRQF_ONESHOT, indio_dev->name,
+						indio_dev);
+		if (ret)
+			return ret;
+	}
+
 	ret = fwnode_irq_get_byname(dev_fwnode(&st->i3cdev->dev), "gp1");
 	if (ret == -EPROBE_DEFER) {
 		return ret;
@@ -739,9 +882,14 @@ static int ad4062_read_raw(struct iio_dev *indio_dev,
 
 	if (!iio_device_claim_direct(indio_dev))
 		return -EBUSY;
+	if (st->wait_event) {
+		ret = -EBUSY;
+		goto out_release;
+	}
 
 	ret = ad4062_read_raw_dispatch(st, val, val2, info);
 
+out_release:
 	iio_device_release_direct(indio_dev);
 	return ret ? ret : IIO_VAL_INT;
 }
@@ -773,9 +921,215 @@ static int ad4062_write_raw(struct iio_dev *indio_dev,
 
 	if (!iio_device_claim_direct(indio_dev))
 		return -EBUSY;
+	if (st->wait_event) {
+		ret = -EBUSY;
+		goto out_release;
+	}
 
 	ret = ad4062_write_raw_dispatch(st, val, val2, info);
 
+out_release:
+	iio_device_release_direct(indio_dev);
+	return ret;
+}
+
+static int ad4062_monitor_mode_enable(struct ad4062_state *st, bool enable)
+{
+	int ret = 0;
+
+	if (!enable) {
+		pm_runtime_put_autosuspend(&st->i3cdev->dev);
+		return 0;
+	}
+
+	ACQUIRE(pm_runtime_active_try_enabled, pm)(&st->i3cdev->dev);
+	ret = ACQUIRE_ERR(pm_runtime_active_try_enabled, &pm);
+	if (ret)
+		return ret;
+
+	ret = ad4062_conversion_frequency_set(st, st->events_frequency);
+	if (ret)
+		return ret;
+
+	ret = ad4062_set_operation_mode(st, AD4062_MONITOR_MODE);
+	if (ret)
+		return ret;
+
+	pm_runtime_get_noresume(&st->i3cdev->dev);
+	return 0;
+}
+
+static int ad4062_read_event_config(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir)
+{
+	struct ad4062_state *st = iio_priv(indio_dev);
+
+	return st->wait_event;
+}
+
+static int ad4062_write_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     bool state)
+{
+	struct ad4062_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+	if (st->wait_event == state) {
+		ret = 0;
+		goto out_release;
+	}
+
+	ret = ad4062_monitor_mode_enable(st, state);
+	if (!ret)
+		st->wait_event = state;
+
+out_release:
+	iio_device_release_direct(indio_dev);
+	return ret;
+}
+
+static int __ad4062_read_event_info_value(struct ad4062_state *st,
+					  enum iio_event_direction dir, int *val)
+{
+	int ret;
+	u8 reg;
+
+	if (dir == IIO_EV_DIR_RISING)
+		reg = AD4062_REG_MAX_LIMIT;
+	else
+		reg = AD4062_REG_MIN_LIMIT;
+
+	ret = regmap_bulk_read(st->regmap, reg, &st->buf.be16,
+			       sizeof(st->buf.be16));
+	if (ret)
+		return ret;
+
+	*val = sign_extend32(get_unaligned_be16(st->buf.bytes), 11);
+
+	return 0;
+}
+
+static int __ad4062_read_event_info_hysteresis(struct ad4062_state *st,
+					       enum iio_event_direction dir, int *val)
+{
+	u8 reg;
+
+	if (dir == IIO_EV_DIR_RISING)
+		reg = AD4062_REG_MAX_HYST;
+	else
+		reg = AD4062_REG_MIN_HYST;
+	return regmap_read(st->regmap, reg, val);
+}
+
+static int ad4062_read_event_value(struct iio_dev *indio_dev,
+				   const struct iio_chan_spec *chan,
+				   enum iio_event_type type,
+				   enum iio_event_direction dir,
+				   enum iio_event_info info, int *val,
+				   int *val2)
+{
+	struct ad4062_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+	if (st->wait_event) {
+		ret = -EBUSY;
+		goto out_release;
+	}
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		ret = __ad4062_read_event_info_value(st, dir, val);
+		break;
+	case IIO_EV_INFO_HYSTERESIS:
+		ret = __ad4062_read_event_info_hysteresis(st, dir, val);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+out_release:
+	iio_device_release_direct(indio_dev);
+	return ret ? ret : IIO_VAL_INT;
+}
+
+static int __ad4062_write_event_info_value(struct ad4062_state *st,
+					   enum iio_event_direction dir, int val)
+{
+	u8 reg;
+
+	if (val > 2047 || val < -2048)
+		return -EINVAL;
+	if (dir == IIO_EV_DIR_RISING)
+		reg = AD4062_REG_MAX_LIMIT;
+	else
+		reg = AD4062_REG_MIN_LIMIT;
+	put_unaligned_be16(val, st->buf.bytes);
+
+	return regmap_bulk_write(st->regmap, reg, &st->buf.be16,
+				 sizeof(st->buf.be16));
+}
+
+static int __ad4062_write_event_info_hysteresis(struct ad4062_state *st,
+						enum iio_event_direction dir, int val)
+{
+	u8 reg;
+
+	if (val >= BIT(7))
+		return -EINVAL;
+	if (dir == IIO_EV_DIR_RISING)
+		reg = AD4062_REG_MAX_HYST;
+	else
+		reg = AD4062_REG_MIN_HYST;
+
+	return regmap_write(st->regmap, reg, val);
+}
+
+static int ad4062_write_event_value(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info, int val,
+				    int val2)
+{
+	struct ad4062_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+	if (st->wait_event) {
+		ret = -EBUSY;
+		goto out_release;
+	}
+
+	switch (type) {
+	case IIO_EV_TYPE_THRESH:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			ret = __ad4062_write_event_info_value(st, dir, val);
+			break;
+		case IIO_EV_INFO_HYSTERESIS:
+			ret = __ad4062_write_event_info_hysteresis(st, dir, val);
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+out_release:
 	iio_device_release_direct(indio_dev);
 	return ret;
 }
@@ -785,13 +1139,17 @@ static int ad4062_triggered_buffer_postenable(struct iio_dev *indio_dev)
 	struct ad4062_state *st = iio_priv(indio_dev);
 	int ret;
 
-	ret = pm_runtime_resume_and_get(&st->i3cdev->dev);
+	if (st->wait_event)
+		return -EBUSY;
+
+	ACQUIRE(pm_runtime_active_try_enabled, pm)(&st->i3cdev->dev);
+	ret = ACQUIRE_ERR(pm_runtime_active_try_enabled, &pm);
 	if (ret)
 		return ret;
 
 	ret = ad4062_set_operation_mode(st, st->mode);
 	if (ret)
-		goto out_mode_error;
+		return ret;
 
 	/* CONV_READ requires read to trigger first sample. */
 	struct i3c_priv_xfer t[2] = {
@@ -809,13 +1167,10 @@ static int ad4062_triggered_buffer_postenable(struct iio_dev *indio_dev)
 
 	ret = i3c_device_do_priv_xfers(st->i3cdev, t, st->gpo_irq[1] ? 2 : 1);
 	if (ret)
-		goto out_mode_error;
-	return 0;
-
-out_mode_error:
-	pm_runtime_put_autosuspend(&st->i3cdev->dev);
+		return ret;
 
-	return ret;
+	pm_runtime_get_noresume(&st->i3cdev->dev);
+	return 0;
 }
 
 static int ad4062_triggered_buffer_predisable(struct iio_dev *indio_dev)
@@ -859,6 +1214,11 @@ static const struct iio_info ad4062_info = {
 	.read_raw = ad4062_read_raw,
 	.write_raw = ad4062_write_raw,
 	.read_avail = ad4062_read_avail,
+	.read_event_config = &ad4062_read_event_config,
+	.write_event_config = &ad4062_write_event_config,
+	.read_event_value = &ad4062_read_event_value,
+	.write_event_value = &ad4062_write_event_value,
+	.event_attrs = &ad4062_event_attribute_group,
 	.get_current_scan_type = &ad4062_get_current_scan_type,
 	.debugfs_reg_access = &ad4062_debugfs_reg_access,
 };
@@ -939,8 +1299,10 @@ static int ad4062_probe(struct i3c_device *i3cdev)
 				     "Failed to initialize regmap\n");
 
 	st->mode = AD4062_SAMPLE_MODE;
+	st->wait_event = false;
 	st->chip = chip;
 	st->sampling_frequency = 0;
+	st->events_frequency = 0;
 	st->oversamp_ratio = BIT(0);
 	st->indio_dev = indio_dev;
 

-- 
2.51.1


