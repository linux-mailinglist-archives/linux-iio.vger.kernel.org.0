Return-Path: <linux-iio+bounces-26289-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB2AC69F28
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 15:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4D5E4F06C7
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 14:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3A03563E1;
	Tue, 18 Nov 2025 14:18:27 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89522EF64F
	for <linux-iio@vger.kernel.org>; Tue, 18 Nov 2025 14:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475507; cv=none; b=mUJufH4cf6GHgSy2TWOZGFubt38lwxjYpyO9AukFGtPc0XiTiOA3tg2z7fPLKxTnBlLLEzkM4cF/P/m++rFZAszOg/PG2bwNDAGDhO20mkN6I/8wr7p0X3V0IYFM6b2Z0MlXNrlbPo59iDl4T+pjtw5yX13fRDRBu/VqqxTjzyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475507; c=relaxed/simple;
	bh=ooMecDHB3KMVLYOMNdihVinK74xdeh/kI/BYw9Kox6E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r+0IEjTrfW1j6CohZDMehtiPQEC4AHWaEwoTefGv0EyrjNK6jke3XJwzrUSDpd2xs+hqZy4scaMeFXUv0PcIpWlpN6fMyUE16buIsVFzQ0vx3G9cj9TsfPkdxSN9M3+c5INjgzZP+rA7kp/4T3gtVH02yGN+A1QcSD1kMQ3b/ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vLMXG-0000ee-Mr; Tue, 18 Nov 2025 15:18:22 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vLMXG-0015yG-0O;
	Tue, 18 Nov 2025 15:18:22 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vLMXG-00000003o3e-0BWK;
	Tue, 18 Nov 2025 15:18:22 +0100
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
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH v4 0/2] iio: adc: Add support for TI ADS131M0x ADCs
Date: Tue, 18 Nov 2025 15:18:19 +0100
Message-ID: <20251118141821.907364-1-o.rempel@pengutronix.de>
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

 .../bindings/iio/adc/ti,ads131m02.yaml        | 208 ++++
 drivers/iio/adc/Kconfig                       |  11 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ti-ads131m02.c                | 968 ++++++++++++++++++
 4 files changed, 1188 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads131m02.yaml
 create mode 100644 drivers/iio/adc/ti-ads131m02.c

--
2.47.3


