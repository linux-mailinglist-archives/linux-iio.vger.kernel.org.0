Return-Path: <linux-iio+bounces-27650-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8077CD147B3
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 18:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DBAB9300AAC6
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 17:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFDB37F72C;
	Mon, 12 Jan 2026 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zNRLtCMz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1AC30F7F0
	for <linux-iio@vger.kernel.org>; Mon, 12 Jan 2026 17:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240001; cv=none; b=PdAvnjnrD+pen6yBDe6jOwJH83FwloYMIbujqFasCIJqtmY0NJlysf3Dg4pcrzsayTuM6r93xXgqW40LVBFe1xY0I0T7g3mLWJblOadFOaDvtJDWXibozLu6Sef5RusK2eWojwYro66U9xqEK2jPsswgFt4+ZGv06Db1tOWlXk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240001; c=relaxed/simple;
	bh=MVsDQFH2OsHI6nzdX0cat5az8qPnbZtSXWv8CsLqz2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Epc3yVxhE1YW4CSOkk/s9E+VCGl4X3fx994LLuE4yRa7eNJyN83X4euj4Nw64mCMecJeW/SlGUeLWtf6VlbCKUu1zsEluwpOupGYX4xKcIpiQT4q2uK4YW5bndHZv3nufOs1QedfXR92L9XUJHSMm6JERH/O/fi/G3HxO0FqdG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zNRLtCMz; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-3f4f9ea26aaso5073384fac.0
        for <linux-iio@vger.kernel.org>; Mon, 12 Jan 2026 09:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768239997; x=1768844797; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HmKXsoki/VhflIbyQc4ST4EE0k/E3vaHih8A+QqR2LE=;
        b=zNRLtCMzKZgJ1NmlLuQhvd10NpdkITFdoEFujSwHxVstoxm8Pvlgj0kotJrwamy3bJ
         eStdOquSasyta5Dl7z6KFRrM949Enmozt+oG3dQONg8hse3KzbPdtmwCC1gJOMEN41rU
         CVzzx1f9SrOb8uL3eKFIAoP7PpudZ2oG1BFYH8updvaHjLq96OzUmut54XSapqHbg2Dh
         dCe2Y4ClPHBXm8fR4GIkCKT0czx4I4udeMOeMzoQZAhZtbnJGc2FGqnPABIJXpvmX59z
         sxtDlR4q+m14aURkF3kpqulsziSCs3+KlOtaoa64nsxGkuv4iYtElA/ANBrQD6HfyeEj
         lQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768239997; x=1768844797;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HmKXsoki/VhflIbyQc4ST4EE0k/E3vaHih8A+QqR2LE=;
        b=FbeEtuvyGP9y7PwZAaL8SG5WZi2b3XIKYhTu7OI2vGnDgo0hU6TeFPlrktjevoYzMt
         8eUuAOm0gupfiyEHroKSjoBLYl/g68WhQsKPY5BZvynf5eV84BCRCYbn3+EgVvZDzZQR
         nm2IUDCbDutDnnMZuVO97PPIwXJPTi4cvPCecq4DS+WN5kMyI5QwmEqhbOAAtyoy/VRM
         LCxJms1K3AvpRgWmTll1OeopkaJglHTbqeRN/2DURBYwOqDAlFABagMFb13mxGBRxfpN
         wEk4qCyqo1F1sstbiy5qteaqM2GZOFVtFpL7kN+MHB86p34tsFDLyo1zHp0Tnrbx1Mu0
         juiA==
X-Forwarded-Encrypted: i=1; AJvYcCUhNbg/MjH0FMaWA4Nlgig0G44pmWIryrl7zxCmolaAYZXnWee58lB9OjJFvnDXzwvdBN5J35J7Z6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBvk3kXzwFHOIx1D2bQNIBBzQ/3upG0+fYTum9KJGse/nfBBd8
	EKTf546JrdgyUSHpDvCfMj8EtdpBKq9JsEzvpZmgE2nAr+ZwSbneeaaCyw57ad0jc84=
X-Gm-Gg: AY/fxX5Uhberqkv0IaQReVyCuLjOJ9rNLUPvHpfuh4EabfLGoHXLloqc8203piBsGSZ
	EgB+uiHPHQQLoP+4trUUv26FgHrL2PYlshPbGtG/entq2StT6NNv0uWptKl6zTSFk0w+8uEUfzO
	JSDA3TEWTMBxd9wFVQM1A8Ro5CVS7eTAu0BL6Tc/2xxx/Tszx+PHmBtaEgn02t6bAEqEdfg8bHC
	rEA5EUcLRgiPUiAnDj8xKcXQyk3czqd6+aLPBvYj1QuSbehZg3QffxsIkH/Z68zBSPA5EYIPt+W
	rNX7ft3IeGUAqo1lxcOM/bfdbnAbGWklvE/kyCTmWk92C0aYUYcDCrAE8LVupR31CO3xRMnS11k
	ZjLvPdwn/QxAiX0Gv9EriOXz8HgEdBJJ1nvh0AwIXV08j0g7/La8Xp4J+dWX456Xqeol+nr+fat
	G96qsFx3toUP5+95A=
X-Google-Smtp-Source: AGHT+IHDAluGdahbvyLPZLvCK4N93Hgdp1InyurG6jyBTL+3ZHFyvo0Ik+mB3pEu8hHs/Ff2X+K6aQ==
X-Received: by 2002:a05:6871:2ea5:b0:3ec:3437:e395 with SMTP id 586e51a60fabf-3ffc09515e6mr9188063fac.17.1768239997384;
        Mon, 12 Jan 2026 09:46:37 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:6b4b:49b3:cce5:b58f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4de40bfsm12126941fac.5.2026.01.12.09.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 09:46:37 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 12 Jan 2026 11:45:25 -0600
Subject: [PATCH v5 7/9] spi: axi-spi-engine: support
 SPI_MULTI_LANE_MODE_STRIPE
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-spi-add-multi-bus-support-v5-7-295f4f09f6ba@baylibre.com>
References: <20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com>
In-Reply-To: <20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12127;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=MVsDQFH2OsHI6nzdX0cat5az8qPnbZtSXWv8CsLqz2E=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpZTNfWnPyjZQpLULSfA2Mt8nAud3GUtKxnHbq5
 Df1OxHFp36JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaWUzXwAKCRDCzCAB/wGP
 wLe+CACDQk0ctEIjRuGKOGuiJwS8rgn6HNWOrMZAsM2EOc4Pd+zibbWGzspuqVPQlW2Vjh2cKkn
 n4HaVZPzXplr9vH4OJy980dY7OjKknclBHzYyhLV92CkNcxGiQuhHEJzxk6t6rkOz4b3BHqdeh5
 zzTV5kGgRndjrawldLUQfpzeXs5izIrMDrb4iZ1++EIOMYU9Y2yg+H1XNxHmt6+FZp9IaomsmI+
 ijvzDD0FqiLo/JERPJuYUSG07lRbmn7cyHDvPDe2CNik75Ea53Jq79ZUxQHow2BQccXp3Q1KvOw
 74Qj3OCh0B2+DCUtkNkEok2ulVO9q8SuyLID5DcAD0TNhFQd
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add support for SPI_MULTI_LANE_MODE_STRIPE to the AXI SPI engine driver.

The v2.0.0 version of the AXI SPI Engine IP core supports multiple
lanes. This can be used with SPI_MULTI_LANE_MODE_STRIPE to support
reading from simultaneous sampling ADCs that have a separate SDO line
for each analog channel. This allows reading all channels at the same
time to increase throughput.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
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


