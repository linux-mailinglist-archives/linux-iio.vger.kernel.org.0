Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE70264B7E
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 19:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgIJRjq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 13:39:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbgIJRhN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:37:13 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E283822228;
        Thu, 10 Sep 2020 17:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759358;
        bh=blQOhietSGkdIajSqFJS++7Xp/W+W41PAK7v1JvlG3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yy7i8C4iYkSWwEK4wkxnFnRR5CCeof7b0xHNTa1WFD2a2XFcgJpYQmoEitRWs/Yak
         1hZ4UbkuqpO2EzMRpadOhB7N1cfRWZnLaPbCu4Ujbv8XEr2fhhm+GRLIig+eJ4riUo
         bbqOZVdsXeOyRXVtWedUIuoK61mfwSrlV72v3mUY=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>
Subject: [PATCH 34/38] iio:magn:ak8975: Drop of_match_ptr and ACPI_PTR protections.
Date:   Thu, 10 Sep 2020 18:32:38 +0100
Message-Id: <20200910173242.621168-35-jic23@kernel.org>
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

Both would result in only a small size saving.  For simplicity it
is best to remove them.  I also wish to remove both these antipatterns
from IIO.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Albrieux <jonathan.albrieux@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 03d71f796177..0141ef3b6476 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
@@ -17,7 +18,6 @@
 #include <linux/delay.h>
 #include <linux/bitops.h>
 #include <linux/gpio/consumer.h>
-#include <linux/acpi.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
 
@@ -773,7 +773,6 @@ static const struct iio_info ak8975_info = {
 	.read_raw = &ak8975_read_raw,
 };
 
-#ifdef CONFIG_ACPI
 static const struct acpi_device_id ak_acpi_match[] = {
 	{"AK8975", AK8975},
 	{"AK8963", AK8963},
@@ -785,7 +784,6 @@ static const struct acpi_device_id ak_acpi_match[] = {
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, ak_acpi_match);
-#endif
 
 static void ak8975_fill_buffer(struct iio_dev *indio_dev)
 {
@@ -1075,8 +1073,8 @@ static struct i2c_driver ak8975_driver = {
 	.driver = {
 		.name	= "ak8975",
 		.pm = &ak8975_dev_pm_ops,
-		.of_match_table = of_match_ptr(ak8975_of_match),
-		.acpi_match_table = ACPI_PTR(ak_acpi_match),
+		.of_match_table = ak8975_of_match,
+		.acpi_match_table = ak_acpi_match,
 	},
 	.probe		= ak8975_probe,
 	.remove		= ak8975_remove,
-- 
2.28.0

