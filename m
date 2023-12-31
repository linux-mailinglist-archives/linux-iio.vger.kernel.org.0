Return-Path: <linux-iio+bounces-1348-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4F4820C8C
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 19:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D58281F82
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 18:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685DD8F6F;
	Sun, 31 Dec 2023 18:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ik3DvDbN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C7E946F
	for <linux-iio@vger.kernel.org>; Sun, 31 Dec 2023 18:35:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F008C433C7;
	Sun, 31 Dec 2023 18:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704047740;
	bh=uwn1TUxZOUiSXjc/bFfi+mAKWflhsH6WURAePKltE6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ik3DvDbNB0A7nHOR8x9NRjealwWXTz3pGrrm4CODOii7HW+5X+YMmJsKCQMhXxkAx
	 FUUOnZAlYyZM0st394Zd/sQtT/Jal0RU7Ohm6pEQ1xqHOGEjSAq2PVKZEPV/JySkD+
	 C411t2XFaq3uss9Ygw1UNb3ZWV83N+VJW3CRMH+RYyFqwzKfvEECUgUtK9aNi5WlJB
	 e4/qfMsFl8pvKDdvOcVY6yW0JxG09M6GFPPtjngYYJqMZ5QHNso1ori1ArzF72o7KH
	 OQK+Qs/kLS9DgSckInA/6O2W9f/C9RbY/atXz7BstY7Fcyy+dXoSUwaLeS1/T2rdER
	 6tLxmpajr2jAA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	kernel test robot <lkp@intel.com>,
	Carlos Song <carlos.song@nxp.com>
Subject: [PATCH 11/24] iio: imu: fxos8700: Drop ACPI_PTR() usage
Date: Sun, 31 Dec 2023 18:35:01 +0000
Message-ID: <20231231183514.566609-12-jic23@kernel.org>
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

Drop unused acpi.h include.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311231427.vEQAuxvI-lkp@intel.com/
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Carlos Song <carlos.song@nxp.com>
---
 drivers/iio/imu/fxos8700_i2c.c | 3 +--
 drivers/iio/imu/fxos8700_spi.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/fxos8700_i2c.c b/drivers/iio/imu/fxos8700_i2c.c
index 2ace306d0f9a..e99677ad96a2 100644
--- a/drivers/iio/imu/fxos8700_i2c.c
+++ b/drivers/iio/imu/fxos8700_i2c.c
@@ -10,7 +10,6 @@
  *      1    |  0    |  0x1C
  *      1    |  1    |  0x1F
  */
-#include <linux/acpi.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
@@ -57,7 +56,7 @@ MODULE_DEVICE_TABLE(of, fxos8700_of_match);
 static struct i2c_driver fxos8700_i2c_driver = {
 	.driver = {
 		.name                   = "fxos8700_i2c",
-		.acpi_match_table       = ACPI_PTR(fxos8700_acpi_match),
+		.acpi_match_table       = fxos8700_acpi_match,
 		.of_match_table         = fxos8700_of_match,
 	},
 	.probe          = fxos8700_i2c_probe,
diff --git a/drivers/iio/imu/fxos8700_spi.c b/drivers/iio/imu/fxos8700_spi.c
index 27e694cce173..6b0dc7a776b9 100644
--- a/drivers/iio/imu/fxos8700_spi.c
+++ b/drivers/iio/imu/fxos8700_spi.c
@@ -2,7 +2,6 @@
 /*
  * FXOS8700 - NXP IMU, SPI bits
  */
-#include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/regmap.h>
@@ -46,7 +45,7 @@ static struct spi_driver fxos8700_spi_driver = {
 	.probe          = fxos8700_spi_probe,
 	.id_table       = fxos8700_spi_id,
 	.driver = {
-		.acpi_match_table       = ACPI_PTR(fxos8700_acpi_match),
+		.acpi_match_table       = fxos8700_acpi_match,
 		.of_match_table         = fxos8700_of_match,
 		.name                   = "fxos8700_spi",
 	},
-- 
2.43.0


