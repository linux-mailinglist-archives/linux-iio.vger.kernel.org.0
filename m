Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90474264B79
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 19:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgIJRjT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 13:39:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727838AbgIJRh3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:37:29 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A5EA2222A;
        Thu, 10 Sep 2020 17:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759363;
        bh=NjmG4Fc74UkPx3ip1qe+lntc+QQRDs/tlprA2yXq8bo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P7YJ+HBpaM+3ovPl5EK0JP+dZd6yMoG9JfuAvrSJs5/ZGc0FbMeZJ4/uA1bDl3a6g
         z0dQ8giUHUDDBBpgxZ0lJX7jPOm2aNs7+6rjLKzZD+o1xyqUP2mlNMCpMBes4wei4k
         06Y70WEJwaQar38yU6v58P3q+SuAL0ER8RkDrZ/8=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        David Barksdale <dbarksdale@uplogix.com>
Subject: [PATCH 37/38] iio:humidity:si7020: Drop of_match_ptr protection
Date:   Thu, 10 Sep 2020 18:32:41 +0100
Message-Id: <20200910173242.621168-38-jic23@kernel.org>
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
Cc: David Barksdale <dbarksdale@uplogix.com>
---
 drivers/iio/humidity/si7020.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
index a09b5773d377..ab6537f136ba 100644
--- a/drivers/iio/humidity/si7020.c
+++ b/drivers/iio/humidity/si7020.c
@@ -20,6 +20,7 @@
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 
@@ -153,7 +154,7 @@ MODULE_DEVICE_TABLE(of, si7020_dt_ids);
 static struct i2c_driver si7020_driver = {
 	.driver = {
 		.name = "si7020",
-		.of_match_table = of_match_ptr(si7020_dt_ids),
+		.of_match_table = si7020_dt_ids,
 	},
 	.probe		= si7020_probe,
 	.id_table	= si7020_id,
-- 
2.28.0

