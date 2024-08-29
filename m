Return-Path: <linux-iio+bounces-8864-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E4596447B
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 14:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42CDC1F263F8
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 12:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8F819885D;
	Thu, 29 Aug 2024 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TTagIQIT"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99C218C35B;
	Thu, 29 Aug 2024 12:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934729; cv=none; b=FxvY1wQ+X10ocFveTeGmxNxHG/2Xm5wWCGC3/30pejCk7g/IPFyYYcZECucYPEqHHekNs5g53uAgvFOPjlHnOTDysmnEnFjAu0J0w8ht3sfXmiIiWQ+vgZEHSDpXcUlXv/gSxrM3TjyGSgioveAiIPI1lIH5CLdZJ5V/5xyCFI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934729; c=relaxed/simple;
	bh=AxUYagKzS0M34P1LwO3B0M/v+bfZjDJYTAgL979ou/0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=geYXkMONRXC2N+nhECP1Jip4TxFnBCzlQ7/mqcnYdjaEFk1389qVSjR+oVOLRxg+2AkWRfQCR3VClf46nT7NzujwtR7siSIHNSrHDhTnTJYa8uWU2kzHUIYAVPKcn1drdXKcXasHHLpv+hs2L6gv/UMil7mFFGlsJ4bGFBCgV70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TTagIQIT; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E622B1C0004;
	Thu, 29 Aug 2024 12:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724934723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OxfsV/iIio6m392vSk+A+q8P71V8n5mUkMrGc4zlCY8=;
	b=TTagIQITvw23bb+4HNuxTi1+1mMWcZN+sDyZErMKmaeb3GwP502QISJSOpHYbf++++WmAP
	MKeaUAqrFWxvI3yS4gzRai6p8GX+jBSz3YM3u1xPeOesrhkuPRUgsG7n6LQLzvbBIurBXi
	UdKn6rVR6HY/PXTvJxPJZ6ZqtDyR8Zyswpd38YYLFHchmfW9AEGmJTLm0crgKyIsuO7Gjr
	smNpWwS7S45UpECdPBtqUkTBUCULP0tBtq4oDel2kT9bKVHz7x9buP4xj10Az2gV9M1DP4
	dhH7ptUPiGJsPJd0t14Hvhm2ln/TkY52YIYxQ9j4obgv0VKLzkAfS35NLfqi2g==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Subject: [PATCH v5 0/3] Add SARADC support on Sophgo CV18XX series
Date: Thu, 29 Aug 2024 14:31:49 +0200
Message-Id: <20240829-sg2002-adc-v5-0-aacb381e869b@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADVq0GYC/2XOTQrCMBCG4atI1kYmk39X3kNcJGmqAW2kKUWR3
 t1UF7a4/Aael3mREvsUC9lvXqSPYyopd3XI7YaEi+vOkaamboKAAiRqWs4IgNQ1gVoU3igMDW+
 RVHDvY5sen9jxVPcllSH3z097ZPP1m9HVLzIjo0BdUCqCVk5LdfA5D9fU7UK+kTk04hLLFcaKD
 RdoAoKzHv8xX2DOVphXLF0Q4CQzAdw/Fj9s2PptMWNrfeOVlhbbNZ6m6Q3ugGDpXQEAAA==
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

This patchset adds initial ADC support for Sophgo CV18XX series SoC. This driver can
work with or without interrupt.

Link: https://github.com/sophgo/sophgo-doc/releases/download/sg2002-trm-v1.0/sg2002_trm_en.pdf

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
Changes in v5:
- Add the ability to read the sample frequency
- Edit commit message to remove No-Die reference and add precision on
  the ADC series
- Rename binding and driver file to match compatible
- Reformat the channel property in the binding
- Clean driver code
- Link to v4: https://lore.kernel.org/r/20240812-sg2002-adc-v4-0-599bdb67592f@bootlin.com

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
- Remove platform_set_drvdata as it wasn't used
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
      dt-bindings: iio: adc: sophgo,cv1800b-saradc: Add Sophgo CV1800B SARADC
      iio: adc: sophgo-saradc: Add driver for Sophgo CV1800B SARADC
      riscv: dts: sophgo: Add SARADC description for Sophgo CV1800B

 .../bindings/iio/adc/sophgo,cv1800b-saradc.yaml    |  83 ++++++++
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi             |  22 +++
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/sophgo-cv1800b-adc.c               | 218 +++++++++++++++++++++
 5 files changed, 334 insertions(+)
---
base-commit: 5be63fc19fcaa4c236b307420483578a56986a37
change-id: 20240527-sg2002-adc-924b862cd3f2

Best regards,
-- 
Thomas Bonnefille <thomas.bonnefille@bootlin.com>


