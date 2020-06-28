Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E7820C804
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jun 2020 14:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgF1MjM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jun 2020 08:39:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbgF1MjM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jun 2020 08:39:12 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47DF520760;
        Sun, 28 Jun 2020 12:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593347952;
        bh=zI3RehXVf5DLbGbpuhmOMehOJYaTZfggTCm5mLkHvpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RYw9lZjvTimY5SWM8R4zQBbf8353n/v4Z0fklFISbviHhtjtTPq8BJltZXzJsoMrb
         bQ2Anl1SNU2NZU+tvhkt0+qX1/vlmj7M4P6y+NJSysDljgyyLUVk0gETwAw7F9ipec
         VOhLXfnMRn0FTPrQz8kMUhDQ1QLUkGe8fJrcHE/Y=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 09/23] iio:adc:ltc2497 drop of_match_ptr protection
Date:   Sun, 28 Jun 2020 13:36:40 +0100
Message-Id: <20200628123654.32830-10-jic23@kernel.org>
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

This prevents the driver being used with ACPI PRP0001 based
bindings. Also switch include to mod_devicetable.h which devices
the used id structure.

Note this is most about removing something I don't want want cut
and paste into new driver rather than any thought that this particular
driver will be used in an ACPI system (though it might!)

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/adc/ltc2497.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
index 5db63d7c6bc5..1adddf5a88a9 100644
--- a/drivers/iio/adc/ltc2497.c
+++ b/drivers/iio/adc/ltc2497.c
@@ -11,7 +11,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/driver.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/mod_devicetable.h>
 
 #include "ltc2497.h"
 
@@ -98,7 +98,7 @@ MODULE_DEVICE_TABLE(of, ltc2497_of_match);
 static struct i2c_driver ltc2497_driver = {
 	.driver = {
 		.name = "ltc2497",
-		.of_match_table = of_match_ptr(ltc2497_of_match),
+		.of_match_table = ltc2497_of_match,
 	},
 	.probe = ltc2497_probe,
 	.remove = ltc2497_remove,
-- 
2.27.0

