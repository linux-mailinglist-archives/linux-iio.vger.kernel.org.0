Return-Path: <linux-iio+bounces-14702-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA99CA21BCE
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 12:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8712B7A23AE
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 11:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610211DE8BE;
	Wed, 29 Jan 2025 11:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nhxfWChB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136991B85CC
	for <linux-iio@vger.kernel.org>; Wed, 29 Jan 2025 11:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738148721; cv=none; b=ZP7tNBWsV7K0gkeP0H4Cj0Oi9+cRRbDQgRpwuR/0nElgET0p3ygMJjY+jaSoBJjGAR69YEkmpRt++rg8Fb2/KgFCBHZYX/uiNsA8csIZiJyicuAtNbfdfPY9i0TMaZ4DePwS1rvC41pnwOoSm2xLWadkEeBWV72xvpGxrhDwWOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738148721; c=relaxed/simple;
	bh=8XBbCyrVrmKJI/qd66kNWiIMy1Am9etQvCwfxj2mcHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CftngDt/POa8n4awjfo19Jjw/5QDF5PtVhJDIpggcAEZiERa5ALzKpHcYPjE5MNpnWtRNC9Xe350kUBsdiLZZouOFduH+OCfp6REkF+aJXVDWn9RR/RCr+06nOrWvmFF1P3CUkc5ABXITuxsNuWyod+PxdoMJxVfu/nVQUoloJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nhxfWChB; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385e0e224cbso3857200f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 29 Jan 2025 03:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738148717; x=1738753517; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4USs6/6zKuF/MdKgpjuvTHhJcap7IwLMSXMnTU59Qc=;
        b=nhxfWChBOY6waDGjbWTdSGOh70nwtl2RZrXoL6PSKyrAJIYejKHHsaB0zXGbEF2mrU
         RGnommZ2U3cWLkuC7PMPl2Mn/oiyOhFavDYc4/53agfqvLRF7JnX4vnW6ZWPEFmF2sD+
         OBuEr8TbLlUCLKuHng25w2gH3a6nW9O1pxBa7sRMOqB0tbii1Q4JnJqq2u0kIbEYb/1G
         4FnjU/fDvsqDgMnFrzY93pNCv8cv8zIQb9n/YxeApHIe1R/TOqGygfCIjFmKp0IQ0tJ2
         C0xwfutg7T8rwnAvd0FV8WJvAHhHWsYPW9tN0BYtuzaXnakIuy2E6dAtGVHkiqNvkDy3
         Qi0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738148717; x=1738753517;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4USs6/6zKuF/MdKgpjuvTHhJcap7IwLMSXMnTU59Qc=;
        b=vxqM7O3KmuJiDhsnTHlUyuLG0kyQd81Fj/Hf5TsgB2N3dcErnLQhfNwEiSnfyW2lEY
         ZXUdeI5bcLsa2O3Lot+bLdYDYQfLVpFoYsK2WmfFlXfcIcqls1+wXxSuaM7MzaaM7wBA
         A0j1HJbYa+Fgzkol0EqGA9MOr4SxM7ELGeIx1JEglbtQk1Rlz9RZ6D6mRGI2iEdTY27N
         sNYsyGTVDY0qjgW/lLkaoghaVJfUOqv6LwptrL0IbMFT0lXODN3rajR3lnFGk/HgIdG/
         PoyfF0IWfBHVttRomdcGf5ft/25lFtaA+9IGulUdnocsRK7N24i9D/xS+xoM8yvVBleM
         HOFg==
X-Forwarded-Encrypted: i=1; AJvYcCXDUMluN2DgOp+Kag4nz3C6a+SBTDDiYLjQO0N05XRPkrtDB2B+eZoxJ/q73SKM+YUyIqbYPkiRabo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5d5Yer4x4s0cQsTEP3Czw+wSfMFbzAAUkhjHBfI3jfQRZf489
	i4upkVZLh8GXwkghi5ZXYElrWx/inexBcoVVSr5xiMIZ4qqO625I9AdcTm4B6zA=
X-Gm-Gg: ASbGncvPe/slQwz3y2eeCJ0y0chsKjiSswZsjiBBvxnEjwbW0b/uYNzPAODzoBoL82H
	QqKA8KSRCjUVIxLaLXQHeUzZkLLSgLDD14ykRJ5VlQ0xBKpSk8lfzgZl4bAIV17HDoBJEq+oJ+q
	v4nTuSl62KlUU5rDOlDB5SYGp8hgeaXP6hxgnPXrqRahurzgbmpOGYnqpQ4Kg2iukKXcfq8htyD
	2cas8FBPGfZcSC3PdekK4s+yVOO9fmY9djOvuSW6dwXhDTkhf4lHF3cuxUWKUi4Rgibu3YkEnRP
	QtehNSHYln3TNn8EIviOyfao3tcCeZoyymnH6Wd3rty+90MB+938iu2gUXzXC8vgMYxiu18=
X-Google-Smtp-Source: AGHT+IGolhfktI6yJtpPuzV602TdVTTUqp9HJAQtBCrT/Ivw8RnYbrotdjfaGHytbagwJUpgq0rX1g==
X-Received: by 2002:a5d:5846:0:b0:385:f4db:e33b with SMTP id ffacd0b85a97d-38c51966b85mr2380865f8f.21.1738148717359;
        Wed, 29 Jan 2025 03:05:17 -0800 (PST)
Received: from [127.0.1.1] (host-95-245-235-245.retail.telecomitalia.it. [95.245.235.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a17d7a7sm17107364f8f.32.2025.01.29.03.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 03:05:16 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 29 Jan 2025 12:03:09 +0100
Subject: [PATCH v3 08/10] iio: adc: ad7606: change r/w_register signature
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-8-c3aec77c0ab7@baylibre.com>
References: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-0-c3aec77c0ab7@baylibre.com>
In-Reply-To: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-0-c3aec77c0ab7@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandru Ardelean <aardelean@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guillaume Stols <gstols@baylibre.com>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Guillaume Stols <gstols@baylibre.com>

The register read/write with IIO backend will require to claim the
direct mode, and doing so requires passing the corresponding iio_dev
structure.
So we need to modify the function signature to pass the iio_dev
structure.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606.c     | 25 +++++++++++--------------
 drivers/iio/adc/ad7606.h     |  8 ++++----
 drivers/iio/adc/ad7606_spi.c |  8 +++++---
 3 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 7985570ed152..4a7fc6f192c6 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -574,13 +574,13 @@ static int ad7606_reg_access(struct iio_dev *indio_dev,
 	guard(mutex)(&st->lock);
 
 	if (readval) {
-		ret = st->bops->reg_read(st, reg);
+		ret = st->bops->reg_read(indio_dev, reg);
 		if (ret < 0)
 			return ret;
 		*readval = ret;
 		return 0;
 	} else {
-		return st->bops->reg_write(st, reg, writeval);
+		return st->bops->reg_write(indio_dev, reg, writeval);
 	}
 }
 
@@ -1148,24 +1148,24 @@ static const struct iio_trigger_ops ad7606_trigger_ops = {
 	.validate_device = iio_trigger_validate_own_device,
 };
 
-static int ad7606_write_mask(struct ad7606_state *st, unsigned int addr,
+static int ad7606_write_mask(struct iio_dev *indio_dev, unsigned int addr,
 			     unsigned long mask, unsigned int val)
 {
+	struct ad7606_state *st = iio_priv(indio_dev);
 	int readval;
 
-	readval = st->bops->reg_read(st, addr);
+	readval = st->bops->reg_read(indio_dev, addr);
 	if (readval < 0)
 		return readval;
 
 	readval &= ~mask;
 	readval |= val;
 
-	return st->bops->reg_write(st, addr, readval);
+	return st->bops->reg_write(indio_dev, addr, readval);
 }
 
 static int ad7616_write_scale_sw(struct iio_dev *indio_dev, int ch, int val)
 {
-	struct ad7606_state *st = iio_priv(indio_dev);
 	unsigned int ch_addr, mode, ch_index;
 
 	/*
@@ -1187,23 +1187,20 @@ static int ad7616_write_scale_sw(struct iio_dev *indio_dev, int ch, int val)
 	/* 0b01 for 2.5v, 0b10 for 5v and 0b11 for 10v */
 	mode = AD7616_RANGE_CH_MODE(ch_index, ((val + 1) & 0b11));
 
-	return ad7606_write_mask(st, ch_addr, AD7616_RANGE_CH_MSK(ch_index),
+	return ad7606_write_mask(indio_dev, ch_addr, AD7616_RANGE_CH_MSK(ch_index),
 				 mode);
 }
 
 static int ad7616_write_os_sw(struct iio_dev *indio_dev, int val)
 {
-	struct ad7606_state *st = iio_priv(indio_dev);
 
-	return ad7606_write_mask(st, AD7616_CONFIGURATION_REGISTER,
+	return ad7606_write_mask(indio_dev, AD7616_CONFIGURATION_REGISTER,
 				 AD7616_OS_MASK, val << 2);
 }
 
 static int ad7606_write_scale_sw(struct iio_dev *indio_dev, int ch, int val)
 {
-	struct ad7606_state *st = iio_priv(indio_dev);
-
-	return ad7606_write_mask(st, AD7606_RANGE_CH_ADDR(ch),
+	return ad7606_write_mask(indio_dev, AD7606_RANGE_CH_ADDR(ch),
 				 AD7606_RANGE_CH_MSK(ch),
 				 AD7606_RANGE_CH_MODE(ch, val));
 }
@@ -1212,7 +1209,7 @@ static int ad7606_write_os_sw(struct iio_dev *indio_dev, int val)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
 
-	return st->bops->reg_write(st, AD7606_OS_MODE, val);
+	return st->bops->reg_write(indio_dev, AD7606_OS_MODE, val);
 }
 
 static int ad7616_sw_mode_setup(struct iio_dev *indio_dev)
@@ -1233,7 +1230,7 @@ static int ad7616_sw_mode_setup(struct iio_dev *indio_dev)
 		return ret;
 
 	/* Activate Burst mode and SEQEN MODE */
-	return ad7606_write_mask(st, AD7616_CONFIGURATION_REGISTER,
+	return ad7606_write_mask(indio_dev, AD7616_CONFIGURATION_REGISTER,
 				 AD7616_BURST_MODE | AD7616_SEQEN_MODE,
 				 AD7616_BURST_MODE | AD7616_SEQEN_MODE);
 }
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 7a044b499cfe..eca7ea99e24d 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -235,10 +235,10 @@ struct ad7606_bus_ops {
 	int (*iio_backend_config)(struct device *dev, struct iio_dev *indio_dev);
 	int (*read_block)(struct device *dev, int num, void *data);
 	int (*sw_mode_config)(struct iio_dev *indio_dev);
-	int (*reg_read)(struct ad7606_state *st, unsigned int addr);
-	int (*reg_write)(struct ad7606_state *st,
-				unsigned int addr,
-				unsigned int val);
+	int (*reg_read)(struct iio_dev *indio_dev, unsigned int addr);
+	int (*reg_write)(struct iio_dev *indio_dev,
+			 unsigned int addr,
+			 unsigned int val);
 	int (*update_scan_mode)(struct iio_dev *indio_dev, const unsigned long *scan_mask);
 	u16 (*rd_wr_cmd)(int addr, char isWriteOp);
 };
diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index 885bf0b68e77..15bfa7a427d9 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -124,8 +124,9 @@ static int ad7606_spi_read_block18to32(struct device *dev,
 	return spi_sync_transfer(spi, &xfer, 1);
 }
 
-static int ad7606_spi_reg_read(struct ad7606_state *st, unsigned int addr)
+static int ad7606_spi_reg_read(struct iio_dev *indio_dev, unsigned int addr)
 {
+	struct ad7606_state *st = iio_priv(indio_dev);
 	struct spi_device *spi = to_spi_device(st->dev);
 	struct spi_transfer t[] = {
 		{
@@ -148,10 +149,11 @@ static int ad7606_spi_reg_read(struct ad7606_state *st, unsigned int addr)
 	return be16_to_cpu(st->d16[1]);
 }
 
-static int ad7606_spi_reg_write(struct ad7606_state *st,
+static int ad7606_spi_reg_write(struct iio_dev *indio_dev,
 				unsigned int addr,
 				unsigned int val)
 {
+	struct ad7606_state *st = iio_priv(indio_dev);
 	struct spi_device *spi = to_spi_device(st->dev);
 
 	st->d16[0] = cpu_to_be16((st->bops->rd_wr_cmd(addr, 1) << 8) |
@@ -176,7 +178,7 @@ static int ad7606B_sw_mode_config(struct iio_dev *indio_dev)
 	struct ad7606_state *st = iio_priv(indio_dev);
 
 	/* Configure device spi to output on a single channel */
-	st->bops->reg_write(st,
+	st->bops->reg_write(indio_dev,
 			    AD7606_CONFIGURATION_REGISTER,
 			    AD7606_SINGLE_DOUT);
 

-- 
2.47.0


