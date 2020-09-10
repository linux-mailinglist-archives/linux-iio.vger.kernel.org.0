Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4FD264B86
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 19:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgIJRkF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 13:40:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgIJRgk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:36:40 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DCEE2220E;
        Thu, 10 Sep 2020 17:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759343;
        bh=/0uhkTEyCAIImJU4E4tLF5MTr4G21ANWyYheb9Ik3qg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fP+3iO0Oii4tcHEL5fUgMNaaj5KfpkqSHYv4mfhxMbeAwDj+OAS6sg9c6FWwqMf+F
         pl9cEMgDsNsNO3k/UVVSUTQI7tD7vve30qlmWlGp4RlTGkbNW6FltU2+TJ3UnR1lZZ
         thIBhDstwHHVtzr74bknYrvvtc/c2LsSBTLUTUVQ=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 23/38] iio:resolver:ad2s1200: Drop of_match_ptr protection
Date:   Thu, 10 Sep 2020 18:32:27 +0100
Message-Id: <20200910173242.621168-24-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910173242.621168-1-jic23@kernel.org>
References: <20200910173242.621168-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This prevents use of this driver with ACPI via PRP0001 and is
an example of an anti pattern I'm trying to remove from IIO.
Hence drop from this driver.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/resolver/ad2s1200.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/resolver/ad2s1200.c b/drivers/iio/resolver/ad2s1200.c
index 6007abad116b..9746bd935628 100644
--- a/drivers/iio/resolver/ad2s1200.c
+++ b/drivers/iio/resolver/ad2s1200.c
@@ -12,6 +12,7 @@
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
@@ -192,7 +193,7 @@ MODULE_DEVICE_TABLE(spi, ad2s1200_id);
 static struct spi_driver ad2s1200_driver = {
 	.driver = {
 		.name = DRV_NAME,
-		.of_match_table = of_match_ptr(ad2s1200_of_match),
+		.of_match_table = ad2s1200_of_match,
 	},
 	.probe = ad2s1200_probe,
 	.id_table = ad2s1200_id,
-- 
2.28.0

