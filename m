Return-Path: <linux-iio+bounces-14888-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D11A253EE
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 09:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0102E1603C4
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 08:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4BB215078;
	Mon,  3 Feb 2025 08:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SQv85Tyi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5410C21506C;
	Mon,  3 Feb 2025 08:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738570245; cv=none; b=omoWzX1lzpdO/7XLx5XrWnwXNQutcRcs342Reov+hZE27IGjEP4PJq3vU/lVgBX5HI5Mtk0MAkGthIasA9l1S0BR6In62k32PdBi1Ym8Rxkrr1vuVq3ocs0hECXPPhx3PTqtAeGWE5wf+Ke75oQSZl+G53TApEcUN93CrXgRJQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738570245; c=relaxed/simple;
	bh=osYNPECt2NJFFaG54NjxK78EI7YpCDkzUhRVQve+W+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PwSBodN1lbHw8dC67hWC8WgLLz6TPNl+p7IgZvnLDyH004SYMYHq/r2m2thb0YpUjILy06XPmJjE0ezJ3MOrrXvRlw2HB8Px4RP+UDwN43krnI+EzcV0e8oxxVlkSqXaxIynan4elFfXW7I5/rmxmnUsM+eECDYmqsLA4MBvJR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SQv85Tyi; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738570242; x=1770106242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=osYNPECt2NJFFaG54NjxK78EI7YpCDkzUhRVQve+W+k=;
  b=SQv85Tyi4P8qA3tST0rpUuZ6OH+a5+Y9E14TZY4Kn0L8K5UcJz/KxqxU
   9KfI69Ci6Nj9uM2hqf6IOPQ0/dk/n69RRn9oNlHAc2vGySWOYSL+Y9Yfm
   YqHgaXOQNPZ+z+LVccYeEgec2Q6qtulrgTBvI7waycvPfmgc6QABdy3KL
   7+JJYpdXhsS2JDETa7wZMTGm6mUpbuNI01Q8xGDkBHOzu8zBsuAE5C7tE
   vQnkCBYkcqOLmKHcJchXBtFvdVXOZybsJSTMkI/gO/btbGNxQHm8l76rv
   SVjzcTI0UN6ltZyA04KWNbRs4ENHnenzHLoYYkEaE8znvrbu2jEhK08z1
   w==;
X-CSE-ConnectionGUID: V8zhPs9dSyqe7jgUXAL1Zg==
X-CSE-MsgGUID: pCn1yIdATsGJrKl7P/3pgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="49654298"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="49654298"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 00:10:42 -0800
X-CSE-ConnectionGUID: H2NTkx2JRNOaYMuy3cRZbA==
X-CSE-MsgGUID: kt9jnhW/QeyExPb8/XYvlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="110788944"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa009.fm.intel.com with ESMTP; 03 Feb 2025 00:10:38 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	linus.walleij@linaro.org,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	dmitry.torokhov@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	sre@kernel.org,
	jic23@kernel.org,
	przemyslaw.kitszel@intel.com
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3 18/20] ASoC: uda1380: use devm_kmemdup_array()
Date: Mon,  3 Feb 2025 13:39:00 +0530
Message-Id: <20250203080902.1864382-19-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250203080902.1864382-1-raag.jadav@intel.com>
References: <20250203080902.1864382-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to use devm_kmemdup_array() which is more robust.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 sound/soc/codecs/uda1380.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 4f8fdd574585..6b474f9ee7c4 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -766,10 +766,8 @@ static int uda1380_i2c_probe(struct i2c_client *i2c)
 			return ret;
 	}
 
-	uda1380->reg_cache = devm_kmemdup(&i2c->dev,
-					uda1380_reg,
-					ARRAY_SIZE(uda1380_reg) * sizeof(u16),
-					GFP_KERNEL);
+	uda1380->reg_cache = devm_kmemdup_array(&i2c->dev, uda1380_reg, ARRAY_SIZE(uda1380_reg),
+						sizeof(u16), GFP_KERNEL);
 	if (!uda1380->reg_cache)
 		return -ENOMEM;
 
-- 
2.34.1


