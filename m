Return-Path: <linux-iio+bounces-10026-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6A298EE63
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 13:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8991F232BE
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 11:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95C4155C94;
	Thu,  3 Oct 2024 11:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IJb+oSGf"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B91213D245;
	Thu,  3 Oct 2024 11:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727956009; cv=none; b=ibM5rA8H4+kKhFxLKeujK93dlC+Ofv+d806kpEh0/iJLySvTO8GjXQ9Gs+MP3eCb/gYEoMs3TnM4J5bsA513UOR1hrKvX8pmOd0qnJ6k4BOW4IfbESket2Ijgqv+6ei/aVz4LwLH3xe8dyaaauIhM3KUM4QKLm2hOdAkgR273S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727956009; c=relaxed/simple;
	bh=qJjNmjKDHb6WVPkylAOGLdvisVk70N6aiJ6nCK0+88U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TCL3mpEGv8KXmM9l2/otLbD4F/YIViXozWqSm+nfyGe3mEcvlZ+mc/VbcICcwja2XREE279W14frvShJFeBNX5HL4vJUOW01F+yEPXxfvzpk64oZcH1istpztfuLk+F19JCneWXNyMHMlrPvZnkI467NLKRvHZ18Clwdnns0NH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IJb+oSGf; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id DED7FC0002;
	Thu,  3 Oct 2024 11:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727956004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pARedIXKgyoxaKrVbEhoCIxqzLG71ZV23YjcFZPbA0E=;
	b=IJb+oSGfuOsHfD2jXJCKF0ty6j4nEuYgXwiwaYajLS7Pk11sjByVDZkgbup40eZbV6XzXF
	gcLDrNTY7TqguBABo+jcPg7ol4wedWMKm/0WlQR2hMl6D0/XINiH83UPrOH9cyeZEaHgiU
	tM7i79tUuH5kJkgRs79hj2uUBA2Kqn91V7kAyEd3LYUH9aHBMFg68Ew1BVUHEyMVIjf7bX
	sPVD4rjN0rNnCDv0tBd5isvIa3wXEMn09qI4kkGgnmZVD/XD4HtzjX4I0cvVqLDfioPqPB
	jZaLQZZEmXL4M8pEokOEewYvOgiffD304ex/vF/0rPr8+14Fd3S/Y4+p7bM5tg==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Ian Ray <ian.ray@gehealthcare.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 0/4] Add support for the GE HealthCare PMC ADC
Date: Thu,  3 Oct 2024 13:46:37 +0200
Message-ID: <20241003114641.672086-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi,

The GE HealthCare PMC Analog to Digital Converter (ADC) is a 16-Channel
voltage and current, 16-Bit ADC with an I2C Interface.

Compare to the previous iteration, this v2 series mainly:
  - Add a description in the binding
  - Fixed sign_extend32() parameter
  - Use dev_err_probe()
  - Remove scale and use processed channels

Best regards,
Herve Codina

Changes v1 -> v2
  v1: https://lore.kernel.org/lkml/20241001074618.350785-1-herve.codina@bootlin.com/

  - Patch 1
    Add 'Acked-by: Conor Dooley <conor.dooley@microchip.com>'

  - Patch 2
    Add a desccription for the 'osc' clock.

  - Patch 3
    Replace sign_extend32(ret, 16) by sign_extend32(ret, 15).
    Use dev_err_probe().
    Remove scale and use processed channels as values are read in IIO
    expected unit (mV or mA).

  - Patch 4
    No changes

Herve Codina (4):
  dt-bindings: vendor-prefixes: Add an entry for GE HealthCare
  dt-bindings: iio: adc: Add the GE HealthCare PMC ADC
  iio: adc: Add support for the GE HealthCare PMC ADC
  MAINTAINERS: add the GE HealthCare PMC ADC driver entry

 .../bindings/iio/adc/gehc,pmc-adc.yaml        |  86 +++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/gehc-pmc-adc.c                | 227 ++++++++++++++++++
 include/dt-bindings/iio/adc/gehc,pmc-adc.h    |  10 +
 7 files changed, 344 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/gehc,pmc-adc.yaml
 create mode 100644 drivers/iio/adc/gehc-pmc-adc.c
 create mode 100644 include/dt-bindings/iio/adc/gehc,pmc-adc.h

-- 
2.46.1


