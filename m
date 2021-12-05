Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B586468C63
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 18:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236626AbhLERZu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 12:25:50 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47488 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236618AbhLERZu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 12:25:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2535B6111A
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 17:22:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57F4C00446;
        Sun,  5 Dec 2021 17:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638724942;
        bh=HtN9lmLq/z0/ihnGkOLpQOcrBR28+wiTxn8AzNzjKBg=;
        h=From:To:Cc:Subject:Date:From;
        b=rS7zSF60rWDRfCle2+UDogBFn/xopUOVTdXUVxIs4aMHeKNmf14IxTCQSGlMaLBEe
         du+sC+vf2U/ZLLrP2nMoB8O2YIQYGuVGg8K3Hwx3nQAV2pllyL4tHg4ycSVn5CJEvT
         v1GnexUAAHNWUt7cKycS2loHGOHij1MQtz4oLeh4A8picIPIHwah2PB3WI0I8/CYvh
         pav9RJHc3AV7DTTSK/g6yB8y4473hZnwAxemrQu4mxC47heqGOAQMu9utrGLZWXAAO
         doka9VPjcWpOQ4efvJaeVs42GmAyHY/m3IkKwlPS2mfZGlrv2uqieo/+52DR1OcMlP
         jB/U/xUixVOJw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kunyang Fan <Kunyang_Fan@aaeon.com.tw>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2] iio: adc: ti-adc081c: Partial revert of removal of ACPI IDs
Date:   Sun,  5 Dec 2021 17:27:28 +0000
Message-Id: <20211205172728.2826512-1-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Unfortuanately a non standards compliant ACPI ID is known to be
in the wild on some AAEON boards.

Partly revert the removal of these IDs so that ADC081C will again
work + add a comment to that affect for future reference.

Whilst here use generic firmware properties rather than the ACPI
specific handling previously found in this driver.

Reported-by: Kunyang Fan <Kunyang_Fan@aaeon.com.tw>
Fixes: c458b7ca3fd0 ("iio:adc:ti-adc081c: Drop ACPI ids that seem very unlikely to be official.")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
---

Looking ideally for a tested-by for this from Kunyang Fan.

v2: Use generic firmware properties as Andy Shevchenko rightly suggested.
I took it a bit further than strictly necessary as I don't like putting
enums in the driver_data only to use them to index a table when we could
just use the pointers directly.

Note this driver does have device tree binding documentation
but that's a job for another day.  Or maybe later today if I get really
bored this evening :)

 drivers/iio/adc/ti-adc081c.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
index 16fc608db36a..bd48b073e720 100644
--- a/drivers/iio/adc/ti-adc081c.c
+++ b/drivers/iio/adc/ti-adc081c.c
@@ -19,6 +19,7 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/property.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
@@ -156,13 +157,16 @@ static int adc081c_probe(struct i2c_client *client,
 {
 	struct iio_dev *iio;
 	struct adc081c *adc;
-	struct adcxx1c_model *model;
+	const struct adcxx1c_model *model;
 	int err;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
 		return -EOPNOTSUPP;
 
-	model = &adcxx1c_models[id->driver_data];
+	if (dev_fwnode(&client->dev))
+		model = device_get_match_data(&client->dev);
+	else
+		model = &adcxx1c_models[id->driver_data];
 
 	iio = devm_iio_device_alloc(&client->dev, sizeof(*adc));
 	if (!iio)
@@ -210,10 +214,17 @@ static const struct i2c_device_id adc081c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, adc081c_id);
 
+static const struct acpi_device_id adc081c_acpi_match[] = {
+	/* Used on some AAEON boards */
+	{ "ADC081C", (kernel_ulong_t)&adcxx1c_models[ADC081C] },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, adc081c_acpi_match);
+
 static const struct of_device_id adc081c_of_match[] = {
-	{ .compatible = "ti,adc081c" },
-	{ .compatible = "ti,adc101c" },
-	{ .compatible = "ti,adc121c" },
+	{ .compatible = "ti,adc081c", .data = &adcxx1c_models[ADC081C] },
+	{ .compatible = "ti,adc101c", .data = &adcxx1c_models[ADC101C] },
+	{ .compatible = "ti,adc121c", .data = &adcxx1c_models[ADC121C] },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adc081c_of_match);
@@ -222,6 +233,7 @@ static struct i2c_driver adc081c_driver = {
 	.driver = {
 		.name = "adc081c",
 		.of_match_table = adc081c_of_match,
+		.acpi_match_table = adc081c_acpi_match,
 	},
 	.probe = adc081c_probe,
 	.id_table = adc081c_id,
-- 
2.34.1

