Return-Path: <linux-iio+bounces-11628-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3699B68DF
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 17:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3876284C7A
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 16:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2913B2141DC;
	Wed, 30 Oct 2024 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JFBaNX3w"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AE61E2838;
	Wed, 30 Oct 2024 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730304483; cv=none; b=L/vXbKsxtMxIkaMAMOTeabtm+6FOwpVjdMWg5pW8lhXuyifHFW9tuNyox9i5QVvr2zy/XJUe/gomAwupPni0uHAIFqutNVI64L1/QnlMZiTmqEo56dXZAMwLw/+9Im40nReLuVOEs3m36PPgyK3pLM/Dh2ghs0tZ8iawWhFcxrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730304483; c=relaxed/simple;
	bh=sG3ot16sMv9t5rM8f8rGAEaq9yO+g6GPx5PBiVGBZvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=um+OfWfBWv7YxSBGP5pED6Z5e4r9LNqZkSspFleJf9bUZuGaAB+JxyaYm5Dqox2C4nD+V4qp35gezZ4CcNaMN16eWMbnFbNo5vOO/E1KhrqkfpKjgTNlDVL1dIGzptms1hbL26NyeOKB62oPGKLYQts/H4u9nUk4dN8negWLjJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JFBaNX3w; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730304483; x=1761840483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sG3ot16sMv9t5rM8f8rGAEaq9yO+g6GPx5PBiVGBZvQ=;
  b=JFBaNX3wSA9Z9dDdybmB5LCjU5QqNa+Wj5bro5LVycYdsZ6dwUlsIvgc
   rsMaE+eUSjOrCxZ00inLJHz9ORrz/qPo/dCIYfFotFjtJxAu6054ikFog
   /w/PaRXmXZpH93MeUeHCxNJQEBR2g19LPXjDYxQM0d5LfSFQygNgZNLI5
   Vk38GvyLBT1VHuaBMOpY6/PkjKtad54zAzcIdVcjNv84bikuYUB/ZDdTi
   AmcyBq4JLpIzlQMlKn0Dwqhgl0xSeRjhwmq682tqvEE6Q45uoKfAUxewr
   i6vYfaEVGianhusCjYhnWvZLtrbKElVobOVedip1zdyWDk2AYUZODhQP/
   A==;
X-CSE-ConnectionGUID: htsrnKQpSHODfbuVvj3Fkg==
X-CSE-MsgGUID: j9T3qg5HRzulIkZISrVCTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30165101"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30165101"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 09:08:02 -0700
X-CSE-ConnectionGUID: s8IUe0R6THCIt2UwyPMhxA==
X-CSE-MsgGUID: 3Ziq6GkVSeO1mMUzfIma2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="113212711"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 30 Oct 2024 09:07:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6BF8131D; Wed, 30 Oct 2024 18:07:58 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 3/4] iio: accel: kxcjk-1013: Deduplicate ODR startup time array
Date: Wed, 30 Oct 2024 18:02:19 +0200
Message-ID: <20241030160756.2099326-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241030160756.2099326-1-andriy.shevchenko@linux.intel.com>
References: <20241030160756.2099326-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The content of kxcj91008_odr_start_up_times and kxcjk1013_odr_start_up_times
is identical, deduplicate it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/kxcjk-1013.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 3d24d4fb6621..27c83c17931a 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -193,23 +193,6 @@ static const struct kx_odr_start_up_time kxcjk1013_odr_start_up_times[] = {
 	{ }
 };
 
-/* KXCJ9-1008 */
-static const struct kx_odr_start_up_time kxcj91008_odr_start_up_times[] = {
-	{ 0x08, 100000 },
-	{ 0x09, 100000 },
-	{ 0x0A, 100000 },
-	{ 0x0B, 100000 },
-	{ 0x00, 80000 },
-	{ 0x01, 41000 },
-	{ 0x02, 21000 },
-	{ 0x03, 11000 },
-	{ 0x04, 6400 },
-	{ 0x05, 3900 },
-	{ 0x06, 2700 },
-	{ 0x07, 2100 },
-	{ }
-};
-
 /* KXCTJ2-1009 */
 static const struct kx_odr_start_up_time kxtj21009_odr_start_up_times[] = {
 	{ 0x08, 1240000 },
@@ -325,24 +308,24 @@ static const struct kx_chipset_info kxcjk1013_info = {
 
 static const struct kx_chipset_info kxcj91008_info = {
 	.regs = &kxcjk1013_regs,
-	.times = pm_ptr(kxcj91008_odr_start_up_times),
+	.times = pm_ptr(kxcjk1013_odr_start_up_times),
 };
 
 static const struct kx_chipset_info kxcj91008_kiox010a_info = {
 	.regs = &kxcjk1013_regs,
-	.times = pm_ptr(kxcj91008_odr_start_up_times),
+	.times = pm_ptr(kxcjk1013_odr_start_up_times),
 	.acpi_type = ACPI_KIOX010A,
 };
 
 static const struct kx_chipset_info kxcj91008_kiox020a_info = {
 	.regs = &kxcjk1013_regs,
-	.times = pm_ptr(kxcj91008_odr_start_up_times),
+	.times = pm_ptr(kxcjk1013_odr_start_up_times),
 	.acpi_type = ACPI_GENERIC,
 };
 
 static const struct kx_chipset_info kxcj91008_smo8500_info = {
 	.regs = &kxcjk1013_regs,
-	.times = pm_ptr(kxcj91008_odr_start_up_times),
+	.times = pm_ptr(kxcjk1013_odr_start_up_times),
 	.acpi_type = ACPI_SMO8500,
 };
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


