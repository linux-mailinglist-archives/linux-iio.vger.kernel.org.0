Return-Path: <linux-iio+bounces-4371-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8228AB21C
	for <lists+linux-iio@lfdr.de>; Fri, 19 Apr 2024 17:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2565B2839FC
	for <lists+linux-iio@lfdr.de>; Fri, 19 Apr 2024 15:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD8E13667D;
	Fri, 19 Apr 2024 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c13XsSQt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772A4133286;
	Fri, 19 Apr 2024 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541012; cv=none; b=uwTR4kk8NY2EHioDT6CS3TCj5etZcmLsFC01+HBqaQb3IX3xbO2wyNgUbjkl2+7g7sZYiYU8eBzVOBSg5ZA6vnHgyT9qzzDhFFXPYWnb90aevczbvbkc/Pldcyd8PrPgr+zWBv4rNF8XWShuIoTBgSQ8FCZXn6pY2enu82mnzI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541012; c=relaxed/simple;
	bh=7mLN6O+gkStwhWw7Spx2RV+GkT06Kb3PBj7KvqQghdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nnZxtAmDQDt8AUjzyR8WupBbhfH/INRWZss466+Ly+w8r5M3ZvbOcqlsbg5CZFKEPOgdO7NQbaduQa1WgJwu6omVBQpdgeqjJ1qDAMyupPjqmgQbi96jqH0z00ioNXR3gh7lxsl+9ZkwCyhq7ImQH3EUblFIjEB0KK1XoevHUug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c13XsSQt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 535AEC4AF10;
	Fri, 19 Apr 2024 15:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713541012;
	bh=7mLN6O+gkStwhWw7Spx2RV+GkT06Kb3PBj7KvqQghdo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=c13XsSQtbu8+gtpeqnkCD7Aw7J+VewjFG6dDJuKgB7BdxSdKXLeBeBcRsQ6JgZXa7
	 565hEm9U1JMpYOwSGKYZXESI3GhflyN31rxcrrID30J3fWAUa/oVVZk2mB/b6H0s91
	 HXkDZUm4/Fz9B90t8CxnZQJF5VsSnkkq6A+Uzr3R9YXXGuwU+4HFBQLgp7w93czxk/
	 eTD9c6FH/8w+3pm+9irDuJPJoLyM4ZdLatjsIOY/ktNcIM9zuPipgEysI17CZS29xX
	 1/C0XN9TrNvyK5b9C3+BFFXa46DIUs9/ZeqDB7ecIxu7YNb4R30HqYXEw1kuHWLRHw
	 jZl/ZSwPOXDzg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E35C4345F;
	Fri, 19 Apr 2024 15:36:52 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 19 Apr 2024 17:36:49 +0200
Subject: [PATCH 6/8] iio: adc: adi-axi-adc: support digital interface
 calibration
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-ad9467-new-features-v1-6-3e7628ff6d5e@analog.com>
References: <20240419-ad9467-new-features-v1-0-3e7628ff6d5e@analog.com>
In-Reply-To: <20240419-ad9467-new-features-v1-0-3e7628ff6d5e@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713541010; l=5353;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=pTk3suYEFqSEy8qWfkkQymJKnE79QKBvOXkcNN9lEGU=;
 b=MpVkNgn2WLrIqBi6yTTxLhZDmBNWXmNmDBRw3sE7mb9JJn23+FAnDtLi8qAe+ZviYZO5pxvdl
 5GqV+n6LWmwDLMfC/RIBgIsJHrbX2BRtpDbBpps+GTDgVlvhgMx3pmL
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Implement the new IIO backend APIs for calibrating the data
digital interfaces.

While at it, removed the tabs in 'struct adi_axi_adc_state' and used
spaces for the members.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 113 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 111 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index b312369b7366..d58fa05499c4 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -7,11 +7,13 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
@@ -37,6 +39,9 @@
 #define   ADI_AXI_REG_RSTN_MMCM_RSTN		BIT(1)
 #define   ADI_AXI_REG_RSTN_RSTN			BIT(0)
 
+#define ADI_AXI_ADC_REG_CTRL			0x0044
+#define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
+
 /* ADC Channel controls */
 
 #define ADI_AXI_REG_CHAN_CTRL(c)		(0x0400 + (c) * 0x40)
@@ -51,14 +56,28 @@
 #define   ADI_AXI_REG_CHAN_CTRL_PN_TYPE_OWR	BIT(1)
 #define   ADI_AXI_REG_CHAN_CTRL_ENABLE		BIT(0)
 
+#define ADI_AXI_ADC_REG_CHAN_STATUS(c)		(0x0404 + (c) * 0x40)
+#define   ADI_AXI_ADC_CHAN_STAT_PN_MASK		GENMASK(2, 1)
+
+#define ADI_AXI_ADC_REG_CHAN_CTRL_3(c)		(0x0418 + (c) * 0x40)
+#define   ADI_AXI_ADC_CHAN_PN_SEL_MASK		GENMASK(19, 16)
+
+/* IO Delays */
+#define ADI_AXI_ADC_REG_DELAY(l)		(0x0800 + (l) * 0x4)
+#define   AXI_ADC_DELAY_CTRL_MASK		GENMASK(4, 0)
+
+#define ADI_AXI_ADC_MAX_IO_NUM_LANES		15
+
 #define ADI_AXI_REG_CHAN_CTRL_DEFAULTS		\
 	(ADI_AXI_REG_CHAN_CTRL_FMT_SIGNEXT |	\
 	 ADI_AXI_REG_CHAN_CTRL_FMT_EN |		\
 	 ADI_AXI_REG_CHAN_CTRL_ENABLE)
 
 struct adi_axi_adc_state {
-	struct regmap				*regmap;
-	struct device				*dev;
+	struct regmap *regmap;
+	struct device *dev;
+	/* lock to protect multiple accesses to the device registers */
+	struct mutex lock;
 };
 
 static int axi_adc_enable(struct iio_backend *back)
@@ -104,6 +123,92 @@ static int axi_adc_data_format_set(struct iio_backend *back, unsigned int chan,
 				  ADI_AXI_REG_CHAN_CTRL_FMT_MASK, val);
 }
 
+static int axi_adc_data_sample_trigger(struct iio_backend *back,
+				       enum iio_backend_sample_trigger trigger)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+
+	if (trigger == IIO_BACKEND_SAMPLE_TRIGGER_EDGE_RISING)
+		return regmap_clear_bits(st->regmap, ADI_AXI_ADC_REG_CTRL,
+					 ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK);
+	if (trigger == IIO_BACKEND_SAMPLE_TRIGGER_EDGE_FALLING)
+		return regmap_set_bits(st->regmap, ADI_AXI_ADC_REG_CTRL,
+				       ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK);
+
+	return -EINVAL;
+}
+
+static int axi_adc_iodelays_set(struct iio_backend *back, unsigned int lane,
+				unsigned int tap)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+	int ret;
+	u32 val;
+
+	if (tap > FIELD_MAX(AXI_ADC_DELAY_CTRL_MASK))
+		return -EINVAL;
+	if (lane > ADI_AXI_ADC_MAX_IO_NUM_LANES)
+		return -EINVAL;
+
+	guard(mutex)(&st->lock);
+	ret = regmap_write(st->regmap, ADI_AXI_ADC_REG_DELAY(lane), tap);
+	if (ret)
+		return ret;
+	/*
+	 * If readback is ~0, that means there are issues with the
+	 * delay_clk.
+	 */
+	ret = regmap_read(st->regmap, ADI_AXI_ADC_REG_DELAY(lane), &val);
+	if (ret)
+		return ret;
+	if (val == U32_MAX)
+		return -EIO;
+
+	return 0;
+}
+
+static int axi_adc_test_pattern_set(struct iio_backend *back,
+				    unsigned int chan,
+				    enum iio_backend_test_pattern pattern)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+
+	switch (pattern) {
+	case IIO_BACKEND_ADI_PRBS_9A:
+		return regmap_update_bits(st->regmap, ADI_AXI_ADC_REG_CHAN_CTRL_3(chan),
+					  ADI_AXI_ADC_CHAN_PN_SEL_MASK,
+					  FIELD_PREP(ADI_AXI_ADC_CHAN_PN_SEL_MASK, 0));
+	default:
+		return -EINVAL;
+	}
+}
+
+static int axi_adc_chan_status(struct iio_backend *back, unsigned int chan,
+			       struct iio_backend_chan_status *status)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+	int ret;
+	u32 val;
+
+	guard(mutex)(&st->lock);
+	/* reset test bits by setting them */
+	ret = regmap_write(st->regmap, ADI_AXI_ADC_REG_CHAN_STATUS(chan),
+			   ADI_AXI_ADC_CHAN_STAT_PN_MASK);
+	if (ret)
+		return ret;
+
+	fsleep(1000);
+
+	ret = regmap_read(st->regmap, ADI_AXI_ADC_REG_CHAN_STATUS(chan), &val);
+	if (ret)
+		return ret;
+
+	if (ADI_AXI_ADC_CHAN_STAT_PN_MASK & val)
+		status->errors = true;
+
+	return 0;
+}
+
 static int axi_adc_chan_enable(struct iio_backend *back, unsigned int chan)
 {
 	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
@@ -166,6 +271,10 @@ static const struct iio_backend_ops adi_axi_adc_generic = {
 	.chan_disable = axi_adc_chan_disable,
 	.request_buffer = axi_adc_request_buffer,
 	.free_buffer = axi_adc_free_buffer,
+	.data_sample_trigger = axi_adc_data_sample_trigger,
+	.iodelay_set = axi_adc_iodelays_set,
+	.test_pattern_set = axi_adc_test_pattern_set,
+	.chan_status = axi_adc_chan_status,
 };
 
 static int adi_axi_adc_probe(struct platform_device *pdev)

-- 
2.44.0



