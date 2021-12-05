Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CB4468C39
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 17:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbhLERAY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 12:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236067AbhLERAY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 12:00:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07EBC061714
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 08:56:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98071B80EC5
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 16:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D349C341C5;
        Sun,  5 Dec 2021 16:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638723414;
        bh=Nc44Dwir+2+VsCnUTFDtU4oIpB9Qc8GM0UsIFYa49D4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y63GaJ0t44fPdN+kLsnwpzagZIIYSP6Ufxr4Yzc6wP7gZNpgPzfa8QsyAHx09eESq
         Pi/uGJk6g0/S1MAC6ttTU8StaryzJdpZhmBuNvsFEfcz5MOW3cZ0GpnMlzf2hBtkJE
         HnwdaGP3GPmKsXOb3V8yOt3GUPQSD2kWLKlSFCsP0DN5qcN4Bzi60IvGtKjAT1SntH
         bw9fOvlQjFg+AA/xMSjSGiaYRR0Z+cz+FBooE8xScM3QyMbz9SmkQKFAcNCBGo8jGp
         0TX62T50W09JqV78h8iJsgZzx+AY+upLmye9CroiE2/ZR7oTgvt3TBypRsSXbpWzax
         7Gc5NcVsHsbNQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kent Gustavsson <kent@minoris.se>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH v3 08/12] iio:adc:mcp3911: Switch to generic firmware properties.
Date:   Sun,  5 Dec 2021 17:01:36 +0000
Message-Id: <20211205170140.2783914-9-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205170140.2783914-1-jic23@kernel.org>
References: <20211205170140.2783914-1-jic23@kernel.org>
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Kent Gustavsson <kent@minoris.se>
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
---
v3: Drop the struct device * from parameters to *_config as it
    is available via adc->spi->dev

drivers/iio/adc/mcp3911.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index e573da5397bb..13535f148c4c 100644
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
 
@@ -200,12 +202,13 @@ static const struct iio_info mcp3911_info = {
 	.write_raw = mcp3911_write_raw,
 };
 
-static int mcp3911_config(struct mcp3911 *adc, struct device_node *of_node)
+static int mcp3911_config(struct mcp3911 *adc)
 {
+	struct device *dev = &adc->spi->dev;
 	u32 configreg;
 	int ret;
 
-	of_property_read_u32(of_node, "device-addr", &adc->dev_addr);
+	device_property_read_u32(dev, "device-addr", &adc->dev_addr);
 	if (adc->dev_addr > 3) {
 		dev_err(&adc->spi->dev,
 			"invalid device address (%i). Must be in range 0-3.\n",
@@ -289,7 +292,7 @@ static int mcp3911_probe(struct spi_device *spi)
 		}
 	}
 
-	ret = mcp3911_config(adc, spi->dev.of_node);
+	ret = mcp3911_config(adc);
 	if (ret)
 		goto clk_disable;
 
-- 
2.34.1

