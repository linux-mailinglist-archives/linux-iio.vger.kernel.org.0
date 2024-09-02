Return-Path: <linux-iio+bounces-9044-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01602968FA6
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 00:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3432C1C2373F
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 22:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6A618B486;
	Mon,  2 Sep 2024 22:29:16 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E8018BB88
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 22:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725316156; cv=none; b=bMR/71CZQDEU7ZyJ7cOXjLM5Cie1aemPNAwqjYSwA/RFDXTfUkPaSXPbYaHPyr2uH9wSbplk7p57RkjQUOuyY6al8mcukUC/WMevCShdaEzRoHoWSDO2+J5s3vZK0wz6aKGvBgNicvmoefPoimWdFsv1xCorMi/hs29LZwn87mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725316156; c=relaxed/simple;
	bh=JbN8T71a/PZKhOL1QNhERt7e8cyfCWMB8Ep8u0D95s4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mETR9DZQ0faCUY9j+VxtBVwz+1A1L/DbvQJccKcnQz+oTn0f0LMTfg1l8rFKE7NHd4xZeBVF1WXhn2Q7+a6xuxhosYUvEg8Bb92HhKWr/yGxnDPzwPIZJRFu7dXEL3Llq+3g8YiD67w9ftxaEX+5KbKVusFQWLxkzu4O/4mhdd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id aff40cbd-697a-11ef-8e8a-005056bd6ce9;
	Tue, 03 Sep 2024 01:28:33 +0300 (EEST)
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
Subject: [PATCH v1 06/22] iio: adc: ltc2497: Get platform data via dev_get_platdata()
Date: Tue,  3 Sep 2024 01:16:51 +0300
Message-ID: <20240902222824.1145571-7-andy.shevchenko@gmail.com>
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

While at it, drop duplicate NULL check that iio_map_array_register()
already has.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/adc/ltc2497-core.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
index 996f6cbbed3c..ad8ddf80310e 100644
--- a/drivers/iio/adc/ltc2497-core.c
+++ b/drivers/iio/adc/ltc2497-core.c
@@ -168,6 +168,7 @@ static const struct iio_info ltc2497core_info = {
 int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
 {
 	struct ltc2497core_driverdata *ddata = iio_priv(indio_dev);
+	struct iio_map *plat_data = dev_get_platdata(dev);
 	int ret;
 
 	/*
@@ -200,16 +201,10 @@ int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
 		return ret;
 	}
 
-	if (dev->platform_data) {
-		struct iio_map *plat_data;
-
-		plat_data = (struct iio_map *)dev->platform_data;
-
-		ret = iio_map_array_register(indio_dev, plat_data);
-		if (ret) {
-			dev_err(&indio_dev->dev, "iio map err: %d\n", ret);
-			goto err_regulator_disable;
-		}
+	ret = iio_map_array_register(indio_dev, plat_data);
+	if (ret) {
+		dev_err(&indio_dev->dev, "iio map err: %d\n", ret);
+		goto err_regulator_disable;
 	}
 
 	ddata->addr_prev = LTC2497_CONFIG_DEFAULT;
-- 
2.46.0


