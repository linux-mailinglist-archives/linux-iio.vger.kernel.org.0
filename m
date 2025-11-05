Return-Path: <linux-iio+bounces-25913-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA072C361D2
	for <lists+linux-iio@lfdr.de>; Wed, 05 Nov 2025 15:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA11856666C
	for <lists+linux-iio@lfdr.de>; Wed,  5 Nov 2025 14:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A4732E148;
	Wed,  5 Nov 2025 14:38:26 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E3F322C67
	for <linux-iio@vger.kernel.org>; Wed,  5 Nov 2025 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353505; cv=none; b=kM0kdMu2bPNfBqtP5gMTdK1eYKDQGY+72WmiShoNrCSOQhkiia5N1FE3TY2XLc8kyD6CZts4zlwW5Kj3Bk6QrNrZiTlfDOk9HWoOIm5Ukz11wgs86ZqQLxI8/jznNGCMWpfD+a4mD5rau1lvomyocDriZBN9aWNydjl4EAkUbxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353505; c=relaxed/simple;
	bh=FAtijL3RkrgUgqOAZuFvMEZx3xdguMn+aB58dDf3pJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GaZsuktTxLrbyDp/YcCxoTi5y5mQ5/SeE81FP1GEPBcqisVhV5UuZpASNq0PgOgBZm0eClcH66QOHoKcvmOkv+6n3xvN8Se9qokWzKgYv9L6fs1iMKkJXOcNVdTzpzUvnQWijNsVUlMAZlmtrpE9UXcCAR9Pd+0nroa7LwDkPkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vGeeO-0003oc-3U; Wed, 05 Nov 2025 15:38:16 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vGeeN-007DGB-0a;
	Wed, 05 Nov 2025 15:38:15 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vGeeN-00000007aCz-0RcE;
	Wed, 05 Nov 2025 15:38:15 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH v1 0/2] iio: adc: Add support for TI ADS131M0x ADCs
Date: Wed,  5 Nov 2025 15:38:12 +0100
Message-ID: <20251105143814.1807444-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

This series adds support for the Texas Instruments ADS131M0x family of
24-bit, simultaneous-sampling ADCs. The first patch introduces the
DeviceTree binding, and the second adds the driver itself.

These devices are not compatible with the ADS131E0x series despite the
similar naming.

David Jander (1):
  iio: adc: Add TI ADS131M0x ADC driver

Oleksij Rempel (1):
  bindings: iio: adc: Add bindings for TI ADS131M0x ADCs

 .../bindings/iio/adc/ti,ads131m08.yaml        | 162 ++++
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ti-ads131m0x.c                | 886 ++++++++++++++++++
 4 files changed, 1059 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads131m08.yaml
 create mode 100644 drivers/iio/adc/ti-ads131m0x.c

--
2.47.3


