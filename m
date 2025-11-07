Return-Path: <linux-iio+bounces-26028-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 56427C41866
	for <lists+linux-iio@lfdr.de>; Fri, 07 Nov 2025 21:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BA9F4E0411
	for <lists+linux-iio@lfdr.de>; Fri,  7 Nov 2025 20:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3EC309DDB;
	Fri,  7 Nov 2025 20:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eOmJ5Bwj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5007C248886;
	Fri,  7 Nov 2025 20:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762546216; cv=none; b=VJ2WsYoTkTYHsPEpAFODF+AI1UD3VE3Z+qc46LtdkGIKUkG7BJUfJRvx5U1Xhy8gURC4sz3/OHdVezyzQ1jSlKhXvk9nXn2CpN80PhOnUUBP29NopaXYndU86OaBc3CxOfT4cN7rIIqQbfMW0LBp4+NJc6msFVJr25tNWWgb0Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762546216; c=relaxed/simple;
	bh=gZxnTDD1Ce1SqG2GR6hS7cmsMjDdgSRDGSuC/N0eyg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSSpDIs5Fx3z/tqHWTCtS3v090ozI1Qvz7XcPEIQGtZhCdmxK4/D6uRH7ql9Z7LMKfmaBCSZvPq5ypDWxdsWyMcfMwwuNRS+3MryFbldG4adErhCC9w9RFzo3m1m2ghsorTzCALcZLkDSCRYu0neaSOm83Gk5GIBLFn/+wrdiKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eOmJ5Bwj; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762546214; x=1794082214;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gZxnTDD1Ce1SqG2GR6hS7cmsMjDdgSRDGSuC/N0eyg4=;
  b=eOmJ5BwjY+4oV8lKesMN8lg2CJ3J0skrmMIiSmtNwzL8fBDaxY9CYnXD
   0GRc/m2dI+Ank1u9pbrH/JW9+hnCXHuESxQ0IASyf0Zt2X2G6NdPzDphK
   kr3nlrdd7Fbk+IfazKQ7KD+2x5zBaBnowednJdV1SsW4lNWRLeFdm37nR
   MHBE+xXwycwl+DWVhRcGXLbgF5KUuklWenhs6gSZ554p4p2TNG4rh10vr
   VNHiqBP6F43JS6vC+2ZdJ18iSF8i+4NvmFLTzMcWN7dNzDCD0UipY+2Ze
   t3XE1gmUUeq8lcLLu6JhUpUMY/LEj476nZXj8qo4lyDzfG0pqbO3LLci6
   w==;
X-CSE-ConnectionGUID: 060Y0LUbQfujMplj2rS4IQ==
X-CSE-MsgGUID: 43FKdsGySTa2SSHtIwi//g==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="75392090"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="75392090"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 12:10:13 -0800
X-CSE-ConnectionGUID: yTkssod/RnCj9VKYmQYKAQ==
X-CSE-MsgGUID: Ptst7ycIQnajgDzbJaPtIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="218860981"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 07 Nov 2025 12:10:10 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id D9F2896; Fri, 07 Nov 2025 21:10:09 +0100 (CET)
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
Subject: [PATCH v2 1/6] media: vidtv: Rename PI definition to PI_SAMPLES
Date: Fri,  7 Nov 2025 21:02:59 +0100
Message-ID: <20251107201005.3156118-2-andriy.shevchenko@linux.intel.com>
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

The definition of PI in the driver is not the actual value in radians,
but rather degrees. Since we are going to have a value in radians
defined in a global header, rename this definition to avoid potential
collisions. No functional changes.

Acked-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/media/test-drivers/vidtv/vidtv_s302m.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/test-drivers/vidtv/vidtv_s302m.c b/drivers/media/test-drivers/vidtv/vidtv_s302m.c
index 9da18eac04b5..b3217d643b1e 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_s302m.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_s302m.c
@@ -45,7 +45,7 @@
 #define FF_S302M_DEFAULT_PTS_OFFSET 100000
 
 /* Used by the tone generator: number of samples for PI */
-#define PI		180
+#define PI_SAMPLES		180
 
 static const u8 reverse[256] = {
 	/* from ffmpeg */
@@ -259,10 +259,10 @@ static u16 vidtv_s302m_get_sample(struct vidtv_encoder *e)
 		if (!ctx->last_tone)
 			return 0x8000;
 
-		pos = (2 * PI * ctx->note_offset * ctx->last_tone) / S302M_SAMPLING_RATE_HZ;
+		pos = (2 * PI_SAMPLES * ctx->note_offset * ctx->last_tone) / S302M_SAMPLING_RATE_HZ;
 		ctx->note_offset++;
 
-		return (fixp_sin32(pos % (2 * PI)) >> 16) + 0x8000;
+		return (fixp_sin32(pos % (2 * PI_SAMPLES)) >> 16) + 0x8000;
 	}
 
 	/* bug somewhere */
-- 
2.50.1


