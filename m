Return-Path: <linux-iio+bounces-13064-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D27D9E30CC
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 02:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF432B23D96
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 01:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C62F507;
	Wed,  4 Dec 2024 01:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SbBHyb1i"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2922500B8;
	Wed,  4 Dec 2024 01:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733276187; cv=none; b=CnwclujkyT28pU5UgqPK7HEdv3MpbE6X97GDdKez7alBP+AfppzpTSaBsbH864kmRtBWMC48xx7hmFeO4Rv+04ynRj+9E7/IMyZh7aOo1lJWui8rYxoT2IVa1iZy/gOuBnyT+Eo3IqhMOSoMpxc70OzkWohrFFaJOyzadCbGMxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733276187; c=relaxed/simple;
	bh=mjLYAJWAsJEP7C3SPxpA96ZZvMOvnlODGBD00nA+UHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ko5PIChUvJhhXrZyLREDyAdXNgWHbXxs9Y6LGAiyUVOCIh46OZSVAbjrFbyjJwILFqnVvYSDbzhDD4QzhIDWwgMrd43+hixf3hLjiPJKBz0buPbUYHFn2azRnuEcK0WxehnccOJgEU31O9qrm1Bp5sAG1eKT9a7ZsI7zjbya71w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SbBHyb1i; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733276186; x=1764812186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mjLYAJWAsJEP7C3SPxpA96ZZvMOvnlODGBD00nA+UHI=;
  b=SbBHyb1igaqH9TxUAM5ODMj5UKCreJzK958PqscnzMGipsosa+i0DXFP
   S2Yyj6C3BlzjRwOtzkXbjHHNpa0yWZsJO27Gi0VEq0REcsTA/zyYfqh3+
   YB4djkMiqWfhuWHD+VOOlH9tPUWcXkM+fU0N52AFKc/Y9XM4uput4rVaE
   09jiUvzTMz4cNS3CY6suLic/M1au+94PYuLJV2Perj1wTgEE3sNOEQrEt
   0j6okyOfqTEGk1GixGc7qbjupnEA9+PeV5f4XSJVRauca05bYknS2pZ7i
   tJdUXSYFcWFVGnnJWoJVndIdy6TF/kjQdiQNHWOpDvrYaGobu17XvSFBY
   A==;
X-CSE-ConnectionGUID: elPpvnXTQsOSjkNHnzd2hw==
X-CSE-MsgGUID: aYVDXF+vS4W2H3EHd1IPtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="37293577"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="37293577"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 17:36:25 -0800
X-CSE-ConnectionGUID: FqNcxhpARV+GxDMfSicfZA==
X-CSE-MsgGUID: 2rjJOPfDRUe/t+A2j89SUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="98694830"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 03 Dec 2024 17:36:23 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2790842D; Wed, 04 Dec 2024 03:36:22 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 2/4] iio: afe: rescale: Don't use ULL(1) << x instead of BIT(x)
Date: Wed,  4 Dec 2024 03:33:17 +0200
Message-ID: <20241204013620.862943-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241204013620.862943-1-andriy.shevchenko@linux.intel.com>
References: <20241204013620.862943-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ULL(1) << x is just an open-coded implementation of BIT_ULL().
Replace the former by the latter.

Note, the rest of the code properly uses BIT()/BIT_ULL() already.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/afe/iio-rescale.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 470dd7d41b2a..9d33e7aabe4d 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -8,6 +8,7 @@
  * Author: Peter Rosin <peda@axentia.se>
  */
 
+#include <linux/bits.h>
 #include <linux/err.h>
 #include <linux/gcd.h>
 #include <linux/mod_devicetable.h>
@@ -62,7 +63,7 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 		if (scale_type == IIO_VAL_FRACTIONAL)
 			tmp = *val2;
 		else
-			tmp = ULL(1) << *val2;
+			tmp = BIT_ULL(*val2);
 
 		rem2 = *val % (int)tmp;
 		*val = *val / (int)tmp;
-- 
2.43.0.rc1.1336.g36b5255a03ac


