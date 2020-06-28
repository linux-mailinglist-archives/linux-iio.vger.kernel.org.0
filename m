Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE2E20C7FC
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jun 2020 14:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgF1MjB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jun 2020 08:39:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbgF1MjA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jun 2020 08:39:00 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E88F320760;
        Sun, 28 Jun 2020 12:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593347940;
        bh=Cz7K3AIcHR1ju60+moItSF+IFx6ukxJN/DTrE0HQDXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wQIjdBVBocTYgL1sYSDQBcIhgJLi/AfewDlXG7LWJOK+yL/PQ2Uv2rYCSeXgw+8RR
         WBQVPYOCrmZ60XbbzupHG/70zOG1nOZFhaCCJMozXBvzdNtMXwvzpwGBRsAS6oh4rp
         sAD5OK3imZU5kGGtwRiu7H2qvBazb1mcRdutb0v8=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 01/23] iio:adc:lpc32xx: Drop of_match_ptr protection
Date:   Sun, 28 Jun 2020 13:36:32 +0100
Message-Id: <20200628123654.32830-2-jic23@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200628123654.32830-1-jic23@kernel.org>
References: <20200628123654.32830-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Whilst is unlikely anyone will be using this part with an ACPI PRP0001
based binding any time soon, we are getting a lot of cut and pasting
of this pattern so I am looking to remove it entirely from IIO.

In this case CONFIG_OF protections also removed and
mod_devicetable.h include added given direct use of struct of_device_id.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/lpc32xx_adc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_adc.c
index bc2712a48844..b56ce15255cf 100644
--- a/drivers/iio/adc/lpc32xx_adc.c
+++ b/drivers/iio/adc/lpc32xx_adc.c
@@ -14,6 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 
@@ -209,19 +210,17 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id lpc32xx_adc_match[] = {
 	{ .compatible = "nxp,lpc3220-adc" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, lpc32xx_adc_match);
-#endif
 
 static struct platform_driver lpc32xx_adc_driver = {
 	.probe		= lpc32xx_adc_probe,
 	.driver		= {
 		.name	= LPC32XXAD_NAME,
-		.of_match_table = of_match_ptr(lpc32xx_adc_match),
+		.of_match_table = lpc32xx_adc_match,
 	},
 };
 
-- 
2.27.0

