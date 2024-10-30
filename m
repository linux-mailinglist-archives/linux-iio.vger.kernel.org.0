Return-Path: <linux-iio+bounces-11631-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3BD9B68E5
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 17:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4AD9285B00
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 16:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C542144DB;
	Wed, 30 Oct 2024 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VxN/BVz9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D233214415;
	Wed, 30 Oct 2024 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730304486; cv=none; b=bPWMtrC/DbILwNcyK4zNe1nsVZdRy9UB3WQ3tUmmkfHjDK8peHPkefCpLT5xzLKyUMyOE7fIR3Tx9ZFI+MKaaYXdEBB/DBsQ/GOmSeCZpD4mHP7hp5xTkIWImAC/Grgx2eON7svjDRdyCxlY6Et1x6pSdZkQF5S0VnJ+5mtZPnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730304486; c=relaxed/simple;
	bh=/I07EL93xI7rksnSSU4yB8BeX/oY+UcVmAMhO1n1Wbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSEF6W3s1Qef7MktaJtYzZ4xZKPFzywnfng7JB1cPpS2Ybu9hNT18xN7w1D5HD5VJA3AgGR8RWtK+5ydhVD7Qw3scUol2NSEBxdlWDntQmVSbVEOWf3pbqUGWu0aya3bf+Ibqc/QeUllWZyyrdpFqWORq5+eb8oPnLLfMjNeeNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VxN/BVz9; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730304485; x=1761840485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/I07EL93xI7rksnSSU4yB8BeX/oY+UcVmAMhO1n1Wbo=;
  b=VxN/BVz9U/5MeCKLcUry687Rujjv7uA9KWByPDvsF7X9GUD8OTm62ezX
   qWFv5nnTC1W/1KQiiXj8RppHg4yyvrO6JeTzp0PoYxBQ5K9o00a5dhSHK
   AikVroORQdS/66Wq37wn7ZK3YUiZbSHSZoN3HOg83oCZpjlEntf6VweeV
   AUdB4dP7ahpZ0LJBIjNNhDOuVm1YxMymM16PCzSffH/ElD3RBGiCh8Q2m
   VTHVAaDob1jvNz+K/FL99orfy1cg4rWZ+xeH898iyk8uRY2zyxb3nYxlu
   7cxS78mO4IdzjYf/SPfEdMQ2An9b1qh6LDpnF6ti4ClATGSy7R9TrGhRt
   Q==;
X-CSE-ConnectionGUID: sSOtmGlEScqSUBlpYq463g==
X-CSE-MsgGUID: kG4+N+CCRD2vTpNjKveL0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="29432042"
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="29432042"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 09:08:02 -0700
X-CSE-ConnectionGUID: jgASKnkcRO+9AJN9sua+yw==
X-CSE-MsgGUID: uA8GKIUMTUScsZ8ceuvrsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="82523851"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 30 Oct 2024 09:08:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 826B0341; Wed, 30 Oct 2024 18:07:58 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 4/4] iio: light: isl29018: Check if name is valid in isl29018_probe()
Date: Wed, 30 Oct 2024 18:02:20 +0200
Message-ID: <20241030160756.2099326-5-andriy.shevchenko@linux.intel.com>
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

Theoretically the name can be invalid if device has an ACPI handle
but hadn't been matched via ACPI ID table. This should never happen,
but let's make code very slightly more robust as some other drivers do.

Fixes: dc4ecaf21c4a ("staging: iio: light: isl29018: add ACPI support")
Depends-on: 14686836fb69 ("iio: light: isl29018: Replace a variant of iio_get_acpi_device_name_and_data()")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/light/isl29018.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
index cbe34026bda6..938fc19cfe59 100644
--- a/drivers/iio/light/isl29018.c
+++ b/drivers/iio/light/isl29018.c
@@ -723,6 +723,8 @@ static int isl29018_probe(struct i2c_client *client)
 		name = iio_get_acpi_device_name_and_data(&client->dev, &ddata);
 		dev_id = (intptr_t)ddata;
 	}
+	if (!name)
+		return -ENODEV;
 
 	mutex_init(&chip->lock);
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


