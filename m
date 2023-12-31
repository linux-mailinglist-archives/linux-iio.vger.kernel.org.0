Return-Path: <linux-iio+bounces-1360-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC83820C97
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 19:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E27B1F20EEB
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 18:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D919471;
	Sun, 31 Dec 2023 18:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lncGjpmy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225219449
	for <linux-iio@vger.kernel.org>; Sun, 31 Dec 2023 18:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317B1C433C9;
	Sun, 31 Dec 2023 18:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704047762;
	bh=pgtJ2HP5ytDsie/NpUvjS4mrbcfUcJ7DEBGfRsrjUok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lncGjpmy884oFhMe8gj+b5SxItuzN2qdCwKHrbk+EL7LwXhkM3GibnzUFmx2Nr4Yh
	 YawIU8BMLyE40U8NcZlsfyQUDrw8xwX2ZE5roQLXR1UIMgd3Lv1N5JCgEcEiLCUDLG
	 yfbuedgPH4v6ldxrj9wQOxcMvHP6WgErrEKXYruYD5rGEyOtkO8DNUidLSSNhI1myi
	 lihTO9wI4WVAR19lQbY2ulJwVMaA2hHJWYC73nxj09S3RagkY4YKQl78LJnoSo1QDF
	 ku8YYFRp38jsi9MSbISdomt5BsSzuIkkQTysCcVFhOQAT1HJW3D1xMFU7xUfk6EUS5
	 MOgx6zwVF6WpA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 23/24] iio: light: max44000: drop ACPI_PTR() and CONFIG_ACPI guards
Date: Sun, 31 Dec 2023 18:35:13 +0000
Message-ID: <20231231183514.566609-24-jic23@kernel.org>
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

The complexity of config guards needed for ACPI_PTR() is not worthwhile
for the small amount of saved data. This example was doing it correctly
but I am proposing dropping this so as to reduce chance of cut and paste
where it is done wrong.  Also drop now unneeded linux/acpi.h include and
added linux/mod_devicetable.h for struct acpi_device_id definition.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/max44000.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
index db96c5b73100..26b464b1b650 100644
--- a/drivers/iio/light/max44000.c
+++ b/drivers/iio/light/max44000.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
 #include <linux/regmap.h>
@@ -19,7 +20,6 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
-#include <linux/acpi.h>
 
 #define MAX44000_DRV_NAME		"max44000"
 
@@ -603,18 +603,16 @@ static const struct i2c_device_id max44000_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, max44000_id);
 
-#ifdef CONFIG_ACPI
 static const struct acpi_device_id max44000_acpi_match[] = {
 	{"MAX44000", 0},
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, max44000_acpi_match);
-#endif
 
 static struct i2c_driver max44000_driver = {
 	.driver = {
 		.name	= MAX44000_DRV_NAME,
-		.acpi_match_table = ACPI_PTR(max44000_acpi_match),
+		.acpi_match_table = max44000_acpi_match,
 	},
 	.probe		= max44000_probe,
 	.id_table	= max44000_id,
-- 
2.43.0


