Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6D8264B6D
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 19:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgIJRhx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 13:37:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727812AbgIJRgH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:36:07 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BD9B22206;
        Thu, 10 Sep 2020 17:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759341;
        bh=UiiKQ6C10JhV4gEG1WsDhxmh2o901QY7gomr0MUp1DU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UjgKtfN/nJrjyDjnNoC5KIEclDtcDu9Z+AgvqqxHqqv4nFqpxgKxR79LPPjRR4Qt2
         kNEXF6jEKas6MiaQE4np7+5PFbaEey0JFEnG606eKunl/0Qim+TjROh9q8ZDwW7bmO
         jjc49YkEKEYLMCnNiur+81MiTjOj1CTfJlfcVzuk=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
Subject: [PATCH 21/38] iio:temperature:tsys01: Drop of_match_ptr protection
Date:   Thu, 10 Sep 2020 18:32:25 +0100
Message-Id: <20200910173242.621168-22-jic23@kernel.org>
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
Cc: Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
---
 drivers/iio/temperature/tsys01.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/tsys01.c b/drivers/iio/temperature/tsys01.c
index 2c631a1ca33b..bbfbad9a8767 100644
--- a/drivers/iio/temperature/tsys01.c
+++ b/drivers/iio/temperature/tsys01.c
@@ -13,6 +13,7 @@
 #include <linux/device.h>
 #include <linux/mutex.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/stat.h>
@@ -222,7 +223,7 @@ static struct i2c_driver tsys01_driver = {
 	.id_table = tsys01_id,
 	.driver = {
 		   .name = "tsys01",
-		   .of_match_table = of_match_ptr(tsys01_of_match),
+		   .of_match_table = tsys01_of_match,
 		   },
 };
 
-- 
2.28.0

