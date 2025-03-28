Return-Path: <linux-iio+bounces-17321-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EC2A74FFB
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 19:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37C1D1893B89
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 18:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CAB1E1DEB;
	Fri, 28 Mar 2025 17:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="dv2YbKOu"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-10.pe-a.jellyfish.systems (out-10.pe-a.jellyfish.systems [198.54.127.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6771DDC34;
	Fri, 28 Mar 2025 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743184503; cv=none; b=Bo21GfSXu8ctfVp4uqNFY85NqOUh150PNFBopv9JipGtN5h53gEdR9ksptoudwF7sthm+iLp8gsJnz26snKrrLBHP55wPWkb5BpxXFolZwPsSZiRwYuuxwguZdubrea6LmzCb2z3AwgbxOxwDhTdukAtjTCj8UomQUxRDhyrPWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743184503; c=relaxed/simple;
	bh=qindB+11Ls3Q9kbh41Qf1DgJD19+LpECy+VTjeVr7HI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlfKmX0q+uh6/lTi82CbJUT/hEgjTcVkWSpz8ZluiPspp5GJ7fCxuJUis2Y6PnIiKguFhdgleCZPCXiBL77fD8BYTnv3clyNzWzVCg/cd+WRQ42ua6yYmY4G51ZNfB47GU8Omu2u/1fQLkvb7iZONSrsU+Jp6inJzyeRTYiUnq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=dv2YbKOu; arc=none smtp.client-ip=198.54.127.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01-3.privateemail.com [66.29.159.56])
	by pe-a.jellyfish.systems (Postfix) with ESMTPA id 4ZPShl4QPMz9sXD;
	Fri, 28 Mar 2025 17:49:43 +0000 (UTC)
Received: from MTA-14.privateemail.com (unknown [10.50.14.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01-3.privateemail.com (Postfix) with ESMTPS id 4ZPShl3fqbz2Sd0Q;
	Fri, 28 Mar 2025 13:49:43 -0400 (EDT)
Received: from mta-14.privateemail.com (localhost [127.0.0.1])
	by mta-14.privateemail.com (Postfix) with ESMTP id 4ZPShl2Kkmz3hhTs;
	Fri, 28 Mar 2025 13:49:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1743184183;
	bh=qindB+11Ls3Q9kbh41Qf1DgJD19+LpECy+VTjeVr7HI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dv2YbKOuzCfK8fW6jjnq2M2QQJqwsfP96kfaYTGUliZPK4Sb3zUaBVAnjPb3tOcjv
	 qhIhgdLoRv1d33iTtkhZuNCHyFWZLUaSxb6KpQIoryAA5UzIvrUeGPnsKWo44vHoNp
	 WF7hUDBMWzjG0J04XttJ/qEV48QCNJVsV+4/OXpbZ2h4ABtQK6rxPlxJp55Rh6Kyu3
	 rcfAj9sspxtnU1prRj7Gplmv0wTq87uPFisJzuYFwh0GdG2Y53e3GI5jMcfOdzFnUw
	 drEUU/cEJT553/4gJimP/BPQEAyPCOkvdvY++/MhBnCzwyu9yQk360Z9npEzJTXJ7D
	 V5NL37fjVlprw==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-14.privateemail.com (Postfix) with ESMTPA;
	Fri, 28 Mar 2025 13:49:27 -0400 (EDT)
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
Subject: [PATCH v8 3/6] iio: filter: admv8818: fix integer overflow
Date: Fri, 28 Mar 2025 13:48:28 -0400
Message-ID: <20250328174831.227202-4-sam.winchenbach@framepointer.org>
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

HZ_PER_MHZ is only unsigned long. This math overflows, leading to
incorrect results.

Fixes: f34fe888ad05 ("iio:filter:admv8818: add support for ADMV8818")
Signed-off-by: Sam Winchenbach <swinchenbach@arka.org>
---
 drivers/iio/filter/admv8818.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
index 3d8740caa1455..cd3aff9a2f7bf 100644
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
2.49.0


