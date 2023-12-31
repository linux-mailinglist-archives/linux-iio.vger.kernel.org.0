Return-Path: <linux-iio+bounces-1343-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F44820C87
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 19:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36656281CAA
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 18:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28B753BE;
	Sun, 31 Dec 2023 18:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/eFhfKq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF2E63B9
	for <linux-iio@vger.kernel.org>; Sun, 31 Dec 2023 18:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E54DC433C7;
	Sun, 31 Dec 2023 18:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704047732;
	bh=NcYuJqGkvepwidYq1uxd1HYYL1S8OOKNcD4Mn3XYMAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e/eFhfKqeeYpSKDL3nEPf4q3OfzE7ddjlGLxfc9dpDxWTcX7+9YFn2M6ObLcPXUGO
	 zzqgJ0p4QaMDC2gM6OqMeoxtF5f7h1cg6cukNKwa/8u24u3mccPOiAHCiznhpMtgwE
	 ssbIw0gJQvmvEjYnYUpp730NrhIr/M7Epky+ZEp+tT+yxLafZbB6HwhG8w82z2b7Cp
	 BFnGn59Jrx8AlpGaSc1idpnGqV5qVwZ7ftsFRaQoHAz6Vz/Lt+NIfHKPeAzTSMVr37
	 mWOrLEXhW7Z/SozZHzVLwMmWzuyxPkVwVfhSg5MnYWt6VsE8dC/aD+66HLuWA+fxa3
	 UwvTjN29lmJxQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 06/24] iio: accel: mxc6255: Drop ACPI_PTR() usage
Date: Sun, 31 Dec 2023 18:34:56 +0000
Message-ID: <20231231183514.566609-7-jic23@kernel.org>
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
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
I can only find this one reported in a much larger build report
(where it was noise) so no obvious closes tag to use.
---
 drivers/iio/accel/mxc6255.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/mxc6255.c b/drivers/iio/accel/mxc6255.c
index 33c2253561e6..ac228128c4f9 100644
--- a/drivers/iio/accel/mxc6255.c
+++ b/drivers/iio/accel/mxc6255.c
@@ -12,7 +12,7 @@
 #include <linux/init.h>
 #include <linux/iio/iio.h>
 #include <linux/delay.h>
-#include <linux/acpi.h>
+#include <linux/mod_devicetable.h>
 #include <linux/regmap.h>
 #include <linux/iio/sysfs.h>
 
@@ -181,7 +181,7 @@ MODULE_DEVICE_TABLE(i2c, mxc6255_id);
 static struct i2c_driver mxc6255_driver = {
 	.driver = {
 		.name = MXC6255_DRV_NAME,
-		.acpi_match_table = ACPI_PTR(mxc6255_acpi_match),
+		.acpi_match_table = mxc6255_acpi_match,
 	},
 	.probe		= mxc6255_probe,
 	.id_table	= mxc6255_id,
-- 
2.43.0


