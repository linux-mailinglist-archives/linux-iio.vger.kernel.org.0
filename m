Return-Path: <linux-iio+bounces-1342-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A66E820C86
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 19:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CD6C1C20F6F
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 18:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7306F8F60;
	Sun, 31 Dec 2023 18:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zdbg8uaW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C568F74
	for <linux-iio@vger.kernel.org>; Sun, 31 Dec 2023 18:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE773C433C9;
	Sun, 31 Dec 2023 18:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704047729;
	bh=456AjWXLRjGpH4Z80fUU/qpPxrTXGxIFTQemgQjxU2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zdbg8uaWFNq8IESP0VCl/VWvrsAmpAypSN+L355KPpU2Y7/8XdMnqf0vQamqwWp8X
	 jmFiRiCO7ChpMaCoJD1W98D0LOoFWOXSYnCNhyMC/j0DCQJlsKwFxILf3WZJQRHJyk
	 LLjnYe1rnxGMbsVAwJAefXnR2mvO/Ru9/1AxkbGTT0f9a31X/ubzQOSN9S6YDGdYv4
	 f/W+M9pG1sBLJJHycVaoCmuwSP8KrX8TXrJvOdzfRv0ULFXKL5yHp8rEdhb/3mqca1
	 5BkpjE8Uel1HS5GYHAnU68m0POddr+ZoeIr4p/r6dkJCU/K9IhW8XZuNGiC/AtAAki
	 0H/MfZtap/VfA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 05/24] iio: accel: mxc4005: Drop ACPI_PTR() usage
Date: Sun, 31 Dec 2023 18:34:55 +0000
Message-ID: <20231231183514.566609-6-jic23@kernel.org>
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

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311181952.1usxCcup-lkp@intel.com/
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/mxc4005.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index 82e8d0b39049..8118cc13614a 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -8,7 +8,7 @@
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
-#include <linux/acpi.h>
+#include <linux/mod_devicetable.h>
 #include <linux/regmap.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
@@ -493,7 +493,7 @@ MODULE_DEVICE_TABLE(i2c, mxc4005_id);
 static struct i2c_driver mxc4005_driver = {
 	.driver = {
 		.name = MXC4005_DRV_NAME,
-		.acpi_match_table = ACPI_PTR(mxc4005_acpi_match),
+		.acpi_match_table = mxc4005_acpi_match,
 		.of_match_table = mxc4005_of_match,
 	},
 	.probe		= mxc4005_probe,
-- 
2.43.0


