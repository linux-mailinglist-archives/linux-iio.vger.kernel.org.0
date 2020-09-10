Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F31264B87
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 19:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgIJRkG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 13:40:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726942AbgIJRgk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:36:40 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CED6022209;
        Thu, 10 Sep 2020 17:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759342;
        bh=OSqA9MJUD+SMez8Uad9aTYpl2IE6ypJvSF7gtwYvU9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0poER1Wg6fTRRaYO2hcjauB1oYcgLlxmwYi9r2VEDHqda3CG9yqeiJPynF0RVFG9y
         NYjkpzXoBpqggKutkRAtpUGmx+cwUBsMqhx10BiSh8jwxIOu6gGgydT5u+3JDek8ba
         R+rhZOXFL8jlYT3zb4Fag0UsJRpli5FhEmliAW6E=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Manivannan Sadhasivam <manivannanece23@gmail.com>
Subject: [PATCH 22/38] iio:temperature:tmp007: Drop of_match_ptr protection
Date:   Thu, 10 Sep 2020 18:32:26 +0100
Message-Id: <20200910173242.621168-23-jic23@kernel.org>
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

This prevents use of this driver with ACPI via PRP0001 and is
an example of an anti pattern I'm trying to remove from IIO.
Hence drop from this driver.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Manivannan Sadhasivam <manivannanece23@gmail.com>
---
 drivers/iio/temperature/tmp007.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/tmp007.c b/drivers/iio/temperature/tmp007.c
index f90fe9e5617b..ad2b35c65548 100644
--- a/drivers/iio/temperature/tmp007.c
+++ b/drivers/iio/temperature/tmp007.c
@@ -20,7 +20,7 @@
 #include <linux/module.h>
 #include <linux/pm.h>
 #include <linux/bitops.h>
-#include <linux/of.h>
+#include <linux/mod_devicetable.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 
@@ -578,7 +578,7 @@ MODULE_DEVICE_TABLE(i2c, tmp007_id);
 static struct i2c_driver tmp007_driver = {
 	.driver = {
 		.name	= "tmp007",
-		.of_match_table = of_match_ptr(tmp007_of_match),
+		.of_match_table = tmp007_of_match,
 		.pm	= &tmp007_pm_ops,
 	},
 	.probe		= tmp007_probe,
-- 
2.28.0

