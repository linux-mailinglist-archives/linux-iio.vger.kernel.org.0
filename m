Return-Path: <linux-iio+bounces-9042-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4A4968FA3
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 00:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F45B1F24621
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 22:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390EC189BB9;
	Mon,  2 Sep 2024 22:29:13 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A155318953E
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 22:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725316153; cv=none; b=rtaff2Wg9+lbzvrD9XJVg2QXTV8c4NvC9FxpZTlijM4W2WgDnTLNvLvD6ssXQxbQucRCDpt2kZ/VOoDfCP/9UzLKtie3SZk/eS6pvN9ZTIudEpiVVKYU1/C9ATind8w8+E+mpFm7j5craO4xMpZUfiBGYnVxc/BWJTuJ/OWpd8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725316153; c=relaxed/simple;
	bh=TJVJWUgFroHz4D1KAqxrh0hBNP9FzfldUPa3LBUsFjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PrcUqSNE2tiB4ksfMy4whjBbU1L0hEsj996AcMY+KqrxsyVMhCtXXgNc5Hj1UqS24pgh1lt3KKdORRRYCNX9MyNhRFYlr0QGo63V+8s8jRTyGZW6o9X00V6hVzujeIbWlAwFrMrXh5i+ZDw4EdAODMe6nKEsZnMShlRzE1Z2Jes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id af57ce29-697a-11ef-8ecb-005056bdf889;
	Tue, 03 Sep 2024 01:28:32 +0300 (EEST)
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
Subject: [PATCH v1 05/22] iio: adc: ad7793: Get platform data via dev_get_platdata()
Date: Tue,  3 Sep 2024 01:16:50 +0300
Message-ID: <20240902222824.1145571-6-andy.shevchenko@gmail.com>
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
 drivers/iio/adc/ad7793.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index abebd519cafa..b86e89370e0d 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -770,7 +770,7 @@ static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
 
 static int ad7793_probe(struct spi_device *spi)
 {
-	const struct ad7793_platform_data *pdata = spi->dev.platform_data;
+	const struct ad7793_platform_data *pdata = dev_get_platdata(&spi->dev);
 	struct ad7793_state *st;
 	struct iio_dev *indio_dev;
 	int ret, vref_mv = 0;
-- 
2.46.0


