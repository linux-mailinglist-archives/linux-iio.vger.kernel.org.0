Return-Path: <linux-iio+bounces-27333-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CDCCD9DEB
	for <lists+linux-iio@lfdr.de>; Tue, 23 Dec 2025 16:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F077330084C2
	for <lists+linux-iio@lfdr.de>; Tue, 23 Dec 2025 15:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6B22701CF;
	Tue, 23 Dec 2025 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bEakcnVl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211B61D9663;
	Tue, 23 Dec 2025 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766505351; cv=none; b=CBGghP8j3Ucmrvz8txyCOWCkNEgJsWVNB/7YbKGndaRx9FL7nb4fpTUz8zkqrNN37tu0jOjG5alZlNZb7LP/RAwIEDwPcmbUvvEDgJ4ELziUDge6cizZ4zluHaSEp/+32K22fi7rQW7gsTKEIWtmCzTQgwWn1eDeVujRHVwOtwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766505351; c=relaxed/simple;
	bh=yUYGvgTuhC5BCr5w7y8XuABCLxs2jqzQf+5M2/LR9jE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rWrvxAGiMrPwCOQUIdZJM3aU/fk7IRIjiJzGSuVpxkqBn1rKws/2YDtl7A1e6naxH0r/PuoOChm5EUPj0GUv/FEUf7PWB3B3zP6EksR6xyfISbOMIfO6l/v4kET1ldrC954wpfN2BDDRc/O1zBro0r711+SGiswf8vamokU3Gkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bEakcnVl; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A02EF4E41D52;
	Tue, 23 Dec 2025 15:55:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7219B60716;
	Tue, 23 Dec 2025 15:55:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 25EF810AB0BAE;
	Tue, 23 Dec 2025 16:55:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766505346; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=p7wDoXQ9uFCE9REkUe1YaH5DAcfutXgAy4GZCWM+c6U=;
	b=bEakcnVlCWIwhqv5kTi+Wj0JmUDzx0zKUHljOcIxSd0g4XZJaxJQpXpeJr4f/dnQCQlmpA
	a3DPTIa/pgtR/TE9ibXx88NK4W2AfJgApaxeK4Y1IKTlVSLManE67RnS2Sbp49CxIiaYrC
	mMOaSRLVQF960wx/rQVKkaZ7N+bkK66YpJMGT3txYDfaxTJNNqbVIFiHq/eQnOJ0sUu8LL
	0KdFG6RUeyCaVV7Fhn0f+dkUqcPYYN5riSxY+qISfTIGo53K+6Imus8EY+s7gpTu6GMyRb
	dyUEDXMmhGhNndqLRulGdVTD6QC/wXFYxPCz95XrqNGHtMDW7hm7qra8tauOPg==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	nuno.sa@analog.com,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Angelo Dureghello <adureghello@baylibre.com>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Eason Yang <j2anfernee@gmail.com>,
	Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	duje@dujemihanovic.xyz,
	herve.codina@bootlin.com,
	Rodolfo Giometti <giometti@enneenne.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com
Subject: [PATCH 0/2] Add driver for the TI TLA2528 i2c ADC
Date: Tue, 23 Dec 2025 16:55:31 +0100
Message-ID: <20251223155534.220504-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi everyone,

This series is a resurection of a patch sent by Rodolfo Giometti that
adds support for the Texas Instruments TLA2528 8-channel 12bit ADC
accessed over i2c : [1]

With Rodolfo's permission, I've picked up the driver where it was left,
and made some changes :

 - All reviews that were made by Jonathan back in 2021 were addressed
 - I've updated the way we manage the regulator, using the newer
   devm_regulator_get_enable_read_voltage() helper
 - There was a bit of renaming for internal variables
 - I simplified a bit the probe/remove by using devm_iio_device_register
 - I've added a binding :)

This was tested on a custom board based on imx93, with a 3v3 ref supply.

Thanks Rodolfo for letting me give another shot at getting this driver
upstream, and to all the reviewers and maintainers that were involved in
the first round of reviews a few years ago.

Maxime

[1] : https://lore.kernel.org/linux-iio/20210802130441.972978-1-giometti@enneenne.com/

Maxime Chevallier (2):
  dt-bindings: iio: adc: add Texas Instruments TLA 2528
  iio: adc: add driver for Texas Instruments TLA2528 adc

 .../bindings/iio/adc/ti,tla2528.yaml          |  48 ++++
 MAINTAINERS                                   |   7 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ti-tla2528.c                  | 209 ++++++++++++++++++
 5 files changed, 275 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,tla2528.yaml
 create mode 100644 drivers/iio/adc/ti-tla2528.c

-- 
2.49.0


