Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B90264B7D
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 19:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgIJRjq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 13:39:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727119AbgIJRhO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:37:14 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7908A22229;
        Thu, 10 Sep 2020 17:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759360;
        bh=8m9Eu5Z7l1WDp5n3jN0PlW09xmryAEuUQvPXhf1s5o4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=griBLVZzTz2/sRHoA4uqbMn4WKm6oP3a2iwOyhgTo3GDKRFgFTDTkDPE9Yi1KNFPR
         rqpO7hKXGkzzUKAvQx3pgHmpmgUJBRn4/nXHy46EmnApiSm4jv7p647etSD2gPk34f
         yvEh75ZM3zQLtm1AhZcwyT6QjXqYL0DEGhYypPCA=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 35/38] iio:magn:ak8974: Drop of_match_ptr protection
Date:   Thu, 10 Sep 2020 18:32:39 +0100
Message-Id: <20200910173242.621168-36-jic23@kernel.org>
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
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/magnetometer/ak8974.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index 7cd9768fbcb2..df5131cf28a9 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -12,6 +12,7 @@
  * Author: Linus Walleij <linus.walleij@linaro.org>
  */
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/kernel.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
@@ -1051,7 +1052,7 @@ static struct i2c_driver ak8974_driver = {
 	.driver	 = {
 		.name	= "ak8974",
 		.pm = &ak8974_dev_pm_ops,
-		.of_match_table = of_match_ptr(ak8974_of_match),
+		.of_match_table = ak8974_of_match,
 	},
 	.probe	  = ak8974_probe,
 	.remove	  = ak8974_remove,
-- 
2.28.0

