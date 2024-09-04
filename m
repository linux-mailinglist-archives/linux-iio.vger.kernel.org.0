Return-Path: <linux-iio+bounces-9151-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AC396C6A6
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 20:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92B50B20BCB
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 18:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1071E4107;
	Wed,  4 Sep 2024 18:45:53 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BA041C6D
	for <linux-iio@vger.kernel.org>; Wed,  4 Sep 2024 18:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725475553; cv=none; b=GtubVyFVGhYSCWSISuqZkAFlCi5NXdIR3XfHoklJnh4c9pVrhah55vGHGGSiDYtfURw/0EJc5xf2ODqfasYmiDo9ic1e0WDV02tz83c9cFF53+aIHdIrDFBOnH8axBp1834wghFvIuakAa56t9o0zJHXw3181SOMxgD86phv6Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725475553; c=relaxed/simple;
	bh=ju5c2JcKzafSYkNLjzrCOJ9FC4i2ixivDaI3ty1dn68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TFLFJm7Nli3vRLLjM2Z3zKE7kFhmF4cLIHGOClU0ZETZV0wm1V2t3fjOTJZKiXm0xRBFGp0ZW6EZxDuwLovm7uoVmmHD0VMGplXXiBGABwve7Xb/PVWMsGXOKYJgSZB2LO75zhRMzt3yzw6x41msfqeHyN6pVleWUh0LdNfSfDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id e42f4ce3-6aed-11ef-abaf-005056bdd08f;
	Wed, 04 Sep 2024 21:45:44 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/1] iio: imu: inv_mpu6050: Use upper_16_bits()/lower_16_bits() helpers
Date: Wed,  4 Sep 2024 21:45:43 +0300
Message-ID: <20240904184543.1219866-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use upper_16_bits()/lower_16_bits() helpers instead of open-coding them.
This is easier to scan quickly compared to bitwise manipulation, and
it is pleasingly symmetric.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
index f7bce428d9eb..b15d8c94cc11 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
@@ -10,6 +10,8 @@
 #include <linux/i2c.h>
 #include <linux/dmi.h>
 #include <linux/acpi.h>
+#include <linux/wordpart.h>
+
 #include "inv_mpu_iio.h"
 
 enum inv_mpu_product_name {
@@ -118,8 +120,8 @@ static int inv_mpu_process_acpi_config(struct i2c_client *client,
 		return ret;
 
 	acpi_dev_free_resource_list(&resources);
-	*primary_addr = i2c_addr & 0x0000ffff;
-	*secondary_addr = (i2c_addr & 0xffff0000) >> 16;
+	*primary_addr = lower_16_bits(i2c_addr);
+	*secondary_addr = upper_16_bits(i2c_addr);
 
 	return 0;
 }
-- 
2.46.0


