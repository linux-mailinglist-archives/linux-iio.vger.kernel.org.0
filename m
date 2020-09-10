Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF2B264B8D
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 19:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgIJRkK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 13:40:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727095AbgIJRgA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:36:00 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CFC9221EC;
        Thu, 10 Sep 2020 17:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759329;
        bh=0gR9DbF4mOgfEbOg15URbOrD9gQ7vQCurGCJPF5Hz98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IgxNW9g9W5kvpE+R3ls5V8qs3KKQYa+7EHwFbAic23MAlgChb/ockX/L1FUPdKZif
         tvnZ2zdX3MouihUUF18MmwuF2+LyOXtoAx4q+YPGldZ9UfflQGU1WkxBCWIkrshMy7
         JyNMZ5yLy6cqPLsH2w+DzWqE/TvJ39zXtusXJ5aI=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 12/38] iio:dac:ad7303: Drop of_match_ptr protection
Date:   Thu, 10 Sep 2020 18:32:16 +0100
Message-Id: <20200910173242.621168-13-jic23@kernel.org>
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

This prevents use of this driver with ACPI via PRP0001 and are
an example of an anti pattern I'm trying to remove from IIO.

Also add mod_devicetable.h include given struct of_device_id is
declared there.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/dac/ad7303.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad7303.c b/drivers/iio/dac/ad7303.c
index 4460aa57a33f..20c85c2a636c 100644
--- a/drivers/iio/dac/ad7303.c
+++ b/drivers/iio/dac/ad7303.c
@@ -7,6 +7,7 @@
 
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
@@ -287,7 +288,7 @@ MODULE_DEVICE_TABLE(spi, ad7303_spi_ids);
 static struct spi_driver ad7303_driver = {
 	.driver = {
 		.name = "ad7303",
-		.of_match_table = of_match_ptr(ad7303_spi_of_match),
+		.of_match_table = ad7303_spi_of_match,
 	},
 	.probe = ad7303_probe,
 	.remove = ad7303_remove,
-- 
2.28.0

