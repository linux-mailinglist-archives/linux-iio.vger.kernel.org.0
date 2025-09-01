Return-Path: <linux-iio+bounces-23619-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8511B3EF02
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 21:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 825E94859D0
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 19:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CCD261B64;
	Mon,  1 Sep 2025 19:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="nUqN/aXA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73B942050;
	Mon,  1 Sep 2025 19:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756756510; cv=none; b=TeVq5bsUeZxsmd2jcK3zkZ1XDBhvxNHENZCJM8MAgSC878IOKnPwaqEwH7PMlJYF0vRRswXUR530sFSa23nQHKvV1JEAbpW/v8NLI3zWrJOCRMCqjvuRz2IPkDTn1NH+sSyFgUfkt7dJspySgWlNPxAgO2hPWpRsIde/jv8Rrc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756756510; c=relaxed/simple;
	bh=KxZyQ0HiwXM6mD91TcRbSpXFQfnZKrBIk2Oadgrdc3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ULUryVZq+0peKEgMQ81fs5WUFseMr+k5xLdsZothIjSwxjGx1Ti3AzxrRCA8T9a9ikMaONLWy2eEir6E9AibRwMJzonWwHTxazMTz+34e0wZiGUaUaClN1NAhj8nkK0CYbgQMsiU1wLj20OV3mvN9lMYgy2e0N5zA8mSzM/wPM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=nUqN/aXA; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [IPv6:2a02:2f0e:3503:4a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 904BC173BE2;
	Mon, 01 Sep 2025 22:47:53 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1756756073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Klj+0n0SGq7wmcxiSme6Bjw4tQChsnNaIt3NDzpKBFI=;
	b=nUqN/aXAXk/MliAnKaWp0EFeh9AZstTF0MmPequRk9mbDjc2YngC1dx2JduPAu626RYZZU
	igPRMTL8KS6XOCGL0Xd98IaN0YIM0lJXh70SVAwH8cjZV9ddf1E/tqC8UWrwVcxljHZRaL
	zGJIwv2QGw0nlVFlOF+hgplYlQiekegyNZKzLE+Pw2xbUv77OKh0w4LRWhdsscdT4EaiQ5
	pTX1UBtG2Wld8axaqiXEPRL0qtANnMmJVYmcPQnW1fY78l7ybBCI8CGpTU7GyigYAa/Mlz
	Evc8zKPk6UQzXX8/RhA8LIbA2iD1iRchK7AECLq4vur8jrfxPyY/no/FSaYufQ==
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH 0/10] iio: accel: BMA220 improvements
Date: Mon,  1 Sep 2025 22:47:26 +0300
Message-ID: <20250901194742.11599-1-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Series of patches that switch the driver to the regmap API, add i2c
connectivity, tap/low-g/high-g/slope event detection and a large number
of sysfs mappings while keeping backward compatibility.

Tested in I2C and SPI modes with two different sensors.

Petre Rodan (10):
  dt-bindings: iio: accel: bosch,BMA220 improvements
  iio: accel: BMA220 split original spi driver
  iio: accel: BMA220 migrate to regmap SPI
  iio: accel: BMA220 add i2c module
  iio: accel: BMA220 make use of the watchdog functionality
  iio: accel: BMA220 add LPF cut-off frequency mapping
  iio: accel: BMA220 add debugfs reg access
  iio: accel: BMA220 add events
  iio: accel: BMA220 add event attrs
  iio: accel: BMA220 add maintainer

 .../bindings/iio/accel/bosch,bma220.yaml      |   20 +-
 MAINTAINERS                                   |    7 +
 drivers/iio/accel/Kconfig                     |   18 +-
 drivers/iio/accel/Makefile                    |    4 +-
 drivers/iio/accel/bma220.h                    |   21 +
 drivers/iio/accel/bma220_core.c               | 1551 +++++++++++++++++
 drivers/iio/accel/bma220_i2c.c                |   62 +
 drivers/iio/accel/bma220_spi.c                |  313 +---
 8 files changed, 1702 insertions(+), 294 deletions(-)
 create mode 100644 drivers/iio/accel/bma220.h
 create mode 100644 drivers/iio/accel/bma220_core.c
 create mode 100644 drivers/iio/accel/bma220_i2c.c

--
2.49.1


