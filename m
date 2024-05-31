Return-Path: <linux-iio+bounces-5559-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 708D78D69F7
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 21:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB0D91F28815
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 19:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083BF17E443;
	Fri, 31 May 2024 19:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4cPIUg8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCAB17D341;
	Fri, 31 May 2024 19:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717184571; cv=none; b=pW0biCmqVQ6Ui+zJfVM3YDBRmy/e61JP/xncHNDBHlOvOWqAGsNNhnPXT4J0NnrPT0vCdd37Fa5F+tqUACOArL5WiZobT1RwbzN5E1B/k6GHOYJnzLPSnUikimDHtyEx4UK7T/NECHiHGjVwpjpRWu0v86+2BNGLucPefT2+lOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717184571; c=relaxed/simple;
	bh=M1LcMgmmfpY2D4207JTUEyEzHZwxRlMHXw5z2scj/Oc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qhJSJ/HonT9pSiMEJkEF3rGqbWeWVwm32YiFXwmxI6HyMaR2oYGyTbVVKtKBrvSQ0CNIYuW7+z14bSV7yJx/bJEAqyQrfJPAoCGVLSrH+E9YwWmXqUGHWnoONVcDw3i9a4zwBBd2i5o1VFgdnRAgj9ns6IgCK8Ux8AlfKZmkGWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4cPIUg8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D2FFC4AF17;
	Fri, 31 May 2024 19:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717184571;
	bh=M1LcMgmmfpY2D4207JTUEyEzHZwxRlMHXw5z2scj/Oc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=h4cPIUg8tvUfcPA6XZ4wEHVMAEC4CbNHWvEpcBl8z992GCJCa7Dwg2F4PG8xBnW3f
	 3gpvObwgSZsgP4NHpHRhjY6+z5ajakmvvECHKq6GVWTWt/0hXjSIbBSvklNXVFOwgI
	 Zjz03iZInMPm302SGTeBcQbe8gzYphe7UMPk3UtMwUoB39G1Ckti1MdM4jq9U9TZFw
	 Ets1xAYZx1EUAiSMv9VapVYltk4dm1YEICJMgt7gOsPyTVDfY68NLiidR5GNvZ7x6s
	 MFQOmfP9V6J11+AtslpZVEmiswFCvFDIbGfDiv8jigSEOc+Cmh5QHbamrS9rK2ICR4
	 pIsKKkwZxV4aw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2B7C27C50;
	Fri, 31 May 2024 19:42:51 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Fri, 31 May 2024 22:42:31 +0300
Subject: [PATCH v4 5/6] iio: adc: ad7173: refactor device info structs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-ad4111-v4-5-64607301c057@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717184569; l=9509;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=RCX3Uz+DiXHXyd/q5TMDm1Ci7vN+X3ks6WalypeIWPs=;
 b=yrUXe7DKclgkoK4krd0WMdGy1JW/vd6D0gaHhIl7hemmldgRFzLGCCAqB73oNwipnHBFFVyze
 mWljF2CzCUcAdbEL/0gBxyJwFIuemAcb6clSnCie25xj21VXMUR+Wq+
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
index ebfd2d5f9632..ed8ff8c5f343 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -129,16 +129,6 @@
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
@@ -211,115 +201,119 @@ static const unsigned int ad7175_sinc5_data_rates[] = {
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
@@ -1190,32 +1184,25 @@ static int ad7173_probe(struct spi_device *spi)
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



