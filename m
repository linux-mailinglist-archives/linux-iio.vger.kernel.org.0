Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B572B228719
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 19:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbgGURQy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jul 2020 13:16:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730313AbgGURQv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 21 Jul 2020 13:16:51 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6E72207BB;
        Tue, 21 Jul 2020 17:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595351811;
        bh=JVhwIlzBLcTPaxL/9vZkWGfMRn9t9TqJg8QDSMKRhew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lh56TkvwYM/2YiLGJ5vDBjJzy5p1D+rPWDCn98YUQIkpfcQpqqOb0mwydgzMOf05D
         +JeRlpMCkmLMvzTXiDY3dRkRAhknCuhHlfXlFtbSG80nKfoTcSijVP00UOIgNgBIU+
         tkMrVTkTse4EiSIj6Ge5ZNs96rh6hwvluVtT1QH4=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 2/5] iio:adc:ti-adc081c: Drop ACPI ids that seem very unlikely to be official.
Date:   Tue, 21 Jul 2020 18:14:41 +0100
Message-Id: <20200721171444.825099-3-jic23@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200721171444.825099-1-jic23@kernel.org>
References: <20200721171444.825099-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

We have no known users of these in the wild.
it seems very unlikely these are real IDS having the form ADCXXXX
as that ID is owned by Achnor Datacomm not TI.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v1->v2
New patch 
 drivers/iio/adc/ti-adc081c.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
index 9426f70a8005..8bc04cfae465 100644
--- a/drivers/iio/adc/ti-adc081c.c
+++ b/drivers/iio/adc/ti-adc081c.c
@@ -19,7 +19,6 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
-#include <linux/acpi.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
@@ -153,17 +152,7 @@ static int adc081c_probe(struct i2c_client *client,
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
 		return -EOPNOTSUPP;
 
-	if (ACPI_COMPANION(&client->dev)) {
-		const struct acpi_device_id *ad_id;
-
-		ad_id = acpi_match_device(client->dev.driver->acpi_match_table,
-					  &client->dev);
-		if (!ad_id)
-			return -ENODEV;
-		model = &adcxx1c_models[ad_id->driver_data];
-	} else {
-		model = &adcxx1c_models[id->driver_data];
-	}
+	model = &adcxx1c_models[id->driver_data];
 
 	iio = devm_iio_device_alloc(&client->dev, sizeof(*adc));
 	if (!iio)
@@ -238,21 +227,10 @@ static const struct of_device_id adc081c_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, adc081c_of_match);
 
-#ifdef CONFIG_ACPI
-static const struct acpi_device_id adc081c_acpi_match[] = {
-	{ "ADC081C", ADC081C },
-	{ "ADC101C", ADC101C },
-	{ "ADC121C", ADC121C },
-	{ }
-};
-MODULE_DEVICE_TABLE(acpi, adc081c_acpi_match);
-#endif
-
 static struct i2c_driver adc081c_driver = {
 	.driver = {
 		.name = "adc081c",
 		.of_match_table = adc081c_of_match,
-		.acpi_match_table = ACPI_PTR(adc081c_acpi_match),
 	},
 	.probe = adc081c_probe,
 	.remove = adc081c_remove,
-- 
2.27.0

