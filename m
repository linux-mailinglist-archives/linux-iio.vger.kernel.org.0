Return-Path: <linux-iio+bounces-14884-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D763A253E4
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 09:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B9343A6FF0
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 08:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849222147F1;
	Mon,  3 Feb 2025 08:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bislhA4x"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954CB1FBCB7;
	Mon,  3 Feb 2025 08:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738570221; cv=none; b=DLy6y2cRNytp/VzBFfO6NLcMIc58GFwyMLDdhPnwncjprNIIfaVxLxqHyyM3+X6P3tOrOb+1vXWLsNWYkCBdzqTqOvcxfS3Z1mRngJi3g0ClJ/GueMLyM4aGrwCKHiLROsjr+oxQLJ1EC9ARX5AKsiC/yf5yg3T27cFEOyDO0Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738570221; c=relaxed/simple;
	bh=7yNXXj2joe0QnJTG3Dlzjs8Ni2YWpcCwxOQhZkxakVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d2wCnW51dBYezara7F05wXiRcZdl6juugdIW6Fq4fRT0Vy0VGHBZfm2xF35pi0W6+3UoXnWAhRFdxfSqHq3cYtd7HM2gKG/iRuWGuzIyY0DfFxzl+9yCQyqi7PfIZ+Th3VH7+pQOcmJg3oNEv3F7yH8aE4LQjM0ewH1D7s78WRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bislhA4x; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738570219; x=1770106219;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7yNXXj2joe0QnJTG3Dlzjs8Ni2YWpcCwxOQhZkxakVQ=;
  b=bislhA4xAaps4wEXWb7p8B77t5XE9rIeIYPAA/O1u3blSZtnd+0SYWhk
   CvP9vZ8QsDY1+DMq2J39P38h5N7qZjjvI8J3imZPTHQONC+jDi5A3MHH4
   yZsCYAAwFm/PqcSX6kvNFV1fpEQ+7/oKPPtmxSc1CzT7T2s74YSxx/WFq
   mOyceYjwz2cWynvMDF1YveZ7wGz0vPARM2oFU++NR8URMVCvAmo7R6W6u
   IOcsuhXKC1Bf5Cjl3TOldIaErcC52CaAB2ogioHEdQ1VeVogBu7sPU2od
   CGrJaw6rEBzs0bThs0jO7X1rJAC3PQ53a+NhUC5kWTSchb7EXU+iuiuUp
   Q==;
X-CSE-ConnectionGUID: mjbou0XWQv6pf5W9nRAhzA==
X-CSE-MsgGUID: iRavrkCORX6lnNT6QUpgog==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="49654215"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="49654215"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 00:10:19 -0800
X-CSE-ConnectionGUID: r9oSOE54SWmA5ruZX0KYJg==
X-CSE-MsgGUID: iZSJaTK+Qsa4kwqQ0aDFOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="110788783"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa009.fm.intel.com with ESMTP; 03 Feb 2025 00:10:14 -0800
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
Subject: [PATCH v3 14/20] iio: adc: xilinx-xadc-core: use devm_kmemdup_array()
Date: Mon,  3 Feb 2025 13:38:56 +0530
Message-Id: <20250203080902.1864382-15-raag.jadav@intel.com>
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
 drivers/iio/adc/xilinx-xadc-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index cfbfcaefec0f..4a47d1ded64a 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1245,8 +1245,8 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
 		channel_templates = xadc_us_channels;
 		max_channels = ARRAY_SIZE(xadc_us_channels);
 	}
-	channels = devm_kmemdup(dev, channel_templates,
-				sizeof(channels[0]) * max_channels, GFP_KERNEL);
+	channels = devm_kmemdup_array(dev, channel_templates, max_channels,
+				      sizeof(channels[0]), GFP_KERNEL);
 	if (!channels)
 		return -ENOMEM;
 
-- 
2.34.1


