Return-Path: <linux-iio+bounces-10557-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B51D699C6CE
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 12:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268731F24311
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 10:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20147188915;
	Mon, 14 Oct 2024 10:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mM7Q/PSp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFCD1684B4
	for <linux-iio@vger.kernel.org>; Mon, 14 Oct 2024 10:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728900584; cv=none; b=b/1Cn5HBzACdItTZzP2515RjisAhw/kdIAXby/qZHpRZhEi8ZRUX/1AsiHOKRGLHf2+Z+4VzqTGz9BP8MJ9r80x5+TShm/4Rh6K0H5AOy/MG1dD+3WiM0ZkN1nxP7n92RtkVP0OTa9jV2JzmXGSuam00Jqa3aCYkn5OOz7MFpdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728900584; c=relaxed/simple;
	bh=vFMLZLLlZTBojDrLKYbJLlcLEpzmZ608q0eB5ddNtbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kN9XVAx6727qhSFs2c6lD/y9ER61UFOVyOwp0EOeZ+5223d31ebefe0vnAWUiuKLyuR3RUTJbWe12rO5msZC0KnaK9oF/lS0O4Nc8xIsn5ASaykkUhPgrHwt+/WBAOqSMOuN5IaL6b7fkYIAJbOBdAO+9AFmENW/HhGfWRsEVpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mM7Q/PSp; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43128a40d29so15626375e9.1
        for <linux-iio@vger.kernel.org>; Mon, 14 Oct 2024 03:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728900581; x=1729505381; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NGy0RMA1Ff97/uU+lzlbLTucHa4F3D3PJ5h7ppvd6Vc=;
        b=mM7Q/PSpcxHqAzaqHcbVJVIPcNnBQXiDuMHK/HRfikoD3BuMwJuHt7k2Igdx0GOElY
         m78kJ9tQe9syO+4X36+0wvYIP45x3bxoLTRaFrNStCahy9t04MOvhfKaXHzORgSw4EnJ
         1fTwqIBuT++eX4VaNl0eEpuiuseHCvbih5XTN8UbjaIoirMNU9rdG3O5xf1RqwKTxI1f
         2T3aETzGrkdWbw2Vv5qgWA/ZneehbV1VSFaD45E4n+ICT9KNTCxzR9tUUwy9w5oy1Zze
         abFYc3OGi9ete+cyekFvY5EtbtV4Q0gZPOtmj2JtwKQUvc4279Jv8yOEyJ+RRV1S6lQj
         i0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728900581; x=1729505381;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NGy0RMA1Ff97/uU+lzlbLTucHa4F3D3PJ5h7ppvd6Vc=;
        b=fs5tQQ7EckEOiKF1RJvzMSmIKNQfpVcZ0DU6fMu/Fd8fJDvqLYBj4pNidtbz5b4w8S
         yWjkqOzHsmloQ68umQLi/7QgdiRalJxfpvhkF22wetRHm1vrI6myHko5QF0ypmTID7wd
         mOONVTeMiYlT3wk/+qeZalBT2pIwWzQhJpKdsfTdpYXlopbIZ/17+Z1W6gD7tIXq0yaD
         eDeZ6OFpxba5l6Ei9mwEobaP9HtMyb9y9wkXMQ36Nt3q5c1CrNrTlzwy8FIPFd0HNTjq
         3RXZXfGP/UV4DPqalNtsT3SNHoDdMqZq2AvDrgfEupSSmgazWH2zDgZuqV/T6YilYEnN
         PjHg==
X-Gm-Message-State: AOJu0YwpzdImhnxJJTOH3Yygigo4TOWaSBOmvQrst+PlbVuDAMQutwYo
	mnC9LWAG1W90NOLqWXLAtYxsJoQzLQbCfxuR7UmI/4pSeTjpPC9P7c7xHxeCbOI=
X-Google-Smtp-Source: AGHT+IHDMARfVC7uT7S1I0CTCitYahVSjlr9lSvsrVYEjQO7gXLaKFSTB1yJLTR+H+N3TirhTHb8fA==
X-Received: by 2002:a5d:570b:0:b0:37d:51f8:46fd with SMTP id ffacd0b85a97d-37d5520571dmr7303396f8f.22.1728900580939;
        Mon, 14 Oct 2024 03:09:40 -0700 (PDT)
Received: from [127.0.1.1] (host-79-45-239-138.retail.telecomitalia.it. [79.45.239.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7ee0afsm10969352f8f.102.2024.10.14.03.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 03:09:40 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 14 Oct 2024 12:08:10 +0200
Subject: [PATCH v6 4/8] iio: dac: adi-axi-dac: extend features
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-4-eeef0c1e0e56@baylibre.com>
References: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
In-Reply-To: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
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

Then, a serie of generic functions has been added to match with
ad3552r needs. Function names has been kept generic as much as
possible, to allow re-utilization from other frontend drivers.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/adi-axi-dac.c | 272 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 261 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 04193a98616e..b887c6343f96 100644
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
@@ -528,6 +563,181 @@ static int axi_dac_reg_access(struct iio_backend *back, unsigned int reg,
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
+	int err, reg;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_FREQUENCY:
+
+		if (!st->info->has_dac_clk)
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
+		if (reg & AXI_DAC_CUSTOM_CTRL_STREAM)
+			*val = st->dac_clk_rate / 2;
+		else
+			*val = st->dac_clk_rate / 8;
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
+	if (data_size == sizeof(u16))
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
@@ -541,11 +751,29 @@ static const struct iio_backend_ops axi_dac_generic_ops = {
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_dac_reg_access),
 };
 
+static const struct iio_backend_ops axi_ad3552r_ops = {
+	.enable = axi_dac_enable,
+	.read_raw = axi_dac_read_raw,
+	.request_buffer = axi_dac_request_buffer,
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
@@ -555,7 +783,6 @@ static const struct regmap_config axi_dac_regmap_config = {
 
 static int axi_dac_probe(struct platform_device *pdev)
 {
-	const unsigned int *expected_ver;
 	struct axi_dac_state *st;
 	void __iomem *base;
 	unsigned int ver;
@@ -566,15 +793,26 @@ static int axi_dac_probe(struct platform_device *pdev)
 	if (!st)
 		return -ENOMEM;
 
-	expected_ver = device_get_match_data(&pdev->dev);
-	if (!expected_ver)
+	st->info = device_get_match_data(&pdev->dev);
+	if (!st->info)
 		return -ENODEV;
 
-	clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	clk = devm_clk_get_enabled(&pdev->dev, "s_axi_aclk");
 	if (IS_ERR(clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
 				     "failed to get clock\n");
 
+	if (st->info->has_dac_clk) {
+		struct clk *dac_clk;
+
+		dac_clk = devm_clk_get_enabled(&pdev->dev, "dac_clk");
+		if (IS_ERR(dac_clk))
+			return dev_err_probe(&pdev->dev, PTR_ERR(dac_clk),
+					     "failed to get dac_clk clock\n");
+
+		st->dac_clk_rate = clk_get_rate(dac_clk);
+	}
+
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
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


