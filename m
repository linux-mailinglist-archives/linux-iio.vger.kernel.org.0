Return-Path: <linux-iio+bounces-14885-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0077AA253E9
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 09:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 296F03A532E
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 08:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AD4214817;
	Mon,  3 Feb 2025 08:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YSl7irO8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9B7204C32;
	Mon,  3 Feb 2025 08:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738570227; cv=none; b=FgL/0CtKfTRg1A+LfsYoWcCo/GHQW2/XCbj3Nfj8aU1s+D1jLeZKkYExw6o4XVeFIhKmbNBziwPGmqJTf2dFmaTOwMcE3mKbf9RdEbautsK9cXk7Wg2xRggD8IbBL8HqVeStD7c44Pmp9gPBZz7C700ogiE78yAYV3KV1/MyTiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738570227; c=relaxed/simple;
	bh=/rID+RWk1vDCco+U0NssT5hH+428fhjipIysDT2gnc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qgu/2KzIm6bWYQI5fQTP2wJ73YopocSZuGXeVtvkeRj13jMYKr4t/vzstzh8oQWY0R9jagN7Wnin/Pl64absd+gmbsD5FxRnZHauP3Tild/QIg9ZmGA4p0JGWPlpcRvC9c1NDYcSugaq5lVCmAqtl4qBy7mWqP3bzMUciFd/GYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YSl7irO8; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738570225; x=1770106225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/rID+RWk1vDCco+U0NssT5hH+428fhjipIysDT2gnc4=;
  b=YSl7irO8Gls2hVrNLeOQ41Aj5aaD9y1lWA16mvy9oDjnX2yJbmsK8UQj
   oHYIerszMVB7s/M17v2HyVkYsZebEl+loqr0qwrsokMPviThJBAcrXO9a
   +uQtSTq3sEgEQroN/9NZSAqKi9WtiZgpzR5qsSQpP7rf2nRpDZLWyfWVL
   U9hagHlY4/+MOd+Ra1ir593DR5npkJr8+X71YfmtezptIPSdpZsX+RtKw
   n6lOyJfiybiwrTfS4jnwHnQtMSzBbAmpspCSRUwGhA2AryTmrUhIxhWjv
   HyDObWLpX277BwXKd490di31iexyGh0hg6BCgDRgSuGl3eDajqGkxIqIb
   Q==;
X-CSE-ConnectionGUID: b9NaDJtNQNGpWamZ/vRu4Q==
X-CSE-MsgGUID: +xDUAN0URyevdU6xVYACew==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="49654236"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="49654236"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 00:10:25 -0800
X-CSE-ConnectionGUID: osTtKT7JRreL/ki+QCuwqw==
X-CSE-MsgGUID: 08HaGt9wQ6Cojfh8FzbSUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="110788829"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa009.fm.intel.com with ESMTP; 03 Feb 2025 00:10:21 -0800
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
	Raag Jadav <raag.jadav@intel.com>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH v3 15/20] ASoC: Intel: avs: use devm_kmemdup_array()
Date: Mon,  3 Feb 2025 13:38:57 +0530
Message-Id: <20250203080902.1864382-16-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250203080902.1864382-1-raag.jadav@intel.com>
References: <20250203080902.1864382-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert to use devm_kmemdup_array() which is more robust.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 sound/soc/intel/avs/boards/da7219.c  | 3 ++-
 sound/soc/intel/avs/boards/es8336.c  | 3 ++-
 sound/soc/intel/avs/boards/nau8825.c | 3 ++-
 sound/soc/intel/avs/boards/rt274.c   | 3 ++-
 sound/soc/intel/avs/boards/rt286.c   | 3 ++-
 sound/soc/intel/avs/boards/rt298.c   | 3 ++-
 sound/soc/intel/avs/boards/rt5663.c  | 3 ++-
 sound/soc/intel/avs/boards/rt5682.c  | 2 +-
 8 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/sound/soc/intel/avs/boards/da7219.c b/sound/soc/intel/avs/boards/da7219.c
index 76078a7005b0..6920a3737ddd 100644
--- a/sound/soc/intel/avs/boards/da7219.c
+++ b/sound/soc/intel/avs/boards/da7219.c
@@ -113,7 +113,8 @@ static int avs_da7219_codec_init(struct snd_soc_pcm_runtime *runtime)
 	}
 
 	num_pins = ARRAY_SIZE(card_headset_pins);
-	pins = devm_kmemdup(card->dev, card_headset_pins, sizeof(*pins) * num_pins, GFP_KERNEL);
+	pins = devm_kmemdup_array(card->dev, card_headset_pins, num_pins,
+				  sizeof(*pins), GFP_KERNEL);
 	if (!pins)
 		return -ENOMEM;
 
diff --git a/sound/soc/intel/avs/boards/es8336.c b/sound/soc/intel/avs/boards/es8336.c
index 426ce37105ae..159d5170dc56 100644
--- a/sound/soc/intel/avs/boards/es8336.c
+++ b/sound/soc/intel/avs/boards/es8336.c
@@ -109,7 +109,8 @@ static int avs_es8336_codec_init(struct snd_soc_pcm_runtime *runtime)
 	data = snd_soc_card_get_drvdata(card);
 	num_pins = ARRAY_SIZE(card_headset_pins);
 
-	pins = devm_kmemdup(card->dev, card_headset_pins, sizeof(*pins) * num_pins, GFP_KERNEL);
+	pins = devm_kmemdup_array(card->dev, card_headset_pins, num_pins,
+				  sizeof(*pins), GFP_KERNEL);
 	if (!pins)
 		return -ENOMEM;
 
diff --git a/sound/soc/intel/avs/boards/nau8825.c b/sound/soc/intel/avs/boards/nau8825.c
index bf902540744c..cf8604ac222a 100644
--- a/sound/soc/intel/avs/boards/nau8825.c
+++ b/sound/soc/intel/avs/boards/nau8825.c
@@ -88,7 +88,8 @@ static int avs_nau8825_codec_init(struct snd_soc_pcm_runtime *runtime)
 	jack = snd_soc_card_get_drvdata(card);
 	num_pins = ARRAY_SIZE(card_headset_pins);
 
-	pins = devm_kmemdup(card->dev, card_headset_pins, sizeof(*pins) * num_pins, GFP_KERNEL);
+	pins = devm_kmemdup_array(card->dev, card_headset_pins, num_pins,
+				  sizeof(*pins), GFP_KERNEL);
 	if (!pins)
 		return -ENOMEM;
 
diff --git a/sound/soc/intel/avs/boards/rt274.c b/sound/soc/intel/avs/boards/rt274.c
index 4b6c02a40204..746ae1a4adc5 100644
--- a/sound/soc/intel/avs/boards/rt274.c
+++ b/sound/soc/intel/avs/boards/rt274.c
@@ -98,7 +98,8 @@ static int avs_rt274_codec_init(struct snd_soc_pcm_runtime *runtime)
 	jack = snd_soc_card_get_drvdata(card);
 	num_pins = ARRAY_SIZE(card_headset_pins);
 
-	pins = devm_kmemdup(card->dev, card_headset_pins, sizeof(*pins) * num_pins, GFP_KERNEL);
+	pins = devm_kmemdup_array(card->dev, card_headset_pins, num_pins,
+				  sizeof(*pins), GFP_KERNEL);
 	if (!pins)
 		return -ENOMEM;
 
diff --git a/sound/soc/intel/avs/boards/rt286.c b/sound/soc/intel/avs/boards/rt286.c
index e40563ca99fd..7f9d8c216b31 100644
--- a/sound/soc/intel/avs/boards/rt286.c
+++ b/sound/soc/intel/avs/boards/rt286.c
@@ -59,7 +59,8 @@ static int avs_rt286_codec_init(struct snd_soc_pcm_runtime *runtime)
 	jack = snd_soc_card_get_drvdata(card);
 	num_pins = ARRAY_SIZE(card_headset_pins);
 
-	pins = devm_kmemdup(card->dev, card_headset_pins, sizeof(*pins) * num_pins, GFP_KERNEL);
+	pins = devm_kmemdup_array(card->dev, card_headset_pins, num_pins,
+				  sizeof(*pins), GFP_KERNEL);
 	if (!pins)
 		return -ENOMEM;
 
diff --git a/sound/soc/intel/avs/boards/rt298.c b/sound/soc/intel/avs/boards/rt298.c
index 94fce07c83f9..11cd7c85c4a7 100644
--- a/sound/soc/intel/avs/boards/rt298.c
+++ b/sound/soc/intel/avs/boards/rt298.c
@@ -70,7 +70,8 @@ static int avs_rt298_codec_init(struct snd_soc_pcm_runtime *runtime)
 	jack = snd_soc_card_get_drvdata(card);
 	num_pins = ARRAY_SIZE(card_headset_pins);
 
-	pins = devm_kmemdup(card->dev, card_headset_pins, sizeof(*pins) * num_pins, GFP_KERNEL);
+	pins = devm_kmemdup_array(card->dev, card_headset_pins, num_pins,
+				  sizeof(*pins), GFP_KERNEL);
 	if (!pins)
 		return -ENOMEM;
 
diff --git a/sound/soc/intel/avs/boards/rt5663.c b/sound/soc/intel/avs/boards/rt5663.c
index b456b9d14665..a47beab60c47 100644
--- a/sound/soc/intel/avs/boards/rt5663.c
+++ b/sound/soc/intel/avs/boards/rt5663.c
@@ -65,7 +65,8 @@ static int avs_rt5663_codec_init(struct snd_soc_pcm_runtime *runtime)
 	jack = &priv->jack;
 	num_pins = ARRAY_SIZE(card_headset_pins);
 
-	pins = devm_kmemdup(card->dev, card_headset_pins, sizeof(*pins) * num_pins, GFP_KERNEL);
+	pins = devm_kmemdup_array(card->dev, card_headset_pins, num_pins,
+				  sizeof(*pins), GFP_KERNEL);
 	if (!pins)
 		return -ENOMEM;
 
diff --git a/sound/soc/intel/avs/boards/rt5682.c b/sound/soc/intel/avs/boards/rt5682.c
index 335960cfd7ba..d503eff827fe 100644
--- a/sound/soc/intel/avs/boards/rt5682.c
+++ b/sound/soc/intel/avs/boards/rt5682.c
@@ -102,7 +102,7 @@ static int avs_rt5682_codec_init(struct snd_soc_pcm_runtime *runtime)
 	jack = snd_soc_card_get_drvdata(card);
 	num_pins = ARRAY_SIZE(card_jack_pins);
 
-	pins = devm_kmemdup(card->dev, card_jack_pins, sizeof(*pins) * num_pins, GFP_KERNEL);
+	pins = devm_kmemdup_array(card->dev, card_jack_pins, num_pins, sizeof(*pins), GFP_KERNEL);
 	if (!pins)
 		return -ENOMEM;
 
-- 
2.34.1


