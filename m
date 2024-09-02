Return-Path: <linux-iio+bounces-9031-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEE0968F85
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 00:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 414DBB2206C
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 22:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5998B188589;
	Mon,  2 Sep 2024 22:28:39 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC249188005
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 22:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725316119; cv=none; b=KDD6t69rakdH2nxyRWyZTM0gJzo2lZAHGdDuNlzhLquwgsGiyqMD3eELiSoxJdbc+E0dFC3+kGznbC//8lHeZSiqfKi8s4brwF3YBjEEOgtapCoSnuH/vDuh8L2LIteFOM9eotckicYXLXM2H7WpyCsZnATT7ERCV0p4Nf57Gmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725316119; c=relaxed/simple;
	bh=CKDqugtmZkhWcHcoOAEU1fuDv7m3PKG/IDTHg8/GOdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o5p9cNdYY2tVyw88nXz82EVYkizGkge/GovAxRUsgv1uEUHTWOtfr7/9NiKAkMa8I9GNfb6UM+r7i8StLVe1eqp2DCu+xm5++wLQ7YxnfxznmJKfNLjY3jvsAiGN1T5aa0nR4gLu2X5GNMmsiMDhnxRX2vQ5F7tOp91C/05wHPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id ad933de5-697a-11ef-abae-005056bdd08f;
	Tue, 03 Sep 2024 01:28:29 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 02/22] iio: adc: ad7266: Get platform data via dev_get_platdata()
Date: Tue,  3 Sep 2024 01:16:47 +0300
Message-ID: <20240902222824.1145571-3-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902222824.1145571-1-andy.shevchenko@gmail.com>
References: <20240902222824.1145571-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Access to platform data via dev_get_platdata() getter to make code cleaner.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/adc/ad7266.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 7949b076fb87..858c8be2ff1a 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -383,7 +383,7 @@ static const char * const ad7266_gpio_labels[] = {
 
 static int ad7266_probe(struct spi_device *spi)
 {
-	struct ad7266_platform_data *pdata = spi->dev.platform_data;
+	const struct ad7266_platform_data *pdata = dev_get_platdata(&spi->dev);
 	struct iio_dev *indio_dev;
 	struct ad7266_state *st;
 	unsigned int i;
-- 
2.46.0


