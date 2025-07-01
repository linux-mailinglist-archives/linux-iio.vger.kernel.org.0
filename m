Return-Path: <linux-iio+bounces-21216-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9225FAF05DB
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 23:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6FE11C07CB8
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 21:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5428630AAAA;
	Tue,  1 Jul 2025 21:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uzFV2QfR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C7C302CCA
	for <linux-iio@vger.kernel.org>; Tue,  1 Jul 2025 21:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751405988; cv=none; b=uK/rYkUQpnngWoUvJXlmKaPdUn5z7vdCMLNH9qg6B9H0vggEYUiommMmWG0AOratqw6UXzGcskCad/ro/OcL93iwg38cB4nM/7SUKgMFMG8XW+x+VCzQl3qDlVNRCEBeU+Ywy0M3vGaZwd7LxiaHf8AKBmzQndIdcLTwiY7sqEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751405988; c=relaxed/simple;
	bh=x4deODr2J/B/ZfZk3+/1/BV8bYxvy5G2y6ggy6cAeUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BZZLHvr9yFeVQPtXkU0PQIzcUlTxU5LHQFxKgTcBxUGfBEgd9J4cTpY+msTsg2rgxp7wB9j2Zc0Hi/N7/6H5RluSFMzUXs6Njrw2ITblRS5uuH45BaAKCyM/idv0c9NJ9TvuBsDcPsdJWKBdaBZ+rRkItUwpRGcllRKDmOiRF9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uzFV2QfR; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-73afbe149afso2162398a34.1
        for <linux-iio@vger.kernel.org>; Tue, 01 Jul 2025 14:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751405983; x=1752010783; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=suln3ZPyOtbgf+467Jl0jyyrQzWY3/ACSgQiyK4V5QE=;
        b=uzFV2QfR/9O4bbbkOJxLfJ4apFXo+I2UDKekRLkUk2CR62s4ds7TvNdaFJaNr15UV9
         as/jpcwB9qphSeaOpw+0nyZirN0iBZ/+21NSkzFTlY9vKyriqkDIsTTGUn76ST45j+PL
         U4F8fyclyDjm/uQeJ5aOMvZB1eegv4aE+CaF3hSJPBypZkguCgesL/zAd027ZMb+LYij
         qUb/Fdbts06kGmSjvYCwBQeIbF+HLGlCkkYpU2RInFkQcZCCL/lPEjk7ZViE3OA+FeMH
         dGFz25q0NMAiRxEp4JxBUjleM5GP32g4p/+s5aLh7lnHZQFOd6lR4A8oFEkWLs7Gl8d3
         QWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751405983; x=1752010783;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=suln3ZPyOtbgf+467Jl0jyyrQzWY3/ACSgQiyK4V5QE=;
        b=l3C2IWQhI1sOqhunVUO5LUqxCBRS+qK8Mp6wrSR25TXob+bPdZSXqYoIK3lqwOpIMM
         catbv9OAgAjXRC4hIymS1QgRE2GWiavcEBCoM8TQk39v2UXm+EBjtqIz8d8wDJFpi33R
         vMDu9gc11eR7fXNGrmaDbPGN5dnyzheRcVQPt6YA6IV8Qqvs6yqAuznOn4Ydqe6SjLGQ
         J5Sgr64xZyIbs9vl4v7M6hpAB9vNermWtqA9x1+8g715kkeApOZj87jvdNhEtaFEFN20
         D1etYLC4sIIEMVosG3falFYYHdano1j4YYv53pEOdde9Rc8q05EIWTSVMH7j6F/tDQyT
         Rdyw==
X-Gm-Message-State: AOJu0YxLMCYuwiTIKwhq19CVRsLE5RccGVjX+cd1qN1LrGl7DBCQ8DtS
	OWuwNl/tpLuqY0gdA8Eq+ceGxjdv2XWMo5oMicTEbW8XQGhsBZolFu+D/Qf3reexONA=
X-Gm-Gg: ASbGnctYwn7DOckePYovEs0g05zKO9HEFKH2XIVBRZTIK5OfIQ1e8K1/JW4J5w5Hgak
	PXFZgNyhlXGns1sDaOOrR2cJpFWnpW+MadiP4zj8yQxRQvcAI8RjdsYSCqK4gkXVXA/ov6sZscL
	BqTVv0ymZkDVgfs/T3eSyK67X5w5Kv1Bl8NCKpo2Ze+73EhtOXDAHgksMYgOY9RZImffXxUZIeS
	IC/dFLzkxxt4bAXlX2d2aARTEjZ5B6W+z2WXuSa9DAHf2m8HJwx3TNPcjroLjnj+5NS1vCXG/KI
	wnAzzhRGGh6cfnHDX6TAG7XfvQ0OcQoyp72otLes6eLqWCBHCDRtlxzYKAdQo5wxB+C5
X-Google-Smtp-Source: AGHT+IF6kRQojTr3O2i9DG8mL7DMuXbV8rMwlD9TonhoHxqzG4+HoL+1QVcxeETXqNSATHlBkNqfyw==
X-Received: by 2002:a05:6808:1a0e:b0:409:f8e:7274 with SMTP id 5614622812f47-40b88e07cbamr163963b6e.18.1751405983560;
        Tue, 01 Jul 2025 14:39:43 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:70a7:ca49:a250:f1d5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b3243deeesm2288335b6e.48.2025.07.01.14.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 14:39:43 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 01 Jul 2025 16:38:00 -0500
Subject: [PATCH v3 12/12] iio: adc: ad7173: add SPI offload support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-12-42abb83e3dac@baylibre.com>
References: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-0-42abb83e3dac@baylibre.com>
In-Reply-To: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-0-42abb83e3dac@baylibre.com>
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
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoZFWKFauMI32n+rVJ4X53stwAqiiUvPd+u9cFp
 uvVIaRAIL+JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGRVigAKCRDCzCAB/wGP
 wE4UCACbCLWfN9b147eeF/3FnSESrviOzb6Fu37NJlnlvMpDCeG1q6ArK8xrmF+fw25/vektB7i
 h24Bm6GTgyEVq+Q0MOPABO9fDJL2uSWaRuVrRrqVr/I9AbRWr5dIfxqQJGtMT/VYQwGAMcVp3h3
 BKUeRv4tRjoETflevaU6psSJMOPzxt3XW7qTSYHuoYAZgWKFvqj9OJqtXTPaBmFuhtx83Jf7WCm
 sjQKKjGVOsn+yZ7Rzlpy34BGCYtFC/SsI1QHMxSe2idYDvGQZlJE5f7SFF9BNCb0VPGmd9A3Rah
 SAjh5D/znRiJRVMB4W6hFq60UKW28JwAD9k7EOd0B3ZEBd/b
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


