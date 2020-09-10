Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92353264B8C
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 19:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgIJRkI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 13:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727790AbgIJRgA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:36:00 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AB3421582;
        Thu, 10 Sep 2020 17:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759333;
        bh=MGOhaJX7nCv7f7rWeUzTDUuEIm2qrKbUJkOWY6iJ97I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ocz2jleVGVJpvf3hk6TO/pXDyMG2swUlGhB6a6a5lUQdVc6lf0k00Gc2nqaN/SB7E
         kIySdFJF6S3dkmwgfG/T2wHymOLwdSq0/Rf7G/EsgKqrjK4X+9AaDpuyc79isvSNn8
         F699ivosAW+XbN+JMpJaX1ZkOzhQxiUB8rAvxpIg=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Subject: [PATCH 15/38] iio:dac:ti-dac5571: Drop of_match_ptr and CONFIG_OF protections
Date:   Thu, 10 Sep 2020 18:32:19 +0100
Message-Id: <20200910173242.621168-16-jic23@kernel.org>
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

These prevent the use of this driver with ACPI via PRP0001 and are
an example of an anti pattern I'm trying to remove from IIO.
Hence drop them from this driver.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
---
 drivers/iio/dac/ti-dac5571.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
index d303b19814e7..d3295767a079 100644
--- a/drivers/iio/dac/ti-dac5571.c
+++ b/drivers/iio/dac/ti-dac5571.c
@@ -18,8 +18,7 @@
 #include <linux/iio/iio.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
-#include <linux/of.h>
+#include <linux/mod_devicetable.h>
 #include <linux/regulator/consumer.h>
 
 enum chip_id {
@@ -384,7 +383,6 @@ static int dac5571_remove(struct i2c_client *i2c)
 	return 0;
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id dac5571_of_id[] = {
 	{.compatible = "ti,dac5571"},
 	{.compatible = "ti,dac6571"},
@@ -398,7 +396,6 @@ static const struct of_device_id dac5571_of_id[] = {
 	{}
 };
 MODULE_DEVICE_TABLE(of, dac5571_of_id);
-#endif
 
 static const struct i2c_device_id dac5571_id[] = {
 	{"dac5571", single_8bit},
@@ -417,7 +414,7 @@ MODULE_DEVICE_TABLE(i2c, dac5571_id);
 static struct i2c_driver dac5571_driver = {
 	.driver = {
 		   .name = "ti-dac5571",
-		   .of_match_table = of_match_ptr(dac5571_of_id),
+		   .of_match_table = dac5571_of_id,
 	},
 	.probe	  = dac5571_probe,
 	.remove   = dac5571_remove,
-- 
2.28.0

