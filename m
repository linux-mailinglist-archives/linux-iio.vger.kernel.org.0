Return-Path: <linux-iio+bounces-11223-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F38099AF260
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 21:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D1F1C259C7
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 19:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A0921BB11;
	Thu, 24 Oct 2024 19:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ia9W3SkF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093CE21A709;
	Thu, 24 Oct 2024 19:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729797134; cv=none; b=Tw4CFpd44O1CNC4pzS8+wml8m0Fs2mxfOU8TRzvHiANjqunIZINFK2ooDSorYLSEcfzjDa1kXVfhiQRswySzd/nQArtx+W0EGAFT8F6zwn6/+nQKLU+t5vleiggCoKcC8PVtB5XDXnSZhcKwAaeZ2YMp37Jw/adIhTuAcIH3Gu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729797134; c=relaxed/simple;
	bh=r1Ljs09ViP07Wgn+0g0azOe4A6vQASHH1I/FkFMyUOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mva0DigjSYwg4XoHztfk3A2IL9RKwdO8plsOqXNWOcW+M4Ow63cGOpc9fonl7akdqWVWLB35xXN+g6MrkFipWVDcqbcbROh0HWfjFMjcbYmi6rtm23L9B5XW8Dube7OVI2ihttgsgxJ30cM3hMbjo294NS5Jm5UVBtEfvBxdReY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ia9W3SkF; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729797132; x=1761333132;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r1Ljs09ViP07Wgn+0g0azOe4A6vQASHH1I/FkFMyUOE=;
  b=Ia9W3SkFmi02PO0nuv+YrqHA71s/00ztrsq5qu2wrCKasFHhbll09757
   wTIeqOplKzhFDARObY2jZkVu/LBTq6v6PqOUT67QmFP2rNbrM8rJb48Fm
   GtpJjrhCF0embvxChxFZ8ZYjtCjZzO2ER9ahT4JiHP8MWSmm8JaryK9FM
   9CP6n2rrLCAMsXVUj+Iksjsj0j/BOvsOXxXanrymdMW9kucnFSjKbwtfB
   H+WQDTsJPq0SKWHD85VQ/Kzh7QWgQk1CSGZcspBUNC3Jb5hRieZ5EcpDt
   1oEodc9v+oYF/AmpuQs3nFsWyCTqePnP9auXp5NbRld4JaJtYX+q6lDtB
   w==;
X-CSE-ConnectionGUID: 40TWDDFITki2DvSz+9IX3w==
X-CSE-MsgGUID: Ev3GZAmdTaW0xabiLPIwCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29563208"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="29563208"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 12:12:11 -0700
X-CSE-ConnectionGUID: gGrwEd3YTrqo+mgC4E+bJg==
X-CSE-MsgGUID: odZb9DYjRqu7NhFuUgdgaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="85791752"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 24 Oct 2024 12:12:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 036AC81D; Thu, 24 Oct 2024 22:12:01 +0300 (EEST)
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
Subject: [PATCH v3 20/24] iio: light: isl29018: Replace a variant of iio_get_acpi_device_name_and_data()
Date: Thu, 24 Oct 2024 22:05:09 +0300
Message-ID: <20241024191200.229894-21-andriy.shevchenko@linux.intel.com>
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

IIO core (ACPI part) provides a generic helper that may be used in
the driver. Replace a variant of iio_get_acpi_device_name_and_data().

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/light/isl29018.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
index 8dfc750e68c0..526ee5619d26 100644
--- a/drivers/iio/light/isl29018.c
+++ b/drivers/iio/light/isl29018.c
@@ -687,20 +687,6 @@ static const struct isl29018_chip_info isl29018_chip_info_tbl[] = {
 	},
 };
 
-static const char *isl29018_match_acpi_device(struct device *dev, int *data)
-{
-	const struct acpi_device_id *id;
-
-	id = acpi_match_device(dev->driver->acpi_match_table, dev);
-
-	if (!id)
-		return NULL;
-
-	*data = (int)id->driver_data;
-
-	return dev_name(dev);
-}
-
 static void isl29018_disable_regulator_action(void *_data)
 {
 	struct isl29018_chip *chip = _data;
@@ -716,9 +702,10 @@ static int isl29018_probe(struct i2c_client *client)
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct isl29018_chip *chip;
 	struct iio_dev *indio_dev;
+	const void *ddata;
+	const char *name;
+	int dev_id;
 	int err;
-	const char *name = NULL;
-	int dev_id = 0;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
 	if (!indio_dev)
@@ -731,11 +718,11 @@ static int isl29018_probe(struct i2c_client *client)
 	if (id) {
 		name = id->name;
 		dev_id = id->driver_data;
+	} else {
+		name = iio_get_acpi_device_name_and_data(&client->dev, &ddata);
+		dev_id = (intptr_t)ddata;
 	}
 
-	if (ACPI_HANDLE(&client->dev))
-		name = isl29018_match_acpi_device(&client->dev, &dev_id);
-
 	mutex_init(&chip->lock);
 
 	chip->type = dev_id;
-- 
2.43.0.rc1.1336.g36b5255a03ac


