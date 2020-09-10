Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F7E264B66
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 19:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgIJRhP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 13:37:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgIJRgA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:36:00 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEA82221ED;
        Thu, 10 Sep 2020 17:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759327;
        bh=CRftnf93UBEo/s7JDiAnvNGiFqR8SiJ2dP8aIvcvte8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EIzIwNbsy1gsD4uUOuGlOdK2PJYAFZ9TviwKTqqatQBGy8Pk5rkUT7wjqSwlqifLe
         +Ot7twcchwx517OM8hKdsNtqqtk1ov8FdYwBqcFBSPUiRvyh8kVcGRaWFmf77bD55W
         bU07m5Dvd9SHU/6wq0efVpS/lda7LKZsNjD2qVlw=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 11/38] iio:dac:ad5593r: Drop of_match_ptr and ACPI_PTR protections.
Date:   Thu, 10 Sep 2020 18:32:15 +0100
Message-Id: <20200910173242.621168-12-jic23@kernel.org>
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
 drivers/iio/dac/ad5593r.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/ad5593r.c b/drivers/iio/dac/ad5593r.c
index 1fbe9c019c7f..5b4df36fdc2a 100644
--- a/drivers/iio/dac/ad5593r.c
+++ b/drivers/iio/dac/ad5593r.c
@@ -11,8 +11,7 @@
 #include <linux/bitops.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/acpi.h>
+#include <linux/mod_devicetable.h>
 
 #define AD5593R_MODE_CONF		(0 << 4)
 #define AD5593R_MODE_DAC_WRITE		(1 << 4)
@@ -124,8 +123,8 @@ MODULE_DEVICE_TABLE(acpi, ad5593r_acpi_match);
 static struct i2c_driver ad5593r_driver = {
 	.driver = {
 		.name = "ad5593r",
-		.of_match_table = of_match_ptr(ad5593r_of_match),
-		.acpi_match_table = ACPI_PTR(ad5593r_acpi_match),
+		.of_match_table = ad5593r_of_match,
+		.acpi_match_table = ad5593r_acpi_match,
 	},
 	.probe = ad5593r_i2c_probe,
 	.remove = ad5593r_i2c_remove,
-- 
2.28.0

