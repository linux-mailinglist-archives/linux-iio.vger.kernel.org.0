Return-Path: <linux-iio+bounces-9034-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD783968F90
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 00:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 126CCB227FF
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 22:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D2018891D;
	Mon,  2 Sep 2024 22:28:52 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B79187FFA
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 22:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725316132; cv=none; b=HhFscO2/0iJbK3JlC7CADLPkimg8GCIqIRIicpiTeb1kPhpEMWZeoh7jiuO6VzVuIrDhW1x7um3ldsJmd5k0C+l2ydJ61NuAXwA8qHyILhufdcilpULuHT+lcOEg3ie/nGFgsB1AVAqVKR9WsikwPenZ1Gz6c3WJgFPeVqqILbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725316132; c=relaxed/simple;
	bh=nHbfgrvQy0z0lM6FjGAHDJWcQ2iS9trkZXW+dADx3oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tAv7iKCplE18hqB4dfo2VY+6x1LjSv4j/S7BVY0gPcvh6lXmf9hoxjqUIZ7urU+5FbhTxvkWO6Uj+UNQzNHlaH/nTqwv7lV6hemwD0bAUYgDuA/yOp74w/GPWJ3QcCXVChheAD1NmBCDZE0o7kFUW79FBfBYmf2gANFPRvKzRv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id ae7e2ff2-697a-11ef-8e8a-005056bd6ce9;
	Tue, 03 Sep 2024 01:28:30 +0300 (EEST)
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
Subject: [PATCH v1 03/22] iio: adc: ad7791: Get platform data via dev_get_platdata()
Date: Tue,  3 Sep 2024 01:16:48 +0300
Message-ID: <20240902222824.1145571-4-andy.shevchenko@gmail.com>
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
 drivers/iio/adc/ad7791.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index 86effe8501b4..5d2ad3dd6caa 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -371,7 +371,7 @@ static const struct iio_info ad7791_no_filter_info = {
 };
 
 static int ad7791_setup(struct ad7791_state *st,
-			struct ad7791_platform_data *pdata)
+			const struct ad7791_platform_data *pdata)
 {
 	/* Set to poweron-reset default values */
 	st->mode = AD7791_MODE_BUFFER;
@@ -401,7 +401,7 @@ static void ad7791_reg_disable(void *reg)
 
 static int ad7791_probe(struct spi_device *spi)
 {
-	struct ad7791_platform_data *pdata = spi->dev.platform_data;
+	const struct ad7791_platform_data *pdata = dev_get_platdata(&spi->dev);
 	struct iio_dev *indio_dev;
 	struct ad7791_state *st;
 	int ret;
-- 
2.46.0


