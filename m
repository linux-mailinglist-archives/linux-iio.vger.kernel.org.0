Return-Path: <linux-iio+bounces-1359-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A8B820C98
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 19:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08589B20DCB
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 18:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B274B645;
	Sun, 31 Dec 2023 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+J1Eeej"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E992E9449
	for <linux-iio@vger.kernel.org>; Sun, 31 Dec 2023 18:36:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E5DC433C8;
	Sun, 31 Dec 2023 18:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704047760;
	bh=rQ2Uddv0tF3IE2PFgll/8V/KdM/+WNckGYfiCppXnm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a+J1EeejJXgNbVEFa45ZbK6c+wB9RONTMIXWoNUeEg6VUDmH7RJuP/C17VsJ6QM2Z
	 7vuGjgNz4wRDc3Wp3wPGE6mFTE98KxnyX2jZsVeTQG/GLJj0YA+A3GEsvJZ9Gpv/2z
	 s2UHCw8t+owt4z8Nso3vGUVb5rykPtXC2DnoT9UDhUjNs+nG0h8jm+VWaWGcz/ETGL
	 ICeI4WsFajhLK6JabwWA/LmmZxGI4bb+mpyFp/72c3q5slcupSoMUvD/xsN7LbPvhe
	 eVQPO769+S2Fa7uN7dcpTu03PMeh/VHEvkdneq7WFVb0DoYD5jwlamQGZtB0qu4EH8
	 AN4rqVovszvjg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 22/24] iio: pressure: hp206c: drop ACPI_PTR() and CONFIG_ACPI guards
Date: Sun, 31 Dec 2023 18:35:12 +0000
Message-ID: <20231231183514.566609-23-jic23@kernel.org>
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
 drivers/iio/pressure/hp206c.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/hp206c.c b/drivers/iio/pressure/hp206c.c
index a072de6cb59c..261af1562827 100644
--- a/drivers/iio/pressure/hp206c.c
+++ b/drivers/iio/pressure/hp206c.c
@@ -11,12 +11,12 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/delay.h>
 #include <linux/util_macros.h>
-#include <linux/acpi.h>
 
 #include <asm/unaligned.h>
 
@@ -400,20 +400,18 @@ static const struct i2c_device_id hp206c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, hp206c_id);
 
-#ifdef CONFIG_ACPI
 static const struct acpi_device_id hp206c_acpi_match[] = {
 	{"HOP206C", 0},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, hp206c_acpi_match);
-#endif
 
 static struct i2c_driver hp206c_driver = {
 	.probe = hp206c_probe,
 	.id_table = hp206c_id,
 	.driver = {
 		.name = "hp206c",
-		.acpi_match_table = ACPI_PTR(hp206c_acpi_match),
+		.acpi_match_table = hp206c_acpi_match,
 	},
 };
 
-- 
2.43.0


