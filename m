Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8AF220C80A
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jun 2020 14:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgF1MjV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jun 2020 08:39:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbgF1MjV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jun 2020 08:39:21 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 376ED20885;
        Sun, 28 Jun 2020 12:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593347961;
        bh=tRtoUybSIIMd0kLcDWQzRSez9/8h6H7KMA45oHMvKyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wD+u2v5Xu6G5/ZSlviCyChNN+cDwSNHMF0hO/XOiCSsfnkyjKJAqJCO5XEL7KOCcT
         iYe1fARMk3EfNcQNTViSvlhACNEaEIUaQ3uxAdkvGB8kG30Ag49ptgazEffN7pds7s
         GPSpgNrvsdDYZTL+qA2FiiMYjIKfpTvJu5dMXhcM=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 15/23] iio:adc:ti-adc081c: Drop of_match_ptr and change to mod_devicetable.h
Date:   Sun, 28 Jun 2020 13:36:46 +0100
Message-Id: <20200628123654.32830-16-jic23@kernel.org>
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

Whilst this driver already supports explicit ACPI bindings we
might as well also allow for PRP0001 based binding.

I'm also keen to remove of_match_ptr from IIO drivers to avoid
this (now) anti-pattern getting coppied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti-adc081c.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
index 82e524b3db88..e00350e6503f 100644
--- a/drivers/iio/adc/ti-adc081c.c
+++ b/drivers/iio/adc/ti-adc081c.c
@@ -18,7 +18,7 @@
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/mod_devicetable.h>
 #include <linux/acpi.h>
 
 #include <linux/iio/iio.h>
@@ -230,7 +230,6 @@ static const struct i2c_device_id adc081c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, adc081c_id);
 
-#ifdef CONFIG_OF
 static const struct of_device_id adc081c_of_match[] = {
 	{ .compatible = "ti,adc081c" },
 	{ .compatible = "ti,adc101c" },
@@ -238,7 +237,6 @@ static const struct of_device_id adc081c_of_match[] = {
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adc081c_of_match);
-#endif
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id adc081c_acpi_match[] = {
@@ -253,7 +251,7 @@ MODULE_DEVICE_TABLE(acpi, adc081c_acpi_match);
 static struct i2c_driver adc081c_driver = {
 	.driver = {
 		.name = "adc081c",
-		.of_match_table = of_match_ptr(adc081c_of_match),
+		.of_match_table = adc081c_of_match,
 		.acpi_match_table = ACPI_PTR(adc081c_acpi_match),
 	},
 	.probe = adc081c_probe,
-- 
2.27.0

