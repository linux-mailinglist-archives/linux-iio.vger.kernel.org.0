Return-Path: <linux-iio+bounces-652-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34418805AB5
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 18:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3F35281EE6
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 17:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDFB692B0;
	Tue,  5 Dec 2023 17:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0J/Tqh4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877BF692A3
	for <linux-iio@vger.kernel.org>; Tue,  5 Dec 2023 17:06:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15380C43395;
	Tue,  5 Dec 2023 17:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701796006;
	bh=zzUdDaQ/rSOdbkrMPGJRubpYY5Nh8A9hKPMOMeoLg9A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=X0J/Tqh4b39nYELFXFtKkC27OWse5xBu9avi+2aKLRgU7MPG9l4ck2EWUv5UV/mOU
	 /61ZK/JCwKKrZn8hngaAogZ2u324JUuAEr9qfAsnMGXl/F0ZHE4Sngk6d0D8XHr12L
	 eym2foFXYujVsEf3gjP2lG/KsOI6gl0YisSKC3zOce2hi7F7zdRh5S8y9XZN8wVEve
	 tAattac43WBcJ1wCBt7lBAxdpqTEYUwX/IErqWburZt4UHlyqhyjTvS8lLto443OK/
	 b6N4wNxgu0ZXYRINOVkwP+TCXg2x2dREr4+jiCM5zBaQKt+d8APm/T+SfkIVujgMgX
	 QJLGmAZEGIrbg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01810C10F07;
	Tue,  5 Dec 2023 17:06:46 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 05 Dec 2023 18:06:46 +0100
Subject: [PATCH 6/8] iio: adc: ad9467: use chip_info variables instead of
 array
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-iio-backend-prep-v1-6-7c9bc18d612b@analog.com>
References: <20231205-iio-backend-prep-v1-0-7c9bc18d612b@analog.com>
In-Reply-To: <20231205-iio-backend-prep-v1-0-7c9bc18d612b@analog.com>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701796004; l=4457;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=xePLVqcepEDlqcSx8DAfd33YoMuOTS8NXIi6omM4F+k=;
 b=fIauLChM7xfvh/Vx4qegvsJQUI9StprY4XT6Zys52EIvYCNOGv8VMKX79yAHhR7iP0wWNodaM
 oO62K6+KF9oAQyuJ+ispbgjmzjdZrcnemdsV0BBtasphfSL0z82AVva
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

Instead of having an array and keeping IDs for each entry of the array,
just have a chip_info struct per device.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad9467.c | 89 +++++++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 46 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 6bdbd0ea8d6c..0d075e6b6248 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -101,12 +101,6 @@
 #define AD9467_DEF_OUTPUT_MODE		0x08
 #define AD9467_REG_VREF_MASK		0x0F
 
-enum {
-	ID_AD9265,
-	ID_AD9434,
-	ID_AD9467,
-};
-
 struct ad9467_chip_info {
 	struct adi_axi_adc_chip_info	axi_adc_info;
 	unsigned int			default_output_mode;
@@ -234,43 +228,46 @@ static const struct iio_chan_spec ad9467_channels[] = {
 	AD9467_CHAN(0, 0, 16, 'S'),
 };
 
-static const struct ad9467_chip_info ad9467_chip_tbl[] = {
-	[ID_AD9265] = {
-		.axi_adc_info = {
-			.id = CHIPID_AD9265,
-			.max_rate = 125000000UL,
-			.scale_table = ad9265_scale_table,
-			.num_scales = ARRAY_SIZE(ad9265_scale_table),
-			.channels = ad9467_channels,
-			.num_channels = ARRAY_SIZE(ad9467_channels),
-		},
-		.default_output_mode = AD9265_DEF_OUTPUT_MODE,
-		.vref_mask = AD9265_REG_VREF_MASK,
+static const struct ad9467_chip_info ad9467_chip_tbl = {
+	.axi_adc_info = {
+		.name = "ad9467",
+		.id = CHIPID_AD9467,
+		.max_rate = 250000000UL,
+		.scale_table = ad9467_scale_table,
+		.num_scales = ARRAY_SIZE(ad9467_scale_table),
+		.channels = ad9467_channels,
+		.num_channels = ARRAY_SIZE(ad9467_channels),
 	},
-	[ID_AD9434] = {
-		.axi_adc_info = {
-			.id = CHIPID_AD9434,
-			.max_rate = 500000000UL,
-			.scale_table = ad9434_scale_table,
-			.num_scales = ARRAY_SIZE(ad9434_scale_table),
-			.channels = ad9434_channels,
-			.num_channels = ARRAY_SIZE(ad9434_channels),
-		},
-		.default_output_mode = AD9434_DEF_OUTPUT_MODE,
-		.vref_mask = AD9434_REG_VREF_MASK,
+	.default_output_mode = AD9467_DEF_OUTPUT_MODE,
+	.vref_mask = AD9467_REG_VREF_MASK,
+};
+
+static const struct ad9467_chip_info ad9434_chip_tbl = {
+	.axi_adc_info = {
+		.name = "ad9434",
+		.id = CHIPID_AD9434,
+		.max_rate = 500000000UL,
+		.scale_table = ad9434_scale_table,
+		.num_scales = ARRAY_SIZE(ad9434_scale_table),
+		.channels = ad9434_channels,
+		.num_channels = ARRAY_SIZE(ad9434_channels),
 	},
-	[ID_AD9467] = {
-		.axi_adc_info = {
-			.id = CHIPID_AD9467,
-			.max_rate = 250000000UL,
-			.scale_table = ad9467_scale_table,
-			.num_scales = ARRAY_SIZE(ad9467_scale_table),
-			.channels = ad9467_channels,
-			.num_channels = ARRAY_SIZE(ad9467_channels),
-		},
-		.default_output_mode = AD9467_DEF_OUTPUT_MODE,
-		.vref_mask = AD9467_REG_VREF_MASK,
+	.default_output_mode = AD9434_DEF_OUTPUT_MODE,
+	.vref_mask = AD9434_REG_VREF_MASK,
+};
+
+static const struct ad9467_chip_info ad9265_chip_tbl = {
+	.axi_adc_info = {
+		.name = "ad9265",
+		.id = CHIPID_AD9265,
+		.max_rate = 125000000UL,
+		.scale_table = ad9265_scale_table,
+		.num_scales = ARRAY_SIZE(ad9265_scale_table),
+		.channels = ad9467_channels,
+		.num_channels = ARRAY_SIZE(ad9467_channels),
 	},
+	.default_output_mode = AD9265_DEF_OUTPUT_MODE,
+	.vref_mask = AD9265_REG_VREF_MASK,
 };
 
 static int ad9467_get_scale(struct adi_axi_adc_conv *conv, int *val, int *val2)
@@ -506,17 +503,17 @@ static int ad9467_probe(struct spi_device *spi)
 }
 
 static const struct of_device_id ad9467_of_match[] = {
-	{ .compatible = "adi,ad9265", .data = &ad9467_chip_tbl[ID_AD9265], },
-	{ .compatible = "adi,ad9434", .data = &ad9467_chip_tbl[ID_AD9434], },
-	{ .compatible = "adi,ad9467", .data = &ad9467_chip_tbl[ID_AD9467], },
+	{ .compatible = "adi,ad9265", .data = &ad9265_chip_tbl, },
+	{ .compatible = "adi,ad9434", .data = &ad9434_chip_tbl, },
+	{ .compatible = "adi,ad9467", .data = &ad9467_chip_tbl, },
 	{}
 };
 MODULE_DEVICE_TABLE(of, ad9467_of_match);
 
 static const struct spi_device_id ad9467_ids[] = {
-	{ "ad9265", (kernel_ulong_t)&ad9467_chip_tbl[ID_AD9265] },
-	{ "ad9434", (kernel_ulong_t)&ad9467_chip_tbl[ID_AD9434] },
-	{ "ad9467", (kernel_ulong_t)&ad9467_chip_tbl[ID_AD9467] },
+	{ "ad9265", (kernel_ulong_t)&ad9265_chip_tbl },
+	{ "ad9434", (kernel_ulong_t)&ad9434_chip_tbl },
+	{ "ad9467", (kernel_ulong_t)&ad9467_chip_tbl },
 	{}
 };
 MODULE_DEVICE_TABLE(spi, ad9467_ids);

-- 
2.43.0


