Return-Path: <linux-iio+bounces-25845-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A2DC2C66B
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 15:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F363A7F9A
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 14:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3BA3101C9;
	Mon,  3 Nov 2025 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pXn7t8Sa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F58530E827;
	Mon,  3 Nov 2025 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762179580; cv=none; b=V5dT9KFOGC7Kfn7nlQWQDNIen/no/Wh4YYCLmtH5DrSiWbcjlYKnFEHHkUEFnppuu0P6zMOCXr2Ok/QRQv3ueVuvwDuT3lScNKjeIVGyJbCwnBNU2WurCZu7Hx/U4kfq0zrF4uufWzmSAc0aAsBsZbq9du2N4zf9NO3HPElRfWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762179580; c=relaxed/simple;
	bh=9NiifvQJi8D1KvjCjQtiU4LSXpQp9V0YKrqUXTw7HDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iYM6/RM/BdhdbW4buYjA/3mxZSoac5kgcii+9tqxblvUlksRiYDdBvn3UK1GTpmAPJbSC1YTOwyfR+6hYg+vglbhHPJSz41Q1bDlmuEZirh0iJdqsRFjsQipsfbflQA2SxX5WWkTPXkYdaL9cYqtnhubd965jRj9F6JRO7q0ps4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pXn7t8Sa; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E63F5C0D7AB;
	Mon,  3 Nov 2025 14:19:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A20EE60628;
	Mon,  3 Nov 2025 14:19:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4068310B50120;
	Mon,  3 Nov 2025 15:19:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762179574; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=IUwcGtE/38Ac68OwdWyQjp0g7+BDVo54gGgBsB+Ixrc=;
	b=pXn7t8SaZk1pj8aMpOpnGjVSQpfL/F0eUznTpgzzpQHiAoNq1AQtoEjsA8C3XvxNPcKo2U
	NG+kkHKUyr48pQ15jPdyKHKnww7OyGH12JYV3auzyG8dGDX9jGrh50sRoZWb0ab+6kxqkO
	5r6G08UwbV58XZTYP281dKE51UgIP0fSQN+US5V9Ve1FWgMevB7udPkJX5LVtF66OKIjBH
	9wgXfnMm5UNETRXl12BgyJtx/7K8lE2uOzhIBP/wa4guqe+sOd2Qx/bNdraAfQGdBaJtc8
	4NkQ+mUlOOErOk/XcUDxACY8OZqU0G0Z+S8FVm3SRmT1jNwjcqu+JW72tdrRgA==
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
Subject: [PATCH v3 0/4] Add support for the Renesas RZ/N1 ADC
Date: Mon,  3 Nov 2025 15:18:30 +0100
Message-ID: <20251103141834.71677-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

The Renesas RZ/N1 ADC controller is the ADC controller available in the
Renesas RZ/N1 SoCs family.

It can use up to two internal ADC cores (ADC1 and ADC2) those internal
cores are handled through ADC controller virtual channels.

Best regards,
Herve Codina

Changes v2 -> v3:

v2: https://lore.kernel.org/lkml/20251029144644.667561-1-herve.codina@bootlin.com/

  Patch 1:
    - Add 'Reviewed-by: Rob Herring'.

  Patch 2:
    - Add missing header files.
    - Use fixed-width values for register definitions.
    - Split comments and remove a redundant 'else'.
    - Return the error in the 'switch case' default statement.
    - Leave a trailing comma in struct iio_info.
    - Move *_vref_mv to *_vref_mV.
    - Split the DEFINE_RUNTIME_DEV_PM_OPS().
    - Update error code handling in rzn1_adc_core_get_regulators().
    - Pass rzn1_adc in platform_set_drvdata(), update suspend/resume
      function accordingly.
    - Add 'Reviewed-by: Nuno Sá'

  Patches 3 and 4:
    No change.

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
 drivers/iio/adc/rzn1-adc.c                    | 490 ++++++++++++++++++
 6 files changed, 629 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,rzn1-adc.yaml
 create mode 100644 drivers/iio/adc/rzn1-adc.c

-- 
2.51.0


