Return-Path: <linux-iio+bounces-19723-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4446DABCE20
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 06:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB33D188725A
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 04:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D661A25A2CF;
	Tue, 20 May 2025 04:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ayHF+RTW"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE0025A648;
	Tue, 20 May 2025 04:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747714034; cv=none; b=Oq/eRseU5QadqOgfM/v4tb6LDd80TfVNcrm9oaRaPPHzzfwAdyr8NKCXsekT5/g+6KrckxnfEfLzGcsvZQUlDS0LbWFwOc9kVUiLYUg3PcRfI1SVNibxBlFvNmnilT8tPMV7/2fEPbkA2vtaRnXqOZUkqVQJwQKczndhlV1Uru0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747714034; c=relaxed/simple;
	bh=nJ6KedU+uwmf+BdiivShjd5wAvlcvkmQJNTkCjp/w7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=C36F1VjhQtZ//11CmePNich0WbMtkK4f19psbsI7b0omk9Bpyu1YiDHJ0XyeFCvOJ3KkhhHHEtU1YhuZFHji/LT2Bagsqr6JxyHizkBYXy8o3FYYX21U4/DaPM/rgEQlckFW8HCO/Q2wK4zOqOF8xZmFjYqQwuyHZaF42zfXGXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ayHF+RTW; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1747714033; x=1779250033;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=nJ6KedU+uwmf+BdiivShjd5wAvlcvkmQJNTkCjp/w7U=;
  b=ayHF+RTW1sdd5qkwkoe6OOEApDefepkG2n+jrpfa9Nubc/MQFGqKtwpK
   ktXKWMyS5WyTGSUYTIuqelfQk2lPn42odWwO0jKx4R8i5rq5l2Ffo+j2s
   wQ+obWJEF73chHeIcFahKhIGgvkyB6HAZ3175NyVJ5ZRtT9ZofyTHaODL
   7dCERA92JxDoE+qsDNUmvFK1J7IinvCAUbbNGYGj92IQHkQyreVp3UIiQ
   lztP7KjlOPgiPFxAFQrXWwcGQO/WD/R/41m0WH6qCrsSsy7l1TJf0XZ4o
   i7ONuGUFNcVONkShnInlPl6T2nF+oqnrVGujaAWoOcFAUprSXSx9nIBZv
   w==;
X-CSE-ConnectionGUID: htdO05ITRmGW9JMUEmdDwA==
X-CSE-MsgGUID: SA2rPMYOTAikDw/z7EgqDw==
X-IronPort-AV: E=Sophos;i="6.15,302,1739862000"; 
   d="scan'208";a="42370416"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 May 2025 21:07:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 19 May 2025 21:06:51 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Mon, 19 May 2025 21:06:49 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Tue, 20 May 2025 09:36:42 +0530
Subject: [PATCH v2] counter: microchip-tcb-capture: Add watch validation
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250520-counter-tcb-v2-1-a0617d2d220a@microchip.com>
X-B4-Tracking: v=1; b=H4sIANH/K2gC/23Myw6DIBCF4Vcxsy4NQ8ReVr5H40JwLLNQDFDSx
 vDupa67/E9yvh0iBaYI92aHQJkj+7WGOjVg3bg+SfBUG5RUWmrUwvrXmiiIZI0w3Uh4a7VCaaA
 +tkAzvw/tMdR2HJMPnwPP+Fv/OxkFCtLtRXZI01XO/cI2eOt4O1u/wFBK+QJc/o4mqgAAAA==
To: Kamel Bouhara <kamel.bouhara@bootlin.com>, William Breathitt Gray
	<wbg@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dharma Balasubiramani
	<dharma.b@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747714007; l=3393;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=nJ6KedU+uwmf+BdiivShjd5wAvlcvkmQJNTkCjp/w7U=;
 b=sdEXf/+Re7V9JjOqNQgcwsFvPcFR9hosuiKoqjZJkUxIZEMam5GP0cCbMCYEFUnZvzeNfuyuL
 uAG79cGYJKwB1dQyP7faOWZroB84akV8zRoJBlN+Ivlnny6sLWwiltU
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

Any other request is rejected with `-EINVAL`, preventing undefined
behaviour in userspace.

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
Changes in v2:
- Include COUNTER_MCHP_EVCHN_CV as well for the sake of completeness.
- Adjust the code to ensure channel limitations.
- Drop sorting in this patch, will be taken care seperately.
- Link to v1: https://lore.kernel.org/r/20250515-counter-tcb-v1-1-e547061ed80f@microchip.com
---
 drivers/counter/microchip-tcb-capture.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index 1de3c50b9804..fe817f4f1edc 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -337,6 +337,27 @@ static struct counter_comp mchp_tc_count_ext[] = {
 	COUNTER_COMP_COMPARE(mchp_tc_count_compare_read, mchp_tc_count_compare_write),
 };
 
+static int mchp_tc_watch_validate(struct counter_device *counter,
+				  const struct counter_watch *watch)
+{
+	if (watch->channel == COUNTER_MCHP_EVCHN_CV || watch->channel == COUNTER_MCHP_EVCHN_RA) {
+		switch (watch->event) {
+		case COUNTER_EVENT_CHANGE_OF_STATE:
+		case COUNTER_EVENT_OVERFLOW:
+		case COUNTER_EVENT_CAPTURE:
+			return 0;
+		default:
+			return -EINVAL;
+		}
+	} else if (watch->channel == COUNTER_MCHP_EVCHN_RB) {
+		return (watch->event == COUNTER_EVENT_CAPTURE) ? 0 : -EINVAL;
+	} else if (watch->channel == COUNTER_MCHP_EVCHN_RC) {
+		return (watch->event == COUNTER_EVENT_THRESHOLD) ? 0 : -EINVAL;
+	} else {
+		return -EINVAL;
+	}
+}
+
 static struct counter_count mchp_tc_counts[] = {
 	{
 		.id = 0,
@@ -356,7 +377,8 @@ static const struct counter_ops mchp_tc_ops = {
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


