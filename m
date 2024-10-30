Return-Path: <linux-iio+bounces-11635-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE789B690A
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 17:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D69D42861F4
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 16:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166F8215024;
	Wed, 30 Oct 2024 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ut6NdegY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A36214422;
	Wed, 30 Oct 2024 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730305222; cv=none; b=ergZoxfpzLQ/MYAdy8kKQXp+YSTQdXjb2WURCShpF9+mnLTcUzvkvMpTLpL6EP2V6z6DMNes/66F2UZjh7zG2En8awz9hUxNXuQq4P0aHwhndbEUHXCajei0QeZNotHns+jWe8Vvu0br+wglvk53v9sJm1tyBfHAqk3sXJZNCYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730305222; c=relaxed/simple;
	bh=gq65YC2ykZCricT7yy2SZsU7hVBxbLZf9QS6ITu3/HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=shKLkE/HYfTgf2j4keU9z7ZdnjuFL0CUuwtt+D46pM00Wfz0nb+Bqb2pVAjzV+NpZxX4YVuE5K1RkO7vNDsaDmjtU2IBo9q/SI6YzvyQFf/cpe/Dn2aRCt/EJishSRWwNEk6kNXYnIML/wkNRJSGMDI7TyMhqJeSe2FIN96Br94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ut6NdegY; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730305221; x=1761841221;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gq65YC2ykZCricT7yy2SZsU7hVBxbLZf9QS6ITu3/HY=;
  b=Ut6NdegYM8ea1d5ZHXgdymf/r2ldh1Tc8DUVjM5liq6IF8e75az4mvLK
   SWTLQFoWcnn6c4uJVJc24u7LlVBJDpdixGTWaX5gF/IxEh72BWfg6sQab
   WZI04QvQW6ig2aQjs6nqm1OzE1VRtT7LKkEBVCZq4B8QxyqcyG2f4ePAF
   jNJuQjqhhwexQPylT1YKTrP0B5tnkJGPaJxqd+RyL2EUZgtxRfnogJXDo
   ZeM/rK/hWimkobsIh4rgS1FEFvOAdjcgWtaWiZgzbKSEqmpm69ypa0LQq
   7EMQJGm5CemdrwKtCzrVEFQXVpaaoCaCy1msrFLNfiuT/2nQo7t2SbpqH
   A==;
X-CSE-ConnectionGUID: ocjc6wBNSB+r59ajz/IiFQ==
X-CSE-MsgGUID: MUA8IqMKR0+D3qK0ZSiQ5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="30230408"
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="30230408"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 09:20:18 -0700
X-CSE-ConnectionGUID: H88prCWESV+Ls/PowtpH3w==
X-CSE-MsgGUID: X4zhELxOQ0CNI0eLPUHU7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="82459068"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 30 Oct 2024 09:20:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0EE3A2A0; Wed, 30 Oct 2024 18:20:15 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v1 2/2] iio: adc: pac1921: Check for error code from devm_mutex_init() call
Date: Wed, 30 Oct 2024 18:19:19 +0200
Message-ID: <20241030162013.2100253-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241030162013.2100253-1-andriy.shevchenko@linux.intel.com>
References: <20241030162013.2100253-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even if it's not critical, the avoidance of checking the error code
from devm_mutex_init() call today diminishes the point of using devm
variant of it. Tomorrow it may even leak something. Add the missed
check.

Fixes: 371f778b83cd ("iio: adc: add support for pac1921")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/pac1921.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
index f6f8f9122a78..385e86ecc441 100644
--- a/drivers/iio/adc/pac1921.c
+++ b/drivers/iio/adc/pac1921.c
@@ -1132,7 +1132,9 @@ static int pac1921_probe(struct i2c_client *client)
 		return dev_err_probe(dev, PTR_ERR(priv->regmap),
 				     "Cannot initialize register map\n");
 
-	devm_mutex_init(dev, &priv->lock);
+	ret = devm_mutex_init(dev, &priv->lock);
+	if (ret)
+		return ret;
 
 	priv->dv_gain = PAC1921_DEFAULT_DV_GAIN;
 	priv->di_gain = PAC1921_DEFAULT_DI_GAIN;
-- 
2.43.0.rc1.1336.g36b5255a03ac


