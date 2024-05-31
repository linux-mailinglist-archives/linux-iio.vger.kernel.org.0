Return-Path: <linux-iio+bounces-5560-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EA68D69F8
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 21:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E68284393
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 19:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1376317E461;
	Fri, 31 May 2024 19:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKHULrhD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB47517D343;
	Fri, 31 May 2024 19:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717184571; cv=none; b=VCgCvY0NauBgo6KgmT9+BfTOqBKZALCOoqnYxDYzDOCsWa3oWvtfPBBiEyo6t2pAaqbT14i1xTl0hV0mJhJCPxSDLgjR6Bmt9EKxvEJoF9MjJqctan7/pMun4Y0r7lu95g6wChQBRLSZuuyvq5u+scPsJXwt8Aw5N8F0Mskr82A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717184571; c=relaxed/simple;
	bh=coty3zmiVkzC0+Ab+NP3vBQIUemt6njlqQD0stWfSn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PbQGnruLEY/2MwZaEgzRhF+q/bVDwp24uF/rslokQFXMBlVsPMUCg0hrsUCL5TM0e5/o3C4SyM/uNXwBF/WdzFyGoXsK9dNrIrcyqtDqCcsVp6GYzA3LJKy95hYytxLsaMNu1jRv/bH387ChZQCiaN8ZSvQLts25BnWV+JPHQpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKHULrhD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5493EC4AF0F;
	Fri, 31 May 2024 19:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717184571;
	bh=coty3zmiVkzC0+Ab+NP3vBQIUemt6njlqQD0stWfSn4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KKHULrhD16NlqabMnShbPtVFP9CbnKW1V3nH1+G74/nLcYDpBFPKD+wQFNTAWwiK1
	 ul8G2wSx9qmQOdFdm8Xn8JECyTN1kXAF/pWXvMWZNFWmoMtsGU91QHzg/peQZ1USVh
	 BQzKiw9Y4yoQIxVMDlMOmICIjpMbUTxNFCceArSO1L+1/kBCjPuSETR8UmhfhkSQs8
	 dYf0QOb2aiVWEDg3qC1/6jOXHPXVk2TKtPMxIy2tIfBAEb4RY7f3+4ZNwZ9VrCafS7
	 V+HJkAtXhD1nvqpDmINx0NzQbbP4sqpkqWRTmMRd+0rxDbivklyh/f9suoA32ZGUJS
	 VUQC3pnbY7PjA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B82DC27C4F;
	Fri, 31 May 2024 19:42:51 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Fri, 31 May 2024 22:42:29 +0300
Subject: [PATCH v4 3/6] iio: adc: ad7173: refactor ain and vref selection
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-ad4111-v4-3-64607301c057@analog.com>
References: <20240531-ad4111-v4-0-64607301c057@analog.com>
In-Reply-To: <20240531-ad4111-v4-0-64607301c057@analog.com>
To: Ceclan Dumitru <dumitru.ceclan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717184569; l=4550;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=7xTLh9Dt46L6LmGcvJeBdLPREQkljJ0gREj2u5d2Mow=;
 b=XPE9rYupnMn63Ou1dEHEiVk8PJKUaxKx/OB6jyyZqEwr3OucVpbqQeX9vpSAAXqKcLC9KbSME
 5RzBrEZTSkTBlSIUIEs5wYHXykhgdwJDaKluwDf2axqfVqOae6XGpue
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

From: Dumitru Ceclan <dumitru.ceclan@analog.com>

Move validation of analog inputs and reference voltage selection to
separate functions to reduce the size of the channel config parsing
function and improve readability.
Add defines for the number of analog inputs in a channel.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7173.c | 71 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 6e249628bc64..a20831d99aa5 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -60,6 +60,7 @@
 #define AD7173_CH_SETUP_AINPOS_MASK	GENMASK(9, 5)
 #define AD7173_CH_SETUP_AINNEG_MASK	GENMASK(4, 0)
 
+#define AD7173_NO_AINS_PER_CHANNEL	2
 #define AD7173_CH_ADDRESS(pos, neg) \
 	(FIELD_PREP(AD7173_CH_SETUP_AINPOS_MASK, pos) | \
 	 FIELD_PREP(AD7173_CH_SETUP_AINNEG_MASK, neg))
@@ -623,6 +624,7 @@ static int ad7173_setup(struct iio_dev *indio_dev)
 static unsigned int ad7173_get_ref_voltage_milli(struct ad7173_state *st,
 						 u8 reference_select)
 {
+	struct device *dev = &st->sd.spi->dev;
 	int vref;
 
 	switch (reference_select) {
@@ -646,9 +648,11 @@ static unsigned int ad7173_get_ref_voltage_milli(struct ad7173_state *st,
 		return -EINVAL;
 	}
 
-	if (vref < 0)
+	if (vref < 0) {
+		dev_err(dev, "Cannot use reference %u. Error:%d\n",
+			reference_select, vref);
 		return vref;
-
+	}
 	return vref / (MICRO / MILLI);
 }
 
@@ -905,13 +909,50 @@ static int ad7173_register_clk_provider(struct iio_dev *indio_dev)
 					   &st->int_clk_hw);
 }
 
+static int ad7173_validate_voltage_ain_inputs(struct ad7173_state *st,
+					      const unsigned int ain[AD7173_NO_AINS_PER_CHANNEL])
+{
+	struct device *dev = &st->sd.spi->dev;
+
+	for (int i = 0; i < AD7173_NO_AINS_PER_CHANNEL; i++) {
+		if (ain[i] < st->info->num_inputs)
+			continue;
+
+		return dev_err_probe(dev, -EINVAL,
+			"Input pin number out of range for pair (%d %d).\n",
+			ain[0], ain[1]);
+	}
+
+	return 0;
+}
+
+static int ad7173_validate_reference(struct ad7173_state *st, int ref_sel)
+{
+	struct device *dev = &st->sd.spi->dev;
+	int ret;
+
+	if (ref_sel == AD7173_SETUP_REF_SEL_INT_REF && !st->info->has_int_ref)
+		return dev_err_probe(dev, -EINVAL,
+			"Internal reference is not available on current model.\n");
+
+	if (ref_sel == AD7173_SETUP_REF_SEL_EXT_REF2 && !st->info->has_ref2)
+		return dev_err_probe(dev, -EINVAL,
+			"External reference 2 is not available on current model.\n");
+
+	ret = ad7173_get_ref_voltage_milli(st, ref_sel);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 {
 	struct ad7173_channel *chans_st_arr, *chan_st_priv;
 	struct ad7173_state *st = iio_priv(indio_dev);
 	struct device *dev = indio_dev->dev.parent;
 	struct iio_chan_spec *chan_arr, *chan;
-	unsigned int ain[2], chan_index = 0;
+	unsigned int ain[AD7173_NO_AINS_PER_CHANNEL], chan_index = 0;
 	int ref_sel, ret, num_channels;
 
 	num_channels = device_get_child_node_count(dev);
@@ -965,11 +1006,9 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		if (ret)
 			return ret;
 
-		if (ain[0] >= st->info->num_inputs ||
-		    ain[1] >= st->info->num_inputs)
-			return dev_err_probe(dev, -EINVAL,
-				"Input pin number out of range for pair (%d %d).\n",
-				ain[0], ain[1]);
+		ret = ad7173_validate_voltage_ain_inputs(st, ain);
+		if (ret)
+			return ret;
 
 		ret = fwnode_property_match_property_string(child,
 							    "adi,reference-select",
@@ -980,19 +1019,9 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		else
 			ref_sel = ret;
 
-		if (ref_sel == AD7173_SETUP_REF_SEL_INT_REF &&
-		    !st->info->has_int_ref)
-			return dev_err_probe(dev, -EINVAL,
-				"Internal reference is not available on current model.\n");
-
-		if (ref_sel == AD7173_SETUP_REF_SEL_EXT_REF2 && !st->info->has_ref2)
-			return dev_err_probe(dev, -EINVAL,
-				"External reference 2 is not available on current model.\n");
-
-		ret = ad7173_get_ref_voltage_milli(st, ref_sel);
-		if (ret < 0)
-			return dev_err_probe(dev, ret,
-					     "Cannot use reference %u\n", ref_sel);
+		ret = ad7173_validate_reference(st, ref_sel);
+		if (ret)
+			return ret;
 
 		if (ref_sel == AD7173_SETUP_REF_SEL_INT_REF)
 			st->adc_mode |= AD7173_ADC_MODE_REF_EN;

-- 
2.43.0



