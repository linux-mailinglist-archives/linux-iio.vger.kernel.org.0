Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968C7264B7B
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 19:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgIJRjN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 13:39:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgIJRhX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:37:23 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBD1E22227;
        Thu, 10 Sep 2020 17:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759361;
        bh=FqgkTVreN1ipDWL7ab+JQMxKaDz/ngXvroDhh/hGK2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bMWAMhujIIDX04tW3FBSbnlIq643tuafP+L5zA0Iwn7HOFG9KsChEFo6cs90NRt3A
         TT+0AEpvpPUwazncKUAifpDSNz2w3W2uUNqvfjjuwjOQ3LE9s1mir9oTgu+/+7OXBE
         8zizrKZcXSEfOsqbFd09usljMb7tWMXNVGTLdEoE=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
Subject: [PATCH 36/38] iio:humidity:htu21: Drop of_match_ptr protection
Date:   Thu, 10 Sep 2020 18:32:40 +0100
Message-Id: <20200910173242.621168-37-jic23@kernel.org>
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
 drivers/iio/humidity/htu21.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/htu21.c b/drivers/iio/humidity/htu21.c
index 4f5d9d1c05ab..36df2a102ca4 100644
--- a/drivers/iio/humidity/htu21.c
+++ b/drivers/iio/humidity/htu21.c
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/stat.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
@@ -247,7 +248,7 @@ static struct i2c_driver htu21_driver = {
 	.id_table = htu21_id,
 	.driver = {
 		   .name = "htu21",
-		   .of_match_table = of_match_ptr(htu21_of_match),
+		   .of_match_table = htu21_of_match,
 		   },
 };
 
-- 
2.28.0

