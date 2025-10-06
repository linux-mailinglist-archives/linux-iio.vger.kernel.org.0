Return-Path: <linux-iio+bounces-24772-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F252BBDCC5
	for <lists+linux-iio@lfdr.de>; Mon, 06 Oct 2025 12:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FED61884D7C
	for <lists+linux-iio@lfdr.de>; Mon,  6 Oct 2025 10:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5704F259C83;
	Mon,  6 Oct 2025 10:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tqHeN/RB"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F9C2135D7;
	Mon,  6 Oct 2025 10:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759747942; cv=none; b=YHdqGtbJoYYJf3byQIx7sXl0IXbV/gVnTRFUV5hFBQCVP7/BFIYP/5mZMS3qFo4baEydZPLVQrcWthDkkKaS4Ejx0QuD2d1NgPZ6w/G5sBlnRPZ3jEhz85hM07XMvvVAbIAK2aXXCzQc9LAI9DtOhpqAzm+B252VraEBwBG+1Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759747942; c=relaxed/simple;
	bh=gm/Cvg544MWI29JKrzAG4mwd8sooFCbAMI/8/oJiB6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Jx6kD1eaJ5hKvuCNv188X0RnaS3XY2LTn20AAAnmaq4Y5QURB8IEm2o9hA4nTa+1gsWF+2PHNSunVQvbbrt/xEf72Xw7ByxxmgcmwrhFHQzlNmGknRABtI0o8pz9fleJOhEZp0VOweR0Ehep9EntnPVADFsgNAtao9Hv5Wt3pIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tqHeN/RB; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1759747940; x=1791283940;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=gm/Cvg544MWI29JKrzAG4mwd8sooFCbAMI/8/oJiB6M=;
  b=tqHeN/RBcxU3z6v7QdTs06OwIAcqyQyZ1xhXmYN1ctCgAo2cIa5I+9US
   k3eqxupUTG/BmCfW+HEDN95SChi4GO+UEI9Gpve9GrSklQvNEOwbp0Wtf
   bYQv5lG77/sETUUSA/kn8Q84698+53uNEtBJGmkg/dBZdD70qQLRkWpfT
   cZsfk9FfwcZF8sLhKD7RXsu1zakVn4VSMp+E2mU4e4bot+0OyCDfB9/zs
   +pfJ7bB/Q5TeecfTb2WS225HZ1bHEXMWEQTkoNS8NTLs/9ht8rjBfKgPv
   wFDBBMM6ZrEH8v0li3AJh8BMmPMQ/NEmsF8GlOdmA36pVx4JbOm8Zxi11
   Q==;
X-CSE-ConnectionGUID: Kr+Q+dDzSjW7mslzFvIb1w==
X-CSE-MsgGUID: nADP52EgTE2cUcdQ/J8xqg==
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="53412948"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Oct 2025 03:52:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 6 Oct 2025 03:51:53 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 6 Oct 2025 03:51:50 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Mon, 6 Oct 2025 16:21:50 +0530
Subject: [PATCH] counter: microchip-tcb-capture: Allow shared IRQ for
 multi-channel TCBs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251006-microchip-tcb-v1-1-09c19181bb4a@microchip.com>
X-B4-Tracking: v=1; b=H4sIAEWf42gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwMz3dzM5KL85IzMAt2S5CTd1JQUi8TUxFRjs2QTJaCegqLUtMwKsHn
 RsbW1AELilytfAAAA
To: Kamel Bouhara <kamel.bouhara@bootlin.com>, William Breathitt Gray
	<wbg@kernel.org>, =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <bence98@sch.bme.hu>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dharma Balasubiramani
	<dharma.b@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759747911; l=1486;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=gm/Cvg544MWI29JKrzAG4mwd8sooFCbAMI/8/oJiB6M=;
 b=bOTY3HZhE7E09lIqJ/OSyYN9TUABG4lzTG4EqLahS4+YGLDcy4zbM0JK+JTdp2Lp0rQEkFtWE
 OfPw2NWn9OnBO/7/RQqhs6jifYZwI4NhbGgK2zd1Drh6xX7gvP3A2SR
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

Mark the interrupt as IRQF_SHARED to permit multiple counter channels to
share the same TCB IRQ line.

Each Timer/Counter Block (TCB) instance shares a single IRQ line among its
three internal channels. When multiple counter channels (e.g., counter@0
and counter@1) within the same TCB are enabled, the second call to
devm_request_irq() fails because the IRQ line is already requested by the
first channel.

Fixes: e5d581396821 ("counter: microchip-tcb-capture: Add IRQ handling")
Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
 drivers/counter/microchip-tcb-capture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index 1a299d1f350b..19d457ae4c3b 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -451,7 +451,7 @@ static void mchp_tc_irq_remove(void *ptr)
 static int mchp_tc_irq_enable(struct counter_device *const counter, int irq)
 {
 	struct mchp_tc_data *const priv = counter_priv(counter);
-	int ret = devm_request_irq(counter->parent, irq, mchp_tc_isr, 0,
+	int ret = devm_request_irq(counter->parent, irq, mchp_tc_isr, IRQF_SHARED,
 				   dev_name(counter->parent), counter);
 
 	if (ret < 0)

---
base-commit: fd94619c43360eb44d28bd3ef326a4f85c600a07
change-id: 20251006-microchip-tcb-edd8aeae36c4

Best regards,
-- 
Dharma Balasubiramani <dharma.b@microchip.com>


