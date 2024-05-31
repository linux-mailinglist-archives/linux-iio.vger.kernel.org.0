Return-Path: <linux-iio+bounces-5547-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CD18D67BE
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 19:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FA08B23D27
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 17:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BB117BB06;
	Fri, 31 May 2024 17:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ct+rfWXx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E007817C233;
	Fri, 31 May 2024 17:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717175336; cv=none; b=MqwJZVJWvtGbmpHs++KAqWMFpmkKMqC71dhnKV5yMSFnQ8xfOlJue2tgIjOddIRp38gH3rg5yf72CwYPUiulHV9qEik2k+he1Sqb9FXePYy+ju/XK2ruehu1nIsehYmaC3S+sI2xwyep+zUfTxI3EyBP7uQGjwaqjW7Q9zeT+n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717175336; c=relaxed/simple;
	bh=9mMdk1jEo+cYqxnq/VHuXt+Kvb7Vs6u4w3HGCp0rzwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=izd+gPhrO7ZlgENTwgrIvmb8puzMqsEBgvvqCkFzmqht8a/DsumKzYtF48i4BGRjYqFucai6NZe262K6cR22X1dwc/jYZuCne8cl4zL6pVuVboPaRk1PS05kCK852Tri909z4MUBiHe0vquCfsBngli1eXDKt0qM3Q4qqVDztL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ct+rfWXx; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717175335; x=1748711335;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9mMdk1jEo+cYqxnq/VHuXt+Kvb7Vs6u4w3HGCp0rzwE=;
  b=ct+rfWXxEkk/BqcaeW21XXZQCaRBvlsSf5KkAeoNT1rzfKunJfhwMjKN
   IHkCVZv0ccEpzqW3JIKbKkWqSR1lpzGz02k4PHztL5Ymwxh6Fo66kPysE
   CxUJZS8t1l+NZrFvtpma7/M5zDSfVqeNRTmzWooOEKVnZipQmiMjEvYRT
   8IYao+pdfA2C7WE+nCbuNDlrJPZa2sc4kxbuY0O2PKZoLeECpWso1XVTF
   36PmQ9o5kK9uLcgkuL8F6Q0zQ9Aoi7i+YfjEIjSSMjCJGYUXPlg6fjjOM
   58Nvs54WdE7FBsYrWjwGGpkfdIpg8TQaW/OuwCSxJvhW6loJvSYUyFSBP
   Q==;
X-CSE-ConnectionGUID: IuBeEx8ESgCFghNjri9z+A==
X-CSE-MsgGUID: HFWJwV4ZRbG6FVy4SqBCfQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="25131930"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="25131930"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 10:08:52 -0700
X-CSE-ConnectionGUID: k3q6XVXASyyTwoSwZ8TqMQ==
X-CSE-MsgGUID: Jpe2YRQZT92NRTtY+XEJTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="36147847"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 31 May 2024 10:08:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6E01B228; Fri, 31 May 2024 20:08:46 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-leds@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Pavel Machek <pavel@ucw.cz>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Johan Hovold <jhovold@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 0/4] lm3533: Remove the outdated drivers
Date: Fri, 31 May 2024 19:56:12 +0300
Message-ID: <20240531170844.1595468-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver is quite outdated from the Linux kernel internal APIs
perspective. In particular GPIO code is using legacy calls,
that started being replaced by a new API ca. 2014, i.e. ten
years ago.

Suggested-by: Linus Walleij <linus.walleij@linaro.org>

Andy Shevchenko (4):
  backlight: lm3533_bl: Remove the driver
  iio: light: lm3533-als: Remove the driver
  leds: lm3533: Remove the driver
  mfd: lm3533: Remove the driver

 drivers/iio/light/Kconfig           |  17 -
 drivers/iio/light/Makefile          |   1 -
 drivers/iio/light/lm3533-als.c      | 922 ----------------------------
 drivers/leds/Kconfig                |  13 -
 drivers/leds/Makefile               |   1 -
 drivers/leds/leds-lm3533.c          | 755 -----------------------
 drivers/mfd/lm3533-core.c           | 645 -------------------
 drivers/video/backlight/Kconfig     |  11 -
 drivers/video/backlight/Makefile    |   1 -
 drivers/video/backlight/lm3533_bl.c | 399 ------------
 include/linux/mfd/lm3533.h          | 100 ---
 11 files changed, 2865 deletions(-)
 delete mode 100644 drivers/iio/light/lm3533-als.c
 delete mode 100644 drivers/leds/leds-lm3533.c
 delete mode 100644 drivers/mfd/lm3533-core.c
 delete mode 100644 drivers/video/backlight/lm3533_bl.c
 delete mode 100644 include/linux/mfd/lm3533.h

-- 
2.43.0.rc1.1336.g36b5255a03ac


