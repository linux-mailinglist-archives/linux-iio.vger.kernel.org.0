Return-Path: <linux-iio+bounces-11220-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 984259AF25C
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 21:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F20E1F24F8B
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 19:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B1F21B44A;
	Thu, 24 Oct 2024 19:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WoGjDKt5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD494219CB3;
	Thu, 24 Oct 2024 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729797132; cv=none; b=Iv/2nTViSO6dnbmGPpB28ZwXJftgJ1fr5sAwIuolPVNEZzwC1GfC2+ivZZT8IWh0p0qrT2CCB2V6waTMJCW4W/e4rvXPNl4QHoMwvTf1SCADAjK+BSOLHLK68FX6DNPGO3MLvMvfyDrXikXS6oF68m7npBNLLvqt4g7rHT8fJII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729797132; c=relaxed/simple;
	bh=LgM3SvYbfr5Xlwt6pPuUSCUbO7HgE47LVHzd9AaUCSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPTJbwal7nEX8T/nIeryuCL1imGegMvVc6bFg2C0IwJLaBfLmOmv3Ekx6HMC6tTksI75E/XWTtTJ8LbIhiTMnnQG0jxOBJYU22JvVaT0AiO0kdhCakfpm4jZF34+PQxr2EFJkhAdIHDfxpKTsZVFPIVdLXsBS8zfdLD5NkeMqi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WoGjDKt5; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729797131; x=1761333131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LgM3SvYbfr5Xlwt6pPuUSCUbO7HgE47LVHzd9AaUCSo=;
  b=WoGjDKt5ozaHAcWmidD/1mHVVivt+4XSPrdYukfsuXMBlUCxeDWIqekA
   pb85lUAFWIaJ1qfqccaFH5PdRBMNcDBH89S1FH8SJB8iCnUJ3SFGmXDuS
   sJWHWOrg+tYh5OzpfjTNgyuNfS2yOR8IlP7OedxhsnDH8GWoM8nows5pA
   qR8jT5s1AIVhRkzhiYUKMrLrd4pK7kTALA4i0BMle1v//i7UXlGXNbv5U
   PZHJBUnEiz+yj4J1QxJay8EcubIp49o/Pr+On9UX5qOrD5+AV5NvPxSm0
   YvYztSqMoewtp8r3465wMfsGMDaE+Vl2pYLuC1TXDhIwcyKPhcW1CWLut
   g==;
X-CSE-ConnectionGUID: y74fSJORQ6SEQUCZzdQUPw==
X-CSE-MsgGUID: p98ZlRh9T8aGH1uE2xxl7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29563194"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="29563194"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 12:12:09 -0700
X-CSE-ConnectionGUID: w40wNZ44QHKdBGDarpAXeQ==
X-CSE-MsgGUID: ifDq+0BMTWunUmn2RU+N9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="85791740"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 24 Oct 2024 12:12:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6C689550; Thu, 24 Oct 2024 22:12:01 +0300 (EEST)
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
Subject: [PATCH v3 07/24] iio: accel: kxcjk-1013: Revert "Add support for KX022-1020"
Date: Thu, 24 Oct 2024 22:04:56 +0300
Message-ID: <20241024191200.229894-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mentioned change effectively broke the ODR startup timeouts
settungs for KX023-1025 case. Let's revert it for now and see
how we can handle it with the better approach after switching
the driver to use data structure instead of enum.

This reverts commit d5cbe1502043124ff8af8136b80f93758c4a61e0.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/kxcjk-1013.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 2eec95d8defb..208e701e1aed 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -174,7 +174,6 @@ enum kx_chipset {
 	KXCJ91008,
 	KXTJ21009,
 	KXTF9,
-	KX0221020,
 	KX0231025,
 	KX_MAX_CHIPS /* this must be last */
 };
@@ -582,8 +581,8 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
 		return ret;
 	}
 
-	/* On KX023 and KX022, route all used interrupts to INT1 for now */
-	if ((data->chipset == KX0231025 || data->chipset == KX0221020) && data->client->irq > 0) {
+	/* On KX023, route all used interrupts to INT1 for now */
+	if (data->chipset == KX0231025 && data->client->irq > 0) {
 		ret = i2c_smbus_write_byte_data(data->client, KX023_REG_INC4,
 						KX023_REG_INC4_DRDY1 |
 						KX023_REG_INC4_WUFI1);
@@ -1509,7 +1508,6 @@ static int kxcjk1013_probe(struct i2c_client *client)
 	case KXTF9:
 		data->regs = &kxtf9_regs;
 		break;
-	case KX0221020:
 	case KX0231025:
 		data->regs = &kx0231025_regs;
 		break;
@@ -1715,7 +1713,6 @@ static const struct i2c_device_id kxcjk1013_id[] = {
 	{"kxcj91008", KXCJ91008},
 	{"kxtj21009", KXTJ21009},
 	{"kxtf9",     KXTF9},
-	{"kx022-1020", KX0221020},
 	{"kx023-1025", KX0231025},
 	{}
 };
@@ -1727,7 +1724,6 @@ static const struct of_device_id kxcjk1013_of_match[] = {
 	{ .compatible = "kionix,kxcj91008", },
 	{ .compatible = "kionix,kxtj21009", },
 	{ .compatible = "kionix,kxtf9", },
-	{ .compatible = "kionix,kx022-1020", },
 	{ .compatible = "kionix,kx023-1025", },
 	{ }
 };
-- 
2.43.0.rc1.1336.g36b5255a03ac


