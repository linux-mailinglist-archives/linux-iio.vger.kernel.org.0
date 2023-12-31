Return-Path: <linux-iio+bounces-1344-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1975820C88
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 19:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FE07281C68
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 18:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F438F6F;
	Sun, 31 Dec 2023 18:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/UsHDp2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05DB944D
	for <linux-iio@vger.kernel.org>; Sun, 31 Dec 2023 18:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC14FC433C7;
	Sun, 31 Dec 2023 18:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704047733;
	bh=91/2rhnDMxfUbkLeoZq4Ko/Q2Z0itmXUS0QXoJH51mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B/UsHDp2+j0sPSbMiXSYyOTTcHdAkVsmeJGprbwbpeWw7ArL1szGm4/G/pOxSaiHn
	 dvzQV5DMkkkpaoTwdabh2MQLi+fyXuNev/6Rv15Yh/dmk3WKlQXc1xuXUwFEPRfcIS
	 DJJU+xMg6/0jcEwXMExNVsnXdvmUHKRWMQwTtSmN+FXqE03revAkoi9JHivPGGKJyn
	 WP81WcGJtR7EKdl2S/81Dc4WXFsaRPrH6XPsFBd0L2GH4CoFv5OxVVvMh06Tx/h3dR
	 OSdVxPTX0kFTS61mOipFa1BZxxTb4xDynHzYj146mhBeooOgwj2fTsrdpgVfTQAtLc
	 x7tj2P16bxPkQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 07/24] iio: accel: stk8ba50: Drop ACPI_PTR() usage
Date: Sun, 31 Dec 2023 18:34:57 +0000
Message-ID: <20231231183514.566609-8-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231183514.566609-1-jic23@kernel.org>
References: <20231231183514.566609-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Avoiding unused variable warnings when using this macro adds
complexity that in simple cases like this one is not justified
for the small saving in data.

Switch include to mod_devicetable.h as that contains the only
acpi specific definitions needed in this driver.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/stk8ba50.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index 3415ac1b4495..668edc88c89d 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -7,11 +7,11 @@
  * STK8BA50 7-bit I2C address: 0x18.
  */
 
-#include <linux/acpi.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -541,7 +541,7 @@ static struct i2c_driver stk8ba50_driver = {
 	.driver = {
 		.name = "stk8ba50",
 		.pm = pm_sleep_ptr(&stk8ba50_pm_ops),
-		.acpi_match_table = ACPI_PTR(stk8ba50_acpi_id),
+		.acpi_match_table = stk8ba50_acpi_id,
 	},
 	.probe =        stk8ba50_probe,
 	.remove =           stk8ba50_remove,
-- 
2.43.0


