Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5521046866C
	for <lists+linux-iio@lfdr.de>; Sat,  4 Dec 2021 18:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355347AbhLDRLL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Dec 2021 12:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355598AbhLDRLK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Dec 2021 12:11:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C35EC061751
        for <linux-iio@vger.kernel.org>; Sat,  4 Dec 2021 09:07:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC8E160ECE
        for <linux-iio@vger.kernel.org>; Sat,  4 Dec 2021 17:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51CB4C341C2;
        Sat,  4 Dec 2021 17:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638637664;
        bh=9qYCC8V6k+4Zu0+atg1Pywtedf4adRJCpePGyZiH+Tg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rsep2XxByU8fybtkREYEHftdUefbJZM72nN7j5PVU+bsbAv/oSVnSiwlloVEBlla7
         TPP1zNy3e6AV0NQ8BT65p+2Ic3wMatSu6HIuUupIHh2Cmi3cGQSRTQI+uRLkLQ9/lG
         BFDLJrw+Y+KM3zWSaVHRo5ukknXvveqIViL/DJ6UpSyDxu/Etqbs8d5ey2Jtp5onV1
         lqxKB/y07Sa9FoTTtzRK/yU9/LW+4q3hEXamU6+YiYJj+aES7un7GjLgSIUwFGLhGz
         JBWBbWHPFfzXf9tVTxxN3oA8VQK/en1Vb+s1a8px+J8RPKwv5W49kTI4DXXodMmcuv
         Jr++VUvBabcRg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Chris Coffey <cmc@babblebit.net>
Subject: [PATCH v2 05/12] iio:pot:mcp41010: Switch to generic firmware properties.
Date:   Sat,  4 Dec 2021 17:12:30 +0000
Message-Id: <20211204171237.2769210-6-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211204171237.2769210-1-jic23@kernel.org>
References: <20211204171237.2769210-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

In this case it was only of_device_get_match_data() + header update.
This enables use of other firmware types with no other changes, such
as ACPI via the PRP0001 route.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Chris Coffey <cmc@babblebit.net>
---
 drivers/iio/potentiometer/mcp41010.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/potentiometer/mcp41010.c b/drivers/iio/potentiometer/mcp41010.c
index 79ccac6d4be0..30a4594d4e11 100644
--- a/drivers/iio/potentiometer/mcp41010.c
+++ b/drivers/iio/potentiometer/mcp41010.c
@@ -21,9 +21,9 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/types.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/property.h>
 #include <linux/spi/spi.h>
 
 #define MCP41010_MAX_WIPERS	2
@@ -146,7 +146,7 @@ static int mcp41010_probe(struct spi_device *spi)
 	data = iio_priv(indio_dev);
 	spi_set_drvdata(spi, indio_dev);
 	data->spi = spi;
-	data->cfg = of_device_get_match_data(&spi->dev);
+	data->cfg = device_get_match_data(&spi->dev);
 	if (!data->cfg)
 		data->cfg = &mcp41010_cfg[spi_get_device_id(spi)->driver_data];
 
-- 
2.34.1

