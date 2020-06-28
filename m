Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10EB620C80F
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jun 2020 14:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgF1Mj2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jun 2020 08:39:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgF1Mj2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jun 2020 08:39:28 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 073592076E;
        Sun, 28 Jun 2020 12:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593347968;
        bh=TBEocbTcMd4wHqWwRnZfrUom1/2JaJaBM4nQYPuE+zM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vB7XN0K9+l4hSil0Fs5GmxFDRSDJvNyr6qC5htLEe04s69KbJXJVAxRfOnEBg9mB8
         sMJdqGUN05YO+ga0SFUb9iWi+AokbYBfgKuYwgEOhv9yU3H1EeSYY+ju75UUb4Ehgt
         /3T0MBhbtAR8Um8Llt6PUGsfgXoIEtqOjuZBmf4c=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 20/23] iio:adc:ti-adc161s626: Drop of_match_ptr protection.
Date:   Sun, 28 Jun 2020 13:36:51 +0100
Message-Id: <20200628123654.32830-21-jic23@kernel.org>
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

Dropping this allows use of ACPI PRP0001.

I'm also looking to drop all of_match_ptr use in IIO in order to avoid
it getting cut and paste into new drivers in the future.

Also add a direct include of mod_devicetable.h to reflect the use
of struct of_device_id.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/adc/ti-adc161s626.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-adc161s626.c b/drivers/iio/adc/ti-adc161s626.c
index f27ca3161530..607791ffe7f0 100644
--- a/drivers/iio/adc/ti-adc161s626.c
+++ b/drivers/iio/adc/ti-adc161s626.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/spi/spi.h>
@@ -257,7 +258,7 @@ MODULE_DEVICE_TABLE(spi, ti_adc_id);
 static struct spi_driver ti_adc_driver = {
 	.driver = {
 		.name	= TI_ADC_DRV_NAME,
-		.of_match_table = of_match_ptr(ti_adc_dt_ids),
+		.of_match_table = ti_adc_dt_ids,
 	},
 	.probe		= ti_adc_probe,
 	.remove		= ti_adc_remove,
-- 
2.27.0

