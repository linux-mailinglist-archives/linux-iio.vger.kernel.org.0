Return-Path: <linux-iio+bounces-16531-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F84A56B15
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 16:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E59E11748E2
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 15:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F9821C16D;
	Fri,  7 Mar 2025 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="TrwCnQTF"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-16.pe-a.jellyfish.systems (out-16.pe-a.jellyfish.systems [198.54.127.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB471218591;
	Fri,  7 Mar 2025 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741359796; cv=none; b=jj+6a8Xenq1S+5emIsNu5bjBSeSndoML5GQVC/w5+NVmRxrFWrsljW0SNxJzzcohCqK9VYcaBh0NIn1Oyaxsmn8LWhxhK/rQFZmMul4G/TL0P7q7WDYbvGCRYGW/AJvFYKo8qybysvUY26IQdRYa16b5QV4ekm7oqLHtlAvlhDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741359796; c=relaxed/simple;
	bh=mVTw6WI2Lz7Orwo/Jz6R+IAedXd3s0R/r2B5TMDZmsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRgxft5vnwAe1vcKzloNu9zwKP5LoZV+fX7O0VbRm7a0bBbsFOumj03cbKb5iEc4Xaxp5+3y8kDl8z9azvk0drOJOvvAhtNaRAGCialvgvr8ocJsf583TJUDWrwnf58KAYc1CikqK0wygygth6cbDHBqUY1j1c1D4YY7HB0fk98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=TrwCnQTF; arc=none smtp.client-ip=198.54.127.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01-3.privateemail.com [66.29.159.56])
	by pe-a.jellyfish.systems (Postfix) with ESMTPA id 4Z8V0K3BKWz4xR2;
	Fri, 07 Mar 2025 15:03:13 +0000 (UTC)
Received: from MTA-09.privateemail.com (unknown [10.50.14.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01-3.privateemail.com (Postfix) with ESMTPS id 4Z8V0K2N2Gz2Sd0Q;
	Fri,  7 Mar 2025 10:03:13 -0500 (EST)
Received: from mta-09.privateemail.com (localhost [127.0.0.1])
	by mta-09.privateemail.com (Postfix) with ESMTP id 4Z8V0K10rzz3hhSR;
	Fri,  7 Mar 2025 10:03:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1741359793;
	bh=mVTw6WI2Lz7Orwo/Jz6R+IAedXd3s0R/r2B5TMDZmsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TrwCnQTFiL7D0U+lJ0Vhy1YpKtEXOb13pVYepFqhuLRtmnWt9pgmbR6nP65WX7x4d
	 XDCCbl8+0vTLOIggrAIaDom0KlHiAO/XI66ySn+OQIbkIPYKgIRKxC3NorZ7k2T9EK
	 U0t87qSQiHaVQbR05OpSQQWFX3+xOGdEvX37Ug9/zdB4kxOa2dFOdtKp3FkVRxJ437
	 eZ1OaEFgZfCm0w6ZkYr+JM0t6XvgExRK/GbBnfTTAiBPsxXczpcrt9b3BpqxfjQCLj
	 B/lT2nVDae4I/9zTNwv46ufkpHHQS1Wvm/PkEtjevXE7QEJp6ED0W/stvfp1VZw39Q
	 mwsdIAxJTDMDQ==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-09.privateemail.com (Postfix) with ESMTPA;
	Fri,  7 Mar 2025 10:02:58 -0500 (EST)
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
Subject: [PATCH v6 3/6] iio: filter: admv8818: fix integer overflow
Date: Fri,  7 Mar 2025 10:02:13 -0500
Message-ID: <20250307150216.374643-3-sam.winchenbach@framepointer.org>
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

HZ_PER_MHZ is only unsigned long. This math overflows, leading to
incorrect results.

Fixes: f34fe888ad05 ("iio:filter:admv8818: add support for ADMV8818")
Signed-off-by: Sam Winchenbach <sam.winchenbach@framepointer.org>
---
 drivers/iio/filter/admv8818.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
index 8f563a426232..a059282e0251 100644
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


