Return-Path: <linux-iio+bounces-25486-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE6EC0E7E6
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 15:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEBD81887809
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 14:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C3830C36E;
	Mon, 27 Oct 2025 14:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kTOd9Q2K"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0D33090CA;
	Mon, 27 Oct 2025 14:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575942; cv=none; b=hFxQKNMIWKzGOl9V9y/WwZMVp2DD5fsYHYqR8B8bde9XstmUpflz7Q9a+eyK2zt3VbPYXBNAmGITN2NSq5gzcBNyyGfcjOoPaIakSUIcMdIgFaVlDuuH+VU0Py1PeFy6fXr4Mhl0dM/W/EuY9lRQPBDdxgpQI1/Qf7pXhy0jByQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575942; c=relaxed/simple;
	bh=avO4KxU32Xlunsqyq7BmWvOS2Y5h0UKNDU8DR6pAnGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qn6c/F1nUg8FA4ZH8qQcJPDWwsZ1Lj2sA/xGlzdX71Anv8mcNcI2A9O9lp4pVMPFVS4T0nNQYiAzugmDjvoCfq5hN+7MKyH5jHAvkSihPrnrTdlrrSLZ8AhwoagAup3JHqWGK+9YF0P7+rlWgI1AeXIgapoHBoOJ5TBoHukWNrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kTOd9Q2K; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761575941; x=1793111941;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=avO4KxU32Xlunsqyq7BmWvOS2Y5h0UKNDU8DR6pAnGI=;
  b=kTOd9Q2KLZTvjKEe5N34ACLZ1uzIlUw7iEO7LaUn0qNjLKhFAdPa2kaw
   6qsGjyxGPSvAMKT2/uddGxty6YcDPMquraSFk9dKXUZggKLbP12gURPre
   +BJjKxqyYnC66xT13luLBe4NjAMadoXbIN/jXXaCLyTaLe7VnNRNhesmY
   ts+XMHQrO9mr3OYCDCdEg97o4Wdr48/4aCPBd6OxTtZMcWg42dQckYA8P
   WNTp8f6eEzi/gf4GV+FoyxduJMsQXioEXNnl3yKRUv3q8Dm5Ha2KXypzD
   BTT4sRNBXozWXi/VoRDw7ZG1bF1MtCCLqAv5Jjr8UKO5ty4cnN4KFtx2n
   Q==;
X-CSE-ConnectionGUID: Jy3F5rlSSqWAwMtgDToXJg==
X-CSE-MsgGUID: wjYsmwwDTxmvNhJU7pmoDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67299499"
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="67299499"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 07:38:57 -0700
X-CSE-ConnectionGUID: 14+sqHWdR4m8zXTHKhpQtw==
X-CSE-MsgGUID: 4Brf0ud8TmumEX8E11mt7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="184756643"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 27 Oct 2025 07:38:53 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 55B4298; Mon, 27 Oct 2025 15:38:53 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Subject: [PATCH v1 3/6] media: dvb-frontends: atbm8830: Convert to use PI definition
Date: Mon, 27 Oct 2025 15:34:52 +0100
Message-ID: <20251027143850.2070427-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251027143850.2070427-1-andriy.shevchenko@linux.intel.com>
References: <20251027143850.2070427-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to use PI definition instead of open coded value of it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/media/dvb-frontends/atbm8830.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-frontends/atbm8830.c b/drivers/media/dvb-frontends/atbm8830.c
index 778c865085bf..74032364d183 100644
--- a/drivers/media/dvb-frontends/atbm8830.c
+++ b/drivers/media/dvb-frontends/atbm8830.c
@@ -6,7 +6,8 @@
  *    Copyright (C) 2009 David T.L. Wong <davidtlwong@gmail.com>
  */
 
-#include <asm/div64.h>
+#include <linux/math64.h>
+#include <linux/units.h>
 #include <media/dvb_frontend.h>
 
 #include "atbm8830.h"
@@ -112,7 +113,7 @@ static int set_if_freq(struct atbm_state *priv, u32 freq /*in kHz*/)
 
 	if (freq != 0) {
 		/* 2 * PI * (freq - fs) / fs * (2 ^ 22) */
-		t = (u64) 2 * 31416 * (freq - fs);
+		t = 2 * DIV_ROUND_UP_ULL(PI, 100000) * (freq - fs);
 		t <<= 22;
 		do_div(t, fs);
 		do_div(t, 1000);
-- 
2.50.1


