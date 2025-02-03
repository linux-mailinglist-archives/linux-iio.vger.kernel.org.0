Return-Path: <linux-iio+bounces-14880-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4142A253C5
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 09:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94A81646FE
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 08:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAEE207E08;
	Mon,  3 Feb 2025 08:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NqCM5DY7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4421C1FC7E6;
	Mon,  3 Feb 2025 08:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738570199; cv=none; b=KEMfOmqKvoIzvWpBBsxi3KHBPQCq2h7OO6BzzvbRL679XHgnX10u3B+hg+Y6HhQaUVbTTA91G+wtN0QJgnnVqRWmfJxZ4e/jdYdgcdiRWYWXNMqdT3pcUEJQN3yRRgQHTtACNambVztM/GwkoBsb/IiSUMwSvG6ViPbMlB0ChWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738570199; c=relaxed/simple;
	bh=fgCvIpitlnQqJjFwUxFyC+YDES2IYehK3oonOwVVBKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n0mXball7Govb/xdNKY9HhQ8lpNEcb3QjkDapemLCgSioawbxBsxPCoI/95w+aV8gpavQwrf/Hvdd7zzcTGr6eZgIvXF1lsNdEOqEilduslUJ/sfKkMNxGbq46EqiUAtnmyeWp566a9Be4QgB4D64kDCQZ3ORojqKv624WRuSeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NqCM5DY7; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738570198; x=1770106198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fgCvIpitlnQqJjFwUxFyC+YDES2IYehK3oonOwVVBKM=;
  b=NqCM5DY7UgHv+jBwAAnSrjy/4rE6n8p6ui8ic0AsBuP/O4q7Kl4/tEZX
   b4WSvpTbDojXSZ8ouxSgPO2ZI0NxFrBh/cboN2ahLzGfcxJpSFxqpHkvj
   V0Gik0Bk1PK5Pc3OYtTRn/lXfVUyHw+zo6YUq9X04kay2z2767VeLGAzO
   51aZcefqH9EA0gygdX7JXTSf9SVjORPHCojC3D1Yl8y7GgTbzaYTA7f+b
   /0br7cHf22APu8EwK/nZ4RyjmGop8qGAQwDVplsftX8K9uA2kGx10tDLh
   /PjikZtZbFZakmIseybv/ruK5Q0SEZFCwedAia0MdvtavQ5wvqiXt6+E4
   w==;
X-CSE-ConnectionGUID: FgC6xjRNSB+X5jaoI5TnOw==
X-CSE-MsgGUID: D4OnmaTTSy2y2Z/60RR1jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="49654179"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="49654179"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 00:09:56 -0800
X-CSE-ConnectionGUID: 0bZJtZXrTOOauKBbPJ1z6w==
X-CSE-MsgGUID: eWR+hLh+TzmmAZaeDzo7Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="110788573"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa009.fm.intel.com with ESMTP; 03 Feb 2025 00:09:51 -0800
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
Subject: [PATCH v3 10/20] input: ipaq-micro-keys: use devm_kmemdup_array()
Date: Mon,  3 Feb 2025 13:38:52 +0530
Message-Id: <20250203080902.1864382-11-raag.jadav@intel.com>
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
 drivers/input/keyboard/ipaq-micro-keys.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/ipaq-micro-keys.c b/drivers/input/keyboard/ipaq-micro-keys.c
index 58631bf7ce55..ca7ec054b1ce 100644
--- a/drivers/input/keyboard/ipaq-micro-keys.c
+++ b/drivers/input/keyboard/ipaq-micro-keys.c
@@ -102,9 +102,8 @@ static int micro_key_probe(struct platform_device *pdev)
 
 	keys->input->keycodesize = sizeof(micro_keycodes[0]);
 	keys->input->keycodemax = ARRAY_SIZE(micro_keycodes);
-	keys->codes = devm_kmemdup(&pdev->dev, micro_keycodes,
-			   keys->input->keycodesize * keys->input->keycodemax,
-			   GFP_KERNEL);
+	keys->codes = devm_kmemdup_array(&pdev->dev, micro_keycodes, keys->input->keycodemax,
+					 keys->input->keycodesize, GFP_KERNEL);
 	if (!keys->codes)
 		return -ENOMEM;
 
-- 
2.34.1


