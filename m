Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F20264B89
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 19:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgIJRkG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 13:40:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbgIJRgk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:36:40 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A0C322208;
        Thu, 10 Sep 2020 17:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759345;
        bh=CBO7LMghT6TP9wjynIdEjpe6+/KEIi18ws0ztpOb5xs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WWDEC8IjU6QkUdWg6sVQpCXCcZisYUsPwnlcoX5Q2l+rAr04zHn77naek5gPFMy7g
         /6Og7IoOKisyVxNynsX/3Qh4OcKIKVZbllShockVHVvUOA6Xe80RF9UNEPI4brP6qt
         v4NSHR5tUs03b1gHgGeDC1OeGfFmbu/h1JgKs/Rk=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 24/38] iio:chemical:ams-iaq-core: Drop of_match_ptr protection
Date:   Thu, 10 Sep 2020 18:32:28 +0100
Message-Id: <20200910173242.621168-25-jic23@kernel.org>
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
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/chemical/ams-iaq-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/ams-iaq-core.c b/drivers/iio/chemical/ams-iaq-core.c
index 8c1b64fd424a..97be3669c554 100644
--- a/drivers/iio/chemical/ams-iaq-core.c
+++ b/drivers/iio/chemical/ams-iaq-core.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
@@ -177,7 +178,7 @@ MODULE_DEVICE_TABLE(of, ams_iaqcore_dt_ids);
 static struct i2c_driver ams_iaqcore_driver = {
 	.driver = {
 		.name	= "ams-iaq-core",
-		.of_match_table = of_match_ptr(ams_iaqcore_dt_ids),
+		.of_match_table = ams_iaqcore_dt_ids,
 	},
 	.probe = ams_iaqcore_probe,
 	.id_table = ams_iaqcore_id,
-- 
2.28.0

