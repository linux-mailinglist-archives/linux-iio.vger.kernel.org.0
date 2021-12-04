Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C7A46866F
	for <lists+linux-iio@lfdr.de>; Sat,  4 Dec 2021 18:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355602AbhLDRLT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Dec 2021 12:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355645AbhLDRLS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Dec 2021 12:11:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140A2C061751
        for <linux-iio@vger.kernel.org>; Sat,  4 Dec 2021 09:07:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A81A860EA9
        for <linux-iio@vger.kernel.org>; Sat,  4 Dec 2021 17:07:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1ADC341C3;
        Sat,  4 Dec 2021 17:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638637672;
        bh=YumZW9e9eO1+G4uWv8xobHj7a1kla7gjc+AG/KZsLr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I9vYvGy6HiSpBaNweeYralsn2GwaILCWKmJ147iXrbi/C2yZiu96MRjfk1xyZtud1
         xjCMu3o5qw9JMiKvlhuCxAAlQx0C3YAnkgDs2eh9onBwpTrJ0o5NenlZHw8aQn8jjw
         g69R/0eweIkki3wEOacB3A1euTu9M9OtUZovjKDVsvUEcMWM9biHhYlXIgV3rD2/Ya
         BRo6HbkUn342IzggyCIqZwcJZpgi1JN2KjwKd72x1luhUXRZAZ7OvyHkreyX9Ebju6
         7Ey758SC3BUqG5fxQ0aJyZDyqVgAUHUuYlbNoCQf6AbV36Dq4DvAhlmYY97b3miAqn
         /ddEi4tgDtMRw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kent Gustavsson <kent@minoris.se>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH v2 08/12] iio:adc:mcp3911: Switch to generic firmware properties.
Date:   Sat,  4 Dec 2021 17:12:33 +0000
Message-Id: <20211204171237.2769210-9-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211204171237.2769210-1-jic23@kernel.org>
References: <20211204171237.2769210-1-jic23@kernel.org>
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

