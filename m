Return-Path: <linux-iio+bounces-25487-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A43C0E85D
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 15:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A2E34FFA40
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 14:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D1130C63B;
	Mon, 27 Oct 2025 14:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZMIk6eBx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1688530ACEC;
	Mon, 27 Oct 2025 14:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575943; cv=none; b=rxIBBUIy83eqs5XvkxCQxF8IxsTFmbyQM5w4BbnU0myvlqOu6xLswxOmDo9oDm2fXFbf7Tjor90VGOWKMaLUEA/6154m6MdJ2vLlWmYxNyiqh8a7HUtfYEtAOkTF407A+vA3l7rrgaZvEmkQaNv4Xn07FBAq19Z+CrQS7w9HjVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575943; c=relaxed/simple;
	bh=0mf6KVr/j+MOBfxqbaBzUm0ypZGxlXyGgTneCJcNaf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r1zHohN2neI09cYLzAtnNYKCHyqlYPio3f0re3XZqeqIuqwhG0vgGd5XvH4J656a5raR+skYPzzc6014+BEv+D6/H/8lgjdJJYFeZ3UjDzRQyS3m/oziTof9PTOyzrFVZnjdGtXjntooc5D5KIf3dkORi3yQGtbhfvgMvnIotQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZMIk6eBx; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761575941; x=1793111941;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0mf6KVr/j+MOBfxqbaBzUm0ypZGxlXyGgTneCJcNaf8=;
  b=ZMIk6eBxzJyWYeWNs4Ag8zaMmmsei9ZLQpUlEuxGCNufA3eq0VsBZsob
   /V3BJ4UirKJrB4E7Mip3tstGFNrHCpXiox4umSBNqbgEcR2/BN4MAwal9
   WzfCOd0+dG50Uxk63LcGvgBy8UHzDSnKyRAwMAsSrIz2J5ZJ1ceg8qcDj
   0c5m46VWgAMkwnYpzJV7qRWEJAxAjQZ2fmrGjfAFzcI9Z4r0v9XpyFSUh
   FisnI4o8LZvFmNfYtDhG6YeRHeesxmUvFe/0KuBAjkBrGx7KbFaxYw18k
   /R+ZA8q2bwik+LYMa/qqxxmRmnoc4eL2yzZ4bUguoE8UA7UTAJC7y0yz7
   g==;
X-CSE-ConnectionGUID: cQBkssl/Q3y3CyrK+djgwg==
X-CSE-MsgGUID: fj7IYf+mQnyumR9tBvbB2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67299503"
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="67299503"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 07:39:00 -0700
X-CSE-ConnectionGUID: bu4SSwf0Tuq5K1xZT9spYw==
X-CSE-MsgGUID: Gb8a2lmTQkuVLnzjbCuitQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="208673521"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 27 Oct 2025 07:38:56 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 632509B; Mon, 27 Oct 2025 15:38:53 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Subject: [PATCH v1 6/6] iio: position: iqs624-pos: Convert to use PI definition
Date: Mon, 27 Oct 2025 15:34:55 +0100
Message-ID: <20251027143850.2070427-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251027143850.2070427-1-andriy.shevchenko@linux.intel.com>
References: <20251027143850.2070427-1-andriy.shevchenko@linux.intel.com>
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
index 8239239c6ee2..da432d1b515c 100644
--- a/drivers/iio/position/iqs624-pos.c
+++ b/drivers/iio/position/iqs624-pos.c
@@ -15,10 +15,11 @@
 #include <linux/notifier.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/units.h>
 
 #define IQS624_POS_DEG_OUT			0x16
 
-#define IQS624_POS_SCALE1			(314159 / 180)
+#define IQS624_POS_SCALE1			DIV_ROUND_UP_ULL(PI, 1800000)
 #define IQS624_POS_SCALE2			100000
 
 struct iqs624_pos_private {
-- 
2.50.1


