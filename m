Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A8F20C811
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jun 2020 14:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbgF1Mjb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jun 2020 08:39:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgF1Mja (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jun 2020 08:39:30 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE66C20738;
        Sun, 28 Jun 2020 12:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593347970;
        bh=9eNDv1CmBLwsXlChrkB+Yomsxb7eXDjKajABk03fLm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bsMKwraAPfnmIkkpc8QiDjHw0wSNeQ0jso3jLEXynBn22PLebnUKCgSMhrxOGpTVg
         HO/E9ZfjKWKY3QKxod5bzkcAFXwvKm7jfdinQ7RdN/EC/e667oZ1t4ziI6UCugQFqE
         33SAXZ4DQ3ku+gBPYeOD9c8zkdIjWqi/TOhgRNqM=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Subject: [PATCH 22/23] iio:adc:bcm_iproc: Drop of_match_ptr protection and switch to mod_devicetable.h
Date:   Sun, 28 Jun 2020 13:36:53 +0100
Message-Id: <20200628123654.32830-23-jic23@kernel.org>
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

Whilst it's unlikely that this driver will ever be instantiated from
ACPI PRP0001 there is little advantage in using the of_match_ptr
protection.  The switch of header is because we only use of_match_id
in here and that is defined in mod_devicetable.h not of.h.

Note the main reason for this patch is to avoid providing instances
of of_match_ptr being used in IIO that might get copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
---
 drivers/iio/adc/bcm_iproc_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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

