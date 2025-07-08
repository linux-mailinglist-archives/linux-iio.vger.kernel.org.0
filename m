Return-Path: <linux-iio+bounces-21453-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE995AFDBA1
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 01:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C2DB48056C
	for <lists+linux-iio@lfdr.de>; Tue,  8 Jul 2025 23:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE2623817A;
	Tue,  8 Jul 2025 23:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TFWe+1Ua"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC32235071;
	Tue,  8 Jul 2025 23:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752016320; cv=none; b=fKVnph5187v8ukidioHCL3Ak3Z0ftola8KzDMHtZZu1dMlGh7DeDbEtaxHJPlmrR6nzIX80o13LGLHMAH6H2BfFCKrm7M1nSlq3HDo4Ptvw/GkM0pQefCCLvEy2JLqLGN7F23diTET6jS0ZryFLdyQZzQAxJC94A60UfPZMx/4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752016320; c=relaxed/simple;
	bh=88dVg0aPiDQ3OnriSOSE3F2c2Gn91+b2V42Or3eb7s4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EECBCFJKXk0+cxRpK7BY86XlaBzsA9eHd4Pnw7wchGOkaxTNmURa3D1+aiHimqYi5R80hFi5X4D2yi3iPp+f6iofSFAXdptiHlB1xm2Ggh0HBikSkxtPtB2v0rDIvmqjBhjdMKzo/pk6jBDDtoDh+/7IOCKiSynOWbSEvCGRwYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TFWe+1Ua; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752016319; x=1783552319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=88dVg0aPiDQ3OnriSOSE3F2c2Gn91+b2V42Or3eb7s4=;
  b=TFWe+1UagsGY49I47ATJ1KA3nWcl6cUtctvW6kPQ65f54K8XRVG7U6/i
   y22R/q9ZINkvti1VlEC0dZvQd7aXrU9V5cNgIff9Ihrpxyg3HKRcZGl00
   hXWz25vo+aLZbJnezwOHEASTV+e3rw/hCKzg87Lbtz3Lc1F7iGhbABmBB
   BAxcZGhYKIBQzvhjIkcwLM6FKM2JobXLuMR7ZFgqO1+5aSp4qOywIg7Ex
   d0zpTqlY/OhSJshIli7QSeVTlUV6C5TRCrd5YdaUBXgolIMblsNkKUpJs
   S3erJ15koBckGyV8B2VRMgZ5NKfUw+UVgHbgLu22V2nHnI+GLoOZxg/Og
   A==;
X-CSE-ConnectionGUID: 2WaDPBipTEWUilqMr/Yl9A==
X-CSE-MsgGUID: gKfVRKAzRFW3EJahm/OM9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53986878"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="53986878"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 16:11:58 -0700
X-CSE-ConnectionGUID: cAOq/KiMQMeF9v1gdMt8hQ==
X-CSE-MsgGUID: UyGKqwoyQNe5199nBvuavQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="186622615"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.102])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 16:11:56 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 85F73121126;
	Wed,  9 Jul 2025 02:11:52 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uZHTc-0044jU-1h;
	Wed, 09 Jul 2025 02:11:52 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Peter Zijlstra <peterz@infradead.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/12] iio: common: Remove redundant pm_runtime_mark_last_busy() calls
Date: Wed,  9 Jul 2025 02:11:52 +0300
Message-Id: <20250708231152.971495-1-sakari.ailus@linux.intel.com>
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


