Return-Path: <linux-iio+bounces-25094-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BF3BDF09E
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 16:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC59425850
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 14:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E7D27F754;
	Wed, 15 Oct 2025 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Fmlw7dH8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A740726A08C;
	Wed, 15 Oct 2025 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760538599; cv=none; b=s8TLe78OXcJfZWcSO2CHdQ+uxZmskPsIdGOTbx1yZK/wqXl5vvo5lfXEEIv1kMBSQSkjbrWSK4slfxV1vAU+xFk58W7XEZIjKou6GjBWyMxBihfo43TIam81om65ozdLVGaFKwbUsXJPzm6jEVJErCCvBKDA8tWZYqjsiwacff0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760538599; c=relaxed/simple;
	bh=6K4hGejioGprPo8ya0KxUvTCK94w5AQCZ8nqBGW2WiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DQ7nopkG/AWGGz4fxbvVX3XOdIvkEUJp/oLPLkxMNH0Qtg7isIizPxJhciD7GtiHToxCsbb1qy+oAxaxE/tNYPZZThLvX5D610YJ3awImOrUyhxdNEd3kfSftmn/f8b7FM8ue+1M2tI+mc8Zg8wNtuDTKKwWcBew+fvm7S45jLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Fmlw7dH8; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E01A81A13D6;
	Wed, 15 Oct 2025 14:29:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AC653606F9;
	Wed, 15 Oct 2025 14:29:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 83CFD102F22BC;
	Wed, 15 Oct 2025 16:29:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760538593; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=QDtzpQmFLoPX3YynFoA/DirpAotzpRiBOpzPBhtRqaA=;
	b=Fmlw7dH8tDXSOEA/YQymNzdnpSQQ1tQtBbe43Z01ToaqZ+Mo58w67e/ZcrncGFx6S5JcJR
	yPCbcQE5JMhgNe1kvXvkW25faFFEuMZsopGYp5MbnDnDZhu3yDMrWMb8puggIQBju97M/+
	Zmh3dahQx9Zi6qCmRP9auIKJuOuZJvb3sKvWyoLjo2lTdnbY8hZsASfUFmyBxjb5B+gJNS
	QKnS89qnsiaNyeSY4wvmh3JTMr0eYUSbCGieQVRwvt51w9lte/Ql7Aia3h9CR+cWuJkxhD
	NqOe5O1lgO77rVWzRMBY9JHTIfV4ZiQtid6Fb/c9zDO1DXiWQSoF8cdklTxRtg==
From: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pascal Eberhard <pascal.eberhard@se.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 0/4] Add support for the Renesas RZ/N1 ADC
Date: Wed, 15 Oct 2025 16:28:12 +0200
Message-ID: <20251015142816.1274605-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

The Renesas RZ/N1 ADC controller is the ADC controller available in the
Renesas RZ/N1 SoCs family.

It can use up to two internal ACD cores (ADC1 and ADC2) those internal
cores are handled through ADC controller virtual channels.

Best regards,
Herve Codina

Herve Codina (Schneider Electric) (4):
  dt-bindings: iio: adc: Add the Renesas RZ/N1 ADC
  iio: adc: Add support for the Renesas RZ/N1 ADC
  ARM: dts: renesas: r9a06g032: Add the ADC device
  MAINTAINERS: Add the Renesas RZ/N1 ADC driver entry

 .../bindings/iio/adc/renesas,rzn1-adc.yaml    | 120 ++++
 MAINTAINERS                                   |   8 +
 arch/arm/boot/dts/renesas/r9a06g032.dtsi      |  10 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/rzn1-adc.c                    | 626 ++++++++++++++++++
 6 files changed, 775 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,rzn1-adc.yaml
 create mode 100644 drivers/iio/adc/rzn1-adc.c

-- 
2.51.0


