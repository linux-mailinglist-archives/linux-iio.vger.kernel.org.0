Return-Path: <linux-iio+bounces-15404-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05ACCA31EDB
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 07:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B131888D5C
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 06:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD123201110;
	Wed, 12 Feb 2025 06:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XEuxkF0t"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D072010EE;
	Wed, 12 Feb 2025 06:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341561; cv=none; b=VGtimHbEu4+dCcFARQHST3qcr9krG8vVcMbuCbXiPReA6FtNPU/ky2qNyHHHgDvT6uCaBP38/fxdQG299pal6ZMqkXL9nzeq7vGWjnnoSIgdnIO9KP4FKh9f3cuFSFvcPSez+Chl2fzI+cgxu+TBkMm84Tp3EGQ/T93XwMdE/aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341561; c=relaxed/simple;
	bh=0GTAFR5PURoBnt701bKnn8CM0d1hlX0pwGmk2rGeaZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W4nOWjxM/U5oiopf7+Ve2dq12prKy2OHJRCS2DWHhmFe/oXAR/CnfBxcifSLgoGCl8TKGOEww0xtt1dybM9SYR5qrpdzldIoSE6wwFtY8nYPmKwQ0zby/HtTPDE98zEAl9SegA4WvmfRBCs3/90Iwp/1ecolVYWjKG13az14bu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XEuxkF0t; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739341560; x=1770877560;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0GTAFR5PURoBnt701bKnn8CM0d1hlX0pwGmk2rGeaZg=;
  b=XEuxkF0tJ3BeTfh2/TpACNHJguwiag/OKkH/rZ72VaImRPvrJQkLveyo
   hLwtJLwe1Ks5SKqgzqBGzCy82nrkxYIzRegxFN/pagpdF6qWg3xtn6C2k
   E1REKdOIrEhLgCDE/gQZYZGVemrcSTF33HgJvJZKKPo9k151LhySQDBvf
   V1mKlE/SDvW0z5/dSEnBuibzBY6qJMXkGAlwpTeGFiylIaH/xxHN/3G3E
   Q9pJRwxoYrSJMOAUkFRV5/K2s5L6F0bqIV3JBBs112pqzIki62bkSdUIw
   yLDMq3JT/N37+BA+O2X4jagVf00Mm+r3Mjv8e1Y15r/hbfTh8xJzWurIv
   w==;
X-CSE-ConnectionGUID: 8xvDM8nqQjuxIdbXNB+3hA==
X-CSE-MsgGUID: 0ByB8SvzTSiAsaRZlXPWWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="40005234"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="40005234"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 22:25:59 -0800
X-CSE-ConnectionGUID: a019WMu3RvKU23p17WdAfg==
X-CSE-MsgGUID: QFK+jYDNRyWtfv15W7bfQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="117812178"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa004.fm.intel.com with ESMTP; 11 Feb 2025 22:25:56 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	linus.walleij@linaro.org,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	dmitry.torokhov@gmail.com,
	jic23@kernel.org,
	przemyslaw.kitszel@intel.com
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v5 10/12] iio: adc: xilinx-xadc-core: use devm_kmemdup_array()
Date: Wed, 12 Feb 2025 11:55:11 +0530
Message-Id: <20250212062513.2254767-11-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212062513.2254767-1-raag.jadav@intel.com>
References: <20250212062513.2254767-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to use devm_kmemdup_array() and while at it, use source size
instead of destination.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index cfbfcaefec0f..e1f8740ae688 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1245,8 +1245,8 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
 		channel_templates = xadc_us_channels;
 		max_channels = ARRAY_SIZE(xadc_us_channels);
 	}
-	channels = devm_kmemdup(dev, channel_templates,
-				sizeof(channels[0]) * max_channels, GFP_KERNEL);
+	channels = devm_kmemdup_array(dev, channel_templates, max_channels,
+				      sizeof(*channel_templates), GFP_KERNEL);
 	if (!channels)
 		return -ENOMEM;
 
-- 
2.34.1


