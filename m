Return-Path: <linux-iio+bounces-9643-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDDD97C6F5
	for <lists+linux-iio@lfdr.de>; Thu, 19 Sep 2024 11:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70CC71F2528B
	for <lists+linux-iio@lfdr.de>; Thu, 19 Sep 2024 09:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81D119922A;
	Thu, 19 Sep 2024 09:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XoFofSA6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767C619CC18
	for <linux-iio@vger.kernel.org>; Thu, 19 Sep 2024 09:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726737706; cv=none; b=m5LXIsrWPIDyy8T2FugkicTQWj4o/Oy9U4thpnp7pQ26KltYkIOLJG+kk6TakLwUry8miTpNJBUYK/BcnXI7OaayijDfEMF88vfkRdcXMzBEksoeZ62TNWnAJVm0q6fyBtUO/xMhQReXnQ2rBs7/vpf6GAHLV9LXRMKuHcbUE8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726737706; c=relaxed/simple;
	bh=4XGzOom73gIUerRuQzf8Mp6Hdpu6jdjxRrE6nfsGpMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qOMjE4vBYp3sGB6eeRDuxEIv/1HINMMGk4zs3hQXXoL7FT3SAGs3nDN4itBqYB3O6+WTGzsPxHnWbHeGJepMZzfNqCZa5t2Z16Q3DxhvNmFGBzZm4I6BwMK22ZTeI+aQ2/4U/dOn5vmHYMkkISdYvDFwPaClNtqoTa0caK7S6Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XoFofSA6; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374ba78f192so383527f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 19 Sep 2024 02:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726737703; x=1727342503; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+NnBndRi3FD2u5hSLd2eWpqMwpmgUucEYsLUxhMHG+Y=;
        b=XoFofSA6f4r9Lr59vufIy3+8K+ALOQ7y8ga06BSSTdCmWw9hc3njoPABVQ8/HInq4H
         GvPA3bjtgIX038V3Q1xxwhN51RODz+TiuBZXeTW5JFvvMRqQGagtaZjzh5mXHQ8I1V39
         jghM22vb+Ll2ypzn3Filonb9wK5Lj2AO4lAFuIqUfMw9Btf3+yWC/SiUEWQyDyubBrYU
         EfSG5EP9MF+hMGbbCM9uKbmZTNqPqqgAmBaCIdA+5bOTnE/axCpMW0/8tL7i8tkE+NgX
         1Hgl9KUJW7xOfX7Qof0rtCqEUYRFC6o5II/e3PKCZ85GXcXHbaqqMCqMexGm80l+qPn+
         iMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726737703; x=1727342503;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+NnBndRi3FD2u5hSLd2eWpqMwpmgUucEYsLUxhMHG+Y=;
        b=ivUXf4VW4+vTYTbUjIeK1tqEHjBrSYlPKvr/dR0zp2Vaie/9YygmblukgzhHTnKqFC
         2QxhKgMOw1J8zH02hKm+mOaWvwjGlVzVzT1blgZXVehVaQjfMPkY2jnYRwYilcQandoI
         uWZKVwRAmQzU1sX43fwwo2F0tNX4IjNSkHY6UT/86QCt7Dnh3hiLzMlMpSjXJMHlrqWt
         UCoao+eROW+VOaxi0lY7IcwMB3ALWNO6NiOicwuE06OqR01uMv2EaSeF5SEQD9N+5iqR
         qrJPx0ach1tCRyYvnJkwMrUO8ZHuTHzqEwTlNpoItofIBzkjOBUt+7RRfF5CMBZNhZKd
         FHew==
X-Gm-Message-State: AOJu0YygAlBQw9ueOijnfz/AQhMsXOsDAZOQp0K/wI7R4yGmwj02wyCi
	GPv9BBA/F/B0LQTZRCxAHFsUrb2pxY0CwEiHMt4ubyBaPksJGPwDyRe5UwJz68k=
X-Google-Smtp-Source: AGHT+IHZHQpR0mpe3LtuSi9Eaj8AoE1qOaflbXcjPyYtDfqSz6Dkp7VzXwt7Q9nBhYgyFNdk0J3Ogg==
X-Received: by 2002:adf:8b9e:0:b0:377:205f:c494 with SMTP id ffacd0b85a97d-378c2cfebc6mr14578799f8f.11.1726737702631;
        Thu, 19 Sep 2024 02:21:42 -0700 (PDT)
Received: from [127.0.1.1] (host-80-117-99-70.retail.telecomitalia.it. [80.117.99.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e75468413sm16889465e9.45.2024.09.19.02.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 02:21:42 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 19 Sep 2024 11:20:02 +0200
Subject: [PATCH v3 06/10] iio: backend: adi-axi-dac: extend features
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-6-a17b9b3d05d9@baylibre.com>
References: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
In-Reply-To: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, dlechner@baylibre.com, 
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
 drivers/iio/dac/adi-axi-dac.c | 274 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 265 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index b8b4171b8043..3ca3a14c575b 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -44,11 +44,34 @@
 #define   AXI_DAC_RSTN_MMCM_RSTN	BIT(1)
 #define   AXI_DAC_RSTN_RSTN		BIT(0)
 #define AXI_DAC_REG_CNTRL_1		0x0044
+#define   AXI_DAC_EXT_SYNC_ARM		BIT(1)
+#define   AXI_DAC_EXT_SYNC_DISARM	BIT(2)
 #define   AXI_DAC_SYNC			BIT(0)
 #define AXI_DAC_REG_CNTRL_2		0x0048
+#define   AXI_DAC_SDR_DDR_N		BIT(16)
+#define   AXI_DAC_SYMB_8B		BIT(14)
 #define	  ADI_DAC_R1_MODE		BIT(5)
+#define   AXI_DAC_UNSIGNED_DATA		BIT(4)
+#define AXI_DAC_REG_STATUS_1		0x54
+#define AXI_DAC_REG_STATUS_2		0x58
 #define AXI_DAC_DRP_STATUS		0x0074
 #define   AXI_DAC_DRP_LOCKED		BIT(17)
+#define AXI_DAC_CNTRL_DATA_RD		0x0080
+#define   AXI_DAC_DATA_RD_8		GENMASK(7, 0)
+#define   AXI_DAC_DATA_RD_16		GENMASK(15, 0)
+#define AXI_DAC_CNTRL_DATA_WR		0x0084
+#define   AXI_DAC_DATA_WR_8		GENMASK(23, 16)
+#define   AXI_DAC_DATA_WR_16		GENMASK(23, 8)
+#define AXI_DAC_UI_STATUS		0x0088
+#define   AXI_DAC_BUSY			BIT(4)
+#define AXI_DAC_REG_CUSTOM_CTRL		0x008C
+#define   AXI_DAC_ADDRESS		GENMASK(31, 24)
+#define   AXI_DAC_SYNCED_TRANSFER	BIT(2)
+#define   AXI_DAC_STREAM		BIT(1)
+#define   AXI_DAC_TRANSFER_DATA		BIT(0)
+
+#define AXI_DAC_STREAM_ENABLE		(AXI_DAC_TRANSFER_DATA | AXI_DAC_STREAM)
+
 /* DAC Channel controls */
 #define AXI_DAC_REG_CHAN_CNTRL_1(c)	(0x0400 + (c) * 0x40)
 #define AXI_DAC_REG_CHAN_CNTRL_3(c)	(0x0408 + (c) * 0x40)
@@ -62,11 +85,25 @@
 #define AXI_DAC_REG_CHAN_CNTRL_7(c)	(0x0418 + (c) * 0x40)
 #define   AXI_DAC_DATA_SEL		GENMASK(3, 0)
 
+#define AXI_DAC_RD_ADDR(x)		(BIT(7) | (x))
+
 /* 360 degrees in rad */
 #define AXI_DAC_2_PI_MEGA		6283190
+
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
+	int bus_type;
 };
 
 struct axi_dac_state {
@@ -77,6 +114,7 @@ struct axi_dac_state {
 	 * data/variables.
 	 */
 	struct mutex lock;
+	const struct axi_dac_info *info;
 	u64 dac_clk;
 	u32 reg_config;
 	bool int_tone;
@@ -461,6 +499,11 @@ static int axi_dac_data_source_set(struct iio_backend *back, unsigned int chan,
 		return regmap_update_bits(st->regmap,
 					  AXI_DAC_REG_CHAN_CNTRL_7(chan),
 					  AXI_DAC_DATA_SEL, AXI_DAC_DATA_DMA);
+	case IIO_BACKEND_INTERNAL_RAMP_16BIT:
+		return regmap_update_bits(st->regmap,
+					  AXI_DAC_REG_CHAN_CNTRL_7(chan),
+					  AXI_DAC_DATA_SEL,
+					  AXI_DAC_DATA_INTERNAL_RAMP_16BIT);
 	default:
 		return -EINVAL;
 	}
@@ -518,9 +561,206 @@ static int axi_dac_reg_access(struct iio_backend *back, unsigned int reg,
 	return regmap_write(st->regmap, reg, writeval);
 }
 
+static int axi_dac_ext_sync_enable(struct iio_backend *back)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+
+	return regmap_set_bits(st->regmap, AXI_DAC_REG_CNTRL_1,
+			       AXI_DAC_EXT_SYNC_ARM);
+}
+
+static int axi_dac_ext_sync_disable(struct iio_backend *back)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+
+	return regmap_clear_bits(st->regmap, AXI_DAC_REG_CNTRL_1,
+				 AXI_DAC_EXT_SYNC_DISARM);
+}
+
+static int axi_dac_ddr_enable(struct iio_backend *back)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+
+	return regmap_clear_bits(st->regmap, AXI_DAC_REG_CNTRL_2,
+				 AXI_DAC_SDR_DDR_N);
+}
+
+static int axi_dac_ddr_disable(struct iio_backend *back)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+
+	return regmap_set_bits(st->regmap, AXI_DAC_REG_CNTRL_2,
+			       AXI_DAC_SDR_DDR_N);
+}
+
+static int axi_dac_buffer_enable(struct iio_backend *back)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+
+	return regmap_set_bits(st->regmap, AXI_DAC_REG_CUSTOM_CTRL,
+			       AXI_DAC_STREAM_ENABLE);
+}
+
+static int axi_dac_buffer_disable(struct iio_backend *back)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+
+	return regmap_clear_bits(st->regmap, AXI_DAC_REG_CUSTOM_CTRL,
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
+	return regmap_update_bits(st->regmap, AXI_DAC_REG_CUSTOM_CTRL,
+				  AXI_DAC_ADDRESS,
+				  FIELD_PREP(AXI_DAC_ADDRESS, address));
+}
+
+static int axi_dac_data_format_set(struct iio_backend *back, unsigned int ch,
+				   const struct iio_backend_data_fmt *data)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+
+	if (data->type == IIO_BACKEND_DATA_UNSIGNED)
+		return regmap_clear_bits(st->regmap, AXI_DAC_REG_CNTRL_2,
+					 AXI_DAC_UNSIGNED_DATA);
+
+	return -EINVAL;
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
+		/*
+		 * As from AXI IP documentation,
+		 * returning the SCLK depending on the stream mode.
+		 */
+		clk_in = clk_get_rate(clk_get(st->dev, 0));
+
+		err = regmap_read(st->regmap, AXI_DAC_REG_CUSTOM_CTRL, &reg);
+		if (err)
+			return err;
+
+		if (reg & AXI_DAC_STREAM)
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
+static int axi_dac_bus_reg_write(struct iio_backend *back, u32 reg,
+				 unsigned int val, size_t data_size)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+
+	switch (st->info->bus_type) {
+	case AXI_DAC_BUS_TYPE_DDR_QSPI: {
+		int ret;
+		u32 ival;
+
+		if (data_size == 2)
+			ival = FIELD_PREP(AXI_DAC_DATA_WR_16, val);
+		else
+			ival = FIELD_PREP(AXI_DAC_DATA_WR_8, val);
+
+		ret = regmap_write(st->regmap, AXI_DAC_CNTRL_DATA_WR, ival);
+		if (ret)
+			return ret;
+
+		/*
+		 * Both REG_CNTRL_2 and AXI_DAC_CNTRL_DATA_WR need to know
+		 * the data size. So keeping data size control here only,
+		 * since data size is mandatory for the current transfer.
+		 * DDR state handled separately by specific backend calls,
+		 * generally all raw register writes are SDR.
+		 */
+		if (data_size == 1)
+			ret = regmap_set_bits(st->regmap, AXI_DAC_REG_CNTRL_2,
+					      AXI_DAC_SYMB_8B);
+		else
+			ret = regmap_clear_bits(st->regmap, AXI_DAC_REG_CNTRL_2,
+						AXI_DAC_SYMB_8B);
+		if (ret)
+			return ret;
+
+		ret = regmap_update_bits(st->regmap, AXI_DAC_REG_CUSTOM_CTRL,
+					 AXI_DAC_ADDRESS,
+					 FIELD_PREP(AXI_DAC_ADDRESS, reg));
+		if (ret)
+			return ret;
+
+		ret = regmap_update_bits(st->regmap, AXI_DAC_REG_CUSTOM_CTRL,
+					 AXI_DAC_TRANSFER_DATA,
+					 AXI_DAC_TRANSFER_DATA);
+		if (ret)
+			return ret;
+
+		ret = regmap_read_poll_timeout(st->regmap,
+					       AXI_DAC_REG_CUSTOM_CTRL, ival,
+					       ival & AXI_DAC_TRANSFER_DATA,
+					       10, 100 * KILO);
+		if (ret)
+			return ret;
+
+		return regmap_clear_bits(st->regmap, AXI_DAC_REG_CUSTOM_CTRL,
+					  AXI_DAC_TRANSFER_DATA);
+	}
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int axi_dac_bus_reg_read(struct iio_backend *back, u32 reg,
+				unsigned int *val, size_t data_size)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+
+	switch (st->info->bus_type) {
+	case AXI_DAC_BUS_TYPE_DDR_QSPI: {
+		int ret;
+		u32 bval;
+
+		ret = axi_dac_bus_reg_write(back, AXI_DAC_RD_ADDR(reg), 0,
+					    data_size);
+		if (ret)
+			return ret;
+
+		ret = regmap_read_poll_timeout(st->regmap, AXI_DAC_UI_STATUS,
+					       bval, bval != AXI_DAC_BUSY,
+					       10, 100);
+		if (ret)
+			return ret;
+
+		return regmap_read(st->regmap, AXI_DAC_CNTRL_DATA_RD, val);
+	}
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static const struct iio_backend_ops axi_dac_generic_ops = {
 	.enable = axi_dac_enable,
 	.disable = axi_dac_disable,
+	.read_raw = axi_dac_read_raw,
 	.request_buffer = axi_dac_request_buffer,
 	.free_buffer = axi_dac_free_buffer,
 	.extend_chan_spec = axi_dac_extend_chan,
@@ -528,6 +768,14 @@ static const struct iio_backend_ops axi_dac_generic_ops = {
 	.ext_info_get = axi_dac_ext_info_get,
 	.data_source_set = axi_dac_data_source_set,
 	.set_sample_rate = axi_dac_set_sample_rate,
+	.ext_sync_enable = axi_dac_ext_sync_enable,
+	.ext_sync_disable = axi_dac_ext_sync_disable,
+	.ddr_enable = axi_dac_ddr_enable,
+	.ddr_disable = axi_dac_ddr_disable,
+	.buffer_enable = axi_dac_buffer_enable,
+	.buffer_disable = axi_dac_buffer_disable,
+	.data_format_set = axi_dac_data_format_set,
+	.data_transfer_addr = axi_dac_data_transfer_addr,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_dac_reg_access),
 };
 
@@ -545,7 +793,6 @@ static const struct regmap_config axi_dac_regmap_config = {
 
 static int axi_dac_probe(struct platform_device *pdev)
 {
-	const unsigned int *expected_ver;
 	struct axi_dac_state *st;
 	void __iomem *base;
 	unsigned int ver;
@@ -556,8 +803,8 @@ static int axi_dac_probe(struct platform_device *pdev)
 	if (!st)
 		return -ENOMEM;
 
-	expected_ver = device_get_match_data(&pdev->dev);
-	if (!expected_ver)
+	st->info = device_get_match_data(&pdev->dev);
+	if (!st->info)
 		return -ENODEV;
 
 	clk = devm_clk_get_enabled(&pdev->dev, NULL);
@@ -588,12 +835,13 @@ static int axi_dac_probe(struct platform_device *pdev)
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
@@ -631,10 +879,18 @@ static int axi_dac_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static unsigned int axi_dac_9_1_b_info = ADI_AXI_PCORE_VER(9, 1, 'b');
+static const struct axi_dac_info dac_generic = {
+	.version = ADI_AXI_PCORE_VER(9, 1, 'b'),
+};
+
+static const struct axi_dac_info dac_ad3552r = {
+	.version = ADI_AXI_PCORE_VER(9, 1, 'b'),
+	.bus_type = AXI_DAC_BUS_TYPE_DDR_QSPI,
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


