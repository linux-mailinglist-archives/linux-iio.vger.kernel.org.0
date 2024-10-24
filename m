Return-Path: <linux-iio+bounces-11218-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F509AF259
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 21:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366E91F24717
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 19:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D4F21A716;
	Thu, 24 Oct 2024 19:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FmMbmyfl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0778218D7F;
	Thu, 24 Oct 2024 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729797132; cv=none; b=nSYlsfwLhAmY793vMWSJG4k6MzLznapyZMzqWfxUKWi8R/l7WrWsuhTFvEyuleO2Z1LoAbENV4suMkg9eTNLfBj8q4/b+iirAHJjhjkUd3VyB87rojQseFEdbgX1CzSQ77WHQcO11BKU1fBY1rGa7or1LbIoAUDg43SUP4SKbNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729797132; c=relaxed/simple;
	bh=DVlqFP9iROUJk4knJhx6hQhmkQUUT8UOd38cVvmpDIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqDgDEdL1CWdRH2RQV3e9c2amLz/J8exMtv9hGvXuCzBIkuQIpGOVvTqpdY+u0Auh80KEnMqk2pX6Soh0ilOUMHijiDP0sTWhzN7CVUc50FoAh3lKEIcZ0Z+fA3ezABsf0cI1Flrk71hsRDp+rr8u1unCUG/Xp8Q4ofMl7DbT6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FmMbmyfl; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729797130; x=1761333130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DVlqFP9iROUJk4knJhx6hQhmkQUUT8UOd38cVvmpDIY=;
  b=FmMbmyflLYnlKFcvPuYfudNn8qahnHto0GEGNyYW4pUDDrY8m85dnrSX
   75ck9pReD5oBddT/WD837CNtzN4z79JAO5cYUlZ4HJLsX9zp+4fFjbmRJ
   AMGHBIkYWRdNi9duShVw7FrzbRP4MgTsUvYJefcPyqoKiXYo2y7s4Bonv
   dv5q8mbVNqBP8ccnrg91nNjTyLCJPZBhha8T8+G9qkHlxEdip8j7qbMLu
   YKH/12u3RFwBINKVYa9tjiXjuySs3YnImLNSC5gR7C7a8Y/ZxmMFJjgGL
   QR/1d+E+G0R1Qu6cKeNqaYfmDtY2lS0gLGykV0SUKPd6zSbwvhLYnJFEo
   Q==;
X-CSE-ConnectionGUID: vt/0wLKfQ2iU6vMhsAoTWA==
X-CSE-MsgGUID: yibr+8RLQqSdnbQaYns2+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="46934433"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="46934433"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 12:12:08 -0700
X-CSE-ConnectionGUID: 8aP7BYO9QCS8h6gBtU5ZVg==
X-CSE-MsgGUID: g8pN/f6rS6+8l5ERb+xCfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="80266682"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 24 Oct 2024 12:12:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 74F91588; Thu, 24 Oct 2024 22:12:01 +0300 (EEST)
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
Subject: [PATCH v3 08/24] iio: accel: kxcjk-1013: Switch from CONFIG_PM guards to pm_ptr() etc
Date: Thu, 24 Oct 2024 22:04:57 +0300
Message-ID: <20241024191200.229894-9-andriy.shevchenko@linux.intel.com>
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

Letting the compiler remove these functions when the kernel is built
without CONFIG_PM support is simpler and less error prone than the
use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/kxcjk-1013.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 208e701e1aed..0cc34e17a23f 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -315,7 +315,7 @@ static const char *const kxtf9_samp_freq_avail =
 	"25 50 100 200 400 800";
 
 /* Refer to section 4 of the specification */
-static __maybe_unused const struct {
+static const struct {
 	int odr_bits;
 	int usec;
 } odr_start_up_times[KX_MAX_CHIPS][12] = {
@@ -601,7 +601,6 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
 	return 0;
 }
 
-#ifdef CONFIG_PM
 static int kxcjk1013_get_startup_times(struct kxcjk1013_data *data)
 {
 	int i;
@@ -614,7 +613,6 @@ static int kxcjk1013_get_startup_times(struct kxcjk1013_data *data)
 
 	return KXCJK1013_MAX_STARTUP_TIME_US;
 }
-#endif
 
 static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
 {
@@ -1636,7 +1634,6 @@ static void kxcjk1013_remove(struct i2c_client *client)
 	mutex_unlock(&data->mutex);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int kxcjk1013_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -1664,9 +1661,7 @@ static int kxcjk1013_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
-#ifdef CONFIG_PM
 static int kxcjk1013_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -1700,12 +1695,10 @@ static int kxcjk1013_runtime_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops kxcjk1013_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(kxcjk1013_suspend, kxcjk1013_resume)
-	SET_RUNTIME_PM_OPS(kxcjk1013_runtime_suspend,
-			   kxcjk1013_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(kxcjk1013_suspend, kxcjk1013_resume)
+	RUNTIME_PM_OPS(kxcjk1013_runtime_suspend, kxcjk1013_runtime_resume, NULL)
 };
 
 static const struct i2c_device_id kxcjk1013_id[] = {
@@ -1734,7 +1727,7 @@ static struct i2c_driver kxcjk1013_driver = {
 		.name	= KXCJK1013_DRV_NAME,
 		.acpi_match_table = ACPI_PTR(kx_acpi_match),
 		.of_match_table = kxcjk1013_of_match,
-		.pm	= &kxcjk1013_pm_ops,
+		.pm	= pm_ptr(&kxcjk1013_pm_ops),
 	},
 	.probe		= kxcjk1013_probe,
 	.remove		= kxcjk1013_remove,
-- 
2.43.0.rc1.1336.g36b5255a03ac


