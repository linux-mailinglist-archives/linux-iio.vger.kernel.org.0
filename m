Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7F446095E
	for <lists+linux-iio@lfdr.de>; Sun, 28 Nov 2021 20:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbhK1T2R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Nov 2021 14:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243514AbhK1T0O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Nov 2021 14:26:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204AFC0613F8
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 11:22:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82D2EB80D5A
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 19:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179C1C004E1;
        Sun, 28 Nov 2021 19:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638127320;
        bh=VkSMyMvO3I84AyzBfDiEEp7AK+5RiVlF3XdRwLUpwcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S/W/csIaz/6hBvFcG42yZ+EFqL4/+q2qvKXyT7ARGYQQjDW0Xce9Wv9lrb4aYff9c
         P0ZUWPebFHK+IFHBDGMMK+zCKQ8Wj5Bhce1wOuVRSzukLWrofWzeHKu7kAO61QUdNb
         hUs7lhrBOLjnT+ir5WxE297dLvOHV7CgP4SZ47YY7IDx25zw8m0A4aXefXM/+rz1il
         wehGMd/o1SMJizYIb/Pbbnne1Nu3B4kJY04VDjf1kRO6m4AZU33wjztEAedtEKXKkW
         jYTrAWfeb2gSMnEqRLZUTqkYJmBf4Gq6UiXgZ2wi9miOJligMmMlHgAUPlxP93lwTV
         92pHExcam/IVg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 09/12] iio:adc:ti-adc12138: Switch to generic firmware properties.
Date:   Sun, 28 Nov 2021 19:26:32 +0000
Message-Id: <20211128192635.2724359-10-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211128192635.2724359-1-jic23@kernel.org>
References: <20211128192635.2724359-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This enables using the driver with other firmware types such
as ACPI via PRP0001.

Also part of a general attempt to move IIO drivers over to generic
properties to avoid opportunities for cut and paste.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti-adc12138.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ti-adc12138.c b/drivers/iio/adc/ti-adc12138.c
index 5b5d45210539..99fe53089c72 100644
--- a/drivers/iio/adc/ti-adc12138.c
+++ b/drivers/iio/adc/ti-adc12138.c
@@ -11,6 +11,7 @@
 #include <linux/interrupt.h>
 #include <linux/completion.h>
 #include <linux/clk.h>
+#include <linux/property.h>
 #include <linux/spi/spi.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
@@ -430,8 +431,8 @@ static int adc12138_probe(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	ret = of_property_read_u32(spi->dev.of_node, "ti,acquisition-time",
-				   &adc->acquisition_time);
+	ret = device_property_read_u32(&spi->dev, "ti,acquisition-time",
+				       &adc->acquisition_time);
 	if (ret)
 		adc->acquisition_time = 10;
 
@@ -517,8 +518,6 @@ static int adc12138_remove(struct spi_device *spi)
 	return 0;
 }
 
-#ifdef CONFIG_OF
-
 static const struct of_device_id adc12138_dt_ids[] = {
 	{ .compatible = "ti,adc12130", },
 	{ .compatible = "ti,adc12132", },
@@ -527,8 +526,6 @@ static const struct of_device_id adc12138_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, adc12138_dt_ids);
 
-#endif
-
 static const struct spi_device_id adc12138_id[] = {
 	{ "adc12130", adc12130 },
 	{ "adc12132", adc12132 },
-- 
2.34.1

