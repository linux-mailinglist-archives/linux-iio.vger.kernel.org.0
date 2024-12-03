Return-Path: <linux-iio+bounces-13005-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 565D69E1A73
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 12:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D216165C37
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 11:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6757A1E3789;
	Tue,  3 Dec 2024 11:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="T1Mansl/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42071E3791
	for <linux-iio@vger.kernel.org>; Tue,  3 Dec 2024 11:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733224414; cv=none; b=P4Wzb4MDbRbFeNGkT2JfaaAOHcj6bFD++zR68/MYhZba+239QwewpT8KoSXor8kxdYl2lVnDZxlnTI9nZ1oi00iBcbxljvKmSF8M2/b9qBrxFHVjDhsG4jDUNyVBG+IYjxea1BWpmc4dHV/NKlNjVl8SgeJSt++BhHHqpLYKNlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733224414; c=relaxed/simple;
	bh=oGSk6hVxW1wYB/QI1mVV80YFrcUPoJqrE8+x2OzhEEI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PmKPr0Mk5yaaIVga5PNCNiSVHnuSPOROK/a9aP2kZdmgb5dhTvjo7k8asyWC0/qA+rNp2sYEvWCtwrGRNhG7VAh1Lji0ojwsRfDMpTi7Cubc1XLZWqsuBsGZ9joQ2UhLIWFRtIs9GoXlVJ6/p67TK+dcIZNiJm/qcoux/64UvZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=T1Mansl/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434a2f3bae4so50012265e9.3
        for <linux-iio@vger.kernel.org>; Tue, 03 Dec 2024 03:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733224410; x=1733829210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHAew+5pIUtNZ469Ay/e6iOZX+tKVuk7Y65o+7qMTAc=;
        b=T1Mansl/VVrNqeYSnHiYEZTqakQvk/nx49YN3fgp8Rg+KuMxAhUWAZabiOdqYyOZsp
         8k5c0nH36NbZidcxPKY7IDdM3v/Ht8fzXEWFd0fiX3XvQhv4IieC7aCDgc8I/YHqNtv9
         svkoribsIoW7pcoCaZUykqDrB82Mu3Bam8E+jfgHavADowlFG2YMYeUQ+fCL+CTeo2Sx
         BniANs0Tr9sKS/rlgLv7q5QYW/UIwREHeuDPis1TeMDf5vLbPpfqMjBJRz+MBQVVN1XX
         LAsAqjQWVXK+FnMDXUCUK7Im5di9D0MLb6sgx9Ymh5XDKu1wDlx0naTRBVsLe/0lheSC
         bNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733224410; x=1733829210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZHAew+5pIUtNZ469Ay/e6iOZX+tKVuk7Y65o+7qMTAc=;
        b=FueQl1929gywBVrnfOJeyVrzKG5Efrte/kmMwugdIjyk7jGvHkqpuUDxRt5AMZ0Qj4
         YEQkFKUaZP8LqgnOnkmCfvrKrR4jQa5ubUEBw0Z7e7XSyUi1maLhvbxpiddMqAZJ2qXH
         BxDz5TB+U/Fb0AWEMhls61QLOW3YspcJ3t0oK1TO0oBCJUAR9B7HkCxAyRMVtNpNZAol
         g3UI9htqGqFNkYvyliwJxAXOhnHjHdF6iU8w753AZv8L82qoqQJvhloEgozhZ8LbbtRO
         Kqw8RqlEHIoDhC99u+1l1+t9i64zddq896G8+TeR+dNI7mKZFGlyIYuL0bQIoJRYVdoq
         zLyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3CBfVzEOBwx1aPmxkMR5EqRqsd2TSSFV+FY3rSOZbX91ihcRgcK45bPkXdM6PpNmcuvCWUgOeBFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YylmQWM5F4VQDZulPYlDYpptY5452+ncVqPxV1rfe9ZdL7uFjac
	VvE0tgEgxNbsPELjr2CUd5pyfMJPKAD49uFxpKtGUjNBJF3B6QYPANc37xqEMxM=
X-Gm-Gg: ASbGncsc8wm51/OuBweRNI2Z0zgo8gxC8mpzwMgqdAAi7IbalU65zp3JP1aesrI5l14
	ANtlmweEUK4M/6tQwoKsDdV+IknrIoyvmTImAigc0+qrQ6wRKF24K++KgVl6D67wvdH4kM3gLXC
	kvOEmgu9crXceOFLWr7XGGLyWK0Yg4b6IQk/D7/+lZF8S1aEZYqu+1hXsqwvcRlaOqRd1XBhWzN
	JQepCgsKo+LKixKLIALK9axDJmRtCKm65aAJXsXtMZQ2ehPKObloiKBGJcsI5xs/IGil8mQc5nk
	8bux
X-Google-Smtp-Source: AGHT+IErtKnY0Pv3GfVcIJwifhLrCQ99HAQ814LD/e3xtS/wVzvpDdVQw8u6DVBzuWDInXQU6dGy3Q==
X-Received: by 2002:a05:600c:1f91:b0:42c:de34:34be with SMTP id 5b1f17b1804b1-434d09acf48mr20434705e9.3.1733224409944;
        Tue, 03 Dec 2024 03:13:29 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e0117069sm11794315f8f.60.2024.12.03.03.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 03:13:29 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 00/14] iio: adc: rzg2l_adc: Add support for RZ/G3S
Date: Tue,  3 Dec 2024 13:13:00 +0200
Message-Id: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

This series adds ADC support for the Renesas RZ/G3S SoC.

Series is organized as follows:
- patch 01/14:		adds clocks, reset and power domain support
			for ADC
- patches 02-06/14:	cleanup patches to ease the addition of RZ/G3S
			support
- patches 07/14:	enables runtime PM autosuspend support
- patches 08-12/14:	add RZ/G3S support, including suspend-to-RAM
			functionality
- patches 13-14/14:	add device tree support

Merge strategy, if any:
- patch 01/14 can go through the Renesas tree
- patches 02-12/14 can go through the IIO tree
- patch 13-14/14 can go through the Renesas tree

Thank you,
Claudiu Beznea

Claudiu Beznea (14):
  clk: renesas: r9a08g045: Add clocks, resets and power domain support
    for the ADC IP
  iio: adc: rzg2l_adc: Use devres helpers to request pre-deasserted
    reset controls
  iio: adc: rzg2l_adc: Simplify the runtime PM code
  iio: adc: rzg2l_adc: Switch to RUNTIME_PM_OPS() and pm_ptr()
  iio: adc: rzg2l_adc: Use read_poll_timeout()
  iio: adc: rzg2l_adc: Simplify the locking scheme in
    rzg2l_adc_read_raw()
  iio: adc: rzg2l_adc: Enable runtime PM autosuspend support
  iio: adc: rzg2l_adc: Prepare for the addition of RZ/G3S support
  iio: adc: rzg2l_adc: Add support for channel 8
  iio: adc: rzg2l_adc: Add suspend/resume support
  dt-bindings: iio: adc: renesas,rzg2l-adc: Document RZ/G3S SoC
  iio: adc: rzg2l_adc: Add support for Renesas RZ/G3S
  arm64: dts: renesas: r9a08g045: Add ADC node
  arm64: dts: renesas: rzg3s-smarc-som: Enable ADC

 .../bindings/iio/adc/renesas,rzg2l-adc.yaml   |  37 +-
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  53 +++
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |   4 +
 drivers/clk/renesas/r9a08g045-cpg.c           |   7 +
 drivers/iio/adc/rzg2l_adc.c                   | 414 ++++++++++--------
 5 files changed, 323 insertions(+), 192 deletions(-)

-- 
2.39.2


