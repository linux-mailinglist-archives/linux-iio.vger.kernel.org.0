Return-Path: <linux-iio+bounces-21455-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B34AFDBA5
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 01:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A57947AE105
	for <lists+linux-iio@lfdr.de>; Tue,  8 Jul 2025 23:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12E82528E1;
	Tue,  8 Jul 2025 23:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZuQX7f7I"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CB6238C10;
	Tue,  8 Jul 2025 23:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752016322; cv=none; b=f5Rc/IsOFKKZPG6f1BFlAokfIaYW0W0dSzZtWWsMunDscYADBrotfG/e3hxW5g0w9guzrdwfjlnxueZeoWU+0AHd+KGgAtoIo1Gv1LF9SdbPTr4EECPjK2ID8FxPsm9Zrp/Cbttss2MUzd9Ufnvhzb6oQMTHX7B+FvUPGmgcyEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752016322; c=relaxed/simple;
	bh=F43DrlOFqpVCv/gcMSySHNfblub8XfWCe+WeSdLWo7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VlAwOYk2yFe9cQtgEN+j+blYgYsoDfRzCaJmSOejruz67SJFv0N5Bfm7fEa7BF6iz7yw/3eLWgnKcilg2onufUgL0a2+MoTPMNWG6jn2d72PTom49168iOy3efOvvV9UTK4ieOX2ksSRcYsi921fMqUZ/JWtagKzxbsRJVc/qCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZuQX7f7I; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752016321; x=1783552321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F43DrlOFqpVCv/gcMSySHNfblub8XfWCe+WeSdLWo7M=;
  b=ZuQX7f7IggCPcjQbKTIHDkj+HR9CcSIoa2o1jjAkwx03MOw8kYnGe5Fc
   sSWoJp55aSJo4SoVO00uthMnLMTWRLDHC8fM90xRdbnMQB8SY365ari+A
   yMJJFQieUIvHymHT6uN4n5NcGVmHP3VyTnuAjfXDOrJ+3Qe7xkvBkjAph
   DZluawoOg+KGXe+uT6Fb31+C+IbUaVoR0E6Dvo2knOBx8Ag48L0Mf9ZGr
   nOsazgymzNeAIog9O7SCtPfJEL1l/6/sLMawFl+0ZuZWl7H10R7m9jOu+
   29GkR7R+xNIfiizK+Jmxcz15iFJX46ta6lAcyfWyjs3Bz+flz9oIl4HwY
   g==;
X-CSE-ConnectionGUID: y9ERFumKQdGt2ILOqHCVyQ==
X-CSE-MsgGUID: 0ZL7BdXETJqUDuK+Nf28uA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53986894"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="53986894"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 16:11:58 -0700
X-CSE-ConnectionGUID: 6ayOncwjQAmKapZsXhhAqQ==
X-CSE-MsgGUID: a2iii1U6R8SgIWzW2rSfoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="186622612"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.102])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 16:11:56 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 9DBD21211BE;
	Wed,  9 Jul 2025 02:11:52 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uZHTc-0044kN-1z;
	Wed, 09 Jul 2025 02:11:52 +0300
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
Subject: [PATCH v2 05/12] iio: dac: Remove redundant pm_runtime_mark_last_busy() calls
Date: Wed,  9 Jul 2025 02:11:52 +0300
Message-Id: <20250708231152.971550-1-sakari.ailus@linux.intel.com>
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
 drivers/iio/dac/stm32-dac.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
index 344388338d9b..0988c991cf60 100644
--- a/drivers/iio/dac/stm32-dac.c
+++ b/drivers/iio/dac/stm32-dac.c
@@ -95,18 +95,14 @@ static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
 	if (en && dac->common->hfsel)
 		udelay(1);
 
-	if (!enable) {
-		pm_runtime_mark_last_busy(dev);
+	if (!enable)
 		pm_runtime_put_autosuspend(dev);
-	}
 
 	return 0;
 
 err_put_pm:
-	if (enable) {
-		pm_runtime_mark_last_busy(dev);
+	if (enable)
 		pm_runtime_put_autosuspend(dev);
-	}
 
 	return ret;
 }
@@ -349,7 +345,6 @@ static int stm32_dac_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_pm_put;
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return 0;
-- 
2.39.5


