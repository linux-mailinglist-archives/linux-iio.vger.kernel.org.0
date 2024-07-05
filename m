Return-Path: <linux-iio+bounces-7360-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F979289F8
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 15:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41DFF1F23650
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 13:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989C1154C11;
	Fri,  5 Jul 2024 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Cw5RLp4F"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A0115381B;
	Fri,  5 Jul 2024 13:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186955; cv=none; b=fplvmlTADMWw7ttqz9pCbfwuJb01U7wZnKzOpMT/6hujs1h2v6ayPFwEjvxa7NunkU8jAWprlhFUdUdCSGDjdQ6Ox9qsr7lLUDiCtQdSERYCV5TDBLC4lYTds5iry4jtBP8LWcJtcL674rz3V10req1OpSAn+8lidskMPOeEjNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186955; c=relaxed/simple;
	bh=FuIt2mgdC/w2VF87WTNDHG4Qzlpt8NFpqXuuHcEXahE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JWJUr/4DtO3xuVMvBI/Sr7XSYD6S9E9xKllANumGNUSnMMmJnIYYplJWIweNET7vmB+r0sKSHFvx29S8yq2MTGNjvfIAE5VlXh5MeqEdIEOLeF2rh4qpkDihzw/roh5HlGEe3QQN4eGGewlRR7M/etXe7CkULTUVVvoZFHpPdJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Cw5RLp4F; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 17F8F24000A;
	Fri,  5 Jul 2024 13:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720186951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JtwzpnUYYLiQKZg/jJnBbMWEqzibWxNiVuSjlyYpAZY=;
	b=Cw5RLp4FJg6Rqepr1HHf4VkotJhfK6s52fJlBwvwkYsT6kWUWUOOH7DAgB14RKFh+P5kEz
	wEDMSCgVi5FMXvdpmv7E0/mBGMPHNSR+5KYUzpxBAPo9fVtwvy4PmYCTF9kI/8dJh1A6KV
	F9i1Guu0CquF7hJZTdokkfvlDVXNup0vTZTIT34IIgnbKClmOKH/dgxv9IcTeWD9ncWGdh
	9Za/zNq4s4pIuWDCQ3r60nQc94TD3mF9OksZVuzDFpWhB5UAc6UDM0oYoAjlPPzJs6uFQO
	YCPCFyAfABMkYJiZxEdPtiyZp53Q2KKdI7dSx+J3YtgCJvmMm8LNBzGzXGalFw==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Subject: [PATCH v2 0/3] Add SARADC support on Sophgo SoC
Date: Fri, 05 Jul 2024 15:42:22 +0200
Message-Id: <20240705-sg2002-adc-v2-0-83428c20a9b2@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD74h2YC/03MQQ6CMBCF4auQWVtTRmjVlfcwLEoZYBJtSUsaD
 endrbhx+b/kfRtECkwRrtUGgRJH9q4EHiqws3ETCR5KA0psZItaxAmlRGEGKy7Y9GeFdjiNCOW
 wBBr5tWP3rvTMcfXhvdup/q4/Rpf/H5NqIYWxSpHUyuhW3Xrv1we7o/VP6HLOH7N9gOymAAAA
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
X-Mailer: b4 0.14.0
X-GND-Sasl: thomas.bonnefille@bootlin.com

This patchset adds initial ADC support for Sophgo SoC. This driver can
work with or without interrupt and in "Active" and "No-Die" domains
depending on if a clock is provided.

Link: https://github.com/sophgo/sophgo-doc/releases/download/sg2002-trm-v1.0/sg2002_trm_en.pdf

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
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
      riscv: dts: sophgo: Add SARADC configuration

 .../bindings/iio/adc/sophgo,cv18xx-saradc.yaml     |  63 +++++++
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi            |   8 +
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi             |  14 ++
 drivers/iio/adc/Kconfig                            |  10 ++
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/sophgo-cv18xx-adc.c                | 195 +++++++++++++++++++++
 6 files changed, 291 insertions(+)
---
base-commit: d20f6b3d747c36889b7ce75ee369182af3decb6b
change-id: 20240527-sg2002-adc-924b862cd3f2

Best regards,
-- 
Thomas Bonnefille <thomas.bonnefille@bootlin.com>


