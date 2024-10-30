Return-Path: <linux-iio+bounces-11630-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6BF9B68E3
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 17:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEA421F215EF
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 16:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D0F2144C3;
	Wed, 30 Oct 2024 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WK1+4tmH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EC62141D9;
	Wed, 30 Oct 2024 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730304486; cv=none; b=mL8yfa/Jp2H8HX2ENPXGt5DnY7Cx0fvSWOqO8klmY0bvRgEfQ0CgWGK3CpG9MSDvl5pjZy15vGLdU3GeNMNl5egbMv/ybbwirbQiYZKs4Z51dyXj5e4BtvCstFovcZcWmjPWTyalwGSEwU78oC1u6XQa4L6WBu2wDkNO1KW2BTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730304486; c=relaxed/simple;
	bh=WkPQT/ukvJI7GgfdejYzYLccVooEVQUu2bpNUjOZik4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNGtdSCxmGko10kYM80vBLxtoa2h+6vFglHtfzmiXPsM0Njs+hvcq86A508Le9ofiwmu0Tde9MEN1da0KQ9953JG3xEhqSVBtPQtNuIsDMD2oSG33SAg3K+US1waD9DrOWhpC4/NluuYvM1gCF37RVvq+50hmJRJKEnafnyfQRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WK1+4tmH; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730304484; x=1761840484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WkPQT/ukvJI7GgfdejYzYLccVooEVQUu2bpNUjOZik4=;
  b=WK1+4tmHNv7mrO516kRf36Xv1iI45CgVVyqsQlTBsxreAJuE8UFUFHAj
   YA3rkUJ3UHaUGabZbIZyFUcgVHie3AT6Xv3DqzDdPwtqQ/THJcsY1PpWA
   sT9Z8kfCUlZcfg26hyvbx4h8W5zkyO1N8LFrKpJPAuhgjWc8ecNJ2Czp4
   Hb/MoNJ7xAiURew1KV4I5PyQVL5xW1NeM69ni/36DsgzTN4lakgdqQWPw
   VRluinxabmwMQmzCPxUOK/njgHoBCVZwFFlvr8oUOgjqQDiJbra0x8l/e
   MPG2mpppbmfWysK8Or1fESX188JB0vCCUWsjNWpAqZm1TM+ccCCNwUx5R
   A==;
X-CSE-ConnectionGUID: do3gKsSgTt+JlXGDV46WqA==
X-CSE-MsgGUID: clQvgixBTEelijL4eOf9Ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="29432037"
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="29432037"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 09:08:01 -0700
X-CSE-ConnectionGUID: WXP9EwfiRkywr6CuI23JTw==
X-CSE-MsgGUID: YffXdnXnR9SKQGIfU9t5wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="82523847"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 30 Oct 2024 09:08:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 608262A0; Wed, 30 Oct 2024 18:07:58 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 2/4] iio: accel: kxcjk-1013: Drop duplicate NULL check in kxcjk1013_probe()
Date: Wed, 30 Oct 2024 18:02:18 +0200
Message-ID: <20241030160756.2099326-3-andriy.shevchenko@linux.intel.com>
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

Since iio_get_acpi_device_name_and_data() always initialises data,
if provided, there is no need to have this check in the caller.
Drop it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/kxcjk-1013.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 28ed0e09d099..3d24d4fb6621 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1507,8 +1507,7 @@ static int kxcjk1013_probe(struct i2c_client *client)
 		data->info = (const struct kx_chipset_info *)(id->driver_data);
 	} else {
 		name = iio_get_acpi_device_name_and_data(&client->dev, &ddata);
-		if (name)
-			data->info = ddata;
+		data->info = ddata;
 		if (data->info == &kxcj91008_kiox010a_info)
 			indio_dev->label = "accel-display";
 		else if (data->info == &kxcj91008_kiox020a_info)
-- 
2.43.0.rc1.1336.g36b5255a03ac


