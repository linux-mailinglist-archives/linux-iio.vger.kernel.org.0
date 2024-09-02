Return-Path: <linux-iio+bounces-9052-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F63968FC7
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 00:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50274B24A7A
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 22:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55DE190470;
	Mon,  2 Sep 2024 22:30:09 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F861A4E8A
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 22:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725316209; cv=none; b=smOtV1+oMMWAh25m4rOUPQy/tAQ+Obi+lpqhksnx2TtgYiOKTRkL+wzDYy32kbDwCZkuqAbctIhKdp1P3PhHeNuUc/LMzBlgcemnNeuZUe9+xKSnXkYw/2Q4Oi91EjPQcJaSGB9f2IWPDAOHs9NIg/B13XLGY7++XDa18pLNhjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725316209; c=relaxed/simple;
	bh=wVFOFwNG96ZS5JTknDbiM35iEs7p1s20pBFB9wSWHWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4pDAtckH+hZFuCRf7razsnTrXP8IUM85b0mTXMjss8ES/l4RCDP91Nye+XZDC81g6yUMLN7//qEmWcOX2woxxm7xqJSfNspldyVXWIZlG0/GwdJnlBlIFRsB8DaBlOm/JBHRmLsRAwqd+YLXAwOJXsW58ebBXrFu/9wD5lCIWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id b6db18c5-697a-11ef-8e8a-005056bd6ce9;
	Tue, 03 Sep 2024 01:28:45 +0300 (EEST)
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
Subject: [PATCH v1 20/22] iio: orientation: hid-sensor-rotation: Get platform data via dev_get_platdata()
Date: Tue,  3 Sep 2024 01:17:05 +0300
Message-ID: <20240902222824.1145571-21-andy.shevchenko@gmail.com>
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
 drivers/iio/orientation/hid-sensor-rotation.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index 5e8cadd5177a..107adadf7711 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -230,11 +230,11 @@ static int dev_rot_parse_report(struct platform_device *pdev,
 /* Function to initialize the processing for usage id */
 static int hid_dev_rot_probe(struct platform_device *pdev)
 {
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
 	int ret;
 	char *name;
 	struct iio_dev *indio_dev;
 	struct dev_rot_state *rot_state;
-	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev,
 					  sizeof(struct dev_rot_state));
@@ -329,7 +329,7 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
 /* Function to deinitialize the processing for usage id */
 static void hid_dev_rot_remove(struct platform_device *pdev)
 {
-	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct dev_rot_state *rot_state = iio_priv(indio_dev);
 
-- 
2.46.0


