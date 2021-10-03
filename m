Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B6E4202A3
	for <lists+linux-iio@lfdr.de>; Sun,  3 Oct 2021 18:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhJCQWM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Oct 2021 12:22:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230426AbhJCQWM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Oct 2021 12:22:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8692961AF9;
        Sun,  3 Oct 2021 16:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633278024;
        bh=Vj4SIoBsa2AmoiWATEhtxp82HLcd8IaL413loVr3pnA=;
        h=From:To:Cc:Subject:Date:From;
        b=KIbhdEc11kSXa1bzsN4jSbTdnEvxEDWJab/JLGodPAYIlyKNEyP2kftdFlw/O4/Fx
         2EdQfFz/OSWvC7kFs7GrWMQT2+oTYV/fUdeOocA54reIiuw2CHy0pHITSmifv3ePBn
         VRgwl9ZODogoIlzvOSPP+b+9lgw3qrZwTruW70n27TnKJwahUTrAyUZnrScunN9WCv
         Q4J4rAOf3wYDTHY2vAZxifW5duMAMAUfO7MNC/qNHvfyJNHAoaFrx2N/FYqK+3Xmeu
         y4+JqaJLUbpH9+QcLL60hQ4iYIUpNGwQoWRSqPtzdx75IEG3JmGd37LqrixNTFAhsw
         6WAFBB2+mbyPQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kunyang Fan <Kunyang_Fan@aaeon.com.tw>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH] iio: adc: ti-adc081c: Partial revert of removal of ACPI IDs
Date:   Sun,  3 Oct 2021 17:24:17 +0100
Message-Id: <20211003162417.427260-1-jic23@kernel.org>
X-Mailer: git-send-email 2.33.0
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

Reported-by: Kunyang Fan <Kunyang_Fan@aaeon.com.tw>
Fixes: c458b7ca3fd0 ("iio:adc:ti-adc081c: Drop ACPI ids that seem very unlikely to be official.")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
---
Kunyang Fan,

I left this for a while in the hope that you might be able to
provide more details on where this ID is used + whether there are
other similar IDs in use by AAEON firmwares.

That information would still be extremely useful given the vague
nature of the comment I have added will give us no real information
on whether we can drop this in the distant future.

Also, please test this patch to make sure I've put back everything
necessary.

drivers/iio/adc/ti-adc081c.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
index 16fc608db36a..0872a4897609 100644
--- a/drivers/iio/adc/ti-adc081c.c
+++ b/drivers/iio/adc/ti-adc081c.c
@@ -15,6 +15,7 @@
  * bits of value registers are reserved.
  */
 
+#include <linux/acpi.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
@@ -162,7 +163,17 @@ static int adc081c_probe(struct i2c_client *client,
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
 		return -EOPNOTSUPP;
 
-	model = &adcxx1c_models[id->driver_data];
+	if (ACPI_COMPANION(&client->dev)) {
+		const struct acpi_device_id *ad_id;
+
+		ad_id = acpi_match_device(client->dev.driver->acpi_match_table,
+					  &client->dev);
+		if (!ad_id)
+			return -ENODEV;
+		model = &adcxx1c_models[ad_id->driver_data];
+	} else {
+		model = &adcxx1c_models[id->driver_data];
+	}
 
 	iio = devm_iio_device_alloc(&client->dev, sizeof(*adc));
 	if (!iio)
@@ -210,6 +221,13 @@ static const struct i2c_device_id adc081c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, adc081c_id);
 
+static const struct acpi_device_id adc081c_acpi_match[] = {
+	/* Used on some AAEON boards */
+	{ "ADC081C", ADC081C },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, adc081c_acpi_match);
+
 static const struct of_device_id adc081c_of_match[] = {
 	{ .compatible = "ti,adc081c" },
 	{ .compatible = "ti,adc101c" },
@@ -222,6 +240,7 @@ static struct i2c_driver adc081c_driver = {
 	.driver = {
 		.name = "adc081c",
 		.of_match_table = adc081c_of_match,
+		.acpi_match_table = adc081c_acpi_match,
 	},
 	.probe = adc081c_probe,
 	.id_table = adc081c_id,
-- 
2.33.0

