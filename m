Return-Path: <linux-iio+bounces-21463-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A51AFDBB7
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 01:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A98381894903
	for <lists+linux-iio@lfdr.de>; Tue,  8 Jul 2025 23:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA2626B2D2;
	Tue,  8 Jul 2025 23:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hpOS6BN6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982D1268C63;
	Tue,  8 Jul 2025 23:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752016328; cv=none; b=fCvmp2Xkp2icJLs9OAnMxiC1IFTh9Z1ow0BrKhCOS5XdLE/xKt5zaoubNPy/AYOea2/WRD1GED8grtSMxJep5zfhIzA0OSTAnYEuw0njK8mFw+cTvth22pK475iZDvirpF0qPu8xFDEAB5JBfssJl9EmHDkXWXBciz7g6b9ebqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752016328; c=relaxed/simple;
	bh=Ig1PGuKdBsLcbAMMUR3OrYt04AHOCCxXALIWbFxwsC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pykxrIzaRWGHlEciQo94GKSnc55wQlYNgcBiVbKFbvPzVC8u3vqPbvf9Q67k5D5ot41FX89VDpZL+m9JrpLgMsferoBvrn6mmmktORZgz8Kr0kp34B503X85MWpCMmP0l4/ABf0ccsHekCBssjIKS5Y7hbNDwHnBpywqa6Cfzik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hpOS6BN6; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752016327; x=1783552327;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ig1PGuKdBsLcbAMMUR3OrYt04AHOCCxXALIWbFxwsC4=;
  b=hpOS6BN6C8jLztz9jJ8SjgMkpFXRLmSXNsA0s1dBqdl6trry2eN3Henm
   PPg8WTVobIbCESdWk0xWhjF4GxyAxXzbFWe2DD4qCo73BB3piGvebRJtO
   +kPbUeVvEQzBRw5jJFahFJYizyWHci+zhe2+KNMpHLNN/1gxajaLrBMRk
   Lh6GZPHyj0oYeAkP/hMqbJvQOSc6Ck31NyEfpHnP5quAgPYrRZtyUH7t4
   gQZG1w2cMYWXBqMHuC4DPZ3i4j7tU/O80rhTJLwXx03yqL2DlRCr/EX1Z
   c6IeroB7iymO+IRSQOpd9mSBB0GiXEGfmG7XM8S68glPNYi8LtFgJaYV6
   g==;
X-CSE-ConnectionGUID: uJ62yqHoRW+1MlTpz4Md/A==
X-CSE-MsgGUID: 2ze9l2GESmacG9/vRVaeBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53987029"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="53987029"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 16:12:06 -0700
X-CSE-ConnectionGUID: Zy5CE07uRACfbfWy8ibJyQ==
X-CSE-MsgGUID: 3I8lcrZKR8Khgw2PPWUg/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="186622636"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.102])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 16:12:01 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id E34D8121325;
	Wed,  9 Jul 2025 02:11:52 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uZHTc-0044nE-2v;
	Wed, 09 Jul 2025 02:11:52 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Julien Stephan <jstephan@baylibre.com>,
	Abhash Jha <abhashkumarjha123@gmail.com>,
	Waqar Hameed <waqar.hameed@axis.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	chuguangqing <chuguangqing@inspur.com>,
	Shreeya Patel <shreeya.patel@collabora.com>,
	Marek Vasut <marex@denx.de>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/12] iio: light: Remove redundant pm_runtime_mark_last_busy() calls
Date: Wed,  9 Jul 2025 02:11:52 +0300
Message-Id: <20250708231152.971728-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250708231144.971170-1-sakari.ailus@linux.intel.com>
References: <20250708231144.971170-1-sakari.ailus@linux.intel.com>
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
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/light/apds9306.c   |  2 --
 drivers/iio/light/apds9960.c   |  1 -
 drivers/iio/light/bh1780.c     |  1 -
 drivers/iio/light/gp2ap002.c   |  2 --
 drivers/iio/light/isl29028.c   | 11 +++--------
 drivers/iio/light/ltrf216a.c   |  1 -
 drivers/iio/light/pa12203001.c | 11 +++--------
 drivers/iio/light/rpr0521.c    |  6 ++----
 drivers/iio/light/tsl2583.c    | 12 +++---------
 drivers/iio/light/tsl2591.c    |  2 --
 drivers/iio/light/us5182d.c    | 12 +++---------
 drivers/iio/light/vcnl4000.c   | 11 +++--------
 drivers/iio/light/vcnl4035.c   | 11 +++--------
 13 files changed, 20 insertions(+), 63 deletions(-)

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
index 0e4284823d44..374bccad9119 100644
--- a/drivers/iio/light/isl29028.c
+++ b/drivers/iio/light/isl29028.c
@@ -336,16 +336,11 @@ static int isl29028_ir_get(struct isl29028_chip *chip, int *ir_data)
 static int isl29028_set_pm_runtime_busy(struct isl29028_chip *chip, bool on)
 {
 	struct device *dev = regmap_get_device(chip->regmap);
-	int ret;
 
-	if (on) {
-		ret = pm_runtime_resume_and_get(dev);
-	} else {
-		pm_runtime_mark_last_busy(dev);
-		ret = pm_runtime_put_autosuspend(dev);
-	}
+	if (on)
+		return pm_runtime_resume_and_get(dev);
 
-	return ret;
+	return pm_runtime_put_autosuspend(dev);
 }
 
 /* Channel IO */
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
index 8885852bef22..98a1f1624c75 100644
--- a/drivers/iio/light/pa12203001.c
+++ b/drivers/iio/light/pa12203001.c
@@ -185,15 +185,10 @@ static int pa12203001_set_power_state(struct pa12203001_data *data, bool on,
 		mutex_unlock(&data->lock);
 	}
 
-	if (on) {
-		ret = pm_runtime_resume_and_get(&data->client->dev);
+	if (on)
+		return pm_runtime_resume_and_get(&data->client->dev);
 
-	} else {
-		pm_runtime_mark_last_busy(&data->client->dev);
-		ret = pm_runtime_put_autosuspend(&data->client->dev);
-	}
-
-	return ret;
+	return pm_runtime_put_autosuspend(&data->client->dev);
 
 err:
 	mutex_unlock(&data->lock);
diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index c50183f07240..fd538aec4819 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -358,12 +358,10 @@ static int rpr0521_set_power_state(struct rpr0521_data *data, bool on,
 	 * Note: If either measurement is re-enabled before _suspend(),
 	 * both stay enabled until _suspend().
 	 */
-	if (on) {
+	if (on)
 		ret = pm_runtime_resume_and_get(&data->client->dev);
-	} else {
-		pm_runtime_mark_last_busy(&data->client->dev);
+	else
 		ret = pm_runtime_put_autosuspend(&data->client->dev);
-	}
 	if (ret < 0) {
 		dev_err(&data->client->dev,
 			"Failed: rpr0521_set_power_state for %d, ret %d\n",
diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
index fc3b0c4226be..8801a491de77 100644
--- a/drivers/iio/light/tsl2583.c
+++ b/drivers/iio/light/tsl2583.c
@@ -641,16 +641,10 @@ static const struct iio_chan_spec tsl2583_channels[] = {
 
 static int tsl2583_set_pm_runtime_busy(struct tsl2583_chip *chip, bool on)
 {
-	int ret;
+	if (on)
+		return pm_runtime_resume_and_get(&chip->client->dev);
 
-	if (on) {
-		ret = pm_runtime_resume_and_get(&chip->client->dev);
-	} else {
-		pm_runtime_mark_last_busy(&chip->client->dev);
-		ret = pm_runtime_put_autosuspend(&chip->client->dev);
-	}
-
-	return ret;
+	return pm_runtime_put_autosuspend(&chip->client->dev);
 }
 
 static int tsl2583_read_raw(struct iio_dev *indio_dev,
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
index 61a0957317a1..d2f5a44892a8 100644
--- a/drivers/iio/light/us5182d.c
+++ b/drivers/iio/light/us5182d.c
@@ -361,19 +361,13 @@ static int us5182d_shutdown_en(struct us5182d_data *data, u8 state)
 
 static int us5182d_set_power_state(struct us5182d_data *data, bool on)
 {
-	int ret;
-
 	if (data->power_mode == US5182D_ONESHOT)
 		return 0;
 
-	if (on) {
-		ret = pm_runtime_resume_and_get(&data->client->dev);
-	} else {
-		pm_runtime_mark_last_busy(&data->client->dev);
-		ret = pm_runtime_put_autosuspend(&data->client->dev);
-	}
+	if (on)
+		return pm_runtime_resume_and_get(&data->client->dev);
 
-	return ret;
+	return pm_runtime_put_autosuspend(&data->client->dev);
 }
 
 static int us5182d_read_value(struct us5182d_data *data,
diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 90e7d4421abf..7d70bb71b432 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -576,16 +576,11 @@ static bool vcnl4010_is_in_periodic_mode(struct vcnl4000_data *data)
 static int vcnl4000_set_pm_runtime_state(struct vcnl4000_data *data, bool on)
 {
 	struct device *dev = &data->client->dev;
-	int ret;
 
-	if (on) {
-		ret = pm_runtime_resume_and_get(dev);
-	} else {
-		pm_runtime_mark_last_busy(dev);
-		ret = pm_runtime_put_autosuspend(dev);
-	}
+	if (on)
+		return pm_runtime_resume_and_get(dev);
 
-	return ret;
+	return pm_runtime_put_autosuspend(dev);
 }
 
 static int vcnl4040_read_als_it(struct vcnl4000_data *data, int *val, int *val2)
diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index 01bc99564f98..963747927425 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -141,17 +141,12 @@ static const struct iio_trigger_ops vcnl4035_trigger_ops = {
 
 static int vcnl4035_set_pm_runtime_state(struct vcnl4035_data *data, bool on)
 {
-	int ret;
 	struct device *dev = &data->client->dev;
 
-	if (on) {
-		ret = pm_runtime_resume_and_get(dev);
-	} else {
-		pm_runtime_mark_last_busy(dev);
-		ret = pm_runtime_put_autosuspend(dev);
-	}
+	if (on)
+		return pm_runtime_resume_and_get(dev);
 
-	return ret;
+	return pm_runtime_put_autosuspend(dev);
 }
 
 static int vcnl4035_read_info_raw(struct iio_dev *indio_dev,
-- 
2.39.5


