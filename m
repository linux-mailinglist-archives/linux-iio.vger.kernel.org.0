Return-Path: <linux-iio+bounces-5030-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC818C4CD1
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 09:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D80E1C20D78
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 07:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593C02BCF7;
	Tue, 14 May 2024 07:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pa33e/fI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCD320DC8;
	Tue, 14 May 2024 07:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715671399; cv=none; b=vF2IPN7U0IFQWfZozZ2a8opVc705gKsLPShRb0D/XYdJQJocgFozv7QIvGx3kq1kRwr9D02y1vXzE37jmbUXfo08yHmlXFG0TnSWi76UtY9Ipmq124qK7ZA8wwEbzpR0L0judgz8kknAK0eYy8S9xeh7JqWwf9mnPvhAkasnfvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715671399; c=relaxed/simple;
	bh=C5kNeRF0fjlzbyKB5kgQ94Y9IwMiOQIyMWEdVrQHiM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TNH6DQJA1FXS5CaSRsykyJGtKJHa3Kj0LyysPbg40dzPmRjqQoYrc0aYUix6nZUwPolMJWREwe45vDtFNbkOghWQy6aV8owROgpUS0FMDl7mTuBEEMMMRCCVtCQZMpSrmuNvYLJ7axAh44FJSNPsmegJTdOIwcBtHGvJSmn4Xsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pa33e/fI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75E62C4AF18;
	Tue, 14 May 2024 07:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715671398;
	bh=C5kNeRF0fjlzbyKB5kgQ94Y9IwMiOQIyMWEdVrQHiM4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pa33e/fIIiqSzouN0QP4BpV2fI3st58px79WFqPqwFUvk4vLZJZPGllNfSk0IMFxX
	 Lqa54zG7jjKqOo0ZOTGw54jd1zGdfSDAU10bWLk+LY6BIkk0tBpKdMWUiNi7WAF70Z
	 GRVzgrdMKv4ejUuZUDRQ3+adK2BwY+N72ymfipMClDZ/pvyga0BVY6YJZdigNbKacg
	 e6R12Ec+0Y5SUgn+7F4HNdkxfOwSMJ1/3caAmmVu1Ynb5oCsLKb/wrV/+tlhBdzoN3
	 ckeFlqPSsyRFAMnlaKgy8fbarPxWExW1JIHBdJMi98Mg9hM8rj3c/5ovPzU07diGvS
	 DXQqUZ7tBOC4w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64587C25B7C;
	Tue, 14 May 2024 07:23:18 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Tue, 14 May 2024 10:22:50 +0300
Subject: [PATCH v2 5/9] iio: adc: ad7173: add support for special inputs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240514-ad4111-v2-5-29be6a55efb5@analog.com>
References: <20240514-ad4111-v2-0-29be6a55efb5@analog.com>
In-Reply-To: <20240514-ad4111-v2-0-29be6a55efb5@analog.com>
To: Ceclan Dumitru <dumitru.ceclan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715671396; l=3852;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=1Uhyl9BcsVFq4jk+4BvPYG89rnBSYbQT8Qh5MOp47mY=;
 b=ePvDJ8e+5VNgkHCxA8dSG1zcSgt5yuDJgs5NdyfD1WtUVWYwYH2JgXBR2ivSebQlbX+Ii309p
 reONiAIrcx7DlJ4TTERPVyGklVXmYFquQ0hbVd0ekUPR9L5WDeKazfY
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
 drivers/iio/adc/ad7173.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index fb33534d63a9..1e9ba3070770 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -65,6 +65,10 @@
 	 FIELD_PREP(AD7173_CH_SETUP_AINNEG_MASK, neg))
 #define AD7173_AIN_TEMP_POS	17
 #define AD7173_AIN_TEMP_NEG	18
+#define AD7173_AIN_COM_IN_POS	19
+#define AD7173_AIN_COM_IN_NEG	20
+#define AD7173_AIN_REF_POS	21
+#define AD7173_AIN_REF_NEG	22
 
 #define AD7172_2_ID			0x00d0
 #define AD7175_ID			0x0cd0
@@ -145,6 +149,8 @@ struct ad7173_device_info {
 	unsigned int id;
 	char *name;
 	bool has_temp;
+	/* ((AVDD1 − AVSS)/5) */
+	bool has_common_input;
 	bool has_input_buf;
 	bool has_int_ref;
 	bool has_ref2;
@@ -215,6 +221,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.has_temp = true,
 		.has_input_buf = true,
 		.has_int_ref = true,
+		.has_common_input = true,
 		.clock = 2 * HZ_PER_MHZ,
 		.sinc5_data_rates = ad7173_sinc5_data_rates,
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
@@ -228,6 +235,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.has_temp = false,
 		.has_input_buf = true,
 		.has_ref2 = true,
+		.has_common_input = true,
 		.clock = 2 * HZ_PER_MHZ,
 		.sinc5_data_rates = ad7173_sinc5_data_rates,
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
@@ -243,6 +251,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.has_input_buf = true,
 		.has_int_ref = true,
 		.has_ref2 = true,
+		.has_common_input = false,
 		.clock = 2 * HZ_PER_MHZ,
 		.sinc5_data_rates = ad7173_sinc5_data_rates,
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
@@ -257,6 +266,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.has_temp = true,
 		.has_input_buf = true,
 		.has_int_ref = true,
+		.has_common_input = true,
 		.clock = 16 * HZ_PER_MHZ,
 		.sinc5_data_rates = ad7175_sinc5_data_rates,
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
@@ -271,6 +281,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.has_input_buf = true,
 		.has_int_ref = true,
 		.has_ref2 = true,
+		.has_common_input = true,
 		.clock = 16 * HZ_PER_MHZ,
 		.sinc5_data_rates = ad7175_sinc5_data_rates,
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
@@ -285,6 +296,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.has_temp = false,
 		.has_input_buf = false,
 		.has_int_ref = true,
+		.has_common_input = false,
 		.clock = 16 * HZ_PER_MHZ,
 		.sinc5_data_rates = ad7175_sinc5_data_rates,
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
@@ -298,6 +310,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.has_temp = true,
 		.has_input_buf = true,
 		.has_int_ref = true,
+		.has_common_input = true,
 		.clock = 16 * HZ_PER_MHZ,
 		.odr_start_value = AD7177_ODR_START_VALUE,
 		.sinc5_data_rates = ad7175_sinc5_data_rates,
@@ -920,6 +933,14 @@ static int ad7173_validate_voltage_ain_inputs(struct ad7173_state *st,
 		if (ain[i] < st->info->num_inputs)
 			continue;
 
+		if (ain[i] == AD7173_AIN_REF_POS || ain[i] == AD7173_AIN_REF_NEG)
+			continue;
+
+		if ((ain[i] == AD7173_AIN_COM_IN_POS ||
+		     ain[i] == AD7173_AIN_COM_IN_NEG) &&
+		    st->info->has_common_input)
+			continue;
+
 		return dev_err_probe(dev, -EINVAL,
 			"Input pin number out of range for pair (%d %d).\n",
 			ain[0], ain[1]);

-- 
2.43.0



