Return-Path: <linux-iio+bounces-1515-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD1D828C19
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jan 2024 19:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 376701F268F2
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jan 2024 18:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A243C06B;
	Tue,  9 Jan 2024 18:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xidoo9Il"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF4A3BB2C;
	Tue,  9 Jan 2024 18:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704823221; x=1736359221;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V+4Z2SI36gE5bFYHxH+Q/B+lJZGmrb1RKuRByt2yuxA=;
  b=Xidoo9IlLjL0Q8OS2pw8JkhBL1mEWWCDmNeHIBE1x3MzkcWO2L3A7E1Q
   d3jppCopGtJe12SbXbVEq+gsoTfI+yv2IGoXO0oYSems5vES0K5RIqXPc
   +J7jFvFx1BCBKZv3AuCInFAFZ/MoW3Q9b7BPiGlO46yRvwbUTX+dq7ICG
   z4QY9ozHnZmfNWeeEZ3/A1PPVKOtKvby5B3q5T12O/sUnSpkBXG+asY1f
   s3CZ/Rwlrb5GCuTplvVBaHTE97LvfTOUD/09WO3d77PjYyKdEAv+o97SB
   K0rKqyQtvCwOJO0uwEvpQfKZZNHWjGKtxxkKL7h/R3R+/pxtwgw92QhiL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="429458616"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="429458616"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 10:00:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="852269566"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="852269566"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jan 2024 10:00:18 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	lars@metafoo.de,
	Basavaraj.Natikar@amd.com
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 2/4] iio: hid-sensor-als: Remove hardcoding of values for enums
Date: Tue,  9 Jan 2024 10:00:05 -0800
Message-Id: <20240109180007.3373784-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240109180007.3373784-1-srinivas.pandruvada@linux.intel.com>
References: <20240109180007.3373784-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove hardcoding of values for enum CHANNEL_SCAN_INDEX_INTENSITY and
CHANNEL_SCAN_INDEX_ILLUM.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v3:
New patch. Added as the next patch removed the hardcoding of enum values
when submitted. To remove unrelated changes, created a patch to just
remove hardcoding of values.

 drivers/iio/light/hid-sensor-als.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 72a7c01c97f8..a7bde6b68102 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -14,8 +14,8 @@
 #include "../common/hid-sensors/hid-sensor-trigger.h"
 
 enum {
-	CHANNEL_SCAN_INDEX_INTENSITY = 0,
-	CHANNEL_SCAN_INDEX_ILLUM = 1,
+	CHANNEL_SCAN_INDEX_INTENSITY,
+	CHANNEL_SCAN_INDEX_ILLUM,
 	CHANNEL_SCAN_INDEX_MAX
 };
 
-- 
2.43.0


