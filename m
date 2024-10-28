Return-Path: <linux-iio+bounces-11490-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 170EF9B3675
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 17:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0390281153
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 16:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC611DED43;
	Mon, 28 Oct 2024 16:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7S6iAj2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE151DE896;
	Mon, 28 Oct 2024 16:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730132982; cv=none; b=tvuxBNpdlrTP0PDa8hK7mUC7wXou+0w6ID8KKfFBqxheuNOfryzok5Qp6jqFIVTSBerz3BsJYFTYnAQ0ta1g1W2Vi8BjdMfpjMq6Hoj2DsqQLzqznRLEBOPnZFOr8LOG/i0/yV5LZi1Pf8F/dGo/ryDYX2R4LOSsDDCW2BpeMAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730132982; c=relaxed/simple;
	bh=DolnAK1KZ/oHw0bM0p/mKe8AbWR+8hjG72u+kf3nPkw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qq7cHMxE3682PUzrBSmi90wSatsh6U58sEy+jO5wCawZRpGpIQRE6KjMqD9sFT+LhuJOrYwnGiyGabuxly4NLRn7diqQE7ys+CDYR9Evt82neqU6wJSQ+F+7Ts4YT1CbzxqaT8mgeTgDF8nrwmIs+/OxeMn5DblIu7CZsK3ojfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7S6iAj2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E4AC4CEC3;
	Mon, 28 Oct 2024 16:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730132981;
	bh=DolnAK1KZ/oHw0bM0p/mKe8AbWR+8hjG72u+kf3nPkw=;
	h=From:To:Cc:Subject:Date:From;
	b=N7S6iAj2Z9Bh8NqFA7C85XHeusxnye38qiUaWCz0o0noLc9ypBmHE9RusVDcWd6It
	 NykHgtzd68DQpMfhegqAGZPGVdQl/ForS8Vh3xm2t1ZTshDorHn2jJLCf1Q7k2NhWO
	 7czvEuW05ouPT75aDkWK/HmWTrvdHRFgf6HWUKoqfKCtIY1c33iIQ/dqFG2gQo47Cd
	 kJVQVAWwbk9M+wOc7M12Fcx7VcmSuW8/Sv9zatEct7tYIWY62o0IlbbgSkR8phOkov
	 Z6Sqt+Ws2mAeaK1s8rVeAVOaDPpm9cwetSumdpscsZqOC2E4JZfEBMx1RJQx127yaJ
	 +UAKmY0JuNR/w==
From: Arnd Bergmann <arnd@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Nuno Sa <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: iio: adc: ad777x depends on CRC8
Date: Mon, 28 Oct 2024 16:29:15 +0000
Message-Id: <20241028162937.2171535-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The newly added driver fails to link when CONFIG_CRC8 is not set:

ld.lld-20: error: undefined symbol: crc8_populate_msb
ld.lld-20: error: undefined symbol: crc8
>>>               vmlinux.o:(ad7779_spi_read)

Select this from Kconfig as we do for other drivers like it.

Fixes: cc20fa9e9ad4 ("drivers: iio: adc: add support for ad777x family")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index d8abe28eec89..849c90203071 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -290,6 +290,7 @@ config AD7768_1
 config AD7779
 	tristate "Analog Devices AD7779 ADC driver"
 	depends on SPI
+	select CRC8
 	select IIO_BUFFER
 	help
 	  Say yes here to build support for Analog Devices AD777X family
-- 
2.39.5


