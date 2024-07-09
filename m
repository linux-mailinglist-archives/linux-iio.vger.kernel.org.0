Return-Path: <linux-iio+bounces-7469-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E71892B646
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 13:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9479E1F23A28
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 11:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E10157E61;
	Tue,  9 Jul 2024 11:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="lgVPDxg9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CB3158858
	for <linux-iio@vger.kernel.org>; Tue,  9 Jul 2024 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523501; cv=none; b=LKnCUJO+lFytOfejb9o1zzSlxhl9eOmFa/QvhOTk0VbuOdvS5JhQCEEBkfWyhsFUdIJH0jsUYnNw0uiM4yMYvDhCTcfnq7euTHcLF7TnD3uLVaGFKt4w27FhPUVYcdYo8hgHbo9+FeewAz/O7H+XoHdybVU6xSF20E/rjUQDCt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523501; c=relaxed/simple;
	bh=mIc8cdfVRPXmxVLFiNbyxGXSotI9LgS9R1xB3cY+/mw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=pkzDZwVSXhFBZqB7+dcCf1f2rpXczVsxn2IFie8DB5uwmQWJeWq3txi+9qnqO8Co8HUasYDih5K8ubsKb28ilMwaAB6t/v6CFFd2S5bJTqR7Xk+FQaeciqHhu1ErL01Sc9/BtdMgfSLjRGYgiFNWL9+y/h6/8v/uXVQ99+oRcNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=lgVPDxg9; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469B6396004305;
	Tue, 9 Jul 2024 07:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=a4mDY
	0r955OSY6grK89Xi6KkFWQA3o0QoT0LGnChgqs=; b=lgVPDxg96DuBOdKWQ0KQ4
	iIqmEvjpydf7b+3Yeml+BShM1QzH4US/Uf/WaufwAeerFOhSu9pDMJF3NzjWhYXh
	7CKDZo7CvEzoJILc/IzplUR6ZvCFRpo+6pMvchr0ujMGQPbw9Ov/DJ3lrbZ093mY
	8VvlAUZcWiZGQbfpcJcxdOW0nhu07EflAM5DcqsigLT0H7aTp1qnr9q6j1m+Rw8H
	pb1Ief9BAnK0CI0iFZyNJ4qBw1Mr7CiHZrTJswm8nYd00iEfEElibOpI0x9H9M5C
	onUsG0oP9NS4JsiHqe6Xty+10futcfbDRAiupK9X6CbPXaqgtvnMDc296TyqCbgw
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 408y9291p0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 07:11:10 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 469BB9FC046296
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Jul 2024 07:11:09 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 9 Jul 2024
 07:11:08 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 9 Jul 2024 07:11:08 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 469BAlgs032387;
	Tue, 9 Jul 2024 07:11:01 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Tue, 9 Jul 2024 13:14:36 +0200
Subject: [PATCH 9/9] iio: adc: ad9467: add digital interface test to
 debugfs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240709-dev-iio-backend-add-debugfs-v1-9-fb4b8f2373c7@analog.com>
References: <20240709-dev-iio-backend-add-debugfs-v1-0-fb4b8f2373c7@analog.com>
In-Reply-To: <20240709-dev-iio-backend-add-debugfs-v1-0-fb4b8f2373c7@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Olivier
 Moysan <olivier.moysan@foss.st.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720523683; l=10407;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=mIc8cdfVRPXmxVLFiNbyxGXSotI9LgS9R1xB3cY+/mw=;
 b=oiO70dp1cEUAMEb/JaTQNELJcoJ5AyjUk9zgAI1XSvSFASZXcwBGeBRzPDp6CSU0Wi/ivGmUB
 IhQ04l0oYlpCHcQOJtk2+03t4TU5w6VQVM6ITsjmtyYej4ywyHdBiWc
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 1CLNC3h0A1-nFvP8PcqVStzA6Z2Blhbs
X-Proofpoint-ORIG-GUID: 1CLNC3h0A1-nFvP8PcqVStzA6Z2Blhbs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090077

One useful thing to do (in case of problems) in this high speed devices
with digital interfaces is to try different test patterns to see if the
interface is working properly (and properly calibrated). Hence add this
to debugfs.

On top of this, for some test patterns, the backend may have a matching
validator block which can be helpful in identifying possible issues. For
the other patterns some test equipment must be used so one can look into
the signal and see how it looks like.

Hence, we also add the backend debugfs interface with
iio_backend_debugfs_add().

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad9467.c | 188 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 188 insertions(+)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 2f4bbbd5611c..ce0bae94aa3a 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
+#include <linux/seq_file.h>
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
@@ -136,6 +137,8 @@ struct ad9467_chip_info {
 	unsigned int num_channels;
 	const unsigned int (*scale_table)[2];
 	int num_scales;
+	unsigned long test_mask;
+	unsigned int test_mask_len;
 	unsigned long max_rate;
 	unsigned int default_output_mode;
 	unsigned int vref_mask;
@@ -147,11 +150,19 @@ struct ad9467_chip_info {
 	bool has_dco_invert;
 };
 
+struct ad9467_chan_test_mode {
+	struct ad9467_state *st;
+	unsigned int idx;
+	u8 mode;
+};
+
 struct ad9467_state {
 	const struct ad9467_chip_info *info;
 	struct iio_backend *back;
 	struct spi_device *spi;
 	struct clk *clk;
+	/* used for debugfs */
+	struct ad9467_chan_test_mode *chan_test;
 	unsigned int output_mode;
 	unsigned int (*scales)[2];
 	/*
@@ -308,6 +319,23 @@ static const struct iio_chan_spec ad9652_channels[] = {
 	AD9467_CHAN(1, BIT(IIO_CHAN_INFO_SCALE), 1, 16, 's'),
 };
 
+static const char * const ad9467_test_modes[] = {
+	[AN877_ADC_TESTMODE_OFF] = "off",
+	[AN877_ADC_TESTMODE_MIDSCALE_SHORT] = "midscale_short",
+	[AN877_ADC_TESTMODE_POS_FULLSCALE] = "pos_fullscale",
+	[AN877_ADC_TESTMODE_NEG_FULLSCALE] = "neg_fullscale",
+	[AN877_ADC_TESTMODE_ALT_CHECKERBOARD] = "checkerboard",
+	[AN877_ADC_TESTMODE_PN23_SEQ] = "prbs23",
+	[AN877_ADC_TESTMODE_PN9_SEQ] = "prbs9",
+	[AN877_ADC_TESTMODE_ONE_ZERO_TOGGLE] = "one_zero_toggle",
+	[AN877_ADC_TESTMODE_USER] = "user",
+	[AN877_ADC_TESTMODE_BIT_TOGGLE] = "bit_toggle",
+	[AN877_ADC_TESTMODE_SYNC] = "sync",
+	[AN877_ADC_TESTMODE_ONE_BIT_HIGH] = "one_bit_high",
+	[AN877_ADC_TESTMODE_MIXED_BIT_FREQUENCY] = "mixed_bit_frequency",
+	[AN877_ADC_TESTMODE_RAMP] = "ramp",
+};
+
 static const struct ad9467_chip_info ad9467_chip_tbl = {
 	.name = "ad9467",
 	.id = CHIPID_AD9467,
@@ -317,6 +345,9 @@ static const struct ad9467_chip_info ad9467_chip_tbl = {
 	.channels = ad9467_channels,
 	.num_channels = ARRAY_SIZE(ad9467_channels),
 	.test_points = AD9647_MAX_TEST_POINTS,
+	.test_mask = GENMASK(AN877_ADC_TESTMODE_ONE_ZERO_TOGGLE,
+			     AN877_ADC_TESTMODE_OFF),
+	.test_mask_len = AN877_ADC_TESTMODE_ONE_ZERO_TOGGLE + 1,
 	.default_output_mode = AD9467_DEF_OUTPUT_MODE,
 	.vref_mask = AD9467_REG_VREF_MASK,
 	.num_lanes = 8,
@@ -331,6 +362,8 @@ static const struct ad9467_chip_info ad9434_chip_tbl = {
 	.channels = ad9434_channels,
 	.num_channels = ARRAY_SIZE(ad9434_channels),
 	.test_points = AD9647_MAX_TEST_POINTS,
+	.test_mask = GENMASK(AN877_ADC_TESTMODE_USER, AN877_ADC_TESTMODE_OFF),
+	.test_mask_len = AN877_ADC_TESTMODE_USER + 1,
 	.default_output_mode = AD9434_DEF_OUTPUT_MODE,
 	.vref_mask = AD9434_REG_VREF_MASK,
 	.num_lanes = 6,
@@ -345,6 +378,9 @@ static const struct ad9467_chip_info ad9265_chip_tbl = {
 	.channels = ad9467_channels,
 	.num_channels = ARRAY_SIZE(ad9467_channels),
 	.test_points = AD9647_MAX_TEST_POINTS,
+	.test_mask = GENMASK(AN877_ADC_TESTMODE_ONE_ZERO_TOGGLE,
+			     AN877_ADC_TESTMODE_OFF),
+	.test_mask_len = AN877_ADC_TESTMODE_ONE_ZERO_TOGGLE + 1,
 	.default_output_mode = AD9265_DEF_OUTPUT_MODE,
 	.vref_mask = AD9265_REG_VREF_MASK,
 	.has_dco = true,
@@ -360,6 +396,9 @@ static const struct ad9467_chip_info ad9643_chip_tbl = {
 	.channels = ad9643_channels,
 	.num_channels = ARRAY_SIZE(ad9643_channels),
 	.test_points = AD9647_MAX_TEST_POINTS,
+	.test_mask = BIT(AN877_ADC_TESTMODE_RAMP) |
+		GENMASK(AN877_ADC_TESTMODE_MIXED_BIT_FREQUENCY, AN877_ADC_TESTMODE_OFF),
+	.test_mask_len = AN877_ADC_TESTMODE_RAMP + 1,
 	.vref_mask = AD9643_REG_VREF_MASK,
 	.has_dco = true,
 	.has_dco_invert = true,
@@ -375,6 +414,9 @@ static const struct ad9467_chip_info ad9649_chip_tbl = {
 	.channels = ad9649_channels,
 	.num_channels = ARRAY_SIZE(ad9649_channels),
 	.test_points = AD9649_TEST_POINTS,
+	.test_mask = GENMASK(AN877_ADC_TESTMODE_MIXED_BIT_FREQUENCY,
+			     AN877_ADC_TESTMODE_OFF),
+	.test_mask_len = AN877_ADC_TESTMODE_MIXED_BIT_FREQUENCY + 1,
 	.has_dco = true,
 	.has_dco_invert = true,
 	.dco_en = AN877_ADC_DCO_DELAY_ENABLE,
@@ -389,6 +431,9 @@ static const struct ad9467_chip_info ad9652_chip_tbl = {
 	.channels = ad9652_channels,
 	.num_channels = ARRAY_SIZE(ad9652_channels),
 	.test_points = AD9647_MAX_TEST_POINTS,
+	.test_mask = GENMASK(AN877_ADC_TESTMODE_ONE_ZERO_TOGGLE,
+			     AN877_ADC_TESTMODE_OFF),
+	.test_mask_len = AN877_ADC_TESTMODE_ONE_ZERO_TOGGLE + 1,
 	.vref_mask = AD9652_REG_VREF_MASK,
 	.has_dco = true,
 };
@@ -933,6 +978,128 @@ static int ad9467_iio_backend_get(struct ad9467_state *st)
 	return -ENODEV;
 }
 
+static int ad9467_test_mode_available_show(struct seq_file *s, void *ignored)
+{
+	struct ad9467_state *st = s->private;
+	unsigned int bit;
+
+	for_each_set_bit(bit, &st->info->test_mask, st->info->test_mask_len)
+		seq_printf(s, "%s\n", ad9467_test_modes[bit]);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ad9467_test_mode_available);
+
+static ssize_t ad9467_chan_test_mode_read(struct file *file,
+					  char __user *userbuf, size_t count,
+					  loff_t *ppos)
+{
+	struct ad9467_chan_test_mode *chan = file->private_data;
+	struct ad9467_state *st = chan->st;
+	char buf[128] = {0};
+	size_t len;
+	int ret;
+
+	if (chan->mode == AN877_ADC_TESTMODE_PN9_SEQ ||
+	    chan->mode == AN877_ADC_TESTMODE_PN23_SEQ) {
+		len = scnprintf(buf, sizeof(buf), "Running \"%s\" Test:\n\t",
+				ad9467_test_modes[chan->mode]);
+
+		ret = iio_backend_debugfs_print_chan_status(st->back, chan->idx,
+							    buf + len,
+							    sizeof(buf) - len);
+		if (ret < 0)
+			return ret;
+		len += ret;
+	} else if (chan->mode == AN877_ADC_TESTMODE_OFF) {
+		len = scnprintf(buf, sizeof(buf), "No test Running...\n");
+	} else {
+		len = scnprintf(buf, sizeof(buf), "Running \"%s\" Test on CH:%u\n",
+				ad9467_test_modes[chan->mode], chan->idx);
+	}
+
+	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
+}
+
+static ssize_t ad9467_chan_test_mode_write(struct file *file,
+					   const char __user *userbuf,
+					   size_t count, loff_t *ppos)
+{
+	struct ad9467_chan_test_mode *chan = file->private_data;
+	struct ad9467_state *st = chan->st;
+	char test_mode[32] = {0};
+	unsigned int mode;
+	int ret;
+
+	ret = simple_write_to_buffer(test_mode, sizeof(test_mode) - 1, ppos,
+				     userbuf, count);
+	if (ret < 0)
+		return ret;
+
+	for_each_set_bit(mode, &st->info->test_mask, st->info->test_mask_len) {
+		if (sysfs_streq(test_mode, ad9467_test_modes[mode]))
+			break;
+	}
+
+	if (mode == st->info->test_mask_len)
+		return -EINVAL;
+
+	guard(mutex)(&st->lock);
+
+	if (mode == AN877_ADC_TESTMODE_OFF) {
+		unsigned int out_mode;
+
+		if (chan->mode == AN877_ADC_TESTMODE_PN9_SEQ ||
+		    chan->mode == AN877_ADC_TESTMODE_PN23_SEQ) {
+			ret = ad9467_backend_testmode_off(st, chan->idx);
+			if (ret)
+				return ret;
+		}
+
+		ret = ad9467_testmode_set(st, chan->idx, mode);
+		if (ret)
+			return ret;
+
+		out_mode = st->info->default_output_mode | AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT;
+		ret = ad9467_outputmode_set(st, out_mode);
+		if (ret)
+			return ret;
+	} else {
+		ret = ad9467_outputmode_set(st, st->info->default_output_mode);
+		if (ret)
+			return ret;
+
+		ret = ad9467_testmode_set(st, chan->idx, mode);
+		if (ret)
+			return ret;
+
+		/*  some patterns have a backend matching monitoring block */
+		if (mode == AN877_ADC_TESTMODE_PN9_SEQ) {
+			ret = ad9467_backend_testmode_on(st, chan->idx,
+							 IIO_BACKEND_ADI_PRBS_9A);
+			if (ret)
+				return ret;
+		} else if (mode == AN877_ADC_TESTMODE_PN23_SEQ) {
+			ret = ad9467_backend_testmode_on(st, chan->idx,
+							 IIO_BACKEND_ADI_PRBS_23A);
+			if (ret)
+				return ret;
+		}
+	}
+
+	chan->mode = mode;
+
+	return count;
+}
+
+static const struct file_operations ad9467_chan_test_mode_fops = {
+	.open = simple_open,
+	.read = ad9467_chan_test_mode_read,
+	.write = ad9467_chan_test_mode_write,
+	.llseek = default_llseek,
+	.owner = THIS_MODULE,
+};
+
 static ssize_t ad9467_dump_calib_table(struct file *file,
 				       char __user *userbuf,
 				       size_t count, loff_t *ppos)
@@ -971,12 +1138,33 @@ static void ad9467_debugfs_init(struct iio_dev *indio_dev)
 {
 	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
 	struct ad9467_state *st = iio_priv(indio_dev);
+	char attr_name[32];
+	unsigned int chan;
 
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
 		return;
 
+	st->chan_test = devm_kcalloc(&st->spi->dev, st->info->num_channels,
+				     sizeof(*st->chan_test), GFP_KERNEL);
+	if (!st->chan_test)
+		return;
+
 	debugfs_create_file("calibration_table_dump", 0400, d, st,
 			    &ad9467_calib_table_fops);
+
+	for (chan = 0; chan < st->info->num_channels; chan++) {
+		snprintf(attr_name, sizeof(attr_name), "in_voltage%u_test_mode",
+			 chan);
+		st->chan_test[chan].idx = chan;
+		st->chan_test[chan].st = st;
+		debugfs_create_file(attr_name, 0600, d, &st->chan_test[chan],
+				    &ad9467_chan_test_mode_fops);
+	}
+
+	debugfs_create_file("in_voltage_test_mode_available", 0400, d, st,
+			    &ad9467_test_mode_available_fops);
+
+	iio_backend_debugfs_add(st->back, indio_dev);
 }
 
 static int ad9467_probe(struct spi_device *spi)

-- 
2.45.2


