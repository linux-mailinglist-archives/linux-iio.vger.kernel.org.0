Return-Path: <linux-iio+bounces-14886-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FBEA253E3
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 09:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5C3B16478A
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 08:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B74214A93;
	Mon,  3 Feb 2025 08:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E3NyMnFd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5476F205E18;
	Mon,  3 Feb 2025 08:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738570233; cv=none; b=aPpK4NGmYLno3X0Jhcj/qbVlzhxz1HMcX6K5CQgp15vXjzCIXiz69gsu3XxYPUZOXdKEXPE7m9tL6TVtg1GifTytNeth/QrbmixUjYeC7k++4AT7OElGgJtv6Kcx9Lpnbis4YwH3AFFhMBmzEjMJMMeN1o+ueBMYZD+a7k0f5Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738570233; c=relaxed/simple;
	bh=J0ziDvMh8G35/PpGvJj7y7kCMccoXafPWLEoDTV7LnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZV4JtVHBkzvsluWdwk++UCRKoyLBDWZbHuhVIm7rxzAmu4LJfZ/TTHH4J9JlTF5z6bLQpZlWb4AaGszXo2rYXwXlRVU93ed0D1siZgAsuQ8/qnsgdFycBMmTNA/m9KGPlidyn3CQ6N6L+h2er84BosAjiumi2TP0YJ5b1LPhw00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E3NyMnFd; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738570231; x=1770106231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J0ziDvMh8G35/PpGvJj7y7kCMccoXafPWLEoDTV7LnY=;
  b=E3NyMnFdFnXf+3O7oQ7+cZOPfWs3+thE3mA+SjB3KSSOox+4WogcMst5
   AYj75nsZkS+swaE7r432JsZKAt+YAxJALmgSPPdOSp/oBJEoMjwmd1pEK
   37vElsLcWBF9YfS3z8dVCgpZD6acRcsbvQZrO6yoPVwrBW7PTBmHi89hE
   iGb0Epo2v/8Ow3B6zOMHZ1rtfg0br8cvCA1QNzPZdBpTUdLXT4ktyoWmi
   yBueeeCB8XgYASpQOQVGax4qDfjGIeVRQChoUM37H6oOkM0vcwbHMl6Pu
   b4kl6UNMZXvykVLjtc5Djj6b5OgvTy1D9sTgXTtljyhgcKk7+karrASRJ
   g==;
X-CSE-ConnectionGUID: OPBaVI0mRZC0QamzogCslQ==
X-CSE-MsgGUID: fw9bMswfQomypwiNP7lZ0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="49654251"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="49654251"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 00:10:31 -0800
X-CSE-ConnectionGUID: lXjAMuoGSfap3E0SEPMs7g==
X-CSE-MsgGUID: auL9gx7cQ6yzXYzgO6hMMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="110788863"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa009.fm.intel.com with ESMTP; 03 Feb 2025 00:10:27 -0800
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
Subject: [PATCH v3 16/20] ASoC: hdac_hdmi: use devm_kmemdup_array()
Date: Mon,  3 Feb 2025 13:38:58 +0530
Message-Id: <20250203080902.1864382-17-raag.jadav@intel.com>
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
 sound/soc/codecs/hdac_hdmi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index e1a7f0b0c0f3..a0f305a8fbf9 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1017,8 +1017,7 @@ static int hdac_hdmi_create_pin_port_muxs(struct hdac_device *hdev,
 			return -ENOMEM;
 	}
 
-	se->texts = devm_kmemdup(&hdev->dev, items,
-			(num_items  * sizeof(char *)), GFP_KERNEL);
+	se->texts = devm_kmemdup_array(&hdev->dev, items, num_items, sizeof(char *), GFP_KERNEL);
 	if (!se->texts)
 		return -ENOMEM;
 
-- 
2.34.1


