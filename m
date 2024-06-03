Return-Path: <linux-iio+bounces-5695-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E35BB8D8730
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 18:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133501C21D0B
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 16:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223C6137901;
	Mon,  3 Jun 2024 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lw71WG/6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68A51369A1;
	Mon,  3 Jun 2024 16:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717431794; cv=none; b=g09Ckby21M5z5+A6hu8PpT0AJvmWMvFE/Oze0H7bEswpfTqPme2BiQMrxxDMNBx++ktmIKNz8zsBi2uTL+wQTROkezp5bP8dNa40L3G3ONmnTbVp0Idt6+ZSiqWwsI8cdgwQiKBN5xm6k+mkDVU/8tmuVnp9ypYEqYJk+FHiLwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717431794; c=relaxed/simple;
	bh=AZw7l4/SRW4xiGFqRImwz1EBYMgqyPOy3M18YVuOpQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s7JHp2sDluag38w2U59RL+9jUDTdYpnBHjPMcwbg1j+bpKp6un/o6KmLLt9noIOkv9PhXIMicIE025dcbux8DUbPO2oQkI4QX8zd8wzLb77Y/jpOWx2cyOniLnMybNcR9azmulnZwI4HvGPV9KDakYkx3TdQjk6AUC+lUe0MZAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lw71WG/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DFCAC4AF1B;
	Mon,  3 Jun 2024 16:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717431794;
	bh=AZw7l4/SRW4xiGFqRImwz1EBYMgqyPOy3M18YVuOpQ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lw71WG/6T/WixFA0kP/MDxws9zNoEXdyjpsDDrRMae13kTkhuyaveDGDt8Ob4kHq/
	 pOkJKQ3sqkSeFFwrSCmWvnpEY7NA+zBNYWigSXoKf+mCvntCRaYyk9dQQV/m3s0nwE
	 80pldGH7Dksv+a0dUUIkxVpa/uoinbYJwBQ7bP29/jcIVxlONP3pK8JEjAmrLMHUjW
	 k1dCxg7qn43KTPuv2lf/EWYxrybRM4pIG7La28qFCS8jCgoBKfbifAarayPKXopS+j
	 h+FU08+Z5dUk5UKUe2VgDvWlfY2E51GMScoVP9ouq7omqpo4k5zjU2MvVC7DhGzCUm
	 0HzKH8+MZmSsQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D7EC27C52;
	Mon,  3 Jun 2024 16:23:14 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Mon, 03 Jun 2024 19:23:04 +0300
Subject: [PATCH v5 6/9] iio: adc: ad7173: add support for special inputs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240603-ad4111-v5-6-9a9c54d9ac78@analog.com>
References: <20240603-ad4111-v5-0-9a9c54d9ac78@analog.com>
In-Reply-To: <20240603-ad4111-v5-0-9a9c54d9ac78@analog.com>
To: Ceclan Dumitru <dumitru.ceclan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717431792; l=4367;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=bRE3qYBUi2MhWS4l41aYscXn5nV81b7PK9EKPErwNCo=;
 b=c+Oy5u/dffBwokkQECvnCDqgXIdwP1MHbduxXCtjliOqj0561YUTnSD6iowUtUKEceBJda2ck
 uDl5VwygkIGB2IyEElMSH5pAa1BthqZiJ93mLcmhrQGDnmW5idb8W68
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
 drivers/iio/adc/ad7173.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 4040edbd1c32..4cff3eda5a6b 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -66,6 +66,15 @@
 	 FIELD_PREP(AD7173_CH_SETUP_AINNEG_MASK, neg))
 #define AD7173_AIN_TEMP_POS	17
 #define AD7173_AIN_TEMP_NEG	18
+#define AD7173_AIN_COM_IN_POS	19
+#define AD7173_AIN_COM_IN_NEG	20
+#define AD7173_AIN_REF_POS	21
+#define AD7173_AIN_REF_NEG	22
+
+#define AD7173_IS_REF_INPUT(x)		((x) == AD7173_AIN_REF_POS || \
+					(x) == AD7173_AIN_REF_NEG)
+#define AD7173_IS_COM_INPUT(x)		((x) == AD7173_AIN_COM_IN_POS || \
+					(x) == AD7173_AIN_COM_IN_NEG)
 
 #define AD7172_2_ID			0x00d0
 #define AD7175_ID			0x0cd0
@@ -146,6 +155,8 @@ struct ad7173_device_info {
 	unsigned int id;
 	char *name;
 	bool has_temp;
+	/* ((AVDD1 − AVSS)/5) */
+	bool has_common_input;
 	bool has_input_buf;
 	bool has_int_ref;
 	bool has_ref2;
@@ -216,6 +227,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.has_temp = true,
 		.has_input_buf = true,
 		.has_int_ref = true,
+		.has_common_input = true,
 		.clock = 2 * HZ_PER_MHZ,
 		.sinc5_data_rates = ad7173_sinc5_data_rates,
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
@@ -230,6 +242,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.has_temp = false,
 		.has_input_buf = true,
 		.has_ref2 = true,
+		.has_common_input = true,
 		.clock = 2 * HZ_PER_MHZ,
 		.sinc5_data_rates = ad7173_sinc5_data_rates,
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
@@ -245,6 +258,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.has_input_buf = true,
 		.has_int_ref = true,
 		.has_ref2 = true,
+		.has_common_input = false,
 		.clock = 2 * HZ_PER_MHZ,
 		.sinc5_data_rates = ad7173_sinc5_data_rates,
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
@@ -259,6 +273,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.has_temp = true,
 		.has_input_buf = true,
 		.has_int_ref = true,
+		.has_common_input = true,
 		.clock = 16 * HZ_PER_MHZ,
 		.sinc5_data_rates = ad7175_sinc5_data_rates,
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
@@ -274,6 +289,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.has_input_buf = true,
 		.has_int_ref = true,
 		.has_ref2 = true,
+		.has_common_input = true,
 		.clock = 16 * HZ_PER_MHZ,
 		.sinc5_data_rates = ad7175_sinc5_data_rates,
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
@@ -288,6 +304,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.has_temp = false,
 		.has_input_buf = false,
 		.has_int_ref = true,
+		.has_common_input = false,
 		.clock = 16 * HZ_PER_MHZ,
 		.sinc5_data_rates = ad7175_sinc5_data_rates,
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
@@ -302,6 +319,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.has_temp = true,
 		.has_input_buf = true,
 		.has_int_ref = true,
+		.has_common_input = true,
 		.clock = 16 * HZ_PER_MHZ,
 		.odr_start_value = AD7177_ODR_START_VALUE,
 		.sinc5_data_rates = ad7175_sinc5_data_rates,
@@ -914,9 +932,15 @@ static int ad7173_validate_voltage_ain_inputs(struct ad7173_state *st,
 					      unsigned int ain0, unsigned int ain1)
 {
 	struct device *dev = &st->sd.spi->dev;
+	bool special_input0, special_input1;
+
+	special_input0 = AD7173_IS_REF_INPUT(ain0) ||
+			(AD7173_IS_COM_INPUT(ain0) && st->info->has_common_input);
+	special_input1 = AD7173_IS_REF_INPUT(ain1) ||
+			(AD7173_IS_COM_INPUT(ain1) && st->info->has_common_input);
 
-	if (ain0 >= st->info->num_inputs ||
-	    ain1 >= st->info->num_inputs)
+	if ((ain0 >= st->info->num_inputs && !special_input0) ||
+	    (ain1 >= st->info->num_inputs && !special_input1))
 		return dev_err_probe(dev, -EINVAL,
 				     "Input pin number out of range for pair (%d %d).\n",
 				     ain0, ain1);

-- 
2.43.0



