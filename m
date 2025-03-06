Return-Path: <linux-iio+bounces-16467-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A85A54C7D
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 14:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E64B188909D
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 13:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A22120E6F6;
	Thu,  6 Mar 2025 13:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="VlfubMQ+"
X-Original-To: linux-iio@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F60220E710;
	Thu,  6 Mar 2025 13:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741268695; cv=none; b=Q3A8dThcdjyzSDG/HT0toQjH1tKvqJ3va5J70WsMelDNr8DoHQeRaEGrTJd+vtU+XYOMkyhY/rR9/1vCHEKLraI/jHV/AGk6VVjPJ9kWkQYEJwZK69dsG8CTWttBi0BydijvJ7fYWo/61izzxCb7EoRK2EVf/h9jnaP09yDOy1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741268695; c=relaxed/simple;
	bh=2vLQvZIclrHC/n1UvIqbeA4KnSm/ZdQsCfKiKVNHHH4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yu7rDrWyG4WSsUzhTnXc7g4QuySEcSanPANXXEUCCgV3aDJy5F5rjFzxgeyopx6OxNn32FZaDcPIvMtBJ3E2QlJIarZwgZcEhoG4Y1QwUK9EpGx9ahjJe62dRw5UMysBT+oblk++FKOYag77+aoFM+2louSL+ZD5/pn+HZBftcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=VlfubMQ+; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 5C4BEA0433;
	Thu,  6 Mar 2025 14:44:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=/UxPbmKXr3I3XApnAtyCIoCLXfkY8WP19iA5l9VOJgc=; b=
	VlfubMQ+0465Ik0rVug7Smjik7/YeRLRztoDu6XBjD0E4Dn4/NqArJ2QorOzFZx9
	hMPZcvP2bLFrXXoQSxkrDpzF29NjKEvhJ9g/gvUn8EY8ZZyqnPh+RU6SQkRp5PWX
	sgqBfTlEvns7Tfsliic4x2Lw4o2e7LEB3ox/wRbNqU9WaqA7yeud+/41a/m9nGAr
	LKI0XMcRS+5SaMFzcTipdCE3BJh1axRsXXxM7QYc/fgKmdsMJqCO+mRfQT2vaMuF
	a0LXA3EH5IThpbO704+uOilii6SisrEeBg+n8p7N9eoH+vnN7WY9c3q6CGHj89Ev
	HltDLzzzYq/syuXaK5qgtp7Tr00ZNgKY4hVDj4AQLBJkcTWuH3MaEaCeA5SlAltq
	l0V/sRY46detqHzyHxTdOCgsEhsnUI/uOJf0OHJtSr7OHoVS0kL2JAuzrRHq213O
	8LBDnBwmrtWbXgLUKbl+eNDOFVDMyns1iEvrqBL8FORxu5Yv/0oUNXNFDRgOvlrO
	/624U7qcG2m5Lep2RaISXVh8UIgnZZk1KAmMZjQUkAtkXpr6EPpREImLvY+QV09D
	RyJUok4J0eZhpL2404wBhKNMQdRTb9BQXdpSGaGivVPxg6KHTMUxWn1ornRKDwh5
	hT3qjFL5Gahs/qpHXMC1llgnU3JIA8PX4LkOUfl8fUY=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, "Kamel
 Bouhara" <kamel.bouhara@bootlin.com>, William Breathitt Gray
	<wbg@kernel.org>, <Dharma.B@microchip.com>
Subject: [PATCH v8 0/2] microchip-tcb-capture: Add Capture, Compare, Overflow etc. events
Date: Thu, 6 Mar 2025 14:44:35 +0100
Message-ID: <20250306134441.582819-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1741268682;VERSION=7985;MC=612642565;ID=1566293;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852637C6A

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
 drivers/counter/microchip-tcb-capture.c       | 132 ++++++++++++++++++
 .../linux/counter/microchip-tcb-capture.h     |  40 ++++++
 3 files changed, 173 insertions(+)
 create mode 100644 include/uapi/linux/counter/microchip-tcb-capture.h

-- 
2.48.1



