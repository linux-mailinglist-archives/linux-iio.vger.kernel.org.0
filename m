Return-Path: <linux-iio+bounces-22479-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DA4B1EE0A
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 19:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94197560E86
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 17:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E071E7C2E;
	Fri,  8 Aug 2025 17:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VyN8tQXl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FCF224D7;
	Fri,  8 Aug 2025 17:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754675344; cv=none; b=qV2fZZ8T9RcQBlbC1kHB2mwH2gPHXc2yybHAiO2ktRAVw2MHgs7PoSIK7pD20ASnh3wlmcN/5kdPE0CeYrRnuCGl0/xWbGN/XEdNnkzw6htvGmt+db86i1F17USXX2c3WQdAHpBsNqB55E2Vk6xeFlY75dxGHVf390q8LnoHpyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754675344; c=relaxed/simple;
	bh=BN+z8RdmLvzo/wjQQzyaxeV0OrQMJMUJyDj1MLnzbkA=;
	h=Subject:To:Cc:From:Date:Message-Id; b=WT+KEhaPxqFIMx3KIXFLRRAWnTiqyXIM+s6YwqYIKcJndinKT7QE0NrGYmGsaMa7cn2DGynH9oazdwaHbJLBTzx7WRBMPFm42k9htWmAa+Mtb8eFnCv1HngiaMAFZ2lSIR9Yv+1yEobJa86WEMErZ62X2SwruX460aCf4GGn2eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VyN8tQXl; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754675344; x=1786211344;
  h=subject:to:cc:from:date:message-id;
  bh=BN+z8RdmLvzo/wjQQzyaxeV0OrQMJMUJyDj1MLnzbkA=;
  b=VyN8tQXlTBpxpUrcABA2I/3RXtygbttnWIhjrMED2BU1jNRlOyPMgrPA
   G0VL9vGt08Jj7nPQV0uNlorC2tDRCXIvhCtmSzENAX5fv5owVjyp8bV8V
   +mnGAk8TnSnWwVVMH52kJCpQRrIJksb4jQVt1r7E5xFLbA14PVIOtz86+
   r6Fq8N7Y3mE+3oXOHPjDgM+YpSknTbbIywBgI9AH1p80xl4a2xj1dg8Hf
   9xN4RkL0T5o9791Xz1vA6vyLVq38PuEtQPaENwxZQ3DLLHfA8T5ISdJjJ
   0WCqxAkcESCbKu7/EndrxA9dzmjKY62PmsCMfMLbBviqymKURfLh7lCU5
   w==;
X-CSE-ConnectionGUID: EpuU0Q+3SGyPl+Xv9bjFPw==
X-CSE-MsgGUID: roT1OTWkSmmO1dQtjYwnIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="79589616"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="79589616"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 10:49:03 -0700
X-CSE-ConnectionGUID: l2xC45q7TDWo1+PKgtPmaQ==
X-CSE-MsgGUID: a/RXC8VmRnalVbCdJaV2oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="165750840"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa009.fm.intel.com with ESMTP; 08 Aug 2025 10:49:02 -0700
Subject: [PATCH] MAINTAINERS: Update max30208 for bouncing maintainer
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, "Nuno Sá" <nuno.sa@analog.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 08 Aug 2025 10:49:01 -0700
Message-Id: <20250808174901.4556B33A@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

This maintainer's email no longer works. Remove it from MAINTAINERS.
Also mark the driver as an orphan.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: "Nuno Sá" <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org
---

 b/MAINTAINERS |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff -puN MAINTAINERS~MAINTAINERS-20250707-6 MAINTAINERS
--- a/MAINTAINERS~MAINTAINERS-20250707-6	2025-08-08 10:45:11.062417377 -0700
+++ b/MAINTAINERS	2025-08-08 10:45:11.078418776 -0700
@@ -15005,9 +15005,8 @@ F:	Documentation/devicetree/bindings/reg
 F:	drivers/regulator/max20086-regulator.c
 
 MAXIM MAX30208 TEMPERATURE SENSOR DRIVER
-M:	Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
 L:	linux-iio@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	drivers/iio/temperature/max30208.c
 
 MAXIM MAX77650 PMIC MFD DRIVER
_

