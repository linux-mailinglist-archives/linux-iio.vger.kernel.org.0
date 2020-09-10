Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A48F264B96
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 19:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgIJRkU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 13:40:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbgIJRfO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:35:14 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D888214F1;
        Thu, 10 Sep 2020 17:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759313;
        bh=SECXsoDEgSc+XnHOLSKBHuHxcn/IbMqNxylG4VrCopc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uv7rV9Sha8k3/Qp+QqYqPQ+QOPBmm0eXfVxnvvtSV3DjrXGOunw2BcmEg4rDTGYYt
         EZ8PsopoC1+RWLLJFgcpEqwreayWin6L/GanS1omOwjsenHSokVi3WRJYt57yexuwi
         K0qPhBYsidHlta/lTPTa9PvchGQ1zBQXhWQFKEhU=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Phil Reid <preid@eletromag.com.au>
Subject: [PATCH 01/38] iio:potentiometer:ad5272: Drop of_match_ptr and CONFIG_OF protections.
Date:   Thu, 10 Sep 2020 18:32:05 +0100
Message-Id: <20200910173242.621168-2-jic23@kernel.org>
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

These prevent use of this driver with ACPI via PRP0001 and are
an example of an anti pattern I'm trying to remove from IIO.
Drop them to remove this restriction.

Also added mod_devicetable.h include given use of struct of_device_id
which is defined in that header.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Phil Reid <preid@eletromag.com.au>
---
 drivers/iio/potentiometer/ad5272.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/potentiometer/ad5272.c b/drivers/iio/potentiometer/ad5272.c
index 933afcf7e925..70c45d346df0 100644
--- a/drivers/iio/potentiometer/ad5272.c
+++ b/drivers/iio/potentiometer/ad5272.c
@@ -15,6 +15,7 @@
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 
 #define  AD5272_RDAC_WR  1
 #define  AD5272_RDAC_RD  2
@@ -192,7 +193,6 @@ static int ad5272_probe(struct i2c_client *client,
 	return devm_iio_device_register(dev, indio_dev);
 }
 
-#if defined(CONFIG_OF)
 static const struct of_device_id ad5272_dt_ids[] = {
 	{ .compatible = "adi,ad5272-020", .data = (void *)AD5272_020 },
 	{ .compatible = "adi,ad5272-050", .data = (void *)AD5272_050 },
@@ -202,7 +202,6 @@ static const struct of_device_id ad5272_dt_ids[] = {
 	{}
 };
 MODULE_DEVICE_TABLE(of, ad5272_dt_ids);
-#endif /* CONFIG_OF */
 
 static const struct i2c_device_id ad5272_id[] = {
 	{ "ad5272-020", AD5272_020 },
@@ -217,7 +216,7 @@ MODULE_DEVICE_TABLE(i2c, ad5272_id);
 static struct i2c_driver ad5272_driver = {
 	.driver = {
 		.name	= "ad5272",
-		.of_match_table = of_match_ptr(ad5272_dt_ids),
+		.of_match_table = ad5272_dt_ids,
 	},
 	.probe		= ad5272_probe,
 	.id_table	= ad5272_id,
-- 
2.28.0

