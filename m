Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CA41AFB8C
	for <lists+linux-iio@lfdr.de>; Sun, 19 Apr 2020 17:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgDSPEX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Apr 2020 11:04:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:56312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgDSPEW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Apr 2020 11:04:22 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E538921D94;
        Sun, 19 Apr 2020 15:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587308662;
        bh=atwHYNRDrKcNOlDQ9cqo9CzcA6aCqQUWlDBp2r1IV3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zyl3RJlks/st9JJ10NvY53JGJ0C5wToSKoMkRQWWYmUa/UI7TA0T066hTxdEQf+K2
         0Tl3GgVgU+Ikf1x5+maKGqYkLzJYSfMfAGm6RK124UQusAbTpVwrBxlXSMq6bNKqJU
         mVe2n5nySTVwbL4sUbSAES8mU/L9NgMJuYBmav7o=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4/7] iio: light: gp2ap020a00f: Swap of.h for mod_devicetable.h + drop of_match_ptr
Date:   Sun, 19 Apr 2020 16:02:03 +0100
Message-Id: <20200419150206.43033-5-jic23@kernel.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200419150206.43033-1-jic23@kernel.org>
References: <20200419150206.43033-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Also drops ifdef protections for CONFIG_OF.

Enables probing via ACPI PRP0001 and removes an example that might be
cut and paste into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/gp2ap020a00f.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 7fbbce0d4bc7..070d4cd0cf54 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -38,8 +38,8 @@
 #include <linux/irq.h>
 #include <linux/irq_work.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
-#include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
@@ -1617,18 +1617,16 @@ static const struct i2c_device_id gp2ap020a00f_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, gp2ap020a00f_id);
 
-#ifdef CONFIG_OF
 static const struct of_device_id gp2ap020a00f_of_match[] = {
 	{ .compatible = "sharp,gp2ap020a00f" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, gp2ap020a00f_of_match);
-#endif
 
 static struct i2c_driver gp2ap020a00f_driver = {
 	.driver = {
 		.name	= GP2A_I2C_NAME,
-		.of_match_table = of_match_ptr(gp2ap020a00f_of_match),
+		.of_match_table = gp2ap020a00f_of_match,
 	},
 	.probe		= gp2ap020a00f_probe,
 	.remove		= gp2ap020a00f_remove,
-- 
2.26.1

