Return-Path: <linux-iio+bounces-14713-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62652A22034
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 16:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 032FD7A3C72
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 15:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142531DE897;
	Wed, 29 Jan 2025 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="me7w5hWN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4D31DE2BB;
	Wed, 29 Jan 2025 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738164356; cv=none; b=XiQHyi1j3aOz/I392VpN8D4xepa2GRUV3i1QQR7N6IfJOtkBbnpVjIE8swZ73pkkNJcs6WU98AoxfnpZjnf1ZPc4PFUp/XXPzAyUZZZ1LLxb5LScdxIQwqBR0hO+M0zlyHf6AP4408FaJC0jBQJsKV5aKRe2Thtc2fTMQBD37h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738164356; c=relaxed/simple;
	bh=ajFru+rJM9W/qGPV9vDJPnDtzVXHxeG3GKD1puqa7Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0HBnfZ1bQZE4kuRhBvKiAG+YZRqEmAthGRpetsc1WY6Cl5q3svy8SnEKwmLWlWj1O9RLTbQe21U1jf2B+SyMVS+AIVYJYsTTjtstF5fYlqtBfRpQ+jSHBhSgsZKP7jDHWD2hFr7zsxw+VE0kq3adBDo8ObdkMLhFfRyzbk2YAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=me7w5hWN; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738164356; x=1769700356;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ajFru+rJM9W/qGPV9vDJPnDtzVXHxeG3GKD1puqa7Gg=;
  b=me7w5hWNrtHJr9D/HnIZdhcyKpBMVcfWzjwROJeP0ex+wAxrLZE79c9S
   etUwobCC7iOBY5xbZpBbksSUnr7P0mCwnKAlu4RnMlHaMS4D/QGRGrLRR
   Zu+tV7oHPzeN5hCj04Khwpvt/GHVt0SwkTZIU+L+B27oQeb+/rRLM4gGM
   fV985tmRsmFYbUvA1DM637+o8YK95daNpiK5ilhDARWckvtWEdiqtodRA
   Dh7oUTRZtxSRs/xdTNQAZLjxMEMt6MHaUKK1VXeMa4DfxzWwM7fIzmN7E
   lazrBs/68eujqMkpFPS0WXy8QTrt2GGDBFW3u6XI3/c9a50clEz9xfn0C
   w==;
X-CSE-ConnectionGUID: vPZHm5NmQr6ze4IivKxemQ==
X-CSE-MsgGUID: d1hVXmovQ5aFQSgDRkdwEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="37879648"
X-IronPort-AV: E=Sophos;i="6.13,243,1732608000"; 
   d="scan'208";a="37879648"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 07:25:52 -0800
X-CSE-ConnectionGUID: 52UHZjVIQuGR5FTpPPjk7w==
X-CSE-MsgGUID: QlQn4dxaTiiNgD4ODTVC5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="114051108"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 29 Jan 2025 07:25:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D908550D; Wed, 29 Jan 2025 17:25:47 +0200 (EET)
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
Subject: [PATCH v1 1/3] iio: light: adux1020: Drop unneeded assignment for cache_type
Date: Wed, 29 Jan 2025 17:24:40 +0200
Message-ID: <20250129152546.1798306-2-andriy.shevchenko@linux.intel.com>
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
 drivers/iio/light/adux1020.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux1020.c
index 593d614b1689..9240983a6cc4 100644
--- a/drivers/iio/light/adux1020.c
+++ b/drivers/iio/light/adux1020.c
@@ -118,7 +118,6 @@ static const struct regmap_config adux1020_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 16,
 	.max_register = 0x6F,
-	.cache_type = REGCACHE_NONE,
 };
 
 static const struct reg_sequence adux1020_def_conf[] = {
-- 
2.43.0.rc1.1336.g36b5255a03ac


