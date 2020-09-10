Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5082C264B67
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 19:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgIJRhX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 13:37:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbgIJRgA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:36:00 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A998221EA;
        Thu, 10 Sep 2020 17:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759326;
        bh=k5O5fxDeVOF9kbZT8cjykqnn4ZZJrkgdMlN2nKk8PV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AmHv+g7umKFjEgEUu7e+qSGENa/d9waGtYRV9aOmA7U3pBFV89kKWSXDAQ++wGgZz
         cgMcozOC+j3B4/u0NtPB9rGRLnXoE5yrrdN5ifJfH+CDCmroX3T/0cqm07szvWL3xe
         WgxDL0bBtnRoHFe0KnlmC9pPiXZIHPKO0mXIpuX8=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 10/38] iio:dac:ad5592r: Drop of_match_ptr and ACPI_PTR protections.
Date:   Thu, 10 Sep 2020 18:32:14 +0100
Message-Id: <20200910173242.621168-11-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910173242.621168-1-jic23@kernel.org>
References: <20200910173242.621168-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These result in a very small reduction in driver size, but at the
cost of more complex build and slightly harder to read code.
In the case of of_match_ptr it also prevents use of PRP0001
ACPI based identification.  In this particular case we have
a valid ACPI/PNP ID that I am assuming was issued by Analog
Devices.  That should be used in preference to PRP0001 but doesn't
mean we should prevent that route.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/dac/ad5592r.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/ad5592r.c b/drivers/iio/dac/ad5592r.c
index 49308ad13c4b..41f651500668 100644
--- a/drivers/iio/dac/ad5592r.c
+++ b/drivers/iio/dac/ad5592r.c
@@ -10,9 +10,8 @@
 
 #include <linux/bitops.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/mod_devicetable.h>
 #include <linux/spi/spi.h>
-#include <linux/acpi.h>
 
 #define AD5592R_GPIO_READBACK_EN	BIT(10)
 #define AD5592R_LDAC_READBACK_EN	BIT(6)
@@ -157,8 +156,8 @@ MODULE_DEVICE_TABLE(acpi, ad5592r_acpi_match);
 static struct spi_driver ad5592r_spi_driver = {
 	.driver = {
 		.name = "ad5592r",
-		.of_match_table = of_match_ptr(ad5592r_of_match),
-		.acpi_match_table = ACPI_PTR(ad5592r_acpi_match),
+		.of_match_table = ad5592r_of_match,
+		.acpi_match_table = ad5592r_acpi_match,
 	},
 	.probe = ad5592r_spi_probe,
 	.remove = ad5592r_spi_remove,
-- 
2.28.0

