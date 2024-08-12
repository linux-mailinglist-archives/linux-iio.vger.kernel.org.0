Return-Path: <linux-iio+bounces-8423-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C61C94F11D
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2024 17:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F7C61C21F2C
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2024 15:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E15184531;
	Mon, 12 Aug 2024 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l8ekYPfh"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE127F6;
	Mon, 12 Aug 2024 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474873; cv=none; b=pya1beZS3MLqS/t0oWag47gymQEThfPf0TxwldmzBB8O8YTDF94M6mkIQoi3khFijwWK4L/uWE2MsKFvaIIXOICXxwosvLzVYeVkLckkulnAn4RoosXKsbwy+W1lV36LZaqWcpke2sqh6V9VtKVboxRsVaKPmu8HpPQJ3LxT7fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474873; c=relaxed/simple;
	bh=qXQ33owotgSnZeYZJ2+UpfZZ8U8matWz4X0TsIqMtKY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=owPAwCB6IkNtCwPfHASqiZ9/Ec26x7XtJ0NIoiHN3gHpJC48hUnF/LE4JEv8/pRzyNa79kc3PIKW6TRrUv76MncvGL+0GLcT54l7RD0+fzEocQZcL1U1sG/gzWrLELL6KJBFL4oFHWMfu/uVvvneCf6SKJVrH2U7p1fM7IxGxP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l8ekYPfh; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 23BD8FF804;
	Mon, 12 Aug 2024 15:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723474866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zrkbsHf98jdzwc61NfnGUE1oZTZ8EfUZY7Ktf9hQoNU=;
	b=l8ekYPfhWJdnIxZH+oQ1nPhqOT0NRFtgyw1sKdDEXKY7wRNnsxnaBwfJ1t9ZOO1oOQU6Pr
	/Jdu5VRbE5RLEWR1kjfQwUupWiRC1VnWo3gDfPHREarJQHXR50+/dXISHo/Y37gor8e+BG
	SGmaG2jUwnQCHzLaDCTnhsvs5wYx2NwvDEG6NqRlrPFX2oGp7l8GgUlkPx01pAjjH4tGuo
	Skd+oL/o71KVdeiyh4QEqkviSTRyqkb436Sqhiicix+RgMl/XdzTazv5HrnySPzSDlGJoZ
	Igjk5xyKi+hPWsu3UzycKUeFEnRlplbiIFSeRJ8EueEnI9/kNiUrpch0+Llfyw==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Subject: [PATCH v4 0/3] Add SARADC support on Sophgo CV18XX series
Date: Mon, 12 Aug 2024 17:00:54 +0200
Message-Id: <20240812-sg2002-adc-v4-0-599bdb67592f@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKYjumYC/2XMSw6CMBSF4a2Qjq25vX1QHLkP46CUAk2UmpYQD
 WHvFpxAHJ6TfP9MkoveJXIpZhLd5JMPQx7iVBDbm6Fz1Dd5EwQUILGkqUMApKaxtEJRa4W24S2
 SDF7Rtf69xW73vHufxhA/W3ti6/vLlNnvMhOjQI1VykGpTCnVtQ5hfPjhbMOTrKEJ91geMGasu
 UBtEUxV4z/mO8zZAfOMpbECjGTagjniZVm+NPaMMSABAAA=
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
 Inochi Amaoto <inochiama@outlook.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: thomas.bonnefille@bootlin.com

This patchset adds initial ADC support for Sophgo SoC. This driver can
work with or without interrupt and in "Active" and "No-Die" domains
depending on if a clock is provided.

Link: https://github.com/sophgo/sophgo-doc/releases/download/sg2002-trm-v1.0/sg2002_trm_en.pdf

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
Changes in v4:
- Lowercase register hexadecimal value in dts
- Reorder properties in dts
- Use only a const in the compatible property of the device tree bindings
- Specify the series of SoC in the driver to avoid confusing with other
  Sophgo SoCs
- Add channel description in the bindings
- Use FIELD_PREP in the default configuration
- Index channels from 0
- Return PTR_ERR instead of IS_ERR
- Link to v3: https://lore.kernel.org/r/20240731-sg2002-adc-v3-0-5ac40a518c0a@bootlin.com

Changes in v3:
- Subdivide default cycle configuration into multiple elementary
  configurations
- Fix formatting in the driver
- Use devm_mutex_init
- Use devm_clk_get_enabled now because the clock is no more optional
- Remove handling of Saradc in No-Die Domain as RTC isn't implemented yet
- Use cv1800-saradc as default compatible instead of a wildcard
- Link to v2: https://lore.kernel.org/r/20240705-sg2002-adc-v2-0-83428c20a9b2@bootlin.com

Changes in v2:
- Drop modifications in MAINTAINERS file
- Rename the ADC from "sophgo-adc" to "sophgo-cv18xx-adc" to avoid
  conflict with ADCs available in future Sophgo SoCs.
- Reorder nodes in DT to match DTS coding style
- Switch from including <linux/of.h> to <linux/mod_devicetable.h>
- Use scoped_guard instead of mutex_lock/unlock
- Check IRQ Status in the handler
- Change IIO device name
- Use devm_clk_get_optional_enabled instead of a clock variable
- Init completion before the IRQ request
- Removed unnecessary iio_info structure in the private data of the
  driver
- Use SoC specific compatible in the bindings and device trees
- Link to v1: https://lore.kernel.org/r/20240702-sg2002-adc-v1-0-ac66e076a756@bootlin.com

---
Thomas Bonnefille (3):
      dt-bindings: iio: adc: sophgo,cv18xx-saradc.yaml: Add Sophgo CV18XX SARADC binding
      iio: adc: sophgo-saradc: Add driver for Sophgo CV18XX series SARADC
      riscv: dts: sophgo: Add SARADC description for Sophgo CV18XX

 .../bindings/iio/adc/sophgo,cv18xx-saradc.yaml     |  85 +++++++++
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi             |  20 ++
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/sophgo-cv18xx-adc.c                | 208 +++++++++++++++++++++
 5 files changed, 324 insertions(+)
---
base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
change-id: 20240527-sg2002-adc-924b862cd3f2

Best regards,
-- 
Thomas Bonnefille <thomas.bonnefille@bootlin.com>


