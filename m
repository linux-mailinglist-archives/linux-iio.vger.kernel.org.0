Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8EAC468670
	for <lists+linux-iio@lfdr.de>; Sat,  4 Dec 2021 18:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355662AbhLDRLV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Dec 2021 12:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355645AbhLDRLV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Dec 2021 12:11:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D8EC061751
        for <linux-iio@vger.kernel.org>; Sat,  4 Dec 2021 09:07:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2416760ED0
        for <linux-iio@vger.kernel.org>; Sat,  4 Dec 2021 17:07:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE073C341C0;
        Sat,  4 Dec 2021 17:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638637674;
        bh=VkSMyMvO3I84AyzBfDiEEp7AK+5RiVlF3XdRwLUpwcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JHCAssIvkNobfVl5iTWjxZKuIKAjZEa9kLAn1g+BDEc2Dp/A15eVYSSII/2YT4rA1
         rIYK5Vndh91m08vpNfJ625zNTeUCOS4i0UCHLpMMg6kBF0E34PDi3yEowyU4dyfZlH
         RWMLk4Z+NjfgUfl4VkiLkM67qNn8TEzQEL707lXauVXLee7Be3jb319NqneCzQvJAG
         QJBHMNVgQG59MmwIr2uLg2r1QoGffTSjco3szuxil78RjH4jMh6ZIZNavhKc0M7Qi0
         FVyYDfMJ8boYnRY2/CGcAlakXhiqpvDbCArKZ9KtI4ifvnMytve36kPC4puC50XTW0
         TC5bV7pyVAipA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 09/12] iio:adc:ti-adc12138: Switch to generic firmware properties.
Date:   Sat,  4 Dec 2021 17:12:34 +0000
Message-Id: <20211204171237.2769210-10-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211204171237.2769210-1-jic23@kernel.org>
References: <20211204171237.2769210-1-jic23@kernel.org>
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

