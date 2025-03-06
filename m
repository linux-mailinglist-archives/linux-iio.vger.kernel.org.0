Return-Path: <linux-iio+bounces-16485-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BF5A55519
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 19:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC7FA3A466B
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 18:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C3926BD80;
	Thu,  6 Mar 2025 18:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="nQmPC5Xh"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-15.pe-b.jellyfish.systems (out-15.pe-b.jellyfish.systems [198.54.127.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE23269CE8;
	Thu,  6 Mar 2025 18:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741286079; cv=none; b=eyvANxw+kKBmwd/Z9GK1yU3dvaqaC/k9zVKzdZvJcW+J5UtwT3kSl7Nf/ZqSLTHkGvJ+cyD33M5EU5pQcoj0Oj/QCO8Pn3jaX4yCe9paY3beQj2FThaMgTYCBcP33boGImcz9iAa/diFRasDvyqrLduin50tj44U8YAUccH8zHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741286079; c=relaxed/simple;
	bh=mVTw6WI2Lz7Orwo/Jz6R+IAedXd3s0R/r2B5TMDZmsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cq39IWn4QIQFOOxUmiCbZ8AjeuQsO5n85RSHft2VLsTbghBenjAnYK8CGRhTcOt7+LIwVIQc07jj0qxrq42sDpS1/JbHme9QP8Otg+EWcmxW3CVNG+FIiB4ZcC9XQM00xNsUTgYHSVrJKAu2rFTE6aErzQ0kO+BG39ZvQYkx/5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=nQmPC5Xh; arc=none smtp.client-ip=198.54.127.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01.privateemail.com [198.54.118.220])
	by pe-b.jellyfish.systems (Postfix) with ESMTPA id 4Z7ykb05ZWzDqR7;
	Thu, 06 Mar 2025 18:34:31 +0000 (UTC)
Received: from MTA-05.privateemail.com (unknown [10.50.14.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01.privateemail.com (Postfix) with ESMTPS id 4Z7ykZ6pjgz3hhVZ;
	Thu,  6 Mar 2025 13:34:30 -0500 (EST)
Received: from mta-05.privateemail.com (localhost [127.0.0.1])
	by mta-05.privateemail.com (Postfix) with ESMTP id 4Z7ykZ5Lzyz3hhbJ;
	Thu,  6 Mar 2025 13:34:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1741286070;
	bh=mVTw6WI2Lz7Orwo/Jz6R+IAedXd3s0R/r2B5TMDZmsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nQmPC5Xho7xI7ycO+wo/PaNzPBBm2FpFEb5GYb2QXQRzWgOFf/XXiwTX57y9CwMff
	 +o6xwFYkSvWg2mzlGXuTgdfuRASwwV3IIW/IK3zMTNtpTTJhWTNhZXqLbdRX0dhvZo
	 6LCcHvmNhcAFmMHUlo4iFHK1+opPZ0O32tXSkYQCRgw/XO09o9C6ozij+lvOjjNcwg
	 9xRb3u7BvuTBnWw+H6G7qiLPI4aOAuWum9ZKN2T0fUO1kPjT71MEUtGO+543oGMggV
	 6RinokGUfp9vw60lqsqmd2/mn+7nTTTN5pAryq7Lz6x8HbF5b99tpf4EPQOEkBGl5X
	 9C3O/OQOgrwHA==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-05.privateemail.com (Postfix) with ESMTPA;
	Thu,  6 Mar 2025 13:34:15 -0500 (EST)
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
Subject: [PATCH v5 3/6] iio: filter: admv8818: fix integer overflow
Date: Thu,  6 Mar 2025 13:33:11 -0500
Message-ID: <20250306183314.150253-3-sam.winchenbach@framepointer.org>
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


