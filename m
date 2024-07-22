Return-Path: <linux-iio+bounces-7808-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D5693962B
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2024 00:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEE39B2243F
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 22:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1931C824B1;
	Mon, 22 Jul 2024 22:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vwwCs2M/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DBA4F5FB
	for <linux-iio@vger.kernel.org>; Mon, 22 Jul 2024 22:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721685695; cv=none; b=g15LEzuFPHVXODk5+naz4X0VJ5WBcMJGyhrvVSYaHFiqsA/qC7G8BHxkBWKtqfvbDx1520HWtRo1WpYrQ+Z9JUFDtuQ3Haa/AuMLF4y9qyDyzaSqXEfP5empY1q0OZ6I/1C8p5Y269Klo1bx6ienEMDU3+Q0g+suVeBkMBvQ8lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721685695; c=relaxed/simple;
	bh=SvKLi9sLW623rbV1m/jcD8qu//tOAi7B0p04n7P2Gv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qz3JsU8MkPUt7wKzfy1yeRr5ipIIDUdgZTOy/lOYdES5ygvdDmGxj53MfbI7WG0J70Dk7/N7cFQ8XLcTAbYgcURtimJLWpm8ZfNazCUmDSh+kpSPhoTUURl/R29xEdkJA6YHvB8HN0rI8h74o1KXg9z1B7URJSPMI8/IE/XCuBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vwwCs2M/; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-260f81f7fb5so2414104fac.0
        for <linux-iio@vger.kernel.org>; Mon, 22 Jul 2024 15:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721685691; x=1722290491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMO2ZzHCP5mlBdbeKR/leL11Eacudeaje7AAQ9UAw44=;
        b=vwwCs2M/A1xmgz91s8b8t3fT2Qv/FOEXmD7A4n5sIslDDkzylsePEg5S9xCpUEyZhy
         VbKR/4r8qTs48skA3T2TJSfqYJGOdByuDKLbCC9kAsciMeOVj8k7Op6ctNbqVNcRHPNX
         y042NwCoiZoVUwCG6SrYQ3+XJW+RpnqMS+aGv1A7P4gfqhKR+YOCNTg5YVwQFZTsyGOT
         mLOLysC5kgBfi28oT3KZlft4NXNYQNAH+TxIEqgN31OX1Kbt4C+L3irOwOAuLaKGWS80
         DbvIMeO1RQJ0j7HOppobdVCA6sJ9OSlzpe4fzSWT6Nlhhn27uJtFN2AkrTJ7vI/cTuYh
         6RmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721685691; x=1722290491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMO2ZzHCP5mlBdbeKR/leL11Eacudeaje7AAQ9UAw44=;
        b=JJZFrbAXCXj2bAAkxMTGWLKGuxOVGENEweuZXD+pwOC1i6r89Bgd5llQgV3lKVJYJY
         in1yw5j1nmq8yzq47ZwnC+2VInTz5xwbA1KwJ3gUk0Ao1a2ULNdGQALOwj+eWq8kbLku
         9k4sp3hq8UPdlYWxIDIvWK9dz/W+Tq3p/BLkfn8/RwInP5k9dsjT19d1lAcPCWpliG1y
         CPJRXqo76CHgw6oTh5eprefuvqEiK8u5XMcBji1mVbjAm4plh00UKucn0CsP+t3ozEqO
         BAuJKFvlIkjyqLZ8MjvT54GDGVHW7R0KDzfMzS3mDkTTF92eVd4GsynPXkTxaap/Eldf
         BOyg==
X-Forwarded-Encrypted: i=1; AJvYcCUit8xRnqBfPoB0oFLL8MZLSN5NW7jGEUDVRCcmwXIF8XbiRMgHDDxju7xGK9q7lndemUjyCrPC1wLhN/VnAd1X1HYFQG6LbZGP
X-Gm-Message-State: AOJu0Yz0Ingkh11rJzWxLQergN/zcMmYNj07yT7R0kK7VAaUleS1e/c/
	C0V4v7k2pU54/3yXjLVdo7kjkXD41BcxAzRS+G0TENcnFAJGQEMCK6jSS8VznAc=
X-Google-Smtp-Source: AGHT+IH1OF3bo9lWzo3JeDYPQ8RSTeCYa8FY/+7dJXY2MAT9oYx8cxOm3ljjhIPR4hIV1QaKOKGlmQ==
X-Received: by 2002:a05:6870:5254:b0:25d:7cc4:caa8 with SMTP id 586e51a60fabf-26121321cedmr8454104fac.10.1721685691415;
        Mon, 22 Jul 2024 15:01:31 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708f60a55e1sm1719911a34.11.2024.07.22.15.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 15:01:31 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH RFC v3 6/9] spi: axi-spi-engine: implement offload support
Date: Mon, 22 Jul 2024 16:57:13 -0500
Message-ID: <20240722-dlech-mainline-spi-engine-offload-2-v3-6-7420e45df69b@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
References: <20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

This implements SPI offload support for the AXI SPI Engine. Currently,
the hardware only supports triggering offload transfers with a hardware
trigger so attempting to use an offload message in the regular SPI
message queue will fail. Also, only allows streaming rx data to an
external sink, so attempts to use a rx_buf in the offload message will
fail.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v3 changes:
* Added clk and dma_chan getter callbacks.
* Fixed some bugs.

v2 changes:

This patch has been reworked to accommodate the changes described in all
of the other patches.
---
 drivers/spi/spi-axi-spi-engine.c | 341 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 337 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index cb3fdcbca2be..314f3afb9357 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -2,11 +2,13 @@
 /*
  * SPI-Engine SPI controller driver
  * Copyright 2015 Analog Devices Inc.
+ * Copyright 2024 BayLibre, SAS
  *  Author: Lars-Peter Clausen <lars@metafoo.de>
  */
 
 #include <linux/clk.h>
 #include <linux/completion.h>
+#include <linux/dmaengine.h>
 #include <linux/fpga/adi-axi-common.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -16,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 
+#define SPI_ENGINE_REG_OFFLOAD_MEM_ADDR_WIDTH	0x10
 #define SPI_ENGINE_REG_RESET			0x40
 
 #define SPI_ENGINE_REG_INT_ENABLE		0x80
@@ -23,6 +26,7 @@
 #define SPI_ENGINE_REG_INT_SOURCE		0x88
 
 #define SPI_ENGINE_REG_SYNC_ID			0xc0
+#define SPI_ENGINE_REG_OFFLOAD_SYNC_ID		0xc4
 
 #define SPI_ENGINE_REG_CMD_FIFO_ROOM		0xd0
 #define SPI_ENGINE_REG_SDO_FIFO_ROOM		0xd4
@@ -33,10 +37,24 @@
 #define SPI_ENGINE_REG_SDI_DATA_FIFO		0xe8
 #define SPI_ENGINE_REG_SDI_DATA_FIFO_PEEK	0xec
 
+#define SPI_ENGINE_MAX_NUM_OFFLOADS		32
+
+#define SPI_ENGINE_REG_OFFLOAD_CTRL(x)		(0x100 + SPI_ENGINE_MAX_NUM_OFFLOADS * (x))
+#define SPI_ENGINE_REG_OFFLOAD_STATUS(x)	(0x104 + SPI_ENGINE_MAX_NUM_OFFLOADS * (x))
+#define SPI_ENGINE_REG_OFFLOAD_RESET(x)		(0x108 + SPI_ENGINE_MAX_NUM_OFFLOADS * (x))
+#define SPI_ENGINE_REG_OFFLOAD_CMD_FIFO(x)	(0x110 + SPI_ENGINE_MAX_NUM_OFFLOADS * (x))
+#define SPI_ENGINE_REG_OFFLOAD_SDO_FIFO(x)	(0x114 + SPI_ENGINE_MAX_NUM_OFFLOADS * (x))
+
+#define SPI_ENGINE_SPI_OFFLOAD_MEM_WIDTH_SDO	GENMASK(15, 8)
+#define SPI_ENGINE_SPI_OFFLOAD_MEM_WIDTH_CMD	GENMASK(7, 0)
+
 #define SPI_ENGINE_INT_CMD_ALMOST_EMPTY		BIT(0)
 #define SPI_ENGINE_INT_SDO_ALMOST_EMPTY		BIT(1)
 #define SPI_ENGINE_INT_SDI_ALMOST_FULL		BIT(2)
 #define SPI_ENGINE_INT_SYNC			BIT(3)
+#define SPI_ENGINE_INT_OFFLOAD_SYNC		BIT(4)
+
+#define SPI_ENGINE_OFFLOAD_CTRL_ENABLE		BIT(0)
 
 #define SPI_ENGINE_CONFIG_CPHA			BIT(0)
 #define SPI_ENGINE_CONFIG_CPOL			BIT(1)
@@ -77,6 +95,10 @@
 #define SPI_ENGINE_CMD_CS_INV(flags) \
 	SPI_ENGINE_CMD(SPI_ENGINE_INST_CS_INV, 0, (flags))
 
+/* default sizes - can be changed when SPI Engine firmware is compiled */
+#define SPI_ENGINE_OFFLOAD_CMD_FIFO_SIZE	16
+#define SPI_ENGINE_OFFLOAD_SDO_FIFO_SIZE	16
+
 struct spi_engine_program {
 	unsigned int length;
 	uint16_t instructions[] __counted_by(length);
@@ -104,6 +126,12 @@ struct spi_engine_message_state {
 	uint8_t *rx_buf;
 };
 
+struct spi_engine_offload {
+	struct spi_device *spi;
+	const char *id;
+	bool prepared;
+};
+
 struct spi_engine {
 	struct clk *clk;
 	struct clk *ref_clk;
@@ -116,6 +144,10 @@ struct spi_engine {
 	unsigned int int_enable;
 	/* shadows hardware CS inversion flag state */
 	u8 cs_inv;
+
+	unsigned int offload_ctrl_mem_size;
+	unsigned int offload_sdo_mem_size;
+	struct spi_engine_offload offload_priv[SPI_ENGINE_MAX_NUM_OFFLOADS];
 };
 
 static void spi_engine_program_add_cmd(struct spi_engine_program *p,
@@ -159,7 +191,7 @@ static void spi_engine_gen_xfer(struct spi_engine_program *p, bool dry,
 
 		if (xfer->tx_buf)
 			flags |= SPI_ENGINE_TRANSFER_WRITE;
-		if (xfer->rx_buf)
+		if (xfer->rx_buf || (xfer->offload_flags & SPI_OFFLOAD_XFER_RX_STREAM))
 			flags |= SPI_ENGINE_TRANSFER_READ;
 
 		spi_engine_program_add_cmd(p, dry,
@@ -211,16 +243,24 @@ static void spi_engine_gen_cs(struct spi_engine_program *p, bool dry,
  *
  * NB: This is separate from spi_engine_compile_message() because the latter
  * is called twice and would otherwise result in double-evaluation.
+ *
+ * Returns 0 on success, -EINVAL on failure.
  */
-static void spi_engine_precompile_message(struct spi_message *msg)
+static int spi_engine_precompile_message(struct spi_message *msg)
 {
 	unsigned int clk_div, max_hz = msg->spi->controller->max_speed_hz;
 	struct spi_transfer *xfer;
 
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		/* If we have an offload transfer, we can't rx to buffer */
+		if (msg->offload && xfer->rx_buf)
+			return -EINVAL;
+
 		clk_div = DIV_ROUND_UP(max_hz, xfer->speed_hz);
 		xfer->effective_speed_hz = max_hz / min(clk_div, 256U);
 	}
+
+	return 0;
 }
 
 static void spi_engine_compile_message(struct spi_message *msg, bool dry,
@@ -518,8 +558,11 @@ static irqreturn_t spi_engine_irq(int irq, void *devid)
 static int spi_engine_optimize_message(struct spi_message *msg)
 {
 	struct spi_engine_program p_dry, *p;
+	int ret;
 
-	spi_engine_precompile_message(msg);
+	ret = spi_engine_precompile_message(msg);
+	if (ret)
+		return ret;
 
 	p_dry.length = 0;
 	spi_engine_compile_message(msg, true, &p_dry);
@@ -531,7 +574,7 @@ static int spi_engine_optimize_message(struct spi_message *msg)
 	spi_engine_compile_message(msg, false, p);
 
 	spi_engine_program_add_cmd(p, false, SPI_ENGINE_CMD_SYNC(
-						AXI_SPI_ENGINE_CUR_MSG_SYNC_ID));
+		msg->offload ? 0 : AXI_SPI_ENGINE_CUR_MSG_SYNC_ID));
 
 	msg->opt_state = p;
 
@@ -577,6 +620,12 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
 	unsigned int int_enable = 0;
 	unsigned long flags;
 
+	if (msg->offload) {
+		dev_err(&host->dev, "Single transfer offload not supported\n");
+		msg->status = -EOPNOTSUPP;
+		goto out;
+	}
+
 	/* reinitialize message state for this transfer */
 	memset(st, 0, sizeof(*st));
 	st->cmd_buf = p->instructions;
@@ -612,11 +661,279 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
 		msg->status = -ETIMEDOUT;
 	}
 
+out:
 	spi_finalize_current_message(host);
 
 	return msg->status;
 }
 
+static bool spi_engine_offload_id_eq(const char *id1, const char *id2)
+{
+	if (!id1 && !id2)
+		return true;
+
+	if (!id1 || !id2)
+		return false;
+
+	return strcmp(id1, id2) == 0;
+}
+
+static struct spi_engine_offload *spi_engine_get_offload(struct spi_device *spi,
+							 const char *id,
+							 unsigned int *offload_num)
+{
+	struct spi_controller *host = spi->controller;
+	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
+	struct spi_engine_offload *priv;
+	int i;
+
+	for (i = 0; i < SPI_ENGINE_MAX_NUM_OFFLOADS; i++) {
+		priv = &spi_engine->offload_priv[i];
+
+		if (priv->spi == spi && spi_engine_offload_id_eq(priv->id, id)) {
+			*offload_num = i;
+			return priv;
+		}
+	}
+
+	return ERR_PTR(-ENODEV);
+}
+
+static int spi_engine_offload_map_channel(struct spi_device *spi,
+					  const char *id,
+					  const unsigned int *args,
+					  unsigned int num_args)
+{
+	struct spi_controller *host = spi->controller;
+	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
+	struct spi_engine_offload *priv;
+
+	if (num_args != 1)
+		return -EINVAL;
+
+	if (args[0] >= SPI_ENGINE_MAX_NUM_OFFLOADS)
+		return -EINVAL;
+
+	priv = &spi_engine->offload_priv[args[0]];
+
+	if (priv->spi)
+		return -EBUSY;
+
+	priv->spi = spi;
+
+	priv->id = kstrdup(id, GFP_KERNEL);
+	if (!priv->id && id)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int spi_engine_offload_prepare(struct spi_device *spi, const char *id,
+				      struct spi_message *msg)
+{
+	struct spi_controller *host = spi->controller;
+	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
+	struct spi_engine_program *p = msg->opt_state;
+	struct spi_engine_offload *priv;
+	struct spi_transfer *xfer;
+	void __iomem *cmd_addr;
+	void __iomem *sdo_addr;
+	size_t tx_word_count = 0;
+	unsigned int offload_num, i;
+
+	priv = spi_engine_get_offload(spi, id, &offload_num);
+	if (IS_ERR(priv))
+		return PTR_ERR(priv);
+
+	if (priv->prepared)
+		return -EBUSY;
+
+	if (p->length > spi_engine->offload_ctrl_mem_size)
+		return -EINVAL;
+
+	/* count total number of tx words in message */
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		if (!xfer->tx_buf)
+			continue;
+
+		if (xfer->bits_per_word <= 8)
+			tx_word_count += xfer->len;
+		else if (xfer->bits_per_word <= 16)
+			tx_word_count += xfer->len / 2;
+		else
+			tx_word_count += xfer->len / 4;
+	}
+
+	if (tx_word_count > spi_engine->offload_sdo_mem_size)
+		return -EINVAL;
+
+	cmd_addr = spi_engine->base + SPI_ENGINE_REG_OFFLOAD_CMD_FIFO(offload_num);
+	sdo_addr = spi_engine->base + SPI_ENGINE_REG_OFFLOAD_SDO_FIFO(offload_num);
+
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		if (!xfer->tx_buf)
+			continue;
+
+		if (xfer->bits_per_word <= 8) {
+			const u8 *buf = xfer->tx_buf;
+
+			for (i = 0; i < xfer->len; i++)
+				writel_relaxed(buf[i], sdo_addr);
+		} else if (xfer->bits_per_word <= 16) {
+			const u16 *buf = xfer->tx_buf;
+
+			for (i = 0; i < xfer->len / 2; i++)
+				writel_relaxed(buf[i], sdo_addr);
+		} else {
+			const u32 *buf = xfer->tx_buf;
+
+			for (i = 0; i < xfer->len / 4; i++)
+				writel_relaxed(buf[i], sdo_addr);
+		}
+	}
+
+	for (i = 0; i < p->length; i++)
+		writel_relaxed(p->instructions[i], cmd_addr);
+
+	msg->offload_state = (void *)(intptr_t)offload_num;
+	priv->prepared = true;
+
+	return 0;
+}
+
+static void spi_engine_offload_unprepare(struct spi_device *spi, const char *id)
+{
+	struct spi_controller *host = spi->controller;
+	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
+	struct spi_engine_offload *priv;
+	unsigned int offload_num;
+
+	priv = spi_engine_get_offload(spi, id, &offload_num);
+	if (IS_ERR(priv)) {
+		dev_warn(&spi->dev, "failed match offload in unprepare\n");
+		return;
+	}
+
+	writel_relaxed(1, spi_engine->base + SPI_ENGINE_REG_OFFLOAD_RESET(offload_num));
+	writel_relaxed(0, spi_engine->base + SPI_ENGINE_REG_OFFLOAD_RESET(offload_num));
+
+	priv->prepared = false;
+}
+
+static int spi_engine_hw_trigger_mode_enable(struct spi_device *spi,
+					     const char *id)
+{
+	struct spi_controller *host = spi->controller;
+	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
+	struct spi_engine_offload *priv;
+	unsigned int offload_num, reg;
+
+	priv = spi_engine_get_offload(spi, id, &offload_num);
+	if (IS_ERR(priv))
+		return PTR_ERR(priv);
+
+	reg = readl_relaxed(spi_engine->base +
+			    SPI_ENGINE_REG_OFFLOAD_CTRL(offload_num));
+	reg |= SPI_ENGINE_OFFLOAD_CTRL_ENABLE;
+	writel_relaxed(reg, spi_engine->base +
+			    SPI_ENGINE_REG_OFFLOAD_CTRL(offload_num));
+
+	return 0;
+}
+
+static void spi_engine_hw_trigger_mode_disable(struct spi_device *spi,
+					       const char *id)
+{
+	struct spi_controller *host = spi->controller;
+	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
+	struct spi_engine_offload *priv;
+	unsigned int offload_num, reg;
+
+	priv = spi_engine_get_offload(spi, id, &offload_num);
+	if (IS_ERR(priv)) {
+		dev_warn(&spi->dev, "failed match offload in disable\n");
+		return;
+	}
+
+	reg = readl_relaxed(spi_engine->base +
+			    SPI_ENGINE_REG_OFFLOAD_CTRL(offload_num));
+	reg &= ~SPI_ENGINE_OFFLOAD_CTRL_ENABLE;
+	writel_relaxed(reg, spi_engine->base +
+			    SPI_ENGINE_REG_OFFLOAD_CTRL(offload_num));
+}
+
+static struct clk *spi_engine_hw_trigger_get_clk(struct spi_device *spi,
+						 const char *id)
+{
+	struct spi_controller *host = spi->controller;
+	struct spi_engine_offload *priv;
+	struct of_phandle_args clkspec;
+	unsigned int offload_num;
+	struct clk *clk;
+	int ret;
+
+	priv = spi_engine_get_offload(spi, id, &offload_num);
+	if (IS_ERR(priv))
+		return ERR_CAST(priv);
+
+	ret = of_parse_phandle_with_args(host->dev.of_node, "trigger-sources",
+					 "#trigger-source-cells", offload_num,
+					 &clkspec);
+	if (ret)
+		return ERR_PTR(ret);
+
+	clk = of_clk_get_from_provider(&clkspec);
+
+	of_node_put(clkspec.np);
+
+	return clk;
+}
+
+static struct dma_chan *spi_engine_rx_stream_get_dma_chan(struct spi_device *spi,
+							  const char *id)
+{
+	struct spi_controller *host = spi->controller;
+	struct spi_engine_offload *priv;
+	unsigned int offload_num;
+	char channel_name[16];
+
+	priv = spi_engine_get_offload(spi, id, &offload_num);
+	if (IS_ERR(priv))
+		return ERR_CAST(priv);
+
+	snprintf(channel_name, sizeof(channel_name), "offload%d-rx", offload_num);
+
+	return dma_request_chan(&host->dev, channel_name);
+}
+
+static const struct spi_controller_offload_ops spi_engine_offload_ops = {
+	.map_channel = spi_engine_offload_map_channel,
+	.prepare = spi_engine_offload_prepare,
+	.unprepare = spi_engine_offload_unprepare,
+	.hw_trigger_mode_enable = spi_engine_hw_trigger_mode_enable,
+	.hw_trigger_mode_disable = spi_engine_hw_trigger_mode_disable,
+	.hw_trigger_get_clk = spi_engine_hw_trigger_get_clk,
+	.rx_stream_get_dma_chan = spi_engine_rx_stream_get_dma_chan,
+};
+
+static void spi_engine_cleanup(struct spi_device *spi)
+{
+	struct spi_controller *host = spi->controller;
+	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
+	int i;
+
+	/* remove spi device to offload mapping */
+	for (i = 0; i < SPI_ENGINE_MAX_NUM_OFFLOADS; i++) {
+		struct spi_engine_offload *priv = &spi_engine->offload_priv[i];
+
+		if (priv->spi == spi) {
+			priv->spi = NULL;
+			kfree(priv->id);
+			priv->id = NULL;
+		}
+	}
+}
+
 static void spi_engine_release_hw(void *p)
 {
 	struct spi_engine *spi_engine = p;
@@ -668,6 +985,19 @@ static int spi_engine_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	if (ADI_AXI_PCORE_VER_MINOR(version) >= 1) {
+		unsigned int sizes = readl(spi_engine->base +
+				SPI_ENGINE_REG_OFFLOAD_MEM_ADDR_WIDTH);
+
+		spi_engine->offload_ctrl_mem_size = 1 <<
+			FIELD_GET(SPI_ENGINE_SPI_OFFLOAD_MEM_WIDTH_CMD, sizes);
+		spi_engine->offload_sdo_mem_size = 1 <<
+			FIELD_GET(SPI_ENGINE_SPI_OFFLOAD_MEM_WIDTH_SDO, sizes);
+	} else {
+		spi_engine->offload_ctrl_mem_size = SPI_ENGINE_OFFLOAD_CMD_FIFO_SIZE;
+		spi_engine->offload_sdo_mem_size = SPI_ENGINE_OFFLOAD_SDO_FIFO_SIZE;
+	}
+
 	writel_relaxed(0x00, spi_engine->base + SPI_ENGINE_REG_RESET);
 	writel_relaxed(0xff, spi_engine->base + SPI_ENGINE_REG_INT_PENDING);
 	writel_relaxed(0x00, spi_engine->base + SPI_ENGINE_REG_INT_ENABLE);
@@ -690,6 +1020,9 @@ static int spi_engine_probe(struct platform_device *pdev)
 	host->optimize_message = spi_engine_optimize_message;
 	host->unoptimize_message = spi_engine_unoptimize_message;
 	host->num_chipselect = 8;
+	host->offload_xfer_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+	host->offload_ops = &spi_engine_offload_ops;
+	host->cleanup = spi_engine_cleanup;
 
 	/* Some features depend of the IP core version. */
 	if (ADI_AXI_PCORE_VER_MINOR(version) >= 2) {

-- 
2.43.0


