Return-Path: <linux-iio+bounces-15347-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB038A30F8C
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 16:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278FA1889378
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 15:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C27253F3A;
	Tue, 11 Feb 2025 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="lLoUEC41"
X-Original-To: linux-iio@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CF1253B46;
	Tue, 11 Feb 2025 15:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739287285; cv=none; b=ZO/eFCot1ckDp3lpDYizMOn3bGn7prf9wDmnIqgDsdDsLlEfHu40Y4gpIfUgmgPEU3Q4kAZBe+3w7eYKLJv8epB82c2bGM/Sd2bmoHwp7CZ92ccYr7ec1EX4wuJJf71GQmo7XkbJPnrxpTRKi/7U+lKZVnGmVglIo7Hfbgtarsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739287285; c=relaxed/simple;
	bh=0G91CjwOhsX1pkxJE7OgIx3A7K+jrtHXyQn0eWnMods=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YAUrbRQ+0AshFQr75irrMJsyOTHomwTV7EjO+cwAfdcRbhbbjJkIRXXvxlimEZqrsARSbc6oVWZMpwkVVmTTwaK1agsM9UGeUcLDTGIOtsX9EXKxJuPzh3LsAqpLFLF8ZU+B/MYOeTQCeQcOURafkjt3WB/dmYwO7/zOVcDSYoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=lLoUEC41; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 8C0B4A0ABF;
	Tue, 11 Feb 2025 16:21:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=AtiuJJ7RhchJVxtKjzxiYrGG9SfY4cQIXR419nrTqIg=; b=
	lLoUEC41/Q1Yakwf95qZk7+T6brQbhJBi/iCa54Z/zGCof9+RiYz5gGYPGIPJmTP
	zI8VXLznkGrJbn6Szpo/RjLFlq/hzvjOxa1+roc5SY1nLhgyMZGgGfr6HML5Y3Ob
	7oOZQvvceXfbXC55MquIdk1zGzq04R8ElrVmxYLnaJXXx5ligp1u9TYnA53tZDq5
	PY3ffl4f26z3KV7HTVTVVB+2xXM417I8VY/Ortv5adZXEp/YW7zNY22NwoVD8+ik
	lI4I1JwLeRDqpZPrvbzaqcz/EtCIkFHzphCyq4aN4n3SIeyguh+qFYOvexGHIfei
	zQFFTQil+B+z+GLLFcpv0hyxek6u9C1ORl2AV7bIaQRbI+HuWE+KLVz8zOriZ84l
	M6pTrnlqwJJkfZ0bhPsMULHQ8YHGb+xaLVue3r5pu+TcXDX2QDnpYYLb0oE4rNTQ
	Laxp6bfRojJkv/E1natczdv+6lnfR7lFol2Ydr9KOPWn2y7Oy57JV/xAeMMl99xt
	UUIhSG+h/EpEu76uqgixOpEWEsMrP+s/Z6wEOKaXLaN08Si3peqbJQHdtPWJJJ25
	jhy99FpKtvlf1tp45tQ9MJg/Hz9cKjXOWth3cEJQlQBgc2VbjzELknivhfRD4sy6
	uX659pCYruZJRVueJzyqZ0PdRxq8BLXHTg9WiPSRtQo=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, "Kamel
 Bouhara" <kamel.bouhara@bootlin.com>, William Breathitt Gray
	<wbg@kernel.org>, <Dharma.B@microchip.com>
Subject: [PATCH v4 0/2] microchip-tcb-capture: Add Capture, Compare, Overflow etc. events
Date: Tue, 11 Feb 2025 16:19:11 +0100
Message-ID: <20250211151914.313585-3-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1739287272;VERSION=7985;MC=2405386640;ID=762815;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94852617160

The TCB has three R/W-able "general purpose" hardware registers:
RA, RB and RC. The hardware is capable of:
* sampling Counter Value Register (CV) to RA/RB on a trigger edge
* sending an interrupt of this change
* sending an interrupt on CV change due to trigger
* triggering an interrupt on CV compare to RC
* stop counting after sampling to RB

To enable using these features in user-space, an interrupt handler
was added, generating the necessary counter events. On top, RA/B/C
registers are added as Count Extensions. To aid interoperation, a
uapi header was also added, containing the various numeral IDs of
the Extensions, Event channels etc.

Bence Csókás (2):
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



