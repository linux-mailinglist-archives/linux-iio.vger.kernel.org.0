Return-Path: <linux-iio+bounces-11106-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4C99AE58E
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 15:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F69D284AF3
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 13:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E46F1DAC97;
	Thu, 24 Oct 2024 13:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cN5Xmxli"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC121D967F;
	Thu, 24 Oct 2024 13:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729775076; cv=none; b=Zdubw3HMxBn4uMG6blnsEA+58ELIc0ijhvOLBNt6gv1GHVOGbq7ccgoOOhJg/JVWG/wUnO4LchHmXXKncslsZG0M+VsBlaS60N4KNtvohI+5YWnY5u2AVnSLlfmDI0bF2UK9ViLFVV3MrvA/wWFVicjG79mJHcK1OYbebcww65c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729775076; c=relaxed/simple;
	bh=r1Ljs09ViP07Wgn+0g0azOe4A6vQASHH1I/FkFMyUOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tICRq6ma8D4lTnLuwOP1ms1DE/x49bG3Z/frgfVMiCIpX0se17Jt11vEXJPJ42aIvN9LuRYZmWSs6EC0LtQmot0+gSXRw2uru9a3n2tke9ObWTPsS1qrkqikYvNTS34RFWbfpdAH0AjiMweChMpafyO4vjKSTFPWRmTPMvakQvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cN5Xmxli; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729775074; x=1761311074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r1Ljs09ViP07Wgn+0g0azOe4A6vQASHH1I/FkFMyUOE=;
  b=cN5XmxliYi3MX3DcwN0TNs0UTb2SloURUMH66qf2+Ft6bOvmXZmkaLdJ
   4XjQSCcwldtUE1ceJ/f1I29k8PP/HPHuZNgMdDKziH/+ZDWvnz76ZFmTn
   w49Ks1jKRotDo9vFszcp14JGknGgtAkPgt5Qh5O6EQMe5GW10Tim3ciPi
   Xw/9FQYMxwkO+OMk1+JvbcTfEQDhlTCxKX7ovif48qSIOYtZ3/5OJABhT
   8rGZ/Zhx5bI+xpa2fZRMnKMuyLmh2W9+PDrkjrg2/UhONsv552pl9OzBv
   PpCJ+1UvDNpd3RCyVoRWXerjo7h/nzn1NwSU1/FZ80R7FaLJf09UQqsuA
   A==;
X-CSE-ConnectionGUID: g31vzK/WTKC1+9qLTSuVmA==
X-CSE-MsgGUID: nXBGM+JXSdSlo3w5W1f8RA==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="40795248"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="40795248"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 06:04:32 -0700
X-CSE-ConnectionGUID: XSs+pGdFSjSi4U3MWB2FEQ==
X-CSE-MsgGUID: 9Cl0J33PSFq7huLLX0OMVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="103898633"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 24 Oct 2024 06:04:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1E3A26A7; Thu, 24 Oct 2024 16:04:25 +0300 (EEST)
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
Subject: [PATCH v2 09/13] iio: light: isl29018: Replace a variant of iio_get_acpi_device_name_and_data()
Date: Thu, 24 Oct 2024 15:36:14 +0300
Message-ID: <20241024130424.3818291-10-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241024130424.3818291-1-andriy.shevchenko@linux.intel.com>
References: <20241024130424.3818291-1-andriy.shevchenko@linux.intel.com>
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


