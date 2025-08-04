Return-Path: <linux-iio+bounces-22270-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B921BB19F4F
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 12:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78BDC3B9501
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 10:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE12257431;
	Mon,  4 Aug 2025 10:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bysfvyQZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD6D254AF0;
	Mon,  4 Aug 2025 10:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754301798; cv=none; b=FVItOIC79D+2hPZ87qWcuENFE0Dc1ARgP2DEKU4Kst4l/h3j3gNzPiJn1u0rvBuoCf0113RuCvm8b19H4NL07MZNvS4bXHSdzDHnncj1G3MIBSMrCeDj177rzAE90ZalIcoda4T1Cm1I9UC+g7gXV+UAhH6UdvG7/u6iToSj0G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754301798; c=relaxed/simple;
	bh=rExnJEsUclWRnuXGTLi8ZjxHecMNknzyT1tPuf5PI9I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=it+GEB6fH/Qu4G/JjJNXl3UYOBsEjV1o/4p5fm5oK64HV/9dwnWRVDg5uUN4oI0vn0sAsUe8Ek8DC9wlwj3w70qhDJOS/PIPSEWfat32VMyXlC5B0IjDxklyQURdBBJ57VENsyQSJ7bTVerUuwauYDimE8dXVDI9KlW91nogqgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bysfvyQZ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1754301797; x=1785837797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rExnJEsUclWRnuXGTLi8ZjxHecMNknzyT1tPuf5PI9I=;
  b=bysfvyQZrs2FL0/0xqgMBLwM4hZeFEioyjAPo2PqRlej+8V8httAQtpk
   O40t3Dat8mhSxGQhNM4jvndwf/FZwn7mIiTdttPmLAQs0zxfofkcGiOIJ
   Itf7qQBsGrzW106O89a+RZQc7+Q78eTGSGqmZ55HBi34Fy7bHi5rLdoy1
   wq+54rA1cGGS3xhG9WdhNJsCYUC/tJdF1G1jibOa3diWOcApiPZCih8D0
   Wnb1RSR53A551hGiWi9W32K8CSb+njHTNEEXvpRfdkU0KWtTseIvSeMgg
   cSuk2rQCWSe9sjZydQXlT4ahPIwyvG2O9qQ4CMpqQ9De8yKGKZxg9IEQ6
   A==;
X-CSE-ConnectionGUID: QrHuXWrSRt6GNRSNglLzJg==
X-CSE-MsgGUID: BPr72ON8RL2cJ2k6co4c9Q==
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="44245504"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Aug 2025 03:03:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 4 Aug 2025 03:03:06 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 4 Aug 2025 03:03:01 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <eugen.hristev@linaro.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH 06/15] dt-bindings: nvmem: microchip-otpc: remove stride details
Date: Mon, 4 Aug 2025 15:32:10 +0530
Message-ID: <20250804100219.63325-7-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804100219.63325-1-varshini.rajendran@microchip.com>
References: <20250804100219.63325-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Removed stride details from the bindings header as they are not relevant
anymore since the access method of OTP packets is changed to TAG
approach. Update the example binding according to the new changes.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 include/dt-bindings/nvmem/microchip,sama7g5-otpc.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/dt-bindings/nvmem/microchip,sama7g5-otpc.h b/include/dt-bindings/nvmem/microchip,sama7g5-otpc.h
index f570b23165a2..682b040675fd 100644
--- a/include/dt-bindings/nvmem/microchip,sama7g5-otpc.h
+++ b/include/dt-bindings/nvmem/microchip,sama7g5-otpc.h
@@ -3,10 +3,4 @@
 #ifndef _DT_BINDINGS_NVMEM_MICROCHIP_OTPC_H
 #define _DT_BINDINGS_NVMEM_MICROCHIP_OTPC_H
 
-/*
- * Need to have it as a multiple of 4 as NVMEM memory is registered with
- * stride = 4.
- */
-#define OTP_PKT(id)			((id) * 4)
-
 #endif
-- 
2.34.1


