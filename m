Return-Path: <linux-iio+bounces-10938-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA09C9AB0F1
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 16:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAE91282C23
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 14:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F081A08CB;
	Tue, 22 Oct 2024 14:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kpDYl4TQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BA91E505;
	Tue, 22 Oct 2024 14:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729607767; cv=none; b=fCPZJqBD4HIB2UlJu36LnMcZP9VTHcW32fLUAFUoMaI8Jw2XBYXnJBMkXEuYI68quoghs45QAHYwOBLvkNpODHGFwUnbU0qUFwB4uvqlhbJCD9eZIiIQsLw7pd+UwKrpXP5oY4Hjj6Mo8wM9G3HSTVEq4ic5QbIvo2oBK04ofoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729607767; c=relaxed/simple;
	bh=2EnMCZX5TCtSv+nMxhGWdPQUTQJB2A854cxPv6kK1bU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fpZCcfSpKF2WqJVD4sbkvLi6y6Qa+q+9kp/rl0e+xbB+nK7hbZff5CWgC1TEbYq+nAKHzPvSNvSyQ6zMmr6Sm0aPINBlMbok1pxVw02R8k7HHAMZNaWcJ6SiyWlJY0RUDQeUGuFgb+QhwrG+ftzy9ERlPyfYVGUSB7Q4lygvnuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kpDYl4TQ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729607765; x=1761143765;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2EnMCZX5TCtSv+nMxhGWdPQUTQJB2A854cxPv6kK1bU=;
  b=kpDYl4TQohZx/jiIG1ipx0hM0hayV2Y2XTmy2doo7PpsF28kB5UZs7em
   Bezgn6EWZkLL4V6695c4IuKxQUf+HDHC2y/VXQ0nlY1AjCdW6dPjnpNQ5
   EExrQ6+CzxRBfCLuP68Ccn/IbbZvSEBifbrHfpWaE/2VkWoXGIkBQxFht
   j+6Y0C/30c9tgJ5QfKM0y2FbNAU5ivA7rujyqsZiX4SRHJdHqMTxDBcVI
   ulWlhEXjnWiLHkP30fGYbaHriyR8NoOMLkAL+WKcLO6ESbMZyAEeXq7So
   +9cIZ+stypzgv84PzTIpLtWtWS5NS4KlLwPGRB7cl93zsm0gC0v3cafAF
   w==;
X-CSE-ConnectionGUID: IY+sbwrAT3K+Fcotmctpdg==
X-CSE-MsgGUID: Q8uT+8fkQMKkAJngmOaOXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="54553669"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="54553669"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 07:36:04 -0700
X-CSE-ConnectionGUID: x3qqdpniSHOBUFHrLDeOjg==
X-CSE-MsgGUID: WXyoIEQHTyyhbjzQMzQNzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="84708599"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 22 Oct 2024 07:36:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 84D6C1BD; Tue, 22 Oct 2024 17:36:01 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: adc: Remove "default n" entries
Date: Tue, 22 Oct 2024 17:36:00 +0300
Message-ID: <20241022143600.3314241-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus already once did that for PDx86, don't repeat our mistakes.
TL;DR: 'n' *is* the default 'default'.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a21ed997a8c1..d8abe28eec89 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1619,7 +1619,6 @@ config TWL4030_MADC
 config TWL6030_GPADC
 	tristate "TWL6030 GPADC (General Purpose A/D Converter) Support"
 	depends on TWL4030_CORE
-	default n
 	help
 	  Say yes here if you want support for the TWL6030/TWL6032 General
 	  Purpose A/D Converter. This will add support for battery type
-- 
2.43.0.rc1.1336.g36b5255a03ac


