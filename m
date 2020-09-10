Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0069A264B68
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 19:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgIJRhY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 13:37:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727113AbgIJRgA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:36:00 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75027221E7;
        Thu, 10 Sep 2020 17:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759323;
        bh=bsUsUZ5Fif7XK+Uhi90Bir1D/WKFHq+PYWLaPVSxvhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PuoJ6FjbRmafkcS8FYfDLWniwcHKiWrMFgOrHx77GVZ6HQhovHPIabzwYCYCwSsg8
         lx2ucFTve4YZ3T7zZza5KlPW9WEj3qtOjgoM84o7RFBSbYtfkNX6BMj2jLOw/IJp6g
         qjI0Fzk+2ZfPecTaHHgY0uXsl9oRBuCUZ89ODW9s=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH 08/38] iio:potentiometer:mcp4531: Drop of_match_ptr and CONFIG_OF protections.
Date:   Thu, 10 Sep 2020 18:32:12 +0100
Message-Id: <20200910173242.621168-9-jic23@kernel.org>
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
Hence drop them from this driver.

Also switch to device_get_match_data() from of_ variant and adjust
headers to reflect the change.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Peter Rosin <peda@axentia.se>
---
 drivers/iio/potentiometer/mcp4531.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/potentiometer/mcp4531.c b/drivers/iio/potentiometer/mcp4531.c
index 95efc4b40514..c25f84b4a270 100644
--- a/drivers/iio/potentiometer/mcp4531.c
+++ b/drivers/iio/potentiometer/mcp4531.c
@@ -28,8 +28,8 @@
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/err.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
 
 #include <linux/iio/iio.h>
 
@@ -275,8 +275,6 @@ static const struct i2c_device_id mcp4531_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, mcp4531_id);
 
-#ifdef CONFIG_OF
-
 #define MCP4531_COMPATIBLE(of_compatible, cfg) {	\
 			.compatible = of_compatible,	\
 			.data = &mcp4531_cfg[cfg],	\
@@ -350,7 +348,6 @@ static const struct of_device_id mcp4531_of_match[] = {
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mcp4531_of_match);
-#endif
 
 static int mcp4531_probe(struct i2c_client *client)
 {
@@ -371,7 +368,7 @@ static int mcp4531_probe(struct i2c_client *client)
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
 
-	data->cfg = of_device_get_match_data(dev);
+	data->cfg = device_get_match_data(dev);
 	if (!data->cfg)
 		data->cfg = &mcp4531_cfg[i2c_match_id(mcp4531_id, client)->driver_data];
 
@@ -386,7 +383,7 @@ static int mcp4531_probe(struct i2c_client *client)
 static struct i2c_driver mcp4531_driver = {
 	.driver = {
 		.name	= "mcp4531",
-		.of_match_table = of_match_ptr(mcp4531_of_match),
+		.of_match_table = mcp4531_of_match,
 	},
 	.probe_new	= mcp4531_probe,
 	.id_table	= mcp4531_id,
-- 
2.28.0

