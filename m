Return-Path: <linux-iio+bounces-12038-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1019C20D1
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 16:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD0941C23092
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 15:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061A421A717;
	Fri,  8 Nov 2024 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LeT8uUh3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382441E5708;
	Fri,  8 Nov 2024 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731080589; cv=none; b=KjuvM/of2k6C7zjfXEeb501FR+kiZRuFJcGurP32hYnYdM+dml8mi087wf+Rj7aD+LX7MW4QcEkzYKqVA6IosgjAw6vmHf3MEL2gRdoKzJvnoddthvtRbwp2e/NeDDhTAoTEaZoJUqxU9GnF8YJDQ7IfFjFoGgnvWCnXIwPGf0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731080589; c=relaxed/simple;
	bh=NzE5MSJ2xz8N9ugZtUdKSolSCu1jOrtA4IXvq5aMGu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mj5W593eLmeQ/4PrRi5y7+31UC4zKxJHKGCP2+5YwObLi3rmwjt8jIEOJMlbh/MAwqtx30S6CG89qTu0aWDsAc7ZGI6/1pHFF7HwBbuAd5+sj2do34MAHM0cVAFsjUk0SvMR+PH8paAoXz2M0gAkmoIrM+jzl9ggQH4w7i++kVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LeT8uUh3; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731080587; x=1762616587;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NzE5MSJ2xz8N9ugZtUdKSolSCu1jOrtA4IXvq5aMGu0=;
  b=LeT8uUh3ddRmnyJRON7PPTdUjU+4fOvz7Gno3Z1pqqhbERTtSbbKKdRo
   KIv1UzzUjn/nyW2DlLUQ32HNVt3WgWZN9nuWhSGqS11S+Nln/Cpc42Hyo
   KubovXQkeAWBMFNJPDn4jYNWpKGr2s7I91+4ffWYxOzxAz2OqnIthkdlE
   Kst7kfcWyikXazWcL57oyJZAft1HeDWxu+sq/pu2+NEQDrI67lVrs8AR5
   xwm2VpH/pMMZJ8SPq346G8iee6B+7gJKnNp6TPKnvdTImM96UHbig8UiB
   vjGUtZbxfpqAiuB66nspRsZHmFWO5o1lnzqm2JtBvJfsniaW9jhDtYTtY
   w==;
X-CSE-ConnectionGUID: Z/LzXZgPSdiwQ7YCXJC4Cg==
X-CSE-MsgGUID: rrYipEuDTxS3WdTif9EhMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11250"; a="30365246"
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="30365246"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 07:43:06 -0800
X-CSE-ConnectionGUID: IYN3AeMwRJu/7kq/oChlUw==
X-CSE-MsgGUID: bL+cn89fTCCpMoIrqWsAGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="90460017"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa005.jf.intel.com with ESMTP; 08 Nov 2024 07:43:04 -0800
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.246.238])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 422E22876E;
	Fri,  8 Nov 2024 15:43:02 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: megi@xff.cz,
	Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	hpa@zytor.com,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	kernel test robot <lkp@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH] iio: magnetometer: fix if () scoped_guard() formatting
Date: Fri,  8 Nov 2024 16:41:27 +0100
Message-ID: <20241108154258.21411-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stephen Rothwell <sfr@canb.auug.org.au>

Add mising braces after an if condition that contains scoped_guard().

This style is both preferred and necessary here, to fix warning after
scoped_guard() change in commit fcc22ac5baf0 ("cleanup: Adjust
scoped_guard() macros to avoid potential warning") to have if-else inside
of the macro. Current (no braces) use in af8133j_set_scale() yields
the following warnings:
af8133j.c:315:12: warning: suggest explicit braces to avoid ambiguous 'else' [-Wdangling-else]
af8133j.c:316:3: warning: add explicit braces to avoid dangling else [-Wdangling-else]

Fixes: fcc22ac5baf0 ("cleanup: Adjust scoped_guard() macros to avoid potential warning")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409270848.tTpyEAR7-lkp@intel.com/
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
I have forgot to add this patch prior to the cited Fixes: commit,
so Stephen Rothwell had to reinvent it, in order to fix linux-next.
original posting by Stephen Rothwell:
https://lore.kernel.org/lkml/20241028165336.7b46ce25@canb.auug.org.au/
---
 drivers/iio/magnetometer/af8133j.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/af8133j.c b/drivers/iio/magnetometer/af8133j.c
index d81d89af6283..acd291f3e792 100644
--- a/drivers/iio/magnetometer/af8133j.c
+++ b/drivers/iio/magnetometer/af8133j.c
@@ -312,10 +312,11 @@ static int af8133j_set_scale(struct af8133j_data *data,
 	 * When suspended, just store the new range to data->range to be
 	 * applied later during power up.
 	 */
-	if (!pm_runtime_status_suspended(dev))
+	if (!pm_runtime_status_suspended(dev)) {
 		scoped_guard(mutex, &data->mutex)
 			ret = regmap_write(data->regmap,
 					   AF8133J_REG_RANGE, range);
+	}
 
 	pm_runtime_enable(dev);
 
-- 
2.46.0


