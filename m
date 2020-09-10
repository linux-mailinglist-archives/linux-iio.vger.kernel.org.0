Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36996264B8F
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 19:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgIJRkL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 13:40:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbgIJRfs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:35:48 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 238DE221E2;
        Thu, 10 Sep 2020 17:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759322;
        bh=M/iE5ajFvegSF/+ggOtfuNwaDIQiCxRk1KTcjv3rSTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wiQpEgKttba7jmiNHLm2XFAQBEyDg8p3rqcVUaxEZ2fvZTgcyiAPdNB9dY3QeI5TJ
         2wqZXVqsynV6sQp2juGzX5nJ3u14EgjHPgW8fek45Rr7bTDTnh9uoPwmahgpuxEBMY
         yDOzAUoPfuNatfz18eXQWE9+OMd0jRub2idg+uf0=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Slawomir Stepien <sst@poczta.fm>
Subject: [PATCH 07/38] iio:potentiometer:mcp4131: Drop of_match_ptr and use generic fw interfaces.
Date:   Thu, 10 Sep 2020 18:32:11 +0100
Message-Id: <20200910173242.621168-8-jic23@kernel.org>
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

This change allows the use of the driver with ACPI via PRP0001
and remove an example of an anti pattern I'm trying to remove from IIO.
Also adjust includes to reflect this change.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Slawomir Stepien <sst@poczta.fm>
---
 drivers/iio/potentiometer/mcp4131.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/potentiometer/mcp4131.c b/drivers/iio/potentiometer/mcp4131.c
index 2923ce250fc3..7c8c18ab8764 100644
--- a/drivers/iio/potentiometer/mcp4131.c
+++ b/drivers/iio/potentiometer/mcp4131.c
@@ -37,9 +37,9 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/types.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/property.h>
 #include <linux/spi/spi.h>
 
 #define MCP4131_WRITE		(0x00 << 2)
@@ -252,7 +252,7 @@ static int mcp4131_probe(struct spi_device *spi)
 	data = iio_priv(indio_dev);
 	spi_set_drvdata(spi, indio_dev);
 	data->spi = spi;
-	data->cfg = of_device_get_match_data(&spi->dev);
+	data->cfg = device_get_match_data(&spi->dev);
 	if (!data->cfg) {
 		devid = spi_get_device_id(spi)->driver_data;
 		data->cfg = &mcp4131_cfg[devid];
@@ -479,7 +479,7 @@ MODULE_DEVICE_TABLE(spi, mcp4131_id);
 static struct spi_driver mcp4131_driver = {
 	.driver = {
 		.name	= "mcp4131",
-		.of_match_table = of_match_ptr(mcp4131_dt_ids),
+		.of_match_table = mcp4131_dt_ids,
 	},
 	.probe		= mcp4131_probe,
 	.id_table	= mcp4131_id,
-- 
2.28.0

