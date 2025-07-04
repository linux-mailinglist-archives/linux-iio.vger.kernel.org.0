Return-Path: <linux-iio+bounces-21331-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 017F1AF8A97
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 10:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A552F4A7666
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 08:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17B52DFA5C;
	Fri,  4 Jul 2025 07:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rg2WGBw0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A299B2DAFDF;
	Fri,  4 Jul 2025 07:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615676; cv=none; b=KgDInYj506zo60D9U93ICLfUqN22z79rXThDC1TI8a/qHqTh6gHakMdl5PazusFGrMHpmXl2weQqEV1zcKoc9UFqK3lvTF7aHj74Zu4CaVCTEVONNaJQ+C9PILqheH+EII41Sjqcac6IlSy6XW9QHRnzUet3Jlkyps6IWoEUByo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615676; c=relaxed/simple;
	bh=feFnRJruPs12PNpvwdA5mfXFpw0U2Z/9ohGffVvSXnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HytyEdBl+i9brHjshg8xLcFdiNanYlv3WRVLSrzAKnBUTNUTNvst34Km3yfmb/KxSGroVDnBrC78hV+b8cKzw9b/er2bl0VsirRsVCJEfGPWgpQGa0CoyOjMFYwRoqtdKk6XrImEcotAB9jq9S4LzbyrQHmUUke6Tk5OOBsaUJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rg2WGBw0; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751615674; x=1783151674;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=feFnRJruPs12PNpvwdA5mfXFpw0U2Z/9ohGffVvSXnk=;
  b=Rg2WGBw0B2p/ZPnzH5OdHAITXnovnqisW/SfCRHa6GfApS+NQNs/u29V
   FmjUICqjfClo0KDuOk90jaIgDzNVVOSRbJRRaCX9odxfa0knvcA+pmzMi
   b8auLieftcBEDAP+0afULWTRY8exLghIHUKzSL3+r91XG71Y8bchkUeub
   2wNH+vDvB7FBHhJqckkwe0yKsTcrsJAGceTgKX07tT2bP0ZRNLZSl/e0x
   5Hmby+qVAWZEPyOUUBTdx0LhivfKvWMqIoo3YMZ+olahU3uU6Eivb9toK
   iby0boCa7nJ+p3SPBcuKjdaTNh+0xDEDJ8R4ANVpWNpxZHXzL1NFoHJ3x
   A==;
X-CSE-ConnectionGUID: IBhLQrroTy+YYze8GnLxdQ==
X-CSE-MsgGUID: Gvnx9dqoRNSCjLas4ql78Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="76494726"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="76494726"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:32 -0700
X-CSE-ConnectionGUID: DK5QhGGXTvGZ9wYi7rJpVQ==
X-CSE-MsgGUID: mqKhOVBnTpKYZlr9BhokPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="158924304"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO svinhufvud.fi.intel.com) ([10.245.244.244])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:29 -0700
Received: from svinhufvud.lan (localhost [IPv6:::1])
	by svinhufvud.fi.intel.com (Postfix) with ESMTP id 8698E447EB;
	Fri,  4 Jul 2025 10:54:27 +0300 (EEST)
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 37/80] iio: proximity: Remove redundant pm_runtime_mark_last_busy() calls
Date: Fri,  4 Jul 2025 10:54:27 +0300
Message-Id: <20250704075427.3219858-1-sakari.ailus@linux.intel.com>
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

 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 1 -
 drivers/iio/proximity/srf04.c                     | 1 -
 2 files changed, 2 deletions(-)

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
index b059bac1078b..f2e2c638a2b6 100644
--- a/drivers/iio/proximity/srf04.c
+++ b/drivers/iio/proximity/srf04.c
@@ -118,7 +118,6 @@ static int srf04_read(struct srf04_data *data)
 	gpiod_set_value(data->gpiod_trig, 0);
 
 	if (data->gpiod_power) {
-		pm_runtime_mark_last_busy(data->dev);
 		pm_runtime_put_autosuspend(data->dev);
 	}
 
-- 
2.39.5


