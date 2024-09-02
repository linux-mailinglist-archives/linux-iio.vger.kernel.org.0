Return-Path: <linux-iio+bounces-9049-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C32C8968FBF
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 00:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F136BB243BC
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 22:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CD318F2DD;
	Mon,  2 Sep 2024 22:29:45 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8326C18E03D
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 22:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725316184; cv=none; b=hgyH9NYIjJKj9xpQJMEPZTighjkedjRzBnLEccQYwBPjNYm1mfj5OznPp6k5jf4zsAFQD9F4Rd/kTWVe8kmrAozkwnV3yhEvjhsceAXVjAfKSQayAmi0ykvpnr4TJ2tpGBq47d8E6WDeNgLoGnSzAy5yGR7pGzf9CLWxftMR3UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725316184; c=relaxed/simple;
	bh=VPi5go2UZSyYcoqWpNRAu5quJSpMf/nZhR31FMIQHoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2WnHTtaP++tHnFVeaqHDPfDukeFdarb7eMle3NLPfmL1F64rzmRnsO3lc1QgdKSF//HaSCwJvahZ2qiLZ7swhg7W2FS3Kd8zaaUrNy/0Q3cNpfmTF1Atkv7CRGC8b1ywLW0D+ierGnhtYRWMEL7WRPv1sCYpYh8dOlyGbvqYEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id b563aa78-697a-11ef-abae-005056bdd08f;
	Tue, 03 Sep 2024 01:28:42 +0300 (EEST)
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
Subject: [PATCH v1 18/22] iio: magnetometer: hid-sensor-magn-3d: Get platform data via dev_get_platdata()
Date: Tue,  3 Sep 2024 01:17:03 +0300
Message-ID: <20240902222824.1145571-19-andy.shevchenko@gmail.com>
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
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index 5c795a430d09..ae10db87d1e1 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -466,11 +466,11 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 /* Function to initialize the processing for usage id */
 static int hid_magn_3d_probe(struct platform_device *pdev)
 {
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
 	int ret = 0;
 	static char *name = "magn_3d";
 	struct iio_dev *indio_dev;
 	struct magn_3d_state *magn_state;
-	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
 	struct iio_chan_spec *channels;
 	int chan_count = 0;
 
@@ -549,7 +549,7 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 /* Function to deinitialize the processing for usage id */
 static void hid_magn_3d_remove(struct platform_device *pdev)
 {
-	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct magn_3d_state *magn_state = iio_priv(indio_dev);
 
-- 
2.46.0


