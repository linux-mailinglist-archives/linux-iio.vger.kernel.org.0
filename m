Return-Path: <linux-iio+bounces-13066-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078669E30CF
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 02:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C134D28310C
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 01:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14AC1C68F;
	Wed,  4 Dec 2024 01:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hoNZTpW/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8F6EAF6;
	Wed,  4 Dec 2024 01:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733276188; cv=none; b=hNnweHjf/2Nt1iPB64iiNKJ2eZKONgbdyUxEWvmYIWKS+WaBcW/VqrzjlmBIQrDHPoanAI4gTP2BBhYxOWzaWc51Mx/upofJOZ+KA3jXWtpVvBnsIk3UATFusxKQA5Iav8LQAGtYLZhVCv4CJoCHah9+vH83m9Cg2yvSerrVhnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733276188; c=relaxed/simple;
	bh=Fe2tQ9m02I6JfppWG1r7EPIzo3auSyK5naADPlvnj+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5kQbqBo08ZD4HVeEaFBTL+7NeTP6h74tHEsiwOnHFaWXXPW/ew3WDqJCpfE7fql3aMzTVxcVwsWsLu86qmQd/ABOCdkpojj0mFDKZKODIEDc4gmtqNdepjaieqatBVSX8KWdHfhc6KLTE09plmrPOJTgSfjxnaGPlpcMPGSMJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hoNZTpW/; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733276187; x=1764812187;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fe2tQ9m02I6JfppWG1r7EPIzo3auSyK5naADPlvnj+I=;
  b=hoNZTpW/mv9fwifZfaeyFVNgCQOxRz88R7B2XeLYGc86p2OS3zbS08bW
   IzI/aD+EjOJZYK+k/fvJQ2l1rjvx75IrvBgizJOVYSwNZHRJxY/sEDqFv
   eqkYhT1G68zefddvlcE+kH3pFJ1fg+vbZIEzkQHOXuTbIEc7gS2sc7VxZ
   9QRtPRw8tM7bl/KZJzNF/MgLR5AqqYUfy7dyWBKfo7+5EtVxtyQ9dX6Ve
   D1Lo6mIK/vtVm0rE1b+o2gRlzU8nSoD0sxpgb7BQ+CX6XJebBVqWVRYnM
   AV6DJEkC/+GmzV/r9j71z5i3tl0+NPEqFv+Wivt81Th8IfoyLnnWZYmm1
   g==;
X-CSE-ConnectionGUID: elyN3KfhTR+aQQB2W87Xfg==
X-CSE-MsgGUID: X9zXaDH+RZK28b5Q+0xfDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="37293581"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="37293581"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 17:36:25 -0800
X-CSE-ConnectionGUID: tFDOS+nAQrqP0DQ5BJlrxQ==
X-CSE-MsgGUID: Ta81aQz0ToGp4TLO6pGSQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="98694833"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 03 Dec 2024 17:36:23 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3FF8EA6B; Wed, 04 Dec 2024 03:36:22 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 4/4] iio: afe: rescale: Don't use "proxy" headers
Date: Wed,  4 Dec 2024 03:33:19 +0200
Message-ID: <20241204013620.862943-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241204013620.862943-1-andriy.shevchenko@linux.intel.com>
References: <20241204013620.862943-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use)
principle.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/afe/iio-rescale.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index bbc73798082d..067823a356d9 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -9,12 +9,16 @@
  */
 
 #include <linux/bits.h>
+#include <linux/dev_printk.h>
 #include <linux/err.h>
 #include <linux/gcd.h>
+#include <linux/math64.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/types.h>
 
 #include <linux/iio/afe/rescale.h>
 #include <linux/iio/consumer.h>
-- 
2.43.0.rc1.1336.g36b5255a03ac


