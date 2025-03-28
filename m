Return-Path: <linux-iio+bounces-17320-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E99A74FF9
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 19:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 989C97A1B9F
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 18:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395D71E0E0A;
	Fri, 28 Mar 2025 17:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="iLOBS5zV"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-09.pe-a.jellyfish.systems (out-09.pe-a.jellyfish.systems [198.54.127.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EB71D54D6;
	Fri, 28 Mar 2025 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743184503; cv=none; b=c6WMljxdd2I92XawNWgmQ+wwDB6hNcc6QoHSS/n+ukJlVJtX+bYh+EgL+mTv77MOk20YWIWy8cToBX4suG9JNMiIyHLsQYecZ5HbZ3F5k+dMdICLCYMKmmnBFFkPZK/CuCGqNfCktdOCgrQ1/nmeQOWgW5zmn0d45pzn5F8bl+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743184503; c=relaxed/simple;
	bh=sIIeYp8PANGpE3s/i2ut7ke4KazsR9oUb1fQXJZMGYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KPTOH1esl0tL1/S3un0BCyZQinX2V7oKJItVofQgh+FteTxRHqBXqR19Yu4ehJNxH56ayIig20HN0HTf06XZIyaUlKHZfDprPxtoDl3x6MzhqF7J1R+EP7yAGeO3Vq8MuEDt9PU+uEKN8sMucB74fR1/5/JaDT9XVUCq5t05VtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=iLOBS5zV; arc=none smtp.client-ip=198.54.127.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01-3.privateemail.com [66.29.159.56])
	by pe-a.jellyfish.systems (Postfix) with ESMTPA id 4ZPShR4lvvz9sQC;
	Fri, 28 Mar 2025 17:49:27 +0000 (UTC)
Received: from MTA-14.privateemail.com (unknown [10.50.14.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01-3.privateemail.com (Postfix) with ESMTPS id 4ZPShR3lZgz2Sd0Q;
	Fri, 28 Mar 2025 13:49:27 -0400 (EDT)
Received: from mta-14.privateemail.com (localhost [127.0.0.1])
	by mta-14.privateemail.com (Postfix) with ESMTP id 4ZPShR2RZYz3hhTs;
	Fri, 28 Mar 2025 13:49:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1743184167;
	bh=sIIeYp8PANGpE3s/i2ut7ke4KazsR9oUb1fQXJZMGYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iLOBS5zVLjzwEZHfs449Itxz7Xe9EyOdA7463nB9XUeZMWTjvt8yzmf4EzcxOdo8V
	 R574WhugV/2YQ/bKxAtz9tqTWHVq5McUsDq7gmf8vaFnOgWXRtaT6gawa1rSKGzitM
	 3gVvuBD9x+y4mcPdmR+U7ilM3YBgdRjT9VRvnSn2jFEVPz5u6s0Q+to1AGuNg/3Z8/
	 3jW2IvXcnt0PKRhRZdILY/F2w9zz1Dg7xYLE/kuPunDt6bpmAZAaU8/F/y1x/n9Xpa
	 sKM3/i7Oya/ccbZOJmySvGDkFGj2oucBvR2IzF5xRPgyecifisoZh25N63Bw9Jx/lP
	 GMw3vkGyog51Q==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-14.privateemail.com (Postfix) with ESMTPA;
	Fri, 28 Mar 2025 13:49:11 -0400 (EDT)
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
Subject: [PATCH v8 2/6] iio: filter: admv8818: fix band 4, state 15
Date: Fri, 28 Mar 2025 13:48:27 -0400
Message-ID: <20250328174831.227202-3-sam.winchenbach@framepointer.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250328174831.227202-1-sam.winchenbach@framepointer.org>
References: <20250328174831.227202-1-sam.winchenbach@framepointer.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

From: Sam Winchenbach <swinchenbach@arka.org>

Corrects the upper range of LPF Band 4 from 18.5 GHz to 18.85 GHz per
the ADMV8818 datasheet

Fixes: f34fe888ad05 ("iio:filter:admv8818: add support for ADMV8818")
Signed-off-by: Sam Winchenbach <swinchenbach@arka.org>
---
 drivers/iio/filter/admv8818.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
index d85b7d3de8660..3d8740caa1455 100644
--- a/drivers/iio/filter/admv8818.c
+++ b/drivers/iio/filter/admv8818.c
@@ -103,7 +103,7 @@ static const unsigned long long freq_range_lpf[4][2] = {
 	{2050000000ULL, 3850000000ULL},
 	{3350000000ULL, 7250000000ULL},
 	{7000000000, 13000000000},
-	{12550000000, 18500000000}
+	{12550000000, 18850000000}
 };
 
 static const struct regmap_config admv8818_regmap_config = {
-- 
2.49.0


