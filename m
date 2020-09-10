Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8116264B93
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 19:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgIJRkR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 13:40:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727085AbgIJRfP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:35:15 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A980421D79;
        Thu, 10 Sep 2020 17:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759314;
        bh=DjKbbIEswiwrtvBGeoLq8O77Wpmcy9kPjofN8C1Cx6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s0PkrW9wBllEu5ZgFP0wd4TYxipZ+WAUP1uHBY8qUD+jk/P+POm14ag5H7kIkXRiH
         5vUIqBB1vWyT/qb8lVcivkpvvzLqrHKq1YufgXB6IVmRyI0O1FLN/myjCmidjl1WZW
         JKiJPvES+D6NrNA0nNFskjFkNdy6RuXmEKIPnxPY=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Slawomir Stepien <sst@poczta.fm>
Subject: [PATCH 02/38] iio:potentiometer:ds1803: Drop of_match_ptr and CONFIG_OF protections
Date:   Thu, 10 Sep 2020 18:32:06 +0100
Message-Id: <20200910173242.621168-3-jic23@kernel.org>
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

Also switch of.h for mod_devicetable.h include given use of
struct of_device_id which is defined in that header.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Slawomir Stepien <sst@poczta.fm>
---
 drivers/iio/potentiometer/ds1803.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
index 5c061ab8f46c..20b45407eaac 100644
--- a/drivers/iio/potentiometer/ds1803.c
+++ b/drivers/iio/potentiometer/ds1803.c
@@ -14,7 +14,7 @@
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/mod_devicetable.h>
 
 #define DS1803_MAX_POS		255
 #define DS1803_WRITE(chan)	(0xa8 | ((chan) + 1))
@@ -134,7 +134,6 @@ static int ds1803_probe(struct i2c_client *client,
 	return devm_iio_device_register(dev, indio_dev);
 }
 
-#if defined(CONFIG_OF)
 static const struct of_device_id ds1803_dt_ids[] = {
 	{ .compatible = "maxim,ds1803-010", .data = &ds1803_cfg[DS1803_010] },
 	{ .compatible = "maxim,ds1803-050", .data = &ds1803_cfg[DS1803_050] },
@@ -142,7 +141,6 @@ static const struct of_device_id ds1803_dt_ids[] = {
 	{}
 };
 MODULE_DEVICE_TABLE(of, ds1803_dt_ids);
-#endif /* CONFIG_OF */
 
 static const struct i2c_device_id ds1803_id[] = {
 	{ "ds1803-010", DS1803_010 },
@@ -155,7 +153,7 @@ MODULE_DEVICE_TABLE(i2c, ds1803_id);
 static struct i2c_driver ds1803_driver = {
 	.driver = {
 		.name	= "ds1803",
-		.of_match_table = of_match_ptr(ds1803_dt_ids),
+		.of_match_table = ds1803_dt_ids,
 	},
 	.probe		= ds1803_probe,
 	.id_table	= ds1803_id,
-- 
2.28.0

