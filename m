Return-Path: <linux-iio+bounces-16128-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2205A4822D
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 15:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DCF716FFE1
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 14:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D579B236435;
	Thu, 27 Feb 2025 14:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="gI7Ssqlz"
X-Original-To: linux-iio@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BD514A4E7;
	Thu, 27 Feb 2025 14:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740667262; cv=none; b=XmkTZ6xd6d/Zc+AKaZ//X8DIwQIOoF2AKZLjS3IKDoDV0oifpLo0i7q06JTIN8e87MCxegGvyVOizfCV26cqKPTCu40oXjxNoNGrCJpTd8Cq/mdWI7GQ4mRa4ddwSJybTFC4hvfZwrBx/5Q6jj8MG9bdZzpR26kLMpC5TAtiFEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740667262; c=relaxed/simple;
	bh=1stVJSuKNARUeQl+YthaR6WjZHwGdG/7Y5SuiNFvvUM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QnWszJZxAuw1nNXDxavzQ2SYhoSjFi8zkQV+3OUuKBOOjvGuh+HNWmcY3LJTnLegM1NvMr/OKExi8LYPUnDC6CD/Jd7dEKKUBcnUwVsNylcKhWDVAzP0Cae8bW89d5HDdaAKvxL7CtPQvpn02i/7LmMuML4Tnvi185LoZnnY0zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=gI7Ssqlz; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id A4C2AA0622;
	Thu, 27 Feb 2025 15:40:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=7+U/H48sVhDKT4EC1mYrNr5/JRrYqDkzYSFlQnG2vr8=; b=
	gI7SsqlzWMgZVk7fqNN+kHmCrqYnQ7hn4k77RkEs2V7qldFQ+Gi2IMt9DVyAsSuX
	WcrTk/nQ/pecNCkQjTWyRbG8LPz3nL2Y2R8t3831tJ6JYKqVMh2vc1sOdpNVG8jn
	pUZIGbBjxltXbfg+qNZw5PVUqLpkDhdaJq/DCXH/IRoA5lakR5ENUi70eS7G0XGL
	ADyDBf8tnB/0+SIJrlA7i2o6RuZ20nwU0anEOYmcIZjqtK6x/uuxF7EeQObNKpRL
	75CIizcobZAr6JObcz+Mn4yAB7hi/F35wykYh3DJbjQ0wY0hjR/Q0mgg1hzMpTQc
	UyoVT/fLSRdTxMBqMamAQ02kOueGmtC1Xzw0zQruZvqJkvHbWF73/5blSY32/Ram
	Dbktb/psWk0XdZrUR2Q21pSGlnh1Nqn8F7pcp7yDKizmQ71FHKMx3ABZr3qlEOll
	ZEnsmo5huqkTTOSqsjSkcGCdZ4TJ9+3WJfK4UgINDiG8eUzj5rWgR0uchtyYciNg
	MCJygyYLG+D0CHK2kMghIY8OqU73eNBvK673++NnUHEBwMvwRN/f+YkI8Ar2iovl
	PHAdmEKSA8UyRibZiM2crAQKLivRZTVp8Oc6hxl0Pam3hRef87H25+Q0IcQ0QK15
	Qr2e4TCAT7AuZiBw+o90ewmxA7w0i+2pmDv1+oU5Fe8=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, "Kamel
 Bouhara" <kamel.bouhara@bootlin.com>, William Breathitt Gray
	<wbg@kernel.org>, <Dharma.B@microchip.com>
Subject: [PATCH v6 0/3] microchip-tcb-capture: Add Capture, Compare, Overflow etc. events
Date: Thu, 27 Feb 2025 15:40:17 +0100
Message-ID: <20250227144023.64530-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1740667258;VERSION=7985;MC=1480940311;ID=1459460;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
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
    RA/RB

 MAINTAINERS                                   |   1 +
 drivers/counter/microchip-tcb-capture.c       | 131 ++++++++++++++++++
 .../linux/counter/microchip-tcb-capture.h     |  49 +++++++
 3 files changed, 181 insertions(+)
 create mode 100644 include/uapi/linux/counter/microchip-tcb-capture.h

-- 
2.48.1



