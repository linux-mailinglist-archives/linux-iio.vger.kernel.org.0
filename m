Return-Path: <linux-iio+bounces-6017-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 447159007DB
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 16:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9AA01F2202B
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 14:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3485F1A01C3;
	Fri,  7 Jun 2024 14:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DS9XdsIZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B684C19FA77;
	Fri,  7 Jun 2024 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771989; cv=none; b=H2AyizIe7OkZlwWofTfdaYW5edmGVolgppMRtfWQZVgElNAN2CUoTOQhkjVyewrA5+edyntKUgBwU8wpbs3HSFq1yTbDLsoPofVuvt64Asc5Zkjy3vD7Kr3MC4DcI3+bbSCf2tXWJa9CLskWtr2R8WiQsfEs+OxiGEujmlOArOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771989; c=relaxed/simple;
	bh=q9U+q/Tpgil3587Qi4S8SMSi/Ij1DKJHz3EHHMrlc4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kVPCXsxVRb63b1uLmlcMSkLLTWX3ZHljw34ipwfaaSU3cLA4NsN6qfFyk+zr+/KA5tKJmJvnM7GAErSg1bu/Zep96WEM6NhCmLoZ2PBaABAFbcK566AQ7sjtcChNgcdBbzrVgArSxExwjDkWLioQNQbdV+0sWXq/SIbDM2Yt4aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DS9XdsIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B2A3C4AF17;
	Fri,  7 Jun 2024 14:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717771989;
	bh=q9U+q/Tpgil3587Qi4S8SMSi/Ij1DKJHz3EHHMrlc4U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DS9XdsIZwkCw1QwcAmbxrtN3zTGKBWnUCoidzH3AeFfQnbgTXqz7mWnedtKCMnF79
	 2dOBreS74RqR1e7mDXKdjyPBKYkBUmjJ/g0+13Ao2b68ibmuu+LtOi+VK/8H88oAWM
	 9JSvJxFeIPcZxKQyFh/3R35L6+OoXSnRlkY8BkFL41nJwnYSn+RPIiubLEWtVXrXKR
	 GOw5lVfOC5b6LM2L3cFh5UyubIleIJmIIs+qEwBYqNoOHRS2QjJmoZEHZEX4rBzGfx
	 qXASvtftBNeREylB2VfxbT0XzfSPiE4rPc7VtZ4FJC6BYifZSgZZXjkIpx8t4CUYWN
	 DTiLkTaJ8HTVA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625CFC27C5F;
	Fri,  7 Jun 2024 14:53:09 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Fri, 07 Jun 2024 17:53:12 +0300
Subject: [PATCH v7 6/9] iio: adc: ad7173: add support for special inputs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240607-ad4111-v7-6-97e3855900a0@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717771987; l=3699;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=GJSw/btckEmYwTEqWgTcPfwKf/O3c5v2N9fDPcBA2Nw=;
 b=Frd2TOuIV3m5a1aayw75eQfuNvHk65o1YPjdRSox1WiOUmiK6v/CqYidLry4PHg/2on/WsN+C
 RB0b+NKspYBDqYJuqQ8JI8zH5k1hnpa7wcu3Jg/UaIXgA5i+JhV9fGQ
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

From: Dumitru Ceclan <dumitru.ceclan@analog.com>

 Add support for selecting REF+ and REF- inputs on all models.
 Add support for selecting ((AVDD1 − AVSS)/5) inputs
  on supported models.

Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7173.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 1257303b0cf6..ca96a9aeec4b 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -66,6 +66,13 @@
 	 FIELD_PREP(AD7173_CH_SETUP_AINNEG_MASK, neg))
 #define AD7173_AIN_TEMP_POS	17
 #define AD7173_AIN_TEMP_NEG	18
+#define AD7173_AIN_POW_MON_POS	19
+#define AD7173_AIN_POW_MON_NEG	20
+#define AD7173_AIN_REF_POS	21
+#define AD7173_AIN_REF_NEG	22
+
+#define AD7173_IS_REF_INPUT(x)		((x) == AD7173_AIN_REF_POS || \
+					(x) == AD7173_AIN_REF_NEG)
 
 #define AD7172_2_ID			0x00d0
 #define AD7175_ID			0x0cd0
@@ -146,6 +153,8 @@ struct ad7173_device_info {
 	unsigned int id;
 	char *name;
 	bool has_temp;
+	/* ((AVDD1 − AVSS)/5) */
+	bool has_pow_supply_monitoring;
 	bool has_input_buf;
 	bool has_int_ref;
 	bool has_ref2;
@@ -216,6 +225,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.has_temp = true,
 		.has_input_buf = true,
 		.has_int_ref = true,
+		.has_pow_supply_monitoring = true,
 		.clock = 2 * HZ_PER_MHZ,
 		.sinc5_data_rates = ad7173_sinc5_data_rates,
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
@@ -230,6 +240,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.has_temp = false,
 		.has_input_buf = true,
 		.has_ref2 = true,
+		.has_pow_supply_monitoring = true,
 		.clock = 2 * HZ_PER_MHZ,
 		.sinc5_data_rates = ad7173_sinc5_data_rates,
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
@@ -259,6 +270,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.has_temp = true,
 		.has_input_buf = true,
 		.has_int_ref = true,
+		.has_pow_supply_monitoring = true,
 		.clock = 16 * HZ_PER_MHZ,
 		.sinc5_data_rates = ad7175_sinc5_data_rates,
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
@@ -274,6 +286,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.has_input_buf = true,
 		.has_int_ref = true,
 		.has_ref2 = true,
+		.has_pow_supply_monitoring = true,
 		.clock = 16 * HZ_PER_MHZ,
 		.sinc5_data_rates = ad7175_sinc5_data_rates,
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
@@ -302,6 +315,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.has_temp = true,
 		.has_input_buf = true,
 		.has_int_ref = true,
+		.has_pow_supply_monitoring = true,
 		.clock = 16 * HZ_PER_MHZ,
 		.odr_start_value = AD7177_ODR_START_VALUE,
 		.sinc5_data_rates = ad7175_sinc5_data_rates,
@@ -911,9 +925,18 @@ static int ad7173_validate_voltage_ain_inputs(struct ad7173_state *st,
 					      unsigned int ain0, unsigned int ain1)
 {
 	struct device *dev = &st->sd.spi->dev;
+	bool special_input0, special_input1;
+
+	/* (AVDD1-AVSS)/5 power supply monitoring */
+	if (ain0 == AD7173_AIN_POW_MON_POS && ain1 == AD7173_AIN_POW_MON_NEG &&
+	    st->info->has_pow_supply_monitoring)
+		return 0;
+
+	special_input0 = AD7173_IS_REF_INPUT(ain0);
+	special_input1 = AD7173_IS_REF_INPUT(ain1);
 
-	if (ain0 >= st->info->num_inputs ||
-	    ain1 >= st->info->num_inputs)
+	if ((ain0 >= st->info->num_inputs && !special_input0) ||
+	    (ain1 >= st->info->num_inputs && !special_input1))
 		return dev_err_probe(dev, -EINVAL,
 				     "Input pin number out of range for pair (%d %d).\n",
 				     ain0, ain1);

-- 
2.43.0



