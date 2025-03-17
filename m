Return-Path: <linux-iio+bounces-16924-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 327A8A63A71
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 02:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F34F188F179
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 01:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB50E78F43;
	Mon, 17 Mar 2025 01:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kECd/zRq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58AA23AD;
	Mon, 17 Mar 2025 01:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742175419; cv=none; b=by6dM13SMUilLXsY5H2Rb5Bk1bOXPTi137iGUzEC94PnGhcs6L/DT0AiB2vpgolH2esTVOPPdvjUfSKuYELY4RyIhg/Wdx76lx1Q6ZgXR5697bX1F9MaVGy/a9Y4gbEckFwmXy046CAeycNQ3ecxFZeWu1rF7yUeTzbOIgbcyQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742175419; c=relaxed/simple;
	bh=6UZEFdgCJ54WqRAxf9tT/iQiD+Qv6fVPWFP9fDbyJRA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PX7CbxthEtggEP3OXl/PpXtCsSqlbBK1JTU7eyclb2+LnNn3jZt0IS0IZxqES7LxUAksokdRzEQ44RXYBD7M1apYwTeM9XYCNL8QjLrBrBOzSKipcU0VQGEE+UKGAcsrCqQ2Z8XBISbxG3wTAga70F7iMHGrV6SftgZ57jkFyk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kECd/zRq; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742175418; x=1773711418;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6UZEFdgCJ54WqRAxf9tT/iQiD+Qv6fVPWFP9fDbyJRA=;
  b=kECd/zRqDnGhSgShFy067LYWdIMtTgOt9ByEVIUeBxMQMm/QdrGfpE2h
   tBeAzSjNPfW/ZHd/VN3sBmOf9th6cu+hR+wzcBxMudp2l8M2sedwmT5IO
   zf5uYvHZ9GjW7bD4/+xH8vJYx6YCJJo7qc43jcLDwz/4Ko2lEeGmiquZB
   AndZJw4glusm2BA35jp6yJx9RppQ/kKT0s+0aMFzf1F+yNO7loYeVX+p3
   ZJwhF0gg0UVMY3kw2OTTDr3OD1h9M8u6wJK/iGQiS3h1/+KHkIRSVh+aV
   otvwLILA2n+lVXBAbiIU9qDpdTW+exIDNhBTRj3K/M8YQm3qyw12pFBMO
   g==;
X-CSE-ConnectionGUID: geEQ5cLxRMSqDZOS2V5olQ==
X-CSE-MsgGUID: jaYRb5BpSPG143WijSGPEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="54252440"
X-IronPort-AV: E=Sophos;i="6.14,252,1736841600"; 
   d="scan'208";a="54252440"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2025 18:36:56 -0700
X-CSE-ConnectionGUID: cvy8ZCcWSIS4MMrYXyY53Q==
X-CSE-MsgGUID: Ed2r1ljBQw+xaRmtb26f4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,252,1736841600"; 
   d="scan'208";a="121795588"
Received: from shsensorbuild.sh.intel.com ([10.239.133.18])
  by orviesa006.jf.intel.com with ESMTP; 16 Mar 2025 18:36:54 -0700
From: Zhang Lixu <lixu.zhang@intel.com>
To: jic23@kernel.org,
	jikos@kernel.org,
	srinivas.pandruvada@linux.intel.com,
	lars@metafoo.de,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lixu.zhang@intel.com
Subject: [PATCH] iio: hid-sensor-prox: Add support for 16-bit report size
Date: Mon, 17 Mar 2025 09:36:34 +0800
Message-Id: <20250317013634.4117399-1-lixu.zhang@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Intel platforms, the HID_USAGE_SENSOR_HUMAN_PROXIMITY report size is 16
bits. This patch adds support for handling 16-bit report sizes for the
HID_USAGE_SENSOR_HUMAN_PROXIMITY usage in the HID sensor proximity driver.

Previously, the driver only supported 8-bit and 32-bit report sizes. With
this change, the driver can now correctly process 16-bit proximity data,
ensuring accurate human presence detection on platforms where this report
size is used.

Signed-off-by: Zhang Lixu <lixu.zhang@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/light/hid-sensor-prox.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 76b76d12b388..3a7b48803d50 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -213,6 +213,9 @@ static int prox_capture_sample(struct hid_sensor_hub_device *hsdev,
 	case 1:
 		prox_state->human_presence[chan] = *(u8 *)raw_data * multiplier;
 		return 0;
+	case 2:
+		prox_state->human_presence[chan] = *(u16 *)raw_data * multiplier;
+		return 0;
 	case 4:
 		prox_state->human_presence[chan] = *(u32 *)raw_data * multiplier;
 		return 0;

base-commit: eea255893718268e1ab852fb52f70c613d109b99
-- 
2.40.1


