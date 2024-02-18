Return-Path: <linux-iio+bounces-2743-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D494E859834
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 18:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A8741F2124B
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 17:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7E56EB78;
	Sun, 18 Feb 2024 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPsUMUg0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE7D1E898
	for <linux-iio@vger.kernel.org>; Sun, 18 Feb 2024 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708277626; cv=none; b=bTU1adsD3tz7DanjpG6keBrbiOXVKKU9zinqOvH+TA/tbOeZHNnaGyCmVQDbJ7SVOqD0QG+WG+7ovCu2eVejZHuRLp9Tt1Qp+VG2Lr0LS+ng64rz9s/pWxXyuoGDBTbsOi93ocgZl95EK5mQvFaap57HJeCctRBBV5SyiErJX30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708277626; c=relaxed/simple;
	bh=dpQ/VsWAzsGMf/vripDP+x17R79FaTpgTYaPEiuo6Po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VyCg9yQX0Ma0bNhHC5qFUjCLWep+eUd5Rm/ki9cnVNaYkNr/AG2kTB6yVqRwtKpsFvAmEdzR8Ru4BciYesO6sG3ELN2SzUUZS+j1lduRoUf6n2tl+KgbRTibv71T1L8HFjyC3ljG5v2fC88TGvsOHDHhSuuMbolFQP6s4rLe8bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPsUMUg0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20C9C43390;
	Sun, 18 Feb 2024 17:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708277625;
	bh=dpQ/VsWAzsGMf/vripDP+x17R79FaTpgTYaPEiuo6Po=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JPsUMUg0k79yl30VIvsEPg45DtoeQNDvLOCZobjZwFFKMcs0TQOZ0l18C8pmpY2fY
	 BcgEA+Nr8D8xE0sGlMUazvDq3IFRR9aueyKbRdsHOBiaVfcLAQlA2BU3l+izSgNKBl
	 5vMJyQXIpNBQTmdKYRLFXyaaLk5adrXUEw259OdyapiD2DsHZfnTMXMW62+uZCMM4V
	 IyaspK2sM6/9IUzvneB3/LcqE29h1FPs6BmxzmKxWfkwaSnvYX/rIA0pNCs7EXw/Kt
	 tjr1WJN0vmAqGK708eF8PAC+5zstFhVy+Fllvz9uOEMBi3b7y3mRyYzgPfoQg9qzgE
	 CRzsLFjCO+V9w==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 7/8] iio: accel: kxsd9: Switch from linux/of.h to linux/mod_devicetable.h
Date: Sun, 18 Feb 2024 17:33:22 +0000
Message-ID: <20240218173323.1023703-8-jic23@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240218173323.1023703-1-jic23@kernel.org>
References: <20240218173323.1023703-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The only of specific definition used is of_device_id table and that
is found in mod_devicetable.h not of.h

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/kxsd9-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/kxsd9-spi.c b/drivers/iio/accel/kxsd9-spi.c
index 1719a9f1d90a..4414670dfb43 100644
--- a/drivers/iio/accel/kxsd9-spi.c
+++ b/drivers/iio/accel/kxsd9-spi.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/device.h>
 #include <linux/kernel.h>
-#include <linux/of.h>
 #include <linux/spi/spi.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/slab.h>
 #include <linux/regmap.h>
 
-- 
2.43.2


