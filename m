Return-Path: <linux-iio+bounces-15138-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F29F3A2CDB3
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 21:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05615188DC07
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 20:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7642C1CDA2E;
	Fri,  7 Feb 2025 20:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tFyh9WDJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B015E1B87CE
	for <linux-iio@vger.kernel.org>; Fri,  7 Feb 2025 20:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738958980; cv=none; b=hQCn0ahwCh/wqjK787Di6AxQ94acTWZ4wjPZkWJl3PE2c+18D2yodS/e3DrDa9FQF/R0sEeldyMILHMBZgHnVtxo8O0IGX697ISAAwLDNjkix+/zxdr1TYTZexbxgSwNrCuuplxVFtbB/YWuFjyDIhzyRqROHw8xzHwDF82RHag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738958980; c=relaxed/simple;
	bh=NRqFiM3QjO3Fp/YY3y2grSjrL3x/SL2k0bUmxCtGjVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ol5o0+nt/Voaf2dmAvFYnKELVIhm5uMx6l/akbUbXISa2WZFlP+Y904ACZ5fZG1Rlnru870at5Tb8N904VGc70EhWiL1zH9PAG1Thhdf1hAQGCEJMlV3oI0D2WUukbJvuLRmVhsCez2xbrXVi7EsT4J2iuGpdLVL+phIsF85Nuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tFyh9WDJ; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5fa8fa48f30so1861924eaf.3
        for <linux-iio@vger.kernel.org>; Fri, 07 Feb 2025 12:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738958977; x=1739563777; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ObILQH9FbMWvsQ/CeWvY5SvzqmzkmCw57uFYf0o7RC8=;
        b=tFyh9WDJ056qG1IIXNTFiV1++OYTtK58tCgea328hJENPSZdpTGbYWOkx2gei8pvZd
         sGgJx45yR954l4/JrC5dSDKW9JCnjxRq6I6whmF70SHqQtbMC4CpbacbYBXAZxOAcHqV
         gglYT42X731RPPaU8TRHjygjRe7W5wsvcSSb4U8erhXM2sr9nx+JedX73uULCGJL97z+
         zTW5L5GIFczBQ0qZ/+MCHgbavK2GQo6wb0Qm2sL6xEBxCFNbFB0RKigRXLRnyz/G9oYz
         RhDyzxdBxB+a3eGYrNsEzdU1kbXKntNl4DG1mrqfsTfbkioTE24dctK8eEd4Pp24bexX
         R30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738958977; x=1739563777;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ObILQH9FbMWvsQ/CeWvY5SvzqmzkmCw57uFYf0o7RC8=;
        b=o62kAYAF7CLU0QMzey4RkR09y3upKhL2o2nXy+zO4PiTFfnPwhNeGOnzikHTBqMSEh
         1Tbnyp5USIJYnicHaI2SKnIrF4qifLetXA8Tr72FeWZrkceZmQPMPkwY8gXJovSF98hb
         DMFJCPKt1bGWumnYLqyL88T3OC1D7jExJC7E4QpZaiRC1TPvU4NHOU/pW9CgUqb191D9
         VXEI1Y+O9ggKSro1vvHgGJ7S+YVsc4hq3riSkBaoUjMc19KgZtvk2JEcx0H9+WeYB0pA
         bsq3mP1WTJ3bSv9YYd3+uZnRcgdTgJk2dHoVRbxWnrJhbEVZXbI1JiWsCBRwouy5EzhM
         CQ6g==
X-Forwarded-Encrypted: i=1; AJvYcCVii/roDmwcVyxZlY0AnKna3KvJbsYB5Jxomd1RhJZR089OSybq54XdMB+j7CZd6Lj5fvF0+YIc8IQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMrvUEudc4r3wH+kdHlx6uXm57QKvplWD2zx4DqZNnjNwRLVre
	08RFPmsIjnJXjmQ+TZ4RvS97nXHJB05Aol1Q9bqUvsmACQJxcLcKmlcJ3DdBCuk=
X-Gm-Gg: ASbGncsmutQGR5mWuOP4hq4GJdZTn4qL+2yMe9rq0jgEpvic2deLsF4kSwYB6bRVoYp
	VcP6IoaYqfu5iRA+t/yp6cgMWoE63lPNRdb5BhPnfLtvjrTo1QPxCIh4+a51JA8IPGRLQ+p++gi
	HIF2K6MP5QDjU8nlw8c6HF+tFfu+bEQS5TXfqalWirQR6j8BTkNtDghhULjpo6M7WQgb0SDX+7M
	jUqZt5jpE8LlprbckvQtxgyOxagnU74tSl/Mt7wOsJTnuAoTuW++773AWxE4gBXqk6NQMNTJiu5
	c3N27mFJHCX/J6trBM6XEfKmuip2c895DFJl0gZ7xM0b10A=
X-Google-Smtp-Source: AGHT+IGPIrnvIEj1XCuBfKqz49HAprJI9YtGjp+82WbYlRu8zED9HMKJoLYJiPmraNGeix0vBLCuow==
X-Received: by 2002:a05:6820:1809:b0:5f6:fcd2:1359 with SMTP id 006d021491bc7-5fc5e6b2a65mr2926706eaf.3.1738958976645;
        Fri, 07 Feb 2025 12:09:36 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc544b08d4sm930387eaf.2.2025.02.07.12.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 12:09:36 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Feb 2025 14:09:04 -0600
Subject: [PATCH v8 07/17] spi: axi-spi-engine: implement offload support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-dlech-mainline-spi-engine-offload-2-v8-7-e48a489be48c@baylibre.com>
References: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
In-Reply-To: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Implement SPI offload support for the AXI SPI Engine. Currently, the
hardware only supports triggering offload transfers with a hardware
trigger so attempting to use an offload message in the regular SPI
message queue will fail. Also, only allows streaming rx data to an
external sink, so attempts to use a rx_buf in the offload message will
fail.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v8 changes:
* Add missing bitfield.h include (fixes CI failure)

v7 changes: none

v6 changes:
* Update for split spi/offload headers.

v5 changes:
* Set offload capability flags based on DT properties.
* Add support for TX DMA since the hardware supports that now.
* Update for changes in other patches in the series.

v4 changes:
* Adapted to changes in other patches in the series.
* Moved trigger enable/disable to same function as offload
  enable/disable.

v3 changes:
* Added clk and dma_chan getter callbacks.
* Fixed some bugs.

v2 changes:

This patch has been reworked to accommodate the changes described in all
of the other patches.
---
 drivers/spi/Kconfig              |   1 +
 drivers/spi/spi-axi-spi-engine.c | 315 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 309 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 2cfc14be869790f5226130428bb7cb40aadfb031..f496ab127ef011d092f66063e05772725ab89771 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -179,6 +179,7 @@ config SPI_AU1550
 config SPI_AXI_SPI_ENGINE
 	tristate "Analog Devices AXI SPI Engine controller"
 	depends on HAS_IOMEM
+	select SPI_OFFLOAD
 	help
 	  This enables support for the Analog Devices AXI SPI Engine SPI controller.
 	  It is part of the SPI Engine framework that is used in some Analog Devices
diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 7c252126b33ea83fe6a6e80c6cb87499243069f5..da9840957778579dad3286f493abad87ad8a3bfc 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -2,11 +2,15 @@
 /*
  * SPI-Engine SPI controller driver
  * Copyright 2015 Analog Devices Inc.
+ * Copyright 2024 BayLibre, SAS
  *  Author: Lars-Peter Clausen <lars@metafoo.de>
  */
 
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
+#include <linux/dmaengine.h>
 #include <linux/fpga/adi-axi-common.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -14,9 +18,11 @@
 #include <linux/module.h>
 #include <linux/overflow.h>
 #include <linux/platform_device.h>
+#include <linux/spi/offload/provider.h>
 #include <linux/spi/spi.h>
 #include <trace/events/spi.h>
 
+#define SPI_ENGINE_REG_OFFLOAD_MEM_ADDR_WIDTH	0x10
 #define SPI_ENGINE_REG_RESET			0x40
 
 #define SPI_ENGINE_REG_INT_ENABLE		0x80
@@ -24,6 +30,7 @@
 #define SPI_ENGINE_REG_INT_SOURCE		0x88
 
 #define SPI_ENGINE_REG_SYNC_ID			0xc0
+#define SPI_ENGINE_REG_OFFLOAD_SYNC_ID		0xc4
 
 #define SPI_ENGINE_REG_CMD_FIFO_ROOM		0xd0
 #define SPI_ENGINE_REG_SDO_FIFO_ROOM		0xd4
@@ -34,10 +41,24 @@
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
@@ -79,6 +100,10 @@
 #define SPI_ENGINE_CMD_CS_INV(flags) \
 	SPI_ENGINE_CMD(SPI_ENGINE_INST_CS_INV, 0, (flags))
 
+/* default sizes - can be changed when SPI Engine firmware is compiled */
+#define SPI_ENGINE_OFFLOAD_CMD_FIFO_SIZE	16
+#define SPI_ENGINE_OFFLOAD_SDO_FIFO_SIZE	16
+
 struct spi_engine_program {
 	unsigned int length;
 	uint16_t instructions[] __counted_by(length);
@@ -106,6 +131,17 @@ struct spi_engine_message_state {
 	uint8_t *rx_buf;
 };
 
+enum {
+	SPI_ENGINE_OFFLOAD_FLAG_ASSIGNED,
+	SPI_ENGINE_OFFLOAD_FLAG_PREPARED,
+};
+
+struct spi_engine_offload {
+	struct spi_engine *spi_engine;
+	unsigned long flags;
+	unsigned int offload_num;
+};
+
 struct spi_engine {
 	struct clk *clk;
 	struct clk *ref_clk;
@@ -118,6 +154,11 @@ struct spi_engine {
 	unsigned int int_enable;
 	/* shadows hardware CS inversion flag state */
 	u8 cs_inv;
+
+	unsigned int offload_ctrl_mem_size;
+	unsigned int offload_sdo_mem_size;
+	struct spi_offload *offload;
+	u32 offload_caps;
 };
 
 static void spi_engine_program_add_cmd(struct spi_engine_program *p,
@@ -163,9 +204,9 @@ static void spi_engine_gen_xfer(struct spi_engine_program *p, bool dry,
 		unsigned int n = min(len, 256U);
 		unsigned int flags = 0;
 
-		if (xfer->tx_buf)
+		if (xfer->tx_buf || (xfer->offload_flags & SPI_OFFLOAD_XFER_TX_STREAM))
 			flags |= SPI_ENGINE_TRANSFER_WRITE;
-		if (xfer->rx_buf)
+		if (xfer->rx_buf || (xfer->offload_flags & SPI_OFFLOAD_XFER_RX_STREAM))
 			flags |= SPI_ENGINE_TRANSFER_READ;
 
 		spi_engine_program_add_cmd(p, dry,
@@ -217,16 +258,24 @@ static void spi_engine_gen_cs(struct spi_engine_program *p, bool dry,
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
@@ -521,11 +570,105 @@ static irqreturn_t spi_engine_irq(int irq, void *devid)
 	return IRQ_HANDLED;
 }
 
+static int spi_engine_offload_prepare(struct spi_message *msg)
+{
+	struct spi_controller *host = msg->spi->controller;
+	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
+	struct spi_engine_program *p = msg->opt_state;
+	struct spi_engine_offload *priv = msg->offload->priv;
+	struct spi_transfer *xfer;
+	void __iomem *cmd_addr;
+	void __iomem *sdo_addr;
+	size_t tx_word_count = 0;
+	unsigned int i;
+
+	if (p->length > spi_engine->offload_ctrl_mem_size)
+		return -EINVAL;
+
+	/* count total number of tx words in message */
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		/* no support for reading to rx_buf */
+		if (xfer->rx_buf)
+			return -EINVAL;
+
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
+	if (tx_word_count && !(spi_engine->offload_caps & SPI_OFFLOAD_CAP_TX_STATIC_DATA))
+		return -EINVAL;
+
+	if (tx_word_count > spi_engine->offload_sdo_mem_size)
+		return -EINVAL;
+
+	/*
+	 * This protects against calling spi_optimize_message() with an offload
+	 * that has already been prepared with a different message.
+	 */
+	if (test_and_set_bit_lock(SPI_ENGINE_OFFLOAD_FLAG_PREPARED, &priv->flags))
+		return -EBUSY;
+
+	cmd_addr = spi_engine->base +
+		   SPI_ENGINE_REG_OFFLOAD_CMD_FIFO(priv->offload_num);
+	sdo_addr = spi_engine->base +
+		   SPI_ENGINE_REG_OFFLOAD_SDO_FIFO(priv->offload_num);
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
+	return 0;
+}
+
+static void spi_engine_offload_unprepare(struct spi_offload *offload)
+{
+	struct spi_engine_offload *priv = offload->priv;
+	struct spi_engine *spi_engine = priv->spi_engine;
+
+	writel_relaxed(1, spi_engine->base +
+			  SPI_ENGINE_REG_OFFLOAD_RESET(priv->offload_num));
+	writel_relaxed(0, spi_engine->base +
+			  SPI_ENGINE_REG_OFFLOAD_RESET(priv->offload_num));
+
+	clear_bit_unlock(SPI_ENGINE_OFFLOAD_FLAG_PREPARED, &priv->flags);
+}
+
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
@@ -537,20 +680,61 @@ static int spi_engine_optimize_message(struct spi_message *msg)
 	spi_engine_compile_message(msg, false, p);
 
 	spi_engine_program_add_cmd(p, false, SPI_ENGINE_CMD_SYNC(
-						AXI_SPI_ENGINE_CUR_MSG_SYNC_ID));
+		msg->offload ? 0 : AXI_SPI_ENGINE_CUR_MSG_SYNC_ID));
 
 	msg->opt_state = p;
 
+	if (msg->offload) {
+		ret = spi_engine_offload_prepare(msg);
+		if (ret) {
+			msg->opt_state = NULL;
+			kfree(p);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
 static int spi_engine_unoptimize_message(struct spi_message *msg)
 {
+	if (msg->offload)
+		spi_engine_offload_unprepare(msg->offload);
+
 	kfree(msg->opt_state);
 
 	return 0;
 }
 
+static struct spi_offload
+*spi_engine_get_offload(struct spi_device *spi,
+			const struct spi_offload_config *config)
+{
+	struct spi_controller *host = spi->controller;
+	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
+	struct spi_engine_offload *priv;
+
+	if (!spi_engine->offload)
+		return ERR_PTR(-ENODEV);
+
+	if (config->capability_flags & ~spi_engine->offload_caps)
+		return ERR_PTR(-EINVAL);
+
+	priv = spi_engine->offload->priv;
+
+	if (test_and_set_bit_lock(SPI_ENGINE_OFFLOAD_FLAG_ASSIGNED, &priv->flags))
+		return ERR_PTR(-EBUSY);
+
+	return spi_engine->offload;
+}
+
+static void spi_engine_put_offload(struct spi_offload *offload)
+{
+	struct spi_engine_offload *priv = offload->priv;
+
+	clear_bit_unlock(SPI_ENGINE_OFFLOAD_FLAG_ASSIGNED, &priv->flags);
+}
+
 static int spi_engine_setup(struct spi_device *device)
 {
 	struct spi_controller *host = device->controller;
@@ -583,6 +767,12 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
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
@@ -632,11 +822,68 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
 			trace_spi_transfer_stop(msg, xfer);
 	}
 
+out:
 	spi_finalize_current_message(host);
 
 	return msg->status;
 }
 
+static int spi_engine_trigger_enable(struct spi_offload *offload)
+{
+	struct spi_engine_offload *priv = offload->priv;
+	struct spi_engine *spi_engine = priv->spi_engine;
+	unsigned int reg;
+
+	reg = readl_relaxed(spi_engine->base +
+			    SPI_ENGINE_REG_OFFLOAD_CTRL(priv->offload_num));
+	reg |= SPI_ENGINE_OFFLOAD_CTRL_ENABLE;
+	writel_relaxed(reg, spi_engine->base +
+			    SPI_ENGINE_REG_OFFLOAD_CTRL(priv->offload_num));
+	return 0;
+}
+
+static void spi_engine_trigger_disable(struct spi_offload *offload)
+{
+	struct spi_engine_offload *priv = offload->priv;
+	struct spi_engine *spi_engine = priv->spi_engine;
+	unsigned int reg;
+
+	reg = readl_relaxed(spi_engine->base +
+			    SPI_ENGINE_REG_OFFLOAD_CTRL(priv->offload_num));
+	reg &= ~SPI_ENGINE_OFFLOAD_CTRL_ENABLE;
+	writel_relaxed(reg, spi_engine->base +
+			    SPI_ENGINE_REG_OFFLOAD_CTRL(priv->offload_num));
+}
+
+static struct dma_chan
+*spi_engine_tx_stream_request_dma_chan(struct spi_offload *offload)
+{
+	struct spi_engine_offload *priv = offload->priv;
+	char name[16];
+
+	snprintf(name, sizeof(name), "offload%u-tx", priv->offload_num);
+
+	return dma_request_chan(offload->provider_dev, name);
+}
+
+static struct dma_chan
+*spi_engine_rx_stream_request_dma_chan(struct spi_offload *offload)
+{
+	struct spi_engine_offload *priv = offload->priv;
+	char name[16];
+
+	snprintf(name, sizeof(name), "offload%u-rx", priv->offload_num);
+
+	return dma_request_chan(offload->provider_dev, name);
+}
+
+static const struct spi_offload_ops spi_engine_offload_ops = {
+	.trigger_enable = spi_engine_trigger_enable,
+	.trigger_disable = spi_engine_trigger_disable,
+	.tx_stream_request_dma_chan = spi_engine_tx_stream_request_dma_chan,
+	.rx_stream_request_dma_chan = spi_engine_rx_stream_request_dma_chan,
+};
+
 static void spi_engine_release_hw(void *p)
 {
 	struct spi_engine *spi_engine = p;
@@ -651,8 +898,7 @@ static int spi_engine_probe(struct platform_device *pdev)
 	struct spi_engine *spi_engine;
 	struct spi_controller *host;
 	unsigned int version;
-	int irq;
-	int ret;
+	int irq, ret;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -667,6 +913,46 @@ static int spi_engine_probe(struct platform_device *pdev)
 	spin_lock_init(&spi_engine->lock);
 	init_completion(&spi_engine->msg_complete);
 
+	/*
+	 * REVISIT: for now, all SPI Engines only have one offload. In the
+	 * future, this should be read from a memory mapped register to
+	 * determine the number of offloads enabled at HDL compile time. For
+	 * now, we can tell if an offload is present if there is a trigger
+	 * source wired up to it.
+	 */
+	if (device_property_present(&pdev->dev, "trigger-sources")) {
+		struct spi_engine_offload *priv;
+
+		spi_engine->offload =
+			devm_spi_offload_alloc(&pdev->dev,
+					       sizeof(struct spi_engine_offload));
+		if (IS_ERR(spi_engine->offload))
+			return PTR_ERR(spi_engine->offload);
+
+		priv = spi_engine->offload->priv;
+		priv->spi_engine = spi_engine;
+		priv->offload_num = 0;
+
+		spi_engine->offload->ops = &spi_engine_offload_ops;
+		spi_engine->offload_caps = SPI_OFFLOAD_CAP_TRIGGER;
+
+		if (device_property_match_string(&pdev->dev, "dma-names", "offload0-rx") >= 0) {
+			spi_engine->offload_caps |= SPI_OFFLOAD_CAP_RX_STREAM_DMA;
+			spi_engine->offload->xfer_flags |= SPI_OFFLOAD_XFER_RX_STREAM;
+		}
+
+		if (device_property_match_string(&pdev->dev, "dma-names", "offload0-tx") >= 0) {
+			spi_engine->offload_caps |= SPI_OFFLOAD_CAP_TX_STREAM_DMA;
+			spi_engine->offload->xfer_flags |= SPI_OFFLOAD_XFER_TX_STREAM;
+		} else {
+			/*
+			 * HDL compile option to enable TX DMA stream also disables
+			 * the SDO memory, so can't do both at the same time.
+			 */
+			spi_engine->offload_caps |= SPI_OFFLOAD_CAP_TX_STATIC_DATA;
+		}
+	}
+
 	spi_engine->clk = devm_clk_get_enabled(&pdev->dev, "s_axi_aclk");
 	if (IS_ERR(spi_engine->clk))
 		return PTR_ERR(spi_engine->clk);
@@ -688,6 +974,19 @@ static int spi_engine_probe(struct platform_device *pdev)
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
@@ -709,6 +1008,8 @@ static int spi_engine_probe(struct platform_device *pdev)
 	host->transfer_one_message = spi_engine_transfer_one_message;
 	host->optimize_message = spi_engine_optimize_message;
 	host->unoptimize_message = spi_engine_unoptimize_message;
+	host->get_offload = spi_engine_get_offload;
+	host->put_offload = spi_engine_put_offload;
 	host->num_chipselect = 8;
 
 	/* Some features depend of the IP core version. */

-- 
2.43.0


