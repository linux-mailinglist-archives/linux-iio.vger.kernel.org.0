Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8F8264B5F
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 19:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgIJRgX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 13:36:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbgIJRfs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:35:48 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C21F8221E3;
        Thu, 10 Sep 2020 17:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759320;
        bh=y4RBhMExWqZsbDmxczqshbG9Lc9AJxW8KSELyxL6VRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OHKWdpXcOjJyEatjyckdI8lDGFNPo19n4c/Y53y89YZJuQLi6N9f7FrygX32GD9oM
         JtGguuq4Vn18IarrDK3vc6u/BXzNbVs6YOPIhzXILbnuCI2TKcnRnd4RJ08UZ+W+TK
         o+7XkJR98wUCmTdmd2k0WU1TFevHJ3IzSrwJ4HGk=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH 06/38] iio:potentiometer:mcp4018: Drop of_match_ptr and CONFIG_OF protections.
Date:   Thu, 10 Sep 2020 18:32:10 +0100
Message-Id: <20200910173242.621168-7-jic23@kernel.org>
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
Also use device_get_match_data() rather than devicetree only version.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Peter Rosin <peda@axentia.se>
---
 drivers/iio/potentiometer/mcp4018.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/potentiometer/mcp4018.c b/drivers/iio/potentiometer/mcp4018.c
index fd0579ad3c83..c0e171fec062 100644
--- a/drivers/iio/potentiometer/mcp4018.c
+++ b/drivers/iio/potentiometer/mcp4018.c
@@ -16,8 +16,8 @@
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
 
 #define MCP4018_WIPER_MAX 127
 
@@ -116,8 +116,6 @@ static const struct i2c_device_id mcp4018_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, mcp4018_id);
 
-#ifdef CONFIG_OF
-
 #define MCP4018_COMPATIBLE(of_compatible, cfg) {	\
 	.compatible = of_compatible,			\
 	.data = &mcp4018_cfg[cfg],			\
@@ -140,8 +138,6 @@ static const struct of_device_id mcp4018_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mcp4018_of_match);
 
-#endif
-
 static int mcp4018_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -161,7 +157,7 @@ static int mcp4018_probe(struct i2c_client *client)
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
 
-	data->cfg = of_device_get_match_data(dev);
+	data->cfg = device_get_match_data(dev);
 	if (!data->cfg)
 		data->cfg = &mcp4018_cfg[i2c_match_id(mcp4018_id, client)->driver_data];
 
@@ -176,7 +172,7 @@ static int mcp4018_probe(struct i2c_client *client)
 static struct i2c_driver mcp4018_driver = {
 	.driver = {
 		.name	= "mcp4018",
-		.of_match_table = of_match_ptr(mcp4018_of_match),
+		.of_match_table = mcp4018_of_match,
 	},
 	.probe_new	= mcp4018_probe,
 	.id_table	= mcp4018_id,
-- 
2.28.0

