Return-Path: <linux-iio+bounces-13137-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C1F9E6CD6
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 12:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 807A61674A6
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 11:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3A31FCF69;
	Fri,  6 Dec 2024 11:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="dABlAaeK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF1A1F03F6
	for <linux-iio@vger.kernel.org>; Fri,  6 Dec 2024 11:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733483638; cv=none; b=Ks8yzHz1OrOjvQ5rtlru9eSzR0jzpQCGCffMaEVJzPziispKLatPwwqH5oAP9MXoUFEmTcXrBEaRQSUbvme+SeD87J7/uA9TGmtKfvF1MTdFIwjhTcAxGbzmfa4IrY0xr4oQAZs4ZV5yIBqDindcpJQgQLf7jHlzquB/fuFfOYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733483638; c=relaxed/simple;
	bh=dDR4+Q0bwup8XiwfT7f6n2a0gDrV0vi56ih3uackW5o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TpyBB5vnFKsM9JTs9CLa8lgEmjTAw7JExDJ9ganwUShw6uD1+0jQRI8TC+9GsU1R6IheSlDb2P8q5HuoryLErxVs/lzirbjEfCz9+T76f1qwdXA7UDaUyV3E1BgHeqCzfujcRpq8uE8oxl93CC13s3FqSDStWtNVwqar+twFgJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=dABlAaeK; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cf9ef18ae9so5368696a12.1
        for <linux-iio@vger.kernel.org>; Fri, 06 Dec 2024 03:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733483633; x=1734088433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xNv2zbazDCZ/pWBKvIEuI2Pxd+zGHz/To3nXkUZrj8k=;
        b=dABlAaeKFe2g0SBgd2s1oTOHlV6y/JXrGEIbqbVZgAaFRA/WmSNy2FHxMFXD0d2eZi
         t3LxiM0jwHHLmkPXuKy+TXx2mUJwKTZO3Huj8sDlCaYIdrdYJxgKFXJkUKwweeGI3AvX
         yG4YsNZNLvdrdlrTl3oRu8FVcGLq8reUEZ0pAqRx/l0dOJLH+XFth/oE84/JkTkjNjE8
         +Ke9WjhkA0N4VfK6/2VV8aHJdPbq61+NEa5uGVYaDkgSHiyrmuL8fTa1sD0cR7pw2I1n
         lWEQzh5RdQlww6uhQxTk4JaqsA4tccmAAzVU+2rOQqT4ygsyJfx+Dm5P1MNCh22J5iaN
         o+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733483633; x=1734088433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xNv2zbazDCZ/pWBKvIEuI2Pxd+zGHz/To3nXkUZrj8k=;
        b=l7IR6hmdgJZwhugwdht5Azc3BRjxw6esuIKcgZfEojfDOEgqPB6mYKdrZfpZby3nLp
         tlPIhvuVPaPTdHoOaEoJAD3f/mgWhHHExcbXHWJU+GXpMMa2kteoXIIiHNP2HdeVEaWW
         6dscFTJsFa2wsoQ8xXIPmwPIZOn7v+EsTOOoxNlKqstBQOZIcrHwVVEcOIPBhtbOCKnG
         TcOSONdrf7bA2ZkkZj8xmAG+fSZ44/iOoOruKrM77TIhN6AnEFaqLnLvcNb/IqiZRYxh
         CIEazT8sUf1Ki9Ics34mJ+PdDpvgOgcslh/eNe36D8EIkWhPf56CQHhupXFkx76K3NUK
         tiqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFHUf7uOtuCphh7feLad9Qu3gM1tb6m3zg5/noqhFsCIGt06UyI0Kn9hxjkhj7u+Z/ZK4u1Swr16M=@vger.kernel.org
X-Gm-Message-State: AOJu0YylofNE4KyNVenBvyyt4WtCUn3eWk2ziV0V4q8bxYV7mFj5zVMC
	1TaSAmLraSiYMdbSDUQNaUPJXMqgYLlZyEGP/gxG2kHToobzRII9xzRbBgLNr6A=
X-Gm-Gg: ASbGncsCaQZczZ21SaVsjVvFKK2QzN7M4JFi9WgdBy/Sb3pCEdHXby5ckD4WuB8n9zU
	lspC55KBawumVqr/dsioSpjnJjhxC0+Gx9Bv8u/ysV8S7MuHXI2zE+BPx/ZTh0imibLijPYzjHR
	SveTCYo7gB15s18bk1H41kjN21yfyooN1GeHsxG7xXsDGOQtrdGdxve1R3de/SOKFHe2yb1FBgm
	U0qDqGEOqB6Kkk9PiRLtcPR70QXA+DR2TcQjNw5DotPL75SUYDViNHrF2B7bBeAIUnkC7G20adr
	tPMo
X-Google-Smtp-Source: AGHT+IHll3lGOqyFO812VEboDgJwa6/Nx08MKrC77gJO3Ig+etbaCZN0rl3zYI2kKOz7kmgwe+LwuQ==
X-Received: by 2002:a17:907:3a0f:b0:aa6:2b21:ab5b with SMTP id a640c23a62f3a-aa63739e4e9mr254496166b.12.1733483633411;
        Fri, 06 Dec 2024 03:13:53 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625eee2a6sm226877866b.90.2024.12.06.03.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 03:13:52 -0800 (PST)
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
Subject: [PATCH v2 00/15] iio: adc: rzg2l_adc: Add support for RZ/G3S
Date: Fri,  6 Dec 2024 13:13:22 +0200
Message-Id: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com>
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
- patch 01/15:		adds clocks, reset and power domain support
			for ADC
- patches 02-07/15:	cleanup patches to ease the addition of RZ/G3S
			support
- patches 08/15:	enables runtime PM autosuspend support
- patches 09-13/15:	add RZ/G3S support, including suspend-to-RAM
			functionality
- patches 14-15/15:	add device tree support

Merge strategy, if any:
- patch 01/15 can go through the Renesas tree
- patches 02-13/15 can go through the IIO tree
- patch 14-15/15 can go through the Renesas tree

Thank you,
Claudiu Beznea

Changes in v2:
- added patch "iio: adc: rzg2l_adc: Convert dev_err() to dev_err_probe()"
  as requested in the review process
- addressed review comments
- collected tags
- each patch includes a detailed description of its changes


Claudiu Beznea (15):
  clk: renesas: r9a08g045: Add clocks, resets and power domain support
    for the ADC IP
  iio: adc: rzg2l_adc: Convert dev_err() to dev_err_probe()
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
 drivers/iio/adc/rzg2l_adc.c                   | 423 ++++++++++--------
 5 files changed, 316 insertions(+), 208 deletions(-)

-- 
2.39.2


