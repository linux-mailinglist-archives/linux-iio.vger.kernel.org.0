Return-Path: <linux-iio+bounces-15239-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46096A2E4AC
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 07:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3B067A16C5
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 06:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CF51C9EAA;
	Mon, 10 Feb 2025 06:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lkMuap7x"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96F31C5F3B;
	Mon, 10 Feb 2025 06:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170256; cv=none; b=OmGuhM/yO252EF2O/rCcTX8IL+M8roCkC1dn1eV4XALprZdSvw1uTr+/B5gtUuZQc1V3YwT+6C8wySS8AMzQjSyK+2IM/KSaZY4so2u3DvfvcqsT71DDCDqOuFr6ctT1Kt98W//5qkd9rcR7sV7AGCIxy4FxFFJuQ774CrQ7aFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170256; c=relaxed/simple;
	bh=NSXN9VYfQFUizYJYR++h6usWkL8OeRS3X1QV/7FBf64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OD2vW+bn4VzKlc6JVd1HBTRHD8fwKVpj5uD15PGX0nUwLxADY1qi+d2ZOx6+wm7wbPzounRBbZWFvHnswkBb5Atlulm3z6fpGyGY9bSiC+ql4lO4YMwOW1s9CBuMDEgJQo0T4iH/DuacdK8by0MS8/BBOktfRRWFL9iiPhTbCpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lkMuap7x; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739170255; x=1770706255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NSXN9VYfQFUizYJYR++h6usWkL8OeRS3X1QV/7FBf64=;
  b=lkMuap7xCdhc/77pjJCuwIsaxQZlhNv+jmtS0fzwNoCwp/F1cnz2k7i1
   a+R1AQydmx2jEiBXJ9021FF0PvluYrmkhuYKGYNVkLUBeoxFgKDeSJF2c
   jMO0+jxyBI5qUyAKH6DR46cYySmaKj6vwpQCc26gPH5NyQbEs5VGmydwt
   J1x2wZERRPKNz1YtVrnUXMPG+Ehr/1qFF7mxIYAROoX9VTYXxt5lRMcuM
   lfooZM7GAAQ8/Ah9jEp9HbONoardhU2SYl0s9r0XEjaQJotWncidDh5CN
   N60MaHxCPCD2uzpNSRT4HcDZplFggeyXThLTydOtHgsyNVCWLVuA7QdG4
   g==;
X-CSE-ConnectionGUID: kIDRTBTKSBCJoLwuFlrl9g==
X-CSE-MsgGUID: MWQMGfVeRHWQDPkDyYFGXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="43499443"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="43499443"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 22:50:55 -0800
X-CSE-ConnectionGUID: udeWm2XeQnaSvtQ5ckvBHg==
X-CSE-MsgGUID: vbdnxsgIQw6TsqiagwaPQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="117122660"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa004.jf.intel.com with ESMTP; 09 Feb 2025 22:50:49 -0800
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
Subject: [PATCH v4 17/20] ASoC: tlv320dac33: use devm_kmemdup_array()
Date: Mon, 10 Feb 2025 12:19:03 +0530
Message-Id: <20250210064906.2181867-18-raag.jadav@intel.com>
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
 sound/soc/codecs/tlv320dac33.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index fa46f51d4341..423b9264a205 100644
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
+					      sizeof(dac33_reg[0]), GFP_KERNEL);
 	if (!dac33->reg_cache)
 		return -ENOMEM;
 
-- 
2.34.1


