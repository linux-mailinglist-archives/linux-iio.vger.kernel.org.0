Return-Path: <linux-iio+bounces-8871-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C94A696449A
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 14:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF5B61C248E3
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 12:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A75518C35B;
	Thu, 29 Aug 2024 12:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="s8PcnoZW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8981E1ABEDB
	for <linux-iio@vger.kernel.org>; Thu, 29 Aug 2024 12:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934804; cv=none; b=mNr/AX75XyYR/a3iAlWLl+JuikG5VF271+IKZzrVpmWXhP97A6xxEoR51cgCI/suHHm8vfqwjZU65gFc/j2xPRiJF1c/00g+jcjZLMOfFYgpwxnNRDj6KYAwtCYh3rE99Yo9o2Bn6p/1SudWnCmJSb3j+xXq8npJ9pAzwDE84Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934804; c=relaxed/simple;
	bh=Ds+1ZPRh3Pd/h/lTlJUmag4WvGxvpkDuwvncfNYz2sg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ku9yJpX6eFDkNggsnLvlgWrNuKFsOfMVJMm+jOiiSCr3UbsVoZ1UHJGqrEf94WgWFXtxarPLOVMb6pgFG0ogbW9/piw3NHBNSwCJX6BbbkUKI5PiWyKuOfrFhaykVkbPBm3CIE8oxHizB5cVqgwtz1Z5CVvbQAwsPg0KkEdb0pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=s8PcnoZW; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-371ba7e46easo423889f8f.0
        for <linux-iio@vger.kernel.org>; Thu, 29 Aug 2024 05:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724934800; x=1725539600; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mqVLJgcYxuhDSoU47RjiW1Y6B/QvAm72bN+dtzZiOHM=;
        b=s8PcnoZWLeRXIkTIgS4KIXSNHGRgtCeksHgdgsMsIrKAGR5EOIc0CeOezOFzNrI4Pp
         ORIXTpwZXcZWvd0LPQvrjqWvKlfGPpdVO6xqIqV8aRYN+z9EBBVq595CfOQ+Y2Mnj1GJ
         BD55Yl2bCt/iQKC08Qfr5MxdjDsgbUelRwNNerQByRscYGHijAo1EfEYkZpH0HNVf3zk
         XIYee8ac8YlUP+shEVCnwTItMAKOmDadD3+IqCVTHJhNXhgpF5GsjzX2lRNbdyjvLqGg
         vWeE5IFYoHOUKsjJxeOeJtvaN+i8VfF1iS2O1xj5E1LxqTWc72IsyKMnGzBujY+flOtI
         //xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724934800; x=1725539600;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqVLJgcYxuhDSoU47RjiW1Y6B/QvAm72bN+dtzZiOHM=;
        b=fIlYVxGqnCZyQ2JbpEmpFJR2cbXoFZratRUuQk3bt5q7RO37r3PqrufXvJRb8/LQ5S
         D+dXr5aY0I6G79HfIwyqcdacPP8bKjw/Gk+xwuELr2XB2EvZVCvPVMZhjLKa9snlOQG9
         barRbZDGU30GQ3hDScGOa82n4Hhlo/2/e5QOiNVkhl9ORCrIexIeHLzTEEBh9FLpFtjc
         co3r1iIniE62QV/njnu1dwMnKjEu4dV1EHneCCzHCoJ+GrTsTFutqcILkBRrzUIRzEhx
         aOV5T+7QxNRaP8CfoQpwRFCIItmGE6BsWTwLJoom9ACCdySgdm2iz6kxiUYTG72CBfdU
         Ilug==
X-Gm-Message-State: AOJu0Yz8OdTMSBVPIMh1jS+aPdv56cS6TbM/roTg+J5s0o0YzG7OPzhe
	IJVfh/NoemhHuKL3dkyM9dEGGfe/Oxj4L/HQxrTFtSupigvdvZpeGxHJFbKk3kg=
X-Google-Smtp-Source: AGHT+IG0NOxZBVBUAP/6A4UX02MrGE4mR/ZJBrI4PfMf765zzw/1pd+sG3xgf1DVlP+a/JP5YPqKww==
X-Received: by 2002:adf:e34f:0:b0:367:9d2c:95ea with SMTP id ffacd0b85a97d-3749b587ee3mr1694282f8f.56.1724934799815;
        Thu, 29 Aug 2024 05:33:19 -0700 (PDT)
Received: from [127.0.1.1] (host-95-233-232-76.retail.telecomitalia.it. [95.233.232.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee9978bsm1315042f8f.49.2024.08.29.05.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 05:33:18 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 29 Aug 2024 14:32:01 +0200
Subject: [PATCH RFC 3/8] iio: backend adi-axi-dac: backend features
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-wip-bl-ad3552r-axi-v0-v1-3-b6da6015327a@baylibre.com>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
In-Reply-To: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dlechner@baylibre.com, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Extend DAC backend with new features required for the AXI driver
version for the a3552r DAC.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/adi-axi-dac.c | 250 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 248 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 0cb00f3bec04..395f222e254d 100644
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
@@ -62,11 +85,20 @@
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
+	AXI_DAC_BUS_TYPE_QSPI,
 };
 
 struct axi_dac_state {
@@ -80,6 +112,7 @@ struct axi_dac_state {
 	u64 dac_clk;
 	u32 reg_config;
 	bool int_tone;
+	int bus_type;
 };
 
 static int axi_dac_enable(struct iio_backend *back)
@@ -460,7 +493,13 @@ static int axi_dac_data_source_set(struct iio_backend *back, unsigned int chan,
 	case IIO_BACKEND_EXTERNAL:
 		return regmap_update_bits(st->regmap,
 					  AXI_DAC_REG_CHAN_CNTRL_7(chan),
-					  AXI_DAC_DATA_SEL, AXI_DAC_DATA_DMA);
+					  AXI_DAC_DATA_SEL,
+					  AXI_DAC_DATA_DMA);
+	case IIO_BACKEND_INTERNAL_RAMP_16:
+		return regmap_update_bits(st->regmap,
+					  AXI_DAC_REG_CHAN_CNTRL_7(chan),
+					  AXI_DAC_DATA_SEL,
+					  AXI_DAC_DATA_INTERNAL_RAMP_16);
 	default:
 		return -EINVAL;
 	}
@@ -518,9 +557,204 @@ static int axi_dac_reg_access(struct iio_backend *back, unsigned int reg,
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
+static int axi_dac_bus_reg_write(struct iio_backend *back,
+				 u32 reg, void *val, size_t size)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+
+	if (!st->bus_type)
+		return -EOPNOTSUPP;
+
+	if (st->bus_type == AXI_DAC_BUS_TYPE_QSPI) {
+		int ret;
+		u32 ival;
+
+		if (size != 1 && size != 2)
+			return -EINVAL;
+
+		switch (size) {
+		case 1:
+			ival = FIELD_PREP(AXI_DAC_DATA_WR_8, *(u8 *)val);
+			break;
+		case 2:
+			ival =  FIELD_PREP(AXI_DAC_DATA_WR_16, *(u16 *)val);
+			break;
+		default:
+			return  -EINVAL;
+		}
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
+		if (size == 1)
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
+
+	return -EINVAL;
+}
+
+static int axi_dac_bus_reg_read(struct iio_backend *back,
+				u32 reg, void *val, size_t size)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+
+	if (!st->bus_type)
+		return -EOPNOTSUPP;
+
+	if (st->bus_type == AXI_DAC_BUS_TYPE_QSPI) {
+		int ret;
+		u32 bval;
+
+		if (size != 1 && size != 2)
+			return -EINVAL;
+
+		bval = 0;
+		ret = axi_dac_bus_reg_write(back,
+					    AXI_DAC_RD_ADDR(reg), &bval, size);
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
+
+	return -EINVAL;
+}
+
 static const struct iio_backend_ops axi_dac_generic_ops = {
 	.enable = axi_dac_enable,
 	.disable = axi_dac_disable,
+	.read_raw = axi_dac_read_raw,
 	.request_buffer = axi_dac_request_buffer,
 	.free_buffer = axi_dac_free_buffer,
 	.extend_chan_spec = axi_dac_extend_chan,
@@ -528,6 +762,16 @@ static const struct iio_backend_ops axi_dac_generic_ops = {
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
 
@@ -576,6 +820,8 @@ static int axi_dac_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(st->regmap),
 				     "failed to init register map\n");
 
+	device_property_read_u32(st->dev, "bus-type", &st->bus_type);
+
 	/*
 	 * Force disable the core. Up to the frontend to enable us. And we can
 	 * still read/write registers...

-- 
2.45.0.rc1


