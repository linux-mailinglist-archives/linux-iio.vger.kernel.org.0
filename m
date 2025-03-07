Return-Path: <linux-iio+bounces-16535-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD075A56B79
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 16:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D4067AB8E9
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 15:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF0521E0AD;
	Fri,  7 Mar 2025 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="qhy2KiDD"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-16.pe-a.jellyfish.systems (out-16.pe-a.jellyfish.systems [198.54.127.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BC121E091;
	Fri,  7 Mar 2025 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360203; cv=none; b=ClVo/p+XNBQ4HpSt/44gwx1n5hHGV3Zz8lNoiTsMh5nOXR9qACAuDVk8V49ExjutgD9hHIcJsHyqbhtqn2nLHzXk6oFhmdxSwDsXdAGE10mMCdEwD93lUMAraG6XHSOCCc7EPEYHKaJ+KcKgknWPG9vwGiUcf8fE5zeTHI/jbIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360203; c=relaxed/simple;
	bh=ihHvQIx2ztyg1h3yxcaLwTKJXChieyv6DV25l6QnD90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UESl9QDyPLWUCjDaRNLVY6tQ9WVmm6pShmLryK+zC0OwlkpM4hvAe51hFuDW11mj7TuFDBrPPu0dxOd78LpczkrIxBdy/5y/bswTOYER5dMOuvBRSUs4YBOfp8SuyBP3g2U38I5sWy99Sriq/Tc/r8Le4BzYdDSsyKMLwwTWIS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=qhy2KiDD; arc=none smtp.client-ip=198.54.127.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01-3.privateemail.com [66.29.159.56])
	by pe-a.jellyfish.systems (Postfix) with ESMTPA id 4Z8V030r8Wz4xR1;
	Fri, 07 Mar 2025 15:02:59 +0000 (UTC)
Received: from MTA-09.privateemail.com (unknown [10.50.14.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01-3.privateemail.com (Postfix) with ESMTPS id 4Z8V023W0Pz2Sd0Q;
	Fri,  7 Mar 2025 10:02:58 -0500 (EST)
Received: from mta-09.privateemail.com (localhost [127.0.0.1])
	by mta-09.privateemail.com (Postfix) with ESMTP id 4Z8V022587z3hhS5;
	Fri,  7 Mar 2025 10:02:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1741359778;
	bh=ihHvQIx2ztyg1h3yxcaLwTKJXChieyv6DV25l6QnD90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qhy2KiDDFvcqu+ixtgYPQY02OQ6Scwnhg48qe5Myk4QwVy1TCma8BfhzfNa7i3gXP
	 ppkLwvL7igfCrEIBTdA3DnuMJkPEvcxCE2vdJ87GdqWDZUmYbMPoaGF9KO8l3HCOIh
	 n5OMKsMIAU+6OshNBhzmIRWvrW3kXBAANolwEQciHg53ZuFZh2OVZQ0jr5teKGS+3q
	 V6S2fSQbA9c1MeEzKZW/ZoUhDqlm4QfQSEg4sLG6jS3I9sD9/TjC3Y4f4RSaOLntk1
	 5SzYmXRQYmxt/63wv5NbQIJsA0Y248UeM25ZLFs+uFtm4HwRSkc7Wy3OQDKt622/3m
	 SbrImQE35mpKQ==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-09.privateemail.com (Postfix) with ESMTPA;
	Fri,  7 Mar 2025 10:02:43 -0500 (EST)
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
	bpellegrino@arka.org
Subject: [PATCH v6 2/6] iio: filter: admv8818: fix band 4, state 15
Date: Fri,  7 Mar 2025 10:02:12 -0500
Message-ID: <20250307150216.374643-2-sam.winchenbach@framepointer.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307150216.374643-1-sam.winchenbach@framepointer.org>
References: <20250307150216.374643-1-sam.winchenbach@framepointer.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

Corrects the upper range of LPF Band 4 from 18.5 GHz to 18.85 GHz per
the ADMV8818 datasheet

Fixes: f34fe888ad05 ("iio:filter:admv8818: add support for ADMV8818")
Signed-off-by: Sam Winchenbach <sam.winchenbach@framepointer.org>
---
 drivers/iio/filter/admv8818.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
index 848baa6e3bbf..8f563a426232 100644
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
2.48.1


