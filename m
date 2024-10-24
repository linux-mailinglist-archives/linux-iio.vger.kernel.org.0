Return-Path: <linux-iio+bounces-11235-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCE39AF27B
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 21:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BF00B234BF
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 19:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E756222A4BD;
	Thu, 24 Oct 2024 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aLUd6vlC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2E8228B62;
	Thu, 24 Oct 2024 19:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729797142; cv=none; b=tqrDrkC/Tnw7q/93Kb7s02279AHC8KePD+41zr+jhMdVAkgl9xGRhLmZ+R1mou9QfO8+y1mx/skPR9l5KO3i1yDhY/xcrosxOt1AwiTPeWpQFLhcWcre9atKkpGvMzYt+2XAxb5sp6v6DCr6LmkL5c4oE/ASKK0t33+PJR2AwU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729797142; c=relaxed/simple;
	bh=8sCpK1pd7nRUkCdMXWy4llb6XrvP6fxWrADB2+farzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fsxga8KoU9zEzbtuHlLVA/VdqJQRV9gH1f9BIKArRQixejMWqkiAVEFfwbfNpRw0WFvhr6FB64Ky/n8ZvrzNzvrkkR/ywuDmCGIN38wk/HxjVZCL/JHCbL4Vxkv9Qlp5R+2ckHvY0rpMsBymypQurK+q0v8aG+XRK/B8bsZ8MG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aLUd6vlC; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729797140; x=1761333140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8sCpK1pd7nRUkCdMXWy4llb6XrvP6fxWrADB2+farzU=;
  b=aLUd6vlCBWApooPx+k053YXnrK4vD7Z3YNGQ/zs9GkxX3FgnHzAMMOxx
   CfrOdjlrQa/k6xKe2/xdtWPXMDLQAAMQ0w6BbFcO8O+Jtck0qI4wviFiw
   ywX+LZGfG+eAsgJ+OJJWGW9IxJKs7ZhvQVUpNVOztq0X62MD4o1JQNufR
   Ea/zbgHW01ib5nza4GhhCA+BNh6/bnX0U13Cwjpm8nSrt0IybdAPSOJW0
   9vz3US7gq/x68cr087zBisrqnst+ayvdTRru+PIzDmVZhYajyCHfm/emq
   dNzoZkXUyASC2DD9bb0xY+wOJOXGgqKmqted9F6eNMosUIFy70y95cDHB
   w==;
X-CSE-ConnectionGUID: jcPN8I9FTNKDcW/9g6sc/w==
X-CSE-MsgGUID: 8YzzzbdbR5SPMh8jNKcgYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="46934542"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="46934542"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 12:12:12 -0700
X-CSE-ConnectionGUID: xEwNjSDTSG+s0b1HBxkeHw==
X-CSE-MsgGUID: UgyuPlXuTk67rQddw1vj4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="80266716"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 24 Oct 2024 12:12:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DA01480A; Thu, 24 Oct 2024 22:12:01 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 17/24] iio: accel: mma9551: Replace custom implementation of iio_get_acpi_device_name()
Date: Thu, 24 Oct 2024 22:05:06 +0300
Message-ID: <20241024191200.229894-18-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IIO core (ACPI part) provides a generic helper that may be used in
the driver. Replace custom implementation of iio_get_acpi_device_name().

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/mma9551.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index fa1799b0b0df..a5d20d8d08b8 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -4,11 +4,11 @@
  * Copyright (c) 2014, Intel Corporation.
  */
 
-#include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/slab.h>
-#include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/iio/iio.h>
@@ -435,17 +435,6 @@ static int mma9551_gpio_probe(struct iio_dev *indio_dev)
 	return 0;
 }
 
-static const char *mma9551_match_acpi_device(struct device *dev)
-{
-	const struct acpi_device_id *id;
-
-	id = acpi_match_device(dev->driver->acpi_match_table, dev);
-	if (!id)
-		return NULL;
-
-	return dev_name(dev);
-}
-
 static int mma9551_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
@@ -464,8 +453,8 @@ static int mma9551_probe(struct i2c_client *client)
 
 	if (id)
 		name = id->name;
-	else if (ACPI_HANDLE(&client->dev))
-		name = mma9551_match_acpi_device(&client->dev);
+	else
+		name = iio_get_acpi_device_name(&client->dev);
 
 	ret = mma9551_init(data);
 	if (ret < 0)
-- 
2.43.0.rc1.1336.g36b5255a03ac


