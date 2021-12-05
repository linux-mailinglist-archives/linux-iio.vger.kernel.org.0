Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE533468C3A
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 17:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236067AbhLERA0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 12:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236074AbhLERA0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 12:00:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5CCC061714
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 08:56:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9F7CB80EC2
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 16:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05285C00446;
        Sun,  5 Dec 2021 16:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638723416;
        bh=vcZPFArCzOiFb2J7uv0CsmosieDviEvZegAGTJz+LlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BY5mULROTmkvDH8umjdCVNSJ6Md+H6eiMjQsKikceO0yoEXJ1rRyRczrP1tQfQMq+
         fludhnER8uNiFiSIibln3jzu3maHi5i8dGEy7JI3zdKfVAcVRp5AhbxjOVf2VmzOsg
         d1Wd5PUJuPSzrMxf3FSvHFM7s/YejjPAVvIhSYwEbKhxtnHLpsUgqQArQnrYgFq5B0
         Z2UebChsTC6xLGBXU/UfyiWgv5ZoogN6DAhGyPI202lVEo9QmofN3ySNXwRvqMtUjk
         F17g927OSPZxug70Cv6hmFhCiH5NUmvsns827YboN/73CkgRQH7mrKyMcwa6pY0T5Q
         6HiBFzEUtxjiQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 09/12] iio:adc:ti-adc12138: Switch to generic firmware properties and drop of_match_ptr
Date:   Sun,  5 Dec 2021 17:01:37 +0000
Message-Id: <20211205170140.2783914-10-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205170140.2783914-1-jic23@kernel.org>
References: <20211205170140.2783914-1-jic23@kernel.org>
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---

v3: Dropped of_match_ptr()

 drivers/iio/adc/ti-adc12138.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ti-adc12138.c b/drivers/iio/adc/ti-adc12138.c
index 5b5d45210539..6eb62b564dae 100644
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
@@ -540,7 +537,7 @@ MODULE_DEVICE_TABLE(spi, adc12138_id);
 static struct spi_driver adc12138_driver = {
 	.driver = {
 		.name = "adc12138",
-		.of_match_table = of_match_ptr(adc12138_dt_ids),
+		.of_match_table = adc12138_dt_ids,
 	},
 	.probe = adc12138_probe,
 	.remove = adc12138_remove,
-- 
2.34.1

