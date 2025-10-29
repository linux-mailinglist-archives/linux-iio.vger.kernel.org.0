Return-Path: <linux-iio+bounces-25620-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C9DC1BBE3
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 16:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D7494F4DD8
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 14:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E045346A19;
	Wed, 29 Oct 2025 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="e94+/JS3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A86732570B;
	Wed, 29 Oct 2025 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749234; cv=none; b=ILrVGmGC6J5ZgcLKlYbe9bkX9Zy7tutdeLPKPsu8Lzl7ccUX4fuqQlYkYJWKS2KVRQ6wsSUEJ8jNh1Q/jHceopxiscIhVeg4JtoGsglvjwwYzIL3sN5Pe+dmGuJTzvyG0yQIbQ+fZXBGuVw4GxijX17+kbm1y1KI8QZmb8An+D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749234; c=relaxed/simple;
	bh=SJYleUZaoyn5JK4o33oSWeOEvviFeuT9HgdwPb4wSrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sak/lsRtSeSegnof1jtE5Iq7gmxfB5lLx7WNNX+BGore7SgcnDAnijpbe7A2qKZkiCYS+kRbqomahUzvhVaW0XsH14MWrkPJiKHNQvDD2JpN/qVX0EfxzBC22fqwcuaHdOFj/SiwmBO+q4DUzBnkt0x7XDBTRivnXx5Sh5xLfu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=e94+/JS3; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 38B9FC0DA83;
	Wed, 29 Oct 2025 14:46:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 848DD606E8;
	Wed, 29 Oct 2025 14:47:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 817CA102F24F9;
	Wed, 29 Oct 2025 15:47:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761749228; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=lhxyx3v6DA24a57QwH/fHNlyw7nDkFupsKGcsioXRTY=;
	b=e94+/JS3+oQoYVE4PqzSqK/Wh07gs4jkbQwVJXJHXrm+8vfcCxDlMiqv1/UN0gSeab1NHt
	37p3lLDyFvqP6KnxZGz2EKFNbBlW+ym+T5ptJ3EGa1NZqVe2RMEAZdNiO9r5RBIIdhjtuY
	PBq6IuMOUmhvk9JAsTODUTgNEy/3PuFlL8zNFvQbdgfnCZwUcx9cqP8pdlkKW5vKv8zKkp
	ZWcRjgc0AhmRCw7L5p4NhRsfm0r+P2M12I5kJllOA12usJ3M/zdkjHgYbjSjxCJTsQ9Wg2
	M/c9kiLj64s014GyNTsYEWI3Sp/jezYcyYhbg536cpwUtkHCC1GSdWY31JwE6Q==
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
Subject: [PATCH v2 0/4] Add support for the Renesas RZ/N1 ADC
Date: Wed, 29 Oct 2025 15:46:40 +0100
Message-ID: <20251029144644.667561-1-herve.codina@bootlin.com>
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

It can use up to two internal ADC cores (ADC1 and ADC2) those internal
cores are handled through ADC controller virtual channels.

Best regards,
Herve Codina

Changes v1 -> v2:

v1: https://lore.kernel.org/lkml/20251015142816.1274605-1-herve.codina@bootlin.com/

  Rebase on top of v6.18-rc3 to have commit db82b8dbf5f0 ("PM: runtime:
  Fix conditional guard definitions")

  Patch 1:
    - Remove unneeded 'dependencies' part.
    - Rename "adc-clk" clock to "adc".
    - Move 'additionalProperties: false' just before the example.
    - Use const instead of enum for the "renesas,r9a06g032-adc"
      compatible string.
    - Fix the ACD typo.

  Patch 2:
    - Fix the ACD typo.
    - Rename "adc-clk" clock to "adc".
    - Update included headers and sort them.
    - Align register definitions at the same column.
    - Inline the FIELD_GET() instead of having macros.
    - Introduce RZN1_ADC_NO_CHANNEL
    - Get Vref voltage value at probe().
    - Remove the bitmap in rzn1_adc_set_iio_dev_channels().
    - Use dev_err_probe() in rzn1_adc_set_iio_dev_channels().
    - Use auto-cleanup variant for PM runtime "resume and get".
    - Use scoped_guard() for mutex.
    - Use devm_mutex_init().
    - Use the fixed "rzn1-adc" string for indio_dev->name.
    - Use DEFINE_RUNTIME_DEV_PM_OPS().
    - Fix rzn1_adc_of_match table and remove of_match_ptr().
    - Add a comment related to decoupling between IIO chans and ADC1 or
      ADC2 core chans
    - Update and add several comments related to ADC core usage and the
      relationship with ADC core regulator presence.
    - Remove clocks and regulators handling from PM runtime
      suspend()/remove().
    - Simplify the driver removing the no more relevant struct
      rzn1_adc_core.

  Patch 3:
    - Rename "adc-clk" clock to "adc".
    - Add 'Reviewed-by: Wolfram Sang'

  Patch 4
    - Removed the linux-iio list

Herve Codina (Schneider Electric) (4):
  dt-bindings: iio: adc: Add the Renesas RZ/N1 ADC
  iio: adc: Add support for the Renesas RZ/N1 ADC
  ARM: dts: renesas: r9a06g032: Add the ADC device
  MAINTAINERS: Add the Renesas RZ/N1 ADC driver entry

 .../bindings/iio/adc/renesas,rzn1-adc.yaml    | 111 ++++
 MAINTAINERS                                   |   7 +
 arch/arm/boot/dts/renesas/r9a06g032.dtsi      |  10 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/rzn1-adc.c                    | 493 ++++++++++++++++++
 6 files changed, 632 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,rzn1-adc.yaml
 create mode 100644 drivers/iio/adc/rzn1-adc.c

-- 
2.51.0


