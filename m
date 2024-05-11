Return-Path: <linux-iio+bounces-4946-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3E78C2E22
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 02:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4C81C2122A
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 00:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B752F22;
	Sat, 11 May 2024 00:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="G/vOyQCS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1053417993
	for <linux-iio@vger.kernel.org>; Sat, 11 May 2024 00:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715388605; cv=none; b=G8xXfwyhVz/WltmgjumdsrwrZC06KpASAZiFYXYTvZAFtwKdOJRmtUy03jo9XC7jxS1MQ7lobyfuHHWyT0drgr2cP1ZIGFetugz2r3wSZo+o0rVL+1uwP5DIHv5wkf58NizQeDzjQuB7cxVmbx0viCRdOhbjMQoITCEGypqhGUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715388605; c=relaxed/simple;
	bh=jbDclhJ4Ltz6ZIxwFk59d4Jg2Ugn8KcUJw9iSCDHoOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iHe9LMMnniJevViQGK0DSzcwZkoxBm2fUKPWyL71+o0LKScexOl/uB3e47ztTCKdfTuAJ+Jr8zvMxu6xE0VN4fgBXcnjjYuWwS8aQY3TeVPERya0TPhKzcTx034qMLPYr7m+KPGjpQFn+sDQI5CaiBr8MYsUFnS4Gak3L7oe0js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=G/vOyQCS; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c98820fc92so1179307b6e.1
        for <linux-iio@vger.kernel.org>; Fri, 10 May 2024 17:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715388602; x=1715993402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4udCyI6Qf35BCwIyLv7+9qZLaDg57Ov9S/WGjBd7b4=;
        b=G/vOyQCSJmalYI8BtwMcqgeCoKL/bFvAowtdzpJz1PJru6f3eTCJKlGsTmLYlC/qbF
         A49c9RGczMPY+6xvWzpOL+DQmIc2x68NB0DSWitlWKYQJdVHyXb87b0E6NGaitCH7KCh
         qoaBrCA23sF6Jc4UFYGcwn7vkJj38yTYg9i9nbtapkIa1dWiSWJRNEfdAa9c5DIgL3NL
         REXf5y2PIj6RU9Xa3sE9ksC43BVkCQXZKW7HpjngZoRlwD0KczsSzK3qvwMZEVIlYYqC
         bUIfPV6t9w/PpJcPXY8HO/nUJUHkAu+SwxwpKVEvvaEMhNLlnZDQoJ7KALVwA+MT2KWH
         GYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715388602; x=1715993402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4udCyI6Qf35BCwIyLv7+9qZLaDg57Ov9S/WGjBd7b4=;
        b=WQv0EtGPkqqaI9dCwkrmZfPecxyvR69AQ0imetw7EuqEDGEU2P7g72PK896mYgrjHg
         UYSoI9YGxGy1j7xyvAIq88HWrx7Tw/Fsq7bW9RF9xe/1TjKsa8+D3h3AOCUbEI8cJWjM
         N+3D0pUAFtZIrqDX8XG7NgGtRJbY/CJ4HZeGgzgCHDJc04G5Fq4FVQoAGqtHFq0diK46
         kJNTRdnVM/7lJkThblEwLrM7XUtrZg5+u/bhnSCNzqYU8/tohkVWLgWTIG2FYkwEs/mo
         YnKRiYdNCm9hFedAWfmRxQLi3FFh4XHsH+wcZQhMt+g+EV49s4IyRpr6aGnV7DQr1yde
         1/iw==
X-Forwarded-Encrypted: i=1; AJvYcCWWyvxP50GyVV3bx2EtZYN3LFlnwURFxnJTrzPXJ+VhMGojHSZhB2/qn0g4dR4fMaLGDKHzuSK5Bxrnm58WmmtKRXn7hDifcB5T
X-Gm-Message-State: AOJu0Yx8ykoBBFajlhIDV+WdoxF7A+MsavKe776Fo91qGz/cBEU6DCR9
	Bf5xsI7VW3Wsi9JT27tQ/cX7ZIEzDTCXBYt0nJeAgr9zytuMlZtQmgQR9CdCUQpqAdOy/kn/gJd
	ZBCQ=
X-Google-Smtp-Source: AGHT+IGjahhfc8kV980Ug9+SQb7W2MTT4ztWS460Tcv/qBM3UEkIaIx+68c/zVIPIHDpTlI0koIHpg==
X-Received: by 2002:a05:6808:180a:b0:3c7:4613:9913 with SMTP id 5614622812f47-3c98d906880mr3409340b6e.10.1715388602094;
        Fri, 10 May 2024 17:50:02 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b29015a3dbsm321132eaf.46.2024.05.10.17.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 17:50:01 -0700 (PDT)
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
Subject: [PATCH RFC v2 6/8] spi: axi-spi-engine: add offload support
Date: Fri, 10 May 2024 19:44:29 -0500
Message-ID: <20240510-dlech-mainline-spi-engine-offload-2-v2-6-8707a870c435@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com>
References: <20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This implements SPI offload support for the AXI SPI Engine. Currently,
the hardware only supports triggering offload transfers with a hardware
trigger so attempting to use an offload message in the regular SPI
message queue will fail. Also, only allows streaming rx data to an
external sink, so attempts to use a rx_buf in the offload message will
fail.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes:

This patch has been reworked to accommodate the changes described in all
of the other patches.
---
 drivers/spi/spi-axi-spi-engine.c | 267 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 264 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index e358ac5b4509..95327df572a0 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -2,6 +2,7 @@
 /*
  * SPI-Engine SPI controller driver
  * Copyright 2015 Analog Devices Inc.
+ * Copyright 2024 BayLibre, SAS
  *  Author: Lars-Peter Clausen <lars@metafoo.de>
  */
 
@@ -16,6 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 
+#define SPI_ENGINE_REG_OFFLOAD_MEM_ADDR_WIDTH	0x10
 #define SPI_ENGINE_REG_RESET			0x40
 
 #define SPI_ENGINE_REG_INT_ENABLE		0x80
@@ -23,6 +25,7 @@
 #define SPI_ENGINE_REG_INT_SOURCE		0x88
 
 #define SPI_ENGINE_REG_SYNC_ID			0xc0
+#define SPI_ENGINE_REG_OFFLOAD_SYNC_ID		0xc4
 
 #define SPI_ENGINE_REG_CMD_FIFO_ROOM		0xd0
 #define SPI_ENGINE_REG_SDO_FIFO_ROOM		0xd4
@@ -33,10 +36,24 @@
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
@@ -74,6 +91,10 @@
 #define SPI_ENGINE_CMD_SYNC(id) \
 	SPI_ENGINE_CMD(SPI_ENGINE_INST_MISC, SPI_ENGINE_MISC_SYNC, (id))
 
+/* default sizes - can be changed when SPI Engine firmware is compiled */
+#define SPI_ENGINE_OFFLOAD_CMD_FIFO_SIZE	16
+#define SPI_ENGINE_OFFLOAD_SDO_FIFO_SIZE	16
+
 struct spi_engine_program {
 	unsigned int length;
 	uint16_t instructions[] __counted_by(length);
@@ -101,6 +122,12 @@ struct spi_engine_message_state {
 	uint8_t *rx_buf;
 };
 
+struct spi_engine_offload {
+	struct spi_device *spi;
+	unsigned int id;
+	bool prepared;
+};
+
 struct spi_engine {
 	struct clk *clk;
 	struct clk *ref_clk;
@@ -111,6 +138,10 @@ struct spi_engine {
 	struct spi_engine_message_state msg_state;
 	struct completion msg_complete;
 	unsigned int int_enable;
+
+	unsigned int offload_ctrl_mem_size;
+	unsigned int offload_sdo_mem_size;
+	struct spi_engine_offload offload_priv[SPI_ENGINE_MAX_NUM_OFFLOADS];
 };
 
 static void spi_engine_program_add_cmd(struct spi_engine_program *p,
@@ -154,7 +185,7 @@ static void spi_engine_gen_xfer(struct spi_engine_program *p, bool dry,
 
 		if (xfer->tx_buf)
 			flags |= SPI_ENGINE_TRANSFER_WRITE;
-		if (xfer->rx_buf)
+		if (xfer->rx_buf || (xfer->offload_flags & SPI_OFFLOAD_XFER_RX_STREAM))
 			flags |= SPI_ENGINE_TRANSFER_READ;
 
 		spi_engine_program_add_cmd(p, dry,
@@ -202,16 +233,24 @@ static void spi_engine_gen_cs(struct spi_engine_program *p, bool dry,
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
@@ -503,8 +542,11 @@ static irqreturn_t spi_engine_irq(int irq, void *devid)
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
@@ -539,6 +581,11 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
 	unsigned int int_enable = 0;
 	unsigned long flags;
 
+	if (msg->offload) {
+		dev_err(&host->dev, "Single transfer offload not supported\n");
+		return -EOPNOTSUPP;
+	}
+
 	/* reinitialize message state for this transfer */
 	memset(st, 0, sizeof(*st));
 	st->cmd_buf = p->instructions;
@@ -579,6 +626,204 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
 	return msg->status;
 }
 
+static struct spi_engine_offload *spi_engine_get_offload(struct spi_device *spi,
+							 unsigned int id,
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
+		if (priv->spi == spi && priv->id == id) {
+			*offload_num = i;
+			return priv;
+		}
+	}
+
+	return ERR_PTR(-ENODEV);
+}
+
+static int spi_engine_offload_map_channel(struct spi_device *spi,
+					  unsigned int id,
+					  unsigned int channel)
+{
+	struct spi_controller *host = spi->controller;
+	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
+	struct spi_engine_offload *priv;
+
+	if (channel >= SPI_ENGINE_MAX_NUM_OFFLOADS)
+		return -EINVAL;
+
+	priv = &spi_engine->offload_priv[channel];
+
+	if (priv->spi)
+		return -EBUSY;
+
+	priv->spi = spi;
+	priv->id = id;
+
+	return 0;
+}
+
+static int spi_engine_offload_prepare(struct spi_device *spi, unsigned int id,
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
+	cmd_addr = spi_engine->base + SPI_ENGINE_REG_OFFLOAD_CMD_FIFO(priv->id);
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
+static void spi_engine_offload_unprepare(struct spi_device *spi, unsigned int id)
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
+static int spi_engine_offload_enable(struct spi_device *spi, unsigned int id)
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
+static void spi_engine_offload_disable(struct spi_device *spi, unsigned int id)
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
+static const struct spi_controller_offload_ops spi_engine_offload_ops = {
+	.map_channel = spi_engine_offload_map_channel,
+	.prepare = spi_engine_offload_prepare,
+	.unprepare = spi_engine_offload_unprepare,
+	.hw_trigger_enable = spi_engine_offload_enable,
+	.hw_trigger_disable = spi_engine_offload_disable,
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
+		if (priv->spi == spi)
+			priv->spi = NULL;
+	}
+}
+
 static void spi_engine_release_hw(void *p)
 {
 	struct spi_engine *spi_engine = p;
@@ -630,6 +875,19 @@ static int spi_engine_probe(struct platform_device *pdev)
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
@@ -652,6 +910,9 @@ static int spi_engine_probe(struct platform_device *pdev)
 	host->optimize_message = spi_engine_optimize_message;
 	host->unoptimize_message = spi_engine_unoptimize_message;
 	host->num_chipselect = 8;
+	host->offload_xfer_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+	host->offload_ops = &spi_engine_offload_ops;
+	host->cleanup = spi_engine_cleanup;
 
 	if (host->max_speed_hz == 0)
 		return dev_err_probe(&pdev->dev, -EINVAL, "spi_clk rate is 0");

-- 
2.43.2


