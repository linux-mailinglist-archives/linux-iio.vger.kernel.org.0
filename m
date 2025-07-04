Return-Path: <linux-iio+bounces-21328-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FEEAF8A84
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 10:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D28A3A6451
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 08:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C4E2DAFA6;
	Fri,  4 Jul 2025 07:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnx02pyy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170192D879A;
	Fri,  4 Jul 2025 07:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615671; cv=none; b=EzfhJTDvYwPc/tPE8KyTVvV9ps93n7Rh1twoJ1awkdNac+OQo/P+9CdLF/f7BuSc3+LwwMQvBxS/rVTDnguMv1GlTSnliBYcIGWXk/nRfQZ7i88ZnFFXvP0OBUGMqp3tiiOrWr16nH3UG6wsMuVjhJxLaM+MXMc/fc6x2uHh/A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615671; c=relaxed/simple;
	bh=DN1KFlObEouhcuoe+jy028IdoQid+nHGeBZgjV8M6aI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ujkisZVA8/ti/rP7RCQOMxHN9pX75fbN3yLsfNStuj+WupxhcMFk3EJm/RT9xn0V1tVm5X6rtYCmc5iMOsBTo8Bt83QZPWCWrjEDnw0KSzepEjGRpVE0SvxqozIgPYpFRfwKDD80fjt2yfpJ5od+xSpMm+b2g/c27r843HJxl3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dnx02pyy; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751615669; x=1783151669;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DN1KFlObEouhcuoe+jy028IdoQid+nHGeBZgjV8M6aI=;
  b=dnx02pyyGZjvb9vjoPd3HFt5B/04xKQ7kPKIma/b17FYj3a1zXilg/du
   pBwM7BywjcRBw+qHo06f5LqUvHt3U3DnxnDfU5HoVYgFbdUGJWLp7nOd1
   FUlB+O46YIsfZN4Kt/ZjXKx76dz7Y8E1ycrfT8f/r1xWz3PQx/6UUuBy5
   3xnTshC4pHazudFH6hf5UmIBE0MvQ76rqk2j5l+0iZP78smu/9Tyc5snC
   66eKJsE/ivbjGW29b/NjoFSL/m8tEXMtlSvV8uVxnLOvBE/zLPAzrdvE3
   w8i7MONLRNTHQ40BTbyG0qiIlwIvtHvn+UPIZS9wWBXZOouV5pVhauBQt
   Q==;
X-CSE-ConnectionGUID: VkkZyOJNRIiLSfpR7NEgFA==
X-CSE-MsgGUID: hvDQYDVcSkWLfJL9c0Uyng==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="76494674"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="76494674"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:28 -0700
X-CSE-ConnectionGUID: XH/YptOcQOKsZp63w+c0Aw==
X-CSE-MsgGUID: 3SB//a+nR0qZR4dIqGDWvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="158924274"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO svinhufvud.fi.intel.com) ([10.245.244.244])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:25 -0700
Received: from svinhufvud.lan (localhost [IPv6:::1])
	by svinhufvud.fi.intel.com (Postfix) with ESMTP id 4316044419;
	Fri,  4 Jul 2025 10:54:23 +0300 (EEST)
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Julien Stephan <jstephan@baylibre.com>,
	Hans de Goede <hansg@kernel.org>,
	Waqar Hameed <waqar.hameed@axis.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 32/80] iio: gyro: Remove redundant pm_runtime_mark_last_busy() calls
Date: Fri,  4 Jul 2025 10:54:22 +0300
Message-Id: <20250704075422.3219401-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
pm_runtime_mark_last_busy().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
The cover letter of the set can be found here
<URL:https://lore.kernel.org/linux-pm/20250704075225.3212486-1-sakari.ailus@linux.intel.com>.

In brief, this patch depends on PM runtime patches adding marking the last
busy timestamp in autosuspend related functions. The patches are here, on
rc2:

        git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
                pm-runtime-6.17-rc1

 drivers/iio/gyro/bmg160_core.c     | 1 -
 drivers/iio/gyro/fxas21002c_core.c | 2 --
 drivers/iio/gyro/mpu3050-core.c    | 3 ---
 drivers/iio/gyro/mpu3050-i2c.c     | 1 -
 4 files changed, 7 deletions(-)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 781d3e96645f..4dbe3c0cc5eb 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -310,7 +310,6 @@ static int bmg160_set_power_state(struct bmg160_data *data, bool on)
 	if (on)
 		ret = pm_runtime_get_sync(dev);
 	else {
-		pm_runtime_mark_last_busy(dev);
 		ret = pm_runtime_put_autosuspend(dev);
 	}
 
diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
index 754c8a564ba4..a88670207cec 100644
--- a/drivers/iio/gyro/fxas21002c_core.c
+++ b/drivers/iio/gyro/fxas21002c_core.c
@@ -373,8 +373,6 @@ static int  fxas21002c_pm_put(struct fxas21002c_data *data)
 {
 	struct device *dev = regmap_get_device(data->regmap);
 
-	pm_runtime_mark_last_busy(dev);
-
 	return pm_runtime_put_autosuspend(dev);
 }
 
diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 16553948c5c3..67ae7d1012bc 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -370,7 +370,6 @@ static int mpu3050_read_raw(struct iio_dev *indio_dev,
 
 out_read_raw_unlock:
 	mutex_unlock(&mpu3050->lock);
-	pm_runtime_mark_last_busy(mpu3050->dev);
 	pm_runtime_put_autosuspend(mpu3050->dev);
 
 	return ret;
@@ -662,7 +661,6 @@ static int mpu3050_buffer_postdisable(struct iio_dev *indio_dev)
 {
 	struct mpu3050 *mpu3050 = iio_priv(indio_dev);
 
-	pm_runtime_mark_last_busy(mpu3050->dev);
 	pm_runtime_put_autosuspend(mpu3050->dev);
 
 	return 0;
@@ -976,7 +974,6 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
 		if (ret)
 			dev_err(mpu3050->dev, "error resetting FIFO\n");
 
-		pm_runtime_mark_last_busy(mpu3050->dev);
 		pm_runtime_put_autosuspend(mpu3050->dev);
 		mpu3050->hw_irq_trigger = false;
 
diff --git a/drivers/iio/gyro/mpu3050-i2c.c b/drivers/iio/gyro/mpu3050-i2c.c
index 8e284f47242c..092878f2c886 100644
--- a/drivers/iio/gyro/mpu3050-i2c.c
+++ b/drivers/iio/gyro/mpu3050-i2c.c
@@ -27,7 +27,6 @@ static int mpu3050_i2c_bypass_deselect(struct i2c_mux_core *mux, u32 chan_id)
 {
 	struct mpu3050 *mpu3050 = i2c_mux_priv(mux);
 
-	pm_runtime_mark_last_busy(mpu3050->dev);
 	pm_runtime_put_autosuspend(mpu3050->dev);
 	return 0;
 }
-- 
2.39.5


