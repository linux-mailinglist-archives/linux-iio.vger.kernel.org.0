Return-Path: <linux-iio+bounces-19647-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36688ABB4D1
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 08:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 504B218960E0
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 06:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C4E224227;
	Mon, 19 May 2025 06:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b="IQ+tE8oZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5757D223DDA;
	Mon, 19 May 2025 06:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747634946; cv=none; b=B9/ZxDleVX+cbLtCNPytaT4Gsc1wEdtn7GX9EWFb0cfbDIb/5Zi4qRx2n8zJhe7bGUwqoRHaqeQ0wlOFExfTPgAfMcZktz1BNEu1vemAG3sWQ4IQRrNk2gl3eba2snpokuqvmcrI6bQsEwLVbB9c+5U94fgHq/VDOAiLsGO6woU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747634946; c=relaxed/simple;
	bh=rF6T8pxOM2Tm5rzdutowsqLi2tHsWexhEUl2S/i0YxI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UBzXICYA1gihyBWARL8HajLAYb78ePDsGmrP1uNLKopohVrYwOk4PyVOvP49EqzcJeAz5aCkej9FaUyzTRy21eKYSQIQrw5WsAYuToS2GtCOU/awyIYFcYtftdmiNnfMkC4BuUxqVuHM+uIUn11HAXkNRrbsVQPuMjCnpTWTEbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b=IQ+tE8oZ; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=it-klinger.de; s=default2502; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=FtkgkryYRMCLN+w/je6wJT2fZr1d9z037DPMjxKNPn8=; b=IQ+tE8oZiu+ynSW30GoNC+ofH1
	MnDHduyuocrkThrHPaMTM44L5gvfp1+75pCfvQ2iVvA3wZb505zshC7u7mTCnJtmB0Vn3QBTOUOIX
	7TAFeWMFT/eSgvzVlBb+9sFfqx9hXJ7lEeU8L36PpCBJdzkf7dCFETnok+SufmKAQuAGp5E71YB2u
	wSvvo79BxGNG6yiNW15VDc5czcwOuLfgGQiDLnUevo4LWVkwK3sNEC6un2qXE9hr8X7ZlDhINnaHp
	d+6L83DI9ggxjDYAc4lIEz8t9LD38/2equXusWQN5v0SsNbAvLRrufYbJAv6fTG49wjqXZE5fJy4R
	Yyp65dxA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1uGtgI-000F8F-0F;
	Mon, 19 May 2025 08:08:58 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1uGtgH-000Ogq-1e;
	Mon, 19 May 2025 08:08:57 +0200
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
Subject: [PATCH v4 0/3] iio:light: add driver for veml6046x00 RGBIR color sensor
Date: Mon, 19 May 2025 08:08:01 +0200
Message-Id: <20250519060804.80464-1-ak@it-klinger.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: ak@it-klinger.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27641/Sun May 18 10:31:14 2025)

This patchset adds an IIO driver for Vishay veml6046x00 RGBIR color sensor

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

 .../iio/light/vishay,veml6046x00.yaml         |  51 +
 MAINTAINERS                                   |   6 +
 drivers/iio/light/Kconfig                     |  13 +
 drivers/iio/light/Makefile                    |   1 +
 drivers/iio/light/veml6046x00.c               | 953 ++++++++++++++++++
 5 files changed, 1024 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/vishay,veml6046x00.yaml
 create mode 100644 drivers/iio/light/veml6046x00.c

-- 
2.39.5


