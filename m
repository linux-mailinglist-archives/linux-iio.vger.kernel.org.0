Return-Path: <linux-iio+bounces-14710-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43642A2202E
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 16:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 684B43A728B
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 15:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CA31D90A5;
	Wed, 29 Jan 2025 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I8ZlZlA/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2044518C31;
	Wed, 29 Jan 2025 15:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738164353; cv=none; b=khzsyme4c1QqPwLwsC9T/vov2aXlvX7YCaLZBo98WMOJXbUDe4aJoPPGIafWfFYpplBpRLWSrCKoE2jI3q0j1agKfI+4vD4PVednaEuSTyRDRKg3PfU7xPKSYvcNnwFBv0fOUG9XIR6TskYGfUgbnGxLCrdZSNG4SoKSVpr7PpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738164353; c=relaxed/simple;
	bh=X16MjgM7SqdQR1M8yfJ1zKv8z/F8zjPQTiuvwd/8EAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkVqALcnRQt03g8xmOeobuncTv3mtkYYlhT8IenULst5xQRKVwUub5/HlUSWA9St5A1+Gi7j9/sAyfvaRXTDofDWmc9ILgAVWS9azaWxQwPm/GjQgVosSiyUGvQpAPq7QU6RuDb0r8HLV3ldRiU7Ipm00xL9zecEs8sY2eL7spA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I8ZlZlA/; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738164352; x=1769700352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X16MjgM7SqdQR1M8yfJ1zKv8z/F8zjPQTiuvwd/8EAE=;
  b=I8ZlZlA/KSoQXqV2WkFG/AeRskQFJSFLMR3q+Zr5yTzi4p6e9y+5dUA3
   o67NCqQXzO+1lJjfmB3bkYjSpCnqYeYUkTLtkqaHdjtOeblojuImJIv6Y
   3Qm+jqZTyMlg23GgJIuZqYB/NrT7KvpTJn94z9P4zrGKzINb1jBEu6ctJ
   7nFhh3HGnHXjDb1NpKEE1AW0ma4MLTegG8RtIFWyoqV7Ri1ODGf8SPmHl
   Bej3kdSFnurbu6VndM7PBZqVTUGIXCqok5poYQ46PzPGXT7/RwBNBnvFl
   9Gf93rMhU2j+gPpmssrEd5w7mo+gLaa9qrmttXb8cvSkpmjm/nvzrnwNi
   A==;
X-CSE-ConnectionGUID: N42K8ms1Q4unnbHC3OT0WA==
X-CSE-MsgGUID: umGzSEHPSiCjCG/x+kGdJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="37927619"
X-IronPort-AV: E=Sophos;i="6.13,243,1732608000"; 
   d="scan'208";a="37927619"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 07:25:51 -0800
X-CSE-ConnectionGUID: j0HEH9FpTfCTcKioZoHNqw==
X-CSE-MsgGUID: BM7J54zeQpmFfW8C2y2ySw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="132326794"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 29 Jan 2025 07:25:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E235C4C3; Wed, 29 Jan 2025 17:25:47 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Icenowy Zheng <icenowy@aosc.io>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/3] iio: magnetometer: af8133j: Drop unneeded assignment for cache_type
Date: Wed, 29 Jan 2025 17:24:41 +0200
Message-ID: <20250129152546.1798306-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20250129152546.1798306-1-andriy.shevchenko@linux.intel.com>
References: <20250129152546.1798306-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

REGCACHE_NONE is the default type of the cache when not provided.
Drop unneeded explicit assignment to it.

Note, it's defined to 0, and if ever be redefined, it will break
literally a lot of the drivers, so it very unlikely to happen.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/magnetometer/af8133j.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/magnetometer/af8133j.c b/drivers/iio/magnetometer/af8133j.c
index a70bf8a3c73b..c1fc339e85b4 100644
--- a/drivers/iio/magnetometer/af8133j.c
+++ b/drivers/iio/magnetometer/af8133j.c
@@ -383,7 +383,6 @@ static const struct regmap_config af8133j_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = AF8133J_REG_SWR,
-	.cache_type = REGCACHE_NONE,
 };
 
 static void af8133j_power_down_action(void *ptr)
-- 
2.43.0.rc1.1336.g36b5255a03ac


