Return-Path: <linux-iio+bounces-16122-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F06F6A481D4
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 15:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F8B21899D63
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 14:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16098234994;
	Thu, 27 Feb 2025 14:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="H8T8ZpXT"
X-Original-To: linux-iio@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70E72309A8;
	Thu, 27 Feb 2025 14:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740666479; cv=none; b=HEQFVYd8p2SN3diXOywE8idK4Sh2wlEk1j3frgn3AonHAtEj3MVBA+wrFVe7ZAcDzPbkSospjRPLaV5+Yrozm+k+dzS1s6Nege7yxOivsWxUHS2s15buCI7UMMMcosHLaWwEcWmW2OJl2anrR6g8I7L1hpNoZ5XtrrvGcoT9qyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740666479; c=relaxed/simple;
	bh=d2kniXghzkVepyvN0Jxk7Th/uso/TF6hJ3QrHIX+78Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CRdxXER6rRk8qKUvE2w/o6vCrL0L4IuS5PgMLUKEXL6MvkHQHVm3v2amHvwj+CaHHRlNA6U9uMhlIWDcB0jcB3KjRZiDxf/ClTNFgK+Q5Tu0fz99AoGd1ou/7WF7gfzHUaGcmLbpPaU48CNHOqYFW10dzudr+9kr3hkfTmGaIbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=H8T8ZpXT; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 9755DA0C24;
	Thu, 27 Feb 2025 15:27:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=WF9LzLHCkRSu0ysovFG2P0lkkTg7dv5c/Mx/XIoFkfI=; b=
	H8T8ZpXTQFc2B2M7Ed0MP3NeBv3NqCye2OrVN1y+7RKuZaNJQXvItUo5/QlVapii
	GweFKa4NhJ9ugM/Je3UVC10CkD0U3NNgAg8zJp4kvQotxExJm3ZsRA8RKOTRG7cF
	PE3dgaCOI7PWAwETWC1ERBowo+fPK4KnPcr7OQDsA08hyEaH6/j/uifCspD4KaHl
	XX0NW2P+XJH/btV6wnHbcfKyuYKSQUe1B7nWxIuY66Pc0Z5NZ3bcpUGS/50KfIRB
	YC1UG8QAh+SRV1KZETDZyQYywUmkZauYVk0+QRTBNbDo4c6ltNt5sf4pZHSLzkNp
	zxDvEgK7MnVlOfBPe8psG/367NS62hNbNY/1hsPr0r0KRL/0qKJHyeAWvfuXcBYU
	uVtIf/Z2MNChv1JRly7Ps7WUtvx5N4xchZjBKPIAxmtRUhqyOicFX57WycqRhg/y
	9snzjKnZAY2aMNs3DHcMcI4Lc9OjAdMKIB1t2ZfGYrPp5AAf3GsCSWUeq1E/Io0R
	NEBumqGycbcS/Pp5nn1vIATnYlX1N67gz5PGBsy+dLB91ayrPHFTk6lkZ0XnDqYV
	AHrMyY907PB7sxcOLGXVUmheuT5KU60Pko+NXwGaw2DgoZrhqWYaXBZZDTrU3/mu
	+Jm0sP7YDHBXfLNRRfWsDMVsOZVRWINVv0dlaGf4Vn0=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, "Kamel
 Bouhara" <kamel.bouhara@bootlin.com>, William Breathitt Gray
	<wbg@kernel.org>, <Dharma.B@microchip.com>
Subject: [PATCH v5 0/3] microchip-tcb-capture: Add Capture, Compare, Overflow etc. events
Date: Thu, 27 Feb 2025 15:27:45 +0100
Message-ID: <20250227142751.61496-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1740666474;VERSION=7985;MC=20500670;ID=1457592;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852637760

The TCB has three R/W-able "general purpose" hardware registers:
RA, RB and RC. The hardware is capable of:
* sampling Counter Value Register (CV) to RA/RB on a trigger edge
* sending an interrupt of this change
* sending an interrupt on CV change due to trigger
* triggering an interrupt on CV compare to RC
* stop counting after sampling to RB

To enable using these features in user-space, an interrupt handler
was added, generating the necessary counter events. On top, RA/RB
registers are added as Count Extensions. To aid interoperation, a
uapi header was also added, containing the various numeral IDs of
the Extensions, Event channels etc.

Bence Csókás (3):
  include: uapi: counter: Add microchip-tcb-capture.h
  counter: microchip-tcb-capture: Add IRQ handling
  counter: microchip-tcb-capture: Add capture extensions for registers
    RA-RC

 MAINTAINERS                                   |   1 +
 drivers/counter/microchip-tcb-capture.c       | 137 ++++++++++++++++++
 .../linux/counter/microchip-tcb-capture.h     |  49 +++++++
 3 files changed, 187 insertions(+)
 create mode 100644 include/uapi/linux/counter/microchip-tcb-capture.h

-- 
2.48.1



