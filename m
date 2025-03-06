Return-Path: <linux-iio+bounces-16484-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEE6A55516
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 19:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26ED97A7933
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 18:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4240626D5C3;
	Thu,  6 Mar 2025 18:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="NOIzUefb"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-16.pe-b.jellyfish.systems (out-16.pe-b.jellyfish.systems [198.54.127.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570C826BD98;
	Thu,  6 Mar 2025 18:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741286060; cv=none; b=XVIwo45kaZGXCs48CHUaOHHFee/MG/K2B1A7FWDzp2M2riHglacHT+d4zhtDF40t144vplhOxm1976D6b48p5GYlC1ii2P0T9rZ6y+72/JqnfWRfUNvzTn/kbK1KfQIKOtK/zPD3DddSWchdC4jduwLKkffAmDP2iVMQ2R7IkXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741286060; c=relaxed/simple;
	bh=ihHvQIx2ztyg1h3yxcaLwTKJXChieyv6DV25l6QnD90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=npClSZVAcpVK270wAQKmwEvaXOx5bCjzQPPh3V0+mw2Ioslu3D1k1XWVedaMa6kF+2sMh8Q0FRMyHamOy5DpMCcVnst5cr+Hg/uhe9KSm9ZnejX1exA/wWeJUtie/xTSMMe197UcEgwIFDbqjFKcQcwCFvvtuJTSaWz+EGHhLBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=NOIzUefb; arc=none smtp.client-ip=198.54.127.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01.privateemail.com [198.54.118.220])
	by pe-b.jellyfish.systems (Postfix) with ESMTPA id 4Z7yk93KzXzGpLY;
	Thu, 06 Mar 2025 18:34:09 +0000 (UTC)
Received: from MTA-05.privateemail.com (unknown [10.50.14.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01.privateemail.com (Postfix) with ESMTPS id 4Z7yk92z25z3hhVd;
	Thu,  6 Mar 2025 13:34:09 -0500 (EST)
Received: from mta-05.privateemail.com (localhost [127.0.0.1])
	by mta-05.privateemail.com (Postfix) with ESMTP id 4Z7yk91BWSz3hhbV;
	Thu,  6 Mar 2025 13:34:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1741286049;
	bh=ihHvQIx2ztyg1h3yxcaLwTKJXChieyv6DV25l6QnD90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NOIzUefbUDGuN8u4z5NVp8XGbfy+qckheuP4PyxcO2KrxUGG0frJVnbQogH6mOcVR
	 hLbZDwoTejIAS6AGg9CVCVBnlg0KTC8tx2IOE3iychfEGW+ctP+aUhb9xmLsYrNzou
	 JE8QR/3XIPLaVP/NfzW2BdyvQS7d1WyefE7WhwKVe3o/98rl2w9fFE/FXtKAXV/dTr
	 x8qq20aY8OeyKzQZHzePKoSQ8riN1eUV4eVaChJU1QYKC4czu8VSwcryi+jhw6gt4d
	 mAp4jNjF0SDlIR7iiLnbw3h9/lBmTfli2Euh4AiFBxVbNSaDcNIffY9dFmjEIAu5+O
	 EK7FotAiqWBQA==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-05.privateemail.com (Postfix) with ESMTPA;
	Thu,  6 Mar 2025 13:33:54 -0500 (EST)
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
Subject: [PATCH v5 2/6] iio: filter: admv8818: fix band 4, state 15
Date: Thu,  6 Mar 2025 13:33:10 -0500
Message-ID: <20250306183314.150253-2-sam.winchenbach@framepointer.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306183314.150253-1-sam.winchenbach@framepointer.org>
References: <20250306183314.150253-1-sam.winchenbach@framepointer.org>
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


