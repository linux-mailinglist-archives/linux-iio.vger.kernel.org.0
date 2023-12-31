Return-Path: <linux-iio+bounces-1353-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68486820C91
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 19:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 095021F21DD2
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 18:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE77AD32;
	Sun, 31 Dec 2023 18:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FU20b2V+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672D7947A
	for <linux-iio@vger.kernel.org>; Sun, 31 Dec 2023 18:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2E3C433C8;
	Sun, 31 Dec 2023 18:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704047749;
	bh=wY8Wk3PVZiVMJs5dhjyfFPaFpSBNAGpPuDZe380g8/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FU20b2V+wr3keFwihZdXr6WIHICr3rkbehi96KgxGdwl4xuL4fR63qmWPODLLuqzk
	 fEUvk/qipEenuLg/lhcKzOH4RZSnfzX857nVg6/YxO7DzfsQhMM2EpGdPiaeCwrwSs
	 Qbldvt+ktr00GJyA6zzuGcduiTs67eoiQSQfWxtedWyIlnkRa+Am3WJ4EsL0Ksj7mB
	 BcS+BG2oxBgd5pfEzb2auooui6RUFsUc1bx9fRfP9PNm5hsiZ2rzqb53Nv2Dhd2agR
	 /EwwoWhoXc1SsY56e+a4QH6y346aJIl4xYbkb1XiHkI2HSYlO9RwN7MvA0vxUTyM2/
	 3RXLT7jGilIuw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 16/24] iio: light: stk3310: Drop ACPI_PTR() usage
Date: Sun, 31 Dec 2023 18:35:06 +0000
Message-ID: <20231231183514.566609-17-jic23@kernel.org>
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

Switch include from acpi.h to mod_devicetable.h which includes the
definition of struct acpi_device_id.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
The report I can immediately find is in a much larger set of unrelated errors
hence no closes tag.
---
 drivers/iio/light/stk3310.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 72b08d870d33..7b71ad71d78d 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -7,11 +7,11 @@
  * IIO driver for STK3310/STK3311. 7-bit I2C address: 0x48.
  */
 
-#include <linux/acpi.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/regmap.h>
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
@@ -712,7 +712,7 @@ static struct i2c_driver stk3310_driver = {
 		.name = "stk3310",
 		.of_match_table = stk3310_of_match,
 		.pm = pm_sleep_ptr(&stk3310_pm_ops),
-		.acpi_match_table = ACPI_PTR(stk3310_acpi_id),
+		.acpi_match_table = stk3310_acpi_id,
 	},
 	.probe =        stk3310_probe,
 	.remove =           stk3310_remove,
-- 
2.43.0


