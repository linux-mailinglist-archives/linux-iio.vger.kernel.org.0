Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D5E20C80E
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jun 2020 14:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgF1Mj0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jun 2020 08:39:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726459AbgF1Mj0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jun 2020 08:39:26 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98B7B20738;
        Sun, 28 Jun 2020 12:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593347966;
        bh=2Vp/HMncT6c0ghGxGu3s2SRLPwjs3iE1JBKBYJZ0a6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U4tg5dL8U1Kxm3pZIpDatKThqfwWpYc0Yg4FS/6FvagIRBhMnf4kMpJ7SU4dTbYJA
         W+GXov/a/XZkZuwgn0Y05DYD2Xu4bAZlOCaUXIM8TE8cwyHlkAloxZiYIlHVIxLTTh
         Qbk3oGFrHBCQm/7yb6aeonrjxhneNn+ovpwGkw88=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: [PATCH 19/23] iio:adc:ti-adc128s052: drop of_match_ptr protection
Date:   Sun, 28 Jun 2020 13:36:50 +0100
Message-Id: <20200628123654.32830-20-jic23@kernel.org>
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

There is no real advantage in this and it prevents use of
ACPI PRP0001. I'm also trying to clear this out of IIO in general
to avoid copying in new drivers.

Include mod_devicetable.h as we are using of_device_id in here so
including that header is best practice.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Angelo Compagnucci <angelo.compagnucci@gmail.com>
---
 drivers/iio/adc/ti-adc128s052.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index c1552b0fee04..cc3fb2d1686a 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -13,6 +13,7 @@
 #include <linux/err.h>
 #include <linux/spi/spi.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/iio/iio.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
@@ -220,7 +221,7 @@ MODULE_DEVICE_TABLE(acpi, adc128_acpi_match);
 static struct spi_driver adc128_driver = {
 	.driver = {
 		.name = "adc128s052",
-		.of_match_table = of_match_ptr(adc128_of_match),
+		.of_match_table = adc128_of_match,
 		.acpi_match_table = ACPI_PTR(adc128_acpi_match),
 	},
 	.probe = adc128_probe,
-- 
2.27.0

