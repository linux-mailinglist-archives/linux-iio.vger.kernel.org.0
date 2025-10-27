Return-Path: <linux-iio+bounces-25484-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A61C0E811
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 15:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 472B14F9AC5
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 14:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C64D30AD0E;
	Mon, 27 Oct 2025 14:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Laimmuns"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F37A218AD1;
	Mon, 27 Oct 2025 14:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575940; cv=none; b=psYbMLfPPSlqKMVAo2ebJQv7vWaR9Y1KGPWKVBZ2aWDOSdWx15YJwFsCTSSkLVRr8/1Zb0v7Aq7xLGwfotvhh+TG4TrLrzhMYbaf3XFtAwnIv5ps+ih9QMu+gkLj+T80vXaoLGx2kSteJrMVr5a2Q0VUkIGeMFRVSjF31DzzxOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575940; c=relaxed/simple;
	bh=kgLsFhWseh0ujDYIDdowa7yD3Ra0B33OBKNPNc/z5WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eubeDD+qu5QrgyiEeu38/M1AMSR9rFS74t159Yhf7lxlHj8FNBybplHmLr1V/FMMJNk3m8BsTMTKrwfRdu3pRJASykdNMt8sowlsC1jjUQ95YxAgR9N+j8Wo32yLB0L2fQA2lHuPZALD2uptEnkJtT0N3zRONaMzDzauhycm9MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Laimmuns; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761575938; x=1793111938;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kgLsFhWseh0ujDYIDdowa7yD3Ra0B33OBKNPNc/z5WY=;
  b=Laimmunsicr9TMjGLj6B/uiiAqNDDwQp14Z4W3ed2035PbtptFeGYT1m
   linHqC5uTUYQXy8xmayTqtg9j5xIbqoa9Fx79gcDjMZK08rdXYDc2X3i8
   lHgN0Qfi2he+6cdUpYlybumok5nYFmdgcK1PpUoyD2yhR2sOFoJG8fjed
   3zi01rQnFr1lZ201RxkxyxCA5TelLhlUQKGSLpa/PCJQYucPoSuXRgfaz
   jXC/RZaK/OOEZJqD8ZQ0/1EhjrA5w/inH6y1xhRX6fhdI6yZGMp63Ge73
   OAPFcgfcEMNNyb85cAt9FYXO4wh3bYxL0S+9vtphh7o4rbuUG1RPaq/pD
   A==;
X-CSE-ConnectionGUID: cc4p9ZHvQli9bBBwkKZVzA==
X-CSE-MsgGUID: nWUxzgujTFuOL7aHlY2nJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67299498"
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="67299498"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 07:38:57 -0700
X-CSE-ConnectionGUID: tvtm8zCpQXWL1kiPvyOWLA==
X-CSE-MsgGUID: frXLvfIjQb2EQex6nulUCg==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 27 Oct 2025 07:38:54 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 4CE0696; Mon, 27 Oct 2025 15:38:53 +0100 (CET)
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
Subject: [PATCH v1 1/6] media: vidtv: Rename PI definition to PI_SAMPLES
Date: Mon, 27 Oct 2025 15:34:50 +0100
Message-ID: <20251027143850.2070427-2-andriy.shevchenko@linux.intel.com>
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

The definition of PI in the driver is not the actual value in radians,
but rather degrees. Since we are going to have a value in radians
defined in a global header, rename this definition to avoid potential
collisions. No functional changes.

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


