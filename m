Return-Path: <linux-iio+bounces-21644-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B7CB04767
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jul 2025 20:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CB5D4A5A43
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jul 2025 18:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D47211A11;
	Mon, 14 Jul 2025 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rqd0M6Pc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CD31C2DB2;
	Mon, 14 Jul 2025 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752517812; cv=none; b=iBbco2/qS0ZGrjEN1jq486LS0ySdM3yT39CeDgFisIYGokpQW6ow33yaaCq2+qQ2lAdZsZgUvIAZIMVkAn47+KM/Z3VMtm2w3cHufUpD3BtIZY1RTC6xFrMuPGii8Zg3dvxeftjiXid/py0AOap3R6wxVzta4/YJtOerIvAvJ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752517812; c=relaxed/simple;
	bh=x1Dp46qhM8pjJBDYWQmgtDIbL4L5K6IA7fyqqpdITtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UvlxWHv7khjITZwiEOdfuOThCSsBHz3xYIH2ExD3IOJ4JlHWkS5klym1e9i3Hm/1oLBZKugkeO/92LgGOCtc2+mYDaThtAYtqCc40xm1d2ABtIIvBCl4rdQCEskTgmRXUiQ5vhhV5jTqceOLIeV82TkEUyme1GgrgC6UMvZQBoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rqd0M6Pc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B17EC4CEED;
	Mon, 14 Jul 2025 18:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752517811;
	bh=x1Dp46qhM8pjJBDYWQmgtDIbL4L5K6IA7fyqqpdITtM=;
	h=From:Date:Subject:To:Cc:From;
	b=Rqd0M6PcnCvHReFkHZoGW3huR56AKLOzsWJ7NIOT1Ovc/CEar/SAU4PMn1waScgbM
	 BMZKlZyG3a6gcs7Q8pDK2TNylBzo9LV2rnhcF9CFs8fphxD1WIksrDUG59ywkPClFi
	 rNqypa8CgEkc8EcgJus1PvqcRWS5JqIvzff3K9l3bvcProDgAKAQOHykyzxSUmv2Si
	 rFG3Ffa4GUjXw99oLGKiOcYODsjizej+BGF61YBDtEMswfI9uC0jg2hwupqN0+MpDR
	 mscrMLaPq9ke5GKDPEafFJSKURBl54C3GiekbZM91CXTL4+Z2K4Vy1ZvdQPzhyuHd/
	 84kzFXbCn0yww==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 14 Jul 2025 11:30:04 -0700
Subject: [PATCH] iio: adc: ad_sigma_delta: Select IIO_BUFFER_DMAENGINE and
 SPI_OFFLOAD
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-iio-ad_sigma_delta-fix-kconfig-selects-v1-1-32e0d6da0423@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKtMdWgC/x2N0QqDMAwAf0XybEDtnMVfEZHSxC7MtdLIGIj/v
 uLjwXF3gnIWVhirEzJ/RSXFAm1dgX+5GBiFCkPXdH0ztA8USehoUQkftxBvh8NVfvj2Ka4SUHl
 jfyg+eSDjrbHWEJTYnrlo92iar+sPqb8+zXgAAAA=
X-Change-ID: 20250714-iio-ad_sigma_delta-fix-kconfig-selects-6e7d3c83883d
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1574; i=nathan@kernel.org;
 h=from:subject:message-id; bh=x1Dp46qhM8pjJBDYWQmgtDIbL4L5K6IA7fyqqpdITtM=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBmlPhtjPF5qrl1VtOPZ3cKIILGrG/TYHH7O3Kj053z3k
 lnXD5zJ6ShlYRDjYpAVU2Spfqx63NBwzlnGG6cmwcxhZQIZwsDFKQATeRnFyLAoctHHuq/dl54G
 pPqaunydcrvsyO3I/bNcjI5c9Xi4f7IfI8Om9UKmuS3J/0MMQh199Lzv3um9z7pGiudU0x1vEf5
 ZwfwA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

CONFIG_AD_SIGMA_DELTA uses several symbols that it does not explicitly
select. If no other enabled driver selects them, the build fails with
either a linker failure if the driver is built in or a modpost failure
if the driver is a module.

  ld.lld: error: undefined symbol: devm_spi_offload_rx_stream_request_dma_chan
  ld.lld: error: undefined symbol: devm_iio_dmaengine_buffer_setup_with_handle
  ld.lld: error: undefined symbol: devm_spi_offload_trigger_get
  ld.lld: error: undefined symbol: devm_spi_offload_get
  ld.lld: error: undefined symbol: spi_offload_trigger_enable
  ld.lld: error: undefined symbol: spi_offload_trigger_disable

Select the necessary Kconfig symbols to include these functions in the
build to clear up the errors.

Fixes: 219da3ea842a ("iio: adc: ad_sigma_delta: add SPI offload support")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/iio/adc/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index d43edc7b0c0f..6de2abad0197 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -22,7 +22,9 @@ config AB8500_GPADC
 config AD_SIGMA_DELTA
 	tristate
 	select IIO_BUFFER
+	select IIO_BUFFER_DMAENGINE
 	select IIO_TRIGGERED_BUFFER
+	select SPI_OFFLOAD
 
 config AD4000
 	tristate "Analog Devices AD4000 ADC Driver"

---
base-commit: 1d71d4a318fb911ff9594d82c9fbd206e510b32f
change-id: 20250714-iio-ad_sigma_delta-fix-kconfig-selects-6e7d3c83883d

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


