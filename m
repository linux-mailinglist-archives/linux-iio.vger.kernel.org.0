Return-Path: <linux-iio+bounces-8090-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE98C942E57
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 14:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CB211F25413
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 12:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79A11B013C;
	Wed, 31 Jul 2024 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="K+Iw48id"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580E71AE85F;
	Wed, 31 Jul 2024 12:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722428664; cv=none; b=mbAdNlnfHHXtsuwjNlIOhmlCBFPQZqWCcbtHPgWLmHY3iaVjunsCH+qxAGRKTitR85oa3mRcyFoPrgMnHSPd1/AX3D+WGO45A7WWJWtQ+J/gcON05LM+yH0yKHrfmBYiCHS93FVabrjCFcUpcjKooJx7QYc5jY2vhBp8zZV0l2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722428664; c=relaxed/simple;
	bh=+NkzxjBsJOkCqsizbjE1T0A6ej8JzZ+9q99YEFJaOmo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eNa/5siMcovBL2Gzsy65cCOrwgbQW+w0Q2C7dvG8iwP+YqfaCfBfzNGvv4esviwmH/F1Jo4KPbIo32raFiU67rQ2W5Gs5uD3td5jvhI1InfVuTQimf2P8Bg0pZBgabX7Iapv4Mb2RlLkNLLpmx14XgMW7gIKwFNr7ekpwJGCLck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=K+Iw48id; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E8606FF80C;
	Wed, 31 Jul 2024 12:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722428659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CQFWrGva3clQlCQc7BZ8s/egQF3wtTwTvc9/iqLjWy4=;
	b=K+Iw48idA4k/otIFWKoKPOvX074b6yGoI6xQ0KgQflh44gXLbdjQHBlvvIoBQUys3zL92Y
	uzSGNhWvpXNX1/jSaV3+w1o+u54WwMb5jEo2uGWsbY65Zijur8s09Am+CV1T9jh+uhy/Zd
	NmUSshKHxqVqQJr3lq3akP3RQjUIBaoGths2rluQiAWyGpyI0TPp2OWCqKmi84R0uld/Si
	TAB0xGt2ptWmz5Ic8SPhqHvQPvjsVGje8qjQiY1IYnX7YRvRAeo4lJYb3s5aUd399lkqOu
	DBF+7LTyPYQBJxnIaPinK1Q0vIVmo/iVVgnPcsGutiQdbyjUFbv3fAhUuAwqxA==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Subject: [PATCH v3 0/3] Add SARADC support on Sophgo SoC
Date: Wed, 31 Jul 2024 14:24:13 +0200
Message-Id: <20240731-sg2002-adc-v3-0-5ac40a518c0a@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO0sqmYC/1XMQQ6CMBCF4auQWVszDtCCK+9hXJRSYBKlpiWNh
 nB3C25g+V7y/TME69kGuGYzeBs5sBvTyE8ZmEGPvRXcpg2EVGBJSoSeEEno1oiaiqaSZNq8I0j
 g7W3Hny12f6Q9cJic/27teFnff0Ylv8vEi0ChjZQWldSqlLfGuenJ49m4F6yhSHtcHjAlXOUFV
 YZQ1w0d8bIsP0f/pqLjAAAA
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
      dt-bindings: iio: adc: sophgo,cv18xx-saradc.yaml: Add Sophgo SARADC binding documentation
      iio: adc: sophgo-saradc: Add driver for Sophgo SARADC
      riscv: dts: sophgo: Add SARADC description

 .../bindings/iio/adc/sophgo,cv18xx-saradc.yaml     |  48 +++++
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi             |   8 +
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/sophgo-cv18xx-adc.c                | 206 +++++++++++++++++++++
 5 files changed, 273 insertions(+)
---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240527-sg2002-adc-924b862cd3f2

Best regards,
-- 
Thomas Bonnefille <thomas.bonnefille@bootlin.com>


