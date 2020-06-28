Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2A320C812
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jun 2020 14:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgF1Mjc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jun 2020 08:39:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgF1Mjc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jun 2020 08:39:32 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B5962076E;
        Sun, 28 Jun 2020 12:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593347972;
        bh=gvYRsqJq0Xz0LzGUzRBd/MuchXSB4lB8S8Wj+ceYzCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FNt6yY5GaL9T0Smh5c2mvJIX8DnjSjmacK2sFrMHcablESNvLYf8L+33tRu4ViSAw
         OfgiQFldVpFReJKU2A+mGOeDX4YrdZBjLaCFIPwNg97bGCFdbq8hgHu0Ri1/V7/d1y
         V70jPMGsixvT9aJpQ/n6fTf004isu8t1dwPgKXBk=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH 23/23] iio:adc:ingenic: drop of_match_ptr protection and include mod_devicetable.h
Date:   Sun, 28 Jun 2020 13:36:54 +0100
Message-Id: <20200628123654.32830-24-jic23@kernel.org>
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

Whilst it's unlikely this device will ever be instantiated using
ACPI, there is little advantage not assigning the of_device_id table in all
cases and it avoids providing an example that might be coppied into new
drivers.

Also include mod_devicetable.h whilst here as of_device_id is defined
in there so including the header is best practice.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Artur Rojek <contact@artur-rojek.eu>
---
 drivers/iio/adc/ingenic-adc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index 3ea097c9650e..fa7ae7f6677e 100644
--- a/drivers/iio/adc/ingenic-adc.c
+++ b/drivers/iio/adc/ingenic-adc.c
@@ -13,6 +13,7 @@
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
 
@@ -497,7 +498,6 @@ static int ingenic_adc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id ingenic_adc_of_match[] = {
 	{ .compatible = "ingenic,jz4725b-adc", .data = &jz4725b_adc_soc_data, },
 	{ .compatible = "ingenic,jz4740-adc", .data = &jz4740_adc_soc_data, },
@@ -505,12 +505,11 @@ static const struct of_device_id ingenic_adc_of_match[] = {
 	{ },
 };
 MODULE_DEVICE_TABLE(of, ingenic_adc_of_match);
-#endif
 
 static struct platform_driver ingenic_adc_driver = {
 	.driver = {
 		.name = "ingenic-adc",
-		.of_match_table = of_match_ptr(ingenic_adc_of_match),
+		.of_match_table = ingenic_adc_of_match,
 	},
 	.probe = ingenic_adc_probe,
 };
-- 
2.27.0

