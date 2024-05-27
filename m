Return-Path: <linux-iio+bounces-5348-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E158D0667
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 17:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 907A328535F
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 15:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D195161FC5;
	Mon, 27 May 2024 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="nWl5P62X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809521E4A9;
	Mon, 27 May 2024 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716824482; cv=none; b=S1f4UCvgI/1O2Ku7ADBLp6BTnKDOSXMJkYtz4xJNavMFnDNaEMHi6lFWCc06atIu3Z21sN7YwHBuhg+XRL7wjit/UQQrd9y0xwn/i1gQ9uY20d8WY7gzldX/EY1bJuGxCrY60yZeGP+LgCCMgb/T4GZaNLpLSMBlJj3lOOGqXoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716824482; c=relaxed/simple;
	bh=xi95REYMNGRInm8QTlaIsBRCKucC1a/x692ZYbFHYpE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pDO1e210jsMt5pyNPIxfg86Ctl1qT1lAGEijT8aHoTHip7KufcVYG0dEhsRhbHIHLMpFLGjHgP9m0FdXbftQSEbdezsSZfPmW4eTwbXGH138EigvZTWy4Sw4mQxOUdUBPclSi/qt+LSHOnsJX1SyF/3lrUhyO3R1ouMeMGxt8O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=nWl5P62X; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 208A11FC11;
	Mon, 27 May 2024 17:41:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1716824469;
	bh=/qL7ds6TPTDOqwgOF3TOtIR58e7jrv/FMc1WXB1AASw=; h=From:To:Subject;
	b=nWl5P62XYKZ31HZHg54sxMgn8LeQnJnSyt33QM/wcS5uSHtYz/vubyXf+am5QLug4
	 6uo6QURAWDJw0D0lmGq4i+jLvj5CuqtegZLEXowwhcKYrsEUlbIz1KQc2OB8U05F0O
	 K+EQHEelgo5CRr7AgSJG5+7w/EMdgu00rGYDY4zl6aEXZMvn/kG/I1G9PW7Sw3dwTs
	 UDtiqv2CASd5+USSMZa1mAlD2nfJ8lErXp25u+oGiN6EJtmyo5xasnhlB6iObCVW7Z
	 sDv00s6DQjl7GTah7Tq+wgD/eSuGVHQNaioMs9oR9aMxuHnqHGmYxEMPDC9ouqmPVh
	 wPB19Y94EGRqA==
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
Subject: [PATCH v1 0/2] iio: adc: ti-ads1119: Add driver
Date: Mon, 27 May 2024 17:40:48 +0200
Message-Id: <20240527154050.24975-1-francesco@dolcini.it>
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

João Paulo Gonçalves (2):
  dt-bindings: iio: adc: add ti,ads1119
  iio: adc: ti-ads1119: Add driver

 .../bindings/iio/adc/ti,ads1119.yaml          | 122 +++
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  13 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ti-ads1119.c                  | 815 ++++++++++++++++++
 5 files changed, 959 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
 create mode 100644 drivers/iio/adc/ti-ads1119.c

-- 
2.39.2


