Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD6620C7FD
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jun 2020 14:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgF1MjC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jun 2020 08:39:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbgF1MjC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jun 2020 08:39:02 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EB6C2076E;
        Sun, 28 Jun 2020 12:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593347942;
        bh=/Qf8gugZ0WrxWXmQYsy7G+9WT6NXIebrWHudXpJRVq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xt1aT7Xv9IDYGyYRWmnS+M8laDAJlFPrk3Ggohr78NABJDctyR7vdEMW4Ifzi1NEx
         qgK/zYb67jGpmpGWnujEyYOkmugoJyvbmnR9OPLjmRIl5puj4gMCtzPdh80MrYHpSR
         IROj/VVBDkDpgqfBxVKJ6/sjqzk7FmvwQ1zztFJA=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH 02/23] iio:adc:axp20x: Convert from OF to generic fw / device properties
Date:   Sun, 28 Jun 2020 13:36:33 +0100
Message-Id: <20200628123654.32830-3-jic23@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200628123654.32830-1-jic23@kernel.org>
References: <20200628123654.32830-1-jic23@kernel.org>
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

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Quentin Schulz <quentin.schulz@bootlin.com>
---
 drivers/iio/adc/axp20x_adc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index 798ff2d89691..b678f897d983 100644
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
 
@@ -670,7 +670,7 @@ static int axp20x_probe(struct platform_device *pdev)
 	info->regmap = axp20x_dev->regmap;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	if (!pdev->dev.of_node) {
+	if (!dev_fwnode(&pdev->dev)) {
 		const struct platform_device_id *id;
 
 		id = platform_get_device_id(pdev);
@@ -678,7 +678,7 @@ static int axp20x_probe(struct platform_device *pdev)
 	} else {
 		struct device *dev = &pdev->dev;
 
-		info->data = (struct axp_data *)of_device_get_match_data(dev);
+		info->data = (struct axp_data *)device_get_match_data(dev);
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

