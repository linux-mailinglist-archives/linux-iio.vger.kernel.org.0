Return-Path: <linux-iio+bounces-15238-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BF3A2E4A5
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 07:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40B41164593
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 06:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208151C5F1F;
	Mon, 10 Feb 2025 06:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PSj2fxuj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB4D1C5D7B;
	Mon, 10 Feb 2025 06:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170251; cv=none; b=tQBUKbv3xvCTc+RmHXApw8QQ/+2OfAVHtR4w/xRc6vLRSmdc0aERMi9Pwc+nlp3oa9lzbiEmHm43vJb+qp5/5YBk/xjqdk2JRa7WUxDw4rx+cDOKgd/zkhd0MMJ8kskOS047933DgIxCHk7XRb8/ZTUXKms8m0tioe3F3ZDrp+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170251; c=relaxed/simple;
	bh=AUJvMFsICvoCmVfWj5JN11a/sKwael8x29G4HCF3zLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HamK/cLoUx7aDxp19nzkbVIMNhRfKpltpnM5taOjCkH30FddsPPH3MEt5PbGx2v2ku9xx9IuQc5qzey5VboPJwdQDdrxQiFjk6E5u0Xvv6Q5JtxrDyJnQPa0TxBbW7KXjlkT8ddGXGp2gfQ29giYb4fzcy/HuS7lBDUMSE+jSz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PSj2fxuj; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739170250; x=1770706250;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AUJvMFsICvoCmVfWj5JN11a/sKwael8x29G4HCF3zLY=;
  b=PSj2fxuj9OF6CXwCLtjWVQhSW96zdT1zwRT9mNhG3xHPJaYtFsjI4n94
   jFYJlbEHFkkCvUlvYUAvzyzCiB+bZD5fVqZHDkRiRXLxzUzQTXc0Udre1
   jhuxE4XNv0EQlxXsC2MUtalLAySjfwBcs1viAy6dG6qiY5QvLBjCEAhci
   18BFIFYY04hlIW0ap19Zz+iHSc220NQHgeWkkdTScIy5yaZcoZmzmz2aB
   KF0vNvXqdQzf1U3ihpnyzBmaIiQdRESQ4KZ8QeTgQJOuJnFkyDltBUMxZ
   mOibo2m3j9cEP4+0YmOY9kCZPVXjXM8KiDuIXI9+BfoENWgqLkb1kc7/c
   Q==;
X-CSE-ConnectionGUID: Lrcp+ABZQs+lW5PTVxPS5w==
X-CSE-MsgGUID: /39y549dTjGVY0NHoTamVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="43499434"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="43499434"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 22:50:49 -0800
X-CSE-ConnectionGUID: cv7smM64T62hLOrp99fIyA==
X-CSE-MsgGUID: 1gt8YbzSQs2FtQu1D0jPow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="117122652"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa004.jf.intel.com with ESMTP; 09 Feb 2025 22:50:44 -0800
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
Subject: [PATCH v4 16/20] ASoC: hdac_hdmi: use devm_kmemdup_array()
Date: Mon, 10 Feb 2025 12:19:02 +0530
Message-Id: <20250210064906.2181867-17-raag.jadav@intel.com>
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
 sound/soc/codecs/hdac_hdmi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index e1a7f0b0c0f3..3bea5d09219a 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1017,8 +1017,7 @@ static int hdac_hdmi_create_pin_port_muxs(struct hdac_device *hdev,
 			return -ENOMEM;
 	}
 
-	se->texts = devm_kmemdup(&hdev->dev, items,
-			(num_items  * sizeof(char *)), GFP_KERNEL);
+	se->texts = devm_kmemdup_array(&hdev->dev, items, num_items, sizeof(items[0]), GFP_KERNEL);
 	if (!se->texts)
 		return -ENOMEM;
 
-- 
2.34.1


