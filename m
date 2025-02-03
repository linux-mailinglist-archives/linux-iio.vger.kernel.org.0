Return-Path: <linux-iio+bounces-14887-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF75AA253F8
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 09:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 381F33A6EAD
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 08:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5273221505D;
	Mon,  3 Feb 2025 08:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hSFT0hmr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A09205E18;
	Mon,  3 Feb 2025 08:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738570239; cv=none; b=Uo22OW+am6KkjfKAAMde5FzoKSWCSG0WUzGOYnswdIL1n/1ZKBTHaiB/cCAPjASSlf5n+ADMJU4vO5LvmNiJpgfqDYJdMn8tZWiuKk+V6DEKTcCZUPlZhYGcwPkWkNt6t2FnjeMHoUVYGALn/9XKDhlxu1YiySd/0AIWBPvbIq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738570239; c=relaxed/simple;
	bh=YdqnTr2rPm7FyKb62Hpv7YlIAZc7xKVdAJkW5E7jtWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VknvLpjgV1rgCjD+MY21MP5E4TSBE4g2htrmxdxCSOvwKmZzkaMMPV0ZzwhyvRytBakP/DzIVYjlcNwnzLPG0MCevBTHGOSYoGkBPG+IwiJ9m4ihYc/OsD+Yl22x6SP1fBxmVysFTSmzRigS84Zo/MaCWqSjBh8uaUsot69vzYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hSFT0hmr; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738570237; x=1770106237;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YdqnTr2rPm7FyKb62Hpv7YlIAZc7xKVdAJkW5E7jtWc=;
  b=hSFT0hmrIfK/T51Jz4xJuilC3xnHSQ2uZJ9Dc6rEuQe7AzoRFf03y0Cb
   bFY1HSjz2WOV8BQ8qi6xQr2HifNcjybF/bVhN47F3XkOe0d6qIzJo7ZlK
   d101xH01SBCwi8BnPnyCcGNpOvNk8AUeeSRaiCfQl+NnU1gCFDa6Fklhn
   gNFA0eyAtds81DAuxmdmhw2RAqs6EM90+9asCeOy4seCXMYIwb6rkhKVW
   KX4/ai4clpB1qzZAQfuZQZdKXov8uI1hRsLW/dLtCv+Kbs8jivrtABt7F
   vx0nfCZI/+U45rt1c51UjHKDEvwBeeKnQ2KaDQ4NdaOoxgxeXtR87MTr2
   g==;
X-CSE-ConnectionGUID: obIXHe3VQle/k6wRRDnMlA==
X-CSE-MsgGUID: 1QBWEawYSIyminIuFXuG6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="49654267"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="49654267"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 00:10:36 -0800
X-CSE-ConnectionGUID: mQCNLdbUTYeduS8GSLQszA==
X-CSE-MsgGUID: XZGEtlSuQbenDxaz3aUobg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="110788920"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa009.fm.intel.com with ESMTP; 03 Feb 2025 00:10:32 -0800
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
Subject: [PATCH v3 17/20] ASoC: tlv320dac33: use devm_kmemdup_array()
Date: Mon,  3 Feb 2025 13:38:59 +0530
Message-Id: <20250203080902.1864382-18-raag.jadav@intel.com>
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
 sound/soc/codecs/tlv320dac33.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index fa46f51d4341..3919f8b14995 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -1477,10 +1477,8 @@ static int dac33_i2c_probe(struct i2c_client *client)
 	if (dac33 == NULL)
 		return -ENOMEM;
 
-	dac33->reg_cache = devm_kmemdup(&client->dev,
-					dac33_reg,
-					ARRAY_SIZE(dac33_reg) * sizeof(u8),
-					GFP_KERNEL);
+	dac33->reg_cache = devm_kmemdup_array(&client->dev, dac33_reg, ARRAY_SIZE(dac33_reg),
+					      sizeof(u8), GFP_KERNEL);
 	if (!dac33->reg_cache)
 		return -ENOMEM;
 
-- 
2.34.1


