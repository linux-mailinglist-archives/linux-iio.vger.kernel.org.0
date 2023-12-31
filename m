Return-Path: <linux-iio+bounces-1355-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F00820C93
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 19:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76A9D1F20FAE
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 18:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2233F9449;
	Sun, 31 Dec 2023 18:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VE9q1i0e"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE55A9470
	for <linux-iio@vger.kernel.org>; Sun, 31 Dec 2023 18:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82420C433C7;
	Sun, 31 Dec 2023 18:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704047753;
	bh=gAjHpl35RhX0uaorrf0CmrQXx8Jcp6zuIYXWxXZ13/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VE9q1i0e+ENPU0mISqQhn1KRaXJO4GvtU9tyxL+mjdIV4+u+eOngq8Svx0wCQ9akp
	 6AGXhPLax62NZJ/+xQTmj/NYNCAtHrWu3aIaVIdKpM7SmASmuI0tvq9S1Y91Y1xxQR
	 uDa13jbXS65ZEC7HInJdc24O/7uDR/5vu0GNwMEOXEUQ6JivJxM5ILnW/n0tVLGPsv
	 tQNZHkHZjGJhfdW2qbU77OWNSg/NLfnm6QoMjf+dawFDiBaV8QGFZ50TxCwH7UmNVB
	 zFo8U/+hkV7f1rybo0A1Mo8VhsmlpD/OPABfcGZC9imqpKupTE5rPHsA0DTaHiCkZc
	 TI/ItKuytMeBg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 18/24] iio: magnetometer: bmc150: Drop ACPI_PTR() usage
Date: Sun, 31 Dec 2023 18:35:08 +0000
Message-ID: <20231231183514.566609-19-jic23@kernel.org>
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

Drop unused linux/acpi.h includes.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312040109.Csnmqnb2-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202311171116.47sUbZV5-lkp@intel.com/
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/magnetometer/bmc150_magn_i2c.c | 3 +--
 drivers/iio/magnetometer/bmc150_magn_spi.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn_i2c.c b/drivers/iio/magnetometer/bmc150_magn_i2c.c
index 281d1fa31c8e..48d9c698f520 100644
--- a/drivers/iio/magnetometer/bmc150_magn_i2c.c
+++ b/drivers/iio/magnetometer/bmc150_magn_i2c.c
@@ -11,7 +11,6 @@
 #include <linux/mod_devicetable.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
-#include <linux/acpi.h>
 #include <linux/regmap.h>
 
 #include "bmc150_magn.h"
@@ -68,7 +67,7 @@ static struct i2c_driver bmc150_magn_driver = {
 	.driver = {
 		.name	= "bmc150_magn_i2c",
 		.of_match_table = bmc150_magn_of_match,
-		.acpi_match_table = ACPI_PTR(bmc150_magn_acpi_match),
+		.acpi_match_table = bmc150_magn_acpi_match,
 		.pm	= &bmc150_magn_pm_ops,
 	},
 	.probe		= bmc150_magn_i2c_probe,
diff --git a/drivers/iio/magnetometer/bmc150_magn_spi.c b/drivers/iio/magnetometer/bmc150_magn_spi.c
index 882987721071..abc75a05c46a 100644
--- a/drivers/iio/magnetometer/bmc150_magn_spi.c
+++ b/drivers/iio/magnetometer/bmc150_magn_spi.c
@@ -10,7 +10,6 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/spi/spi.h>
-#include <linux/acpi.h>
 #include <linux/regmap.h>
 
 #include "bmc150_magn.h"
@@ -55,7 +54,7 @@ static struct spi_driver bmc150_magn_spi_driver = {
 	.remove		= bmc150_magn_spi_remove,
 	.id_table	= bmc150_magn_spi_id,
 	.driver = {
-		.acpi_match_table = ACPI_PTR(bmc150_magn_acpi_match),
+		.acpi_match_table = bmc150_magn_acpi_match,
 		.name	= "bmc150_magn_spi",
 	},
 };
-- 
2.43.0


