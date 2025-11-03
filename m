Return-Path: <linux-iio+bounces-25825-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A106C2A93C
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 09:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0733E3A7E48
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 08:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47862DC77C;
	Mon,  3 Nov 2025 08:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lAz7ASkb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A28353363;
	Mon,  3 Nov 2025 08:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762158585; cv=none; b=F5RldKBmE54CIcxWUdRLzV5HNN6wWLZnfqao3EDknUlaklTNC5d5N3mOy0KtIin7kmAA2FE2riZ1PURuveSWZnd8phIcwOcSt4BBzP6POD+YxzXR5EAWCAZzzbrqUFT/SB+OnwQHLtw2m2kDI+jgKGD2GqPxFeeDf6qkEg8A5GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762158585; c=relaxed/simple;
	bh=QaXWOKRR0oLApgRTFcnBA0aGTeHTQUruM4agZxllNWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IRSQrw5X3YSyfcI9Dn2WrQC3q+bX2PZlrEhYsrsBIHDWkSoaayS3a2pWsHeZDn5lVG++qAzdVu5zMmO2XVg+FjOrTyGY3LA65BDdWElSlqCkQjx49HfRnIfW7Wm3Um9IbrYN4/o4JKwFRiiOXM+66OP9OckTvZcM3KctV7Fvitk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lAz7ASkb; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762158583; x=1793694583;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QaXWOKRR0oLApgRTFcnBA0aGTeHTQUruM4agZxllNWU=;
  b=lAz7ASkbZAfgYKbfBKyvF/0owIbOy4wC6XZNFI2OKNhLmXE0Cj1gRHJN
   NnpbeVnTdJDSTrtJ42OUIe5xY/R/1d3KuUvktxskYxIfyud6s/LmWYgQ5
   9VIIFuJ+DAOUOY3BklHUMzU3O1Zwng6sQrHK8JxollOQBnPsCJWJjA7Zq
   JWmrc3oaX+GQCAm9nTizvpgOgKBelqj8NdQRUbyICn9WPBO0GhnDxggq2
   xeIDMILp8DMn6F0BPEAog3LASdDBITiGRlnS8dOs18ATy8Rzcu40LHHbO
   ylzUbmn9eVO78nPtcibXxmm3vxH6jpOb3IQQjfsjFFS3a6RHYTvvnrBTj
   Q==;
X-CSE-ConnectionGUID: 2PbWFI/xTkGoWSkBIP6dYg==
X-CSE-MsgGUID: s8lVYVApRxON4+dqr47+ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="74906927"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="74906927"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 00:29:42 -0800
X-CSE-ConnectionGUID: PEZxTFVEROiUnEwgRUTbfw==
X-CSE-MsgGUID: 6fZ8levTRtSjBB2soH1qMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="190902577"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 03 Nov 2025 00:29:40 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 7154E95; Mon, 03 Nov 2025 09:29:39 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jyoti Bhayana <jbhayana@google.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v2 1/1] iio: common: scmi_sensors: Get rid of const_ilog2()
Date: Mon,  3 Nov 2025 09:29:11 +0100
Message-ID: <20251103082937.4081863-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fisrt of all, const_ilog2() was a workaround of some sparse issue,
which was never appeared in the C functions. Second, the calls here
are done against constants and work with a bit of luck. Replace
this altogether by a pre-calculated simple integer constant.
Amend a comment to give a hint where it comes from.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: Rewrite the patch completely (David)

 drivers/iio/common/scmi_sensors/scmi_iio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
index 39c61c47022a..5136ad9ada04 100644
--- a/drivers/iio/common/scmi_sensors/scmi_iio.c
+++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
@@ -66,10 +66,9 @@ static int scmi_iio_sensor_update_cb(struct notifier_block *nb,
 		/*
 		 *  Timestamp returned by SCMI is in seconds and is equal to
 		 *  time * power-of-10 multiplier(tstamp_scale) seconds.
-		 *  Converting the timestamp to nanoseconds below.
+		 *  Converting the timestamp to nanoseconds (10⁹) below.
 		 */
-		tstamp_scale = sensor->sensor_info->tstamp_scale +
-			       const_ilog2(NSEC_PER_SEC) / const_ilog2(10);
+		tstamp_scale = sensor->sensor_info->tstamp_scale + 9;
 		if (tstamp_scale < 0) {
 			do_div(time, int_pow(10, abs(tstamp_scale)));
 			time_ns = time;
-- 
2.50.1


