Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2B4264B6C
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 19:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgIJRhu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 13:37:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727808AbgIJRgI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:36:08 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51E4022204;
        Thu, 10 Sep 2020 17:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759337;
        bh=cXootZKrgeLDcJ9SEVrRtl/e4xuUl1nD7EO4bR3RNTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P4njzWQC1ICSW6RvZnUF79cBi+46jv5nulsUgovNaYnM571W0tXu4Ok2MTQtUDJiX
         mqlpf53yMFseq7L9I0fDyCIcCzf6z6JW5z2t8sgJJSMzJpBym+b/oRGUpJW2CqY/N3
         crvAvW85uicDRAfMLv8SLDMWSfvwHFO5X3rNDqRs=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH 18/38] iio:pressure:ms5611: Drop of_match_ptr and CONFIG_OF protections
Date:   Thu, 10 Sep 2020 18:32:22 +0100
Message-Id: <20200910173242.621168-19-jic23@kernel.org>
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

These prevents use of this driver with ACPI via PRP0001 and are
an example of an anti pattern I'm trying to remove from IIO.
Hence drop them from this driver.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Tomasz Duszynski <tduszyns@gmail.com>
---
 drivers/iio/pressure/ms5611_i2c.c | 6 ++----
 drivers/iio/pressure/ms5611_spi.c | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/pressure/ms5611_i2c.c b/drivers/iio/pressure/ms5611_i2c.c
index 072c106dd66d..7c04f730430c 100644
--- a/drivers/iio/pressure/ms5611_i2c.c
+++ b/drivers/iio/pressure/ms5611_i2c.c
@@ -14,7 +14,7 @@
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
 
 #include <asm/unaligned.h>
 
@@ -113,14 +113,12 @@ static int ms5611_i2c_remove(struct i2c_client *client)
 	return ms5611_remove(i2c_get_clientdata(client));
 }
 
-#if defined(CONFIG_OF)
 static const struct of_device_id ms5611_i2c_matches[] = {
 	{ .compatible = "meas,ms5611" },
 	{ .compatible = "meas,ms5607" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ms5611_i2c_matches);
-#endif
 
 static const struct i2c_device_id ms5611_id[] = {
 	{ "ms5611", MS5611 },
@@ -132,7 +130,7 @@ MODULE_DEVICE_TABLE(i2c, ms5611_id);
 static struct i2c_driver ms5611_driver = {
 	.driver = {
 		.name = "ms5611",
-		.of_match_table = of_match_ptr(ms5611_i2c_matches)
+		.of_match_table = ms5611_i2c_matches,
 	},
 	.id_table = ms5611_id,
 	.probe = ms5611_i2c_probe,
diff --git a/drivers/iio/pressure/ms5611_spi.c b/drivers/iio/pressure/ms5611_spi.c
index 4799aa57135e..45d3a7d5be8e 100644
--- a/drivers/iio/pressure/ms5611_spi.c
+++ b/drivers/iio/pressure/ms5611_spi.c
@@ -9,7 +9,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/spi/spi.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
 
 #include <asm/unaligned.h>
 
@@ -115,14 +115,12 @@ static int ms5611_spi_remove(struct spi_device *spi)
 	return ms5611_remove(spi_get_drvdata(spi));
 }
 
-#if defined(CONFIG_OF)
 static const struct of_device_id ms5611_spi_matches[] = {
 	{ .compatible = "meas,ms5611" },
 	{ .compatible = "meas,ms5607" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ms5611_spi_matches);
-#endif
 
 static const struct spi_device_id ms5611_id[] = {
 	{ "ms5611", MS5611 },
@@ -134,7 +132,7 @@ MODULE_DEVICE_TABLE(spi, ms5611_id);
 static struct spi_driver ms5611_driver = {
 	.driver = {
 		.name = "ms5611",
-		.of_match_table = of_match_ptr(ms5611_spi_matches)
+		.of_match_table = ms5611_spi_matches
 	},
 	.id_table = ms5611_id,
 	.probe = ms5611_spi_probe,
-- 
2.28.0

