Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9F520C808
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jun 2020 14:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgF1MjS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jun 2020 08:39:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbgF1MjS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jun 2020 08:39:18 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54AA42076E;
        Sun, 28 Jun 2020 12:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593347958;
        bh=+x/8ZKYoENY4A9z32X4I3gXxTtDbpzgabpqW4LhGGrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gLpZXCXBGIUStYWD+Gbm42s0UrnEbA7nhlvIROo5LW2RVjrRg0/9qoTtvjB0aVKne
         1vEFHIbdhitN0UUKc1vK6roikpgifM1gOvBiRtnW3uyE7/+XtgzvDdCyD3SzRIDgyk
         QkODtBQkNV9J+UrwSPd+OzzQwpXaeEBf1sF67dk8=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: [PATCH 13/23] iio:adc:mcp3422: remove CONFIG_OF and of_match_ptr protections
Date:   Sun, 28 Jun 2020 13:36:44 +0100
Message-Id: <20200628123654.32830-14-jic23@kernel.org>
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

They stop the driver being used with ACPI PRP0001 and are something
I want to avoid being cut and paste into new drivers.
Also switch the include from of.h to mod_devicetable.h as we
struct of_device_id is defined in there and we don't use anything
actually in of.h.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Angelo Compagnucci <angelo.compagnucci@gmail.com>
---
 drivers/iio/adc/mcp3422.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index 40e0d3ed05a5..ec9c79199ffb 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -16,9 +16,9 @@
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/delay.h>
 #include <linux/sysfs.h>
-#include <linux/of.h>
 #include <asm/unaligned.h>
 
 #include <linux/iio/iio.h>
@@ -402,18 +402,16 @@ static const struct i2c_device_id mcp3422_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, mcp3422_id);
 
-#ifdef CONFIG_OF
 static const struct of_device_id mcp3422_of_match[] = {
 	{ .compatible = "mcp3422" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mcp3422_of_match);
-#endif
 
 static struct i2c_driver mcp3422_driver = {
 	.driver = {
 		.name = "mcp3422",
-		.of_match_table = of_match_ptr(mcp3422_of_match),
+		.of_match_table = mcp3422_of_match,
 	},
 	.probe = mcp3422_probe,
 	.id_table = mcp3422_id,
-- 
2.27.0

