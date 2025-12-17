Return-Path: <linux-iio+bounces-27137-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4BACC78C8
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 13:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FB4E3064ED5
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 12:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3D7341642;
	Wed, 17 Dec 2025 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="KvAQk4Eo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBF733F395;
	Wed, 17 Dec 2025 12:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765973659; cv=none; b=ckOwx53c0vt2/fgk+ItMA7VPdcLeQ7PHnDoJbd/eSHJGgYFwpvKfeyA2q4OyqfvFBBqIUaLlJEtgrnmL0Wt2OpcN1nupunWp4iwJhvTmKH0Uc0y6oXct6zYZwQNedPO+QNctWJJcOtepN0hVsYJ7nFMnwDTJciWLuCaJwW2FJ0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765973659; c=relaxed/simple;
	bh=IXC04bKVME1MIN4tc1hJfbQ469/2PvuAl9H57VoRJtg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=oG7MS8m9cBAoVct6i+rd7gKUrktEyd/+0rafQb5HkV0QTDGIReGN5WcG135HU3g9CdB8sl0XWEOqHnl2NudSGHyOiv+4WEh4nK2EHFSm8hGOpUvofe4QmumnlHJ+qRE3CoED3qdBoE/Kx2D76s26iMzx7fHW6bNO1/KlSO0ZcSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=KvAQk4Eo; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHAUCA93839029;
	Wed, 17 Dec 2025 07:14:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=F6kMV
	vXDxJtwauqyYrgwjcDvWbFhv8SJKq/0AaQJMTc=; b=KvAQk4EoEemoruT6YjjLS
	jABtfuV2ewRYT07T5ws9XVLj92mqVJUKByyfAdwGKKRvy2D59bYm1gIjwRD+jVpI
	bdcqPU+7794jo3vPdpADSBaHn4fsq8kOegbvRwAK1E3DhckdZlDtFQ17pwGqwu0w
	CMMM0i1+6v+NNUszyQuv/hYddyKOsounuPLLnZG/jWrFJwYQyqnvg1WlzOn/hRK7
	P+a79ombVpE2sGIKOmyiknNcyp7Gwawtr3bys+7bnzBWdjlRYQhyd9t9hr7kUtv/
	LqLQxOorkINqv0fU3nsfu/SmLJmCnutWX8skT8bqPtCqp+VtTdmUTV3VhxS2bYq5
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4b3jw9jeh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 07:14:01 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5BHCDv0D041098
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Dec 2025 07:13:57 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 17 Dec 2025 07:13:57 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 17 Dec 2025 07:13:57 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 17 Dec 2025 07:13:57 -0500
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5BHCDUvB014815;
	Wed, 17 Dec 2025 07:13:49 -0500
From: Jorge Marques <jorge.marques@analog.com>
Date: Wed, 17 Dec 2025 13:13:28 +0100
Subject: [PATCH v4 5/9] iio: adc: ad4062: Add IIO Trigger support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251217-staging-ad4062-v4-5-7890a2951a8f@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765973610; l=13791;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=IXC04bKVME1MIN4tc1hJfbQ469/2PvuAl9H57VoRJtg=;
 b=EWwMfcOd/vD0HQEUKajE53jWMwygkprMq8sjPM69M+p15Kd7cE1wyMcYoDFzyEA8HYSfsxx2t
 0MKeXhukijMAG4bOLJXlg5fIJ4vPIZ54jmtPDbX/yuTgcSrz+moDjaz
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDA5NSBTYWx0ZWRfX4/zfXKgWTbNJ
 0Lh5rr10LRxmbXZiAwa21I8Y46zmRdKybagAEcFNO3RvVIIZlqzUORSvGXS2MN6q9vFRdYnQVOF
 FY6Dp+W+HeDq+xDXLVKWipxciSbeBwdLrOCwhoDLfYTrfNo14Y0OdF6IRZHQIqtbCHj9LemGiH5
 23gefQYQbTdc4pIcMtvfc07Jz7sFJUDtdq7pvLrCJCyfT8H0xJMj3KfOdHHxDTFWXL/3hz8BRWY
 7eOBCPUQppupafDtA1Y/YBf+FtBLeDFlh6YwWiDx2jaYw/hOCELwGrpoPabC4dw185SAMxkXdBs
 8bXJIU3X7mAL5+cZQLOb1aYsUeJkt5Jq315NGe07yUfJJ6/h6TKrpW1dAt+Pn5+v7JkQjzfzrKI
 ZZV/ufffcjvxbCiYP9CBVtepo78fow==
X-Authority-Analysis: v=2.4 cv=TZGbdBQh c=1 sm=1 tr=0 ts=69429e89 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gAnH3GRIAAAA:8 a=CGgXswB9vpsB3GpN9NgA:9 a=QEXdDO2ut3YA:10
 a=br55WurUj89AL1qEz8Q6:22
X-Proofpoint-GUID: 58jtYC6xYq98BaqlaI-3aCnbUWEWU4eJ
X-Proofpoint-ORIG-GUID: 58jtYC6xYq98BaqlaI-3aCnbUWEWU4eJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170095

Adds support for IIO Trigger. Optionally, gp1 is assigned as Data Ready
signal, if not present, fallback to an I3C IBI with the same role.
The software trigger is allocated by the device, but must be attached by
the user before enabling the buffer. The purpose is to not impede
removing the driver due to the increased reference count when
iio_trigger_set_immutable() or iio_trigger_get() is used.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 drivers/iio/adc/Kconfig  |   2 +
 drivers/iio/adc/ad4062.c | 272 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 268 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index fda0da422c675..89a6486135f60 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -74,6 +74,8 @@ config AD4062
 	tristate "Analog Devices AD4062 Driver"
 	depends on I3C
 	select REGMAP_I3C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Analog Devices AD4062 I3C analog
 	  to digital converters (ADC).
diff --git a/drivers/iio/adc/ad4062.c b/drivers/iio/adc/ad4062.c
index 1a7829c507e53..afc8b6969cf08 100644
--- a/drivers/iio/adc/ad4062.c
+++ b/drivers/iio/adc/ad4062.c
@@ -9,10 +9,15 @@
 #include <linux/bitops.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
+#include <linux/devm-helpers.h>
 #include <linux/err.h>
 #include <linux/i3c/device.h>
 #include <linux/i3c/master.h>
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 #include <linux/interrupt.h>
 #include <linux/jiffies.h>
 #include <linux/math.h>
@@ -59,6 +64,9 @@
 #define     AD4062_REG_DEVICE_STATUS_DEVICE_RESET	BIT(6)
 #define AD4062_REG_IBI_STATUS				0x48
 #define AD4062_REG_CONV_READ_LSB			0x50
+#define AD4062_REG_CONV_READ_16BITS			0x51
+#define AD4062_REG_CONV_READ_32BITS			0x53
+#define AD4062_REG_CONV_TRIGGER_16BITS			0x57
 #define AD4062_REG_CONV_TRIGGER_32BITS			0x59
 #define AD4062_REG_CONV_AUTO				0x61
 #define AD4062_MAX_REG					AD4062_REG_CONV_AUTO
@@ -94,6 +102,36 @@ enum {
 	AD4062_SCAN_TYPE_BURST_AVG,
 };
 
+static const struct iio_scan_type ad4062_scan_type_12_s[] = {
+	[AD4062_SCAN_TYPE_SAMPLE] = {
+		.sign = 's',
+		.realbits = 12,
+		.storagebits = 16,
+		.endianness = IIO_BE,
+	},
+	[AD4062_SCAN_TYPE_BURST_AVG] = {
+		.sign = 's',
+		.realbits = 14,
+		.storagebits = 16,
+		.endianness = IIO_BE,
+	},
+};
+
+static const struct iio_scan_type ad4062_scan_type_16_s[] = {
+	[AD4062_SCAN_TYPE_SAMPLE] = {
+		.sign = 's',
+		.realbits = 16,
+		.storagebits = 16,
+		.endianness = IIO_BE,
+	},
+	[AD4062_SCAN_TYPE_BURST_AVG] = {
+		.sign = 's',
+		.realbits = 20,
+		.storagebits = 32,
+		.endianness = IIO_BE,
+	},
+};
+
 static const unsigned int ad4062_conversion_freqs[] = {
 	2000000, 1000000, 300000, 100000,	/*  0 -  3 */
 	33300, 10000, 3000, 500,		/*  4 -  7 */
@@ -105,6 +143,7 @@ struct ad4062_state {
 	const struct ad4062_chip_info *chip;
 	const struct ad4062_bus_ops *ops;
 	enum ad4062_operation_mode mode;
+	struct work_struct trig_conv;
 	struct completion completion;
 	struct iio_trigger *trigger;
 	struct iio_dev *indio_dev;
@@ -112,8 +151,10 @@ struct ad4062_state {
 	struct regmap *regmap;
 	int vref_uV;
 	unsigned int samp_freqs[ARRAY_SIZE(ad4062_conversion_freqs)];
+	bool gpo_irq[2];
 	u16 sampling_frequency;
 	u8 oversamp_ratio;
+	u8 conv_sizeof;
 	u8 conv_addr;
 	union {
 		__be32 be32;
@@ -147,7 +188,7 @@ static const struct regmap_access_table ad4062_regmap_wr_table = {
 	.n_yes_ranges = ARRAY_SIZE(ad4062_regmap_wr_ranges),
 };
 
-#define AD4062_CHAN {									\
+#define AD4062_CHAN(bits) {								\
 	.type = IIO_VOLTAGE,								\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_RAW) |				\
 				    BIT(IIO_CHAN_INFO_SCALE) |				\
@@ -158,18 +199,21 @@ static const struct regmap_access_table ad4062_regmap_wr_table = {
 	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
 	.indexed = 1,									\
 	.channel = 0,									\
+	.has_ext_scan_type = 1,								\
+	.ext_scan_type = ad4062_scan_type_##bits##_s,					\
+	.num_ext_scan_type = ARRAY_SIZE(ad4062_scan_type_##bits##_s),			\
 }
 
 static const struct ad4062_chip_info ad4060_chip_info = {
 	.name = "ad4060",
-	.channels = { AD4062_CHAN },
+	.channels = { AD4062_CHAN(12) },
 	.prod_id = AD4060_PROD_ID,
 	.avg_max = 256,
 };
 
 static const struct ad4062_chip_info ad4062_chip_info = {
 	.name = "ad4062",
-	.channels = { AD4062_CHAN },
+	.channels = { AD4062_CHAN(16) },
 	.prod_id = AD4062_PROD_ID,
 	.avg_max = 4096,
 };
@@ -334,8 +378,13 @@ static int ad4062_setup(struct iio_dev *indio_dev, struct iio_chan_spec const *c
 			const bool *ref_sel)
 {
 	struct ad4062_state *st = iio_priv(indio_dev);
+	const struct iio_scan_type *scan_type;
 	int ret;
 
+	scan_type = iio_get_current_scan_type(indio_dev, chan);
+	if (IS_ERR(scan_type))
+		return PTR_ERR(scan_type);
+
 	ret = regmap_update_bits(st->regmap, AD4062_REG_GP_CONF,
 				 AD4062_REG_GP_CONF_MODE_MSK_1,
 				 FIELD_PREP(AD4062_REG_GP_CONF_MODE_MSK_1,
@@ -372,7 +421,10 @@ static irqreturn_t ad4062_irq_handler_drdy(int irq, void *private)
 	struct iio_dev *indio_dev = private;
 	struct ad4062_state *st = iio_priv(indio_dev);
 
-	complete(&st->completion);
+	if (iio_buffer_enabled(indio_dev) && iio_trigger_using_own(indio_dev))
+		iio_trigger_poll(st->trigger);
+	else
+		complete(&st->completion);
 
 	return IRQ_HANDLED;
 }
@@ -382,7 +434,55 @@ static void ad4062_ibi_handler(struct i3c_device *i3cdev,
 {
 	struct ad4062_state *st = i3cdev_get_drvdata(i3cdev);
 
-	complete(&st->completion);
+	if (iio_buffer_enabled(st->indio_dev))
+		iio_trigger_poll_nested(st->trigger);
+	else
+		complete(&st->completion);
+}
+
+static void ad4062_trigger_work(struct work_struct *work)
+{
+	struct ad4062_state *st =
+		container_of(work, struct ad4062_state, trig_conv);
+	int ret;
+
+	/*
+	 * Read current conversion, if at reg CONV_READ, stop bit triggers
+	 * next sample and does not need writing the address.
+	 */
+	struct i3c_priv_xfer xfer_sample = {
+		.data.in = &st->buf.be32,
+		.len = st->conv_sizeof,
+		.rnw = true,
+	};
+	struct i3c_priv_xfer xfer_trigger = {
+		.data.out = &st->conv_addr,
+		.len = sizeof(st->conv_addr),
+		.rnw = false,
+	};
+
+	ret = i3c_device_do_priv_xfers(st->i3cdev, &xfer_sample, 1);
+	if (ret)
+		return;
+
+	iio_push_to_buffers_with_ts(st->indio_dev, &st->buf.be32, st->conv_sizeof,
+				    iio_get_time_ns(st->indio_dev));
+	if (st->gpo_irq[1])
+		return;
+
+	i3c_device_do_priv_xfers(st->i3cdev, &xfer_trigger, 1);
+}
+
+static irqreturn_t ad4062_poll_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ad4062_state *st = iio_priv(indio_dev);
+
+	iio_trigger_notify_done(indio_dev->trig);
+	schedule_work(&st->trig_conv);
+
+	return IRQ_HANDLED;
 }
 
 static void ad4062_disable_ibi(void *data)
@@ -433,10 +533,13 @@ static int ad4062_request_irq(struct iio_dev *indio_dev)
 	if (ret == -EPROBE_DEFER)
 		return ret;
 
-	if (ret < 0)
+	if (ret < 0) {
+		st->gpo_irq[1] = false;
 		return regmap_update_bits(st->regmap, AD4062_REG_ADC_IBI_EN,
 					  AD4062_REG_ADC_IBI_EN_CONV_TRIGGER,
 					  AD4062_REG_ADC_IBI_EN_CONV_TRIGGER);
+	}
+	st->gpo_irq[1] = true;
 
 	return devm_request_threaded_irq(dev, ret,
 					 ad4062_irq_handler_drdy,
@@ -444,6 +547,34 @@ static int ad4062_request_irq(struct iio_dev *indio_dev)
 					 indio_dev);
 }
 
+static const struct iio_trigger_ops ad4062_trigger_ops = {
+	.validate_device = &iio_trigger_validate_own_device,
+};
+
+static int ad4062_request_trigger(struct iio_dev *indio_dev)
+{
+	struct ad4062_state *st = iio_priv(indio_dev);
+	struct device *dev = &st->i3cdev->dev;
+	int ret;
+
+	st->trigger = devm_iio_trigger_alloc(dev, "%s-dev%d",
+					     indio_dev->name,
+					     iio_device_id(indio_dev));
+	if (!st->trigger)
+		return -ENOMEM;
+
+	st->trigger->ops = &ad4062_trigger_ops;
+	iio_trigger_set_drvdata(st->trigger, indio_dev);
+
+	ret = devm_iio_trigger_register(dev, st->trigger);
+	if (ret)
+		return ret;
+
+	indio_dev->trig = iio_trigger_get(st->trigger);
+
+	return 0;
+}
+
 static const int ad4062_oversampling_avail[] = {
 	1, 2, 4, 8, 16, 32, 64, 128,		/*  0 -  7 */
 	256, 512, 1024, 2048, 4096,		/*  8 - 12 */
@@ -478,6 +609,25 @@ static int ad4062_read_avail(struct iio_dev *indio_dev,
 	}
 }
 
+static int ad4062_get_chan_scale(struct iio_dev *indio_dev, int *val, int *val2)
+{
+	struct ad4062_state *st = iio_priv(indio_dev);
+	const struct iio_scan_type *scan_type;
+
+	/*
+	 * In burst averaging mode the averaging filter accumulates resulting
+	 * in a sample with increased precision.
+	 */
+	scan_type = iio_get_current_scan_type(indio_dev, st->chip->channels);
+	if (IS_ERR(scan_type))
+		return PTR_ERR(scan_type);
+
+	*val = (st->vref_uV * 2) / (MICRO / MILLI); /* signed */
+	*val2 = scan_type->realbits - 1;
+
+	return IIO_VAL_FRACTIONAL_LOG2;
+}
+
 static int ad4062_get_chan_calibscale(struct ad4062_state *st, int *val, int *val2)
 {
 	int ret;
@@ -593,6 +743,9 @@ static int ad4062_read_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+		return ad4062_get_chan_scale(indio_dev, val, val2);
+
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return ad4062_get_sampling_frequency(st, val);
 	}
@@ -641,6 +794,87 @@ static int ad4062_write_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
+/*
+ * The AD4062 in burst averaging mode increases realbits from 16-bits to
+ * 20-bits, increasing the storagebits from 16-bits to 32-bits.
+ */
+static inline size_t ad4062_sizeof_storagebits(struct ad4062_state *st)
+{
+	const struct iio_scan_type *scan_type =
+		iio_get_current_scan_type(st->indio_dev, st->chip->channels);
+
+	return BITS_TO_BYTES(scan_type->storagebits);
+}
+
+/* Read registers only with realbits (no sign extension bytes) */
+static inline size_t ad4062_get_conv_addr(struct ad4062_state *st, size_t _sizeof)
+{
+	if (st->gpo_irq[1])
+		return _sizeof == sizeof(u32) ? AD4062_REG_CONV_READ_32BITS :
+						AD4062_REG_CONV_READ_16BITS;
+	return _sizeof == sizeof(u32) ? AD4062_REG_CONV_TRIGGER_32BITS :
+					AD4062_REG_CONV_TRIGGER_16BITS;
+}
+
+static int pm_ad4062_triggered_buffer_postenable(struct ad4062_state *st)
+{
+	int ret;
+
+	PM_RUNTIME_ACQUIRE(&st->i3cdev->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	ret = ad4062_set_operation_mode(st, st->mode);
+	if (ret)
+		return ret;
+
+	st->conv_sizeof = ad4062_sizeof_storagebits(st);
+	st->conv_addr = ad4062_get_conv_addr(st, st->conv_sizeof);
+	/* CONV_READ requires read to trigger first sample. */
+	struct i3c_priv_xfer xfer_sample[2] = {
+		{
+			.data.out = &st->conv_addr,
+			.len = sizeof(st->conv_addr),
+			.rnw = false,
+		},
+		{
+			.data.in = &st->buf.be32,
+			.len = sizeof(st->buf.be32),
+			.rnw = true,
+		}
+	};
+
+	return i3c_device_do_priv_xfers(st->i3cdev, xfer_sample,
+					st->gpo_irq[1] ? 2 : 1);
+}
+
+static int ad4062_triggered_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad4062_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = pm_ad4062_triggered_buffer_postenable(st);
+	if (ret)
+		return ret;
+
+	pm_runtime_get_noresume(&st->i3cdev->dev);
+	return 0;
+}
+
+static int ad4062_triggered_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad4062_state *st = iio_priv(indio_dev);
+
+	pm_runtime_put_autosuspend(&st->i3cdev->dev);
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops ad4062_triggered_buffer_setup_ops = {
+	.postenable = &ad4062_triggered_buffer_postenable,
+	.predisable = &ad4062_triggered_buffer_predisable,
+};
+
 static int ad4062_debugfs_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 				     unsigned int writeval, unsigned int *readval)
 {
@@ -652,10 +886,21 @@ static int ad4062_debugfs_reg_access(struct iio_dev *indio_dev, unsigned int reg
 		return regmap_write(st->regmap, reg, writeval);
 }
 
+static int ad4062_get_current_scan_type(const struct iio_dev *indio_dev,
+					const struct iio_chan_spec *chan)
+{
+	struct ad4062_state *st = iio_priv(indio_dev);
+
+	return st->mode == AD4062_BURST_AVERAGING_MODE ?
+			   AD4062_SCAN_TYPE_BURST_AVG :
+			   AD4062_SCAN_TYPE_SAMPLE;
+}
+
 static const struct iio_info ad4062_info = {
 	.read_raw = ad4062_read_raw,
 	.write_raw = ad4062_write_raw,
 	.read_avail = ad4062_read_avail,
+	.get_current_scan_type = ad4062_get_current_scan_type,
 	.debugfs_reg_access = ad4062_debugfs_reg_access,
 };
 
@@ -762,6 +1007,17 @@ static int ad4062_probe(struct i3c_device *i3cdev)
 	if (ret)
 		return ret;
 
+	ret = ad4062_request_trigger(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_triggered_buffer_setup(&i3cdev->dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      ad4062_poll_handler,
+					      &ad4062_triggered_buffer_setup_ops);
+	if (ret)
+		return ret;
+
 	pm_runtime_set_active(dev);
 	ret = devm_pm_runtime_enable(dev);
 	if (ret)
@@ -774,6 +1030,10 @@ static int ad4062_probe(struct i3c_device *i3cdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to request i3c ibi\n");
 
+	ret = devm_work_autocancel(dev, &st->trig_conv, ad4062_trigger_work);
+	if (ret)
+		return ret;
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 

-- 
2.51.1


