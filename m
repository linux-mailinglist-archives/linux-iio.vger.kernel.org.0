Return-Path: <linux-iio+bounces-10731-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C6C9A41D0
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 16:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8CE1F259EE
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 14:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571861FF5F7;
	Fri, 18 Oct 2024 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eIZVqyVP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C5744384;
	Fri, 18 Oct 2024 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729263467; cv=none; b=kWQjl43zX9DTBD/Y2wCzu2BIZxsS16/PWpC3JAwuXWzdZbPGNqpBgaTCkiUViCgsfW0ZaKCvzzhj1CWK5o6VLReQA60NBWttfSiarFKfXcc8J+E5MOVgk/c46AFRP2pMqwEu5NvjHFA874OcM89UJEHZPnwIjhLgLDsnWeHBdoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729263467; c=relaxed/simple;
	bh=jV6ZxFpaAtay1oUU6PAS9zcjx6/Uej3Dl7a0D5iXTzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zewwha4B+leGvQf7YVChVcPkwtr/ncBQ/7cSwmFrJgDFWhHe2gnzRROXMsEGU7vjWz4786fWhrCSkz5HAntDdwv2iyec9A0i7nhAa+e1DvbIZ6/rz0QRZtcW8u1kYFQ6ZoC6iU5XOIq40JT6tD0o6tbzv7B9+Et0aep/o1cZMJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eIZVqyVP; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729263465; x=1760799465;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jV6ZxFpaAtay1oUU6PAS9zcjx6/Uej3Dl7a0D5iXTzA=;
  b=eIZVqyVP7UQ2NHky4GW6MMqIokkLwghD1hy8ig+UjjVhfNNLtHDqumQJ
   AIPyq4efVRnciewsPYZFGp6Bv34OrVAiLFVLbHKXyOgqAODpxTc9TqkZ3
   KCV9Q2U1BoOqT+6NXvTLJri4U8OELr4JAzS8DUOW9d3fazSmVJrVZJtg6
   CKwEwYNlrdCP1uvp3HoGS16qgtQNMYlXSYy+OaQYJNVonzEI4nAqciq6z
   SVme7hZsRR331B83jJB+hVwExhIRz3dGx0FGDlbjPjgfCu71DAljvylbt
   zngjYor/7gl8HtBckTKeXMpTAauR+xi72Q9XZ2Uy0Xmc21Y1l1sYsJFik
   g==;
X-CSE-ConnectionGUID: jmJQdlMpRv2PSDHhPYaclA==
X-CSE-MsgGUID: vbKOtel3SKuKiMHNDXw56A==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="28931858"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="28931858"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 07:57:45 -0700
X-CSE-ConnectionGUID: BRW1S8rMQFSloQCyyYPDCg==
X-CSE-MsgGUID: 8B6T81X2RTC8NQPUcbXexQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="83464945"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 18 Oct 2024 07:57:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 230F1343; Fri, 18 Oct 2024 17:57:42 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: gyro: bmg160: Drop most likely fake ACPI IDs
Date: Fri, 18 Oct 2024 17:57:32 +0300
Message-ID: <20241018145732.2181309-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
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
vendor IDs in the registry for Bosh are BSG and BOSC.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/gyro/bmg160_i2c.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/gyro/bmg160_i2c.c b/drivers/iio/gyro/bmg160_i2c.c
index 672d0b720f61..a81814df5205 100644
--- a/drivers/iio/gyro/bmg160_i2c.c
+++ b/drivers/iio/gyro/bmg160_i2c.c
@@ -39,8 +39,6 @@ static void bmg160_i2c_remove(struct i2c_client *client)
 
 static const struct acpi_device_id bmg160_acpi_match[] = {
 	{"BMG0160", 0},
-	{"BMI055B", 0},
-	{"BMI088B", 0},
 	{},
 };
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


