Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A3A264B7F
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 19:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgIJRjq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 13:39:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727032AbgIJRhL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:37:11 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38B1B22226;
        Thu, 10 Sep 2020 17:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759356;
        bh=EgNyny7tY6Sx+fJIB487Wky48EnLP3lyv7nkTARfNC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WXEvF0qpNCXdGDcULruKFQ+84fLfAjtxTjiHv5lewR0fTDUVgO0WiQiCX0cRBMpj7
         1mesaUGIZtpED1Th5gFlgomMGy5C2wwbzsL8UOSFZZ7bEMze8ZDWkPEdlwVEonoE78
         s5SwTjmlmGyNDuysXyJ2kebZ9Ds8aRSM5nRTl9ik=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 32/38] iio:proximity:as3935: Drop of_match_ptr and use generic fw accessors
Date:   Thu, 10 Sep 2020 18:32:36 +0100
Message-Id: <20200910173242.621168-33-jic23@kernel.org>
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

This change allows the driver to be used with ACPI PRP0001 and removes
an antipattern that I want to avoid being copied into new IIO drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/proximity/as3935.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index 4df8d53d65fb..b79ada839e01 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
@@ -356,7 +357,6 @@ static int as3935_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 	struct iio_trigger *trig;
 	struct as3935_state *st;
-	struct device_node *np = dev->of_node;
 	int ret;
 
 	/* Be sure lightning event interrupt is specified */
@@ -375,7 +375,7 @@ static int as3935_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 	mutex_init(&st->lock);
 
-	ret = of_property_read_u32(np,
+	ret = device_property_read_u32(dev,
 			"ams,tuning-capacitor-pf", &st->tune_cap);
 	if (ret) {
 		st->tune_cap = 0;
@@ -389,7 +389,7 @@ static int as3935_probe(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	ret = of_property_read_u32(np,
+	ret = device_property_read_u32(dev,
 			"ams,nflwdth", &st->nflwdth_reg);
 	if (!ret && st->nflwdth_reg > AS3935_NFLWDTH_MASK) {
 		dev_err(dev, "invalid nflwdth setting of %d\n",
@@ -471,7 +471,7 @@ MODULE_DEVICE_TABLE(spi, as3935_id);
 static struct spi_driver as3935_driver = {
 	.driver = {
 		.name	= "as3935",
-		.of_match_table = of_match_ptr(as3935_of_match),
+		.of_match_table = as3935_of_match,
 		.pm	= AS3935_PM_OPS,
 	},
 	.probe		= as3935_probe,
-- 
2.28.0

