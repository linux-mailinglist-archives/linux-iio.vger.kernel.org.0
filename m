Return-Path: <linux-iio+bounces-9083-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FEE96A612
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 20:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F5A52826DC
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 18:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9692919047A;
	Tue,  3 Sep 2024 18:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YA+Oqlw1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D318E19006A;
	Tue,  3 Sep 2024 18:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725386548; cv=none; b=i/pWVRVsaOOM95TcIKXjpopwpozYzNEFxUjboTQMfxjHEQUYxKL3Qr352/sUWIVXbu61a5J1+1l6L48BGSz7Id8vQ6m6lgdErEaoghOC2Tp3kcQ9iKQvKaoPZdpVKbiXRKbZPejCCm0OhawWWu+8+b+9bYUs8lOlNB517iRod4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725386548; c=relaxed/simple;
	bh=7jLwmtWp8ZSFRPOhBYTZo6CTSRQHjJth6niaXlzmqtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bS0eCB7pvEQIUUAe5TUKgjb6E0ekjerjERzvHAOiTCyhlAm53USt6XZbXBVatBrpNCpY43e7e6je0abTxafxXcCKWbqn14sznmcw8NNBYflo5U6bFyZ5s33QTj16lWQJWVeWhjggt+exr90Ta+kLZsVNbRIERT2RYXli7Hb4ySI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YA+Oqlw1; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725386547; x=1756922547;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7jLwmtWp8ZSFRPOhBYTZo6CTSRQHjJth6niaXlzmqtQ=;
  b=YA+Oqlw1jC+huHOcEWZXTUgMMhbpXbdG22bT37AQ8wJG5qt2stf3BcSV
   /6h7vf7p8Lt2YQcMiVhaiJvjKb5X4Fv7EhH0FMFWqIARi+Kd4kDkk1XlC
   pZ9SxK4R82us4q+fskfrjRuRjCDg/yzhKOeiUH5R8vjjBaWNUAvRSgWNq
   u/HHIkeyxzsyFYLcN+MeIkSQ1tD2PoelKUBr+Jediz4GYdI7mAggDOvb8
   uxTdCFaZRXqkIjNKIWhBA8ZHcEaoIWxSU+NPB2UYbQG2A71tnwH/49/wF
   InR2Iw1BBTwMFbGhH/sKZQTziGF4HDARWwd4+rwNnwADXQSHMUvjqJbJ8
   g==;
X-CSE-ConnectionGUID: 6tr8S37RRLmYX4rQDuhVBQ==
X-CSE-MsgGUID: KxLx0hvZTaCbtoc/R5OaHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24194278"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="24194278"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 11:02:25 -0700
X-CSE-ConnectionGUID: Vj9eRJj1RBGdeXdjfuQ+WQ==
X-CSE-MsgGUID: 717iswrTRcGNTG1jFDtdJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="69151345"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 03 Sep 2024 11:02:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A8C731FA; Tue, 03 Sep 2024 21:02:21 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH v2 1/3] types: Complement the aligned types with signed 64-bit one
Date: Tue,  3 Sep 2024 20:59:04 +0300
Message-ID: <20240903180218.3640501-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240903180218.3640501-1-andriy.shevchenko@linux.intel.com>
References: <20240903180218.3640501-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some user may want to use aligned signed 64-bit type.
Provide it for them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/types.h      | 3 ++-
 include/uapi/linux/types.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/types.h b/include/linux/types.h
index 2bc8766ba20c..2d7b9ae8714c 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -115,8 +115,9 @@ typedef u64			u_int64_t;
 typedef s64			int64_t;
 #endif
 
-/* this is a special 64bit data type that is 8-byte aligned */
+/* These are the special 64-bit data types that are 8-byte aligned */
 #define aligned_u64		__aligned_u64
+#define aligned_s64		__aligned_s64
 #define aligned_be64		__aligned_be64
 #define aligned_le64		__aligned_le64
 
diff --git a/include/uapi/linux/types.h b/include/uapi/linux/types.h
index 6375a0684052..48b933938877 100644
--- a/include/uapi/linux/types.h
+++ b/include/uapi/linux/types.h
@@ -53,6 +53,7 @@ typedef __u32 __bitwise __wsum;
  * No conversions are necessary between 32-bit user-space and a 64-bit kernel.
  */
 #define __aligned_u64 __u64 __attribute__((aligned(8)))
+#define __aligned_s64 __s64 __attribute__((aligned(8)))
 #define __aligned_be64 __be64 __attribute__((aligned(8)))
 #define __aligned_le64 __le64 __attribute__((aligned(8)))
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


