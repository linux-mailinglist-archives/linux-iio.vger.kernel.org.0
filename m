Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC97264B8A
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 19:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgIJRkI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 13:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbgIJRgA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:36:00 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB9ED221F1;
        Thu, 10 Sep 2020 17:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759335;
        bh=3ZzsgVXWiUsw2MOOAw6VdAfqjtG1nFMCujkrjuTF6ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DKbCq4ckt9feyCL3VZXgWXZIxxUaw68ncz2MQwnxl1C0dm0Hry5uPzF9N4Sv7qYj5
         cRKiKBCcRUrF5bFR9Uzq9sVAFQ6+umpGmBQKJtuLoWtQUgG0DtzBljybXOQj7YMMBT
         14jo8sIeEIHrAehfn2WxF9iwoRSDKkQzhKodGvbc=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 17/38] iio:pressure:icp10100: Drop of_match_ptr and CONFIG_OF protections
Date:   Thu, 10 Sep 2020 18:32:21 +0100
Message-Id: <20200910173242.621168-18-jic23@kernel.org>
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

These prevents use of this driver with ACPI via PRP0001 and are
an example of an anti pattern I'm trying to remove from IIO.
Hence drop them from this driver.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/pressure/icp10100.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/icp10100.c b/drivers/iio/pressure/icp10100.c
index 90c0df068bbb..48759fc4bf18 100644
--- a/drivers/iio/pressure/icp10100.c
+++ b/drivers/iio/pressure/icp10100.c
@@ -10,6 +10,7 @@
 
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/i2c.h>
 #include <linux/pm_runtime.h>
 #include <linux/crc8.h>
@@ -645,7 +646,7 @@ static struct i2c_driver icp10100_driver = {
 	.driver = {
 		.name = "icp10100",
 		.pm = &icp10100_pm,
-		.of_match_table = of_match_ptr(icp10100_of_match),
+		.of_match_table = icp10100_of_match,
 	},
 	.probe = icp10100_probe,
 	.id_table = icp10100_id,
-- 
2.28.0

