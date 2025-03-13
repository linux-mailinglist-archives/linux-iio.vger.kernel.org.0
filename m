Return-Path: <linux-iio+bounces-16780-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53090A5FB84
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 17:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EFA416F7A3
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 16:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A85C2690F0;
	Thu, 13 Mar 2025 16:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jJfMsnKe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A582D1EF0A5;
	Thu, 13 Mar 2025 16:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741882981; cv=none; b=ksxnkXuRWHhGnwgJEPRa2m61Y7vS0fvUUfuX0g81B2L4j3ZjvgQtBxhC/1s3j6bZmN6Yujgz5LCgTsdLI2uBVbGE4bK6QjtCpxYd1BemLkVXp+ia0k5t5oQoWJwSGk4OBM+TGqXbq+JHxqQ1jxmHmw+MlFwW6zjvKmjXVc1AZGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741882981; c=relaxed/simple;
	bh=P5R3F0s5D5HlzbFQP8b72oupiPY/dzZzf3y7zl8VGxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t5f9JfCJi7VVwjTsw5Ww+jfYWRq6cQS0aJC43KThFip1sqSV9WY2v4T0ZQU0DRV6FfOnLXRHpZk9ivXFBCVWQpFQp9NQ5MUhZqc7flkwHfZ2Ses2wme4H4w4UYqJ3nAlmDTvr3ple8rNg0JHYN+F6efUnZ/1utHP/lA53zEoTWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jJfMsnKe; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741882979; x=1773418979;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P5R3F0s5D5HlzbFQP8b72oupiPY/dzZzf3y7zl8VGxU=;
  b=jJfMsnKerzn3vRKVpc3VB4YU3zkdyNdLVqZDBfhFJmz+4wOndess3CRi
   0S1V4TmAXL60X4aRXNOlNMUyrAKf2aRWmEy/fiaS99ONkC9ZqYtPrf5An
   eMHtX2fDFtphAyQGvhOyeKy6p4XTIp9oY8BYGK2jZ7KyaoAPm9IEWVW9Q
   dyb54MF6vKcTfNd0lGbP8CQ4G+7KBXk/MwBGQDmTBRYkmf+iGzPoeFIe6
   B7PAx46tPW7Dc1foPuhDgTqpTMo5GN2d0dxWzq5o1xscqhz+qTE2A7BLx
   x42qHK8Z6Rdi3bfTw0zXJI2E5bELlGUxgjBL01ASqvMnMetUfHo9RWEVS
   w==;
X-CSE-ConnectionGUID: LmnpfIPhTECPsfzL4JnqLg==
X-CSE-MsgGUID: fazMzV6TT/OcjboDgjtLSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="46800124"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="46800124"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 09:22:58 -0700
X-CSE-ConnectionGUID: 3spZhGmWTZCTemtFuHZ1zQ==
X-CSE-MsgGUID: BgKOe3xMRiSkev+0VQhWTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="151859277"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 13 Mar 2025 09:22:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C3080156; Thu, 13 Mar 2025 18:22:54 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: amplifiers: hmc425a: Remove not fully correct comment
Date: Thu, 13 Mar 2025 18:22:53 +0200
Message-ID: <20250313162254.416422-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The OF match table can be used outside of OF-based platforms.
Remove the (misleading) comment.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/amplifiers/hmc425a.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
index d9a359e1388a..e92d7f399e33 100644
--- a/drivers/iio/amplifiers/hmc425a.c
+++ b/drivers/iio/amplifiers/hmc425a.c
@@ -398,7 +398,6 @@ static int hmc425a_probe(struct platform_device *pdev)
 	return devm_iio_device_register(&pdev->dev, indio_dev);
 }
 
-/* Match table for of_platform binding */
 static const struct of_device_id hmc425a_of_match[] = {
 	{ .compatible = "adi,hmc425a",
 	  .data = &hmc425a_chip_info_tbl[ID_HMC425A]},
-- 
2.47.2


