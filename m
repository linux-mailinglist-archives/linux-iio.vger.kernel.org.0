Return-Path: <linux-iio+bounces-21657-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C726B051FD
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 08:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF69E3B136F
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 06:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCD726CE1C;
	Tue, 15 Jul 2025 06:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bj91PUsq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D87022129E;
	Tue, 15 Jul 2025 06:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752561659; cv=none; b=nI+2MLwykEfZ3RRWRHWNsRzFymo1S6KpKgMlxMs99fpUXHeY4eJORIiP2Hni5gPbRIKSpBBJhXOchdI27LDDofUjVG3Q4JPlQrJVq0uEkTYcA6jF70SdBvhbC63JoyYiajceicE93sBnPRpblOTurBfDOdiag/NfrDMU6GrhcJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752561659; c=relaxed/simple;
	bh=2MFc+mqng9V53IYxCFsXcu15C5ZMnrscjd5cTTA+Am0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o6VgdRh+Wn74V4s0kxvcYaD+GoCJp/N/EquLV0br4LZ+HQuCdzxz3GprKXxtleLkasQwSNkny2wIuHF8Ok6jM8gJxdkBil+rQgm5ytjn6HdBzoEwuCcpu8KuB/xfYfR5DIqeAwWEBccg40q60kFCBNPgb2WdzKXrs2kmQg19miY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bj91PUsq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F30C4CEF4;
	Tue, 15 Jul 2025 06:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752561659;
	bh=2MFc+mqng9V53IYxCFsXcu15C5ZMnrscjd5cTTA+Am0=;
	h=From:To:Cc:Subject:Date:From;
	b=Bj91PUsq4hQy3RPbWRXv0N3oT6jEerpQ+3hWrk+9XpYAGmSiLTiCR9Q34LT0WUWxt
	 GvSonbm+AyirUn9bzCW/hBgMyavLGx2sjai4GHCjQSp9xDGTF+uyqCk0qJ/rJb6K9j
	 9eTWbyGuRwBQB50SXyyOTx723uHfbmJbHFHFBj0xD4S8gqtDBHjvEzOj5yVhC6QI/B
	 1XybCAgq5wQ1X2G0a7wlU/sqdhO6Eto8GHn3h5f3296Hj0LvfZrmHZfzBLFGqWUlR8
	 xXKUGlDZTG50/3uE2dwRCiBQe8A/5loX4PUEOUzEHnZhzZUoFK7kYCP2hpF7UQyIKx
	 +YzWUpr604HZg==
From: Arnd Bergmann <arnd@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andy@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: ad_sigma_delta: select CONFIG_IIO_BUFFER_DMAENGINE
Date: Tue, 15 Jul 2025 08:40:44 +0200
Message-Id: <20250715064053.3484105-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The newly added support for SPI offloading causes a link error
when the dmaengine buffer helpers are unavailable:

arm-linux-gnueabi-ld: drivers/iio/adc/ad_sigma_delta.o: in function `devm_ad_sd_setup_buffer_and_trigger':
ad_sigma_delta.c:(.text+0x6b8): undefined reference to `devm_iio_dmaengine_buffer_setup_with_handle'

Fixes: 219da3ea842a ("iio: adc: ad_sigma_delta: add SPI offload support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index d43edc7b0c0f..e2649739a2da 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -23,6 +23,7 @@ config AD_SIGMA_DELTA
 	tristate
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
+	select IIO_BUFFER_DMAENGINE
 
 config AD4000
 	tristate "Analog Devices AD4000 ADC Driver"
-- 
2.39.5


