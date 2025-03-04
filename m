Return-Path: <linux-iio+bounces-16366-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F04E9A4E5D9
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 17:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F33B28A66B9
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 16:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D397281355;
	Tue,  4 Mar 2025 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="h9cleO3a"
X-Original-To: linux-iio@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC8D25D551;
	Tue,  4 Mar 2025 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103547; cv=none; b=mZC+AiDXF9OFUHRVR2vqbunFoxjYmO6u8igwIxK9jfRPVjyA/3/29Sfk4Z3tYqDJSBye5LrgyWX5zEmJ8heIpCECALhH5qfUUEpEbK0Xr3Lf8atOb1mg8pN6Wx8BNBzVZTHmv0PL7oVoBBX4iEBMkcpG/IGoj9ftlliJMBJ9NxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103547; c=relaxed/simple;
	bh=XbV8vyaY10cWIL3JE8+j/ixlPNT/ot6WlfTx734vGlU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QCUT68PY5jdNJPtF6TJfkFjwhhhfFHfvA+zVOv2KkESQCWlQONTK2qWs0N4YK0OPtDNvuIRsK7znuCsa8njc38Rg65Bxf229xIRB+RWKB85Y9B7X8WPN08hjPFfoqMpm5lhEbODc/oHhX2BCqE47D/LDI/hwGZ3XZ8D78AS5nIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=h9cleO3a; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 10956A0391;
	Tue,  4 Mar 2025 16:52:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=DonSCwrfl91cmZ8V/r9qwCe7RUFgipzpqhb+J45mutU=; b=
	h9cleO3a3l+c3MvbQ+71f5S+ixtZrMLrY8Qx4HJLf0gcYmx1R4DgjqcluKWaD+B5
	0wPiDjOnOPlb8yEAZmazwSYYeBaOFC5tLL3ANZaoi2/G9A0Fbyk08Nt6W9+KJFQg
	1W+y5Xq4+Wohcgu3TdowC7iZ7AciJwxhcIo3KZvCBaw4R77hQkV9ikv+pojobAP3
	XJS2o1o+reEurMfAgPPpPfBYKK74MIaRBFMYt/Sgu9cqfUeHTWeMs9GlxhcJ4OqT
	iaAy961c87gzs/iJHO9Xt0QQBSEfsBGCGjUXLpIxqoC+IcnAu7kTodSQ6bUb0gmR
	vbqJelcz3moQ+KCIfImYME1kqIls4oLJ/kKKSfP8F6h/2Fr3eCHYkLYDKzIcVQFT
	vJP7lIgmN7QiZ8ZW91ye4nKUGbFqH85Fz65j9ifZdccSd6UQfjoiFw1bwE9BfWb2
	qb5e+XWswXi09TdRYa6SkpouZ5ybrd5Fctjkrjp+OHuNsSs3QPgYPPg8X7YXvGRd
	odZHr1xyob8EIXTOlYjxG/P/5vwqYCVIc8i5XJShGUxFSrB+4g8+qcxy+Vcbu9cj
	Csw2BJsYfu5S9RY1tt6ok+zDsoR5gxfhEFVmGdeNg1y/L/Jo0/sv4i4r6iuwJDyl
	d91QNZ32JoobtMvJat7IqyKdUhHjNpZ8snxmMkwvVBc=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, "Kamel
 Bouhara" <kamel.bouhara@bootlin.com>, William Breathitt Gray
	<wbg@kernel.org>, <Dharma.B@microchip.com>
Subject: [PATCH v7 0/2] microchip-tcb-capture: Add Capture, Compare, Overflow etc. events
Date: Tue, 4 Mar 2025 16:51:50 +0100
Message-ID: <20250304155156.374150-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1741103540;VERSION=7985;MC=3473926107;ID=1544446;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852637264

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

Bence Csókás (2):
  counter: microchip-tcb-capture: Add IRQ handling
  counter: microchip-tcb-capture: Add capture extensions for registers
    RA/RB

 MAINTAINERS                                   |   1 +
 drivers/counter/microchip-tcb-capture.c       | 133 ++++++++++++++++++
 .../linux/counter/microchip-tcb-capture.h     |  40 ++++++
 3 files changed, 174 insertions(+)
 create mode 100644 include/uapi/linux/counter/microchip-tcb-capture.h

-- 
2.48.1



