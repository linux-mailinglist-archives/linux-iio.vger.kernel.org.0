Return-Path: <linux-iio+bounces-15240-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B017A2E4B0
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 07:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1393A164874
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 06:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14DA1CAA9C;
	Mon, 10 Feb 2025 06:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T1yo/1ps"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DD41C5F3B;
	Mon, 10 Feb 2025 06:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170261; cv=none; b=D16ThdI7Pbu0Gc+ho8nrEtRWIVKuM+feRmG8mSIhFedkdQtjHzRGGZcxba0h4UucOsLNwXq6DmABsngxW6OaZ6wco2Y8lyjXpKSKkWa8FAs5ANx2wAq8U7ZmcIabBogvS1ucfm4GIXufR5wlrUsnj6syY3E6R/6zMAr4Y2XS1YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170261; c=relaxed/simple;
	bh=e7a2cCCwX7XNrpGn1XdJxR3IeQTxmfvf2zp8jE434LA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M1R2TXiiIhO5EhwryEz4l8TUcPX2cgEwgt4gWAGCATwpn97biDLG1aVRrnV3FJ5XQE2Zn8UCY09MxwNBtoign4qqBkO0ZBgRqSVd41wtp2uHAbc7Yttw9kuybjsWDmgTCaOrbgZtceKN/Ey/B3CLzVuqxWlAdQxY+Stxcfo1rPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T1yo/1ps; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739170260; x=1770706260;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e7a2cCCwX7XNrpGn1XdJxR3IeQTxmfvf2zp8jE434LA=;
  b=T1yo/1psk9EXA/yWZgHKRUonD2q7KD0RblZUUanR0Z3cAnCM4EDJLHrK
   uUOsNTL9MoBLAvhnBqLW8dasV9pYYrxxyITQcli/7AsARkV4LvT4kEq5t
   9R106mWmcW0+Us+4JnvRmp5fjc/jIyDNabAKLs9aP2UjSkn8ufgRFT1sE
   3CiHqUGOzbEOgIcEyFvsh5HdnsrE6GerCyDZcQhL+/qffbPjji7sOuYY9
   uO3+cBQRiHtVX2rEGqnVqNx3iEx4GkxX/wGA3H2McJD2g4jELORmX7QxO
   QCooZ8bz0bkrOgz1maIjCcZx0VtkPhSPo6oz8ZYGH2SU/EodL9RwHNpcn
   w==;
X-CSE-ConnectionGUID: O8OnLhyFQVSmfwLnZCW1ZQ==
X-CSE-MsgGUID: yOur5SMYSrSV6hqFV8G9rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="43499448"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="43499448"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 22:51:00 -0800
X-CSE-ConnectionGUID: Ei79wzUjSDKA6PSrMi8McQ==
X-CSE-MsgGUID: nYvCXSGbRImAhM6wHJfPLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="117122671"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa004.jf.intel.com with ESMTP; 09 Feb 2025 22:50:55 -0800
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
Subject: [PATCH v4 18/20] ASoC: uda1380: use devm_kmemdup_array()
Date: Mon, 10 Feb 2025 12:19:04 +0530
Message-Id: <20250210064906.2181867-19-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210064906.2181867-1-raag.jadav@intel.com>
References: <20250210064906.2181867-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to use devm_kmemdup_array() and while at it, make the size robust
against type changes.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 sound/soc/codecs/uda1380.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 4f8fdd574585..c179d865b938 100644
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
+						sizeof(uda1380_reg[0]), GFP_KERNEL);
 	if (!uda1380->reg_cache)
 		return -ENOMEM;
 
-- 
2.34.1


