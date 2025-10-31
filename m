Return-Path: <linux-iio+bounces-25715-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE52C23984
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 08:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9ECB406354
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 07:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A88F329C53;
	Fri, 31 Oct 2025 07:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mLZ5ZGOQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA179329E70;
	Fri, 31 Oct 2025 07:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761896707; cv=none; b=GostI2qkWAgDHIxmtKSPearwuhl53wqe/vC3NvBSN6bW2vax1eXBTX5MScKYclFtS+kg1fwxEaQv0s1iqx/UJhgTSuM3uE+fgLTrXTdC7P0FFqsQAsPSZXry/53d2ihokGiwRGpnxRPL9SruwwL7GLZGsr7OcqrkzfJcoOSz4Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761896707; c=relaxed/simple;
	bh=DIa0t7rQHt59sCQtcDI0ZpiS1egH2dMVWGrfPPCEM4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j/D933tBVaByy594/2cVUi+TgX1lAKI9GQtUb2CMAQbOEkjS/kglJIAqc599j1B7/eqdKMOy9ZgOaaTR50LLox/pA/+15MD4oRSa8a1s0QhyBAKKeSNzzxXR8rfk6677uzt9SWe5m8PEtn0228qVc8FBwfTy1OpxZxQgJVd0MxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mLZ5ZGOQ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761896706; x=1793432706;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DIa0t7rQHt59sCQtcDI0ZpiS1egH2dMVWGrfPPCEM4o=;
  b=mLZ5ZGOQEdTfJO4TVDfaznIzZZdB52m1Qh4E5jpcoWRtL8c5puxk1ncy
   K5qM5vsoZbYgLt9gaBzb9TiL8/MUWFgMZE1zxfQmhY+QxhCpFILomLqjq
   vBAnYJ/H97aAZrFtrtlH4Jwk5XRwVNB+WIaH/xXbhoYYiP11MxMh+9F8H
   jOPUYQO9MBB490EpGiZsaVd8Or04mUtsIuD1sneBJ4wJDnO0X2R6VmXMZ
   n10rxtYtczD7t7xIN5iRbAz8gdmFE2hcilBkQOTB9nh/2q3LLmiD+ljoi
   9PfYOsYY1Vlmu5evT1BOT8E2TEoeO2k47xul0jGhWHIR8YMSGziv0FELw
   Q==;
X-CSE-ConnectionGUID: XJLtxn9qR7G57HFbUhF0Mg==
X-CSE-MsgGUID: X7QZ4b0vS9yRNfGuRUyg3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="51624589"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="51624589"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 00:45:05 -0700
X-CSE-ConnectionGUID: L+dVuAYcTsyc3RdXURjhGQ==
X-CSE-MsgGUID: Y+8N4W3yRwSOLMK7kTPntQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="186285126"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 31 Oct 2025 00:45:03 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 2977F95; Fri, 31 Oct 2025 08:45:02 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jyoti Bhayana <jbhayana@google.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 1/1] iio: common: scmi_sensors: Replace const_ilog2() with ilog2()
Date: Fri, 31 Oct 2025 08:45:00 +0100
Message-ID: <20251031074500.3958667-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

const_ilog2() was a workaround of some sparse issue, which was
never appeared in the C functions. Replace it with ilog2().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/common/scmi_sensors/scmi_iio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
index 39c61c47022a..b40c6d6442e6 100644
--- a/drivers/iio/common/scmi_sensors/scmi_iio.c
+++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
@@ -69,7 +69,7 @@ static int scmi_iio_sensor_update_cb(struct notifier_block *nb,
 		 *  Converting the timestamp to nanoseconds below.
 		 */
 		tstamp_scale = sensor->sensor_info->tstamp_scale +
-			       const_ilog2(NSEC_PER_SEC) / const_ilog2(10);
+			       ilog2(NSEC_PER_SEC) / ilog2(10);
 		if (tstamp_scale < 0) {
 			do_div(time, int_pow(10, abs(tstamp_scale)));
 			time_ns = time;
-- 
2.50.1


