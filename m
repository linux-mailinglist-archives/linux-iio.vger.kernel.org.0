Return-Path: <linux-iio+bounces-6016-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7FC9007DA
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 16:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324341F21805
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 14:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFB11A01BC;
	Fri,  7 Jun 2024 14:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUa61FgN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E9919FA76;
	Fri,  7 Jun 2024 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771989; cv=none; b=t+NDyTPla3tIWR0NKxhhFyeHGmiarYI41zUtHGjbBu6oX2jF1cchxe0QerA0sgFHYFeWN06hRvB8dmP4OgBGbIu/FZhkMAckKJsLwbfQwZ5R+yDQ7S90WrnPE5kIvDGIaLVsWQMYcBx18+udFKfzeg2zqfoOa8AW7HXFK+6gKEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771989; c=relaxed/simple;
	bh=NVd+zTYMoc6J2OMUcKwaZbTj/+f6TMT5UM+zc8YKt/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B07gq3up0jCBPUPnknm+bEj+y8uqgWxmaSM2HEzKqiLCRxflPyOHcfjXsFpHjtaDKiwvDvgF8SK8ynvpVcZPv/8IMPEuiSwlV2P7pSM5EA/vm3jE0nHtwLLDvwzSLty40W9QviO6pAYPxwqy0A/D2EkIiGZVOVnllmP5EgjiEwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUa61FgN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D18CC4AF10;
	Fri,  7 Jun 2024 14:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717771989;
	bh=NVd+zTYMoc6J2OMUcKwaZbTj/+f6TMT5UM+zc8YKt/w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rUa61FgNv5pJ14/LHxKtXfF8lpAdQrcAT9CN03pg7z8eBT/Vlg5fAlDoLEhtk1CjW
	 vIrUs8q+4ZVykfrOdIG4iC7csGKP5ud+3UtFVU7YN04U5BBN5W/UYAMfxX0XpLMKKR
	 hOSqzCfnI4YAPdPGZPyCKeQSKeTx8FlRHWb4DbzUw/goWHAeaoxpELyNz3YPijL/Gh
	 n+SABBoNxYBwqCT1m05SbTSuvKJ21bWN9bE3cB6RK9hHCR5U3lzmpZHMwclamnkFUh
	 KKR4l5wrmC0p8F5N/7QusRjPyyRWnWYlB3vaaaykaYfU/71ZX8snI4IcGstQwGRtwy
	 YdnjZceYm7g7g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D7BC27C6E;
	Fri,  7 Jun 2024 14:53:09 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Fri, 07 Jun 2024 17:53:11 +0300
Subject: [PATCH v7 5/9] iio: adc: ad7173: refactor ain and vref selection
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-ad4111-v7-5-97e3855900a0@analog.com>
References: <20240607-ad4111-v7-0-97e3855900a0@analog.com>
In-Reply-To: <20240607-ad4111-v7-0-97e3855900a0@analog.com>
To: Ceclan Dumitru <dumitru.ceclan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717771987; l=3945;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=9f0Vi+E6u2sww3gPlgrOmpy9ZqM0gcSKGN10c+NtFoI=;
 b=kZtZkxMai7Y0H9SWUiz6HQMYgLCr0SyEjRVTuh8pDX9pkm5FCFEpcE76cK2wjA3TRv5HAYkE8
 EJ8JzkNaJ5eDfEcQ8RBEP3QColjL9jMXh6Ot6eWG7v1qCDzB9ipGlhB
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

Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7173.c | 62 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 8631f218b69e..1257303b0cf6 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -60,6 +60,7 @@
 #define AD7173_CH_SETUP_AINPOS_MASK	GENMASK(9, 5)
 #define AD7173_CH_SETUP_AINNEG_MASK	GENMASK(4, 0)
 
+#define AD7173_NO_AINS_PER_CHANNEL	2
 #define AD7173_CH_ADDRESS(pos, neg) \
 	(FIELD_PREP(AD7173_CH_SETUP_AINPOS_MASK, pos) | \
 	 FIELD_PREP(AD7173_CH_SETUP_AINNEG_MASK, neg))
@@ -906,13 +907,48 @@ static int ad7173_register_clk_provider(struct iio_dev *indio_dev)
 					   &st->int_clk_hw);
 }
 
+static int ad7173_validate_voltage_ain_inputs(struct ad7173_state *st,
+					      unsigned int ain0, unsigned int ain1)
+{
+	struct device *dev = &st->sd.spi->dev;
+
+	if (ain0 >= st->info->num_inputs ||
+	    ain1 >= st->info->num_inputs)
+		return dev_err_probe(dev, -EINVAL,
+				     "Input pin number out of range for pair (%d %d).\n",
+				     ain0, ain1);
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
+		return dev_err_probe(dev, ret, "Cannot use reference %u\n",
+				     ref_sel);
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
@@ -966,11 +1002,9 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		if (ret)
 			return ret;
 
-		if (ain[0] >= st->info->num_inputs ||
-		    ain[1] >= st->info->num_inputs)
-			return dev_err_probe(dev, -EINVAL,
-				"Input pin number out of range for pair (%d %d).\n",
-				ain[0], ain[1]);
+		ret = ad7173_validate_voltage_ain_inputs(st, ain[0], ain[1]);
+		if (ret)
+			return ret;
 
 		ret = fwnode_property_match_property_string(child,
 							    "adi,reference-select",
@@ -981,19 +1015,9 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
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



