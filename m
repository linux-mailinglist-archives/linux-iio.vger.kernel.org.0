Return-Path: <linux-iio+bounces-21326-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0D3AF8A87
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 10:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12AC516CF29
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 08:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9E42D94B4;
	Fri,  4 Jul 2025 07:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AY8v/1M/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87A22D6611;
	Fri,  4 Jul 2025 07:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615669; cv=none; b=t+8jfW84KGr9w0SxKkLtAL3awl2oa7kxURhV/Ps7dM4g5TXW0AvT+ujPzE4q+f6+nuRQvQgyMHh1MvFpEJpM9x65s2+fP1vgKwqOJ4y0P1/PraPBG1/52VCnNsWWx+vcQnFvlcFzxnzE/ZbzaHrakMWDPDDJ9KB2dXgvh8BAyYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615669; c=relaxed/simple;
	bh=eEMXgNk8O9i8u94PDwyXfwKEs6jdqR9SbmKxC3eBhrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L5H/9gLJAfVD4e1cpViz5S2Ar1pXhaIYkaUBs71BcfBhPv4jVP/zQ12JxlfzPaCrXy+RzuH5RLNM/MhnZEBfwYQKsrukjKWj2N4lVHeYo5pcbDHP9rYfX/D8yg3Zwp8mEOdW6e76g6kDMEwuFmDDtVnYe3z2CxFNvHjiPuzVlFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AY8v/1M/; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751615667; x=1783151667;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eEMXgNk8O9i8u94PDwyXfwKEs6jdqR9SbmKxC3eBhrY=;
  b=AY8v/1M/0PQp5DA0UNufoDL3QqWaqLiUDf9126qGrsDdGDTv+Zz8eSOS
   DasQAsZ/LkZjgpY8fBLczNCWcfTVwuad0HWm5AF/5hfpex4faJ6ub6OhK
   Hh5j9UaKu/JRi7KunDbfTJXSlXsXTh09CPgPfd87FHCcvUxLd5nyybq4F
   80CYri0rM0QIj5ydgqWjJZsMvzF4Ct8pI+wbIs6TTpHNYeNbYNrliQJhl
   Rl3xtDQ9cljKVLfv1M4+HwhxDxqlSHSuWJeF4fubCmYzZ9aLDNHb1H59l
   re0dWYHtKeElzNMcTWskUv3PYV1D4dib/PhdclMwCkfsb5XT59jmUz0F5
   A==;
X-CSE-ConnectionGUID: hlQgJgl7Qtq49rFxEt+8sQ==
X-CSE-MsgGUID: gCmaUy6QQJuzdRqfkva8bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="76494633"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="76494633"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:26 -0700
X-CSE-ConnectionGUID: y4e4yWymRNK1WTvnPcl7zQ==
X-CSE-MsgGUID: V7rlD42dQFqqPct9gwu6pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="158924267"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO svinhufvud.fi.intel.com) ([10.245.244.244])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:23 -0700
Received: from svinhufvud.lan (localhost [IPv6:::1])
	by svinhufvud.fi.intel.com (Postfix) with ESMTP id 7A6FE447EB;
	Fri,  4 Jul 2025 10:54:21 +0300 (EEST)
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 30/80] iio: common: Remove redundant pm_runtime_mark_last_busy() calls
Date: Fri,  4 Jul 2025 10:54:21 +0300
Message-Id: <20250704075421.3219234-1-sakari.ailus@linux.intel.com>
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

 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 48193937275b..5540e2d28f4a 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -163,7 +163,6 @@ int hid_sensor_power_state(struct hid_sensor_common *st, bool state)
 		ret = pm_runtime_resume_and_get(&st->pdev->dev);
 	} else {
 		atomic_dec(&st->user_requested_state);
-		pm_runtime_mark_last_busy(&st->pdev->dev);
 		pm_runtime_use_autosuspend(&st->pdev->dev);
 		ret = pm_runtime_put_autosuspend(&st->pdev->dev);
 	}
-- 
2.39.5


