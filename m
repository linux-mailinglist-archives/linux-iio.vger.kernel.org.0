Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E41F264B91
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 19:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgIJRkN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 13:40:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbgIJRfs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:35:48 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6220221D90;
        Thu, 10 Sep 2020 17:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759317;
        bh=YS4gAiSw2mEy2kXOy+RZEFyGI5yFPZtd5djTX23+YXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jF8OtCoPPikHeHfTGm9bFj6BoyDMXVdGE2HfqrpFStlbYIFneN48HkyJCobfhrg5K
         WmFQjonOyRh0ML3zFwy12fnnFcr7/99A26jl5y3A0qAXz8m1Qh5mwwKJKs5n6uIE47
         EwBL1H2XLpEs2xYC3SwyYJt8JodlJyhFpU0LHGQU=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maury Anderson <maury.anderson@rockwellcollins.com>,
        Matthew Weber <matthew.weber@rockwellcollins.com>,
        Slawomir Stepien <sst@poczta.fm>
Subject: [PATCH 04/38] iio:potentiometer:max5481: Drop of_match_ptr and CONFIG_OF protections.
Date:   Thu, 10 Sep 2020 18:32:08 +0100
Message-Id: <20200910173242.621168-5-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910173242.621168-1-jic23@kernel.org>
References: <20200910173242.621168-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These prevent use of this driver with ACPI via PRP0001 and are
an example of an anti pattern I'm trying to remove from IIO.
Whilst this driver has an ACPI binding, it is not of a form
that is valid under ACPI so will be dropped shortly.

Also switch to device_get_match_data() and switch headers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Maury Anderson <maury.anderson@rockwellcollins.com>
Cc: Matthew Weber <matthew.weber@rockwellcollins.com>
Cc: Slawomir Stepien <sst@poczta.fm>
---
 drivers/iio/potentiometer/max5481.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/potentiometer/max5481.c b/drivers/iio/potentiometer/max5481.c
index 5f5988189796..6d1e1a57cba1 100644
--- a/drivers/iio/potentiometer/max5481.c
+++ b/drivers/iio/potentiometer/max5481.c
@@ -11,8 +11,8 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
 #include <linux/spi/spi.h>
 
 /* write wiper reg */
@@ -117,7 +117,6 @@ static const struct iio_info max5481_info = {
 	.write_raw = max5481_write_raw,
 };
 
-#if defined(CONFIG_OF)
 static const struct of_device_id max5481_match[] = {
 	{ .compatible = "maxim,max5481", .data = &max5481_cfg[max5481] },
 	{ .compatible = "maxim,max5482", .data = &max5481_cfg[max5482] },
@@ -126,7 +125,6 @@ static const struct of_device_id max5481_match[] = {
 	{ }
 };
 MODULE_DEVICE_TABLE(of, max5481_match);
-#endif
 
 static int max5481_probe(struct spi_device *spi)
 {
@@ -144,7 +142,7 @@ static int max5481_probe(struct spi_device *spi)
 
 	data->spi = spi;
 
-	data->cfg = of_device_get_match_data(&spi->dev);
+	data->cfg = device_get_match_data(&spi->dev);
 	if (!data->cfg)
 		data->cfg = &max5481_cfg[id->driver_data];
 
@@ -198,7 +196,7 @@ MODULE_DEVICE_TABLE(acpi, max5481_acpi_match);
 static struct spi_driver max5481_driver = {
 	.driver = {
 		.name  = "max5481",
-		.of_match_table = of_match_ptr(max5481_match),
+		.of_match_table = max5481_match,
 		.acpi_match_table = ACPI_PTR(max5481_acpi_match),
 	},
 	.probe = max5481_probe,
-- 
2.28.0

