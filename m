Return-Path: <linux-iio+bounces-2440-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E78F3850B64
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 21:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 873181F23618
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 20:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A91F5F484;
	Sun, 11 Feb 2024 20:15:40 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BAE5EE92
	for <linux-iio@vger.kernel.org>; Sun, 11 Feb 2024 20:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707682540; cv=none; b=nbUP7q+rEAzczT7MGQ4TNds9clXEOSs9aygtSdgBZLTLcAgdf86UNjsycFU2yV5au4xEp72HgSk1HRmMIdTLfak4lL7FMvJqaB5eLjBWUJT4y3sPtCIZgIaQ/FJDAOinFFJvdq0aWnvJmO6j/vvb8utfrd4wYZCGahz2j9GIZ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707682540; c=relaxed/simple;
	bh=ZrHIuQSM8iDm77EAadM1fDiTchD/AxV8beVPT6IGqLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GlYLuElBB8FtlfRoF1Th6Ea/wdPq/3PMJSUghIVVIVLtsVIV0t4VOLnK0VoXbP6rrDeie+5nvjdZ5MKSxSdYKxlMete5GuSaVVwympJyCFp+F6pOSB5fTNuqf1X/AOGycs1EBSb0kkJ3BMrWkE4H0BAHgwD9NFfAQSNM5vQ5SZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 4e07fa90-c91a-11ee-abf4-005056bdd08f;
	Sun, 11 Feb 2024 22:15:31 +0200 (EET)
From: andy.shevchenko@gmail.com
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Marius Hoch <mail@mariushoch.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 2/3] iio: st_sensors: lsm9ds0: Don't use "proxy" headers
Date: Sun, 11 Feb 2024 22:14:33 +0200
Message-ID: <20240211201526.1518165-3-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240211201526.1518165-1-andy.shevchenko@gmail.com>
References: <20240211201526.1518165-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use)
principle.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h      | 5 ++++-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c | 4 ++--
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c  | 4 +++-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c  | 4 +++-
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h
index 76678cdefb07..e67d31b48441 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h
@@ -4,9 +4,12 @@
 #ifndef ST_LSM9DS0_H
 #define ST_LSM9DS0_H
 
-struct iio_dev;
+struct device;
+struct regmap;
 struct regulator;
 
+struct iio_dev;
+
 struct st_lsm9ds0 {
 	struct device *dev;
 	const char *name;
diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
index 7b9dc849f010..10c1b2ba7a3d 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
@@ -7,10 +7,10 @@
  * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  */
 
-#include <linux/device.h>
+#include <linux/array_size.h>
+#include <linux/dev_printk.h>
 #include <linux/err.h>
 #include <linux/module.h>
-#include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
 #include <linux/iio/common/st_sensors.h>
diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
index 61d855083aa0..ab8504286ba4 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
@@ -7,8 +7,10 @@
  * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  */
 
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gfp_types.h>
 #include <linux/i2c.h>
-#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/regmap.h>
diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
index 8cc041d56cf7..69e9135795a3 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
@@ -7,7 +7,9 @@
  * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  */
 
-#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gfp_types.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/regmap.h>
-- 
2.43.0


