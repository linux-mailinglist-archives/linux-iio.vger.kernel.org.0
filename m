Return-Path: <linux-iio+bounces-1346-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3023820C8A
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 19:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429931F21DF2
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 18:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8539470;
	Sun, 31 Dec 2023 18:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qzvaj+eT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682C59449
	for <linux-iio@vger.kernel.org>; Sun, 31 Dec 2023 18:35:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE9DC433C7;
	Sun, 31 Dec 2023 18:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704047736;
	bh=zWlhy6ZNkjB3qcJbh53BaTcO2Nf62ujM4U2RDSpLLfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qzvaj+eT6yIhjElsWQ7kqjJGNGf6we06zq8hLilTcDxmA6IvF5DLPbGyJQMpTCnRc
	 683erOUkjfFHpNRM2VNC8wdRhfsF3FTWP0kDMNhULdI3jmboAlVVIJVBCAD7DT82Pg
	 5Sf3X+IRhSzPQnSGgxHZrArn3MqnOYWs98iaDgJxiDmRD75ZltJ1DRYJr2sxDhjaah
	 cRwtSHAV+p5yrn6nM8ALV7NtkAQ5J5sQuqG8Od/+YEr6xCXWZQmo11fLxwrp4UsHWM
	 qG164BWsVf+M45f9K89y9vor+VzWrdvA+uZEKkZNYTjrbUGBuOOferQaapMq7bi4qb
	 1vm5RoDbcdWjQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH 09/24] iio: gyro: bmg160: Drop ACPI_PTR() usage
Date: Sun, 31 Dec 2023 18:34:59 +0000
Message-ID: <20231231183514.566609-10-jic23@kernel.org>
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
Cc: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/iio/gyro/bmg160_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/gyro/bmg160_i2c.c b/drivers/iio/gyro/bmg160_i2c.c
index 2f9675596138..9c8e20c25e96 100644
--- a/drivers/iio/gyro/bmg160_i2c.c
+++ b/drivers/iio/gyro/bmg160_i2c.c
@@ -3,7 +3,7 @@
 #include <linux/regmap.h>
 #include <linux/iio/iio.h>
 #include <linux/module.h>
-#include <linux/acpi.h>
+#include <linux/mod_devicetable.h>
 
 #include "bmg160.h"
 
@@ -66,7 +66,7 @@ MODULE_DEVICE_TABLE(of, bmg160_of_match);
 static struct i2c_driver bmg160_i2c_driver = {
 	.driver = {
 		.name	= "bmg160_i2c",
-		.acpi_match_table = ACPI_PTR(bmg160_acpi_match),
+		.acpi_match_table = bmg160_acpi_match,
 		.of_match_table = bmg160_of_match,
 		.pm	= &bmg160_pm_ops,
 	},
-- 
2.43.0


