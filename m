Return-Path: <linux-iio+bounces-5696-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5A68D8732
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 18:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97FE01F26909
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 16:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23980137904;
	Mon,  3 Jun 2024 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+EftQgc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69391369A3;
	Mon,  3 Jun 2024 16:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717431794; cv=none; b=p5CpVbMZ6+cBLsDoaMl8jduX0uw6zLq+MUdbJFYOe4d0ProxlIz7sbvneolyPZEDHcwekCw1EoUvJx+70KjSZLugkm2XQMQv/EOWQ746fbkfZFkxzsGf1V/PlnJRX34i21+nwTptm8iDZw19gOGiTK9TlUxDY7H6OegOjEzhFXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717431794; c=relaxed/simple;
	bh=3uoTLGExFhw8T/5yZSVqsReGZtzdIcbvOL1A/cA7iY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Per0ob1BXZRCtLqTlWCc052ah//FLhiAYjdrw3sx8jVmxm7aITf0aLGsCUlgR8daFpvzBtD+/mmvxSZJQJw9RT90qRaOTjdSq7c31SqRjEDP7fKoFtz1NQmL6w16Dokarv+uq6Rr8yv0J5tVpvtA7hI1EALhu3aUzfrPh2CbCxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+EftQgc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EC35C4AF48;
	Mon,  3 Jun 2024 16:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717431794;
	bh=3uoTLGExFhw8T/5yZSVqsReGZtzdIcbvOL1A/cA7iY8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=i+EftQgcB63QT6H/lN8yGwdIoMir9cy+nb1SLgNlvBI55VWXUXyYF+ksG27YWqCmh
	 2JL1nuRF/2kGuQhlXWCvR7KS6OihyBFJRRieKDYCsJPYV0voLR9w8jtZfe+w88FUci
	 hlU9Ljjew4qnZ3lfbbO3K7OfipPXcZo5y/NNSo/M1TMkqXM1rBBnFucK/7zbIQRnB1
	 Toowr2qif1QBycfceuZiw4Ir8yhdwPyFQ2O8EPxqkSy7Z6AWt6z3HJX70KTJKHLaAa
	 9qicsWqKmsIaWZuu2D8OqnZbwQsqAGcmeWvCJ57mIIRoNisTlYyY0q1NxsGWJHB+vA
	 P1PO2URYkdCtA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383CEC25B76;
	Mon,  3 Jun 2024 16:23:14 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Mon, 03 Jun 2024 19:23:05 +0300
Subject: [PATCH v5 7/9] iio: adc: ad7173: refactor device info structs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240603-ad4111-v5-7-9a9c54d9ac78@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717431792; l=9509;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=xBrHUTTNXev6rrV+QhMZtiU7E27mY9Y4lkspfZHyCHI=;
 b=5ccEfFfjzjMnoAcPJW2f3S7EiVkt1/Px9jGnYYsijv5+5gZM2nUlYSMkJcB9sWC3G3gsdh7Yp
 NMe6ICnD7ZFCUIt4le3BMbQnjKSeNJNPChJo5z59KCuG0zbULZN5q6h
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

From: Dumitru Ceclan <dumitru.ceclan@analog.com>

Drop array of device info structs and use individual structs for all;
drop models enum as no longer needed. This improves readability as the
structs are pointed directly.

Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7173.c | 267 ++++++++++++++++++++++-------------------------
 1 file changed, 127 insertions(+), 140 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 4cff3eda5a6b..5ade166814d7 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -134,16 +134,6 @@
 #define AD7173_FILTER_ODR0_MASK		GENMASK(5, 0)
 #define AD7173_MAX_CONFIGS		8
 
-enum ad7173_ids {
-	ID_AD7172_2,
-	ID_AD7172_4,
-	ID_AD7173_8,
-	ID_AD7175_2,
-	ID_AD7175_8,
-	ID_AD7176_2,
-	ID_AD7177_2,
-};
-
 struct ad7173_device_info {
 	const unsigned int *sinc5_data_rates;
 	unsigned int num_sinc5_data_rates;
@@ -216,115 +206,119 @@ static const unsigned int ad7175_sinc5_data_rates[] = {
 	5000,					/* 20    */
 };
 
-static const struct ad7173_device_info ad7173_device_info[] = {
-	[ID_AD7172_2] = {
-		.name = "ad7172-2",
-		.id = AD7172_2_ID,
-		.num_inputs = 5,
-		.num_channels = 4,
-		.num_configs = 4,
-		.num_gpios = 2,
-		.has_temp = true,
-		.has_input_buf = true,
-		.has_int_ref = true,
-		.has_common_input = true,
-		.clock = 2 * HZ_PER_MHZ,
-		.sinc5_data_rates = ad7173_sinc5_data_rates,
-		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
-	},
-	[ID_AD7172_4] = {
-		.name = "ad7172-4",
-		.id = AD7172_4_ID,
-		.num_inputs = 9,
-		.num_channels = 8,
-		.num_configs = 8,
-		.num_gpios = 4,
-		.has_temp = false,
-		.has_input_buf = true,
-		.has_ref2 = true,
-		.has_common_input = true,
-		.clock = 2 * HZ_PER_MHZ,
-		.sinc5_data_rates = ad7173_sinc5_data_rates,
-		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
-	},
-	[ID_AD7173_8] = {
-		.name = "ad7173-8",
-		.id = AD7173_ID,
-		.num_inputs = 17,
-		.num_channels = 16,
-		.num_configs = 8,
-		.num_gpios = 4,
-		.has_temp = true,
-		.has_input_buf = true,
-		.has_int_ref = true,
-		.has_ref2 = true,
-		.has_common_input = false,
-		.clock = 2 * HZ_PER_MHZ,
-		.sinc5_data_rates = ad7173_sinc5_data_rates,
-		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
-	},
-	[ID_AD7175_2] = {
-		.name = "ad7175-2",
-		.id = AD7175_2_ID,
-		.num_inputs = 5,
-		.num_channels = 4,
-		.num_configs = 4,
-		.num_gpios = 2,
-		.has_temp = true,
-		.has_input_buf = true,
-		.has_int_ref = true,
-		.has_common_input = true,
-		.clock = 16 * HZ_PER_MHZ,
-		.sinc5_data_rates = ad7175_sinc5_data_rates,
-		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
-	},
-	[ID_AD7175_8] = {
-		.name = "ad7175-8",
-		.id = AD7175_8_ID,
-		.num_inputs = 17,
-		.num_channels = 16,
-		.num_configs = 8,
-		.num_gpios = 4,
-		.has_temp = true,
-		.has_input_buf = true,
-		.has_int_ref = true,
-		.has_ref2 = true,
-		.has_common_input = true,
-		.clock = 16 * HZ_PER_MHZ,
-		.sinc5_data_rates = ad7175_sinc5_data_rates,
-		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
-	},
-	[ID_AD7176_2] = {
-		.name = "ad7176-2",
-		.id = AD7176_ID,
-		.num_inputs = 5,
-		.num_channels = 4,
-		.num_configs = 4,
-		.num_gpios = 2,
-		.has_temp = false,
-		.has_input_buf = false,
-		.has_int_ref = true,
-		.has_common_input = false,
-		.clock = 16 * HZ_PER_MHZ,
-		.sinc5_data_rates = ad7175_sinc5_data_rates,
-		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
-	},
-	[ID_AD7177_2] = {
-		.name = "ad7177-2",
-		.id = AD7177_ID,
-		.num_inputs = 5,
-		.num_channels = 4,
-		.num_configs = 4,
-		.num_gpios = 2,
-		.has_temp = true,
-		.has_input_buf = true,
-		.has_int_ref = true,
-		.has_common_input = true,
-		.clock = 16 * HZ_PER_MHZ,
-		.odr_start_value = AD7177_ODR_START_VALUE,
-		.sinc5_data_rates = ad7175_sinc5_data_rates,
-		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
-	},
+static const struct ad7173_device_info ad7172_2_device_info = {
+	.name = "ad7172-2",
+	.id = AD7172_2_ID,
+	.num_inputs = 5,
+	.num_channels = 4,
+	.num_configs = 4,
+	.num_gpios = 2,
+	.has_temp = true,
+	.has_input_buf = true,
+	.has_int_ref = true,
+	.has_common_input = true,
+	.clock = 2 * HZ_PER_MHZ,
+	.sinc5_data_rates = ad7173_sinc5_data_rates,
+	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
+};
+
+static const struct ad7173_device_info ad7172_4_device_info = {
+	.name = "ad7172-4",
+	.id = AD7172_4_ID,
+	.num_inputs = 9,
+	.num_channels = 8,
+	.num_configs = 8,
+	.num_gpios = 4,
+	.has_temp = false,
+	.has_input_buf = true,
+	.has_ref2 = true,
+	.has_common_input = true,
+	.clock = 2 * HZ_PER_MHZ,
+	.sinc5_data_rates = ad7173_sinc5_data_rates,
+	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
+};
+
+static const struct ad7173_device_info ad7173_8_device_info = {
+	.name = "ad7173-8",
+	.id = AD7173_ID,
+	.num_inputs = 17,
+	.num_channels = 16,
+	.num_configs = 8,
+	.num_gpios = 4,
+	.has_temp = true,
+	.has_input_buf = true,
+	.has_int_ref = true,
+	.has_ref2 = true,
+	.has_common_input = false,
+	.clock = 2 * HZ_PER_MHZ,
+	.sinc5_data_rates = ad7173_sinc5_data_rates,
+	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
+};
+
+static const struct ad7173_device_info ad7175_2_device_info = {
+	.name = "ad7175-2",
+	.id = AD7175_2_ID,
+	.num_inputs = 5,
+	.num_channels = 4,
+	.num_configs = 4,
+	.num_gpios = 2,
+	.has_temp = true,
+	.has_input_buf = true,
+	.has_int_ref = true,
+	.has_common_input = true,
+	.clock = 16 * HZ_PER_MHZ,
+	.sinc5_data_rates = ad7175_sinc5_data_rates,
+	.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
+};
+
+static const struct ad7173_device_info ad7175_8_device_info = {
+	.name = "ad7175-8",
+	.id = AD7175_8_ID,
+	.num_inputs = 17,
+	.num_channels = 16,
+	.num_configs = 8,
+	.num_gpios = 4,
+	.has_temp = true,
+	.has_input_buf = true,
+	.has_int_ref = true,
+	.has_ref2 = true,
+	.has_common_input = true,
+	.clock = 16 * HZ_PER_MHZ,
+	.sinc5_data_rates = ad7175_sinc5_data_rates,
+	.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
+};
+
+static const struct ad7173_device_info ad7176_2_device_info = {
+	.name = "ad7176-2",
+	.id = AD7176_ID,
+	.num_inputs = 5,
+	.num_channels = 4,
+	.num_configs = 4,
+	.num_gpios = 2,
+	.has_temp = false,
+	.has_input_buf = false,
+	.has_int_ref = true,
+	.has_common_input = false,
+	.clock = 16 * HZ_PER_MHZ,
+	.sinc5_data_rates = ad7175_sinc5_data_rates,
+	.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
+};
+
+static const struct ad7173_device_info ad7177_2_device_info = {
+	.name = "ad7177-2",
+	.id = AD7177_ID,
+	.num_inputs = 5,
+	.num_channels = 4,
+	.num_configs = 4,
+	.num_gpios = 2,
+	.has_temp = true,
+	.has_input_buf = true,
+	.has_int_ref = true,
+	.has_common_input = true,
+	.clock = 16 * HZ_PER_MHZ,
+	.odr_start_value = AD7177_ODR_START_VALUE,
+	.sinc5_data_rates = ad7175_sinc5_data_rates,
+	.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
 };
 
 static const char *const ad7173_ref_sel_str[] = {
@@ -1191,32 +1185,25 @@ static int ad7173_probe(struct spi_device *spi)
 }
 
 static const struct of_device_id ad7173_of_match[] = {
-	{ .compatible = "adi,ad7172-2",
-	  .data = &ad7173_device_info[ID_AD7172_2]},
-	{ .compatible = "adi,ad7172-4",
-	  .data = &ad7173_device_info[ID_AD7172_4]},
-	{ .compatible = "adi,ad7173-8",
-	  .data = &ad7173_device_info[ID_AD7173_8]},
-	{ .compatible = "adi,ad7175-2",
-	  .data = &ad7173_device_info[ID_AD7175_2]},
-	{ .compatible = "adi,ad7175-8",
-	  .data = &ad7173_device_info[ID_AD7175_8]},
-	{ .compatible = "adi,ad7176-2",
-	  .data = &ad7173_device_info[ID_AD7176_2]},
-	{ .compatible = "adi,ad7177-2",
-	  .data = &ad7173_device_info[ID_AD7177_2]},
+	{ .compatible = "adi,ad7172-2", .data = &ad7172_2_device_info},
+	{ .compatible = "adi,ad7172-4", .data = &ad7172_4_device_info},
+	{ .compatible = "adi,ad7173-8", .data = &ad7173_8_device_info},
+	{ .compatible = "adi,ad7175-2", .data = &ad7175_2_device_info},
+	{ .compatible = "adi,ad7175-8", .data = &ad7175_8_device_info},
+	{ .compatible = "adi,ad7176-2", .data = &ad7176_2_device_info},
+	{ .compatible = "adi,ad7177-2", .data = &ad7177_2_device_info},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad7173_of_match);
 
 static const struct spi_device_id ad7173_id_table[] = {
-	{ "ad7172-2", (kernel_ulong_t)&ad7173_device_info[ID_AD7172_2]},
-	{ "ad7172-4", (kernel_ulong_t)&ad7173_device_info[ID_AD7172_4]},
-	{ "ad7173-8", (kernel_ulong_t)&ad7173_device_info[ID_AD7173_8]},
-	{ "ad7175-2", (kernel_ulong_t)&ad7173_device_info[ID_AD7175_2]},
-	{ "ad7175-8", (kernel_ulong_t)&ad7173_device_info[ID_AD7175_8]},
-	{ "ad7176-2", (kernel_ulong_t)&ad7173_device_info[ID_AD7176_2]},
-	{ "ad7177-2", (kernel_ulong_t)&ad7173_device_info[ID_AD7177_2]},
+	{ "ad7172-2", (kernel_ulong_t)&ad7172_2_device_info},
+	{ "ad7172-4", (kernel_ulong_t)&ad7172_4_device_info},
+	{ "ad7173-8", (kernel_ulong_t)&ad7173_8_device_info},
+	{ "ad7175-2", (kernel_ulong_t)&ad7175_2_device_info},
+	{ "ad7175-8", (kernel_ulong_t)&ad7175_8_device_info},
+	{ "ad7176-2", (kernel_ulong_t)&ad7176_2_device_info},
+	{ "ad7177-2", (kernel_ulong_t)&ad7177_2_device_info},
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7173_id_table);

-- 
2.43.0



