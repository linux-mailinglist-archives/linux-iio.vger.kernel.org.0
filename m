Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C19C20C803
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jun 2020 14:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgF1MjL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jun 2020 08:39:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbgF1MjL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jun 2020 08:39:11 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAFD520738;
        Sun, 28 Jun 2020 12:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593347950;
        bh=0Kep5vf3LddS9GzYz5onH9z2/GwPK0upcNcDCnoRMJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rXQ2Z2dTq3YvzTGGLB2iKTbn56v/VurY1cHGom4vW3nhTGj41TmbbOa9VBX8eadns
         9Iv8vCS8TgZ5OmOifUvmNtCml+K1A1hb1VhDtuEZvSY0KM1Wh1rA2GCna7rBPdEKpM
         tjXQVBo6j4LnOAH3E1JGpltfp4oi90p10tl0dKdk=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 08/23] iio:adc:cpcap-adc: Drop of_match_ptr protection and use device_get_match_data
Date:   Sun, 28 Jun 2020 13:36:39 +0100
Message-Id: <20200628123654.32830-9-jic23@kernel.org>
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

Part of a slow effort to avoid OF specific code in IIO.

Whilst the main advantages of this are not likely to be seen in this
particular driver (ACPI support via PRP0001) the change proposed
does make things a bit more maintainable and also ensures that
this particular (now) anti-patern is less likely to be cut and
paste into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 drivers/iio/adc/cpcap-adc.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/cpcap-adc.c b/drivers/iio/adc/cpcap-adc.c
index 004e7fee1fb2..cc26cf309638 100644
--- a/drivers/iio/adc/cpcap-adc.c
+++ b/drivers/iio/adc/cpcap-adc.c
@@ -15,9 +15,9 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_platform.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 
 #include <linux/iio/buffer.h>
@@ -955,22 +955,10 @@ MODULE_DEVICE_TABLE(of, cpcap_adc_id_table);
 
 static int cpcap_adc_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	struct cpcap_adc *ddata;
 	struct iio_dev *indio_dev;
 	int error;
 
-	match = of_match_device(of_match_ptr(cpcap_adc_id_table),
-				&pdev->dev);
-	if (!match)
-		return -EINVAL;
-
-	if (!match->data) {
-		dev_err(&pdev->dev, "no configuration data found\n");
-
-		return -ENODEV;
-	}
-
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*ddata));
 	if (!indio_dev) {
 		dev_err(&pdev->dev, "failed to allocate iio device\n");
@@ -978,7 +966,9 @@ static int cpcap_adc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 	ddata = iio_priv(indio_dev);
-	ddata->ato = match->data;
+	ddata->ato = device_get_match_data(&pdev->dev);
+	if (!ddata->ato)
+		return -ENODEV;
 	ddata->dev = &pdev->dev;
 
 	mutex_init(&ddata->lock);
@@ -1027,7 +1017,7 @@ static int cpcap_adc_probe(struct platform_device *pdev)
 static struct platform_driver cpcap_adc_driver = {
 	.driver = {
 		.name = "cpcap_adc",
-		.of_match_table = of_match_ptr(cpcap_adc_id_table),
+		.of_match_table = cpcap_adc_id_table,
 	},
 	.probe = cpcap_adc_probe,
 };
-- 
2.27.0

