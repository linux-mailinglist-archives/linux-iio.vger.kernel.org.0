Return-Path: <linux-iio+bounces-19741-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B26E7ABDEC6
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 17:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8FE1BA71A8
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 15:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31CA25D20B;
	Tue, 20 May 2025 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PN/xGAA4"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12AC2505AA;
	Tue, 20 May 2025 15:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747754553; cv=none; b=GSsTNfJ/vNkQ2FlSC/xFU50mj5KK5Qxk8L2B+LOOGZzOGEXs01T78tNA5nZ8dyK9o9CwR7YpWbYPjphP+fr4iY43GawjhUzqex/P3YX3z9C2nUytKTExgySX/5TOBjttOuyZ4xmk7/JpUS9XpTgvIp/rCOIw+ajtemdWnZNYr2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747754553; c=relaxed/simple;
	bh=TOckte/RXxhhtZxgfzD8giJmyAbKzFbnveOMKN1CJ7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=fY3kAU3NBa5xHigSz/FxLASIjoeezMxIcwBdtmZz/FUEl9yo2gupS0uGebtpioAGEyrRwjaaQANWb1YF5ehpvv5+KZhMLcA0sIjGDOxBfYRugv69/yqcJjo49OR9CDNaWDh5dEtIyJK6XKe+PeaKRxcDX2xnWpSkjz2WjnEPXCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PN/xGAA4; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1747754552; x=1779290552;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=TOckte/RXxhhtZxgfzD8giJmyAbKzFbnveOMKN1CJ7E=;
  b=PN/xGAA4KKeLsK7pR0JI9c69pIm9J7kvuDSKhpN15i/DdnviJWl/cx4F
   eiGJ6DsTFQkJarmZrT8BNBvQI2dmv8zTJY/DrYVFj2hR0nTbZe2RbW0IU
   SR6Dj7eJPLauHViiMHd3DGTLpUlWogT2AgILMxlmJwzM8G0T/+xBuQs3o
   yFzixkmYbXQAzEbDaI/ZWzAgay3sUS6qqOw4MVugCb+/FTBdAjuPanylu
   h7LzsXEknTpZ6adF7JcbZHPNV2IObUTuY9e5fnAAtjgUP5lyjHpkchDIG
   V1BlxH9wITbAos6IfRTsRfIOoi7cu8aC3Z4bTsr59Z7MlZCHqCn6WWJpG
   g==;
X-CSE-ConnectionGUID: Mv3k4QTqSfuckgJwL9Kybw==
X-CSE-MsgGUID: R5ra95CaR2KdyZQCHjO6ng==
X-IronPort-AV: E=Sophos;i="6.15,302,1739862000"; 
   d="scan'208";a="41853373"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 May 2025 08:22:26 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 20 May 2025 08:21:52 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Tue, 20 May 2025 08:21:48 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Tue, 20 May 2025 20:51:46 +0530
Subject: [PATCH v3] counter: microchip-tcb-capture: Add watch validation
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250520-counter-tcb-v3-1-4631e2aff7ed@microchip.com>
X-B4-Tracking: v=1; b=H4sIAAmeLGgC/23MQQ6CMBCF4auQrq3pjBTUlfcwLko7yCygpMVGQ
 7i7hZUal+8l3z+LSIEpinMxi0CJI/shj8OuELYzw50ku7wFKtRKg5bWP4aJgpxsI5vKEJxKjaA
 akcUYqOXnVrve8u44Tj68tniC9f3fSSBBki5rVQG5o2ovPdvgbcfj3vperK2EHx7Vt8fsTca1Q
 4eozK9fluUN+ewv8eoAAAA=
To: Kamel Bouhara <kamel.bouhara@bootlin.com>, William Breathitt Gray
	<wbg@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dharma Balasubiramani
	<dharma.b@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747754508; l=3596;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=TOckte/RXxhhtZxgfzD8giJmyAbKzFbnveOMKN1CJ7E=;
 b=wn+a9fjoolTdBjvBYyQB/3JM0obFki/MI9r7lVs8n3lHFMJpxKAAUmnoQ89tYB26zcm++sFos
 M6I/YoN6YhtA7bxDVWGwabKlXvljmGicckGjlWxC9NJ18nbTWqufY3z
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

The Timer Counter Block (TCB) exposes several kinds of events to the
Counter framework, but not every event is meaningful on every hardware
channel. Add a `watch_validate()` callback so userspace may register only
the combinations actually supported:

* Channel 0 (COUNTER_MCHP_EVCHN_CV, COUNTER_MCHP_EVCHN_RA)
   - COUNTER_EVENT_CAPTURE
   - COUNTER_EVENT_CHANGE_OF_STATE
   - COUNTER_EVENT_OVERFLOW

* Channel 1 (COUNTER_MCHP_EVCHN_RB)
   - COUNTER_EVENT_CAPTURE

* Channel 2 (COUNTER_MCHP_EVCHN_RC)
   - COUNTER_EVENT_THRESHOLD

Any other request is rejected with `-EINVAL`.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
Tested the code on target (sam9x60_curiosity) using the following commands

valid ones:
./counter_watch_events -d -wevt_change_of_state,chan=0
./counter_watch_events -d -wevt_ovf,chan=0
./counter_watch_events -d -wevt_capture,chan=0
./counter_watch_events -d -wevt_capture,chan=1
./counter_watch_events -d -wevt_threshold,chan=2

invalid ones:
./counter_watch_events -d -wevt_threshold,chan=0
./counter_watch_events -d -wevt_threshold,chan=1
Error adding watches[0]: Invalid argument
---
Changes in v3:
- Update commit description to not mention undefined behaviour as that is
  not the case.
- Use the early returns to avoid the else statements and code consistent with
  linux style.
- Link to v2: https://lore.kernel.org/r/20250520-counter-tcb-v2-1-a0617d2d220a@microchip.com

Changes in v2:
- Include COUNTER_MCHP_EVCHN_CV as well for the sake of completeness.
- Adjust the code to ensure channel limitations.
- Drop sorting in this patch, will be taken care seperately.
- Link to v1: https://lore.kernel.org/r/20250515-counter-tcb-v1-1-e547061ed80f@microchip.com
---
 drivers/counter/microchip-tcb-capture.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index 1de3c50b9804..1a299d1f350b 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -337,6 +337,28 @@ static struct counter_comp mchp_tc_count_ext[] = {
 	COUNTER_COMP_COMPARE(mchp_tc_count_compare_read, mchp_tc_count_compare_write),
 };
 
+static int mchp_tc_watch_validate(struct counter_device *counter,
+				  const struct counter_watch *watch)
+{
+	if (watch->channel == COUNTER_MCHP_EVCHN_CV || watch->channel == COUNTER_MCHP_EVCHN_RA)
+		switch (watch->event) {
+		case COUNTER_EVENT_CHANGE_OF_STATE:
+		case COUNTER_EVENT_OVERFLOW:
+		case COUNTER_EVENT_CAPTURE:
+			return 0;
+		default:
+			return -EINVAL;
+		}
+
+	if (watch->channel == COUNTER_MCHP_EVCHN_RB && watch->event == COUNTER_EVENT_CAPTURE)
+		return 0;
+
+	if (watch->channel == COUNTER_MCHP_EVCHN_RC && watch->event == COUNTER_EVENT_THRESHOLD)
+		return 0;
+
+	return -EINVAL;
+}
+
 static struct counter_count mchp_tc_counts[] = {
 	{
 		.id = 0,
@@ -356,7 +378,8 @@ static const struct counter_ops mchp_tc_ops = {
 	.function_read  = mchp_tc_count_function_read,
 	.function_write = mchp_tc_count_function_write,
 	.action_read    = mchp_tc_count_action_read,
-	.action_write   = mchp_tc_count_action_write
+	.action_write   = mchp_tc_count_action_write,
+	.watch_validate = mchp_tc_watch_validate,
 };
 
 static const struct atmel_tcb_config tcb_rm9200_config = {

---
base-commit: 8566fc3b96539e3235909d6bdda198e1282beaed
change-id: 20250515-counter-tcb-b6ae1945210b

Best regards,
-- 
Dharma Balasubiramani <dharma.b@microchip.com>


