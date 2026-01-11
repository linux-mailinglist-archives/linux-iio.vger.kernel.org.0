Return-Path: <linux-iio+bounces-27625-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F20BD0F77F
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 17:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA26F3033D52
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 16:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE7834C9A9;
	Sun, 11 Jan 2026 16:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ES9AQSWw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17AE883F
	for <linux-iio@vger.kernel.org>; Sun, 11 Jan 2026 16:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768150537; cv=none; b=RI3IWfeTaYP9JqNDP3YOekY4I1+zlUZ8RhchvD01FL9kFKXj1PDw1qkr4nQQHipGHU2WQFOUjiRgzkrqvu0c4QFhlLwxRyTn9fF7pPcjJ/Y/HsLAHUwA08c3g/FKHyConKo7L21sWlZYuF+Gx/o8ZqBEpRZotpkfvua59c32Ms4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768150537; c=relaxed/simple;
	bh=OyyjE72HGSvmyD713pATyGpQZWkpJ9Z7h/S0IlmwRu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BOfXgRJT+r5YencFApPVL4ZalNJLIx5DfVb8SuCY+t8aNmXIJ16CR6UleRMrPOv7KT6sZP2x+OaxmeLoqEoH0sEMSq49w77+O91UCPJBTasCXscYjyN+yK6TTrMAGd2B+teQJ9w5lbzj5P7cX4/jkN06tKGCdsDzYq+4bHH0JPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ES9AQSWw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C50EC4CEF7;
	Sun, 11 Jan 2026 16:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768150537;
	bh=OyyjE72HGSvmyD713pATyGpQZWkpJ9Z7h/S0IlmwRu8=;
	h=From:To:Cc:Subject:Date:From;
	b=ES9AQSWwsEBQz9kVzjLya26GlRE3qTYHfdebvvTFs0Ktq7hW5pwz94mvoBDDP0lQM
	 W1zyzAuDy4g0nDuVtLNCzygA1I7lw2YES9MyAUlBq4Jyl7FchZna/4eupG97PBdtEe
	 pfWQcIEhvUtGo+Au5Lx6uvF/ZOPAqILt/DyBsunPYJBv8F9BuG54jgs9ZFKIcdSm4+
	 jp4cEVqAs1gB/izJbieVwtOPE3fWIlNi2HZTpQFKEAxR44d3mUwInuH950e8ereNae
	 pkUxI4a0sQiYwa/1M+ENpe7HsC39g9UmwRxqlQAJQKIWFFDp0J/Axnoax/2bHLIOHb
	 jQUtiMrm2g1rA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Jonathan Santos <Jonathan.Santos@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] iio: adc: ad7768-1: Select GPIOLIB
Date: Sun, 11 Jan 2026 16:55:28 +0000
Message-ID: <20260111165528.284067-1-jic23@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This driver provides a gpio chip a some related functions are not
stubbed if GPIOLIB is not built.

   hppa-linux-ld: drivers/iio/adc/ad7768-1.o: in function `ad7768_gpio_get':
>> drivers/iio/adc/ad7768-1.c:420: undefined reference to `gpiochip_get_data'
   hppa-linux-ld: drivers/iio/adc/ad7768-1.o: in function `ad7768_gpio_set':
   drivers/iio/adc/ad7768-1.c:453: undefined reference to `gpiochip_get_data'
   hppa-linux-ld: drivers/iio/adc/ad7768-1.o: in function `ad7768_gpio_init':
>> drivers/iio/adc/ad7768-1.c:498: undefined reference to `devm_gpiochip_add_data_with_key'
   hppa-linux-ld: drivers/iio/adc/ad7768-1.o: in function `ad7768_gpio_direction_input':
   drivers/iio/adc/ad7768-1.c:387: undefined reference to `gpiochip_get_data'
   hppa-linux-ld: drivers/iio/adc/ad7768-1.o: in function `ad7768_gpio_direction_output':
   drivers/iio/adc/ad7768-1.c:404: undefined reference to `gpiochip_get_data'

Fixes: ("d569ae0f052e iio: adc: ad7768-1: Add GPIO controller support")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512271235.WwAmAbOa-lkp@intel.com/
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index b4295aa415bf..e37569f65524 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -409,6 +409,7 @@ config AD7766
 config AD7768_1
 	tristate "Analog Devices AD7768-1 ADC driver"
 	depends on SPI
+	select GPIOLIB
 	select REGULATOR
 	select REGMAP_SPI
 	select IIO_BUFFER
-- 
2.52.0


