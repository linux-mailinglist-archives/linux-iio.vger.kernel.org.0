Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C3E20C80D
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jun 2020 14:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgF1MjZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jun 2020 08:39:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726459AbgF1MjZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jun 2020 08:39:25 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BBFB208C7;
        Sun, 28 Jun 2020 12:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593347965;
        bh=iqOiNR5aBrgv2ybIysFrgMlk25L22Abrh9ZIVftrjWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rOsj/q35UQJZ0mA5KBrf1vgYvSq5hpQmeALTEe7QS7glr8oyhZW5xyiFCUHhqo3gu
         B3GuAjxExRhrh07sQxrzXK2HtavUPlR8LZ6DSMMVs4LdQKbdHvAbrY4mcxsJ9Pccu8
         murILrXmkVwwi0vnN8Q6n74qgAAvb+WHnNckoId4=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 18/23] iio:adc:ti-adc108s102: Drop CONFIG_OF and of_match_ptr protections
Date:   Sun, 28 Jun 2020 13:36:49 +0100
Message-Id: <20200628123654.32830-19-jic23@kernel.org>
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

Although this driver has an explicit ACPI binding it is good to also
allow for PRP0001 use of the of_match_id table.

I'm also trying to clean this (now) anti-pattern out of IIO to avoid
cut and paste into new drivers.

Also add an include of mod_devicetable.h as the driver directly uses
struct of_device_id which is defined in there.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/iio/adc/ti-adc108s102.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-adc108s102.c b/drivers/iio/adc/ti-adc108s102.c
index 9b9b27415c93..183b2245e89b 100644
--- a/drivers/iio/adc/ti-adc108s102.c
+++ b/drivers/iio/adc/ti-adc108s102.c
@@ -20,6 +20,7 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
@@ -299,13 +300,11 @@ static int adc108s102_remove(struct spi_device *spi)
 	return 0;
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id adc108s102_of_match[] = {
 	{ .compatible = "ti,adc108s102" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adc108s102_of_match);
-#endif
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id adc108s102_acpi_ids[] = {
@@ -324,7 +323,7 @@ MODULE_DEVICE_TABLE(spi, adc108s102_id);
 static struct spi_driver adc108s102_driver = {
 	.driver = {
 		.name   = "adc108s102",
-		.of_match_table = of_match_ptr(adc108s102_of_match),
+		.of_match_table = adc108s102_of_match,
 		.acpi_match_table = ACPI_PTR(adc108s102_acpi_ids),
 	},
 	.probe		= adc108s102_probe,
-- 
2.27.0

