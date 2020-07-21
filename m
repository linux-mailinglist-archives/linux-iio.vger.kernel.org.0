Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E7622871D
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 19:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbgGURQ4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jul 2020 13:16:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730697AbgGURQy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 21 Jul 2020 13:16:54 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AFCE21702;
        Tue, 21 Jul 2020 17:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595351814;
        bh=D6k9CHHnvGteEJEefsTRPxBTC9ESQLU5MQrcbn7z8NE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0IyLTwxhVf4U8lrFrsVo/74Wv1rxx7qiB6dvcogrOZ9PRzLu2a8rA04jUrgnTjqy6
         1Jxx88PiRQ5daqnB+wQKIIH0jfBRfAh/IXlO/AM9QDuUPQzeMohjX38fyv7maaY5uf
         FaX0faa4fTKnrAmaWHnZalcC/Om3a7czEWwJ1o+k=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: [PATCH v2 4/5] iio:adc:ti-adc128s052: drop of_match_ptr protection
Date:   Tue, 21 Jul 2020 18:14:43 +0100
Message-Id: <20200721171444.825099-5-jic23@kernel.org>
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

There is no real advantage in having these protections and
for parts that do not have an explicit ACPI ID, it prevents the
use of PRP0001. I'm trying to clear this out of IIO in general
to avoid copying in new drivers.

Include mod_devicetable.h as we are using of_device_id in here so
including that header is best practice.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Angelo Compagnucci <angelo.compagnucci@gmail.com>
---
 v1->v2
 * Mention that some parts of valid IDs, so we are interesting in
   enabling PRP0001 option for those that don't.
   
 drivers/iio/adc/ti-adc128s052.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index e86f55ce093f..3143f35a6509 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -13,6 +13,7 @@
 #include <linux/err.h>
 #include <linux/spi/spi.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/iio/iio.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
@@ -220,7 +221,7 @@ MODULE_DEVICE_TABLE(acpi, adc128_acpi_match);
 static struct spi_driver adc128_driver = {
 	.driver = {
 		.name = "adc128s052",
-		.of_match_table = of_match_ptr(adc128_of_match),
+		.of_match_table = adc128_of_match,
 		.acpi_match_table = ACPI_PTR(adc128_acpi_match),
 	},
 	.probe = adc128_probe,
-- 
2.27.0

