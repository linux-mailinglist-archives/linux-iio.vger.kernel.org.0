Return-Path: <linux-iio+bounces-26611-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B85C7C99DB5
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 03:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A41384E249D
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 02:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99292264619;
	Tue,  2 Dec 2025 02:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pj/7C6AS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8136B256C8B
	for <linux-iio@vger.kernel.org>; Tue,  2 Dec 2025 02:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764642107; cv=none; b=HEbxzCKRZHz2qovcrqnlzRJNIGDtFi5W1jxprMm3VFLFVO2Gl07Uizcs3gUWPp3rvQtHJlSfhy2gBHN6zDOKxJ5Vgy4JxmNgTX5/BZWgNDt3Hzqop+hpW6NcdBD0HGZF9l9S2wOCggtXIq7AXY/ig1+tXNxrxHtWEqfnuS6gy4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764642107; c=relaxed/simple;
	bh=YGvYUPI9nlA4KSwcS4O1bSjeRr55I+gcPjKWb8gh1rI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YqQAfGr/m+Yhex0E8kUv2b4ItEpvvcYcjJfymNqqct5rQZkPJ38p5KS6mw2Y4o5BG/941lruE9pLfDE2qJ7JKu5uf5ip8GJSkFNYSCC/k6AulXjvZJp2KzJFWUbDzZCgLI2L5sfm92g4r2e37r1iAZfXKeMSIOU3JpR8lM/UXyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pj/7C6AS; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-3e7ead70738so2680222fac.0
        for <linux-iio@vger.kernel.org>; Mon, 01 Dec 2025 18:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764642103; x=1765246903; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1wiS8NSc7Hrv1RskP9nPIhtrBDJN7TE+vx4N05Su490=;
        b=pj/7C6ASpzmHhIVKtoDFzjmwTGMemldVEQZuHqdbwLHwzlvp67FIK4k/wCXsXRliuf
         p4LIRfJZe/YG6VrNFZhQnu65x+dcuSw1fVUdwJTXrEHRbZXpjeVx+zS4jhUduzwWTcE9
         FiWSmCsru7Hh74yzpza3vdOyh6CPKz/Sbfy+u+cV0zZF7Z3InwOHxT/2fstYBUvu6mDu
         Sod6FY3AZw5mZeDS0d+BMF2a5Uyykf1tT1Ln5Bv/nehawT5LaUwpGqSUwCBR/BULLD2p
         h4bTpQxX3/Usr6yHF/XtX3KiW9GtxdMjgiLtS5WVXsvjIhXChRto1CGmHX43JncNiKhh
         lHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764642103; x=1765246903;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1wiS8NSc7Hrv1RskP9nPIhtrBDJN7TE+vx4N05Su490=;
        b=dVihlhdUZ2p77h5DVVCuayvyRI01gpmeEeYA+za2j5tDnOH444qagJN8EbO6rmpn3r
         zVcDCqS52MeptoJYyFb2Xu3XsP5kOwsLhkhRwa7bBgQu1v7qzdjstc9MybJ2QOwutMDr
         k8I/xO3cOY3OsJ5LjCfs3KUzdyCH7Jmo0bJZ5jSYDakaYBFi77tMN5RVaVqeKfj+Mc6D
         yOGmcMxgMRvULMAi1dd0rJkDSqGBUiVuSOpKF+FMrDwUivKz2RgW1nyUMmiC7a6hGY6f
         r+a9+gtvXcV3ZDQ1Z+pIdd5nsM0fvcgwZ5CHFvWm5/5Zhqmg039OEOY+/b8jv2BoKKnT
         pIGg==
X-Forwarded-Encrypted: i=1; AJvYcCXTh9j7ypePmStW26jExOrG81ZsBfF3EZxWqpr56rFZiJyQXihLAYseebbc/yqh1xgF62T3lXTD4ag=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLmPKG4/mAfqa+gCId/R/pk4+bWtthEhVBexFx/adU1INSgp6d
	UA9e/BcitXhAmL7IAbG8e0JEylskPdQE3OK73VhcNoj7hs2KVpBRyWbVmx0RrsBxwOc=
X-Gm-Gg: ASbGncv++RUM5RqVnMEtrLOG6LOmAfdSOx4oxaPwk0BewC1Sfy58ys5nvNRcmYWenOt
	qg5QTECaelHpdpeMSFQ6B06poEKF3GlvX0nos2MLzWtRyEBxVCugGWv0bBMOVrhZhHHLKdaypA0
	NRKaJDxEHnGRTDOyM/TzkIu5gqs5L0BN4+2cLeGEvRoPFEx4UZIkQV8qFIr5rTZl3yFrp8dfp1a
	FxpDMWTyA2Qh8vVtc6CS9MDNANQ2wqms8HPGurzY0SfLz9o3do5P864l4V//sJaHufrAmaIqIRM
	/kIsw1+8/6jpE/pyCrY8pm5kGsY5AtrC2MBMZg7f7S10j7hRkXgg1iwtPm+GA2gQsiqdbcBlFlZ
	2i4MInOsXxlTFW5/fHCL5KX6Q63XcPv/O07oQexqOSqc/a63A3ooy70eWhQ7Y7NMsordRtteISn
	H3Tr+emNI20rS9qw==
X-Google-Smtp-Source: AGHT+IHsrflFNy9GTuCDPfXMsxjy4Q4vKgYD0d6HLofuzRVhA2ABiiT+ivwGCEyVHXqzQw4YNechPQ==
X-Received: by 2002:a05:6871:b23:b0:3ec:32a0:33bc with SMTP id 586e51a60fabf-3ed1ff9e124mr17535727fac.31.1764642103403;
        Mon, 01 Dec 2025 18:21:43 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b67b:16c:f7ae:4908])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f0dca0475esm6651747fac.1.2025.12.01.18.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 18:21:43 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 01 Dec 2025 20:20:42 -0600
Subject: [PATCH v3 4/7] spi: axi-spi-engine: support
 SPI_MULTI_LANE_MODE_STRIPE
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-spi-add-multi-bus-support-v3-4-34e05791de83@baylibre.com>
References: <20251201-spi-add-multi-bus-support-v3-0-34e05791de83@baylibre.com>
In-Reply-To: <20251201-spi-add-multi-bus-support-v3-0-34e05791de83@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11423;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=YGvYUPI9nlA4KSwcS4O1bSjeRr55I+gcPjKWb8gh1rI=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpLk0XMRLT+GlVQnTE+yVkm4nY9zSXA7ZI1NcHp
 0B1CkV9NdKJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaS5NFwAKCRDCzCAB/wGP
 wEtKB/0SN5CHnsnbiQKenRy1MhH2ThGQ2FVBpg44YSkQzF3Cuimp5SWGeIAN4rGbuMZoqDdXVaq
 /UnUMlJ9vReA0JxZX+SVZUdTDRLMvhuKqnOX/FS2kAduyO9pko8VRFqW253UgOSZJLVfVkR/Djm
 3Hhxt2C88UNODJiBh8Lg9+S1aWeiVwsC0DX6GQ6S/43n1eOYs3Y32n6vbnXrPxLprSwxC76iYFj
 Qye7J7FPNXYPb/ToMz+auJ4WMv2cImFL4iAzp0psm+vkvSIPv+8LPWjevre1Ucr5CxzaSHy9wca
 9Kw0zfxJ+7i7FQNuRR1Fm/GxFsnbRPi73qvz5ud8RtY97EFE
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add support for SPI_MULTI_LANE_MODE_STRIPE to the AXI SPI engine driver.

The v2.0.0 version of the AXI SPI Engine IP core supports multiple
lanes. This can be used with SPI_MULTI_LANE_MODE_STRIPE to support
reading from simultaneous sampling ADCs that have a separate SDO line
for each analog channel. This allows reading all channels at the same
time to increase throughput.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
v3 changes:
* Renamed "buses" to "lanes" to reflect devicetree property name change.

v2 changes:
* Fixed off-by-one in SPI_ENGINE_REG_DATA_WIDTH_NUM_OF_SDIO_MASK GENMASK
---
 drivers/spi/spi-axi-spi-engine.c | 128 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 124 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index e06f412190fd243161a0b3df992f26157531f6a1..4a514002d03789a62b29c68ea0f8f20789c830c8 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -23,6 +23,9 @@
 #include <linux/spi/spi.h>
 #include <trace/events/spi.h>
 
+#define SPI_ENGINE_REG_DATA_WIDTH		0x0C
+#define   SPI_ENGINE_REG_DATA_WIDTH_NUM_OF_SDIO_MASK	GENMASK(23, 16)
+#define   SPI_ENGINE_REG_DATA_WIDTH_MASK		GENMASK(15, 0)
 #define SPI_ENGINE_REG_OFFLOAD_MEM_ADDR_WIDTH	0x10
 #define SPI_ENGINE_REG_RESET			0x40
 
@@ -75,6 +78,8 @@
 #define SPI_ENGINE_CMD_REG_CLK_DIV		0x0
 #define SPI_ENGINE_CMD_REG_CONFIG		0x1
 #define SPI_ENGINE_CMD_REG_XFER_BITS		0x2
+#define SPI_ENGINE_CMD_REG_SDI_MASK		0x3
+#define SPI_ENGINE_CMD_REG_SDO_MASK		0x4
 
 #define SPI_ENGINE_MISC_SYNC			0x0
 #define SPI_ENGINE_MISC_SLEEP			0x1
@@ -105,6 +110,10 @@
 #define SPI_ENGINE_OFFLOAD_CMD_FIFO_SIZE	16
 #define SPI_ENGINE_OFFLOAD_SDO_FIFO_SIZE	16
 
+/* Extending SPI_MULTI_LANE_MODE values for optimizing messages. */
+#define SPI_ENGINE_MULTI_BUS_MODE_UNKNOWN	-1
+#define SPI_ENGINE_MULTI_BUS_MODE_CONFLICTING	-2
+
 struct spi_engine_program {
 	unsigned int length;
 	uint16_t instructions[] __counted_by(length);
@@ -142,6 +151,9 @@ struct spi_engine_offload {
 	unsigned long flags;
 	unsigned int offload_num;
 	unsigned int spi_mode_config;
+	unsigned int multi_lane_mode;
+	u8 primary_lane_mask;
+	u8 all_lane_mask;
 	u8 bits_per_word;
 };
 
@@ -165,6 +177,22 @@ struct spi_engine {
 	bool offload_requires_sync;
 };
 
+static u8 spi_engine_primary_lane_flag(struct spi_device *spi)
+{
+	return BIT(spi->data_lanes[0]);
+}
+
+static u8 spi_engine_all_lane_flags(struct spi_device *spi)
+{
+	u8 flags = 0;
+	int i;
+
+	for (i = 0; i < spi->num_data_lanes; i++)
+		flags |= BIT(spi->data_lanes[i]);
+
+	return flags;
+}
+
 static void spi_engine_program_add_cmd(struct spi_engine_program *p,
 	bool dry, uint16_t cmd)
 {
@@ -193,7 +221,7 @@ static unsigned int spi_engine_get_config(struct spi_device *spi)
 }
 
 static void spi_engine_gen_xfer(struct spi_engine_program *p, bool dry,
-	struct spi_transfer *xfer)
+				struct spi_transfer *xfer, u32 num_lanes)
 {
 	unsigned int len;
 
@@ -204,6 +232,9 @@ static void spi_engine_gen_xfer(struct spi_engine_program *p, bool dry,
 	else
 		len = xfer->len / 4;
 
+	if (xfer->multi_lane_mode == SPI_MULTI_LANE_MODE_STRIPE)
+		len /= num_lanes;
+
 	while (len) {
 		unsigned int n = min(len, 256U);
 		unsigned int flags = 0;
@@ -269,6 +300,7 @@ static int spi_engine_precompile_message(struct spi_message *msg)
 {
 	unsigned int clk_div, max_hz = msg->spi->controller->max_speed_hz;
 	struct spi_transfer *xfer;
+	int multi_lane_mode = SPI_ENGINE_MULTI_BUS_MODE_UNKNOWN;
 	u8 min_bits_per_word = U8_MAX;
 	u8 max_bits_per_word = 0;
 
@@ -284,6 +316,24 @@ static int spi_engine_precompile_message(struct spi_message *msg)
 			min_bits_per_word = min(min_bits_per_word, xfer->bits_per_word);
 			max_bits_per_word = max(max_bits_per_word, xfer->bits_per_word);
 		}
+
+		if (xfer->rx_buf || xfer->offload_flags & SPI_OFFLOAD_XFER_RX_STREAM ||
+		    xfer->tx_buf || xfer->offload_flags & SPI_OFFLOAD_XFER_TX_STREAM) {
+			switch (xfer->multi_lane_mode) {
+			case SPI_MULTI_LANE_MODE_SINGLE:
+			case SPI_MULTI_LANE_MODE_STRIPE:
+				break;
+			default:
+				/* Other modes, like mirror not supported */
+				return -EINVAL;
+			}
+
+			/* If all xfers have the same multi-lane mode, we can optimize. */
+			if (multi_lane_mode == SPI_ENGINE_MULTI_BUS_MODE_UNKNOWN)
+				multi_lane_mode = xfer->multi_lane_mode;
+			else if (multi_lane_mode != xfer->multi_lane_mode)
+				multi_lane_mode = SPI_ENGINE_MULTI_BUS_MODE_CONFLICTING;
+		}
 	}
 
 	/*
@@ -297,6 +347,10 @@ static int spi_engine_precompile_message(struct spi_message *msg)
 			priv->bits_per_word = min_bits_per_word;
 		else
 			priv->bits_per_word = 0;
+
+		priv->multi_lane_mode = multi_lane_mode;
+		priv->primary_lane_mask = spi_engine_primary_lane_flag(msg->spi);
+		priv->all_lane_mask = spi_engine_all_lane_flags(msg->spi);
 	}
 
 	return 0;
@@ -310,6 +364,7 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 	struct spi_engine_offload *priv;
 	struct spi_transfer *xfer;
 	int clk_div, new_clk_div, inst_ns;
+	int prev_multi_lane_mode = SPI_MULTI_LANE_MODE_SINGLE;
 	bool keep_cs = false;
 	u8 bits_per_word = 0;
 
@@ -334,6 +389,7 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 		 * in the same way.
 		 */
 		bits_per_word = priv->bits_per_word;
+		prev_multi_lane_mode = priv->multi_lane_mode;
 	} else {
 		spi_engine_program_add_cmd(p, dry,
 			SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_CONFIG,
@@ -344,6 +400,24 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 	spi_engine_gen_cs(p, dry, spi, !xfer->cs_off);
 
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		if (xfer->rx_buf || xfer->offload_flags & SPI_OFFLOAD_XFER_RX_STREAM ||
+		    xfer->tx_buf || xfer->offload_flags & SPI_OFFLOAD_XFER_TX_STREAM) {
+			if (xfer->multi_lane_mode != prev_multi_lane_mode) {
+				u8 lane_flags = spi_engine_primary_lane_flag(spi);
+
+				if (xfer->multi_lane_mode == SPI_MULTI_LANE_MODE_STRIPE)
+					lane_flags = spi_engine_all_lane_flags(spi);
+
+				spi_engine_program_add_cmd(p, dry,
+					SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDI_MASK,
+							     lane_flags));
+				spi_engine_program_add_cmd(p, dry,
+					SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDO_MASK,
+							     lane_flags));
+			}
+			prev_multi_lane_mode = xfer->multi_lane_mode;
+		}
+
 		new_clk_div = host->max_speed_hz / xfer->effective_speed_hz;
 		if (new_clk_div != clk_div) {
 			clk_div = new_clk_div;
@@ -360,7 +434,7 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 					bits_per_word));
 		}
 
-		spi_engine_gen_xfer(p, dry, xfer);
+		spi_engine_gen_xfer(p, dry, xfer, spi->num_data_lanes);
 		spi_engine_gen_sleep(p, dry, spi_delay_to_ns(&xfer->delay, xfer),
 				     inst_ns, xfer->effective_speed_hz);
 
@@ -394,6 +468,17 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 	if (clk_div != 1)
 		spi_engine_program_add_cmd(p, dry,
 			SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_CLK_DIV, 0));
+
+	/* Restore single lane mode unless offload disable will restore it later. */
+	if (prev_multi_lane_mode == SPI_MULTI_LANE_MODE_STRIPE &&
+	    (!msg->offload || priv->multi_lane_mode != SPI_MULTI_LANE_MODE_STRIPE)) {
+		u8 lane_flags = spi_engine_primary_lane_flag(spi);
+
+		spi_engine_program_add_cmd(p, dry,
+			SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDI_MASK, lane_flags));
+		spi_engine_program_add_cmd(p, dry,
+			SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDO_MASK, lane_flags));
+	}
 }
 
 static void spi_engine_xfer_next(struct spi_message *msg,
@@ -799,6 +884,17 @@ static int spi_engine_setup(struct spi_device *device)
 	writel_relaxed(SPI_ENGINE_CMD_CS_INV(spi_engine->cs_inv),
 		       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
 
+	if (host->num_data_lanes > 1) {
+		u8 lane_flags = spi_engine_primary_lane_flag(device);
+
+		writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDI_MASK,
+						    lane_flags),
+			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
+		writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDO_MASK,
+						    lane_flags),
+			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
+	}
+
 	/*
 	 * In addition to setting the flags, we have to do a CS assert command
 	 * to make the new setting actually take effect.
@@ -902,6 +998,15 @@ static int spi_engine_trigger_enable(struct spi_offload *offload)
 						    priv->bits_per_word),
 			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
 
+	if (priv->multi_lane_mode == SPI_MULTI_LANE_MODE_STRIPE) {
+		writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDI_MASK,
+						    priv->all_lane_mask),
+			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
+		writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDO_MASK,
+						    priv->all_lane_mask),
+			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
+	}
+
 	writel_relaxed(SPI_ENGINE_CMD_SYNC(1),
 		spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
 
@@ -929,6 +1034,16 @@ static void spi_engine_trigger_disable(struct spi_offload *offload)
 	reg &= ~SPI_ENGINE_OFFLOAD_CTRL_ENABLE;
 	writel_relaxed(reg, spi_engine->base +
 			    SPI_ENGINE_REG_OFFLOAD_CTRL(priv->offload_num));
+
+	/* Restore single-lane mode. */
+	if (priv->multi_lane_mode == SPI_MULTI_LANE_MODE_STRIPE) {
+		writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDI_MASK,
+						    priv->primary_lane_mask),
+			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
+		writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDO_MASK,
+						    priv->primary_lane_mask),
+			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
+	}
 }
 
 static struct dma_chan
@@ -973,7 +1088,7 @@ static int spi_engine_probe(struct platform_device *pdev)
 {
 	struct spi_engine *spi_engine;
 	struct spi_controller *host;
-	unsigned int version;
+	unsigned int version, data_width_reg_val;
 	int irq, ret;
 
 	irq = platform_get_irq(pdev, 0);
@@ -1042,7 +1157,7 @@ static int spi_engine_probe(struct platform_device *pdev)
 		return PTR_ERR(spi_engine->base);
 
 	version = readl(spi_engine->base + ADI_AXI_REG_VERSION);
-	if (ADI_AXI_PCORE_VER_MAJOR(version) != 1) {
+	if (ADI_AXI_PCORE_VER_MAJOR(version) > 2) {
 		dev_err(&pdev->dev, "Unsupported peripheral version %u.%u.%u\n",
 			ADI_AXI_PCORE_VER_MAJOR(version),
 			ADI_AXI_PCORE_VER_MINOR(version),
@@ -1050,6 +1165,8 @@ static int spi_engine_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	data_width_reg_val = readl(spi_engine->base + SPI_ENGINE_REG_DATA_WIDTH);
+
 	if (adi_axi_pcore_ver_gteq(version, 1, 1)) {
 		unsigned int sizes = readl(spi_engine->base +
 				SPI_ENGINE_REG_OFFLOAD_MEM_ADDR_WIDTH);
@@ -1097,6 +1214,9 @@ static int spi_engine_probe(struct platform_device *pdev)
 	}
 	if (adi_axi_pcore_ver_gteq(version, 1, 3))
 		host->mode_bits |= SPI_MOSI_IDLE_LOW | SPI_MOSI_IDLE_HIGH;
+	if (adi_axi_pcore_ver_gteq(version, 2, 0))
+		host->num_data_lanes = FIELD_GET(SPI_ENGINE_REG_DATA_WIDTH_NUM_OF_SDIO_MASK,
+						 data_width_reg_val);
 
 	if (host->max_speed_hz == 0)
 		return dev_err_probe(&pdev->dev, -EINVAL, "spi_clk rate is 0");

-- 
2.43.0


