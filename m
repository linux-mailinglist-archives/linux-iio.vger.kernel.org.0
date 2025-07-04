Return-Path: <linux-iio+bounces-21330-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B50AF8A92
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 10:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 546DB4A0291
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 08:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557D92DBF43;
	Fri,  4 Jul 2025 07:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cCMjBQKd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42D22D542C;
	Fri,  4 Jul 2025 07:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615675; cv=none; b=dQ2TxWP0b1dIqNrX5oj9jdtEgpnW4jqD6+Wuh38nShjAK2oCPylKI1D+YgWTKG7lT/2QkYnoXJi3nLq+7chuFq+r30nt6ge7cEzgkpXTy0sHDLeB6G3+rjzBgKe8BunLMP7JphBF3nCqQTY/Y8wHFmcR17vEcVBqmSUKP4BJfOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615675; c=relaxed/simple;
	bh=CRIWCLPCoDeia77/badXqEi5i8gzI/aN0BfcHkaARVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rv3Tx+5cGoDbfD0d7rf9nD32t9pbr2FN/KZyL9VKDFDH3siw5Y0FOoD9LwiNzA21LQ6aVeP/jiBylosGAQDXQ6ScUH7CJ1t3QN6v6saxA3BTH8NpzeLdGnIV15Xl8BXEtrMT8f+LBjGVsI8+SwZ3ASTXA1jzrAh4OY7Oa2tYFyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cCMjBQKd; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751615672; x=1783151672;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CRIWCLPCoDeia77/badXqEi5i8gzI/aN0BfcHkaARVU=;
  b=cCMjBQKdkd3z3ZYMmfxn3ChrHqXvlmp1uG+ssZK4J9xN+uxQZ0lzUJiF
   ea6zFzO+N92myD9s9xGdcPORe9N8/tly61xdel2jhcr9/Ocf/RWX80JnJ
   vbNNVQu7YB6kiT6DckHZcZDnfutQwInvncRfmCsyO9rh2S3JcvSvJBc6+
   shpjNjY+t2vGGnBhiO8hzrpBWWlZI8AmO9L+Pj4PALJa7S48tMZygsojI
   mEMhvXlu4fdVnB0Iy8obo7TeFVptiWRzGBDTCvfLWQ6MM2ONVw1SAFHlm
   eI1i99idjDIe1fDoKE1d5O2N0F9rymr7VfI/xlTKVTE6xXMJsfVq2mowk
   A==;
X-CSE-ConnectionGUID: 0fQALHxnRfCq8NWaZcAJIA==
X-CSE-MsgGUID: FEMv23WnRumA2GC2GhzJgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="76494715"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="76494715"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:32 -0700
X-CSE-ConnectionGUID: 9JGs9zU8R3mlxCN1zcIBUg==
X-CSE-MsgGUID: rPW2CgHGQ+Onfly1RQWb+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="158924282"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO svinhufvud.fi.intel.com) ([10.245.244.244])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:26 -0700
Received: from svinhufvud.lan (localhost [IPv6:::1])
	by svinhufvud.fi.intel.com (Postfix) with ESMTP id D826644433;
	Fri,  4 Jul 2025 10:54:24 +0300 (EEST)
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Julien Stephan <jstephan@baylibre.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Waqar Hameed <waqar.hameed@axis.com>,
	Abhash Jha <abhashkumarjha123@gmail.com>,
	chuguangqing <chuguangqing@inspur.com>,
	Shreeya Patel <shreeya.patel@collabora.com>,
	Marek Vasut <marex@denx.de>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 34/80] iio: light: Remove redundant pm_runtime_mark_last_busy() calls
Date: Fri,  4 Jul 2025 10:54:24 +0300
Message-Id: <20250704075424.3219556-1-sakari.ailus@linux.intel.com>
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

 drivers/iio/light/apds9306.c   | 2 --
 drivers/iio/light/apds9960.c   | 1 -
 drivers/iio/light/bh1780.c     | 1 -
 drivers/iio/light/gp2ap002.c   | 2 --
 drivers/iio/light/isl29028.c   | 1 -
 drivers/iio/light/ltrf216a.c   | 1 -
 drivers/iio/light/pa12203001.c | 1 -
 drivers/iio/light/rpr0521.c    | 1 -
 drivers/iio/light/tsl2583.c    | 1 -
 drivers/iio/light/tsl2591.c    | 2 --
 drivers/iio/light/us5182d.c    | 1 -
 drivers/iio/light/vcnl4000.c   | 1 -
 drivers/iio/light/vcnl4035.c   | 1 -
 13 files changed, 16 deletions(-)

diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
index f676da245aa7..5916cabd0755 100644
--- a/drivers/iio/light/apds9306.c
+++ b/drivers/iio/light/apds9306.c
@@ -537,7 +537,6 @@ static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
 
 	*val = get_unaligned_le24(&buff);
 
-	pm_runtime_mark_last_busy(data->dev);
 	pm_runtime_put_autosuspend(data->dev);
 
 	return 0;
@@ -1121,7 +1120,6 @@ static int apds9306_write_event_config(struct iio_dev *indio_dev,
 			if (ret)
 				return ret;
 
-			pm_runtime_mark_last_busy(data->dev);
 			pm_runtime_put_autosuspend(data->dev);
 
 			return 0;
diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index b92d0fce5aec..79b202c59a0f 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -495,7 +495,6 @@ static int apds9960_set_power_state(struct apds9960_data *data, bool on)
 			usleep_range(data->als_adc_int_us,
 				     APDS9960_MAX_INT_TIME_IN_US);
 	} else {
-		pm_runtime_mark_last_busy(dev);
 		ret = pm_runtime_put_autosuspend(dev);
 	}
 
diff --git a/drivers/iio/light/bh1780.c b/drivers/iio/light/bh1780.c
index c7c877d2fe67..5d3c6d5276ba 100644
--- a/drivers/iio/light/bh1780.c
+++ b/drivers/iio/light/bh1780.c
@@ -111,7 +111,6 @@ static int bh1780_read_raw(struct iio_dev *indio_dev,
 			value = bh1780_read_word(bh1780, BH1780_REG_DLOW);
 			if (value < 0)
 				return value;
-			pm_runtime_mark_last_busy(&bh1780->client->dev);
 			pm_runtime_put_autosuspend(&bh1780->client->dev);
 			*val = value;
 
diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index 42859e5b1089..a0d8a58f2704 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -271,7 +271,6 @@ static int gp2ap002_read_raw(struct iio_dev *indio_dev,
 	}
 
 out:
-	pm_runtime_mark_last_busy(gp2ap002->dev);
 	pm_runtime_put_autosuspend(gp2ap002->dev);
 
 	return ret;
@@ -353,7 +352,6 @@ static int gp2ap002_write_event_config(struct iio_dev *indio_dev,
 		pm_runtime_get_sync(gp2ap002->dev);
 		gp2ap002->enabled = true;
 	} else {
-		pm_runtime_mark_last_busy(gp2ap002->dev);
 		pm_runtime_put_autosuspend(gp2ap002->dev);
 		gp2ap002->enabled = false;
 	}
diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
index 0e4284823d44..5ff20d423def 100644
--- a/drivers/iio/light/isl29028.c
+++ b/drivers/iio/light/isl29028.c
@@ -341,7 +341,6 @@ static int isl29028_set_pm_runtime_busy(struct isl29028_chip *chip, bool on)
 	if (on) {
 		ret = pm_runtime_resume_and_get(dev);
 	} else {
-		pm_runtime_mark_last_busy(dev);
 		ret = pm_runtime_put_autosuspend(dev);
 	}
 
diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
index 61f57a82b872..5f27f754fe1c 100644
--- a/drivers/iio/light/ltrf216a.c
+++ b/drivers/iio/light/ltrf216a.c
@@ -208,7 +208,6 @@ static int ltrf216a_set_power_state(struct ltrf216a_data *data, bool on)
 			return ret;
 		}
 	} else {
-		pm_runtime_mark_last_busy(dev);
 		pm_runtime_put_autosuspend(dev);
 	}
 
diff --git a/drivers/iio/light/pa12203001.c b/drivers/iio/light/pa12203001.c
index 8885852bef22..93823421f42f 100644
--- a/drivers/iio/light/pa12203001.c
+++ b/drivers/iio/light/pa12203001.c
@@ -189,7 +189,6 @@ static int pa12203001_set_power_state(struct pa12203001_data *data, bool on,
 		ret = pm_runtime_resume_and_get(&data->client->dev);
 
 	} else {
-		pm_runtime_mark_last_busy(&data->client->dev);
 		ret = pm_runtime_put_autosuspend(&data->client->dev);
 	}
 
diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index c50183f07240..15e2cca22e4d 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -361,7 +361,6 @@ static int rpr0521_set_power_state(struct rpr0521_data *data, bool on,
 	if (on) {
 		ret = pm_runtime_resume_and_get(&data->client->dev);
 	} else {
-		pm_runtime_mark_last_busy(&data->client->dev);
 		ret = pm_runtime_put_autosuspend(&data->client->dev);
 	}
 	if (ret < 0) {
diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
index fc3b0c4226be..d3a4923e5adc 100644
--- a/drivers/iio/light/tsl2583.c
+++ b/drivers/iio/light/tsl2583.c
@@ -646,7 +646,6 @@ static int tsl2583_set_pm_runtime_busy(struct tsl2583_chip *chip, bool on)
 	if (on) {
 		ret = pm_runtime_resume_and_get(&chip->client->dev);
 	} else {
-		pm_runtime_mark_last_busy(&chip->client->dev);
 		ret = pm_runtime_put_autosuspend(&chip->client->dev);
 	}
 
diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
index 08476f193a44..c5557867ea43 100644
--- a/drivers/iio/light/tsl2591.c
+++ b/drivers/iio/light/tsl2591.c
@@ -772,7 +772,6 @@ static int tsl2591_read_raw(struct iio_dev *indio_dev,
 err_unlock:
 	mutex_unlock(&chip->als_mutex);
 
-	pm_runtime_mark_last_busy(&client->dev);
 	pm_runtime_put_autosuspend(&client->dev);
 
 	return ret;
@@ -995,7 +994,6 @@ static int tsl2591_write_event_config(struct iio_dev *indio_dev,
 		pm_runtime_get_sync(&client->dev);
 	} else if (!state && chip->events_enabled) {
 		chip->events_enabled = false;
-		pm_runtime_mark_last_busy(&client->dev);
 		pm_runtime_put_autosuspend(&client->dev);
 	}
 
diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
index 61a0957317a1..8f0f85e98f3a 100644
--- a/drivers/iio/light/us5182d.c
+++ b/drivers/iio/light/us5182d.c
@@ -369,7 +369,6 @@ static int us5182d_set_power_state(struct us5182d_data *data, bool on)
 	if (on) {
 		ret = pm_runtime_resume_and_get(&data->client->dev);
 	} else {
-		pm_runtime_mark_last_busy(&data->client->dev);
 		ret = pm_runtime_put_autosuspend(&data->client->dev);
 	}
 
diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 90e7d4421abf..39e2cf20038a 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -581,7 +581,6 @@ static int vcnl4000_set_pm_runtime_state(struct vcnl4000_data *data, bool on)
 	if (on) {
 		ret = pm_runtime_resume_and_get(dev);
 	} else {
-		pm_runtime_mark_last_busy(dev);
 		ret = pm_runtime_put_autosuspend(dev);
 	}
 
diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index 01bc99564f98..079fb49bf73b 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -147,7 +147,6 @@ static int vcnl4035_set_pm_runtime_state(struct vcnl4035_data *data, bool on)
 	if (on) {
 		ret = pm_runtime_resume_and_get(dev);
 	} else {
-		pm_runtime_mark_last_busy(dev);
 		ret = pm_runtime_put_autosuspend(dev);
 	}
 
-- 
2.39.5


