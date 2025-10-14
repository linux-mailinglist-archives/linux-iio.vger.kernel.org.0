Return-Path: <linux-iio+bounces-25068-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9B7BDB8BF
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 00:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E9C94E99A0
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 22:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DF130E0E5;
	Tue, 14 Oct 2025 22:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ihgx14zf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B67D30DD26
	for <linux-iio@vger.kernel.org>; Tue, 14 Oct 2025 22:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760479391; cv=none; b=dYxqiUamcCgHXu1URlJwy3tAkgD1Q3odw1nJ/fhfTM4b4MqAvYcTjaxb9IUHDYDz9dl0FrFNisCi+41qkVrJZBbgzOxnkRQqcySRc+Pjg56HEl7mJ+20XZ6ZG5zGKEab/rYbPRIkQImmsNk1/lDvWvEMDEfY/20xgnmUFlARwbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760479391; c=relaxed/simple;
	bh=iGxHppXly7+UoE2cBj7yYdo8IZtZeXEYkEYsYgmyiE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cg6xeXnrL7/om72tRS7eEsRIssfpKPvidsAk8EbUa3wKNFtvq78L6LO8RYgNQaGa3tfFLHQ2HbFGrv8nIfOJuPBRnFbVQeigjQ1rII5l88csQ30KJj4Q/zsPxa9upqXOBhmldoXTV6oP++sQuu8zu/pZDuAe+/bkQb3xV8kz3YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ihgx14zf; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-43f8116a130so2721062b6e.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Oct 2025 15:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760479388; x=1761084188; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hVSX3wg6D3BZrSjhShOGc77c905d3gx9lJ4+Vh4Rc0I=;
        b=Ihgx14zf4zi9Fozs82D6BJVvx4cBCT66+9tK7ouOJpjPzcR2bDv70KGn9mXyJaUczH
         dBjbLnSLWILmiuUOLKa5JCxIrhFcpTCLtTJetUgk9J7EI6WuV+xMzzh2x4r2p6k4Q+NV
         F50bQSPnA97sCdf46XaHNSd90N/0C2fP1E5mpt/Yb03JsHdWn8imgE3BAm+6btAgnAjZ
         vAguh4YpRC29nAFmsOZGCqAgto5FrOFo5w1UToLbV7zOs6w6TpAylRGq+IK56UqYRcFW
         4qDguw+Gg/PJTmPzLoLL5eVoudHT5fvO67hfXK9LDCxPbEoE8EGlwzObdk49G+qnOMZr
         RGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760479388; x=1761084188;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVSX3wg6D3BZrSjhShOGc77c905d3gx9lJ4+Vh4Rc0I=;
        b=UU/5YB6fFciWXg3I3LntV5huV9ZPSppCuhxLf0ReSCy9jQCHbT2SH1ekPMNJIurDYn
         FF3yAa1FjXYBteF+eBLiH+ZwOyJzBL2nM0kQKEQwzRQV9n1EEvlVZZQKSf3KIbXx5jRZ
         cZiWYJusolmG/3ascrCmkLchmgcuujXaofka0cssjAC4QWDO8llmzDEAw6ckHlE1l2Vp
         sxPmytOvq3PxtDLaXN1IfMS6eTA5avewtd8snkGRqMYZzPsibq5FVm2IMshheZfsR4SR
         0Xb1nj2zDyEiCp/Bl3oWFwmCUxcOj5iU0x7ncHmzmgvhjXRLTBAZXzPakqklm57IXQeD
         aOvA==
X-Forwarded-Encrypted: i=1; AJvYcCWxDluMz5l5BJ+Lu5+cQtucEoEtkpLACoqHZPkYKdJg8wRvzCfd63Sb0CBFXKeRY+F/T209FKoh2Q0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyv0C/wwo+qzD95RjQtv978TSzFP8zVtQUNrhnp5VQrM2giHyC
	hQRcV+NgYvwKiKMhYxKH+NK4+hTbnC/qfFEwPDKzf/zVdTGHjyBKriQDe1A7C2TgTSE=
X-Gm-Gg: ASbGnct1p5Dz/y3Lv9FlcUE/gVYVZzPKZYnbzhgyBgpT94nLOi/T1W2O9UL860F1C7a
	lWRHPrOkGBPqQIEh7vjskYiQbJUo1x8U+4M5d8NE0bt1bmE8LzOslKF5Lgfbw29CuNt+ZfdzPQe
	bXo2dWev82j1A0yWn23PYO7975pzZcpUAOZTh5sar5gxCuwLyKmkIsmdt9GklXzGDtE7wwHAgqA
	5rjq/g8NB80moSF+acg/UJXt5IwFmmGx8wFtmVRyVbXFzDppl0l+IHek3IQHc+69k5QUvgRJEdA
	E26bZz20krqpO34Ki4eL/EwSNquxFfZtS8vePB9ApUpH6J+1ReynQHo5Vhoxsq0UB/O8fK9tE91
	CeZ4Qjja+sNyu/t8cKPmdpFvL1W6oo6Abmn/ZgPMcZaQ9GQ==
X-Google-Smtp-Source: AGHT+IGAQ7GlpbimDDSmc47OA0bbTqFwaI93ZqDVLWNcq+QZf0I5cJUk4XRH+LP83KceT6m1ioy99Q==
X-Received: by 2002:a05:6808:309b:b0:438:4117:a863 with SMTP id 5614622812f47-4417b3da67amr12184659b6e.39.1760479387691;
        Tue, 14 Oct 2025 15:03:07 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:c482:1912:c2de:367e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4419895119bsm3593732b6e.21.2025.10.14.15.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 15:03:07 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 14 Oct 2025 17:02:14 -0500
Subject: [PATCH 4/6] spi: axi-spi-engine: support SPI_MULTI_BUS_MODE_STRIPE
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-spi-add-multi-bus-support-v1-4-2098c12d6f5f@baylibre.com>
References: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
In-Reply-To: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11170;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=iGxHppXly7+UoE2cBj7yYdo8IZtZeXEYkEYsYgmyiE0=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBo7siAJVNddMdmXJwLNUAUIA83WvwWdd2kd0ks2
 EejqmFQB5mJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaO7IgAAKCRDCzCAB/wGP
 wAU1CACCt040Gtyu52rLDqsniwxAEPZjotnXxBhlkLlF/D1/zB6BHEBjVRYUjz745halxHTwph6
 1G87TU/Jt80oUfubcm+83xWR7pIF1VRDj57lZZ1QzwxDLRBGJaG1kPmFP6HeNRv3h3baxDGG8nL
 N35Z47oCius4Utd0f0Cgf6B3pIugmcB9XsSVFevxlWLCrsZcPxCWN5uB2hbMonCRgmsXngi9gki
 /q7LV6nUduK605pycpbes2SKSLhQyEpm1eqJc7NlGbBO+MN8CY5/uW7NgdCgMRL3l24UB7xpYJj
 8RJvTulh9OFkE4Da+UJbaDJgx+fOjnWcmJ/z3IOAzyPEyDBo
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
 drivers/spi/spi-axi-spi-engine.c | 128 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 124 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index e06f412190fd243161a0b3df992f26157531f6a1..707e5108efec41f7eff608a09fcebd9d28fa2d70 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -23,6 +23,9 @@
 #include <linux/spi/spi.h>
 #include <trace/events/spi.h>
 
+#define SPI_ENGINE_REG_DATA_WIDTH		0x0C
+#define   SPI_ENGINE_REG_DATA_WIDTH_NUM_OF_SDIO_MASK	GENMASK(24, 16)
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


