Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02319460953
	for <lists+linux-iio@lfdr.de>; Sun, 28 Nov 2021 20:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352717AbhK1T1L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Nov 2021 14:27:11 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58396 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbhK1TZL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Nov 2021 14:25:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6868B80D5C
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 19:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01556C004E1;
        Sun, 28 Nov 2021 19:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638127312;
        bh=9qYCC8V6k+4Zu0+atg1Pywtedf4adRJCpePGyZiH+Tg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EJE5Ny9GiFHb1kJQNkz7d7j/lhMts01tzEy3vYqrMJUFwPKFW8uEB1NZncSjFUGXg
         +rHUYouYj2NaiGB6iuULqAfVqSIboM7k4bnNn+Vn+gebuR6ua7VwhkYTpNsTB21IdD
         ZQ/wYxKd2iOtvaavTJyaJHDg0QmGuIAgj8iCjNANOPbs6VxWLeNCtJiWE1sBfHmTC8
         I7vW73CUkg2Xop0mM0j7EC6vipK9XkFlx3n0Io+cNmDlbN1JgVwRMmqCGkjx1bNZS0
         sMTNX6bvUTeUF/yvo9rHKuVtHH1VDg5JImbdg4SMD7e9Lb/FQYcXv2/DRMMIQXoQUj
         akPetOa3eQdgw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Chris Coffey <cmc@babblebit.net>
Subject: [PATCH 05/12] iio:pot:mcp41010: Switch to generic firmware properties.
Date:   Sun, 28 Nov 2021 19:26:28 +0000
Message-Id: <20211128192635.2724359-6-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211128192635.2724359-1-jic23@kernel.org>
References: <20211128192635.2724359-1-jic23@kernel.org>
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

