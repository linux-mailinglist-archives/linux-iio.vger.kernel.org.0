Return-Path: <linux-iio+bounces-21671-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D7AB055AB
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 10:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5D683A5AE3
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 08:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41E52D3EDC;
	Tue, 15 Jul 2025 08:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b="Zq87e/iS"
X-Original-To: linux-iio@vger.kernel.org
Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8F31917F0;
	Tue, 15 Jul 2025 08:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752569946; cv=none; b=BKAVk+AoDo5hlqqm7NIrzk4Zkblcu6ndmNM94ZDv/tNk1ERLSSLKU0wLy6FTcwDfHtXknoPVtCHEoWWyVUWK+HxZLlC+MwX+X2MA2oejRsgdLEHcbiMDAq6OFShBwwanXAYnRJzonBlT0egsrmM9+Madcs3DbGaqmhtYxnc2Rok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752569946; c=relaxed/simple;
	bh=iKMUAmtCdb7rPKw4eZtTd6lyT0NyYrxjSniJ3kxQU1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HuYXMaEcFduOYqhmUJyVawXbGqXpMZPvbF76CZtgq4XM0oOBUQJicSDqiXezzOM3utP3VMApdLVLewk+x77OBPmy6wBw4XLZ+Ag1wseUQM5Fy/HpErD3tVKJC0ueXDQ2V/wDFzLp8CV8+95VlsC5/+1C1EXObxpywXIPo7batMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b=Zq87e/iS; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=it-klinger.de; s=default2502; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=9RXJXruNUCau64eqsnbcwp67ROSKsLP30uYqLfMi3TM=; b=Zq87e/iSpFlF/f7A0gRsaIpCBz
	nXaaXhYmEi5sDXFaJ9rqovnMTB2Qz4cFLakPHOjkip3fgqO4SdrvALeju+yaEq+IjeoyAuWajnsiQ
	+/uVX9/eNh3EqLas7yObWoWKJ4tgVpHQuwAa1wt9RDHW9LB8Dzk98TWuvqnT0rJtB/FWku1c8T9Dr
	UmUmV7Ucj3kCLHQmUaf+Rm5C5k9a5aUZqrMVpTz25clM1fmznR+LiA6UcdjWohKHEnUacb6iDcgIb
	g+urh0lgsDl8Bet+WN1dwWuPqf/RJxaSCHISLT+fMaeZukFgNPcXE2PgGUVLrikOM+NBumi/ccV0I
	aeDrrZPQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1ubbUx-000HgA-1z;
	Tue, 15 Jul 2025 10:58:51 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1ubbUw-000AWe-1b;
	Tue, 15 Jul 2025 10:58:51 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: lars@metafoo.de,
	javier.carrasco.cruz@gmail.com,
	mazziesaccount@gmail.com,
	andriy.shevchenko@linux.intel.com,
	arthur.becker@sentec.com,
	perdaniel.olsson@axis.com,
	mgonellabolduc@dimonoff.com,
	muditsharma.info@gmail.com,
	clamor95@gmail.com,
	emil.gedenryd@axis.com,
	ak@it-klinger.de,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/3] iio:light: add driver for veml6046x00 RGBIR color sensor
Date: Tue, 15 Jul 2025 10:58:07 +0200
Message-Id: <20250715085810.7679-1-ak@it-klinger.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.7/27699/Mon Jul 14 10:54:31 2025)

This patchset adds an IIO driver for Vishay veml6046x00 RGBIR color sensor

Changes in v6:
- Thanks to the in-depth review of Andy many datatype improvements were
  realized.
- According to Jonathans review change the channel types from IIO_LIGHT to
  IIO_INTENSITY.

Changes in v5:
- Thanks to the feedback of Andy and further explanations of Jonathan many
  improvements could be implemented.
- add documentation in kernel-doc format
- iio_push_to_buffers_with_ts() is not used as also testing against
  linux-stable where it is not available so far.

Changes in v4:
- implement feedback from Andy and Jonathan
- implement feedback from vendor (reading interrupt register as bulk read)

Changes in v3:
- implement a lot of feedback from Jonathan
- change scale value to real factor of lux per raw count instead of hardware
  gain
- optimize code by using more lookup tables
- remove unimplemented threshold functionality

Changes in v2:
- fix missing include for example in vishay,veml6046x00.yaml

Andreas Klinger (3):
  dt-bindings: iio: light: veml6046x00: add color sensor
  iio: light: add support for veml6046x00 RGBIR color sensor
  MAINTAINER: add maintainer for veml6046x00

 .../iio/light/vishay,veml6046x00.yaml         |   51 +
 MAINTAINERS                                   |    6 +
 drivers/iio/light/Kconfig                     |   13 +
 drivers/iio/light/Makefile                    |    1 +
 drivers/iio/light/veml6046x00.c               | 1037 +++++++++++++++++
 5 files changed, 1108 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/vishay,veml6046x00.yaml
 create mode 100644 drivers/iio/light/veml6046x00.c

-- 
2.39.5


