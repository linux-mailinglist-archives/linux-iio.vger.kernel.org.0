Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73FFF264B62
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 19:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgIJRhB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 13:37:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727775AbgIJRgA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:36:00 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF2E920731;
        Thu, 10 Sep 2020 17:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759331;
        bh=lrmBXop/WLuC0YA7CBQo5Yntd7FPhktdQfv6mz5kJ78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bi9zuTQ3OzM4/a0ecxf0ftD8jQwcLpWMBtI29Nv5ZrF5SnsNU13AVrpmCTjbQJzoN
         THE3sjsw6JAk2sk/hwewkc8AU2RUUORNt7c8w0myLh5LZGZFV9Ks/s8kC6k55I1fZ+
         b7Dc4uUZjoOZaWs/+KLc7v4csLu567v3wKXkG6So=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 14/38] iio:dac:ti-dac082s085: Drop of_match_ptr and CONFIG_OF protections
Date:   Thu, 10 Sep 2020 18:32:18 +0100
Message-Id: <20200910173242.621168-15-jic23@kernel.org>
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

These prevent the use of this driver with ACPI via PRP0001 and are
an example of an anti pattern I'm trying to remove from IIO.
Hence drop them from this driver.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lukas Wunner <lukas@wunner.de>
---
 drivers/iio/dac/ti-dac082s085.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/ti-dac082s085.c b/drivers/iio/dac/ti-dac082s085.c
index 86bfb1c3f9b9..de33c1fc6e0b 100644
--- a/drivers/iio/dac/ti-dac082s085.c
+++ b/drivers/iio/dac/ti-dac082s085.c
@@ -14,6 +14,7 @@
 
 #include <linux/iio/iio.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 
@@ -324,7 +325,6 @@ static int ti_dac_remove(struct spi_device *spi)
 	return 0;
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id ti_dac_of_id[] = {
 	{ .compatible = "ti,dac082s085" },
 	{ .compatible = "ti,dac102s085" },
@@ -335,7 +335,6 @@ static const struct of_device_id ti_dac_of_id[] = {
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ti_dac_of_id);
-#endif
 
 static const struct spi_device_id ti_dac_spi_id[] = {
 	{ "dac082s085", dual_8bit  },
@@ -351,7 +350,7 @@ MODULE_DEVICE_TABLE(spi, ti_dac_spi_id);
 static struct spi_driver ti_dac_driver = {
 	.driver = {
 		.name		= "ti-dac082s085",
-		.of_match_table	= of_match_ptr(ti_dac_of_id),
+		.of_match_table	= ti_dac_of_id,
 	},
 	.probe	  = ti_dac_probe,
 	.remove   = ti_dac_remove,
-- 
2.28.0

