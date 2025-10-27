Return-Path: <linux-iio+bounces-25485-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F4DC0E965
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 15:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0C91407D64
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 14:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B37530BBA0;
	Mon, 27 Oct 2025 14:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cUZQqWwg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2362F7AD1;
	Mon, 27 Oct 2025 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575941; cv=none; b=oDWnc+KIyylMy7PLzG2U5IoOYc+4YL1B/WRBX1ZJlPeF9pdwqnIP2qBFBu9UYnsqog9hcHAyYbBFFdP6u04kfH2yAF5vgkj87vw5C4wLEUlPOHawntxsNkfBhWkpW5FzrOsYqXr+Y+lMMyHIGbc7KFFlg0fjOJfemAuVlMSbMNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575941; c=relaxed/simple;
	bh=t8/6zRVTizK4cIUezK62ZALLb792Irp9cNhxLGlkKis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1czJIcu2Evhx4jM2mBOSvz5hv7uy/QN8y7yJphgkfWUkC3hM1JzSs24x4qULhX4mTPgKTTOuXQkp5LqUDhvVfl8JNkO3bhG2vJYah87cigRnVVAS1cUDb5WljRXTmB99NQ2FOjo+93m1cZ0b2pSRvooWuk8r51htmxcuQVWjW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cUZQqWwg; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761575940; x=1793111940;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t8/6zRVTizK4cIUezK62ZALLb792Irp9cNhxLGlkKis=;
  b=cUZQqWwgHb5QugiZqHOvmJUCDZsR8zO3QfEET+67U9YjVHsgdYm9wKpR
   Slqv10ZNwJgqeS8UD8elBaBKgJuxB1LyegyeGuYkKcuF1Khc+ejg7MYnq
   Co4yIO2MKs/xCn69WhPD93dI9O2p9jFwYh2PC+auXgi9tQJE/TaDHYHZ9
   JREQt+v9BbJhZ+IRHMWRo+LEQR/U0uRFTEwjN/zAcn8iVEIsZ9vh3SYrT
   rC3f1oshD+DjLxxkoFtjLYWYIAdfLnaSNpTD/bCP3m9r4t1ZbQGkjJcAX
   Y352H1lRcZd6WSOlekqlRe40Nm2BW6noPJSw4HC2uZhves+0DWanU0WYR
   g==;
X-CSE-ConnectionGUID: Qp+DDirlT9uOGnRb9Hh6FA==
X-CSE-MsgGUID: GzCJ0Dx9RxWViqEj7bdJNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62686918"
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="62686918"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 07:38:59 -0700
X-CSE-ConnectionGUID: 6S5n2PnkSNKhgtd4dS2P3A==
X-CSE-MsgGUID: L0AlvyGrRP+pDrU5sQTYIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="184237032"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 27 Oct 2025 07:38:56 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 5ED5E9A; Mon, 27 Oct 2025 15:38:53 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Subject: [PATCH v1 5/6] iio: frequency: ad9523: Convert to use PI definition
Date: Mon, 27 Oct 2025 15:34:54 +0100
Message-ID: <20251027143850.2070427-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251027143850.2070427-1-andriy.shevchenko@linux.intel.com>
References: <20251027143850.2070427-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to use PI definition instead of open coded value of it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/frequency/ad9523.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index 63c485e9e44c..fab1671d9212 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -15,6 +15,7 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/delay.h>
+#include <linux/units.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -652,7 +653,7 @@ static int ad9523_read_raw(struct iio_dev *indio_dev,
 			AD9523_CLK_DIST_DIV_REV(ret);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_PHASE:
-		code = (AD9523_CLK_DIST_DIV_PHASE_REV(ret) * 3141592) /
+		code = (AD9523_CLK_DIST_DIV_PHASE_REV(ret) * DIV_ROUND_UP_ULL(PI, 1000)) /
 			AD9523_CLK_DIST_DIV_REV(ret);
 		*val = code / 1000000;
 		*val2 = code % 1000000;
@@ -701,7 +702,7 @@ static int ad9523_write_raw(struct iio_dev *indio_dev,
 		break;
 	case IIO_CHAN_INFO_PHASE:
 		code = val * 1000000 + val2 % 1000000;
-		tmp = (code * AD9523_CLK_DIST_DIV_REV(ret)) / 3141592;
+		tmp = (code * AD9523_CLK_DIST_DIV_REV(reg)) / DIV_ROUND_UP_ULL(PI, 1000);
 		tmp = clamp(tmp, 0, 63);
 		reg &= ~AD9523_CLK_DIST_DIV_PHASE(~0);
 		reg |= AD9523_CLK_DIST_DIV_PHASE(tmp);
-- 
2.50.1


