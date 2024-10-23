Return-Path: <linux-iio+bounces-10996-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B71499ACE89
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 17:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DB311F23CD7
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 15:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29721C876B;
	Wed, 23 Oct 2024 15:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="II0wnrWr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E0D1C3050;
	Wed, 23 Oct 2024 15:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729696921; cv=none; b=KsBI1J0MX6LJTpAQwx1Xbjammb9H+K5tmjMeJByedAYNltvRRmrqd4M2DxWHFfGf6KiedQ1CzC5hmeBjmD3W6CLMwH5micN431nd+TjfPZbN7hwKGDrW2BuaOWISd/4VZ21lAukZdQ6QyMJKaibcMdIU3NzI26zJWufvLjqsZyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729696921; c=relaxed/simple;
	bh=jDq1gH5YCUKcq4BcItLXMsB6y4PEq3PrFo3E4XnyPsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CnGj2XHnEzodDgqYAD+nDpAeWrTXxkd6IkgUZMEMPLCxkvH99AhULuScteqZyK1QQ/+EH7jRN4gv2jqANfnESUhWwWueJqo9qSTbT3EhH+PJ7rV+/9CK2uhgl6M97u1DpBbCrmzJ81e4y5K1lhuIX3FK5f/CySkOBasHGgj+WI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=II0wnrWr; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729696920; x=1761232920;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jDq1gH5YCUKcq4BcItLXMsB6y4PEq3PrFo3E4XnyPsg=;
  b=II0wnrWrh0t8fVhMEnjB+JuojxSQ/PAiX/aENrdxDfZozyctn5N4r7Pm
   UOL3qC7kkcUHAmPaxrCAME6MaYsCQMXklwJwXAN7YbZgnva5rCm+4ICRf
   mp6oA65DhB/twygCf2gV51x4z3Cv93fgs9DHjiJu6YM/YmhZufxTxWlhd
   mL5rlmpI9xCMpX1VuBF4BQZ80kjnps9N+xxryACDwdvXjXWZVQoeoFDJu
   3cTgrALNLb5GSJc/vRiokvyYYZeMnebDa1zh8eQ2I5IVJSQNziJYB8el+
   DWNUVNhSN0pGx7WWQoWiBIeheWNPWgedCPE63uLiJky0P1GdReObJ1hKt
   A==;
X-CSE-ConnectionGUID: uGjy5etLQESzzkOpyHEYmA==
X-CSE-MsgGUID: o+HBFte8RaGIL2SsSgJbCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46757927"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46757927"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 08:21:56 -0700
X-CSE-ConnectionGUID: zUwNeNHhQs6jTkXpENGOVg==
X-CSE-MsgGUID: MUdqcuqNSRuuz2DjFLAjsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="79823545"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 23 Oct 2024 08:21:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 24B7E644; Wed, 23 Oct 2024 18:21:49 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v1 11/13] iio: light: ltr501: Drop most likely fake ACPI IDs
Date: Wed, 23 Oct 2024 18:17:34 +0300
Message-ID: <20241023152145.3564943-12-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241023152145.3564943-1-andriy.shevchenko@linux.intel.com>
References: <20241023152145.3564943-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commits in question do not proove that ACPI IDs exist.
Quite likely it was a cargo cult addition while doing that
for DT-based enumeration. Drop most likely fake ACPI IDs.

The to be removed IDs has been checked against the following resources:
1) DuckDuckGo
2) Google
3) MS catalog: https://www.catalog.update.microsoft.com/Search.aspx
This gives no useful results in regard to DSDT, moreover, the official
vendor ID in the registry for Lite-On is LCI.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/light/ltr501.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 8c516ede9116..3fff5d58ba3c 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1610,8 +1610,6 @@ static int ltr501_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(ltr501_pm_ops, ltr501_suspend, ltr501_resume);
 
 static const struct acpi_device_id ltr_acpi_match[] = {
-	{ "LTER0501", ltr501 },
-	{ "LTER0559", ltr559 },
 	{ "LTER0301", ltr301 },
 	{ },
 };
-- 
2.43.0.rc1.1336.g36b5255a03ac


