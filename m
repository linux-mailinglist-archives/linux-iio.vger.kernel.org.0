Return-Path: <linux-iio+bounces-10861-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 702109A691C
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 14:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92666B221D2
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 12:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B9C1F8929;
	Mon, 21 Oct 2024 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="orpzBaJg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E890B1F4FAA
	for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2024 12:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514504; cv=none; b=SUdopH9cQMU7HXcXnaY16sNY16UFQAoeXJ+gm+VI/A6WJWh34CZSmPm32YjN8TnaIxXy64LLhsccZfx2FnY2bgjuJHfMIPIwHnLuk+pDz7fUExIFk68so7Nz4OTFTiWLVTS9bThWY0YliJP022vyNzkR7GXaQw9nUtxhTnEeBds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514504; c=relaxed/simple;
	bh=I5+N0NAOWe/sFtKQrOJaNq01/VpOlW3Inx+5dZK6gIY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MW1Y/WgKTEShe/04PD6JA/rJwVCKmxqIRb4ga/033jdPjVZNVL47K2ZFzYUEeVum1428OqenmS8DWR6mkrjsQlYyQ3RQwqOF3ZhQ0Ls1qVwkewfQsTWkhXWVT8IfyafstC4tHQiu0n2aPoVt1CB9PmQqTRh299Z/xpa8yk7pCc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=orpzBaJg; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d63a79bb6so3454768f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2024 05:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729514499; x=1730119299; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kfuuqnRiCMyUJkSpQXuY6IEMDANSYZzC6ZVJzn8ka58=;
        b=orpzBaJgNBFFFj50f1ZCF5ZZ20GpQkgHL1P+2vzjzxc0Y/wCGm9r2PvyKx7N5P3klb
         uZj95w292JMu2eP/KpwLAqv8VolBjz8bDgi1nT+dyIXidaJngfvqG7NoE48utlqtnciF
         cenKM2SgaCxdWkIGktkxAjTTw5gl/y9bpfQQ4zc/Qi19fAXnsnKjlZse5uXvqAq1LXQw
         BlVFjIXOEJ4e1v6QEdBKgLylmbMy75bqsf1p5mhFIQlA5lMnG8kbnQ756FJRGiXMP3Wf
         GzeOjIcEEd0cph1R7fe4Xii4zKGdnyNOvKT4WdkKUv/p8hPsPFKP9F2v2NqIbK++ZH2z
         xWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729514499; x=1730119299;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfuuqnRiCMyUJkSpQXuY6IEMDANSYZzC6ZVJzn8ka58=;
        b=dz5+w0a3aTdWJ0iz8my2qmnOeWMe+gLwuyiGT60PzcRaVUzKtVqU9uKb7ebIm8yCYO
         dOX8Au9yh4tHK7ULYbD9xkrvAm5LJQKg9lX8oqNnMYK+vMzmvElfoM4zOVeuITPBMMit
         136dCyEHrjDzrypanEyFy9lcq9i6kZTtcWht1qc03cIDTliP92WcoCMsxRc4wiSp/L9f
         aoqWtgl0KGW6ku4OGROJdyp6SKhq3fW3O77uk7KJOypBmsRJHRZN7wTEPAyYgOBKUoS9
         HwpEU4lCxSR+qWmZ3xLm7qpm3ZZwA0y1J4/yOs/g6mJaHUO7V/2F7b/C8kc6y16pmBSB
         ddAw==
X-Gm-Message-State: AOJu0Yyq4DaSbf4y52TLkP3SUIg0Wb+BURi5UXI3HbNOxw6UK4nvSzGu
	IODs9UIyF9vI1S9mNZdCfLjRCbhs+AbKfhqoq25g0rInYU8wrX5RwbKecaBzlC8=
X-Google-Smtp-Source: AGHT+IGh6twMI+/m70yF8EXIyTqqdimLuyH5/jEIePdblqJbAcDCRMJSv21iYL95TPRhGOdz90xxxQ==
X-Received: by 2002:a05:6000:11d2:b0:37d:52db:a0a7 with SMTP id ffacd0b85a97d-37eab4ee017mr7128503f8f.2.1729514499080;
        Mon, 21 Oct 2024 05:41:39 -0700 (PDT)
Received: from [127.0.1.1] (host-82-61-199-210.retail.telecomitalia.it. [82.61.199.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cc88esm55996075e9.46.2024.10.21.05.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:41:38 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 21 Oct 2024 14:40:14 +0200
Subject: [PATCH v7 4/8] iio: dac: adi-axi-dac: extend features
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-4-969694f53c5d@baylibre.com>
References: <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-0-969694f53c5d@baylibre.com>
In-Reply-To: <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-0-969694f53c5d@baylibre.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dlechner@baylibre.com, 
 Mark Brown <broonie@kernel.org>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Extend AXI-DAC backend with new features required to interface
to the ad3552r DAC. Mainly, a new compatible string is added to
support the ad3552r-axi DAC IP, very similar to the generic DAC
IP but with some customizations to work with the ad3552r.

Then, a series of generic functions has been added to match with
ad3552r needs. Function names has been kept generic as much as
possible, to allow re-utilization from other frontend drivers.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/adi-axi-dac.c | 269 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 255 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 04193a98616e..9d6809fe7a67 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -46,9 +46,28 @@
 #define AXI_DAC_CNTRL_1_REG			0x0044
 #define   AXI_DAC_CNTRL_1_SYNC			BIT(0)
 #define AXI_DAC_CNTRL_2_REG			0x0048
+#define   AXI_DAC_CNTRL_2_SDR_DDR_N		BIT(16)
+#define   AXI_DAC_CNTRL_2_SYMB_8B		BIT(14)
 #define   ADI_DAC_CNTRL_2_R1_MODE		BIT(5)
+#define   AXI_DAC_CNTRL_2_UNSIGNED_DATA		BIT(4)
+#define AXI_DAC_STATUS_1_REG			0x0054
+#define AXI_DAC_STATUS_2_REG			0x0058
 #define AXI_DAC_DRP_STATUS_REG			0x0074
 #define   AXI_DAC_DRP_STATUS_DRP_LOCKED		BIT(17)
+#define AXI_DAC_CUSTOM_RD_REG			0x0080
+#define AXI_DAC_CUSTOM_WR_REG			0x0084
+#define   AXI_DAC_CUSTOM_WR_DATA_8		GENMASK(23, 16)
+#define   AXI_DAC_CUSTOM_WR_DATA_16		GENMASK(23, 8)
+#define AXI_DAC_UI_STATUS_REG			0x0088
+#define   AXI_DAC_UI_STATUS_IF_BUSY		BIT(4)
+#define AXI_DAC_CUSTOM_CTRL_REG			0x008C
+#define   AXI_DAC_CUSTOM_CTRL_ADDRESS		GENMASK(31, 24)
+#define   AXI_DAC_CUSTOM_CTRL_SYNCED_TRANSFER	BIT(2)
+#define   AXI_DAC_CUSTOM_CTRL_STREAM		BIT(1)
+#define   AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA	BIT(0)
+
+#define AXI_DAC_CUSTOM_CTRL_STREAM_ENABLE	(AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA | \
+						 AXI_DAC_CUSTOM_CTRL_STREAM)
 
 /* DAC Channel controls */
 #define AXI_DAC_CHAN_CNTRL_1_REG(c)		(0x0400 + (c) * 0x40)
@@ -63,12 +82,21 @@
 #define AXI_DAC_CHAN_CNTRL_7_REG(c)		(0x0418 + (c) * 0x40)
 #define   AXI_DAC_CHAN_CNTRL_7_DATA_SEL		GENMASK(3, 0)
 
+#define AXI_DAC_RD_ADDR(x)			(BIT(7) | (x))
+
 /* 360 degrees in rad */
 #define AXI_DAC_2_PI_MEGA			6283190
 
 enum {
 	AXI_DAC_DATA_INTERNAL_TONE,
 	AXI_DAC_DATA_DMA = 2,
+	AXI_DAC_DATA_INTERNAL_RAMP_16BIT = 11,
+};
+
+struct axi_dac_info {
+	unsigned int version;
+	const struct iio_backend_info *backend_info;
+	bool has_dac_clk;
 };
 
 struct axi_dac_state {
@@ -79,9 +107,11 @@ struct axi_dac_state {
 	 * data/variables.
 	 */
 	struct mutex lock;
+	const struct axi_dac_info *info;
 	u64 dac_clk;
 	u32 reg_config;
 	bool int_tone;
+	int dac_clk_rate;
 };
 
 static int axi_dac_enable(struct iio_backend *back)
@@ -471,6 +501,11 @@ static int axi_dac_data_source_set(struct iio_backend *back, unsigned int chan,
 					  AXI_DAC_CHAN_CNTRL_7_REG(chan),
 					  AXI_DAC_CHAN_CNTRL_7_DATA_SEL,
 					  AXI_DAC_DATA_DMA);
+	case IIO_BACKEND_INTERNAL_RAMP_16BIT:
+		return regmap_update_bits(st->regmap,
+					  AXI_DAC_CHAN_CNTRL_7_REG(chan),
+					  AXI_DAC_CHAN_CNTRL_7_DATA_SEL,
+					  AXI_DAC_DATA_INTERNAL_RAMP_16BIT);
 	default:
 		return -EINVAL;
 	}
@@ -528,6 +563,166 @@ static int axi_dac_reg_access(struct iio_backend *back, unsigned int reg,
 	return regmap_write(st->regmap, reg, writeval);
 }
 
+static int axi_dac_ddr_enable(struct iio_backend *back)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+
+	return regmap_clear_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
+				 AXI_DAC_CNTRL_2_SDR_DDR_N);
+}
+
+static int axi_dac_ddr_disable(struct iio_backend *back)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+
+	return regmap_set_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
+			       AXI_DAC_CNTRL_2_SDR_DDR_N);
+}
+
+static int axi_dac_data_stream_enable(struct iio_backend *back)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+
+	return regmap_set_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
+			       AXI_DAC_CUSTOM_CTRL_STREAM_ENABLE);
+}
+
+static int axi_dac_data_stream_disable(struct iio_backend *back)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+
+	return regmap_clear_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
+				 AXI_DAC_CUSTOM_CTRL_STREAM_ENABLE);
+}
+
+static int axi_dac_data_transfer_addr(struct iio_backend *back, u32 address)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+
+	if (address > FIELD_MAX(AXI_DAC_CUSTOM_CTRL_ADDRESS))
+		return -EINVAL;
+
+	/*
+	 * Sample register address, when the DAC is configured, or stream
+	 * start address when the FSM is in stream state.
+	 */
+	return regmap_update_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
+				  AXI_DAC_CUSTOM_CTRL_ADDRESS,
+				  FIELD_PREP(AXI_DAC_CUSTOM_CTRL_ADDRESS,
+				  address));
+}
+
+static int axi_dac_data_format_set(struct iio_backend *back, unsigned int ch,
+				   const struct iio_backend_data_fmt *data)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+
+	switch (data->type) {
+	case IIO_BACKEND_DATA_UNSIGNED:
+		return regmap_clear_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
+					 AXI_DAC_CNTRL_2_UNSIGNED_DATA);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int axi_dac_read_raw(struct iio_backend *back,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_FREQUENCY:
+
+		if (!st->info->has_dac_clk)
+			return -EOPNOTSUPP;
+
+		/*
+		 * Returning here always the maximum (buffering mode)
+		 * clock rate.
+		 */
+		*val = st->dac_clk_rate;
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int axi_dac_bus_reg_write(struct iio_backend *back, u32 reg, u32 val,
+				 size_t data_size)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+	int ret;
+	u32 ival;
+
+	/*
+	 * Both AXI_DAC_CNTRL_2_REG and AXI_DAC_CUSTOM_WR_REG need to know
+	 * the data size. So keeping data size control here only,
+	 * since data size is mandatory for the current transfer.
+	 * DDR state handled separately by specific backend calls,
+	 * generally all raw register writes are SDR.
+	 */
+	if (data_size == sizeof(u16))
+		ival = FIELD_PREP(AXI_DAC_CUSTOM_WR_DATA_16, val);
+	else
+		ival = FIELD_PREP(AXI_DAC_CUSTOM_WR_DATA_8, val);
+
+	ret = regmap_write(st->regmap, AXI_DAC_CUSTOM_WR_REG, ival);
+	if (ret)
+		return ret;
+
+	if (data_size == sizeof(u8))
+		ret = regmap_set_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
+				      AXI_DAC_CNTRL_2_SYMB_8B);
+	else
+		ret = regmap_clear_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
+					AXI_DAC_CNTRL_2_SYMB_8B);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
+				 AXI_DAC_CUSTOM_CTRL_ADDRESS,
+				 FIELD_PREP(AXI_DAC_CUSTOM_CTRL_ADDRESS, reg));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
+				 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA,
+				 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA);
+	if (ret)
+		return ret;
+
+	ret = regmap_read_poll_timeout(st->regmap,
+				AXI_DAC_UI_STATUS_REG, ival,
+				FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, ival) == 0,
+				10, 100 * KILO);
+	if (ret == -ETIMEDOUT)
+		dev_err(st->dev, "AXI read timeout\n");
+
+	/* Cleaning always AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA */
+	return regmap_clear_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
+				 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA);
+}
+
+static int axi_dac_bus_reg_read(struct iio_backend *back, u32 reg, u32 *val,
+				size_t data_size)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+	int ret;
+
+	/*
+	 * SPI, we write with read flag, then we read just at the AXI
+	 * io address space to get data read.
+	 */
+	ret = axi_dac_bus_reg_write(back, AXI_DAC_RD_ADDR(reg), 0, data_size);
+	if (ret)
+		return ret;
+
+	return regmap_read(st->regmap, AXI_DAC_CUSTOM_RD_REG, val);
+}
+
 static const struct iio_backend_ops axi_dac_generic_ops = {
 	.enable = axi_dac_enable,
 	.disable = axi_dac_disable,
@@ -541,11 +736,31 @@ static const struct iio_backend_ops axi_dac_generic_ops = {
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_dac_reg_access),
 };
 
+static const struct iio_backend_ops axi_ad3552r_ops = {
+	.enable = axi_dac_enable,
+	.disable = axi_dac_disable,
+	.read_raw = axi_dac_read_raw,
+	.request_buffer = axi_dac_request_buffer,
+	.free_buffer = axi_dac_free_buffer,
+	.data_source_set = axi_dac_data_source_set,
+	.ddr_enable = axi_dac_ddr_enable,
+	.ddr_disable = axi_dac_ddr_disable,
+	.data_stream_enable = axi_dac_data_stream_enable,
+	.data_stream_disable = axi_dac_data_stream_disable,
+	.data_format_set = axi_dac_data_format_set,
+	.data_transfer_addr = axi_dac_data_transfer_addr,
+};
+
 static const struct iio_backend_info axi_dac_generic = {
 	.name = "axi-dac",
 	.ops = &axi_dac_generic_ops,
 };
 
+static const struct iio_backend_info axi_ad3552r = {
+	.name = "axi-ad3552r",
+	.ops = &axi_ad3552r_ops,
+};
+
 static const struct regmap_config axi_dac_regmap_config = {
 	.val_bits = 32,
 	.reg_bits = 32,
@@ -555,7 +770,6 @@ static const struct regmap_config axi_dac_regmap_config = {
 
 static int axi_dac_probe(struct platform_device *pdev)
 {
-	const unsigned int *expected_ver;
 	struct axi_dac_state *st;
 	void __iomem *base;
 	unsigned int ver;
@@ -566,14 +780,29 @@ static int axi_dac_probe(struct platform_device *pdev)
 	if (!st)
 		return -ENOMEM;
 
-	expected_ver = device_get_match_data(&pdev->dev);
-	if (!expected_ver)
+	st->info = device_get_match_data(&pdev->dev);
+	if (!st->info)
 		return -ENODEV;
+	clk = devm_clk_get_enabled(&pdev->dev, "s_axi_aclk");
+	if (IS_ERR(clk)) {
+		/* Backward compat., old fdt versions without clock-names. */
+		clk = devm_clk_get_enabled(&pdev->dev, NULL);
+		if (IS_ERR(clk))
+			return dev_err_probe(&pdev->dev, PTR_ERR(clk),
+					"failed to get clock\n");
+	}
+
+	if (st->info->has_dac_clk) {
+		struct clk *dac_clk;
 
-	clk = devm_clk_get_enabled(&pdev->dev, NULL);
-	if (IS_ERR(clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
-				     "failed to get clock\n");
+		dac_clk = devm_clk_get_enabled(&pdev->dev, "dac_clk");
+		if (IS_ERR(dac_clk))
+			return dev_err_probe(&pdev->dev, PTR_ERR(dac_clk),
+					     "failed to get dac_clk clock\n");
+
+		/* We only care about the streaming mode rate */
+		st->dac_clk_rate = clk_get_rate(dac_clk) / 2;
+	}
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
@@ -598,12 +827,13 @@ static int axi_dac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (ADI_AXI_PCORE_VER_MAJOR(ver) != ADI_AXI_PCORE_VER_MAJOR(*expected_ver)) {
+	if (ADI_AXI_PCORE_VER_MAJOR(ver) !=
+		ADI_AXI_PCORE_VER_MAJOR(st->info->version)) {
 		dev_err(&pdev->dev,
 			"Major version mismatch. Expected %d.%.2d.%c, Reported %d.%.2d.%c\n",
-			ADI_AXI_PCORE_VER_MAJOR(*expected_ver),
-			ADI_AXI_PCORE_VER_MINOR(*expected_ver),
-			ADI_AXI_PCORE_VER_PATCH(*expected_ver),
+			ADI_AXI_PCORE_VER_MAJOR(st->info->version),
+			ADI_AXI_PCORE_VER_MINOR(st->info->version),
+			ADI_AXI_PCORE_VER_PATCH(st->info->version),
 			ADI_AXI_PCORE_VER_MAJOR(ver),
 			ADI_AXI_PCORE_VER_MINOR(ver),
 			ADI_AXI_PCORE_VER_PATCH(ver));
@@ -629,7 +859,8 @@ static int axi_dac_probe(struct platform_device *pdev)
 		return ret;
 
 	mutex_init(&st->lock);
-	ret = devm_iio_backend_register(&pdev->dev, &axi_dac_generic, st);
+
+	ret = devm_iio_backend_register(&pdev->dev, st->info->backend_info, st);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret,
 				     "failed to register iio backend\n");
@@ -642,10 +873,20 @@ static int axi_dac_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static unsigned int axi_dac_9_1_b_info = ADI_AXI_PCORE_VER(9, 1, 'b');
+static const struct axi_dac_info dac_generic = {
+	.version = ADI_AXI_PCORE_VER(9, 1, 'b'),
+	.backend_info = &axi_dac_generic,
+};
+
+static const struct axi_dac_info dac_ad3552r = {
+	.version = ADI_AXI_PCORE_VER(9, 1, 'b'),
+	.backend_info = &axi_ad3552r,
+	.has_dac_clk = true,
+};
 
 static const struct of_device_id axi_dac_of_match[] = {
-	{ .compatible = "adi,axi-dac-9.1.b", .data = &axi_dac_9_1_b_info },
+	{ .compatible = "adi,axi-dac-9.1.b", .data = &dac_generic },
+	{ .compatible = "adi,axi-ad3552r", .data = &dac_ad3552r },
 	{}
 };
 MODULE_DEVICE_TABLE(of, axi_dac_of_match);

-- 
2.45.0.rc1


