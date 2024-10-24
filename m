Return-Path: <linux-iio+bounces-11219-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E7C9AF25B
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 21:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C51C1F24D0C
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 19:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34A7219CA0;
	Thu, 24 Oct 2024 19:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OoJJiXy8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E0A219C9D;
	Thu, 24 Oct 2024 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729797132; cv=none; b=FUWU27QhbV+60tMlgi0qx7eQTpae5dKwJaPHN2z60o8jKu71INd5k48hZI3s4niFClFC+tOe7cCznv2yEORRajfcfFZWlwcl+YDRRUdhwJ0MlmIYNb2NSBJo24y99Ye7ux/4DN1LnhS1cqbydIB01fa80hfNgO4Kbmt+zdgK4zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729797132; c=relaxed/simple;
	bh=qTxetLJkqg4g0jepIJZKrTX9ckYhdcAkQpxO6atHE9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SB8fTse9178RVB8YFrPtbOuGscuQh4x1A1OwA3rqyyDZuk/2ZSfoYoS3rQZ1F7MqpYKboYaf32zzciumWTGzHfBMYQf+WKcmlwcZxsRT8P2hAJHRGvkT6fjb3HYqCHIWbd0nFVAvLEeklMFYHwEWBgcOXsG8Fnmp7Ub62V4yRMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OoJJiXy8; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729797130; x=1761333130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qTxetLJkqg4g0jepIJZKrTX9ckYhdcAkQpxO6atHE9k=;
  b=OoJJiXy8MyzW9BBibLXmq9sL3DFoCT4F6jD54Jb/nNRuCVj2K0b1b4Km
   FztoXdc2l9zZACjJuVFC8hsOi1VdBU5cPEmeuw8dD94I1ddbR99oeAS4G
   WrMUULI6nig193URir+32cQCOXtl87ry1Lss2R9WxDjSumic0jLeITh3y
   14h3HryFjiIA8u6eNNU74Z+Z/+VAQQqRCMdSVqoazHlKTlIGDKeia85qO
   bNkMtSJV+CMhd+LKc3OWSxqN8qjURiiEYDjXTWXh5sfPyVamlV92xl8NB
   PV/KWJi/ol5d/UWd3cNCHwCtlv4qdoGbXC48wUTlykMlAly6+AmAaTu6o
   Q==;
X-CSE-ConnectionGUID: X4+fngIUS7SB+amlRbn30A==
X-CSE-MsgGUID: OQ3RH9W+Tx6VdcHt7f0NXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="46934437"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="46934437"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 12:12:08 -0700
X-CSE-ConnectionGUID: UlXj/410RWaLXF2qmfav2Q==
X-CSE-MsgGUID: hZiWnDn4RzalinuyRWI2ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="80266679"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 24 Oct 2024 12:12:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4F3D541D; Thu, 24 Oct 2024 22:12:01 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 06/24] =?UTF-8?q?iio:=20accel:=20kxcjk-1013:=20Remove?= =?UTF-8?q?=20redundant=20I=C2=B2C=20ID?=
Date: Thu, 24 Oct 2024 22:04:55 +0300
Message-ID: <20241024191200.229894-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The ACPI IDs are defined in the respective ID tables. Puting them
to the I²C ID legacy table has no meaning. Remove that ID.

Fixes: 3bfa74f86006 ("iio:kxcjk-1013: Add support for SMO8500 device")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/kxcjk-1013.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index bbf65fc97b08..2eec95d8defb 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1717,7 +1717,6 @@ static const struct i2c_device_id kxcjk1013_id[] = {
 	{"kxtf9",     KXTF9},
 	{"kx022-1020", KX0221020},
 	{"kx023-1025", KX0231025},
-	{"SMO8500",   KXCJ91008},
 	{}
 };
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


