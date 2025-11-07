Return-Path: <linux-iio+bounces-26033-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 471E9C41896
	for <lists+linux-iio@lfdr.de>; Fri, 07 Nov 2025 21:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8557D3A5939
	for <lists+linux-iio@lfdr.de>; Fri,  7 Nov 2025 20:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDC1335067;
	Fri,  7 Nov 2025 20:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FDQC70Md"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC0830CD8E;
	Fri,  7 Nov 2025 20:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762546219; cv=none; b=aOa2Ufe91hDG+rJgsNoxcpjfpU0gqN4+M+mIL22kwRE2HdM/49AxOM8sWzA4kE9ngY8thp/agFN+5lQoA5b5e6GsYOaDagyCdl57wUs90EE0E+wVbRXbL9D7r3JnHZxRqkRIzd/RG2yVf66QFIGLTGSBOWpQKAPXBsOXMVmbCNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762546219; c=relaxed/simple;
	bh=ud1/96IUeRP+Bx2biumyTkRJpYJUg2NbiGKWfKUmRbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bN15oAMYFkiwUY5XeLuz2Aa0Vi9LpabRB1Jf8XHSRNJaBEHB+hHRU0p+IqW5wtQblMg8r0+Yha2WLOnqM/l4RPfdA4wkHHLj1iFZmfrnTHYqZhIG17UtMCziElZ10YLWmlEhTk3e+MflBIZQfJ69mNWX2gGo0xkv9dDVkWD8zME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FDQC70Md; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762546218; x=1794082218;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ud1/96IUeRP+Bx2biumyTkRJpYJUg2NbiGKWfKUmRbw=;
  b=FDQC70MdiAagxQ52Q0vXbe4kGgWTovn7312MI7bXM4DdrtEucW8I5elb
   pCREE2IIaRtad9hk0ZIzj++ZaB3IuBfGvjmgdCoWfbIWGTml4QrMOSLV+
   pv+B8p8fdWYiVGFNtie6GtOIaU6YNsp+dI6T8cATscxscymga4PTC3MhY
   cQhyw3/i0K6JwT2sPqbxLiVHyQ3Oei2viu5l7jCcqc17/kFM9/Cszq4yi
   cOpseQD/tUmXNI2RSOgsxLwqsGoj/GKpJ4zX45nviwo5fKs/tfxPMbHYa
   HE9Ls2blrweVzwCFWS/oOSjODhz29yJBstOqh7ICjdrO4TlLZeEzgcWyV
   w==;
X-CSE-ConnectionGUID: qVz3XKOZQAq1wPFG29QPJg==
X-CSE-MsgGUID: OgY9CKbhQ3aZd39MTah5Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="68348701"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="68348701"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 12:10:18 -0800
X-CSE-ConnectionGUID: 3jq1ptbVQAa2Kp7bUKTyoQ==
X-CSE-MsgGUID: Wnku1eHJSLu6IyykDen4gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="188285318"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 07 Nov 2025 12:10:15 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id F12BF9B; Fri, 07 Nov 2025 21:10:09 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	linux-iio@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Subject: [PATCH v2 6/6] iio: position: iqs624-pos: Convert to use PI definition
Date: Fri,  7 Nov 2025 21:03:04 +0100
Message-ID: <20251107201005.3156118-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251107201005.3156118-1-andriy.shevchenko@linux.intel.com>
References: <20251107201005.3156118-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to use PI definition instead of open coded value of it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/position/iqs624-pos.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/position/iqs624-pos.c b/drivers/iio/position/iqs624-pos.c
index 8239239c6ee2..24d7a2591858 100644
--- a/drivers/iio/position/iqs624-pos.c
+++ b/drivers/iio/position/iqs624-pos.c
@@ -15,10 +15,11 @@
 #include <linux/notifier.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/units.h>
 
 #define IQS624_POS_DEG_OUT			0x16
 
-#define IQS624_POS_SCALE1			(314159 / 180)
+#define IQS624_POS_SCALE1			(PI / 180000)
 #define IQS624_POS_SCALE2			100000
 
 struct iqs624_pos_private {
-- 
2.50.1


