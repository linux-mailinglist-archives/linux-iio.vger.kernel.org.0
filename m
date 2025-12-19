Return-Path: <linux-iio+bounces-27241-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B080CD2003
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 22:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CCA730B6E3E
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 21:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CFB344023;
	Fri, 19 Dec 2025 21:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OYBHwfmE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA8F17C77
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 21:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766180020; cv=none; b=jPzORsAXTFzvFnROWwr5TCABQF0gE3z1fhRLLix0nhS7t63NDD1CYLlkRHHDOnsIDOvxwl1zE7XSb6pAN9kgn1ttlhdOCGzV9OL6nbLJz7V0j8BaOSXW94F6EFQIzgl3wwv64JG2cAaJtnnvpjGfJiN3TmX1t7cSGYtJCH0Wpeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766180020; c=relaxed/simple;
	bh=dY7cp3RBBiVCkp9Kcc53brAEC9hdPWhw6DTjqjQNuOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sdCPi1XxbZru3AJLrguvmgLJnS51enM2U5FhA1F8pD2y1nxpsHpaJ/2twTb7FF8yno7SrcAmpzwHffiHJyUSUkX7dqzNjD3zRMk5s0Fd3uso7/IRNyE6Ll11U5h445c45nr+decUwcwGC/qufattenomUY0JjSj8YBu6U4yprkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OYBHwfmE; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c750b10e14so869253a34.2
        for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 13:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766180015; x=1766784815; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Z43oS2Jw0Ev4dfYo22by9u6LAdxn5XavRVOij2D4nc=;
        b=OYBHwfmEq716OpxS6FqQ3aBY2UuKnc0yNAHfFyN/KxzpndfNIqaTuQH1n3SwY9aWqJ
         fefzVPchGoywDJZ46oOWLtesBz1ABgSMraRPNC/3nS6DXoOn4swg69p/Y8WmhtTtbVnY
         LN3WECQOUolYLJaeq3gGTmb+H5Xyoj/5VsvutwHWGH/xG9LaFJjIrmFKzTwoo66hg6by
         epSNL/j351nTVGNuU5X69eEQ3JIrKVww3hGkBRJIrz5LbenmfO4Y8p867nLfwM7bOwRP
         ne82WgySl/dPYqsoKk3SLfshQzSSym57jlkyF2/FKtSepjYgSxH6+ItrGjJCTObICVux
         GMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766180015; x=1766784815;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3Z43oS2Jw0Ev4dfYo22by9u6LAdxn5XavRVOij2D4nc=;
        b=cZwuEtPdt29VFcSgqnUbme0OZY4AJCIRLcF1SuV0AUJO6bGliNTCa2Dz+34P7xPPdD
         5jvHUoSX9blTRe8bYZh9vcD7rHHCwEGrr95FC/aCYyWjbhhVYo/Bcwc8/tfVvyhplen5
         SyVsM9SVg3+UjP49NBQ1BDqBgIAd6+WkXp/RnZ+QculC47CzsSElkTFpk+e7bXMIkvLQ
         a2rw8DEqxTYiQ0SSwI8xc4uwaMssfLviE8RjpFN2S+vYGzww1bGkuRciKFwVt4THlZI3
         jRP4uJZ6m0YrBFj+42i23LDqD9mzRZbkDc8OPYY/481fh0BDf8fkbJiS4fvlI9eTOOpI
         khug==
X-Forwarded-Encrypted: i=1; AJvYcCXeDSgelVcMMuXI4vTBEblNVjLzp4knzLocmPC3V3Lro5nLqAQqBu0F9l6LrnZd1tumqWMmVe8uMxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9xWwxqMwG58GzW65FbYee3rsKnHDs7wxIOvx20FuJAl2Y6xvX
	xThe3kyZfa16R/4Qf4ue6dorHEQ+exBTZjIva+3WFy/AyuTxqdAf4clcj6yCmK1+7ag=
X-Gm-Gg: AY/fxX4/3bfr9HRQ0EsYU7GIlokn+jeazNzAzv2l1a9RBbWP8WMzlucwk8+bq5ZboFc
	jIw3M+UbhP+cJ/M2S9Hh1zOXcU8hb4GoTbRIOjfN8+6OO/Ev2xX2EVOBLo0ZsAyacKL7Eys88dX
	3c89Lc+VCno62vI60Mp6VnobcAlkVMWP2WhLfa2rNafJ/fI8A+RWx9f3fPE5mSAbNos/9zy5t8P
	LARzmNVyHDqymMZw3amWNrEV1YGdFz1PIsgWuZNw/YTysmKoeXI+Bxaj7DAsfGglYcRDbyHvT2o
	nHXK3ccsB9m5O5OoKOD/8RQuJYAhR58MMPuMgjYDUQx5T8vHdvk4Tm8r45mXvtZCUdUkhwwZ6cr
	Swoc39wcQ6ZFB3q/eiQCQ/SUuNyN8UumW0U1eHL3+TLfDb/e2yn1iPPYsVUg3ria3troUpc621x
	V4UFCxTDvmUN7rA/V+2+snW1TT
X-Google-Smtp-Source: AGHT+IEV2Y3TdkUjmquqF6HvA05aKkAArLkAjqKr0vCj0HIE8vG1QcO6ia3T+QJa2w3j6AwwMjeNgw==
X-Received: by 2002:a05:6830:3105:b0:7c7:6348:594a with SMTP id 46e09a7af769-7cc668e8135mr2423716a34.7.1766180015061;
        Fri, 19 Dec 2025 13:33:35 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:9b20:bac4:9680:435])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667563ffsm2485045a34.13.2025.12.19.13.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 13:33:34 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 19 Dec 2025 15:32:15 -0600
Subject: [PATCH v4 7/9] spi: axi-spi-engine: support
 SPI_MULTI_LANE_MODE_STRIPE
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-spi-add-multi-bus-support-v4-7-145dc5204cd8@baylibre.com>
References: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
In-Reply-To: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
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
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=12068;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=dY7cp3RBBiVCkp9Kcc53brAEC9hdPWhw6DTjqjQNuOU=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpRcSRlMrxU20bsdrnwA0lULCe3bQauFngTE13D
 Cztvrg/HdKJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaUXEkQAKCRDCzCAB/wGP
 wAYwB/9ZG35txJDZP6Mh2qj0HGLp4MngWr27B9x859qchxnuxg4Mdf9PGWo4QB5JyjIXpEWwerT
 AwEnsUnQVT7LM7du3wlzfxh5EKE5Zyq4kRGp8dKICL3W2u9H1hkgBLGIDaCpGc83QNf3vyi8469
 HAPkzivB8SKBp/1hJeYiLx1ZYO+0J3bwbO3cpEVhaf+PHC9iT4tqnepj4FzGFWIoCsxxAbf9VLC
 OKq/XuQ0xN2dFzjhFxKFF5hnMdXLnpQcGWMf7FPTTkiun8Yad9nFZci3yVc6JJZFXaVN4WG9MAq
 sRmGuv67klWTxgPuNzeL8Sio0c1fKWuJNBlF6svZLB0FI2xq
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
v4 changes:
* Update for core SPI API changes.

v3 changes:
* Renamed "buses" to "lanes" to reflect devicetree property name change.

v2 changes:
* Fixed off-by-one in SPI_ENGINE_REG_DATA_WIDTH_NUM_OF_SDIO_MASK GENMASK
---
 drivers/spi/spi-axi-spi-engine.c | 145 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 141 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index e06f412190fd..3028e6112909 100644
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
@@ -142,6 +151,11 @@ struct spi_engine_offload {
 	unsigned long flags;
 	unsigned int offload_num;
 	unsigned int spi_mode_config;
+	unsigned int multi_lane_mode;
+	u8 rx_primary_lane_mask;
+	u8 tx_primary_lane_mask;
+	u8 rx_all_lanes_mask;
+	u8 tx_all_lanes_mask;
 	u8 bits_per_word;
 };
 
@@ -165,6 +179,25 @@ struct spi_engine {
 	bool offload_requires_sync;
 };
 
+static void spi_engine_primary_lane_flag(struct spi_device *spi,
+					 u8 *rx_lane_flags, u8 *tx_lane_flags)
+{
+	*rx_lane_flags = BIT(spi->rx_lane_map[0]);
+	*tx_lane_flags = BIT(spi->tx_lane_map[0]);
+}
+
+static void spi_engine_all_lanes_flags(struct spi_device *spi,
+				       u8 *rx_lane_flags, u8 *tx_lane_flags)
+{
+	int i;
+
+	for (i = 0; i < spi->num_rx_lanes; i++)
+		*rx_lane_flags |= BIT(spi->rx_lane_map[i]);
+
+	for (i = 0; i < spi->num_tx_lanes; i++)
+		*tx_lane_flags |= BIT(spi->tx_lane_map[i]);
+}
+
 static void spi_engine_program_add_cmd(struct spi_engine_program *p,
 	bool dry, uint16_t cmd)
 {
@@ -193,7 +226,7 @@ static unsigned int spi_engine_get_config(struct spi_device *spi)
 }
 
 static void spi_engine_gen_xfer(struct spi_engine_program *p, bool dry,
-	struct spi_transfer *xfer)
+				struct spi_transfer *xfer, u32 num_lanes)
 {
 	unsigned int len;
 
@@ -204,6 +237,9 @@ static void spi_engine_gen_xfer(struct spi_engine_program *p, bool dry,
 	else
 		len = xfer->len / 4;
 
+	if (xfer->multi_lane_mode == SPI_MULTI_LANE_MODE_STRIPE)
+		len /= num_lanes;
+
 	while (len) {
 		unsigned int n = min(len, 256U);
 		unsigned int flags = 0;
@@ -269,6 +305,7 @@ static int spi_engine_precompile_message(struct spi_message *msg)
 {
 	unsigned int clk_div, max_hz = msg->spi->controller->max_speed_hz;
 	struct spi_transfer *xfer;
+	int multi_lane_mode = SPI_ENGINE_MULTI_BUS_MODE_UNKNOWN;
 	u8 min_bits_per_word = U8_MAX;
 	u8 max_bits_per_word = 0;
 
@@ -284,6 +321,24 @@ static int spi_engine_precompile_message(struct spi_message *msg)
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
@@ -297,6 +352,14 @@ static int spi_engine_precompile_message(struct spi_message *msg)
 			priv->bits_per_word = min_bits_per_word;
 		else
 			priv->bits_per_word = 0;
+
+		priv->multi_lane_mode = multi_lane_mode;
+		spi_engine_primary_lane_flag(msg->spi,
+					     &priv->rx_primary_lane_mask,
+					     &priv->tx_primary_lane_mask);
+		spi_engine_all_lanes_flags(msg->spi,
+					   &priv->rx_all_lanes_mask,
+					   &priv->tx_all_lanes_mask);
 	}
 
 	return 0;
@@ -310,6 +373,7 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 	struct spi_engine_offload *priv;
 	struct spi_transfer *xfer;
 	int clk_div, new_clk_div, inst_ns;
+	int prev_multi_lane_mode = SPI_MULTI_LANE_MODE_SINGLE;
 	bool keep_cs = false;
 	u8 bits_per_word = 0;
 
@@ -334,6 +398,7 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 		 * in the same way.
 		 */
 		bits_per_word = priv->bits_per_word;
+		prev_multi_lane_mode = priv->multi_lane_mode;
 	} else {
 		spi_engine_program_add_cmd(p, dry,
 			SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_CONFIG,
@@ -344,6 +409,28 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 	spi_engine_gen_cs(p, dry, spi, !xfer->cs_off);
 
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		if (xfer->rx_buf || xfer->offload_flags & SPI_OFFLOAD_XFER_RX_STREAM ||
+		    xfer->tx_buf || xfer->offload_flags & SPI_OFFLOAD_XFER_TX_STREAM) {
+			if (xfer->multi_lane_mode != prev_multi_lane_mode) {
+				u8 tx_lane_flags, rx_lane_flags;
+
+				if (xfer->multi_lane_mode == SPI_MULTI_LANE_MODE_STRIPE)
+					spi_engine_all_lanes_flags(spi, &rx_lane_flags,
+								   &tx_lane_flags);
+				else
+					spi_engine_primary_lane_flag(spi, &rx_lane_flags,
+								     &tx_lane_flags);
+
+				spi_engine_program_add_cmd(p, dry,
+					SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDI_MASK,
+							     rx_lane_flags));
+				spi_engine_program_add_cmd(p, dry,
+					SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDO_MASK,
+							     tx_lane_flags));
+			}
+			prev_multi_lane_mode = xfer->multi_lane_mode;
+		}
+
 		new_clk_div = host->max_speed_hz / xfer->effective_speed_hz;
 		if (new_clk_div != clk_div) {
 			clk_div = new_clk_div;
@@ -360,7 +447,7 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 					bits_per_word));
 		}
 
-		spi_engine_gen_xfer(p, dry, xfer);
+		spi_engine_gen_xfer(p, dry, xfer, spi->num_rx_lanes);
 		spi_engine_gen_sleep(p, dry, spi_delay_to_ns(&xfer->delay, xfer),
 				     inst_ns, xfer->effective_speed_hz);
 
@@ -394,6 +481,19 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 	if (clk_div != 1)
 		spi_engine_program_add_cmd(p, dry,
 			SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_CLK_DIV, 0));
+
+	/* Restore single lane mode unless offload disable will restore it later. */
+	if (prev_multi_lane_mode == SPI_MULTI_LANE_MODE_STRIPE &&
+	    (!msg->offload || priv->multi_lane_mode != SPI_MULTI_LANE_MODE_STRIPE)) {
+		u8 rx_lane_flags, tx_lane_flags;
+
+		spi_engine_primary_lane_flag(spi, &rx_lane_flags, &tx_lane_flags);
+
+		spi_engine_program_add_cmd(p, dry,
+			SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDI_MASK, rx_lane_flags));
+		spi_engine_program_add_cmd(p, dry,
+			SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDO_MASK, tx_lane_flags));
+	}
 }
 
 static void spi_engine_xfer_next(struct spi_message *msg,
@@ -799,6 +899,19 @@ static int spi_engine_setup(struct spi_device *device)
 	writel_relaxed(SPI_ENGINE_CMD_CS_INV(spi_engine->cs_inv),
 		       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
 
+	if (host->num_data_lanes > 1) {
+		u8 rx_lane_flags, tx_lane_flags;
+
+		spi_engine_primary_lane_flag(device, &rx_lane_flags, &tx_lane_flags);
+
+		writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDI_MASK,
+						    rx_lane_flags),
+			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
+		writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDO_MASK,
+						    tx_lane_flags),
+			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
+	}
+
 	/*
 	 * In addition to setting the flags, we have to do a CS assert command
 	 * to make the new setting actually take effect.
@@ -902,6 +1015,15 @@ static int spi_engine_trigger_enable(struct spi_offload *offload)
 						    priv->bits_per_word),
 			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
 
+	if (priv->multi_lane_mode == SPI_MULTI_LANE_MODE_STRIPE) {
+		writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDI_MASK,
+						    priv->rx_all_lanes_mask),
+			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
+		writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDO_MASK,
+						    priv->tx_all_lanes_mask),
+			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
+	}
+
 	writel_relaxed(SPI_ENGINE_CMD_SYNC(1),
 		spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
 
@@ -929,6 +1051,16 @@ static void spi_engine_trigger_disable(struct spi_offload *offload)
 	reg &= ~SPI_ENGINE_OFFLOAD_CTRL_ENABLE;
 	writel_relaxed(reg, spi_engine->base +
 			    SPI_ENGINE_REG_OFFLOAD_CTRL(priv->offload_num));
+
+	/* Restore single-lane mode. */
+	if (priv->multi_lane_mode == SPI_MULTI_LANE_MODE_STRIPE) {
+		writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDI_MASK,
+						    priv->rx_primary_lane_mask),
+			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
+		writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDO_MASK,
+						    priv->tx_primary_lane_mask),
+			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
+	}
 }
 
 static struct dma_chan
@@ -973,7 +1105,7 @@ static int spi_engine_probe(struct platform_device *pdev)
 {
 	struct spi_engine *spi_engine;
 	struct spi_controller *host;
-	unsigned int version;
+	unsigned int version, data_width_reg_val;
 	int irq, ret;
 
 	irq = platform_get_irq(pdev, 0);
@@ -1042,7 +1174,7 @@ static int spi_engine_probe(struct platform_device *pdev)
 		return PTR_ERR(spi_engine->base);
 
 	version = readl(spi_engine->base + ADI_AXI_REG_VERSION);
-	if (ADI_AXI_PCORE_VER_MAJOR(version) != 1) {
+	if (ADI_AXI_PCORE_VER_MAJOR(version) > 2) {
 		dev_err(&pdev->dev, "Unsupported peripheral version %u.%u.%u\n",
 			ADI_AXI_PCORE_VER_MAJOR(version),
 			ADI_AXI_PCORE_VER_MINOR(version),
@@ -1050,6 +1182,8 @@ static int spi_engine_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	data_width_reg_val = readl(spi_engine->base + SPI_ENGINE_REG_DATA_WIDTH);
+
 	if (adi_axi_pcore_ver_gteq(version, 1, 1)) {
 		unsigned int sizes = readl(spi_engine->base +
 				SPI_ENGINE_REG_OFFLOAD_MEM_ADDR_WIDTH);
@@ -1097,6 +1231,9 @@ static int spi_engine_probe(struct platform_device *pdev)
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


