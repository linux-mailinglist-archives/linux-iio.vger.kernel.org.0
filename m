Return-Path: <linux-iio+bounces-15032-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 067C2A288B4
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 12:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 683951629B7
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 11:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9F822AE71;
	Wed,  5 Feb 2025 10:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="WnoYpEIL"
X-Original-To: linux-iio@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FD421A43C;
	Wed,  5 Feb 2025 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738752702; cv=none; b=F3e1MYQYpUUFYuzQqQPOpimu90ORi5YwQptWZB3/aeHISNJK7dDL+DFLXaR+JRAqO3HWyeBS0+Wkoe/9Vp/YLDaJTgvzcIJcdic/ZBk20Wv2pchOXlPeWnLRZ6qg2S+M0WN606mWcfEufvkOw6d4CqirZWn8xsFup4Kw3vZUwHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738752702; c=relaxed/simple;
	bh=xUsgjTQEb7sHHjlzti7ETNNktSz2XdnC+Kdkoq6qrFE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YjhJxJU5+lWKkqXLjVN4BPqyjQo/VKUNl8+w6SIjTBpTSvMGNJ+uTBVe2PgoUGzv9boDE+Q6XJLnK6311mNY7dopRK9gly8lnPcVymkTv9jdlWo3D47qdhjzQi6sk7KvsD4Z1wAs0R1aLRF78DxXIaNM34od2z7HLken+3RjPPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=WnoYpEIL; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id B646BA0031;
	Wed,  5 Feb 2025 11:51:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=A8a8Vknd+Ac1B5NbwMCS9Rp6ox5pHlVEJ+QCEfo6ioE=; b=
	WnoYpEILKm9SvCt3yFSNGC/pL8zToIpwkbYHyPlxp+VVP2rAtXJYcxeEbw4g1E4R
	X14ODohHKGFOHhtxnIaAU6klhR1GAc9GZK4rOXVZFEcsBjcc6QIqIAwggrhwKZCf
	TzahDJATPmmkcZ0HC4vhLitYFpjoq6pwHZJkpvz/QFlOjFfikS5p2oFVnRZ/g72s
	4c7KZXhD232EbMksPdbERtFGUNeevdlhX89lSpPzcnf+u0M6JoZXIQ8JpKD5lxrx
	Tz6OBDNpbotA+Je4hevaZ+Chiy80I+LU9Qcry4CYD5/CTfjytbTVaNGeRKZPhVtK
	huFPGYvVQfS+giv5dcy3vkE48KgdtOnzBPhZ8eUMGf3ZxFPcBpx9Vgyche2h/644
	rhsuDfUgN4LZFMg60ZFipKmy6+2P8AHJz7UJynvvIG7o7EMNiycwH+bXO7hTd1Fq
	GoOWxojUrpCb1dPMeGTJ4oBBIOfhsjAgkUUG1tDDupW2K8I7Zhl60VU8GlTg3kth
	H92Sfa/GXZFSqchZwH8Kfw/789l5TMZmbOpKeeHux3AqFBEJh9GZn/hf8dn5S8Dg
	+h9yLrpGiqvLeIOLZ7gOmlVyc/mv7YWrWwyYut2K3Nkmr8+hw627AlA5y0PpYwsQ
	xd6+28uXypSWwG31J7PypaUvdvLSrDGwUn8jvF7VFzg=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, "Kamel
 Bouhara" <kamel.bouhara@bootlin.com>, William Breathitt Gray <wbg@kernel.org>
Subject: [PATCH v3 0/2] microchip-tcb-capture: Add Capture, Compare, Overflow etc. events
Date: Wed, 5 Feb 2025 11:50:43 +0100
Message-ID: <20250205104957.95236-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1738752695;VERSION=7984;MC=1779217303;ID=244308;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852667264

The TCB has three R/W-able "general purpose" hardware registers:
RA, RB and RC. The hardware is capable of:
* sampling Counter Value Register (CV) to RA/RB on a trigger edge
* sending an interrupt of this change
* sending an interrupt on CV change due to trigger
* triggering an interrupt on CV compare to RC
* stop counting after sampling to RB

To enable using these features in user-space, an interrupt handler
was added, generating the necessary counter events. On top, RA/B/C
registers are added as Count Extensions.

Bence Csókás (2):
  counter: microchip-tcb-capture: Add IRQ handling
  counter: microchip-tcb-capture: Add capture extensions for registers
    RA-RC

 drivers/counter/microchip-tcb-capture.c | 125 ++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

-- 
2.48.1



