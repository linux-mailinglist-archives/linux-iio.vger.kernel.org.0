Return-Path: <linux-iio+bounces-16909-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53C8A635F1
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 15:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 167BE7A7714
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 13:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932F11ACEAD;
	Sun, 16 Mar 2025 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="WyHgp+LF"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-16.pe-a.jellyfish.systems (out-16.pe-a.jellyfish.systems [198.54.127.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC2E19D8B2;
	Sun, 16 Mar 2025 14:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742133602; cv=none; b=h/6LaJkS+U3bqWv5KHYErg/dLpOSpDK+61lh+QyKpt59zdX5f327NAAkopUZIuF9yZ7KOHtZ7R3/yy3cnzMiMlnNTM3Z5AkgNEz0fchLueEjBVYyjf6qf++75JXmPtNs58OB9bPax9uCsLMwqgbOCOz4RkbZu9gaZ/4clGljwZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742133602; c=relaxed/simple;
	bh=Vl/ufIx096MHZv77qSr5S9QTJLYNLRDfBf1wjhPvv50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VuR3+KvnOmy31OWyd84Tb8Y8npxljNRic8d13vfE7oU3rf6ZgHFXuyLmvI3tT7wo7RQm/sQpO0blWHnOq4DaFNX2CfwxmgIFvzBGdHKTH4IDF0u61KHRHXtbY8pxlqzRPhJFEC84c2z6+0r10nd25WY2Rtk44baMhQS5nS8+KtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=WyHgp+LF; arc=none smtp.client-ip=198.54.127.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01-3.privateemail.com [66.29.159.56])
	by pe-a.jellyfish.systems (Postfix) with ESMTPA id 4ZFzzD5NLsz4wPf;
	Sun, 16 Mar 2025 13:51:20 +0000 (UTC)
Received: from MTA-12.privateemail.com (unknown [10.50.14.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01-3.privateemail.com (Postfix) with ESMTPS id 4ZFzzD3Xykz2Sd0R;
	Sun, 16 Mar 2025 09:51:20 -0400 (EDT)
Received: from mta-12.privateemail.com (localhost [127.0.0.1])
	by mta-12.privateemail.com (Postfix) with ESMTP id 4ZFzzD2DWTz3hhRq;
	Sun, 16 Mar 2025 09:51:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1742133080;
	bh=Vl/ufIx096MHZv77qSr5S9QTJLYNLRDfBf1wjhPvv50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WyHgp+LF3FCdjDcLDKhvZ858YlY7AjpkvUIvI66t1fDxP3ZqfO9ascCQVtd0wZIC/
	 z58AdDPuU7SL3QFHIqLv/KyrVx7e8pTHxctKYF7sbpmi12DPNtxxsF9WNR9rF5ejhP
	 Nu/gQjk4UhAuqV6/cLgI9I3Y0+c/jKMXiHZZh1Rz2f0HmxVSx161WKZqWl8Hk6Xax/
	 fXE8A5GXPNtaZoXT2ybTD58el/gqDpE5NFHXd2THqsM6FBBkIDQzHQSADm7A0K7fit
	 ymt6JfrbFWiak6hDznRkVIhokiWH7Mke99JyvzbjNSEsS6CmFoSQd2Lb8yC0jX31G8
	 5R7YE+n6IwfEA==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-12.privateemail.com (Postfix) with ESMTPA;
	Sun, 16 Mar 2025 09:51:04 -0400 (EDT)
From: Sam Winchenbach <sam.winchenbach@framepointer.org>
To: linux-kernel@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	antoniu.miclaus@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	sam.winchenbach@framepointer.org,
	bpellegrino@arka.org,
	Sam Winchenbach <swinchenbach@arka.org>
Subject: [PATCH v7 3/6] iio: filter: admv8818: fix integer overflow
Date: Sun, 16 Mar 2025 09:50:05 -0400
Message-ID: <20250316135008.155304-3-sam.winchenbach@framepointer.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316135008.155304-1-sam.winchenbach@framepointer.org>
References: <20250316135008.155304-1-sam.winchenbach@framepointer.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

From: Sam Winchenbach <swinchenbach@arka.org>

HZ_PER_MHZ is only unsigned long. This math overflows, leading to
incorrect results.

Fixes: f34fe888ad05 ("iio:filter:admv8818: add support for ADMV8818")
Signed-off-by: Sam Winchenbach <swinchenbach@arka.org>
---
 drivers/iio/filter/admv8818.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
index 3d8740caa145..cd3aff9a2f7b 100644
--- a/drivers/iio/filter/admv8818.c
+++ b/drivers/iio/filter/admv8818.c
@@ -154,7 +154,7 @@ static int __admv8818_hpf_select(struct admv8818_state *st, u64 freq)
 	}
 
 	/* Close HPF frequency gap between 12 and 12.5 GHz */
-	if (freq >= 12000 * HZ_PER_MHZ && freq <= 12500 * HZ_PER_MHZ) {
+	if (freq >= 12000ULL * HZ_PER_MHZ && freq < 12500ULL * HZ_PER_MHZ) {
 		hpf_band = 3;
 		hpf_step = 15;
 	}
-- 
2.48.1


