Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B2B20C805
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jun 2020 14:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgF1MjP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jun 2020 08:39:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbgF1MjN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jun 2020 08:39:13 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD29D2076E;
        Sun, 28 Jun 2020 12:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593347953;
        bh=HOOSFXk00b0q4slNXO37TWA5HPxLOWzPQxswS+rW7T4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bT5KhxXsKyOqRB1gWPSCde1j1kkwU69jbRHdahOnhBu26mY5FCtCl3ixx6gCqCUqt
         Q3wMR4aYaJQq2stwsJf/TGG7p71ULMBjE+9m0leoJ68dWI3tsvdy0wevuTARlEfGpn
         Dj6T+NKuKgGR0NSIyVRtwQ0476ViZzUFc2+GDEys=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH 10/23] iio:adc:max11100: Drop of_match_ptr protection / add mod_devicetable.h include
Date:   Sun, 28 Jun 2020 13:36:41 +0100
Message-Id: <20200628123654.32830-11-jic23@kernel.org>
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

Allows use of driver with ACPI PRP0001 base binding.
Mostly this is about trying to avoid cut and paste of this into new
drivers (it is a frequent review comment) rather than any
thought that this driver might get used on an ACPI platform.

The mod_devicetable.h include is to encourage best practice of including
any header directly used within the code (here for of_match_id)

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jacopo Mondi <jacopo@jmondi.org>
---
 drivers/iio/adc/max11100.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/max11100.c b/drivers/iio/adc/max11100.c
index 57734f9742f6..77fcee1dddf7 100644
--- a/drivers/iio/adc/max11100.c
+++ b/drivers/iio/adc/max11100.c
@@ -9,6 +9,7 @@
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 
@@ -161,7 +162,7 @@ MODULE_DEVICE_TABLE(of, max11100_ids);
 static struct spi_driver max11100_driver = {
 	.driver = {
 		.name	= "max11100",
-		.of_match_table = of_match_ptr(max11100_ids),
+		.of_match_table = max11100_ids,
 	},
 	.probe		= max11100_probe,
 	.remove		= max11100_remove,
-- 
2.27.0

