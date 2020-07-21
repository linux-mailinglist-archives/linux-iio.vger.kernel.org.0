Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A220422871B
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 19:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730334AbgGURQz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jul 2020 13:16:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:55522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730344AbgGURQx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 21 Jul 2020 13:16:53 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F17AC22482;
        Tue, 21 Jul 2020 17:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595351812;
        bh=yvn1cuTRX53siM51hQw6t4ITmNMCRxa+9xE0PsEy5fE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fkcVSO2IZMApdK3PpDE/CJHsp5JVW31UE6zRs11qnIrrdWdViKc/09JS4I+pVVv7I
         Wk7vNXKXOs5veIeX25n1QpyMWF/eztaRCrJJFJP3wUj7AK13e5wSt6WrlWBrEwRVqP
         pGgXo2S48hwbc9KS8Kz4SPW7zCQGfWR+yey9CsWE=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 3/5] iio:adc:ti-adc108s102: Drop CONFIG_OF and of_match_ptr protections
Date:   Tue, 21 Jul 2020 18:14:42 +0100
Message-Id: <20200721171444.825099-4-jic23@kernel.org>
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

I'm trying to clean this (now) anti-pattern out of IIO to avoid
cut and paste into new drivers.

Also add an include of mod_devicetable.h as the driver directly uses
struct of_device_id which is defined in there.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
---

v1->v2
* Drop reference to PRP0001 etc in this one as it has valid ACPI
  IDs.

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

