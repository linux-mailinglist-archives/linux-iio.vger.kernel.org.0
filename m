Return-Path: <linux-iio+bounces-14875-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7230A253A8
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 09:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7C1B1642E7
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 08:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEF4202F7E;
	Mon,  3 Feb 2025 08:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ipN4ks+X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E68E1FAC23;
	Mon,  3 Feb 2025 08:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738570168; cv=none; b=Reaf39scZs/xAp2M/65BOjklwy6WnR8Fbn7EL9cVn3iZg6qDRSOHCRBltwtWZB3xHXkh9iFl27Y0eokSH+MrxGFkczTQwCtNM/L3oCSZOOnTj80YbRAzrHuXG5u6C08/7vw1W01D3uFpyWQHm4hvpOnzfzRuiqj9x4zvQ2xFhq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738570168; c=relaxed/simple;
	bh=WCHPCMsEFr8fFCx9hS+57kpPs9vJIZEITYsuAOqFO8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=re7ZfLizms9Ffjp4hgzBh3tc2YXW6TysxHSUTXSxjz4HYPbSMjP1czbXqmFEPH1TWiFtY2Hoecc6ODKr9oj1CFVDQXl4c6cRYNNWFp4HTQ9ft40x/eC4X8/JJn5zvWy+6PTDNHydCc9UdSGvdVZ67cEimedG+hPA8Aw8VmuzBr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ipN4ks+X; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738570167; x=1770106167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WCHPCMsEFr8fFCx9hS+57kpPs9vJIZEITYsuAOqFO8A=;
  b=ipN4ks+XWO/u+Q0ryhZPY4OED/QPr5aR/wAQJaSkrX7QPNqNiO6BnlBP
   ul6cjuO1zSmtKNlllKAlkMd9xGgKUWwqwCV6sc3RjyA8PU7URms3kUZMl
   zWDCxjxBzvZ8oPrpLR5B0jfHA1AQbAhfA1kYEkxnjqSt17SvryUi6QqUb
   if7VCoN6JDtHDZJncaskndgnrx1IXuXYACV6LNl3eMg3td9md8yJvk3f8
   wci0aYXVBSFFXFZ2kqkEbMdQ+sNPXUdwgWnb7rI9IJc6ftBsNeb/He5wx
   Yt1dtHk18tKSn0HjogEUP57kdL9oa6NY+vi5ESCTC5fuYd4k/GMrVjrlu
   g==;
X-CSE-ConnectionGUID: zseztHnCRqqRntrBWD88Ww==
X-CSE-MsgGUID: BYxXyorpQsW9Fyc4INF8Iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="49654132"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="49654132"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 00:09:26 -0800
X-CSE-ConnectionGUID: J1JwmQZ9RrqYiALGfzEaPw==
X-CSE-MsgGUID: G9/fLFKfQjWdk5IjBKvTNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="110788497"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa009.fm.intel.com with ESMTP; 03 Feb 2025 00:09:23 -0800
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
Subject: [PATCH v3 05/20] pinctrl: baytrail: copy communities using devm_kmemdup_array()
Date: Mon,  3 Feb 2025 13:38:47 +0530
Message-Id: <20250203080902.1864382-6-raag.jadav@intel.com>
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

Copy communities using devm_kmemdup_array() instead of doing it manually.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pinctrl/intel/pinctrl-baytrail.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
index 7340dc20349c..797315fee29a 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -1557,16 +1557,14 @@ static int byt_set_soc_data(struct intel_pinctrl *vg,
 	vg->soc = soc;
 
 	vg->ncommunities = vg->soc->ncommunities;
-	vg->communities = devm_kcalloc(vg->dev, vg->ncommunities,
-				       sizeof(*vg->communities), GFP_KERNEL);
+	vg->communities = devm_kmemdup_array(vg->dev, vg->soc->communities, vg->ncommunities,
+					     sizeof(*vg->communities), GFP_KERNEL);
 	if (!vg->communities)
 		return -ENOMEM;
 
 	for (i = 0; i < vg->soc->ncommunities; i++) {
 		struct intel_community *comm = vg->communities + i;
 
-		*comm = vg->soc->communities[i];
-
 		comm->pad_regs = devm_platform_ioremap_resource(pdev, 0);
 		if (IS_ERR(comm->pad_regs))
 			return PTR_ERR(comm->pad_regs);
-- 
2.34.1


