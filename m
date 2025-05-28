Return-Path: <linux-iio+bounces-19980-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A3CAC61B6
	for <lists+linux-iio@lfdr.de>; Wed, 28 May 2025 08:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1D73AB968
	for <lists+linux-iio@lfdr.de>; Wed, 28 May 2025 06:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BF0211494;
	Wed, 28 May 2025 06:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Coy2FnQP"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9EF20C478;
	Wed, 28 May 2025 06:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748412834; cv=none; b=FIe4Alx4LfS1c0dTNl91wTTl7n0Bv3vDYY48WF7B/XJXZByD1SuPkYAk6397zLfxIcQTIQyMpS6U+b20f3L3PNu36+ksiFHwXQ4FqICyl1xUMZcYOMHhkgKBw97jZ8nW0TTNwR6TDps6nxlbVgAIMOb8QIYKoV08/o69XiSo0RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748412834; c=relaxed/simple;
	bh=dGXYE/DiAwj+uOxmvi69MBxG9FwMrkP4VaIHvYdkff4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=QVdSQcPTapIx57QinCjC4SwkkalFrpvenvmAIMsvZCwTZuamFigd2MqKTbZ7ftkoyPQ4ZhA8xzNOrH++bBnO8h9Mz1oVJTadk8pJ9vSv5AvSoPbyUy23B/IX4S1AH0gQF5lLvCX/1Da+7TxOdjdUwwBZnzlypWxzmFmffjJPpbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Coy2FnQP; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1748412833; x=1779948833;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=dGXYE/DiAwj+uOxmvi69MBxG9FwMrkP4VaIHvYdkff4=;
  b=Coy2FnQPAW5lt55qlo1I9ftBjStc/or3o2ny0nwZXizl5raxNK4QkGga
   jx8MYQhZMaxAz9NkAmJllGYFdKQS/qVcJtDQdveDfBTnKJNOyCzNthw3G
   2fqpFh2eEzv4t6A7clj3CmivX3RIZJDeFvtbzPnEHr/6ZqaJvKJ1TPUVO
   GXtIs3WsWaMQwSNd3xVPrqSb9DF+sgClzuWHRog+1AXPCwx6eOaCcKEnG
   ov0dwoUs0vrLdtLy93uapFFC7e+ClQ+wAMaA6OanWPu4Rk7DMAeK8YaKF
   J8FwL6Zm45Ichl2e8JoDfTuFM+G5ZjFRMHjzy6dsArAhOmAWwBq7Ymyku
   g==;
X-CSE-ConnectionGUID: Na4ii3iOTbObYzT6z7QrlA==
X-CSE-MsgGUID: ztvcs+Y1SXeDgHiUPfKLeQ==
X-IronPort-AV: E=Sophos;i="6.15,320,1739862000"; 
   d="scan'208";a="42149723"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 May 2025 23:13:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 27 May 2025 23:13:16 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Tue, 27 May 2025 23:13:12 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Subject: [PATCH 0/2] TCB: Add DMA support to read the capture register AB
Date: Wed, 28 May 2025 11:43:03 +0530
Message-ID: <20250528-mchp-tcb-dma-v1-0-083a41fb7b51@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG+pNmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDUyML3dzkjALdkuQk3ZTcRF3TRCNLQxOLtFSzVDMloJaCotS0zAqwcdG
 xtbUAjG8sgF4AAAA=
To: Kamel Bouhara <kamel.bouhara@bootlin.com>, William Breathitt Gray
	<wbg@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dharma Balasubiramani
	<dharma.b@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748412791; l=1279;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=dGXYE/DiAwj+uOxmvi69MBxG9FwMrkP4VaIHvYdkff4=;
 b=zV5Oyny2gAL5OxDkogoxJfETHlTsLTFHxNGEk/be2hY9iGYHrsZLVJhkFH6yjjXD/KQsIIC3X
 zGHJ4QN+DkWCp6r0lAU0fW7PsdUlTwx1qU5X/XQ7oCkPQcINu8gSh0X
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

This patch series adds support to enable the DMA support for TCB.

When DMA is used, the Register AB (TC_RAB) address must be configured as
source address of the transfer. TC_RAB provides the next unread value from
TC_RA and TC_RB. It may be read by the DMA after a request has been
triggered upon loading TC_RA or TC_RB.

-----------------------------------
This is tested on sam9x60 curiosity

root@sam9x60-curiosity-sd:~# cat /sys/bus/counter/devices/counter0/count0/capture0
258428554
root@sam9x60-curiosity-sd:~# devmem2 0xf800800c 
/dev/mem opened.
Memory mapped at address 0xb6f78000.
Read at address  0xF800800C (0xb6f7800c): 0x0F674E8A

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
Dharma Balasubiramani (2):
      counter: microchip-tcb-capture: Retrieve and map parent base address
      counter: microchip-tcb-capture: Add DMA support for TC_RAB register reads

 drivers/counter/microchip-tcb-capture.c | 128 +++++++++++++++++++++++++++++++-
 include/soc/at91/atmel_tcb.h            |   1 +
 2 files changed, 126 insertions(+), 3 deletions(-)
---
base-commit: fefff2755f2aa4125dce2a1edfe7e545c7c621f2
change-id: 20250528-mchp-tcb-dma-5a29148fe6e6

Best regards,
-- 
Dharma Balasubiramani <dharma.b@microchip.com>


