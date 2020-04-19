Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016951AFB89
	for <lists+linux-iio@lfdr.de>; Sun, 19 Apr 2020 17:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgDSPEU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Apr 2020 11:04:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgDSPET (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Apr 2020 11:04:19 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F31E221973;
        Sun, 19 Apr 2020 15:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587308659;
        bh=V7lJ7JDeqdCtorEyl6z0O+mrCrBodR4edEuakzx/oqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ygvMnMkMaAE/9LHjqCRP+bQuGKh5M83SJKbzQ0Edbn5v7ubS749LFUHzIwsfC7VQb
         yRjLyWCQEX6Gl8bJN+i6lOjE3poC5qmtO3EcG1aZ2IZheSBNC0AsSkCS2xI+cm0DeI
         P8sF6vClZ6ePbX/c6sXrbBNhN8n0q5nURjmrlLz8=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/7] iio: light: bh1780: use mod_devicetable.h and drop of_match_ptr macro
Date:   Sun, 19 Apr 2020 16:02:00 +0100
Message-Id: <20200419150206.43033-2-jic23@kernel.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200419150206.43033-1-jic23@kernel.org>
References: <20200419150206.43033-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Whilst this enables ACPI binding or the device via PRP0001 the
primary aim is to remove potential for these two things to be
cut and paste into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/bh1780.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/bh1780.c b/drivers/iio/light/bh1780.c
index a8361006dcd9..03f2d8d123c4 100644
--- a/drivers/iio/light/bh1780.c
+++ b/drivers/iio/light/bh1780.c
@@ -13,7 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/mod_devicetable.h>
 #include <linux/pm_runtime.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -273,13 +273,11 @@ static const struct i2c_device_id bh1780_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, bh1780_id);
 
-#ifdef CONFIG_OF
 static const struct of_device_id of_bh1780_match[] = {
 	{ .compatible = "rohm,bh1780gli", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, of_bh1780_match);
-#endif
 
 static struct i2c_driver bh1780_driver = {
 	.probe		= bh1780_probe,
@@ -288,7 +286,7 @@ static struct i2c_driver bh1780_driver = {
 	.driver = {
 		.name = "bh1780",
 		.pm = &bh1780_dev_pm_ops,
-		.of_match_table = of_match_ptr(of_bh1780_match),
+		.of_match_table = of_bh1780_match,
 	},
 };
 
-- 
2.26.1

