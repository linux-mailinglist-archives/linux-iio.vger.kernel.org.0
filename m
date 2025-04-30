Return-Path: <linux-iio+bounces-18919-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D7EAA579F
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 23:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4599E2866
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 21:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0E92222A0;
	Wed, 30 Apr 2025 21:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fOfFR4DG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0BC270EB8
	for <linux-iio@vger.kernel.org>; Wed, 30 Apr 2025 21:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746049331; cv=none; b=mfgfy/L2grQ1CWoDtdkuKL+jqnP3XCKTq/kdiuCNd072Af4sBoCRHq4BpEvuniS2exwvW3w2NhuvvUePVByS1TxRCGfG96sXc/07ZW/Ogiwl9iovII8JvdAY2K5eojtX2bADLiohenbQ4V/EcNMkfcX6sAJi5c+hpy1uWejP0Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746049331; c=relaxed/simple;
	bh=2uTy4bFann+T6grhqJ/odAqfQsvefvHb4ifQ3K0jCf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NMsHe/uyTT0+e3VewDSibvi3p0CClgxz/2PdGPNegGEZ4ZRfbdIUzHUlr/VIAgMgbRdDLK+NUTjbeg0TAnWwO/KKT7L2P7Ku2LUWKcA3E767yHHcODnKJTTYm5QcOfo9sKLqRCn1yI7x1ddiI66KJdcmKiJK3QI6mT8Dy1NOm5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fOfFR4DG; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3fcfc85f1f5so125623b6e.2
        for <linux-iio@vger.kernel.org>; Wed, 30 Apr 2025 14:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746049327; x=1746654127; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2eqk9sIPH3kRJ0H1IrNTaQdeLGQyXLAVqxXo3pgzbFA=;
        b=fOfFR4DGcFP3dJH0mZ9iPAnKa+w1Up0PixT0Kw8p+4uLvdMxIa4D28wTDVPoIg86q8
         FyY8HDCiZ3EvMSmXEx4y/Vn5e+BsTVlwwF0C2ZB2UhEia+3ZyWWUIZqiHPYJ48W+1d/S
         tEGNoVGaJdjp3pkGLf3ehEDpkwAwOiCb0O0LnVPuGsIuqpLOUx6/ZKgvSgmNfGTwUIqu
         TbRUr10S1rWEvnO4V8JYOBeaZD3NTAjxKnWgl6C+ihx2+fhjELhp5Ee32xMAb2v6T4+4
         A3HaKdtehQUFcHlWjfBs92zBD+bfcV2cU+rczIQa90Z3Bz3cuevilUsLWe8Z/BZpatm+
         aKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746049328; x=1746654128;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2eqk9sIPH3kRJ0H1IrNTaQdeLGQyXLAVqxXo3pgzbFA=;
        b=TH4Kb/h9Qne1PPKjNu2KHANt6W4tBBD2VDEClKd6nBIs6fXGig0QnEZaE76ObaYODk
         8b4ZJtSTOaYMH1FvUKGgX6V0JJjvWKA3bViBypIFLPDSmvc48YFSZQ+O4WHM+EJTBnEX
         3c2mFh31rnK57ucRLF1Fm0Lhk/IFg4XmfRvWm09U0Q5zOaTWqGAblY8cJ0iLtB9ND0G4
         0jbgoiEFF255gGIVIkxVM3vekh7GzMot3isT+N272p3P5J8kPRbV+V/atYCHJ9T9Mx/Z
         NYb7pCrJ7ZoO82+7w/ql1DxknqPM1jxztWEVYttibrDZnADWKX9COqhKC+t2UWppgM7h
         Xffw==
X-Forwarded-Encrypted: i=1; AJvYcCWXdTkR34MeoIa5miG64Lot2+2398vqGD1eWIlZlH991DlS7W5h5PE06rXkZz+AjN5dYBSazn1mIWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzhNG0sPAnBjXxRzqQfWg8lm3stxbnOAk4Asys1iHx/G8kzPg5
	eRy2+bFQMHv9UywYw6IIQ5JdwARkmGkFaoxucBHKe4vPrF2UDR+Ni9X/RsY5uOw=
X-Gm-Gg: ASbGncurFrGadEKd0SLq997HC8ariQrhPETvHX0y2PT3GPMVyaPiibCEyAif6agszBx
	VpiCqEdPBASNMmW/VQ5r9DMGiOhe9j8VwcHfH40GdyzJS8ZWeOF9ztYJKasF+saT773iP9JLlLv
	KV4YBfb4zNEBxIYQ3tYwFQGG2az1LYWrtljDgNVD0bPBudgGJbHq8quww9TwH4KwpQJKhi9Ac/u
	1HLdO2dcPE0d0oM2JT9yI14f4xOJrOcyQazTcEljgz7FvUoMpsF2knGXNfDH0Pbrw+x7sSBU294
	i7KqxE7BG+/eoQNqrzUSTsQdEov0EZnGK75QNsJS4wl0dvjRvc2eceFA
X-Google-Smtp-Source: AGHT+IGY9DlaOYDRpODkvgRuTtdbcko7b5Ok2AAkFuKsGdmlMgFbTTgLZ1DcDuzAA3TrAFLbLdqdRg==
X-Received: by 2002:a05:6808:d50:b0:401:e933:5de2 with SMTP id 5614622812f47-402c7267e60mr2472286b6e.18.1746049327713;
        Wed, 30 Apr 2025 14:42:07 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:359a:f1e:f988:206a])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40212926792sm992584b6e.18.2025.04.30.14.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 14:42:07 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 30 Apr 2025 16:41:58 -0500
Subject: [PATCH] iio: adc: ad7606_spi: add offload scan mask check
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-iio-adc-ad7606_spi-fix-offload-scan-mask-check-v1-1-8b165d9d6c0e@baylibre.com>
X-B4-Tracking: v=1; b=H4sIACWZEmgC/x2N0QrCMAxFf2Xk2UC6dhP8FREpaerCtB0NiDD27
 5Y9nIcDh3t3MGkqBrdhhyZfNa2li7sMwEssL0FN3WGkcaLgCVUrxsSd60zz0zbFrD+sOb9rTGg
 cC36irciL8IoueU+BiMkF6KNbk56fh/fHcfwBxKgkA4AAAAA=
X-Change-ID: 20250430-iio-adc-ad7606_spi-fix-offload-scan-mask-check-1d330400c014
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Angelo Dureghello <adureghello@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4065; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=2uTy4bFann+T6grhqJ/odAqfQsvefvHb4ifQ3K0jCf4=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoEpkoUgYTpBmkEzcYI82KM/BZKfGXxZ3ssfngO
 O55VNp4VHWJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaBKZKAAKCRDCzCAB/wGP
 wKLXB/0YCHDsPWsyu2Kfs3J8O7bAOzEhirH43R1fptdXWSUP3B6GSAxe8QQIGpe9Mrlbg79itF8
 bchdVEIBZtHr2KmnBU75tEFUzphqr0tjOO2E17dHdnylR1E5J/oxgqoAZLqDmPyuKspZ8dAq+ia
 l9mB0Bbpg1Z5OugRpDS9c9eUuoCH2Dj9mqz2cIvfCqSQza6ylQIkRTrC/D9KbW+hvANaWu3w7Vk
 i5WYdOQo+f71LE6Vyv5yhL4NethxHI/827YyeyG6kpKClRgwBTe/GcoJ4uk1ZgJ7RCOiskcjIXI
 sODKBMTFJss7RS6hXsOmi423+4uroZQC2ocFwijl+dNUCpvC
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Validate the scan mask when SPI offloading is being used.

Since this family of ADCs is simultaneous sampling, there isn't a way
to selectively disable channels when reading sample data. (Technically,
AD7616 has a sequencer so could have some control, but that is for
another day).

For "regular" IIO triggered buffer reads, this isn't a problem and the
IIO core will demux the data and ignore data from disabled channels.
However, since SPI offloading is done completely in hardware, we don't
have a way to do the same. So before this patch, if less than all
channels were enabled, the data would be misplaced in the buffer.

By adding a check in update_scan_mode, we can fail to enable the buffer
instead of having bad data returned to userspace.

Fixes: e96d35faf357 ("iio: adc: ad7606: add SPI offload support")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7606_spi.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index 997be483ebb93293481b922e13ece4edb47e940a..69287c0c231bc57a108cc782a0d98db83b7612f8 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -5,6 +5,7 @@
  * Copyright 2011 Analog Devices Inc.
  */
 
+#include <linux/bitmap.h>
 #include <linux/err.h>
 #include <linux/math.h>
 #include <linux/module.h>
@@ -329,19 +330,47 @@ static int ad7606_spi_offload_probe(struct device *dev,
 	return 0;
 }
 
+static int ad7606_spi_update_scan_mode(struct iio_dev *indio_dev,
+				       const unsigned long *scan_mask)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	if (st->offload_en) {
+		DECLARE_BITMAP(bitmap, AD760X_MAX_CHANNELS);
+
+		bitmap_fill(bitmap, AD760X_MAX_CHANNELS);
+
+		/*
+		 * SPI offload requires that all channels are enabled since
+		 * there isn't a way to selectively disable channels that get
+		 * read (this is simultaneous sampling ADC) and the DMA buffer
+		 * has no way of demuxing the data to filter out unwanted
+		 * channels.
+		 */
+		if (!bitmap_equal(bitmap, scan_mask,
+				  st->chip_info->num_adc_channels))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct ad7606_bus_ops ad7606_spi_bops = {
 	.offload_config = ad7606_spi_offload_probe,
 	.read_block = ad7606_spi_read_block,
+	.update_scan_mode = ad7606_spi_update_scan_mode,
 };
 
 static const struct ad7606_bus_ops ad7607_spi_bops = {
 	.offload_config = ad7606_spi_offload_probe,
 	.read_block = ad7606_spi_read_block14to16,
+	.update_scan_mode = ad7606_spi_update_scan_mode,
 };
 
 static const struct ad7606_bus_ops ad7608_spi_bops = {
 	.offload_config = ad7606_spi_offload_probe,
 	.read_block = ad7606_spi_read_block18to32,
+	.update_scan_mode = ad7606_spi_update_scan_mode,
 };
 
 static const struct ad7606_bus_ops ad7616_spi_bops = {
@@ -350,6 +379,7 @@ static const struct ad7606_bus_ops ad7616_spi_bops = {
 	.reg_read = ad7606_spi_reg_read,
 	.reg_write = ad7606_spi_reg_write,
 	.rd_wr_cmd = ad7616_spi_rd_wr_cmd,
+	.update_scan_mode = ad7606_spi_update_scan_mode,
 };
 
 static const struct ad7606_bus_ops ad7606b_spi_bops = {
@@ -359,6 +389,7 @@ static const struct ad7606_bus_ops ad7606b_spi_bops = {
 	.reg_write = ad7606_spi_reg_write,
 	.rd_wr_cmd = ad7606b_spi_rd_wr_cmd,
 	.sw_mode_config = ad7606b_sw_mode_config,
+	.update_scan_mode = ad7606_spi_update_scan_mode,
 };
 
 static const struct ad7606_bus_ops ad7606c_18_spi_bops = {
@@ -368,6 +399,7 @@ static const struct ad7606_bus_ops ad7606c_18_spi_bops = {
 	.reg_write = ad7606_spi_reg_write,
 	.rd_wr_cmd = ad7606b_spi_rd_wr_cmd,
 	.sw_mode_config = ad7606b_sw_mode_config,
+	.update_scan_mode = ad7606_spi_update_scan_mode,
 };
 
 static const struct ad7606_bus_info ad7605_4_bus_info = {

---
base-commit: 350224bdb9725aab5b90d72fc3db7618ebd232ae
change-id: 20250430-iio-adc-ad7606_spi-fix-offload-scan-mask-check-1d330400c014

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


