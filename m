Return-Path: <linux-iio+bounces-11752-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD869B8CB0
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 09:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9A53B2283A
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 08:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D777D1581E5;
	Fri,  1 Nov 2024 08:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A1EPJMqw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3AA156661;
	Fri,  1 Nov 2024 08:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730448735; cv=none; b=QEUx4fW63RfbqLNkbstEx06KiJMOZZhec1E9g3mZVzFRFvznCMvLgYYspnC/YQ3TapL0jjL7SA1DX87AskFoogX0hOkbiErlzNF+trl9dGqrvVYfI3whhKB8Zjgwr41a8yENKMfBVUY/MiIe53YgRSQ3EVGOrAUGu+Ks2A4/8zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730448735; c=relaxed/simple;
	bh=zb/4/bFX10GCalAWVbRwK1NHWuKv704m0q1ZHqlV4MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YN85nhLZDuywM0ZATxfI9lIszTb9N+vUdlEM2k93xXPiyN7T5GzWTEJdb3N9P+3W28jVE4f6hI527t9/CuxuXb8oTaCvvIhdzFTCkywH+zLnJ+YwCdKarEQ7+Q8M3UpJzj3srSpwnB97rSoYDVSgvUdTXNn9SWyS9ryJpj59a3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A1EPJMqw; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730448734; x=1761984734;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zb/4/bFX10GCalAWVbRwK1NHWuKv704m0q1ZHqlV4MM=;
  b=A1EPJMqwwKUccZ8wAiINgHQ9EwUvAXON8TpHieWxeHaDBuOFOu3qOTvq
   7NO77o8zQoW9SQ7FYLjt/yHCEyg45M/8YtlJFCcrQ1xhLpoJnoRqS5/q+
   +VcuCwc2rveyZ4Wy6eYn5AlSEmi5TFB3hDpe7x/634DzMBqR8vtfqp4Uz
   SQrPFx5ep4xOcC3dqwpUVwnl1xfNdrMFWxBQ0z6HuwxGJs7b2d7LerLHn
   51G3YeuQvPAn3AowC4ZMfs3omrMmn9OWmwTv+8u9XN0ULUuBBF4Tauzqn
   6xTdFo4Hw7eNaS2hvP2zjcznvtgQSO7JnplUR9qSvzfNqbkDpeZG/g/6r
   g==;
X-CSE-ConnectionGUID: ix3muR/HSTOUvXb74byJxw==
X-CSE-MsgGUID: N1d7PKDLQHGKsIWrgbfNig==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="47698432"
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="47698432"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 01:12:11 -0700
X-CSE-ConnectionGUID: BjMOWp+XTr27ON0JFU63ew==
X-CSE-MsgGUID: bkxN9cATQKWm1iQKsiMYKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="87712822"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 01 Nov 2024 01:12:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 01C8B1AC; Fri, 01 Nov 2024 10:12:07 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v2 1/4] iio: light: ltr501: Assing ddata to NULL
Date: Fri,  1 Nov 2024 10:08:26 +0200
Message-ID: <20241101081203.3360421-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241101081203.3360421-1-andriy.shevchenko@linux.intel.com>
References: <20241101081203.3360421-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When iio_get_acpi_device_name_and_data() fails, the ddata may be left
uninitialised. Initialise it to NULL.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/54fac4a7-b601-40ce-8c00-d94807f5e214@stanley.mountain
Fixes: 61da460b813d ("iio: light: ltr501: Replace a variant of iio_get_acpi_device_name_and_data()")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/light/ltr501.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 7228611d4c59..616dc6921702 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1424,8 +1424,8 @@ static int ltr501_probe(struct i2c_client *client)
 	struct ltr501_data *data;
 	struct iio_dev *indio_dev;
 	struct regmap *regmap;
+	const void *ddata = NULL;
 	int partid, chip_idx;
-	const void *ddata;
 	const char *name;
 	int ret;
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


