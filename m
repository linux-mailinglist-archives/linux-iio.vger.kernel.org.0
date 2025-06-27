Return-Path: <linux-iio+bounces-21026-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04320AEC342
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 01:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FE5D164577
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 23:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8484C2EF640;
	Fri, 27 Jun 2025 23:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HZ4p/gRd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635722EE976
	for <linux-iio@vger.kernel.org>; Fri, 27 Jun 2025 23:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751067700; cv=none; b=jJ5qxiyD1Wx9nY+1UbNgXEUH9vplN3jb1i9Y/EitFEp1hatMUwZvl8dxJwalCv5ae8L2q6HmWtjSXRpvqdyz3HNoGZ9INJ0L5YE5wIRU0Y8rzRxYSeN2IGVhLbo2e8OdbEI49DxdRNv9lpLOfhRRBrqRvy1pV3x8GM0lM0Fjf9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751067700; c=relaxed/simple;
	bh=x4deODr2J/B/ZfZk3+/1/BV8bYxvy5G2y6ggy6cAeUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TGKp8MPxAZDTmEt/WyYgLEIRdWk5mcnGoLscuJeby5W3oUEk+TrwzgcDSn+dScfFFtPFvOTrpY1PI7MCA7hiM2umjbN//cO6IhVMqs3jd9toEeQfhase2Op0+e9TkZ2x6dC643hKHsYUsMohfAUf5hnwUghGKh0D93E2Qt2oMRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HZ4p/gRd; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4067ac8f6cdso322879b6e.2
        for <linux-iio@vger.kernel.org>; Fri, 27 Jun 2025 16:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751067696; x=1751672496; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=suln3ZPyOtbgf+467Jl0jyyrQzWY3/ACSgQiyK4V5QE=;
        b=HZ4p/gRdPh9Joh/7m7D6Fva0cJ36VmR9Bp/hrTC+77N5yUItE5lJfdPEJFXWEev5m6
         947NppeOafZKWiNccQ5/xdDqSnjNzkMqLdnYksmz+Oc+0xkTfw9bvkmA4/MgL+wsVuje
         DvTCyKfnGMADWcwkjesHei2uzo68Dv0NeDS3rgB7yWSE5n25Nuuptd33rZwXbZYHEicU
         RQiFij1aE8HSUvApcvQNVitDrVSGDjmgJnA2bY6Mm/GjeIHo0eKCtaqwbII6uVd58yeh
         UeTIVdDoDw+FM7RHdcq6Xd9frmLkIvZrbPAXiFM0nPOSnmIG+Ddv8HTt+ejPIYucfODg
         +nZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751067696; x=1751672496;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=suln3ZPyOtbgf+467Jl0jyyrQzWY3/ACSgQiyK4V5QE=;
        b=dP5FJbpZ2aUpyu73I8gXLq6KixLGIGJWSHx/lvqy+mZiukVyiI5wJ8qYsnWp0ArYMP
         GmBQ5vMFVorAW5aGxBIXXNQkmnK5eIhbw1mHcuKTLs6AjTXKBfDXOQYSkc+5602ihEs2
         2YPl3Lp3LR3aQnqWbIkXVToeK8LtgxQ373k42spmB63WG2UV3ho2hQVdz8ngGyfxFd6n
         E+jun+/V69ZvIGReCC1C/DEc8MlNZ24rfMzWEbecnrFC6p93SFh+FrzDC32hkr4mBE2x
         UXd/ElgMCV0WR6UQuysl6PIpA8FIeOwQTsX7yxX4WLTYM/Hy+lPx7xglkahb2apTAHF3
         uVrg==
X-Gm-Message-State: AOJu0Yw7pIfSobWF8WfrNyLaUoyHPZSqRQ3oTH+jI03QHUmacgtn3tKn
	CLtl1zND1gV2UDCW7dCxCPnmYU6bTHyGX1uAD1vlWafYqZNDS6judMDK0MGYdr2IN3Q=
X-Gm-Gg: ASbGncsUrKl6HhrB8nTGyGfPdmq4sHLzi632+2FvXKyvFsZ5Y9XM6++CScQCh1rH3Yp
	khUHHmWg7mahqIgV6jTpxlH24G2wQafJn6bnAmoHOwKVhBbzUUqN4IVhn40IWYg9JT4J8I5VyhL
	oyiF0PkJI9UXNVThUC/TcsuLgt8cTvU8b0nMTiIaHRcEm6XpeXfzQSArSu4NcWivqtrK/1iP/we
	LfP0aa0FPG9OFgSMIqKvZjgz1o95ItVRTGlrt2nSOBpRjEmzEEfZBJA5lDEhVZ0z0r0yHERYoJO
	/cX1/ZNaOvCPhkaJCC48s3yxksVbxLAUjeUd1U5E/qXEVr9G9i0eHu5o0hhI+JKci60=
X-Google-Smtp-Source: AGHT+IEszVnxwzyUu8l9k/WvR7kBjoiy6AXFg08wYNDhVx48W7AflOGCRwyijBhqehZP+bmW1LpC8g==
X-Received: by 2002:a05:6808:16a0:b0:409:f8e:7274 with SMTP id 5614622812f47-40b33e1f70emr3785765b6e.18.1751067696431;
        Fri, 27 Jun 2025 16:41:36 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:1715:453e:e133:7d6])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b322ae4e9sm568483b6e.17.2025.06.27.16.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 16:41:36 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 27 Jun 2025 18:40:07 -0500
Subject: [PATCH v2 11/11] iio: adc: ad7173: add SPI offload support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-11-f49c55599113@baylibre.com>
References: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-0-f49c55599113@baylibre.com>
In-Reply-To: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-0-f49c55599113@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2110; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=x4deODr2J/B/ZfZk3+/1/BV8bYxvy5G2y6ggy6cAeUc=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoXywbZ3akr4Chs8YgOyK+7h+O6cqelf/VMExPK
 4GiksjiiRWJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaF8sGwAKCRDCzCAB/wGP
 wHDwB/9daIu7wU8HmfXqqf/0QoDpVWOj5ADrc2WMoNjPFQEftaBGFOm1rdoqqyMt84oatVzP9KA
 6ALLKPtnKhspuD5eQjHfWV//yErQA9TnClFJWADMyEogkYmtAuvPgfu3ecUSUmNSjDpazTAgOUG
 ckEBGtC3uLJMRkfD0n2yHBQsKkGsH0vp3hUELYKuFa9jaghzPjeSMMOt8LEopm6s88kr4mN1Xmn
 7AYQZLcA22rDmwTc2D1ADD9bIaIXNDJ3dEDtFm26TYaEvZxrTbZIyZf19oaL8kjQ0ILRpvsZ7t/
 hp2//OOeTLp9S/OPoBYpN33mGe0MUxCbMqx8M1ek69qsP3Pr
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Enable SPI offload support for the AD7173 ADC driver.

The scan_type used for SPI offload is assuming that we are using the
ad411x_ad717x HDL project [1] which always stores data words in 32-bits.

Link: https://analogdevicesinc.github.io/hdl/projects/ad411x_ad717x/index.html [1]
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7173.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 010339c2b7044da4b36dc894a38a145c2fcccd6a..580d4bf3366b193fa0f13d0a28886d390e1295b8 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -748,6 +748,7 @@ static const struct ad_sigma_delta_info ad7173_sigma_delta_info_4_slots = {
 	.set_mode = ad7173_set_mode,
 	.has_registers = true,
 	.has_named_irqs = true,
+	.supports_spi_offload = true,
 	.addr_shift = 0,
 	.read_mask = BIT(6),
 	.status_ch_mask = GENMASK(3, 0),
@@ -764,6 +765,7 @@ static const struct ad_sigma_delta_info ad7173_sigma_delta_info_8_slots = {
 	.set_mode = ad7173_set_mode,
 	.has_registers = true,
 	.has_named_irqs = true,
+	.supports_spi_offload = true,
 	.addr_shift = 0,
 	.read_mask = BIT(6),
 	.status_ch_mask = GENMASK(3, 0),
@@ -1585,6 +1587,11 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		if (st->info->data_reg_only_16bit)
 			chan_arr[chan_index].scan_type = ad4113_scan_type;
 
+		if (ad_sigma_delta_has_spi_offload(&st->sd)) {
+			chan_arr[chan_index].scan_type.storagebits = 32;
+			chan_arr[chan_index].scan_type.endianness = IIO_CPU;
+		}
+
 		chan_index++;
 	}
 
@@ -1675,6 +1682,12 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		if (st->info->data_reg_only_16bit)
 			chan_arr[chan_index].scan_type = ad4113_scan_type;
 
+		/* Assuming SPI offload is ad411x_ad717x HDL project. */
+		if (ad_sigma_delta_has_spi_offload(&st->sd)) {
+			chan_arr[chan_index].scan_type.storagebits = 32;
+			chan_arr[chan_index].scan_type.endianness = IIO_CPU;
+		}
+
 		chan_index++;
 	}
 	return 0;

-- 
2.43.0


