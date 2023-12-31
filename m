Return-Path: <linux-iio+bounces-1345-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BACF9820C89
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 19:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768D5281F9D
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 18:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1340946F;
	Sun, 31 Dec 2023 18:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UH2Xm/Cf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C899944B
	for <linux-iio@vger.kernel.org>; Sun, 31 Dec 2023 18:35:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2A4C433C9;
	Sun, 31 Dec 2023 18:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704047735;
	bh=Fy0gIq8SLn8DScjo7AXzO7QcZGedQ53QEqk6TGyvWIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UH2Xm/CfX+rQze6XYJkPLRfzmdYQV1wUBQhKUSdWu+zn2BF7zFsTdPt/k3jPE+H7Z
	 1N7hL94zUrykkMBPnoRLN20vrfDUhKXAKkoeP3S7Q4Q7mHwxr8HXhpxFwGi5cVlNUx
	 mOesAPRa2kXw5CkHLfF7fXe25MnwWLDq33t8beDgYuXDQ1VKTNlv74/u0CYs+DYfr0
	 WqQSzSWyIMZ+P3HqI9ZaA4aDJtc63q+JUxuLavlRoHqRmE5iE1IvtJrQZVM96BFobj
	 2RjbJlRQHVEVFlsesEbK9ENG/Zm1veai+FuPM95p907oAgqDGyUlj2EUkJXS+YN2H3
	 cn8ESJWB7qM3A==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 08/24] iio: accel: bmc150: Drop ACPI_PTR()
Date: Sun, 31 Dec 2023 18:34:58 +0000
Message-ID: <20231231183514.566609-9-jic23@kernel.org>
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

In general the complexity of avoiding maybe unused variable warnings is
not worth dealing with for the small amount of data saved. In thie
case, the i2c driver does include some other code under a CONFIG_ACPI
guard but remove the ACPI_PTR() usage anyway to bring keep it inline
with the spi driver.

Drop include of linux/acpi.h in the spi driver that doesn't need
it as struct acpi_device_id is defined in mod_devicetable.h which
is already included.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/bmc150-accel-i2c.c | 2 +-
 drivers/iio/accel/bmc150-accel-spi.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
index ee1ba134ad42..f08594b372cf 100644
--- a/drivers/iio/accel/bmc150-accel-i2c.c
+++ b/drivers/iio/accel/bmc150-accel-i2c.c
@@ -266,7 +266,7 @@ static struct i2c_driver bmc150_accel_driver = {
 	.driver = {
 		.name	= "bmc150_accel_i2c",
 		.of_match_table = bmc150_accel_of_match,
-		.acpi_match_table = ACPI_PTR(bmc150_accel_acpi_match),
+		.acpi_match_table = bmc150_accel_acpi_match,
 		.pm	= &bmc150_accel_pm_ops,
 	},
 	.probe		= bmc150_accel_probe,
diff --git a/drivers/iio/accel/bmc150-accel-spi.c b/drivers/iio/accel/bmc150-accel-spi.c
index 921fb46be0b8..a6b9f599eb7b 100644
--- a/drivers/iio/accel/bmc150-accel-spi.c
+++ b/drivers/iio/accel/bmc150-accel-spi.c
@@ -7,7 +7,6 @@
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/acpi.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
 
@@ -70,7 +69,7 @@ MODULE_DEVICE_TABLE(spi, bmc150_accel_id);
 static struct spi_driver bmc150_accel_driver = {
 	.driver = {
 		.name	= "bmc150_accel_spi",
-		.acpi_match_table = ACPI_PTR(bmc150_accel_acpi_match),
+		.acpi_match_table = bmc150_accel_acpi_match,
 		.pm	= &bmc150_accel_pm_ops,
 	},
 	.probe		= bmc150_accel_probe,
-- 
2.43.0


