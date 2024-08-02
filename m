Return-Path: <linux-iio+bounces-8146-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD193945F66
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 16:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44041B21F92
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 14:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868B3200120;
	Fri,  2 Aug 2024 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3eCVUWP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDE6200110
	for <linux-iio@vger.kernel.org>; Fri,  2 Aug 2024 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722608832; cv=none; b=DNA8RWeE3mMoXPFYcXiH2Us+j87MjGlTpAPy2bnkdL2MA/Z205X4Npt+MvLxCwoR2Yi/yO8+w5Rbil4jarF0Q/Ji+9fXbZeGKY30HZXUlm7hbTWNSpWrN+qMrCkCPPomYUjBP+rXwKjjjAQcSHE+cM9ziWQDaY1KGX8DqUbpWGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722608832; c=relaxed/simple;
	bh=ImbjH8tckq4jKS+ePXVSd7/obirTGvOQ9YPWj0pNfw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pg7++Pda0EsbzZpMr4FU5ags8kXVho4CIFeywUeuMatZJG9OniZehTrWocgC10XWVrH/me8BDTA0d8V39BsgSkAAH4qWCO9/0uOA6KgHzjQlhfII/AFIUMMBy90X5//FRXt05QnsljJmD1X4TKYo8juTgqVJ4owc8A3EgHCcWTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3eCVUWP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E92C5C4AF0B;
	Fri,  2 Aug 2024 14:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722608832;
	bh=ImbjH8tckq4jKS+ePXVSd7/obirTGvOQ9YPWj0pNfw0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=m3eCVUWP1y6xBP0bDQZnyE4uM80+jWzILDXUsh7X2rOlWoC8+WfSH/stV49bJGr8Y
	 0lLPUq5hAOoP9IySPs8F8RxNMV966b3uxTEfXSfDvHlAvHVHpH1T81c1q+m2ybM6i8
	 N0cWNsHe8Pg6yGiwBoiOcKzR/Zu0hbM0HHbr45c6q/9Dbc1lrFoPB+/834/gS7EPCF
	 Fctvs0sIStWPsAA2MC8IHHRbDKr32rxBjDUkU6PAizacCd3VupQNHVrEQsRPdnFhOK
	 Y98qmMaojAqkzOw3zDE5tJKkJRoEdnoH3QEf8PORuCiHpUy+tY0mz1wRqP9ISwAqAh
	 FRE5zCrYWZnJg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1406C3DA4A;
	Fri,  2 Aug 2024 14:27:11 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 02 Aug 2024 16:27:06 +0200
Subject: [PATCH v2 8/8] iio: adc: ad9467: add digital interface test to
 debugfs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-dev-iio-backend-add-debugfs-v2-8-4cb62852f0d0@analog.com>
References: <20240802-dev-iio-backend-add-debugfs-v2-0-4cb62852f0d0@analog.com>
In-Reply-To: <20240802-dev-iio-backend-add-debugfs-v2-0-4cb62852f0d0@analog.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Dragos Bogdan <dragos.bogdan@analog.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722608829; l=10407;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=mIc8cdfVRPXmxVLFiNbyxGXSotI9LgS9R1xB3cY+/mw=;
 b=Y3qtXMeeJ+C0VrBK9ZCI8YtvWcj+1IRlTyPO3Tnc+56wmMmMXYlvlMxn6Jw9S6zSlgulUdjoL
 nyT4bAM5kJCBshUgSdlNlUReXQa2IsQo3v1QZ0VBqEonbR3juYeBqbz
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

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



