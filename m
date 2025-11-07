Return-Path: <linux-iio+bounces-26038-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5347EC41A8B
	for <lists+linux-iio@lfdr.de>; Fri, 07 Nov 2025 21:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0FAC42534C
	for <lists+linux-iio@lfdr.de>; Fri,  7 Nov 2025 20:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6760733C533;
	Fri,  7 Nov 2025 20:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="b1EiszdV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE13C335064
	for <linux-iio@vger.kernel.org>; Fri,  7 Nov 2025 20:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762548831; cv=none; b=M2GGW3h4cS2+3hVPK2QNGJq/kG0iBCE1SvfKVbjL0THvyUFhPAPzBVG5t5tpdj+iGoUAXFW4JvBXiERPRt3SMRuAxxuJBUl0PZjXLgDNT2+JNDpzqm/b5CyadNsNmn1phu+Iszx1Jtq5jDrwo2GaUM0Vu63NAxUY+c2pklHO7Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762548831; c=relaxed/simple;
	bh=tDgY9PgjE3rE33iaQr1P6OAzhqfnlIin3aQjjP7cTsw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SjLCs6H7+blx5P7e5TzzvHl8iXr0T8W9qpbDDb6PrpgwQgmiczqZvr74FK93ahTxBDOmo1Hz72Mzl/X9fDMzPmP1nf5V9bl4UHbMFsQRlXBZmD383QpFmuuEY51LouPRe9xW0UV1r8toOAvf6VdkpceevBGDps4RjYDB4k7SPB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=b1EiszdV; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7c2948b774cso699177a34.0
        for <linux-iio@vger.kernel.org>; Fri, 07 Nov 2025 12:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762548828; x=1763153628; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TogcEBDmAA9dvY22CwRmyMkgHgYI49vrkDW3/a9RFVE=;
        b=b1EiszdVIndLIuW210qZ4DTvlNuIM4O0sAlq2RzFLPTvYORA0nA/twuj0zRSD4ePKZ
         fNUV87/kvTa+TRM68JG/nlDJIJUwDvYqyyDJhyIWSN7MPoXI/KG3R42bJ5LcwWEdFuFH
         Hs42M1Bh+s5DfGhgBuDp0971SItQ/KTac0eHX1ulCApaVz5g6NNqAXGLLI877tLpIfMk
         fevQpt8VqZCtPgpSE2OBvd/Nq0jdhDz/3ifDRpgR/6B9+CL4S0u6ac4FCkWo1Hl1cDiS
         Z4yzMld1X50dJ0jzTuuZdomSH/hbNw5MJ6wX5jcpHU9rEFe/uPfGKnbrp2PnPJN65jCR
         LlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762548828; x=1763153628;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TogcEBDmAA9dvY22CwRmyMkgHgYI49vrkDW3/a9RFVE=;
        b=WRxyHP5NWFxz3P0o2SAc6lqYXrYDRPsEZe0gfA5bZaowx6R6KsCRmemEJHLnS9mb+9
         BuFWKNyHe+87+pMtCOgFXmqwpXcJodTzPVGFq/JzMtDd7ozECUdEqgK50nHEFAKHH0sW
         QB/0xbnwG7CQOEmcOpkMoQMRQQxFbfVONEpMrlWs8CFvHalaH/WRP8195xTXY7ZDw12a
         SFn7VFde0lETOurFjVbK76Jw0kSARKcm3G8ev47/8xM1d51jaiO4CTBp4G6Bh2KRKSIz
         6GnjUfENVTFld55AG1sPl9zjxbLfl8gNwtXleiFReHx/7c5Y1i6LdKCY+8P/2mR2X1ll
         4I6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWlZlOczTKbGJYaZge3qq73OAmQ0lbTwGQQbMluOpxnVHRBpJUf1i4UwOmlBVKBbF2vevnlTilqlA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5UQizmtX37HvN2E7pIg2y0hG7JrVzwCUsNKshbSaSUD7qHV+W
	X3JDGLg5GitqJlqLYbFlTkKsUo/cwNAPVytUgYe0idkRYARDSgc0dJ/d9CISFnsb6Gw=
X-Gm-Gg: ASbGncvbDPSR8HZwWB1penerhso8ug1hfsTuUySc4tISFY1sWhEKwmuc9HDGTevCeoB
	550XqowSH4DNcrKEblc3BfAm2zl3lOA80k9zoPsMhdJw0+9hkrSaVYY04u4yxSgZoQGqsyKwPV6
	32UHiNeh7TWSR2bndfg3M0/qI3w6e9z2rX5rfhIiU+nQKz2bTTivy7XU2ATjI4PZA/zt3WEnGoR
	n8V4RyTjX5k82b0lV30J0Pb/iT1oEXrsEejwQcUcw2U1cw0HAeSlkSEQ8bLYPFoMOGJlLgBNSrA
	rNKGMWIrGOF71f4aUSXhpI6k2GDfuEe2+snpzOG6dKIFZZX2BMQSCCGt7jcC1b3Acg3xN5LwHTE
	u8OWsf6+7AUqNKUPEqn5f9zytK++tbhxUbue6FOeSehRlShTFLOsXupAPh1zClZ7onv76INxZm1
	WVlCiG
X-Google-Smtp-Source: AGHT+IGWyMDK671xIFdUYmdwQn0Ar6RSBRefyOIxpV28IGDXeutrbpMFaD0KVVQmG1QoeOGTW+MKCw==
X-Received: by 2002:a05:6808:2f18:b0:43f:5bee:4e49 with SMTP id 5614622812f47-4502a3fd765mr439380b6e.41.1762548827591;
        Fri, 07 Nov 2025 12:53:47 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7bb8:950b:327d:4ba4])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-656c57eae5esm2915601eaf.16.2025.11.07.12.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 12:53:47 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Nov 2025 14:52:50 -0600
Subject: [PATCH v2 4/6] spi: axi-spi-engine: support
 SPI_MULTI_BUS_MODE_STRIPE
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-spi-add-multi-bus-support-v2-4-8a92693314d9@baylibre.com>
References: <20251107-spi-add-multi-bus-support-v2-0-8a92693314d9@baylibre.com>
In-Reply-To: <20251107-spi-add-multi-bus-support-v2-0-8a92693314d9@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11262;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=tDgY9PgjE3rE33iaQr1P6OAzhqfnlIin3aQjjP7cTsw=;
 b=owEBbAGT/pANAwAKAcLMIAH/AY/AAcsmYgBpDlxAFRFTT9BeZuPCT/R7t64DTDDepkVGvPhGA
 ownsyE6vfWJATIEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaQ5cQAAKCRDCzCAB/wGP
 wDWHB/QJbbjOIG/SDsXPlJGmah/kDYwKw8YWdx9ahTjab4U87wdF1ymGKiEBWyO3pzAl4HpVelT
 pXilGpHmXTH17QuhcaoN3chgMDltrI3ZE3qTO2RMUM5INRLGVo7PkSn0vYofyaiWDcN0nXIWxZ3
 r3NNH+B5Tj7rbpAZAYnNR5Ku2tnNghXS7N9HRCnnkNq6gTFY8lYy6xMQjV0cNkrB+jShE0jgqlZ
 zf7NI1Aj8fEhZVY7iNxRAw1mowSyfb+k8D0N6P2pv+7t0S2Cqr+Hps5QnSxK5AJU5LZKOITGFHy
 w3bAmhKjtmnnhKKDVxHSmAedPpvvvTCVOE8TBEGNCYrOv1Y=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add support for SPI_MULTI_BUS_MODE_STRIPE to the AXI SPI engine driver.

The v2.0.0 version of the AXI SPI Engine IP core supports multiple
buses. This can be used with SPI_MULTI_BUS_MODE_STRIPE to support
reading from simultaneous sampling ADCs that have a separate SDO line
for each analog channel. This allows reading all channels at the same
time to increase throughput.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
v2 changes:
* Fixed off-by-one in SPI_ENGINE_REG_DATA_WIDTH_NUM_OF_SDIO_MASK GENMASK
---
 drivers/spi/spi-axi-spi-engine.c | 128 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 124 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index e06f412190fd243161a0b3df992f26157531f6a1..c9d146e978b89abb8273900722ae2cfafdd6325f 100644
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
 
+/* Extending SPI_MULTI_BUS_MODE values for optimizing messages. */
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
+	unsigned int multi_bus_mode;
+	u8 primary_bus_mask;
+	u8 all_bus_mask;
 	u8 bits_per_word;
 };
 
@@ -165,6 +177,22 @@ struct spi_engine {
 	bool offload_requires_sync;
 };
 
+static u8 spi_engine_primary_bus_flag(struct spi_device *spi)
+{
+	return BIT(spi->data_bus[0]);
+}
+
+static u8 spi_engine_all_bus_flags(struct spi_device *spi)
+{
+	u8 flags = 0;
+	int i;
+
+	for (i = 0; i < spi->num_data_bus; i++)
+		flags |= BIT(spi->data_bus[i]);
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
 
+	if (xfer->multi_bus_mode == SPI_MULTI_BUS_MODE_STRIPE)
+		len /= num_lanes;
+
 	while (len) {
 		unsigned int n = min(len, 256U);
 		unsigned int flags = 0;
@@ -269,6 +300,7 @@ static int spi_engine_precompile_message(struct spi_message *msg)
 {
 	unsigned int clk_div, max_hz = msg->spi->controller->max_speed_hz;
 	struct spi_transfer *xfer;
+	int multi_bus_mode = SPI_ENGINE_MULTI_BUS_MODE_UNKNOWN;
 	u8 min_bits_per_word = U8_MAX;
 	u8 max_bits_per_word = 0;
 
@@ -284,6 +316,24 @@ static int spi_engine_precompile_message(struct spi_message *msg)
 			min_bits_per_word = min(min_bits_per_word, xfer->bits_per_word);
 			max_bits_per_word = max(max_bits_per_word, xfer->bits_per_word);
 		}
+
+		if (xfer->rx_buf || xfer->offload_flags & SPI_OFFLOAD_XFER_RX_STREAM ||
+		    xfer->tx_buf || xfer->offload_flags & SPI_OFFLOAD_XFER_TX_STREAM) {
+			switch (xfer->multi_bus_mode) {
+			case SPI_MULTI_BUS_MODE_SINGLE:
+			case SPI_MULTI_BUS_MODE_STRIPE:
+				break;
+			default:
+				/* Other modes, like mirror not supported */
+				return -EINVAL;
+			}
+
+			/* If all xfers have the same multi-bus mode, we can optimize. */
+			if (multi_bus_mode == SPI_ENGINE_MULTI_BUS_MODE_UNKNOWN)
+				multi_bus_mode = xfer->multi_bus_mode;
+			else if (multi_bus_mode != xfer->multi_bus_mode)
+				multi_bus_mode = SPI_ENGINE_MULTI_BUS_MODE_CONFLICTING;
+		}
 	}
 
 	/*
@@ -297,6 +347,10 @@ static int spi_engine_precompile_message(struct spi_message *msg)
 			priv->bits_per_word = min_bits_per_word;
 		else
 			priv->bits_per_word = 0;
+
+		priv->multi_bus_mode = multi_bus_mode;
+		priv->primary_bus_mask = spi_engine_primary_bus_flag(msg->spi);
+		priv->all_bus_mask = spi_engine_all_bus_flags(msg->spi);
 	}
 
 	return 0;
@@ -310,6 +364,7 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 	struct spi_engine_offload *priv;
 	struct spi_transfer *xfer;
 	int clk_div, new_clk_div, inst_ns;
+	int prev_multi_bus_mode = SPI_MULTI_BUS_MODE_SINGLE;
 	bool keep_cs = false;
 	u8 bits_per_word = 0;
 
@@ -334,6 +389,7 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 		 * in the same way.
 		 */
 		bits_per_word = priv->bits_per_word;
+		prev_multi_bus_mode = priv->multi_bus_mode;
 	} else {
 		spi_engine_program_add_cmd(p, dry,
 			SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_CONFIG,
@@ -344,6 +400,24 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 	spi_engine_gen_cs(p, dry, spi, !xfer->cs_off);
 
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		if (xfer->rx_buf || xfer->offload_flags & SPI_OFFLOAD_XFER_RX_STREAM ||
+		    xfer->tx_buf || xfer->offload_flags & SPI_OFFLOAD_XFER_TX_STREAM) {
+			if (xfer->multi_bus_mode != prev_multi_bus_mode) {
+				u8 bus_flags = spi_engine_primary_bus_flag(spi);
+
+				if (xfer->multi_bus_mode == SPI_MULTI_BUS_MODE_STRIPE)
+					bus_flags = spi_engine_all_bus_flags(spi);
+
+				spi_engine_program_add_cmd(p, dry,
+					SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDI_MASK,
+							     bus_flags));
+				spi_engine_program_add_cmd(p, dry,
+					SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDO_MASK,
+							     bus_flags));
+			}
+			prev_multi_bus_mode = xfer->multi_bus_mode;
+		}
+
 		new_clk_div = host->max_speed_hz / xfer->effective_speed_hz;
 		if (new_clk_div != clk_div) {
 			clk_div = new_clk_div;
@@ -360,7 +434,7 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 					bits_per_word));
 		}
 
-		spi_engine_gen_xfer(p, dry, xfer);
+		spi_engine_gen_xfer(p, dry, xfer, spi->num_data_bus);
 		spi_engine_gen_sleep(p, dry, spi_delay_to_ns(&xfer->delay, xfer),
 				     inst_ns, xfer->effective_speed_hz);
 
@@ -394,6 +468,17 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 	if (clk_div != 1)
 		spi_engine_program_add_cmd(p, dry,
 			SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_CLK_DIV, 0));
+
+	/* Restore single bus mode unless offload disable will restore it later. */
+	if (prev_multi_bus_mode == SPI_MULTI_BUS_MODE_STRIPE &&
+	    (!msg->offload || priv->multi_bus_mode != SPI_MULTI_BUS_MODE_STRIPE)) {
+		u8 bus_flags = spi_engine_primary_bus_flag(spi);
+
+		spi_engine_program_add_cmd(p, dry,
+			SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDI_MASK, bus_flags));
+		spi_engine_program_add_cmd(p, dry,
+			SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDO_MASK, bus_flags));
+	}
 }
 
 static void spi_engine_xfer_next(struct spi_message *msg,
@@ -799,6 +884,17 @@ static int spi_engine_setup(struct spi_device *device)
 	writel_relaxed(SPI_ENGINE_CMD_CS_INV(spi_engine->cs_inv),
 		       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
 
+	if (host->num_data_bus > 1) {
+		u8 bus_flags = spi_engine_primary_bus_flag(device);
+
+		writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDI_MASK,
+						    bus_flags),
+			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
+		writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDO_MASK,
+						    bus_flags),
+			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
+	}
+
 	/*
 	 * In addition to setting the flags, we have to do a CS assert command
 	 * to make the new setting actually take effect.
@@ -902,6 +998,15 @@ static int spi_engine_trigger_enable(struct spi_offload *offload)
 						    priv->bits_per_word),
 			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
 
+	if (priv->multi_bus_mode == SPI_MULTI_BUS_MODE_STRIPE) {
+		writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDI_MASK,
+						    priv->all_bus_mask),
+			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
+		writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDO_MASK,
+						    priv->all_bus_mask),
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
+	/* Restore single-bus mode. */
+	if (priv->multi_bus_mode == SPI_MULTI_BUS_MODE_STRIPE) {
+		writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDI_MASK,
+						    priv->primary_bus_mask),
+			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
+		writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDO_MASK,
+						    priv->primary_bus_mask),
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
+		host->num_data_bus = FIELD_GET(SPI_ENGINE_REG_DATA_WIDTH_NUM_OF_SDIO_MASK,
+					       data_width_reg_val);
 
 	if (host->max_speed_hz == 0)
 		return dev_err_probe(&pdev->dev, -EINVAL, "spi_clk rate is 0");

-- 
2.43.0


