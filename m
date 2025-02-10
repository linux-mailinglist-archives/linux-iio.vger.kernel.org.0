Return-Path: <linux-iio+bounces-15234-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 551CDA2E494
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 07:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874D83A75E2
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 06:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E1D1C3BFC;
	Mon, 10 Feb 2025 06:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FyHPZdwc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C97C134BD;
	Mon, 10 Feb 2025 06:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170228; cv=none; b=q1IzN1YdfTZukavnaHmX/b5OEuFRe+iWP23Weyu832TLwxqp5JfRBF0PkjnPhCpsFBmV/2raZk3fs+v5bMo+ve27J/3TCXRqyFPFopLCNRiN0WeT45PcLpFIeJa1X8cL2iO0duo6KfbEuFdEjPkRnp7eiIu2aJstkx53pze8ZTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170228; c=relaxed/simple;
	bh=LiGS3+6W4VSmf7HQmdSuxLihLsGhBnmgTm1eWOTnPMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uGafuUlgd1V8NtV2qUsRSV3tPeUrLr6B4lllDNXKVXHRMlakBiwVSNTQSvro+/Wfjk0pG8RicJZFQOsChu9k5LTRvDt3qdbrhJBPMgPuVMmMOVfnxhKwfjn7nakEQmtzULivsPki4zzmlupj0Sbx5oQ2DqaWXJ0BQnwA69m7bGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FyHPZdwc; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739170227; x=1770706227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LiGS3+6W4VSmf7HQmdSuxLihLsGhBnmgTm1eWOTnPMo=;
  b=FyHPZdwcy6BOPym7wtTZMFNYen2KvK6dotxSf3346edWyBrEKbTLAt9i
   sbr+TLNhBQl+71gxzfyIZ0hQeZbFMu0oenpgyru4M7kJT6+8ColHWvDV+
   hjn1Cu6gor/QQMdYh0AX/YR1BOJD/qqx93tRoSnm1N31iUZp+UaXznp2M
   klPKzFkJwOzjQE/uDIofxYkR8GytUVATZxyZQ87g8FTBVE6C4klMA/Q0L
   fxVt/JflncaUf/EMSwdslZDhGRSJuWPndcpJz3DwTSoJdX9C8cuDB5K/s
   A3xcVDqT468hRSB/n3n2s4LeoHzXW9Q2uvRTJgJqhkYED8OMYTls7UXT6
   Q==;
X-CSE-ConnectionGUID: MoIZezM2SHiAThtQNMk36Q==
X-CSE-MsgGUID: lQBj5PPZT3i1cl5JZaYspw==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="43499401"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="43499401"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 22:50:27 -0800
X-CSE-ConnectionGUID: PAEd5n4GSk6eKlzTH6Bxug==
X-CSE-MsgGUID: fLt5yuIASf2LEp5CGw7Lfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="117122596"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa004.jf.intel.com with ESMTP; 09 Feb 2025 22:50:21 -0800
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
Subject: [PATCH v4 12/20] regulator: cros-ec: use devm_kmemdup_array()
Date: Mon, 10 Feb 2025 12:18:58 +0530
Message-Id: <20250210064906.2181867-13-raag.jadav@intel.com>
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
 drivers/regulator/cros-ec-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/cros-ec-regulator.c b/drivers/regulator/cros-ec-regulator.c
index fb9643ed7a49..fb0767b33a36 100644
--- a/drivers/regulator/cros-ec-regulator.c
+++ b/drivers/regulator/cros-ec-regulator.c
@@ -138,8 +138,8 @@ static int cros_ec_regulator_init_info(struct device *dev,
 	data->num_voltages =
 		min_t(u16, ARRAY_SIZE(resp.voltages_mv), resp.num_voltages);
 	data->voltages_mV =
-		devm_kmemdup(dev, resp.voltages_mv,
-			     sizeof(u16) * data->num_voltages, GFP_KERNEL);
+		devm_kmemdup_array(dev, resp.voltages_mv, data->num_voltages,
+				   sizeof(resp.voltages_mv[0]), GFP_KERNEL);
 	if (!data->voltages_mV)
 		return -ENOMEM;
 
-- 
2.34.1


