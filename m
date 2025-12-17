Return-Path: <linux-iio+bounces-27141-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A1ECC7902
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 13:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9071930A3A89
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 12:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869DF340A57;
	Wed, 17 Dec 2025 12:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="kbVKa8X/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5324340DAD;
	Wed, 17 Dec 2025 12:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765973662; cv=none; b=J+P63WDc1dHwrrSjgf1+fdngUbEc0i1NkkZ1qPgFIthgsOyZX3IvlTvBwJ2saZfQYh8uUjIC4GdTNvwC9I7jXLSYIwbKR0CWbxboMtvLzVtsbD+nmNm896D0ElCYRSh9urr0oH3OoWHvt07qTfJpNhYcVrtKZBY/R2juRadTwAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765973662; c=relaxed/simple;
	bh=c5sxELgxedBXy9/Ij3kKXZWr3/c8v9Q6WMmKuYjKC5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=njyBlSt9zsAEO2H7zJvui/sSszdIY17dIyp7iD09kt0xG9ei68cormguVnOXmmqydCMGXuZZu+xQlG8OEAYNYCeHV5PzxM+7+Nf4CjSgfKXESuJclDKD4JP5YZwr4CpQYpv7njTNcSeb5GSmL8Q+EmjZwdrye+A9q2oSNCvND+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=kbVKa8X/; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BH9aYqg964276;
	Wed, 17 Dec 2025 07:14:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=lDKvg
	UzCvseni4RnfEC198s9SBS1tFxpX7x/zdIz5Z4=; b=kbVKa8X/qL4TRTz+nDpMy
	3dX3ranY5AxEQpJZ3hM9JuAcMpd/YbNFKJnglCxxLZUm0ljv1Q201EuIf8u8L1Yk
	XBRX6ze8oJa8p3xx0ISpjpmeE45VLwrx1JzHmNfeIy+3Rfl4nidtfpJtAOdiIx0B
	OsadlPMcJf3Ls+CcdsztAjUMFocttEBkdZ9uexdbWM6GA4vojOfvD6ywrQzM3wA2
	8tYRJr7XOkL1yQ9ntvv5ynMdetTRzR03HbvgoF/ktt2g6v+sgyEDTHbYLfi6WKGO
	icQyJiXDpFXFz1tv9jBAPMpxpGHK1Yr6uPcnEnkVXs5oagbFwezW8OL32UpNFWcy
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4b3jt2thqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 07:14:03 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5BHCE2Wb041117
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Dec 2025 07:14:02 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 17 Dec 2025 07:14:01 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 17 Dec 2025 07:14:01 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 17 Dec 2025 07:14:01 -0500
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5BHCDUvD014815;
	Wed, 17 Dec 2025 07:13:53 -0500
From: Jorge Marques <jorge.marques@analog.com>
Date: Wed, 17 Dec 2025 13:13:30 +0100
Subject: [PATCH v4 7/9] iio: adc: ad4062: Add IIO Events support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251217-staging-ad4062-v4-7-7890a2951a8f@analog.com>
References: <20251217-staging-ad4062-v4-0-7890a2951a8f@analog.com>
In-Reply-To: <20251217-staging-ad4062-v4-0-7890a2951a8f@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765973610; l=17372;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=c5sxELgxedBXy9/Ij3kKXZWr3/c8v9Q6WMmKuYjKC5o=;
 b=o9KNm64Ei5wL3Ycn4jYOfLwiH5eWBl598nFvjuPsAh+8sii4yYG7WK6pEk9bpWrUV6+wRp4yE
 XGdWkqwcqYuC/uFc4V0yp4WhOrDfrIWCnltSQpkhIbRJTHTSC1Qrhcj
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: sxj_IoQzF0gH5z0LEd3mZtSroXNlQCri
X-Authority-Analysis: v=2.4 cv=Ct6ys34D c=1 sm=1 tr=0 ts=69429e8b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gAnH3GRIAAAA:8 a=ctgkBTGrW6sVLClIBwcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: sxj_IoQzF0gH5z0LEd3mZtSroXNlQCri
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDA5NSBTYWx0ZWRfXyhoKX3g30VIp
 tUxTAJXVsXFQUwPgBeyMr/u82rLhkafSlvdUvTy50FjO2uhvGp2gp7GfsJTFwP23VD1CDQthKC4
 SmM/sb7Rgkg2y8MiHXtghRhlHw6RlDbG+tDtnGh0PdTw6sZgGXhfoSbFha/qB4E0geTXGb4w9GJ
 LlqRzz9tuyz1VKREHiOHYSceFdCsGGfBoVC4NBHWuYMmHQAmGpCFDUz0vfmLKC0J7FBU8xEhWY0
 WilyZvpWuDAV/F2HobKkuTyk/jpEMP/ZVD6fO0yQjDWs+SinXd7iaF8LAKd3KjpPnK2dv56sj8M
 LOTmZ2cmDEddWSBmib2r7SaCpg/tY6OcbamV0NMyY/paIjg3c5lcl4P+MDdxLMNg2RulZXsm5dJ
 H3/5tK4sVEdxC20lZJ96XGhkdsdGbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512170095

Adds support for IIO Events. Optionally, gp0 is assigned as Threshold
Either signal, if not present, fallback to an I3C IBI with the same
role.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 drivers/iio/adc/ad4062.c | 407 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 406 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4062.c b/drivers/iio/adc/ad4062.c
index afc8b6969cf08..2084f0058627d 100644
--- a/drivers/iio/adc/ad4062.c
+++ b/drivers/iio/adc/ad4062.c
@@ -14,7 +14,9 @@
 #include <linux/i3c/device.h>
 #include <linux/i3c/master.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
@@ -51,14 +53,22 @@
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
@@ -78,9 +88,13 @@
 #define AD4060_PROD_ID		0x7A
 #define AD4062_PROD_ID		0x7C
 
+#define AD4062_GP_INTR		0x1
 #define AD4062_GP_DRDY		0x2
 
+#define AD4062_LIMIT_BITS	12
+
 #define AD4062_INTR_EN_NEITHER	0x0
+#define AD4062_INTR_EN_EITHER	0x3
 
 #define AD4062_TCONV_NS		270
 
@@ -149,10 +163,12 @@ struct ad4062_state {
 	struct iio_dev *indio_dev;
 	struct i3c_device *i3cdev;
 	struct regmap *regmap;
+	bool wait_event;
 	int vref_uV;
 	unsigned int samp_freqs[ARRAY_SIZE(ad4062_conversion_freqs)];
 	bool gpo_irq[2];
 	u16 sampling_frequency;
+	u16 events_frequency;
 	u8 oversamp_ratio;
 	u8 conv_sizeof;
 	u8 conv_addr;
@@ -188,6 +204,26 @@ static const struct regmap_access_table ad4062_regmap_wr_table = {
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
 #define AD4062_CHAN(bits) {								\
 	.type = IIO_VOLTAGE,								\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_RAW) |				\
@@ -199,6 +235,8 @@ static const struct regmap_access_table ad4062_regmap_wr_table = {
 	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
 	.indexed = 1,									\
 	.channel = 0,									\
+	.event_spec = ad4062_events,							\
+	.num_event_specs = ARRAY_SIZE(ad4062_events),					\
 	.has_ext_scan_type = 1,								\
 	.ext_scan_type = ad4062_scan_type_##bits##_s,					\
 	.num_ext_scan_type = ARRAY_SIZE(ad4062_scan_type_##bits##_s),			\
@@ -218,6 +256,73 @@ static const struct ad4062_chip_info ad4062_chip_info = {
 	.avg_max = 4096,
 };
 
+static ssize_t sampling_frequency_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct ad4062_state *st = iio_priv(dev_to_iio_dev(dev));
+
+	return sysfs_emit(buf, "%d\n", ad4062_conversion_freqs[st->events_frequency]);
+}
+
+static int sampling_frequency_store_dispatch(struct iio_dev *indio_dev,
+					     const char *buf)
+{
+	struct ad4062_state *st = iio_priv(indio_dev);
+	int val, ret;
+
+	if (st->wait_event)
+		return -EBUSY;
+
+	ret = kstrtoint(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	st->events_frequency = find_closest_descending(val, ad4062_conversion_freqs,
+						       ARRAY_SIZE(ad4062_conversion_freqs));
+	return 0;
+}
+
+static ssize_t sampling_frequency_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = sampling_frequency_store_dispatch(indio_dev, buf);
+	iio_device_release_direct(indio_dev);
+	return ret ?: len;
+}
+
+static IIO_DEVICE_ATTR_RW(sampling_frequency, 0);
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
 static int ad4062_set_oversampling_ratio(struct ad4062_state *st, int val, int val2)
 {
 	const u32 _max = st->chip->avg_max;
@@ -344,9 +449,11 @@ static int ad4062_conversion_frequency_set(struct ad4062_state *st, u8 val)
 static int ad4062_set_operation_mode(struct ad4062_state *st,
 				     enum ad4062_operation_mode mode)
 {
+	const unsigned int samp_freq = mode == AD4062_MONITOR_MODE ?
+				       st->events_frequency : st->sampling_frequency;
 	int ret;
 
-	ret = ad4062_conversion_frequency_set(st, st->sampling_frequency);
+	ret = ad4062_conversion_frequency_set(st, samp_freq);
 	if (ret)
 		return ret;
 
@@ -355,6 +462,17 @@ static int ad4062_set_operation_mode(struct ad4062_state *st,
 	if (ret)
 		return ret;
 
+	if (mode == AD4062_MONITOR_MODE) {
+		/* Change address pointer to enter monitor mode */
+		struct i3c_priv_xfer xfer_trigger = {
+			.data.out = &st->conv_addr,
+			.len = sizeof(st->conv_addr),
+			.rnw = false,
+		};
+		st->conv_addr = AD4062_REG_CONV_TRIGGER_32BITS;
+		return i3c_device_do_priv_xfers(st->i3cdev, &xfer_trigger, 1);
+	}
+
 	return regmap_write(st->regmap, AD4062_REG_MODE_SET,
 			    AD4062_REG_MODE_SET_ENTER_ADC);
 }
@@ -385,6 +503,13 @@ static int ad4062_setup(struct iio_dev *indio_dev, struct iio_chan_spec const *c
 	if (IS_ERR(scan_type))
 		return PTR_ERR(scan_type);
 
+	ret = regmap_update_bits(st->regmap, AD4062_REG_GP_CONF,
+				 AD4062_REG_GP_CONF_MODE_MSK_0,
+				 FIELD_PREP(AD4062_REG_GP_CONF_MODE_MSK_0,
+					    AD4062_GP_INTR));
+	if (ret)
+		return ret;
+
 	ret = regmap_update_bits(st->regmap, AD4062_REG_GP_CONF,
 				 AD4062_REG_GP_CONF_MODE_MSK_1,
 				 FIELD_PREP(AD4062_REG_GP_CONF_MODE_MSK_1,
@@ -404,6 +529,13 @@ static int ad4062_setup(struct iio_dev *indio_dev, struct iio_chan_spec const *c
 	if (ret)
 		return ret;
 
+	ret = regmap_update_bits(st->regmap, AD4062_REG_INTR_CONF,
+				 AD4062_REG_INTR_CONF_EN_MSK_0,
+				 FIELD_PREP(AD4062_REG_INTR_CONF_EN_MSK_0,
+					    AD4062_INTR_EN_EITHER));
+	if (ret)
+		return ret;
+
 	ret = regmap_update_bits(st->regmap, AD4062_REG_INTR_CONF,
 				 AD4062_REG_INTR_CONF_EN_MSK_1,
 				 FIELD_PREP(AD4062_REG_INTR_CONF_EN_MSK_1,
@@ -416,6 +548,19 @@ static int ad4062_setup(struct iio_dev *indio_dev, struct iio_chan_spec const *c
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
@@ -434,6 +579,14 @@ static void ad4062_ibi_handler(struct i3c_device *i3cdev,
 {
 	struct ad4062_state *st = i3cdev_get_drvdata(i3cdev);
 
+	if (st->wait_event) {
+		iio_push_event(st->indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_EITHER),
+			       iio_get_time_ns(st->indio_dev));
+		return;
+	}
 	if (iio_buffer_enabled(st->indio_dev))
 		iio_trigger_poll_nested(st->trigger);
 	else
@@ -529,6 +682,25 @@ static int ad4062_request_irq(struct iio_dev *indio_dev)
 	struct device *dev = &st->i3cdev->dev;
 	int ret;
 
+	ret = fwnode_irq_get_byname(dev_fwnode(&st->i3cdev->dev), "gp0");
+	if (ret == -EPROBE_DEFER)
+		return ret;
+
+	if (ret < 0) {
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
 	if (ret == -EPROBE_DEFER)
 		return ret;
@@ -720,6 +892,9 @@ static int ad4062_read_chan_raw(struct ad4062_state *st, int *val)
 static int ad4062_read_raw_dispatch(struct ad4062_state *st,
 				    int *val, int *val2, long info)
 {
+	if (st->wait_event)
+		return -EBUSY;
+
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
 		return ad4062_read_chan_raw(st, val);
@@ -761,6 +936,9 @@ static int ad4062_read_raw(struct iio_dev *indio_dev,
 static int ad4062_write_raw_dispatch(struct ad4062_state *st, int val, int val2,
 				     long info)
 {
+	if (st->wait_event)
+		return -EBUSY;
+
 	switch (info) {
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		return ad4062_set_oversampling_ratio(st, val, val2);
@@ -789,7 +967,224 @@ static int ad4062_write_raw(struct iio_dev *indio_dev,
 		return -EBUSY;
 
 	ret = ad4062_write_raw_dispatch(st, val, val2, info);
+	iio_device_release_direct(indio_dev);
+	return ret;
+}
+
+static int pm_ad4062_monitor_mode_enable(struct ad4062_state *st)
+{
+	int ret;
+
+	PM_RUNTIME_ACQUIRE(&st->i3cdev->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	return ad4062_set_operation_mode(st, AD4062_MONITOR_MODE);
+}
+
+static int ad4062_monitor_mode_enable(struct ad4062_state *st)
+{
+	int ret;
+
+	ret = pm_ad4062_monitor_mode_enable(st);
+	if (ret)
+		return ret;
+
+	pm_runtime_get_noresume(&st->i3cdev->dev);
+	return 0;
+}
 
+static int ad4062_monitor_mode_disable(struct ad4062_state *st)
+{
+	pm_runtime_put_autosuspend(&st->i3cdev->dev);
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
+static int ad4062_write_event_config_dispatch(struct iio_dev *indio_dev,
+					      bool state)
+{
+	struct ad4062_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (st->wait_event == state)
+		ret = 0;
+	else if (state)
+		ret = ad4062_monitor_mode_enable(st);
+	else
+		ret = ad4062_monitor_mode_disable(st);
+	if (ret)
+		return ret;
+
+	st->wait_event = state;
+	return 0;
+}
+
+static int ad4062_write_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     bool state)
+{
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = ad4062_write_event_config_dispatch(indio_dev, state);
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
+	*val = sign_extend32(be16_to_cpu(st->buf.be16), AD4062_LIMIT_BITS - 1);
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
+static int ad4062_read_event_config_dispatch(struct iio_dev *indio_dev,
+					     enum iio_event_direction dir,
+					     enum iio_event_info info, int *val)
+{
+	struct ad4062_state *st = iio_priv(indio_dev);
+
+	if (st->wait_event)
+		return -EBUSY;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		return __ad4062_read_event_info_value(st, dir, val);
+	case IIO_EV_INFO_HYSTERESIS:
+		return __ad4062_read_event_info_hysteresis(st, dir, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4062_read_event_value(struct iio_dev *indio_dev,
+				   const struct iio_chan_spec *chan,
+				   enum iio_event_type type,
+				   enum iio_event_direction dir,
+				   enum iio_event_info info, int *val,
+				   int *val2)
+{
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = ad4062_read_event_config_dispatch(indio_dev, dir, info, val);
+	iio_device_release_direct(indio_dev);
+	return ret ?: IIO_VAL_INT;
+}
+
+static int __ad4062_write_event_info_value(struct ad4062_state *st,
+					   enum iio_event_direction dir, int val)
+{
+	u8 reg;
+
+	if (val != sign_extend32(val, AD4062_LIMIT_BITS - 1))
+		return -EINVAL;
+	if (dir == IIO_EV_DIR_RISING)
+		reg = AD4062_REG_MAX_LIMIT;
+	else
+		reg = AD4062_REG_MIN_LIMIT;
+	st->buf.be16 = cpu_to_be16(val);
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
+	if (val > BIT(7) - 1)
+		return -EINVAL;
+	if (dir == IIO_EV_DIR_RISING)
+		reg = AD4062_REG_MAX_HYST;
+	else
+		reg = AD4062_REG_MIN_HYST;
+
+	return regmap_write(st->regmap, reg, val);
+}
+
+static int ad4062_write_event_value_dispatch(struct iio_dev *indio_dev,
+					     enum iio_event_type type,
+					     enum iio_event_direction dir,
+					     enum iio_event_info info, int val)
+{
+	struct ad4062_state *st = iio_priv(indio_dev);
+
+	if (st->wait_event)
+		return -EBUSY;
+
+	switch (type) {
+	case IIO_EV_TYPE_THRESH:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			return __ad4062_write_event_info_value(st, dir, val);
+		case IIO_EV_INFO_HYSTERESIS:
+			return __ad4062_write_event_info_hysteresis(st, dir, val);
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4062_write_event_value(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info, int val,
+				    int val2)
+{
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = ad4062_write_event_value_dispatch(indio_dev, type, dir, info, val);
 	iio_device_release_direct(indio_dev);
 	return ret;
 }
@@ -825,6 +1220,9 @@ static int pm_ad4062_triggered_buffer_postenable(struct ad4062_state *st)
 	if (ret)
 		return ret;
 
+	if (st->wait_event)
+		return -EBUSY;
+
 	ret = ad4062_set_operation_mode(st, st->mode);
 	if (ret)
 		return ret;
@@ -900,6 +1298,11 @@ static const struct iio_info ad4062_info = {
 	.read_raw = ad4062_read_raw,
 	.write_raw = ad4062_write_raw,
 	.read_avail = ad4062_read_avail,
+	.read_event_config = ad4062_read_event_config,
+	.write_event_config = ad4062_write_event_config,
+	.read_event_value = ad4062_read_event_value,
+	.write_event_value = ad4062_write_event_value,
+	.event_attrs = &ad4062_event_attribute_group,
 	.get_current_scan_type = ad4062_get_current_scan_type,
 	.debugfs_reg_access = ad4062_debugfs_reg_access,
 };
@@ -980,8 +1383,10 @@ static int ad4062_probe(struct i3c_device *i3cdev)
 				     "Failed to initialize regmap\n");
 
 	st->mode = AD4062_SAMPLE_MODE;
+	st->wait_event = false;
 	st->chip = chip;
 	st->sampling_frequency = 0;
+	st->events_frequency = 0;
 	st->oversamp_ratio = 0;
 	st->indio_dev = indio_dev;
 

-- 
2.51.1


