Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C3622871A
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 19:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbgGURQz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jul 2020 13:16:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:55496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730259AbgGURQv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 21 Jul 2020 13:16:51 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B5FD20792;
        Tue, 21 Jul 2020 17:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595351810;
        bh=ucw080tQlfKhilxnj/V+gVSUilw/vxsoDGM2VnjUU6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NEkWvHslzDrJ/BX4YLsILUQ6QbDJr9vFziMgNHln3tXalaOwvnxhUcADW7u4F4kaB
         a2JZZrimFf7Ruq17UvVkRJ0kzAQS1YLDecBmOnNkV0KG6N1r5jXt8jIc0mAAVIy5sU
         xap71kXrP8YSbRTJeLKLdrIGDMDAAR2hDeht1XNY=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH v2 1/5] iio:adc:axp20x: Convert from OF to generic fw / device properties
Date:   Tue, 21 Jul 2020 18:14:40 +0100
Message-Id: <20200721171444.825099-2-jic23@kernel.org>
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

Whilst fairly unlikely anyone will ever use this driver with anything
other than DT, we are trying to move IIO over to the generic interfaces
where easy to do so.

In this case this involved moving to generic check on presence
of fw_node, generic device_get_match_data and dropping the of_match_ptr
protection.  Also relevant header changes to have property.h and
mod_devicetable.h only.

Also drop the casting away of a const in favour of retaining
the const throughout.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Quentin Schulz <quentin.schulz@bootlin.com>
---
v1->v2

* Avoid the casting away of const by keeping it const throughout.

drivers/iio/adc/axp20x_adc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index 798ff2d89691..3e0c0233b431 100644
--- a/drivers/iio/adc/axp20x_adc.c
+++ b/drivers/iio/adc/axp20x_adc.c
@@ -9,10 +9,10 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/thermal.h>
 
@@ -67,7 +67,7 @@ struct axp_data;
 
 struct axp20x_adc_iio {
 	struct regmap		*regmap;
-	struct axp_data		*data;
+	const struct axp_data	*data;
 };
 
 enum axp20x_adc_channel_v {
@@ -670,15 +670,15 @@ static int axp20x_probe(struct platform_device *pdev)
 	info->regmap = axp20x_dev->regmap;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	if (!pdev->dev.of_node) {
+	if (!dev_fwnode(&pdev->dev)) {
 		const struct platform_device_id *id;
 
 		id = platform_get_device_id(pdev);
-		info->data = (struct axp_data *)id->driver_data;
+		info->data = (const struct axp_data *)id->driver_data;
 	} else {
 		struct device *dev = &pdev->dev;
 
-		info->data = (struct axp_data *)of_device_get_match_data(dev);
+		info->data = device_get_match_data(dev);
 	}
 
 	indio_dev->name = platform_get_device_id(pdev)->name;
@@ -742,7 +742,7 @@ static int axp20x_remove(struct platform_device *pdev)
 static struct platform_driver axp20x_adc_driver = {
 	.driver = {
 		.name = "axp20x-adc",
-		.of_match_table = of_match_ptr(axp20x_adc_of_match),
+		.of_match_table = axp20x_adc_of_match,
 	},
 	.id_table = axp20x_adc_id_match,
 	.probe = axp20x_probe,
-- 
2.27.0

