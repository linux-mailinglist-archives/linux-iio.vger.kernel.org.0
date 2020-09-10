Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9A7264B8B
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 19:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgIJRkH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 13:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbgIJRgH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:36:07 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A872422205;
        Thu, 10 Sep 2020 17:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759338;
        bh=jX7d/q07bb0yUNhq92Q8mLQoAcpDdgi9QFVlVXqSryM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fa57UGphh1njDenxiQ9i8OLr8Te/qnSIH+p8ODry6//rfkuxJXXmxI4uPcfBXTZUl
         n9F123D3da273cjGE4UHj25iaIHA1gtqhgcHvb/gG0rFkC5wZboMi5msd3brKr9+ym
         88wXRCf7c0KMJFn30ES7o6HkXDA6gNE6GfAGpZvY=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
Subject: [PATCH 19/38] iio:pressure:ms5637: Drop of_match_ptr protection
Date:   Thu, 10 Sep 2020 18:32:23 +0100
Message-Id: <20200910173242.621168-20-jic23@kernel.org>
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
Cc: Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
---
 drivers/iio/pressure/ms5637.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c
index 05e0ef7260d5..5b59a4137d32 100644
--- a/drivers/iio/pressure/ms5637.c
+++ b/drivers/iio/pressure/ms5637.c
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/stat.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -192,7 +193,7 @@ static struct i2c_driver ms5637_driver = {
 	.id_table = ms5637_id,
 	.driver = {
 		   .name = "ms5637",
-		   .of_match_table = of_match_ptr(ms5637_of_match),
+		   .of_match_table = ms5637_of_match,
 		   },
 };
 
-- 
2.28.0

