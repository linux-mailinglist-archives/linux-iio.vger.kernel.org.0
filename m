Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C2F23FEAF
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 16:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgHIOPO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 10:15:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgHIOPO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 10:15:14 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22F9A206B5;
        Sun,  9 Aug 2020 14:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596982514;
        bh=5aNqZNdtkt0leeVUnYSiNakukKRLCaegX/hQH1Mdp/Q=;
        h=From:To:Cc:Subject:Date:From;
        b=iM8pONp7487xkFWM4xCe56YQvex3pj/54HDT7SZnkr3Q6evgAikM18GTCnvOpXxcz
         OSmbL6dHfsgZfK9PUMx/J2tvggv87uEu7jHmyk5QI0fky8y1fn2NVGWWpGiA5GIPfv
         +Uj6cBnXfkH0zhBoRUBebmoY1NCAKx5rlwrP7gxI=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3] iio:adc:axp20x: Convert from OF to generic fw / device properties
Date:   Sun,  9 Aug 2020 15:13:05 +0100
Message-Id: <20200809141305.205993-1-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
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
of fwnode, generic device_get_match_data() and dropping the of_match_ptr
protection.  Also relevant header changes to have property.h and
mod_devicetable.h only.

Also drop the casting away of a const in favour of retaining
the const throughout.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Quentin Schulz <quentin.schulz@bootlin.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
---
V3 changes: Tidy up the commit message as suggested by
Andy Schevchenko.

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
2.28.0

