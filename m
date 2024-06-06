Return-Path: <linux-iio+bounces-5929-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B842F8FF2D0
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 18:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19272B2A774
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 16:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94C2198841;
	Thu,  6 Jun 2024 16:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="xmSqYpwE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61441953A4;
	Thu,  6 Jun 2024 16:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717691742; cv=none; b=HrpqE/1pYKm+sGZCWPOrIH1C0yy99Ah5/xwdUGQXkideLZ40pG4RtQbTt0AfmuvDjtGtgzgIrM/88uN/LlXMgWrfo3IMjed3eOIKBhN++X10HW94W0SrIqXizHagR+/JTYWJgL8/A7FIgZThQwIiUasqYTc1Cel7lnZMmKxqOqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717691742; c=relaxed/simple;
	bh=txrTlDYUmWxlbNDzia4hkPlPs50Pzoy0fdsdojtxSwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VDh5qwTqabPhhS0UDU6hkPUGik3tDF/0eUJYaHaF086Yr9hqg2Pavt+Ko03BlgDHEx54e5LP9hCL+dqkqd7RJgxuO/Hvp84Th4/OHg5ieYWHSPqvEZBCwzr0W3a4kR5kG4MeYFo0uIAF59wPajc7kytcaUshDXBu7G6i0ogYGZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=xmSqYpwE; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.corp.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 7C0971F9B3;
	Thu,  6 Jun 2024 18:35:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1717691737;
	bh=VL7Jfe5LASAsbhjsk8tZFy0dkoyYybfw6edvNlQBITs=; h=From:To:Subject;
	b=xmSqYpwEBoC9JKobeAaYu3W7Emobg6hiR/s/V32L1VCFJZKrmM71Ax9txRgr0e5GT
	 U9hQlv7GN5KRvKgMZS9K9at/tDi96c/8/5FAgSS2Jy4sIqmYaiYxhQRepQjTNLSutf
	 k60nyBEQUy43Cdbn8CnzLOKVOOAqmhpxMXKNJt1mNe7i/zWxPZArUprRFJSXVOcE+b
	 ABlMI04Eh3zUTFS7V9/36xsIR3wboRGIxKvD/q2XP6Y7Tj79tYm0fho5lLLf+fH1hA
	 wOg/vRBVrGhdUiYib4CQSFM2ebtxtm120bVhXzBFYnrFXI5M8GcGGd23KzpQMzc/Sn
	 nhn47F0iduCIg==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco@dolcini.it>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] iio: adc: ti-ads1119: Add driver
Date: Thu,  6 Jun 2024 18:35:27 +0200
Message-Id: <20240606163529.87528-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

The ADS1119 is a precision, 16-bit, analog-to-digital converter (ADC)
that features two differential or four single-ended inputs through a
flexible input multiplexer (MUX), rail-to-rail input
buffers, a programmable gain stage, a voltage reference, and an
oscillator.

Apart from normal single conversion, the driver also supports
continuous conversion mode using a triggered buffer. However, in this
mode only one channel can be scanned at a time, and it only uses the data
ready interrupt as a trigger. This is because the device channels are
multiplexed, and using its own data ready interrupt as a trigger guarantees
the signal sampling frequency.

v2:
 bindings:
 - add diff-channels and single-channel
 - remove ti,gain and ti,datarate
 - more details on the patch changelog

 driver:
 - adaptation for the binding changes
 - changed i2c read/write to the device (not using regmap anymore, use FIELD macros)
 - more details on the patch changelog

v1: https://lore.kernel.org/all/20240527154050.24975-1-francesco@dolcini.it/

João Paulo Gonçalves (2):
  dt-bindings: iio: adc: add ti,ads1119
  iio: adc: ti-ads1119: Add driver

 .../bindings/iio/adc/ti,ads1119.yaml          | 148 +++
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  12 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ti-ads1119.c                  | 850 ++++++++++++++++++
 5 files changed, 1019 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
 create mode 100644 drivers/iio/adc/ti-ads1119.c

-- 
2.39.2


