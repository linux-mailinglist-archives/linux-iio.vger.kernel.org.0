Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C5220C801
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jun 2020 14:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgF1MjI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jun 2020 08:39:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbgF1MjI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jun 2020 08:39:08 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE85C2076E;
        Sun, 28 Jun 2020 12:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593347948;
        bh=vqys9J+CxZpDqKWoLrfc42E8xFmtZolr4+PnOPt17CM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M8PqMW1fVjd1Tv70Ypeursfxrow2QgO2ho0brFGICG9ZTWCeXFY6U2crkEiv4rFum
         wNN4nFCMhWUS+CrzfETO7RzthpRojtDk5C7XeqzQHKtzVRMeUCDgi4CrMO07DpmunO
         75Nvu66OTIEptg/bx2VehZ6pdb7Vv/xIbG17BsgQ=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Philippe Reynes <tremyfr@yahoo.fr>
Subject: [PATCH 06/23] iio:adc:max1027: drop of_match_ptr and CONFIG_OF protections
Date:   Sun, 28 Jun 2020 13:36:37 +0100
Message-Id: <20200628123654.32830-7-jic23@kernel.org>
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

These just prevent the driver being used with ACPI PRP0001
and provide no major benefits.

Part of clearing these out in general in IIO to avoid cut and paste
repetition in new drivers.  Also include mod_devicetable.h as we
directly make use of of_device_id which is defined in there.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Philippe Reynes <tremyfr@yahoo.fr>
---
 drivers/iio/adc/max1027.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 9e993ccd14de..ca1dff3924ff 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -14,6 +14,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/spi/spi.h>
 #include <linux/delay.h>
 
@@ -79,7 +80,6 @@ static const struct spi_device_id max1027_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, max1027_id);
 
-#ifdef CONFIG_OF
 static const struct of_device_id max1027_adc_dt_ids[] = {
 	{ .compatible = "maxim,max1027" },
 	{ .compatible = "maxim,max1029" },
@@ -90,7 +90,6 @@ static const struct of_device_id max1027_adc_dt_ids[] = {
 	{},
 };
 MODULE_DEVICE_TABLE(of, max1027_adc_dt_ids);
-#endif
 
 #define MAX1027_V_CHAN(index, depth)					\
 	{								\
@@ -518,7 +517,7 @@ static int max1027_probe(struct spi_device *spi)
 static struct spi_driver max1027_driver = {
 	.driver = {
 		.name	= "max1027",
-		.of_match_table = of_match_ptr(max1027_adc_dt_ids),
+		.of_match_table = max1027_adc_dt_ids,
 	},
 	.probe		= max1027_probe,
 	.id_table	= max1027_id,
-- 
2.27.0

