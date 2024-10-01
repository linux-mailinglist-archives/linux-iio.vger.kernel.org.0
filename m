Return-Path: <linux-iio+bounces-9948-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE94198B5FE
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 09:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B65A1C21DD6
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 07:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5565C1BDAAB;
	Tue,  1 Oct 2024 07:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eoPs3q2X"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A381BDA9A;
	Tue,  1 Oct 2024 07:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727768788; cv=none; b=sFOMFN5SsKDqjNnSUwVXXh7wYTJ2AFJrXAtTJV9u8ujBCkSd94RsqEprSR9iZbIPMys1LeraEzXWo603GkYGHUp+cdbdExC56FbOhs8l/0522TSXqH7BVstzVe0aEp6kBGO0UDS3hmX7JnegX1piNdGqY+huSEAal1spT18eTe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727768788; c=relaxed/simple;
	bh=ghLCz8Tyz8K0aUocQgwa7+S6jrmvt8Rh/LopHBOVzKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GJb9MRjQ2BuSwmV2mYPlPjAhRGkzrlaoeJWwz3dLK5wLhbVMSpnwfvClyIlvTYOjIVuiFCgEoKyBaAyN6ruc0prXz6kYk4ka4InHSHTthH9azJB033zn0UbrcaWLn96TxCujrsSaODAbnknqMSaXg3eiq4KFPJxxWq75Sb0IrPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eoPs3q2X; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id CD2496000C;
	Tue,  1 Oct 2024 07:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727768783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3P5G11Gjk4DFFXij9ZL5IMVFSMrbo1y85Zod+UaGUBA=;
	b=eoPs3q2XV5ATH5ce4c25WlK1EZ/ENwZwtmp/nnnAKkETa90+Va4LgImtUkuyaMP5P3VhJx
	fSN2QX3xRATn4pwEqkl5NrE+Imd04HQxx+UZBkgxKKwmY5osfInMIcG/vCp19J3r62yh/9
	TlFgPvqdpReaCDCRNH94DXZZvgkTCWGhcA4Sp5D/G67UC7bkVb80RmnhoTcti+xz5KH+Mw
	aIWNYR362MoniKxnRiE3bjMryZ7i7hDI2OBBLnHH5SVUS8UpElFWSXnaJIKXjJ4dlja/XS
	94WfxRIVPfXM/9ughJHMQodrxH8QOHZ+gqJRhpSbZ7Ucw7gY+72BQiKZARL3Ig==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
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
Subject: [PATCH 0/4] Add support for the GE HealthCare PMC ADC
Date: Tue,  1 Oct 2024 09:46:14 +0200
Message-ID: <20241001074618.350785-1-herve.codina@bootlin.com>
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

Best regards,
Herve Codina

Herve Codina (4):
  dt-bindings: vendor-prefixes: Add an entry for GE HealthCare
  dt-bindings: iio: adc: Add the GE HealthCare PMC ADC
  iio: adc: Add support for the GE HealthCare PMC ADC
  MAINTAINERS: add the GE HealthCare PMC ADC driver entry

 .../bindings/iio/adc/gehc,pmc-adc.yaml        |  82 ++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/gehc-pmc-adc.c                | 233 ++++++++++++++++++
 include/dt-bindings/iio/adc/gehc,pmc-adc.h    |  10 +
 7 files changed, 346 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/gehc,pmc-adc.yaml
 create mode 100644 drivers/iio/adc/gehc-pmc-adc.c
 create mode 100644 include/dt-bindings/iio/adc/gehc,pmc-adc.h

-- 
2.46.1


