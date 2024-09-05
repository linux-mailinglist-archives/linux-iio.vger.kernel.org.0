Return-Path: <linux-iio+bounces-9200-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EA196DDCA
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 17:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8760B21724
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 15:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C4A19E989;
	Thu,  5 Sep 2024 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="K0hnjoBb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4BD19DF44
	for <linux-iio@vger.kernel.org>; Thu,  5 Sep 2024 15:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549538; cv=none; b=el7AxxemCJEBO1vzs6BZ2AKnVzxVmJZ7+CaQmuI/aft7NXqUK5crKcq2wASMg85rShUZzya3IY1suT4uMNBrVmXLQ+G4N5lUkUiW3qabwtGuRd/Hs0XSiZsA7aZOyZ/t4DIQsVM28E3jQ53iDikIkxqt1b9Pb8vTzYfBD7UdMPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549538; c=relaxed/simple;
	bh=zqR8Ma3kQq7AIwQIpNx2PJFyFY9OTdv+a2GS2Z1e4G0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NiiwfjP3mHcs6ckLSlOS4OQOFpp4YkqVTiagKBuUKcTHazpSuePgOyVRIEcmEkQAKxnrEt3uVlodXrqt2ouoYGkosv/qYKtKEkXTfxGifJ07gHHcN/2Z+CeGTwU6dr9wHGcyVFlmpd7ul55c03/+Tg4iP7EICPxFuAKDCouh1j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=K0hnjoBb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42bb81e795bso7464875e9.1
        for <linux-iio@vger.kernel.org>; Thu, 05 Sep 2024 08:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725549535; x=1726154335; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZWIl1ehBhaIBfAagiEJ5QO2cnvkrw2A+Y1bB2atjQg=;
        b=K0hnjoBboJvUBQAtSk8q3E2JYWvum5tTPMfRhd9BVoW0RCyfZQMnvuI2w8T2noNMLi
         2g8TTr5Y4tO53CNqIJc5VdrDovVjly9CqHpGY/0IEX4+JMgfWctAfF8z6MVCnDyS1L3T
         Tz/1Jb5IBrEVUcV4SnOWIr3BNNhoGQ3IvYr/94ZTUxwKIEgvTn9wGZIVWhzqeDmmzpz2
         BktJNOpU3aOl/ak563b59SQMSqNWK/bcxIlZfjrUkNhhVSs152SU88L4H62C0GVEHsip
         QE5+Hffy85qIzo9OBFti48S23iGTHtgbjkiVg1j6LHChE+DP4C3DqTGs+xup0S+3mmnk
         XirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725549535; x=1726154335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZWIl1ehBhaIBfAagiEJ5QO2cnvkrw2A+Y1bB2atjQg=;
        b=GfCHMaf4n1lGBULI9bDLmRF/9dDwNSocPiJmbNcis9Tg1HStcgHMXhgj27tY3JhaeZ
         4QhZm1cZbnIAVCNcy20CT1Ow6ArW1ci1DZZgKEzDc0T7RsiOa6nzi5QHqF0P7cJpTigm
         IyOYhbTJPVCkov4+o6BLu2vPKH7BRm1KDbZ72/QjZ8VSkQGU4XlC5dPq4zbV62PWIIdC
         2zLOFojwR/XfzxGxK/xY0bk3pgc/Qz4TCDyvCePH8vf2xPKhNCcErB+LK1kVfGCgoC3X
         kjKrfEXR6+hoLKaDoS4ZD6QFuz55D8bpLzc1larZo3X7jkwXdQa1F+5w5De7wG1UVErI
         Ol+g==
X-Gm-Message-State: AOJu0YzUk/V4PGBgiM6BpKgHyJ4ybLUt+b5Y7pcpILATH8vEgdFGWiSx
	DO/eb2hmR0ASh9MuEkphBtcQORQdlsUhSE/qrsrYZl7/cxpPLmCFRbxL1ug8GB0=
X-Google-Smtp-Source: AGHT+IFfv6NcUGX8vOG3/4+6e/vDUUbSoXMb7KdUiar5eVs0/9ZUn5U0xFyGbxxUh5XllqbeOb6wdw==
X-Received: by 2002:a05:600c:34c3:b0:426:5fe1:ec7a with SMTP id 5b1f17b1804b1-42bbb440201mr145238975e9.31.1725549534679;
        Thu, 05 Sep 2024 08:18:54 -0700 (PDT)
Received: from [127.0.1.1] (host-95-233-232-76.retail.telecomitalia.it. [95.233.232.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c1de81b2sm14031076f8f.30.2024.09.05.08.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 08:18:54 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 05 Sep 2024 17:17:33 +0200
Subject: [PATCH v2 3/9] iio: backend adi-axi-dac: extend features
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-3-87d669674c00@baylibre.com>
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
In-Reply-To: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Extend DAC backend with new features required for the AXI driver
version for the ad3552r DAC. Mainly, a new compatible string has
been added to support a DAC IP very similar to the generic DAC IP
but with some customizations to work with the ad3552r.

Then, a serie of generic functions has been added to match with
ad3552r needs. Function names has been kept generic as much as
possible, to allow re-utilization from other frontend drivers.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Co-developed-by: David Lechner <dlechner@baylibre.com>
Co-developed-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/dac/adi-axi-dac.c | 267 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 257 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 0cb00f3bec04..cc31e1dcd1df 100644
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
-#define	  ADI_DAC_R1_MODE		BIT(4)
+#define   AXI_DAC_SDR_DDR_N		BIT(16)
+#define   AXI_DAC_SYMB_8B		BIT(14)
+#define	  ADI_DAC_R1_MODE		BIT(5)
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
+	AXI_DAC_DATA_INTERNAL_RAMP_16 = 11,
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
+	case IIO_BACKEND_INTERNAL_RAMP_16:
+		return regmap_update_bits(st->regmap,
+					  AXI_DAC_REG_CHAN_CNTRL_7(chan),
+					  AXI_DAC_DATA_SEL,
+					  AXI_DAC_DATA_INTERNAL_RAMP_16);
 	default:
 		return -EINVAL;
 	}
@@ -518,9 +561,192 @@ static int axi_dac_reg_access(struct iio_backend *back, unsigned int reg,
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
+
+	switch (mask) {
+	case IIO_CHAN_INFO_FREQUENCY:
+		*val = clk_get_rate(devm_clk_get(st->dev, 0));
+
+		return IIO_VAL_INT;
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
+		 * since data size is mandatory for to the current transfer.
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
+		}
+		break;
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
+		bval = 0;
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
+		}
+		break;
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
@@ -528,6 +754,16 @@ static const struct iio_backend_ops axi_dac_generic_ops = {
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
+	.bus_reg_read = axi_dac_bus_reg_read,
+	.bus_reg_write = axi_dac_bus_reg_write,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_dac_reg_access),
 };
 
@@ -545,8 +781,8 @@ static const struct regmap_config axi_dac_regmap_config = {
 
 static int axi_dac_probe(struct platform_device *pdev)
 {
-	const unsigned int *expected_ver;
 	struct axi_dac_state *st;
+	const struct axi_dac_info *info;
 	void __iomem *base;
 	unsigned int ver;
 	struct clk *clk;
@@ -556,10 +792,12 @@ static int axi_dac_probe(struct platform_device *pdev)
 	if (!st)
 		return -ENOMEM;
 
-	expected_ver = device_get_match_data(&pdev->dev);
-	if (!expected_ver)
+	info = device_get_match_data(&pdev->dev);
+	if (!info)
 		return -ENODEV;
 
+	st->info = info;
+
 	clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
@@ -588,12 +826,13 @@ static int axi_dac_probe(struct platform_device *pdev)
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
@@ -631,10 +870,18 @@ static int axi_dac_probe(struct platform_device *pdev)
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
+	{ .compatible = "adi,axi-dac-ad3552r", .data = &dac_ad3552r },
 	{}
 };
 MODULE_DEVICE_TABLE(of, axi_dac_of_match);

-- 
2.45.0.rc1


