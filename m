Return-Path: <linux-iio+bounces-21327-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE19BAF8A81
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 10:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 385FB3A1266
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 08:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2B92DA747;
	Fri,  4 Jul 2025 07:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SgqInHLr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403EE2D6638;
	Fri,  4 Jul 2025 07:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615670; cv=none; b=DniCbrpjoYXp5jsGzxiCRfNOuhup7vn3BOHEVW29K0a7JxvT8lHnjpMSIzGWgN5YZr9ITgOFb/AN+HHJRkUq9gyHeaEgpqWbghLnydRXggn4ps2sNt/8MaOXFF687jViRfbuRFGfBATDVWPE6cZl5okBRhjc5NaHtpx3XwJsQjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615670; c=relaxed/simple;
	bh=iWBWM0U4T919tQGPGfn9BScin0AJyspS/yqsVimSI2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ehakGMswGkgb/MqLnxPK7pKY8tbayMvsQDWAdk6MRobUYxiS9wPm3bpYIcfZOCwR4eL7qTVLhUyIukYFdgV8Q1uplRpLzXA56LExjwpIA48dmlT2sf9Hc6M211viVPpe7NKYhR9ZQlM3OGahDnv3PnPxld+YPiBjWDRgAYUhn1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SgqInHLr; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751615668; x=1783151668;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iWBWM0U4T919tQGPGfn9BScin0AJyspS/yqsVimSI2Q=;
  b=SgqInHLrh5Ey+6QTxzP2B2ogOKiz0BB+Vx3+xf2pAXEq2tqwAb8UBbyM
   9ed+r8YpRKcx4vjE8N8A5EBYUzOH5tjo3xF9CUPiD9CA1+1RHxOHNIlGO
   iBtE/4d5uDy0erCyNgeECBt7Uhnhg5oW8x9rxU1tmoslN5AMtnFU8th13
   1UH53ujqh4Hp7U/WEZmVDl0hlucCckSve1NfyiG2MTOlgFrROMyGTHJPT
   7+AY8NqrNnVf8t08MVkpdrOwSk+fjvK7ZDt8h1g9ak+uwD4IEdL2EkLLA
   I5DyHOD95cnsCocf7ZVbwMFKHXJtc9Nqa59KhKSeJYCGxjFXejpUZvMUh
   w==;
X-CSE-ConnectionGUID: m1NKziOZTDasnewOTupUDg==
X-CSE-MsgGUID: lFBXTsx5TDWylBqepNcm3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="76494640"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="76494640"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:27 -0700
X-CSE-ConnectionGUID: 1PPAJs0KT4yeS0NQgpsEJA==
X-CSE-MsgGUID: PargF/5ZSQyGI5qazvbrfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="158924271"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO svinhufvud.fi.intel.com) ([10.245.244.244])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:24 -0700
Received: from svinhufvud.lan (localhost [IPv6:::1])
	by svinhufvud.fi.intel.com (Postfix) with ESMTP id 4FF4244A4B;
	Fri,  4 Jul 2025 10:54:22 +0300 (EEST)
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 31/80] iio: dac: Remove redundant pm_runtime_mark_last_busy() calls
Date: Fri,  4 Jul 2025 10:54:22 +0300
Message-Id: <20250704075422.3219331-1-sakari.ailus@linux.intel.com>
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

 drivers/iio/dac/stm32-dac.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
index 344388338d9b..7d47c7dddbf8 100644
--- a/drivers/iio/dac/stm32-dac.c
+++ b/drivers/iio/dac/stm32-dac.c
@@ -96,7 +96,6 @@ static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
 		udelay(1);
 
 	if (!enable) {
-		pm_runtime_mark_last_busy(dev);
 		pm_runtime_put_autosuspend(dev);
 	}
 
@@ -104,7 +103,6 @@ static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
 
 err_put_pm:
 	if (enable) {
-		pm_runtime_mark_last_busy(dev);
 		pm_runtime_put_autosuspend(dev);
 	}
 
@@ -349,7 +347,6 @@ static int stm32_dac_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_pm_put;
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return 0;
-- 
2.39.5


