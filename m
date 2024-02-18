Return-Path: <linux-iio+bounces-2735-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEE485982A
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 18:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E862811F4
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 17:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CE46EB75;
	Sun, 18 Feb 2024 17:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdVyXD/s"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85876EB6E
	for <linux-iio@vger.kernel.org>; Sun, 18 Feb 2024 17:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708277288; cv=none; b=qba05HZGTAKqq2r7jv+WI5fow1/rJFmzh4A2UJejAn2Cv7ZsAUjV7zbb41aGv37jDo6fk7i9Rkh9lzyF0KqVF3/txGwMmCwP2wPJHDqc3ZwOgNaKQaeawdLoGZKVciZk8iZfFUY4PdbakYIW5B9HBwTA5waQx8LsRb/1snu7nuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708277288; c=relaxed/simple;
	bh=qMELB7PQmn3jz1qdSc2O9qlVDGZ3OQJIk3MInMF/wUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJi6AqSlpzw+d0y5lLpP1ul6g2r0/CLlUxRD800p21G6oJS/BefSiEPwsmeL6t1sTUQrCTOOdDPLIH5u6ormNyr8XdoEv/Uwj1xjEItAEjDVJ0tAOM+gr3J6UI0s1fHaBwTwTT/2BZYHyZznyCyexaDfNDJVt3krcy2ddyUDGrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdVyXD/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2DCEC433C7;
	Sun, 18 Feb 2024 17:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708277288;
	bh=qMELB7PQmn3jz1qdSc2O9qlVDGZ3OQJIk3MInMF/wUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DdVyXD/sIO5uOLVAQvmOFMemF2AMXSCK8c55tS0FBtTifRZLvb47ixXPETnkaBqmR
	 PpRgGLG2AwY9FfsLDNuP0OTtZ/yU+80hUyEIDYTEKhYFOPF98nDbF+3UTso+LEBh6c
	 AKWVRkQC6jEmCu3lLCB8bTCQ6WC5v8GW1Ak04VJQpZoVlz77zVWAkWJpKq953mnNKt
	 2maZPZIpA/LSsPMsTUj6ZcRANI/uUUCm0Nk1h+ftW7VBnDla5YCUSiocS+4jeXrSR+
	 LKxCTZCIE+7bz2wfFLca82Y7VdiYV0Cf6VvJgy2PKlhWRcnlxYml3YSP2Ah6ApH9xy
	 HCSfEipV++LVQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Sean Nyekjaer <sean@geanix.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 8/8] iio: adc: hx711: Switch from of specific to fwnode property handling.
Date: Sun, 18 Feb 2024 17:27:31 +0000
Message-ID: <20240218172731.1023367-9-jic23@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240218172731.1023367-1-jic23@kernel.org>
References: <20240218172731.1023367-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Allows driver to be used with other firmware types and removes an
example that might be copied into new IIO drivers.

Cc: Andreas Klinger <ak@it-klinger.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/hx711.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index c80c55fb8c6c..fef97c1d226a 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -7,7 +7,7 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/slab.h>
@@ -459,7 +459,6 @@ static const struct iio_chan_spec hx711_chan_spec[] = {
 static int hx711_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
 	struct hx711_data *hx711_data;
 	struct iio_dev *indio_dev;
 	int ret;
@@ -533,7 +532,7 @@ static int hx711_probe(struct platform_device *pdev)
 	hx711_data->gain_chan_a = 128;
 
 	hx711_data->clock_frequency = 400000;
-	ret = of_property_read_u32(np, "clock-frequency",
+	ret = device_property_read_u32(&pdev->dev, "clock-frequency",
 					&hx711_data->clock_frequency);
 
 	/*
-- 
2.43.2


