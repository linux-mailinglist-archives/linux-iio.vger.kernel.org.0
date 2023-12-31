Return-Path: <linux-iio+bounces-1356-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D251D820C94
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 19:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 864C81F2103B
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 18:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD33946F;
	Sun, 31 Dec 2023 18:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLq3jwLC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19061AD25
	for <linux-iio@vger.kernel.org>; Sun, 31 Dec 2023 18:35:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262BCC433C8;
	Sun, 31 Dec 2023 18:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704047754;
	bh=QqqWuEipCzKVQESUlVNEUpvOqTx6euQIx4FtdGhGOkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NLq3jwLC0rx6F4wQO/9WH74s1UgFqYEdpH/j4i5H9hs26i0ATcAgWp63pCM8pwPKJ
	 mpM2CAF94dMcsINRLVckXRdCnF7sfJjtsB/2/XqBa4n7yNj3Zw36XFhc+uXDvUm/D/
	 k7oG9FGn1o99kgYv3BknMGM+HccM7IYX8+VT/0Pxa0OWgzg0zft9PIMwIAxQgvN35a
	 e0euH7yyM47TZsSES5vmCyYfh/hB+AUz5NhMpedzdDRZHCv6E2jmFzQzc7FmaR9jXi
	 KaWPikyL3D1IDq30Qk07rdVh9IeH5M0abkqbD4jTjWpRDuJykxF/cH/z+bMBMaTU0W
	 CPokx/XwAMalg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 19/24] iio: magnetometer: mmc35240: Drop ACPI_PTR() usage
Date: Sun, 31 Dec 2023 18:35:09 +0000
Message-ID: <20231231183514.566609-20-jic23@kernel.org>
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
 drivers/iio/magnetometer/mmc35240.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
index b495b8a63928..6b9f4b056191 100644
--- a/drivers/iio/magnetometer/mmc35240.c
+++ b/drivers/iio/magnetometer/mmc35240.c
@@ -10,11 +10,11 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
 #include <linux/regmap.h>
-#include <linux/acpi.h>
 #include <linux/pm.h>
 
 #include <linux/iio/iio.h>
@@ -573,7 +573,7 @@ static struct i2c_driver mmc35240_driver = {
 		.name = MMC35240_DRV_NAME,
 		.of_match_table = mmc35240_of_match,
 		.pm = pm_sleep_ptr(&mmc35240_pm_ops),
-		.acpi_match_table = ACPI_PTR(mmc35240_acpi_match),
+		.acpi_match_table = mmc35240_acpi_match,
 	},
 	.probe		= mmc35240_probe,
 	.id_table	= mmc35240_id,
-- 
2.43.0


