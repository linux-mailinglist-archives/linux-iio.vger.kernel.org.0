Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81259460955
	for <lists+linux-iio@lfdr.de>; Sun, 28 Nov 2021 20:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239721AbhK1T1R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Nov 2021 14:27:17 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58458 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357661AbhK1TZQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Nov 2021 14:25:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9470B80D5E
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 19:21:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD37EC53FC7;
        Sun, 28 Nov 2021 19:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638127318;
        bh=YumZW9e9eO1+G4uWv8xobHj7a1kla7gjc+AG/KZsLr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tAlnrE1bFiZF2l4Mc8LyBdHmZPZbnYoEJC1+80V/dg3lQYg4pq/0eObWZoUaySr1E
         4z04xyPMLqSHEF9pER4yeGIUYALtVFFsw2DYDE40gbtNTcgoltDd1Ztj3GlaF7Onm8
         U9uT12qw6WD9/RlqoU4FwT32FhsKOY5B+oV1wFrUKJHEsOGNeH1u0dzyn9II2P3/Y0
         7g84MrWyBLSfSPaVw6nCTiJw4/mTrormyFrtOLp8A/P2d3LrTay4ynP1AyW5DF3pBT
         jx7/sHul9QUXus8sqoIRHirWU+fvN9WLWxU6O4vxILvDdvJpyl9tWVUIUHt9MLGTU8
         ndOwEu99DX8jA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kent Gustavsson <kent@minoris.se>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH 08/12] iio:adc:mcp3911: Switch to generic firmware properties.
Date:   Sun, 28 Nov 2021 19:26:31 +0000
Message-Id: <20211128192635.2724359-9-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211128192635.2724359-1-jic23@kernel.org>
References: <20211128192635.2724359-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This allows use of the driver with other types of firmware such as ACPI
PRP0001 based probing.

Also part of a general attempt to remove direct use of of_ specific
accessors from IIO.

Added an include for mod_devicetable.h whilst here to cover the
struct of_device_id definition.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Kent Gustavsson <kent@minoris.se>
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index e573da5397bb..f6895acb8838 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -10,6 +10,8 @@
 #include <linux/err.h>
 #include <linux/iio/iio.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 
@@ -200,12 +202,12 @@ static const struct iio_info mcp3911_info = {
 	.write_raw = mcp3911_write_raw,
 };
 
-static int mcp3911_config(struct mcp3911 *adc, struct device_node *of_node)
+static int mcp3911_config(struct mcp3911 *adc, struct device *dev)
 {
 	u32 configreg;
 	int ret;
 
-	of_property_read_u32(of_node, "device-addr", &adc->dev_addr);
+	device_property_read_u32(dev, "device-addr", &adc->dev_addr);
 	if (adc->dev_addr > 3) {
 		dev_err(&adc->spi->dev,
 			"invalid device address (%i). Must be in range 0-3.\n",
@@ -289,7 +291,7 @@ static int mcp3911_probe(struct spi_device *spi)
 		}
 	}
 
-	ret = mcp3911_config(adc, spi->dev.of_node);
+	ret = mcp3911_config(adc, &spi->dev);
 	if (ret)
 		goto clk_disable;
 
-- 
2.34.1

