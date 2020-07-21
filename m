Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B8022871E
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 19:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgGURQ5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jul 2020 13:16:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730259AbgGURQz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 21 Jul 2020 13:16:55 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E2E822BF5;
        Tue, 21 Jul 2020 17:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595351815;
        bh=9SdG8N05TDSRJzpOZOLSGePEP3PnZIhkj3HHyjHYrx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LAuGpz1gs8Lnof3eIE/SYkeaP6zak3Py1fTVRQQ4WGlPdxst+oHScfEE+aluZbW4S
         UK5kYpiey04ZhmkOfxojyTv3/y01/EzhUUqXfYpqnR6Uw77ZkdoD6g1Wskj61WlRKA
         dHmv5ERJllCcnkP0ATZ5qHZ1S8vhd72koWewCATI=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Subject: [PATCH v2 5/5] iio:adc:bcm_iproc: Drop of_match_ptr protection and switch to mod_devicetable.h
Date:   Tue, 21 Jul 2020 18:14:44 +0100
Message-Id: <20200721171444.825099-6-jic23@kernel.org>
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

This driver cannot be instantiated from ACPI due to it's use of
syscon_regmap_lookup_by_phandle() but in the interests of clearing
this anti pattern out of IIO, let us switch to an explicit
check in kconfig and remove the protections on the of_match_table
The switch of header is because we only use of_device_id
in here and that is defined in mod_devicetable.h not of.h.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
---
 * Use Kconfig change to make it explicit you can build the driver
   without OF, but it won't do anything terribly useful.
 drivers/iio/adc/Kconfig         | 2 +-
 drivers/iio/adc/bcm_iproc_adc.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 66d9cc073157..f495d01a79b9 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -340,7 +340,7 @@ config AXP288_ADC
 
 config BCM_IPROC_ADC
 	tristate "Broadcom IPROC ADC driver"
-	depends on ARCH_BCM_IPROC || COMPILE_TEST
+	depends on (ARCH_BCM_IPROC && OF) || COMPILE_TEST
 	depends on MFD_SYSCON
 	default ARCH_BCM_CYGNUS
 	help
diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index 936da32faa9d..44e1e53ada72 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -4,7 +4,7 @@
  */
 
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/mod_devicetable.h>
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/mfd/syscon.h>
@@ -617,7 +617,7 @@ static struct platform_driver iproc_adc_driver = {
 	.remove	= iproc_adc_remove,
 	.driver	= {
 		.name	= "iproc-static-adc",
-		.of_match_table = of_match_ptr(iproc_adc_of_match),
+		.of_match_table = iproc_adc_of_match,
 	},
 };
 module_platform_driver(iproc_adc_driver);
-- 
2.27.0

