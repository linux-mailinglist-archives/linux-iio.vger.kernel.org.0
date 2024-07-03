Return-Path: <linux-iio+bounces-7258-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A259B92653B
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 17:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AFFD1F23A12
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 15:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD4C17966D;
	Wed,  3 Jul 2024 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="BP4wdYBK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FC7442C;
	Wed,  3 Jul 2024 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720021640; cv=none; b=HG24GmT4rR0RFR5qDNqSQPFV+h62fE+nebWS5htTxeMTWqAOpWWRwsv1Fun61KLJ6Kpw/qHmYDjymGKaZhQLl/bV8fKa8LIFE7Z3lhdO9NLg+u0wSDZjYdMJFJ+KcRAudBkiT8dVyTUccSZ1maaIpUD0VQopzabQt5Fo44NIUn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720021640; c=relaxed/simple;
	bh=Q8Xt/8YnnP3LTXdqSBkCU3Ipwti9fbiabN+rpCqT3cg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KWjBkqe/dVp+//I4Nhb5qRruueead9SYjIghOe9lTiCT+QZKs9IIUOBqUlVeJ9SoqJAksGrZaxXaZgcOqVJVcTVHUunnBgieFGehuth4ZN2AdHvSkur+6SaXNQrtMbjOVT3R3xw+HOGUC+x/TGl3orC+q5QCS7jhKyxcDuNe+Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=BP4wdYBK; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 39C38100004;
	Wed,  3 Jul 2024 18:46:55 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1720021615; bh=aaAtfu0bay8K56ozdAui+ro4SrSIeYspj4YS0cWnXTk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=BP4wdYBK4iQ+N8gE7rk2ZDgJNwrIPpgCAi4uledt8oN9WTRG6s7zzVq2ZvS462k8u
	 TCvEP0bNZ3Zx/cLNeJV82cv0YBvomQZYfO0gB9Sn3/QZeCnpceQaQbF7WxmhylLARq
	 PW1Sk/LfpFLLzj9kWKg4eXgBL4YapDMv04BKhD7XknXnWtzTPNSrQmK5If6f89y321
	 m8u0B/fY6Jws9bM3R1c+lz82lwrXYzq+jHBYPvW5G4SNrQ6vLja0azfh1hgsImE3ZQ
	 R+5G///N7vM6Yi+xrRlQrs0Fh6uYk41aKzq4LKSvp7FH3f/01TLFF5Ts2tZkxsB2At
	 JiaPVpdlwJzZg==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Wed,  3 Jul 2024 18:45:53 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.5) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 3 Jul 2024
 18:45:33 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Michael Hennerich <Michael.Hennerich@analog.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Lars-Peter Clausen
	<lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Datta Shubhrajyoti <shubhrajyoti@ti.com>,
	<linux-iio@vger.kernel.org>, <linux-staging@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, Dan Carpenter
	<dan.carpenter@linaro.org>
Subject: [PATCH v2] staging: iio: frequency: ad9834: Validate frequency parameter value
Date: Wed, 3 Jul 2024 18:45:06 +0300
Message-ID: <20240703154506.25584-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240703104734.12034-1-amishin@t-argos.ru>
References: 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186312 [Jul 03 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 21 0.3.21 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05, {Tracking_from_domain_doesnt_match_to}, mx1.t-argos.ru.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;t-argos.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/03 14:53:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/07/03 06:16:00 #25818842
X-KSMG-AntiVirus-Status: Clean, skipped

In ad9834_write_frequency() clk_get_rate() can return 0. In such case
ad9834_calc_freqreg() call will lead to division by zero. Checking
'if (fout > (clk_freq / 2))' doesn't protect in case of 'fout' is 0.
ad9834_write_frequency() is called from ad9834_write(), where fout is
taken from text buffer, which can contain any value.

Modify parameters checking.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 12b9d5bf76bf ("Staging: IIO: DDS: AD9833 / AD9834 driver")
Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
v1->v2: Check if clk_freq == 0 directly instead of fout == 0
 as suggested by Dan

 drivers/staging/iio/frequency/ad9834.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index a7a5cdcc6590..47e7d7e6d920 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -114,7 +114,7 @@ static int ad9834_write_frequency(struct ad9834_state *st,
 
 	clk_freq = clk_get_rate(st->mclk);
 
-	if (fout > (clk_freq / 2))
+	if (!clk_freq || fout > (clk_freq / 2))
 		return -EINVAL;
 
 	regval = ad9834_calc_freqreg(clk_freq, fout);
-- 
2.30.2


