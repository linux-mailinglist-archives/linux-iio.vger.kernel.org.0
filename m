Return-Path: <linux-iio+bounces-21458-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EE4AFDBAB
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 01:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458FD168434
	for <lists+linux-iio@lfdr.de>; Tue,  8 Jul 2025 23:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA97B265282;
	Tue,  8 Jul 2025 23:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="maG6tq4D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD4325A2C7;
	Tue,  8 Jul 2025 23:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752016324; cv=none; b=ObYCj9/EpfYNCMy4WcKudm6W0Hb6busOV3LKw89Ae6dN0U8FTuKXp7yb4yFV8A9uVufaep8jz/4vRRWpYNS4f9tiX5UQLHWAg5p8sXfWWqGKK+skzTo8Mb8Wevfhw+enribFekjmBqcIpHn8N/lk42C3kUEy18wceX7vL9oLBt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752016324; c=relaxed/simple;
	bh=tpbdqx+pZt3zIStQ4Q085+Fu2fEEZYeaTuSZlts3qRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ji7fN6wdFRKPjFDLuW33vum2p+fD2lUICyKmstNdC5QXCZGuvqQsdvf7NiN7FtW09poAcREjNPIb2w9VnKOWXk3rkrDIPMYsUGE/2SIXjO/cet07ns50LC9L2ItAcoufg7SkBc6IFDbeReUh4nZbeDNo2D8x7Mzx5kXlfCF7yCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=maG6tq4D; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752016323; x=1783552323;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tpbdqx+pZt3zIStQ4Q085+Fu2fEEZYeaTuSZlts3qRY=;
  b=maG6tq4Dm0oqDSpKmhn2cOMaWjnmevBv/eXSdH35x1t8aTuO1/7P7eVz
   Ld5bDv9iX4o+BNnJoJj7suNSqUQ90zb/6Q3jVZxSFliodCC0pM8AqihK7
   573N8OXY8jzupkmNNybA484VPO9WVbWa/YqbVbiPQA+MScPYKoe/AKVzR
   rhRQPB/igmHGq7tNAKANl1CP8X7HppPS/wAT+GDMT7PtcY3+FtdZr+163
   DdL0P+rY9+yLJJHx20Tf9QVyG7jfYGU3zpEGWmmizWqhIyLS4EsZ8Ob0Z
   rZtVOVigT6G4TzcgRtZm9wyGDAwzHYKaR7J+7RL8xg32f/Nmj4jB0Po+6
   g==;
X-CSE-ConnectionGUID: UtJ4TjPPR6SJZht64p9NKQ==
X-CSE-MsgGUID: 0+abS7DrQsyqE35WPyxIqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53986968"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="53986968"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 16:12:03 -0700
X-CSE-ConnectionGUID: U99cAgAdQtGA8o2HpCwRfw==
X-CSE-MsgGUID: 6wHWAofqSLa383Fqz9v1yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="186622635"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.102])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 16:12:01 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 6C28E121574;
	Wed,  9 Jul 2025 02:11:53 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uZHTd-0044q8-1M;
	Wed, 09 Jul 2025 02:11:53 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/12] iio: proximity: Remove redundant pm_runtime_mark_last_busy() calls
Date: Wed,  9 Jul 2025 02:11:53 +0300
Message-Id: <20250708231153.971907-1-sakari.ailus@linux.intel.com>
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
---
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 1 -
 drivers/iio/proximity/srf04.c                     | 4 +---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index 1deaf70e92ce..d53a596128f5 100644
--- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
+++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
@@ -191,7 +191,6 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
 		}
 		ret = -EIO;
 	}
-	pm_runtime_mark_last_busy(&client->dev);
 	pm_runtime_put_autosuspend(&client->dev);
 
 	return ret;
diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
index b059bac1078b..310467ce39e2 100644
--- a/drivers/iio/proximity/srf04.c
+++ b/drivers/iio/proximity/srf04.c
@@ -117,10 +117,8 @@ static int srf04_read(struct srf04_data *data)
 	udelay(data->cfg->trigger_pulse_us);
 	gpiod_set_value(data->gpiod_trig, 0);
 
-	if (data->gpiod_power) {
-		pm_runtime_mark_last_busy(data->dev);
+	if (data->gpiod_power)
 		pm_runtime_put_autosuspend(data->dev);
-	}
 
 	/* it should not take more than 20 ms until echo is rising */
 	ret = wait_for_completion_killable_timeout(&data->rising, HZ/50);
-- 
2.39.5


