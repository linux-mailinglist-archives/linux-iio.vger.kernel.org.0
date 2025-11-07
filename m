Return-Path: <linux-iio+bounces-26030-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06931C41878
	for <lists+linux-iio@lfdr.de>; Fri, 07 Nov 2025 21:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C98323A54C2
	for <lists+linux-iio@lfdr.de>; Fri,  7 Nov 2025 20:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9AC30B52B;
	Fri,  7 Nov 2025 20:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j7ROp2d3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6012FCC10;
	Fri,  7 Nov 2025 20:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762546217; cv=none; b=QGE/mfKebwlVAubeHYMtdLdg2kpM320HG8s3ev6mvuEz9s+cd/AyDxQ8srzIF8FBY7JwXmiv3RLKcowBveA1c0hXEZjudIbcvUU2tUhoe3Y5krapuAFcuRmf4GHQNVhJjlN11bctA2krTsOdsdiwmsbgAGcUvvcoI+MwGtbFOlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762546217; c=relaxed/simple;
	bh=5QG0FpgOvh5wtnP8TLZzDRojDuvAIKEwkt4o9WiKN7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNEnaY18XJTbUkQoS56Je5iJsT5AvEZG0gcET0MkfX9eCauMFTfQuBut5LynNbNUiohtnQwBKpO/ayHn1a/8r/cIpwUt1kSTHhgy323zO3Re4Dwf4Szoyznc1SWqXuuiGSsVSy0fJW7jSVLHjW7NfGcIoXUFJfzHVx2REc3NlK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j7ROp2d3; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762546214; x=1794082214;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5QG0FpgOvh5wtnP8TLZzDRojDuvAIKEwkt4o9WiKN7U=;
  b=j7ROp2d3UTxXgjYqrTIyXYhAtL6DCQcrl5l/Eqkd8u2+VZWdHggqyw6F
   QWs6tSYksbhIOsYxh3inyMVTDaay5p/4M2AdGhEEUAZX6W732kNi3HgFr
   GsCrJLZIZkS4YgKJbUQfYlY5J78I1Qpu9yEXDiTVMDwz6yxgd3sdNFfiR
   6htuBj5oWgRoDz2Dl1nbagef6BtVictfda6Ralo/IR7ME8YlG0bzBupVA
   XPDtbDhr0uB0kbuo9l3O50B3GsJZ9mXmEVYxYSHYWTQjz8ihfU9RCSIJY
   apBDsE6aItjDcUn0rb0EBAiBjnOaMTNk0ko7GK2jKfejOJ2nYYszsbkom
   w==;
X-CSE-ConnectionGUID: gmt6cHAJSiWKq37QmPr5og==
X-CSE-MsgGUID: ZNMJFLy4SOiZUQy1J7zrpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="68348697"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="68348697"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 12:10:14 -0800
X-CSE-ConnectionGUID: hWl+RhlQSNa2I3aHFHm0sA==
X-CSE-MsgGUID: VvCS4ZgmS160DI7KY7ucrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="218777174"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 07 Nov 2025 12:10:11 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id E39B098; Fri, 07 Nov 2025 21:10:09 +0100 (CET)
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
Subject: [PATCH v2 3/6] media: dvb-frontends: atbm8830: Convert to use PI definition
Date: Fri,  7 Nov 2025 21:03:01 +0100
Message-ID: <20251107201005.3156118-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251107201005.3156118-1-andriy.shevchenko@linux.intel.com>
References: <20251107201005.3156118-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to use PI definition instead of open coded value of it.

Acked-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/media/dvb-frontends/atbm8830.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-frontends/atbm8830.c b/drivers/media/dvb-frontends/atbm8830.c
index 778c865085bf..93181e0eb34f 100644
--- a/drivers/media/dvb-frontends/atbm8830.c
+++ b/drivers/media/dvb-frontends/atbm8830.c
@@ -6,7 +6,8 @@
  *    Copyright (C) 2009 David T.L. Wong <davidtlwong@gmail.com>
  */
 
-#include <asm/div64.h>
+#include <linux/math64.h>
+#include <linux/units.h>
 #include <media/dvb_frontend.h>
 
 #include "atbm8830.h"
@@ -112,7 +113,7 @@ static int set_if_freq(struct atbm_state *priv, u32 freq /*in kHz*/)
 
 	if (freq != 0) {
 		/* 2 * PI * (freq - fs) / fs * (2 ^ 22) */
-		t = (u64) 2 * 31416 * (freq - fs);
+		t = (u64) 2 * DIV_ROUND_UP(PI, 10000) * (freq - fs);
 		t <<= 22;
 		do_div(t, fs);
 		do_div(t, 1000);
-- 
2.50.1


