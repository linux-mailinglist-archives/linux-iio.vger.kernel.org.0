Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3390420C807
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jun 2020 14:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgF1MjR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jun 2020 08:39:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbgF1MjR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jun 2020 08:39:17 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97FA620760;
        Sun, 28 Jun 2020 12:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593347956;
        bh=Y4ykPCu/uFg/Mwr3Xw7IJJOphupiq1C7mA3+puk7UdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bUqse5yEnkYvYipGSQz3s4vOzinhAuBxirzwdbTfssdudeniGqvMTQYOS57gICBKg
         85IwfTTRImDy75DHqXWfemz/GkyQ0LP+N2YmR3tzADoerOQukbAFQwK0PNSiQudFPi
         Z5IymuPiW5DtbDa5yDyWgFqjmMmOyBSz1QjGPh0Q=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Oskar Andero <oskar.andero@gmail.com>,
        =?UTF-8?q?S=C3=B8ren=20Andersen?= <san@rosetechnology.dk>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 12/23] iio:adc:mcp320x: Drop CONFIG_OF and of_match_ptr protections
Date:   Sun, 28 Jun 2020 13:36:43 +0100
Message-Id: <20200628123654.32830-13-jic23@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200628123654.32830-1-jic23@kernel.org>
References: <20200628123654.32830-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These just prevent the driver being used with ACPI PRP0001.
They also get cut and paste into new drivers and we want to discourage
this from happening by cleaning it out in general.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Oskar Andero <oskar.andero@gmail.com>
Cc: Søren Andersen <san@rosetechnology.dk>
Cc: Lukas Wunner <lukas@wunner.de>
---
 drivers/iio/adc/mcp320x.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index e533f1064cf8..bb37e66ff7dc 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -41,6 +41,7 @@
 #include <linux/delay.h>
 #include <linux/spi/spi.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/iio/iio.h>
 #include <linux/regulator/consumer.h>
 
@@ -469,7 +470,6 @@ static int mcp320x_remove(struct spi_device *spi)
 	return 0;
 }
 
-#if defined(CONFIG_OF)
 static const struct of_device_id mcp320x_dt_ids[] = {
 	/* NOTE: The use of compatibles with no vendor prefix is deprecated. */
 	{ .compatible = "mcp3001" },
@@ -497,7 +497,6 @@ static const struct of_device_id mcp320x_dt_ids[] = {
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mcp320x_dt_ids);
-#endif
 
 static const struct spi_device_id mcp320x_id[] = {
 	{ "mcp3001", mcp3001 },
@@ -520,7 +519,7 @@ MODULE_DEVICE_TABLE(spi, mcp320x_id);
 static struct spi_driver mcp320x_driver = {
 	.driver = {
 		.name = "mcp320x",
-		.of_match_table = of_match_ptr(mcp320x_dt_ids),
+		.of_match_table = mcp320x_dt_ids,
 	},
 	.probe = mcp320x_probe,
 	.remove = mcp320x_remove,
-- 
2.27.0

