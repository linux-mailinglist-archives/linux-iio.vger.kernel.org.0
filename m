Return-Path: <linux-iio+bounces-1352-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 034C4820C90
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 19:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3F04281CA4
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 18:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746939471;
	Sun, 31 Dec 2023 18:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fj0voqZn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5AF946F
	for <linux-iio@vger.kernel.org>; Sun, 31 Dec 2023 18:35:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477F8C433C7;
	Sun, 31 Dec 2023 18:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704047748;
	bh=cyCRz59QJCpgqOottnhsRenKeKV6/ecrahYphOrQYWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fj0voqZnUlSf2yzCWyiGlorqcR7nSTTzbAaOQUm97Y+x5g5xb+9SYo/B524V4L4qX
	 X9VoC/67dgfpENo9Og6pIbHwHqKtB2tgRORoad5xB+SUIep9ksJntjhXyHYo+QNwvL
	 RMwERsRH9Z5qHQX0ZNofygOeYxyOze6YzUxIAB+U1WvFB9u45e7A0lmujo4xh/WAlv
	 6roHHL+BYYDB2q0ZikoWepTFYoYlOR2kJuplHJ1Wkt9jN046cKDz2gEh4MDR2vryVs
	 hMMKKXo6n67j4BvN3S5Am7DTmQ2j9icXFW8S/CYT3ZCCls7+cR7uF+ujEl38iyP0ZC
	 pgqYQMWy94y/g==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 15/24] iio: light: rpr0521: Drop ACPI_PTR() usage
Date: Sun, 31 Dec 2023 18:35:05 +0000
Message-ID: <20231231183514.566609-16-jic23@kernel.org>
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

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/rpr0521.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index bbb8581622f2..40d5732b5e32 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -10,11 +10,11 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
 #include <linux/regmap.h>
 #include <linux/delay.h>
-#include <linux/acpi.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
@@ -1119,7 +1119,7 @@ static struct i2c_driver rpr0521_driver = {
 	.driver = {
 		.name	= RPR0521_DRV_NAME,
 		.pm	= pm_ptr(&rpr0521_pm_ops),
-		.acpi_match_table = ACPI_PTR(rpr0521_acpi_match),
+		.acpi_match_table = rpr0521_acpi_match,
 	},
 	.probe		= rpr0521_probe,
 	.remove		= rpr0521_remove,
-- 
2.43.0


