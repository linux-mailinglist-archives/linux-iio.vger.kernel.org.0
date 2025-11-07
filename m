Return-Path: <linux-iio+bounces-26029-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E87C41875
	for <lists+linux-iio@lfdr.de>; Fri, 07 Nov 2025 21:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 483ED189C441
	for <lists+linux-iio@lfdr.de>; Fri,  7 Nov 2025 20:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762D530B526;
	Fri,  7 Nov 2025 20:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dAOsUdZI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545E129E10B;
	Fri,  7 Nov 2025 20:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762546217; cv=none; b=AqS6T7MNmmalPvonL6agSaPRGimekz1lcshnjaxJ4l9oxOqTddPWgrM1b3QlyBcOCAX4fSQMoysj4WYbRlcp7EmMEZLqMUzvNiy2D2+9LCDjdDncloZzRUJuQN6WBPrl2oo4bPz0RV/MLQ02VUZ/H6sB1OxlDADfNyWmon2q6is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762546217; c=relaxed/simple;
	bh=84hvNmk1wrkfPc8Aw4HiHMUeu30dNeI0g/yAJW6HfMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rdhQlEExBOuetf4IrQxNWhG3NwR3+ClGTc3v1zOOU/fymOAHGaVnRhTwy6cyLurBngpQccZEt9wpkfB5oNmdil56eYLnB5B56tXZKAYuJUT7MR0KJIBVqkNC649Bo57ILQqiv9AfSjJYHMAoDd7QlMA3CxQDOPVGEZlpxY6Xzm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dAOsUdZI; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762546215; x=1794082215;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=84hvNmk1wrkfPc8Aw4HiHMUeu30dNeI0g/yAJW6HfMk=;
  b=dAOsUdZIYNF2oGkxwsx37XWknlc+gTCAe9GFGBV315eYpRmnhnDL3xCb
   44728X5URpUsP1OuCGLzeETCZPY1BOsl18OmRtr4dbeR83HWk0ocHk3Bz
   TXRSZLyt951T9rgATE4U+Q1mH7e/xo/6O5tFIRmvJ6PVhu2uP7e50z56x
   VwzFpBrbjyK5/D1o7vqA5zEZ5YnWK8YzHxBvAnWxtwQPBP3CYVvfLjkkD
   xjPX12ZQSkMW+oin2CSALdujyWuC+dHQBUSrYSqAisfQtQLdu8sOKp51N
   zXSAA4rraajFpTF4BHd7MiS/zVUGPWSL6gqAJLStOA0AtOaCysyEKwP9e
   Q==;
X-CSE-ConnectionGUID: +mk3lFxHQpy8fiaAagFgrQ==
X-CSE-MsgGUID: O7K4AmumSyyTw4254INC5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="64400153"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="64400153"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 12:10:15 -0800
X-CSE-ConnectionGUID: L3pN/AknT0WGhHbFTM1CEw==
X-CSE-MsgGUID: RQxIx9bNQ1yIpX4eyC7d1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="188065153"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 07 Nov 2025 12:10:11 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id DEB6B97; Fri, 07 Nov 2025 21:10:09 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
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
Subject: [PATCH v2 2/6] =?UTF-8?q?units:=20Add=2032-=20and=2064-bit=20sign?= =?UTF-8?q?ed=20values=20of=20=CF=80?=
Date: Fri,  7 Nov 2025 21:03:00 +0100
Message-ID: <20251107201005.3156118-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251107201005.3156118-1-andriy.shevchenko@linux.intel.com>
References: <20251107201005.3156118-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There are a few drivers that want to have these values, and
one more known to come soon. Let's define the values for them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/units.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/units.h b/include/linux/units.h
index f626e212d4ca..5b3293bce04c 100644
--- a/include/linux/units.h
+++ b/include/linux/units.h
@@ -21,6 +21,12 @@
 #define PICO	1000000000000ULL
 #define FEMTO	1000000000000000ULL
 
+/* Value of π * 10⁸ (fits s32 or signed int) */
+#define PI	314159265
+
+/* Value of π * 10¹⁸ (fits s64 or signed long long) */
+#define PI_LL	3141592653589793238LL
+
 /* Hz based multipliers */
 #define NANOHZ_PER_HZ		1000000000UL
 #define MICROHZ_PER_HZ		1000000UL
-- 
2.50.1


