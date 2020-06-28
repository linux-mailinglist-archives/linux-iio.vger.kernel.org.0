Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC4C20C806
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jun 2020 14:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgF1MjP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jun 2020 08:39:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbgF1MjP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jun 2020 08:39:15 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BAE920738;
        Sun, 28 Jun 2020 12:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593347955;
        bh=23Rs0c4y4scQtvDfQVwU0AjBUAD6Tw+9G2uyv8LsWz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xuIhlK3Y7vDzy1Ya9kRhSr0nq0m5kWCi9pKeCyJtMdWcMY1qQ6zgeCXZ+yKJq3gnj
         MQwrYQdXIjzAKAKdlNarqsUMOmQdqnz3RqUk/q2cdU4vYQrKxzfZ9Slxn+we6pZdjp
         SuMmim3r/TI2jNSZL4vCdUtm8SRMxxGbU6qGS/7c=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 11/23] iio:adc:max1118: Drop CONFIG_OF / of_match_ptr protections
Date:   Sun, 28 Jun 2020 13:36:42 +0100
Message-Id: <20200628123654.32830-12-jic23@kernel.org>
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

These just stop the driver being used with ACPI PRP0001 and
we are trying to clear them out of IIO to avoid them getting copied
into new drivers.
Also add the mod_devicetable.h include as we are using
struct of_device_id which is defined in there.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/iio/adc/max1118.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/max1118.c b/drivers/iio/adc/max1118.c
index 273fbea2a515..01b20e420ac4 100644
--- a/drivers/iio/adc/max1118.c
+++ b/drivers/iio/adc/max1118.c
@@ -18,6 +18,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/spi/spi.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
@@ -280,8 +281,6 @@ static const struct spi_device_id max1118_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, max1118_id);
 
-#ifdef CONFIG_OF
-
 static const struct of_device_id max1118_dt_ids[] = {
 	{ .compatible = "maxim,max1117" },
 	{ .compatible = "maxim,max1118" },
@@ -290,12 +289,10 @@ static const struct of_device_id max1118_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, max1118_dt_ids);
 
-#endif
-
 static struct spi_driver max1118_spi_driver = {
 	.driver = {
 		.name = "max1118",
-		.of_match_table = of_match_ptr(max1118_dt_ids),
+		.of_match_table = max1118_dt_ids,
 	},
 	.probe = max1118_probe,
 	.remove = max1118_remove,
-- 
2.27.0

