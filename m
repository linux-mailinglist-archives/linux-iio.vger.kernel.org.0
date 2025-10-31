Return-Path: <linux-iio+bounces-25740-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3A5C25020
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 13:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5E90A35114C
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 12:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E0F3491E3;
	Fri, 31 Oct 2025 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUyVfOv3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0423834845E
	for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 12:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913862; cv=none; b=NUwqoUyApNL236QinwTv7AuqPCAWtYpP00UPIqDgo4gGqo5tLEyap3BpdsK9iiqxsTG6Xu46q45laFzPZJvS4KzHaifl2lCxtQGzd5LYwPjb+7sSJwNvEEhLgMARmmX5xZCnYXVH96QvF0p7GTBoiMnzdIevAvONMhhjGyNOJgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913862; c=relaxed/simple;
	bh=V4RJzZphfKx37wj3eEA1qW+dCUIJJzMAGt2EjyBX9wc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H6g1M4FOkwX3Hnh4One82JnoeDMWkx5B2QF9++XxygdTudYKFZjYgu8AEAAawMDa7f9aV5GSzOgIAkbiaNwjzyn8FR30XFD51K62PNNov9uf97QWMVQqRIFshS+m2aPfT4Ve13+mxIG2CVr3Vr3aa9Z7QtyFm5DuFoEw8mmo+zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUyVfOv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC8B1C19423;
	Fri, 31 Oct 2025 12:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761913861;
	bh=V4RJzZphfKx37wj3eEA1qW+dCUIJJzMAGt2EjyBX9wc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rUyVfOv3ee95Vp4wuWFkZVHvoFywWH3ocRGKfpGdUM3SNrMG+XqI81z+PR1+f3/1D
	 PhMQmfiYqbP6xrtWzuIhs0jRUvAgLliFbLBzOCGbMkuelwKWRglgjyOAcJyHQ1SUU0
	 yZfP+O+PNlmfHjSj452lBhGvQP50CnGtfUVqM056jPLlXkaGd0BwpVnRqOWsfn2tZh
	 4zI0OI/SzuahGUJuTec7f+Av0fKk/i2Idwp7bb/qk474g6QBJhxgwmRSsS4PhWdQ/S
	 uf6YZvbmVkRNNV3YJQQRnZVZ9zWmcyUybWXNz5MPrX0iBc+fHCi/1nngWfCGqzixVR
	 H3i514ZbbTvkw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57F4CCFA05;
	Fri, 31 Oct 2025 12:31:01 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 31 Oct 2025 12:31:25 +0000
Subject: [PATCH v3 04/10] iio: dac: ad5446: Move to single chip_info
 structures
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251031-dev-add-ad5542-v3-4-d3541036c0e6@analog.com>
References: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
In-Reply-To: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761913895; l=12932;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=k4kpCJG6rFhM61Zoi1L74+epIGOKF+Hbsl/bqtsJOjs=;
 b=RgL68p5ajUgIPrFW7C/w2h/FUDn2ER+jxWT+7FRDiHFkjTL0s4q/IC/lNKvloItH80ymQiKKf
 ngLJ4EIr1LfBoWnfwUaR2S1sXapOx5Id72QNzFla/DrxOiyR939MSMo
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Do not use an array with an enum id kind of thing. Use the more
maintainable chip_info variable per chip.

Adapt the probe functions to use the proper helpers (for SPI and I2c).
Note that in a following patch we'll also add the chip_info variables to
the of_device_id tables. Hence already use the helpers that internally use
device_get_match_data().

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/dac/ad5446.c | 352 +++++++++++++++++++++++------------------------
 1 file changed, 176 insertions(+), 176 deletions(-)

diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index 5f9b6f82a981..54702ba43805 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -291,165 +291,161 @@ static int ad5660_write(struct ad5446_state *st, unsigned val)
  * (and a bit cryptic), however this style is used to make clear which
  * parts are supported here.
  */
-enum ad5446_supported_spi_device_ids {
-	ID_AD5300,
-	ID_AD5310,
-	ID_AD5320,
-	ID_AD5444,
-	ID_AD5446,
-	ID_AD5450,
-	ID_AD5451,
-	ID_AD5541A,
-	ID_AD5512A,
-	ID_AD5553,
-	ID_AD5600,
-	ID_AD5601,
-	ID_AD5611,
-	ID_AD5621,
-	ID_AD5641,
-	ID_AD5620_2500,
-	ID_AD5620_1250,
-	ID_AD5640_2500,
-	ID_AD5640_1250,
-	ID_AD5660_2500,
-	ID_AD5660_1250,
-	ID_AD5662,
+
+static const struct ad5446_chip_info ad5300_chip_info = {
+	.channel = AD5446_CHANNEL_POWERDOWN(8, 16, 4),
+	.write = ad5446_write,
 };
 
-static const struct ad5446_chip_info ad5446_spi_chip_info[] = {
-	[ID_AD5300] = {
-		.channel = AD5446_CHANNEL_POWERDOWN(8, 16, 4),
-		.write = ad5446_write,
-	},
-	[ID_AD5310] = {
-		.channel = AD5446_CHANNEL_POWERDOWN(10, 16, 2),
-		.write = ad5446_write,
-	},
-	[ID_AD5320] = {
-		.channel = AD5446_CHANNEL_POWERDOWN(12, 16, 0),
-		.write = ad5446_write,
-	},
-	[ID_AD5444] = {
-		.channel = AD5446_CHANNEL(12, 16, 2),
-		.write = ad5446_write,
-	},
-	[ID_AD5446] = {
-		.channel = AD5446_CHANNEL(14, 16, 0),
-		.write = ad5446_write,
-	},
-	[ID_AD5450] = {
-		.channel = AD5446_CHANNEL(8, 16, 6),
-		.write = ad5446_write,
-	},
-	[ID_AD5451] = {
-		.channel = AD5446_CHANNEL(10, 16, 4),
-		.write = ad5446_write,
-	},
-	[ID_AD5541A] = {
-		.channel = AD5446_CHANNEL(16, 16, 0),
-		.write = ad5446_write,
-	},
-	[ID_AD5512A] = {
-		.channel = AD5446_CHANNEL(12, 16, 4),
-		.write = ad5446_write,
-	},
-	[ID_AD5553] = {
-		.channel = AD5446_CHANNEL(14, 16, 0),
-		.write = ad5446_write,
-	},
-	[ID_AD5600] = {
-		.channel = AD5446_CHANNEL(16, 16, 0),
-		.write = ad5446_write,
-	},
-	[ID_AD5601] = {
-		.channel = AD5446_CHANNEL_POWERDOWN(8, 16, 6),
-		.write = ad5446_write,
-	},
-	[ID_AD5611] = {
-		.channel = AD5446_CHANNEL_POWERDOWN(10, 16, 4),
-		.write = ad5446_write,
-	},
-	[ID_AD5621] = {
-		.channel = AD5446_CHANNEL_POWERDOWN(12, 16, 2),
-		.write = ad5446_write,
-	},
-	[ID_AD5641] = {
-		.channel = AD5446_CHANNEL_POWERDOWN(14, 16, 0),
-		.write = ad5446_write,
-	},
-	[ID_AD5620_2500] = {
-		.channel = AD5446_CHANNEL_POWERDOWN(12, 16, 2),
-		.int_vref_mv = 2500,
-		.write = ad5446_write,
-	},
-	[ID_AD5620_1250] = {
-		.channel = AD5446_CHANNEL_POWERDOWN(12, 16, 2),
-		.int_vref_mv = 1250,
-		.write = ad5446_write,
-	},
-	[ID_AD5640_2500] = {
-		.channel = AD5446_CHANNEL_POWERDOWN(14, 16, 0),
-		.int_vref_mv = 2500,
-		.write = ad5446_write,
-	},
-	[ID_AD5640_1250] = {
-		.channel = AD5446_CHANNEL_POWERDOWN(14, 16, 0),
-		.int_vref_mv = 1250,
-		.write = ad5446_write,
-	},
-	[ID_AD5660_2500] = {
-		.channel = AD5446_CHANNEL_POWERDOWN(16, 16, 0),
-		.int_vref_mv = 2500,
-		.write = ad5660_write,
-	},
-	[ID_AD5660_1250] = {
-		.channel = AD5446_CHANNEL_POWERDOWN(16, 16, 0),
-		.int_vref_mv = 1250,
-		.write = ad5660_write,
-	},
-	[ID_AD5662] = {
-		.channel = AD5446_CHANNEL_POWERDOWN(16, 16, 0),
-		.write = ad5660_write,
-	},
+static const struct ad5446_chip_info ad5310_chip_info = {
+	.channel = AD5446_CHANNEL_POWERDOWN(10, 16, 2),
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5320_chip_info = {
+	.channel = AD5446_CHANNEL_POWERDOWN(12, 16, 0),
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5444_chip_info = {
+	.channel = AD5446_CHANNEL(12, 16, 2),
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5446_chip_info = {
+	.channel = AD5446_CHANNEL(14, 16, 0),
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5450_chip_info = {
+	.channel = AD5446_CHANNEL(8, 16, 6),
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5451_chip_info = {
+	.channel = AD5446_CHANNEL(10, 16, 4),
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5541a_chip_info = {
+	.channel = AD5446_CHANNEL(16, 16, 0),
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5512a_chip_info = {
+	.channel = AD5446_CHANNEL(12, 16, 4),
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5553_chip_info = {
+	.channel = AD5446_CHANNEL(14, 16, 0),
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5600_chip_info = {
+	.channel = AD5446_CHANNEL(16, 16, 0),
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5601_chip_info = {
+	.channel = AD5446_CHANNEL_POWERDOWN(8, 16, 6),
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5611_chip_info = {
+	.channel = AD5446_CHANNEL_POWERDOWN(10, 16, 4),
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5621_chip_info = {
+	.channel = AD5446_CHANNEL_POWERDOWN(12, 16, 2),
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5641_chip_info = {
+	.channel = AD5446_CHANNEL_POWERDOWN(14, 16, 0),
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5620_2500_chip_info = {
+	.channel = AD5446_CHANNEL_POWERDOWN(12, 16, 2),
+	.int_vref_mv = 2500,
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5620_1250_chip_info = {
+	.channel = AD5446_CHANNEL_POWERDOWN(12, 16, 2),
+	.int_vref_mv = 1250,
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5640_2500_chip_info = {
+	.channel = AD5446_CHANNEL_POWERDOWN(14, 16, 0),
+	.int_vref_mv = 2500,
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5640_1250_chip_info = {
+	.channel = AD5446_CHANNEL_POWERDOWN(14, 16, 0),
+	.int_vref_mv = 1250,
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5660_2500_chip_info = {
+	.channel = AD5446_CHANNEL_POWERDOWN(16, 16, 0),
+	.int_vref_mv = 2500,
+	.write = ad5660_write,
+};
+
+static const struct ad5446_chip_info ad5660_1250_chip_info = {
+	.channel = AD5446_CHANNEL_POWERDOWN(16, 16, 0),
+	.int_vref_mv = 1250,
+	.write = ad5660_write,
+};
+
+static const struct ad5446_chip_info ad5662_chip_info = {
+	.channel = AD5446_CHANNEL_POWERDOWN(16, 16, 0),
+	.write = ad5660_write,
 };
 
 static const struct spi_device_id ad5446_spi_ids[] = {
-	{"ad5300", ID_AD5300},
-	{"ad5310", ID_AD5310},
-	{"ad5320", ID_AD5320},
-	{"ad5444", ID_AD5444},
-	{"ad5446", ID_AD5446},
-	{"ad5450", ID_AD5450},
-	{"ad5451", ID_AD5451},
-	{"ad5452", ID_AD5444}, /* ad5452 is compatible to the ad5444 */
-	{"ad5453", ID_AD5446}, /* ad5453 is compatible to the ad5446 */
-	{"ad5512a", ID_AD5512A},
-	{"ad5541a", ID_AD5541A},
-	{"ad5542a", ID_AD5541A}, /* ad5541a and ad5542a are compatible */
-	{"ad5543", ID_AD5541A}, /* ad5541a and ad5543 are compatible */
-	{"ad5553", ID_AD5553},
-	{"ad5600", ID_AD5600},
-	{"ad5601", ID_AD5601},
-	{"ad5611", ID_AD5611},
-	{"ad5621", ID_AD5621},
-	{"ad5641", ID_AD5641},
-	{"ad5620-2500", ID_AD5620_2500}, /* AD5620/40/60: */
-	{"ad5620-1250", ID_AD5620_1250}, /* part numbers may look differently */
-	{"ad5640-2500", ID_AD5640_2500},
-	{"ad5640-1250", ID_AD5640_1250},
-	{"ad5660-2500", ID_AD5660_2500},
-	{"ad5660-1250", ID_AD5660_1250},
-	{"ad5662", ID_AD5662},
-	{"dac081s101", ID_AD5300}, /* compatible Texas Instruments chips */
-	{"dac101s101", ID_AD5310},
-	{"dac121s101", ID_AD5320},
-	{"dac7512", ID_AD5320},
+	{"ad5300", (kernel_ulong_t)&ad5300_chip_info},
+	{"ad5310", (kernel_ulong_t)&ad5310_chip_info},
+	{"ad5320", (kernel_ulong_t)&ad5320_chip_info},
+	{"ad5444", (kernel_ulong_t)&ad5444_chip_info},
+	{"ad5446", (kernel_ulong_t)&ad5446_chip_info},
+	{"ad5450", (kernel_ulong_t)&ad5450_chip_info},
+	{"ad5451", (kernel_ulong_t)&ad5451_chip_info},
+	{"ad5452", (kernel_ulong_t)&ad5444_chip_info}, /* ad5452 is compatible to the ad5444 */
+	{"ad5453", (kernel_ulong_t)&ad5446_chip_info}, /* ad5453 is compatible to the ad5446 */
+	{"ad5512a", (kernel_ulong_t)&ad5512a_chip_info},
+	{"ad5541a", (kernel_ulong_t)&ad5541a_chip_info},
+	{"ad5542a", (kernel_ulong_t)&ad5541a_chip_info}, /* ad5541a and ad5542a are compatible */
+	{"ad5543", (kernel_ulong_t)&ad5541a_chip_info}, /* ad5541a and ad5543 are compatible */
+	{"ad5553", (kernel_ulong_t)&ad5553_chip_info},
+	{"ad5600", (kernel_ulong_t)&ad5600_chip_info},
+	{"ad5601", (kernel_ulong_t)&ad5601_chip_info},
+	{"ad5611", (kernel_ulong_t)&ad5611_chip_info},
+	{"ad5621", (kernel_ulong_t)&ad5621_chip_info},
+	{"ad5641", (kernel_ulong_t)&ad5641_chip_info},
+	{"ad5620-2500", (kernel_ulong_t)&ad5620_2500_chip_info}, /* AD5620/40/60: */
+	/* part numbers may look differently */
+	{"ad5620-1250", (kernel_ulong_t)&ad5620_1250_chip_info},
+	{"ad5640-2500", (kernel_ulong_t)&ad5640_2500_chip_info},
+	{"ad5640-1250", (kernel_ulong_t)&ad5640_1250_chip_info},
+	{"ad5660-2500", (kernel_ulong_t)&ad5660_2500_chip_info},
+	{"ad5660-1250", (kernel_ulong_t)&ad5660_1250_chip_info},
+	{"ad5662", (kernel_ulong_t)&ad5662_chip_info},
+	{"dac081s101", (kernel_ulong_t)&ad5300_chip_info}, /* compatible Texas Instruments chips */
+	{"dac101s101", (kernel_ulong_t)&ad5310_chip_info},
+	{"dac121s101", (kernel_ulong_t)&ad5320_chip_info},
+	{"dac7512", (kernel_ulong_t)&ad5320_chip_info},
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad5446_spi_ids);
 
 static const struct of_device_id ad5446_of_ids[] = {
-	{ .compatible = "ti,dac7512" },
+	{ .compatible = "ti,dac7512", .data = &ad5320_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad5446_of_ids);
@@ -457,9 +453,13 @@ MODULE_DEVICE_TABLE(of, ad5446_of_ids);
 static int ad5446_spi_probe(struct spi_device *spi)
 {
 	const struct spi_device_id *id = spi_get_device_id(spi);
+	const struct ad5446_chip_info *chip_info;
 
-	return ad5446_probe(&spi->dev, id->name,
-		&ad5446_spi_chip_info[id->driver_data]);
+	chip_info = spi_get_device_match_data(spi);
+	if (!chip_info)
+		return -ENODEV;
+
+	return ad5446_probe(&spi->dev, id->name, chip_info);
 }
 
 static struct spi_driver ad5446_spi_driver = {
@@ -512,41 +512,41 @@ static int ad5622_write(struct ad5446_state *st, unsigned val)
  * (and a bit cryptic), however this style is used to make clear which
  * parts are supported here.
  */
-enum ad5446_supported_i2c_device_ids {
-	ID_AD5602,
-	ID_AD5612,
-	ID_AD5622,
+
+static const struct ad5446_chip_info ad5602_chip_info = {
+	.channel = AD5446_CHANNEL_POWERDOWN(8, 16, 4),
+	.write = ad5622_write,
 };
 
-static const struct ad5446_chip_info ad5446_i2c_chip_info[] = {
-	[ID_AD5602] = {
-		.channel = AD5446_CHANNEL_POWERDOWN(8, 16, 4),
-		.write = ad5622_write,
-	},
-	[ID_AD5612] = {
-		.channel = AD5446_CHANNEL_POWERDOWN(10, 16, 2),
-		.write = ad5622_write,
-	},
-	[ID_AD5622] = {
-		.channel = AD5446_CHANNEL_POWERDOWN(12, 16, 0),
-		.write = ad5622_write,
-	},
+static const struct ad5446_chip_info ad5612_chip_info = {
+	.channel = AD5446_CHANNEL_POWERDOWN(10, 16, 2),
+	.write = ad5622_write,
+};
+
+static const struct ad5446_chip_info ad5622_chip_info = {
+	.channel = AD5446_CHANNEL_POWERDOWN(12, 16, 0),
+	.write = ad5622_write,
 };
 
 static int ad5446_i2c_probe(struct i2c_client *i2c)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
-	return ad5446_probe(&i2c->dev, id->name,
-		&ad5446_i2c_chip_info[id->driver_data]);
+	const struct ad5446_chip_info *chip_info;
+
+	chip_info = i2c_get_match_data(i2c);
+	if (!chip_info)
+		return -ENODEV;
+
+	return ad5446_probe(&i2c->dev, id->name, chip_info);
 }
 
 static const struct i2c_device_id ad5446_i2c_ids[] = {
-	{"ad5301", ID_AD5602},
-	{"ad5311", ID_AD5612},
-	{"ad5321", ID_AD5622},
-	{"ad5602", ID_AD5602},
-	{"ad5612", ID_AD5612},
-	{"ad5622", ID_AD5622},
+	{"ad5301", (kernel_ulong_t)&ad5602_chip_info},
+	{"ad5311", (kernel_ulong_t)&ad5612_chip_info},
+	{"ad5321", (kernel_ulong_t)&ad5622_chip_info},
+	{"ad5602", (kernel_ulong_t)&ad5602_chip_info},
+	{"ad5612", (kernel_ulong_t)&ad5612_chip_info},
+	{"ad5622", (kernel_ulong_t)&ad5622_chip_info},
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ad5446_i2c_ids);

-- 
2.51.0



