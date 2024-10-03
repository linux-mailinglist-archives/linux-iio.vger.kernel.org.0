Return-Path: <linux-iio+bounces-10069-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AFF98F52D
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 19:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCECD1F2282E
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 17:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4181AD3E1;
	Thu,  3 Oct 2024 17:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Yfi1PR/W"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4631E1AC887
	for <linux-iio@vger.kernel.org>; Thu,  3 Oct 2024 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727976646; cv=none; b=JQeQ4zCqEHvsMhLg+aEmbCVb0diDvXehAdUfq+eZIW9VgyO7s6HSUc3MmVp/ZXlJnQKUaPEW/nQYBT+fgsGTjgJaufWsfCn/hqbVwz5iGoci5f99LYkzwStagWq9FihaeuyYoqhkMFrx0tn5u66NM04mR9oiZbn9qdeCn5EcnDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727976646; c=relaxed/simple;
	bh=mgT3T9tttmgvxCfN17OqPtKCa4mCMiQaX4FKrLGNrjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XmfTTHf+QtWMzzPZJL1QrWBKxKNh1SCvPu9ElPhNoWuSPhEowR5d3VWGfAvNOQSD/On2SRkGdEX/Wq1ztszWdlnrX1iWpXFY50M/AoqxBcAOi6ZbsXm2aG/uhTLLDWNwvi+30CzCKME5PidpOJGz2qGJ9ghbsF5Zv7pFGX46cJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Yfi1PR/W; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cbbb1727eso12337735e9.2
        for <linux-iio@vger.kernel.org>; Thu, 03 Oct 2024 10:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727976643; x=1728581443; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kWqq62gfKg/Q0efQuXXYrKoj5jhcNcILxAL6UARPPd0=;
        b=Yfi1PR/W60JOxpylmTjrf9hx2KB2powGzFgdbrNj2/+JB7vg9HEt2mi4liNWzjB9a9
         GCOXV2/exkBgrTtU/+DwLdMhzFM3hO/Gv798Y7QA15BQxn075GDku2f/ZPDLCsUlOgzc
         yIr6lpoB+4FBv1CRA2Zxc2DbtV4qU1LxU4xyaJcKkHYznYB3TB7POMBWWilqJPceIe7k
         67U0Q4dgECxyGQ/xtybLVs0H82Szl2xA71yMtBF+EWob94bDfo409wPzgUSn+cfTsaza
         VkJAoDebanDSZTfOfhynqebjjU8mMEWYUlsbahSawZodx0qaIhe6sUCLCXfY7kR/ocJP
         u0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727976643; x=1728581443;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWqq62gfKg/Q0efQuXXYrKoj5jhcNcILxAL6UARPPd0=;
        b=qrsQ577oPI3hfjfy3+qMs6Axw7hXVz8pw37xBQDl5fUotnzRA1OTeupURQwGAESw5W
         qLsH4q0qErmvi5FSWDcfpsL7jBUwBX6i7Kl5Tpa1TwL4EDPcpHQCv9B8LRlfBNaYNvJk
         0C0bd9n10vaqz/fxqgzC9r2XOeH3dpF5UgpkDTuoCtPqzNSD0InKxIQaFONC+5NnlIG+
         AQEksmj2iZdoGiNXXPHfsztT4382jK/Dz2R8WMadk0ZEd3aUhIC7UjgHYR5uKgQaL5kh
         1pqGe/6vEVjN8bADpsXgN0s5U8y6R7sOUWOVt8j6yXB00he1dqXHDAvFc7BFmYX7kOax
         nHcA==
X-Gm-Message-State: AOJu0Yw99j4GzshufzFnsGr/KhqbjzAIXeWCNZzJqxE98XKqxnmySS49
	fBQQ9BpFsr1KLbiXqc2cHFZmozpWhkpAIjr3epgW+Lm/jaOFBglv8Ob4v02YqRo=
X-Google-Smtp-Source: AGHT+IFdxsW51jhSFCuRg1daoPh2nnPypxQvR7layAkgcoY+Y5m8deTsgtZRnA5jr6biUUwN1fLZ+A==
X-Received: by 2002:a05:6000:a8d:b0:37c:d23a:1e4 with SMTP id ffacd0b85a97d-37d0e79bd82mr89044f8f.30.1727976642626;
        Thu, 03 Oct 2024 10:30:42 -0700 (PDT)
Received: from [127.0.1.1] (host-79-54-25-3.retail.telecomitalia.it. [79.54.25.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082d116asm1703735f8f.90.2024.10.03.10.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 10:30:41 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 03 Oct 2024 19:29:04 +0200
Subject: [PATCH v4 07/11] iio: dac: adi-axi-dac: extend features
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-7-ceb157487329@baylibre.com>
References: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-0-ceb157487329@baylibre.com>
In-Reply-To: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-0-ceb157487329@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Mihail Chindris <mihail.chindris@analog.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org, 
 dlechner@baylibre.com, Mark Brown <broonie@kernel.org>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Extend AXI-DAC backend with new features required to interface
to the ad3552r DAC. Mainly, a new compatible string is added to
support the ad3552r-axi DAC IP, very similar to the generic DAC
IP but with some customizations to work with the ad3552r.

Then, a serie of generic functions has been added to match with
ad3552r needs. Function names has been kept generic as much as
possible, to allow re-utilization from other frontend drivers.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/adi-axi-dac.c | 278 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 264 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 04193a98616e..a4147231cd57 100644
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
+#define AXI_DAC_STREAM_ENABLE			(AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA | \
+						AXI_DAC_CUSTOM_CTRL_STREAM)
 
 /* DAC Channel controls */
 #define AXI_DAC_CHAN_CNTRL_1_REG(c)		(0x0400 + (c) * 0x40)
@@ -63,12 +82,26 @@
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
+enum {
+	AXI_DAC_BUS_TYPE_NONE,
+	AXI_DAC_BUS_TYPE_DDR_QSPI,
+};
+
+struct axi_dac_info {
+	unsigned int version;
+	const struct iio_backend_info *backend_info;
+	bool bus_controller;
 };
 
 struct axi_dac_state {
@@ -79,6 +112,8 @@ struct axi_dac_state {
 	 * data/variables.
 	 */
 	struct mutex lock;
+	const struct axi_dac_info *info;
+	struct clk *clk;
 	u64 dac_clk;
 	u32 reg_config;
 	bool int_tone;
@@ -471,6 +506,11 @@ static int axi_dac_data_source_set(struct iio_backend *back, unsigned int chan,
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
@@ -528,6 +568,188 @@ static int axi_dac_reg_access(struct iio_backend *back, unsigned int reg,
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
+static int axi_dac_dma_stream_enable(struct iio_backend *back)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+
+	return regmap_set_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
+			       AXI_DAC_STREAM_ENABLE);
+}
+
+static int axi_dac_dma_stream_disable(struct iio_backend *back)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+
+	return regmap_clear_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
+				 AXI_DAC_STREAM_ENABLE);
+}
+
+static int axi_dac_data_transfer_addr(struct iio_backend *back, u32 address)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
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
+	int err;
+
+	switch (data->type) {
+	case IIO_BACKEND_DATA_UNSIGNED:
+		err = regmap_clear_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
+					AXI_DAC_CNTRL_2_UNSIGNED_DATA);
+		if (err)
+			return err;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int axi_dac_read_raw(struct iio_backend *back,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+	int err;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_FREQUENCY: {
+		int clk_in, reg;
+
+		if (!st->info->bus_controller)
+			return -EOPNOTSUPP;
+
+		/*
+		 * As from ad3552r AXI IP documentation,
+		 * returning the SCLK depending on the stream mode.
+		 */
+		err = regmap_read(st->regmap, AXI_DAC_CUSTOM_CTRL_REG, &reg);
+		if (err)
+			return err;
+
+		clk_in = clk_get_rate(st->clk);
+
+		if (reg & AXI_DAC_CUSTOM_CTRL_STREAM)
+			*val = clk_in / 2;
+		else
+			*val = clk_in / 8;
+
+		return IIO_VAL_INT;
+		}
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
+	if (data_size == 2)
+		ival = FIELD_PREP(AXI_DAC_CUSTOM_WR_DATA_16, val);
+	else
+		ival = FIELD_PREP(AXI_DAC_CUSTOM_WR_DATA_8, val);
+
+	ret = regmap_write(st->regmap, AXI_DAC_CUSTOM_WR_REG, ival);
+	if (ret)
+		return ret;
+
+	/*
+	 * Both REG_CNTRL_2 and AXI_DAC_CNTRL_DATA_WR need to know
+	 * the data size. So keeping data size control here only,
+	 * since data size is mandatory for the current transfer.
+	 * DDR state handled separately by specific backend calls,
+	 * generally all raw register writes are SDR.
+	 */
+	if (data_size == 1)
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
+				       AXI_DAC_CUSTOM_CTRL_REG, ival,
+				       ival & AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA,
+				       10, 100 * KILO);
+	if (ret)
+		return ret;
+
+	return regmap_clear_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
+				 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA);
+}
+
+static int axi_dac_bus_reg_read(struct iio_backend *back, u32 reg, u32 *val,
+				size_t data_size)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+	int ret;
+	u32 ival;
+
+	/*
+	 * SPI, we write with read flag, then we read just at the AXI
+	 * io address space to get data read.
+	 */
+	ret = axi_dac_bus_reg_write(back, AXI_DAC_RD_ADDR(reg), 0, data_size);
+	if (ret)
+		return ret;
+
+	ret = regmap_read_poll_timeout(st->regmap, AXI_DAC_UI_STATUS_REG, ival,
+				FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, ival) !=
+				AXI_DAC_UI_STATUS_IF_BUSY,
+				10, 100);
+	if (ret)
+		return ret;
+
+	return regmap_read(st->regmap, AXI_DAC_CUSTOM_RD_REG, val);
+}
+
 static const struct iio_backend_ops axi_dac_generic_ops = {
 	.enable = axi_dac_enable,
 	.disable = axi_dac_disable,
@@ -541,11 +763,29 @@ static const struct iio_backend_ops axi_dac_generic_ops = {
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_dac_reg_access),
 };
 
+static const struct iio_backend_ops axi_ad3552r_ops = {
+	.enable = axi_dac_enable,
+	.read_raw = axi_dac_read_raw,
+	.request_buffer = axi_dac_request_buffer,
+	.data_source_set = axi_dac_data_source_set,
+	.ddr_enable = axi_dac_ddr_enable,
+	.ddr_disable = axi_dac_ddr_disable,
+	.dma_stream_enable = axi_dac_dma_stream_enable,
+	.dma_stream_disable = axi_dac_dma_stream_disable,
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
@@ -555,24 +795,22 @@ static const struct regmap_config axi_dac_regmap_config = {
 
 static int axi_dac_probe(struct platform_device *pdev)
 {
-	const unsigned int *expected_ver;
 	struct axi_dac_state *st;
 	void __iomem *base;
 	unsigned int ver;
-	struct clk *clk;
 	int ret;
 
 	st = devm_kzalloc(&pdev->dev, sizeof(*st), GFP_KERNEL);
 	if (!st)
 		return -ENOMEM;
 
-	expected_ver = device_get_match_data(&pdev->dev);
-	if (!expected_ver)
+	st->info = device_get_match_data(&pdev->dev);
+	if (!st->info)
 		return -ENODEV;
 
-	clk = devm_clk_get_enabled(&pdev->dev, NULL);
-	if (IS_ERR(clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
+	st->clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(st->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(st->clk),
 				     "failed to get clock\n");
 
 	base = devm_platform_ioremap_resource(pdev, 0);
@@ -598,12 +836,13 @@ static int axi_dac_probe(struct platform_device *pdev)
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
@@ -629,7 +868,8 @@ static int axi_dac_probe(struct platform_device *pdev)
 		return ret;
 
 	mutex_init(&st->lock);
-	ret = devm_iio_backend_register(&pdev->dev, &axi_dac_generic, st);
+
+	ret = devm_iio_backend_register(&pdev->dev, st->info->backend_info, st);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret,
 				     "failed to register iio backend\n");
@@ -642,10 +882,20 @@ static int axi_dac_probe(struct platform_device *pdev)
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
+	.bus_controller = true,
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


