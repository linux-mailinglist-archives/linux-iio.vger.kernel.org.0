Return-Path: <linux-iio+bounces-19522-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA64AB7CC9
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 06:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A09517F49B
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 04:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9E7272E79;
	Thu, 15 May 2025 04:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0EDPiRSh"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD90374C4;
	Thu, 15 May 2025 04:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747285163; cv=none; b=Ebi4Y6smpHzmPdB6U/EHldzbSIqrwIIItqMZI4x1GXZK04Tv2atbhDR71Wmefr+NktQevOp/ZJD1voKqR2yXaQZFQTh4lqZRsqVEGEmgXrnhGW8XX77fiF2FWbPyNZUwB+fUMyDGPZdeE4G8Pxn1rtaWc0BtawHsR2DzH5fTwU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747285163; c=relaxed/simple;
	bh=4VztJ67csbNOom2wQRi838Nreo1zmt+wKbfXF4TmClk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=C5zx0FxhJGi1HWun+SSTmTuzkRkMoRaK5nIgEvkMV+1We5GXjIMMgr1Q0klpzS7pflPgHfEgbdwgS9XcVy2nHNALGkgl2mkWALscrChw/seMCinb+RVcoUxhu38HL/Pox5NN+C0Hva77fi+oKcVZaNIZhDhMrkFFpSNgODUPUaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0EDPiRSh; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1747285161; x=1778821161;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=4VztJ67csbNOom2wQRi838Nreo1zmt+wKbfXF4TmClk=;
  b=0EDPiRShms0Fr536lnQK1M5Bpz/srQVfNqNECuDsaZZTOEvnP19kb0ps
   ei+ElxMPugfhlReTDpQxMAE4DlnNCcA1b9cIA5OPPFy7PKXqLL0HL7Qjg
   67x7iSUhRto+aJABpkjsvPPngfLdOlcLKSXEzvJxRWK0nUsHlusmAF/lv
   DquWUy/u8KAEL3Kc2BELJhWDGMdniBu40ZWwBfhuHDspehXhNyO5aXorK
   Vz+6uGkA0ao0LCNx/sPM688h8TY1qIgoa2EIb790L3VGg+bKxxV2j1EoM
   Z9GUX8wyB423tu1RrYq1Qg/J7ZHeRXUDFKEDuyUb5Lyp9bh1XuvCvUJxc
   w==;
X-CSE-ConnectionGUID: 7SwAsoW3S9q8TSOD2TSkbQ==
X-CSE-MsgGUID: /cROPzdaS3GrzU0lo4VFRA==
X-IronPort-AV: E=Sophos;i="6.15,290,1739862000"; 
   d="scan'208";a="42133405"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 May 2025 21:59:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 14 May 2025 21:58:35 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Wed, 14 May 2025 21:58:33 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Thu, 15 May 2025 10:28:25 +0530
Subject: [PATCH] counter: microchip-tcb-capture: Add watch validation
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250515-counter-tcb-v1-1-e547061ed80f@microchip.com>
X-B4-Tracking: v=1; b=H4sIAHB0JWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDU0NT3eT80ryS1CLdkuQk3SSzxFRDSxNTI0ODJCWgjoKi1LTMCrBp0bG
 1tQCOvc6/XQAAAA==
To: Kamel Bouhara <kamel.bouhara@bootlin.com>, William Breathitt Gray
	<wbg@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dharma Balasubiramani
	<dharma.b@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747285110; l=2402;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=4VztJ67csbNOom2wQRi838Nreo1zmt+wKbfXF4TmClk=;
 b=q187hDCueE1QScVAwflXU6hvqLkWRU76EQZbtHTo2ZyqL/Jz2tvk9VZo07bPwp1m6foSk0EPM
 GrIMjrDG8boByfWV3iwXTyloEioJwZqmBA2HCtGB3WZBboYKjAGn1gx
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

Introduce a watch validation callback to restrict supported event and
channel combinations. This allows userspace to receive notifications only
for valid event types and sources. Specifically, enable the following
supported events on channels RA, RB, and RC:

  - COUNTER_EVENT_CAPTURE
  - COUNTER_EVENT_CHANGE_OF_STATE
  - COUNTER_EVENT_OVERFLOW
  - COUNTER_EVENT_THRESHOLD

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
 drivers/counter/microchip-tcb-capture.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index 1de3c50b9804..179ff5595143 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -337,6 +337,27 @@ static struct counter_comp mchp_tc_count_ext[] = {
 	COUNTER_COMP_COMPARE(mchp_tc_count_compare_read, mchp_tc_count_compare_write),
 };
 
+static int mchp_tc_watch_validate(struct counter_device *counter,
+				  const struct counter_watch *watch)
+{
+	switch (watch->channel) {
+	case COUNTER_MCHP_EVCHN_RA:
+	case COUNTER_MCHP_EVCHN_RB:
+	case COUNTER_MCHP_EVCHN_RC:
+		switch (watch->event) {
+		case COUNTER_EVENT_CAPTURE:
+		case COUNTER_EVENT_CHANGE_OF_STATE:
+		case COUNTER_EVENT_OVERFLOW:
+		case COUNTER_EVENT_THRESHOLD:
+			return 0;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
 static struct counter_count mchp_tc_counts[] = {
 	{
 		.id = 0,
@@ -351,12 +372,13 @@ static struct counter_count mchp_tc_counts[] = {
 };
 
 static const struct counter_ops mchp_tc_ops = {
-	.signal_read    = mchp_tc_count_signal_read,
+	.action_read    = mchp_tc_count_action_read,
+	.action_write   = mchp_tc_count_action_write,
 	.count_read     = mchp_tc_count_read,
 	.function_read  = mchp_tc_count_function_read,
 	.function_write = mchp_tc_count_function_write,
-	.action_read    = mchp_tc_count_action_read,
-	.action_write   = mchp_tc_count_action_write
+	.signal_read    = mchp_tc_count_signal_read,
+	.watch_validate = mchp_tc_watch_validate,
 };
 
 static const struct atmel_tcb_config tcb_rm9200_config = {

---
base-commit: 9f35e33144ae5377d6a8de86dd3bd4d995c6ac65
change-id: 20250515-counter-tcb-b6ae1945210b

Best regards,
-- 
Dharma Balasubiramani <dharma.b@microchip.com>


