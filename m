Return-Path: <linux-iio+bounces-13065-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC9C9E30CD
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 02:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1671B164527
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 01:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AAA14A8B;
	Wed,  4 Dec 2024 01:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P8pr9Oxc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90657846F;
	Wed,  4 Dec 2024 01:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733276187; cv=none; b=GLse93PU0dUIeX+aS95WcMCKfquDHNybRsQL/GM4uiCDcQPUKpS2/9xbLTMzf9qMyhPt+MMA5xLXYXicV/1RnadTzuTkYTkJHuMLP/js7O6WaZld0u3iL95uBdlvEgDzOiaef75TGSmvPO2Aefm9kHHmtXq3YQRbiec5q4tR2Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733276187; c=relaxed/simple;
	bh=FFvequ/mfqiZtc1OdaDGJVhmmWqYniLAWEv5dTvXPgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQrHaG9TcpzuA5ndkTCDDVJwUnk+eFXxBghrZjqp/tpsWxw2zF+01zJRAWUlXpLAJJKOlWx9E2PefOy1BheSOFOHohkJpLI+EC0ONQKf/pTb5733tWAP8JU7cDFRTwa8FGpVRmQj9Acxf2zQmLqvq6rApRJ4vKBpMcJ3+mQqQyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P8pr9Oxc; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733276186; x=1764812186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FFvequ/mfqiZtc1OdaDGJVhmmWqYniLAWEv5dTvXPgA=;
  b=P8pr9OxcLdOMk1OKJ9QS0/kGhLRK4+vAp1xSsPt9t9JOtVjDIbMt9pAH
   9up2tfVwaTDoeBc0Lpyxm3Cz9PDOj948Wg8WQBLKRD8c4ws91ScIAKPYM
   Ykv37EjkfCZHBq7tiL1n50Esh2ZEkXuteKBU+0Wv7hSzIH+/F2fDROdgN
   dMEMeoWDiuml3piSo89gbEHe6ypnYKad7Xm5mT22/zyzyWl4dvZt0k4ky
   hCVaR0e6NVGkMhZOTPdnWdNDiwb0HDcjmtrQSUzAjbbu3q2WWRQak0Uy8
   T4h01bLYaMRsXOLYzmtRYzbqTXtrOtuamhWio05m8ly5QmP2yu3hgbB1r
   g==;
X-CSE-ConnectionGUID: h/99cnFuRdiFvifo17h1FQ==
X-CSE-MsgGUID: XEsCOEeRQt+5RnHiqCvdbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="33655185"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="33655185"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 17:36:25 -0800
X-CSE-ConnectionGUID: ogI+hdr7StmUIZ1QlIcXzw==
X-CSE-MsgGUID: eDEuZZ1xQGS6VbcKxAgC9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="98600611"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 03 Dec 2024 17:36:23 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 223721EC; Wed, 04 Dec 2024 03:36:22 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/4] iio: afe: rescale: Don't use ^ for booleans
Date: Wed,  4 Dec 2024 03:33:16 +0200
Message-ID: <20241204013620.862943-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241204013620.862943-1-andriy.shevchenko@linux.intel.com>
References: <20241204013620.862943-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two (non-critical) issues with the code. First of all,
the eXclusive OR is not defined for booleans, so boolean to integer
promotion is required, Second, the u32 variable is used to keep
boolean value, so boolean is converted implicitly to the integer.

All these are not needed when variable is defined as boolean to begin
with and operations are replaced by simple != and ||.

Fixes: 701ee14da95d ("iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/afe/iio-rescale.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index b6a46036d5ea..470dd7d41b2a 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -26,7 +26,7 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 	int _val, _val2;
 	s32 rem, rem2;
 	u32 mult;
-	u32 neg;
+	bool neg;
 
 	switch (scale_type) {
 	case IIO_VAL_INT:
@@ -95,7 +95,7 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 		 * If only one of the rescaler elements or the schan scale is
 		 * negative, the combined scale is negative.
 		 */
-		if (neg ^ ((rescale->numerator < 0) ^ (rescale->denominator < 0))) {
+		if (neg != (rescale->numerator < 0 || rescale->denominator < 0)) {
 			if (*val)
 				*val = -*val;
 			else
-- 
2.43.0.rc1.1336.g36b5255a03ac


