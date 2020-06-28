Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A6C20C80C
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jun 2020 14:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgF1MjY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jun 2020 08:39:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726459AbgF1MjX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jun 2020 08:39:23 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF47E208B6;
        Sun, 28 Jun 2020 12:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593347963;
        bh=9ohi+nrNv/8GK3r1qJC3YAtMoWzP9JYvhmJTZx9Ay04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v86r2i0UGNlEUSalwXXx7+o8iLO5DSKoiKwE/B6pvHnv1/cIWOkCApoG66sSRdcaX
         Rrm5MuFysu5xL8WJIUm3WuIfLBF4vhbWXpg5pJ40TeRaJkhCHZf5oKhdichZFhWvdQ
         y0aov3F7AOl3T64TVzRPCK0jm/CvT0NOY5W+tC3g=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <martenli@axis.com>
Subject: [PATCH 17/23] iio:adc:ti-adc084s021: drop of_match_ptr protection
Date:   Sun, 28 Jun 2020 13:36:48 +0100
Message-Id: <20200628123654.32830-18-jic23@kernel.org>
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

Allows ACPI PRP0001 to be used with this driver.
Also adds mod_devicetable.h header as the driver is directly using
struct of_device_id which is defined in that file.

I'm also trying to clear out of_match_ptr use in IIO to avoid it
being cut and paste into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mårten Lindahl <martenli@axis.com>
---
 drivers/iio/adc/ti-adc084s021.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
index c2db2435f419..5678bf7499b1 100644
--- a/drivers/iio/adc/ti-adc084s021.c
+++ b/drivers/iio/adc/ti-adc084s021.c
@@ -10,6 +10,7 @@
 #include <linux/err.h>
 #include <linux/spi/spi.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/interrupt.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
@@ -254,7 +255,7 @@ MODULE_DEVICE_TABLE(spi, adc084s021_id);
 static struct spi_driver adc084s021_driver = {
 	.driver = {
 		.name = ADC084S021_DRIVER_NAME,
-		.of_match_table = of_match_ptr(adc084s021_of_match),
+		.of_match_table = adc084s021_of_match,
 	},
 	.probe = adc084s021_probe,
 	.id_table = adc084s021_id,
-- 
2.27.0

