Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCDD264B73
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 19:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgIJRiL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 13:38:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgIJRhI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:37:08 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 812C221D81;
        Thu, 10 Sep 2020 17:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759353;
        bh=ZXzliXGT/bnt7tne6KtQiVtQWVtaNAaHSzjfewyEpyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VibKZAx/2gNAg1JHi40xz1ojgcGrjpBnVOS7xHfUOX/hPBmT6JiBEEumCrTYHUB4J
         kY0uKRITyrxDwZgNDwLMsnrNBZJ941ZAs4EmxfYNAkvnUXx2YePXOklkQnHrCcgjFX
         ooyrop3nhtZxqWXDZ1+W7iNAluN6YRyS9UeKnNKA=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 30/38] iio:humidity:hdc100x: Drop of_match_ptr protection.
Date:   Thu, 10 Sep 2020 18:32:34 +0100
Message-Id: <20200910173242.621168-31-jic23@kernel.org>
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
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/humidity/hdc100x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index 071cb2b12bb6..2a957f19048e 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -15,6 +15,7 @@
 
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
 
@@ -417,7 +418,7 @@ MODULE_DEVICE_TABLE(of, hdc100x_dt_ids);
 static struct i2c_driver hdc100x_driver = {
 	.driver = {
 		.name	= "hdc100x",
-		.of_match_table = of_match_ptr(hdc100x_dt_ids),
+		.of_match_table = hdc100x_dt_ids,
 	},
 	.probe = hdc100x_probe,
 	.id_table = hdc100x_id,
-- 
2.28.0

