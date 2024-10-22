Return-Path: <linux-iio+bounces-10939-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 247719AB0F3
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 16:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C4E1F2411C
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 14:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967B81A2541;
	Tue, 22 Oct 2024 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dZ4FLHtC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3EF1A0BFF;
	Tue, 22 Oct 2024 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729607771; cv=none; b=tkDeQbMQWfkEn2TdfMg/C2sQtGdxiB3gUt1rnzLIr05fDakrxTwDMy/b2EjxOZLvmbUt7YmtqDs7s22PGtQ8onuoT9iYy+exoiR9FGLVDo4FZHG/GfCrdN0ow6d/7Tr0e7vRMYa5HTaK+/882ZaIBtDrtGOlbASI1EIgtuog5U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729607771; c=relaxed/simple;
	bh=LA+KzMHWOlUcpefpbtsowQGO9oa9dLVRNEPxFnph74M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XghVjGNgKyBwhOtocrZHSqAnn49YphSM/aqPXDbCSPD4ZPn46qfBPjrOjh0URrMdsCT7wKhIS4tsllX1ymjbiFWs2aGPNvcjRv0PKOO8mIEQpRMB+zpIrcsbVgbNn88iBtlw8JXLPf0kka7v/7ghw/miNy5WxiwjZFZeJ1JPDSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dZ4FLHtC; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729607770; x=1761143770;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LA+KzMHWOlUcpefpbtsowQGO9oa9dLVRNEPxFnph74M=;
  b=dZ4FLHtCXS+duKYlsjzZUS7zOQTchXceeallAuY5ptb49rETAP4INmJh
   OFVwQ+1lR8WPsZhfMwi+4JuMPSeSFbaSRPr2pVSs/adpadh7cdTMf9o5t
   4rtNZqw0Q/S7/4XUu+xZ+/EP3slEMQ1jn8NFxZeoIbOKQk1nzFR4fsqfR
   9isReFjzraVHCgo/uAwucbdCMa2bODNHItwYjOfpo0L+1dnyWEJZfZFpr
   KpF1piTHYwGwybhhFmUmyeyUPxoKlN3nZ/d9MEsUCR1C0yZF/K7yeCQpo
   xJkyAv5dVybs2BIWynVNlyT2D8TgMct7m2U6DxCkOps+UVTE7R8rRy4Gb
   Q==;
X-CSE-ConnectionGUID: nl42Q+1QTQ+3yl3dzwlKPA==
X-CSE-MsgGUID: J9mQc0mmTAWYFxoktlYW/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="29039158"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="29039158"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 07:36:09 -0700
X-CSE-ConnectionGUID: 8i2IlmjcTa6KCwBLCSgSAA==
X-CSE-MsgGUID: /SCLImUmS4iupRLYoHMH4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="80310228"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 22 Oct 2024 07:36:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 93DAC1BD; Tue, 22 Oct 2024 17:36:06 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: light: Remove "default n" entries
Date: Tue, 22 Oct 2024 17:36:05 +0300
Message-ID: <20241022143605.3314275-1-andriy.shevchenko@linux.intel.com>
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
 drivers/iio/light/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 39c0e08a8e06..4d0ba043b65e 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -248,7 +248,6 @@ config SENSORS_ISL29018
 	tristate "Intersil 29018 light and proximity sensor"
 	depends on I2C
 	select REGMAP_I2C
-	default n
 	help
 	  If you say yes here you get support for ambient light sensing and
 	  proximity infrared sensing from Intersil ISL29018.
-- 
2.43.0.rc1.1336.g36b5255a03ac


