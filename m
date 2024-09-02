Return-Path: <linux-iio+bounces-9050-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0746C968FC0
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 00:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFA271F256D8
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 22:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094E818FDAB;
	Mon,  2 Sep 2024 22:29:50 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4E118FC91
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 22:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725316189; cv=none; b=bpEoGvVtkzmaFP25SCXrkKQmfmxfg4NS4PBm8EDxYY+IPA9ETl8dzOYd7iLT+VPjsHhLI5glMyG7fMKyaEKPtLCcn6zHQchnHO+96Uihnp7nXiybSmIBR0kUDBpIiVaF2UehbibH990ayg7RQFdiMcpQ8ULt4oHoVz8VXs1Da/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725316189; c=relaxed/simple;
	bh=Ul7D5wVVmqAMqo0mpEDHlr0YAPA1NGYKbyJmDz49LVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m2gvlNFYg5SmOGV3k6Knw6Y4t7dsRrKrqIHr0XksDmA+pVZsoWcwKevxG9mNCNm3PuuqOBIhAMY6oLDEKD/dzv/JO84DgjcTuCbeD275i+VvQ8wk2XjiuSW2n3NMC/oZrYndiptmW4HWwBUGhTXAGzB2VHYDXKTzkw7B5FitrIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id b60e9e8e-697a-11ef-8e8a-005056bd6ce9;
	Tue, 03 Sep 2024 01:28:44 +0300 (EEST)
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
Subject: [PATCH v1 19/22] iio: orientation: hid-sensor-incl-3d: Get platform data via dev_get_platdata()
Date: Tue,  3 Sep 2024 01:17:04 +0300
Message-ID: <20240902222824.1145571-20-andy.shevchenko@gmail.com>
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
 drivers/iio/orientation/hid-sensor-incl-3d.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index 8943d5c78bc0..21664563b565 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -299,11 +299,11 @@ static int incl_3d_parse_report(struct platform_device *pdev,
 /* Function to initialize the processing for usage id */
 static int hid_incl_3d_probe(struct platform_device *pdev)
 {
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
 	int ret;
 	static char *name = "incli_3d";
 	struct iio_dev *indio_dev;
 	struct incl_3d_state *incl_state;
-	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev,
 					  sizeof(struct incl_3d_state));
@@ -385,7 +385,7 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 /* Function to deinitialize the processing for usage id */
 static void hid_incl_3d_remove(struct platform_device *pdev)
 {
-	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct incl_3d_state *incl_state = iio_priv(indio_dev);
 
-- 
2.46.0


