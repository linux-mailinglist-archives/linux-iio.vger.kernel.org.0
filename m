Return-Path: <linux-iio+bounces-27963-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4058CD3AC85
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 15:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6306D301F76E
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 14:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDC437F0F3;
	Mon, 19 Jan 2026 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GagMSqmA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442533596F5;
	Mon, 19 Jan 2026 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768833450; cv=none; b=B0bs1IedLr8Tqd+evh+V5savxGU/KsNizuYVkpPGx+T5OIe7GfanDOzdb0UgaIppePc0r3NZj+bUQ5Lb0aRLiJO1whvQME2HmRnba+ps7UiCqR94XFscRu17d7GCyEhADDZSm+WryG1BS6KvZIFl5XsEqdMvkrbjGvQhfH68lkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768833450; c=relaxed/simple;
	bh=dwwTpaKA7gIHT3p11HWy39HHGkQKNmQErjgBN0eXz+Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Wyg6PRLIfjK+gJnOjGW6La+OBHVoel/b6/USA83bQysp1HT7VHZjdayzkgBcs93NK22VMMVuu6Nf9sm1DiBT0S1qOaTMkTrjBER29ZDwDT1+fvw5rwBhPu264zlg7Vg1FqtDhmlnJLuuLnEJJ6E6QYtZBZq6GPYYs9SFTzPpJkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GagMSqmA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E33B7C116C6;
	Mon, 19 Jan 2026 14:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768833450;
	bh=dwwTpaKA7gIHT3p11HWy39HHGkQKNmQErjgBN0eXz+Q=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=GagMSqmA+0TmmaneCSNcjSO7yIEvefS8HknztquIBgEf5PyRUQkvLXafiydwnSUCI
	 3fV3R2VdKt4kFiXzKq7iuPlO+dkwbtP3mfsyuV3umWYcRMv1z6Hw3LamIzq9Ay9eCS
	 FLOnvvBkjYki7PtfibU3HdV1ssuyH+Nr+7c9vLH+4KibLpzMt0KUMfD7tne+eEQBch
	 AWt7fjJmWbaS9cjgUMnTU/IcPKNH48kUKJf/CDlFImg9iisfZI22NyeCDVfqBV93GI
	 9qugh8gRbF6ntAOqHsrp8ZAAU5oUFu0IMrgwSAHC06CEBldB8xiqJUCNlywqtDQwt6
	 33RZkdZLX7Alg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FE7D29C32;
	Mon, 19 Jan 2026 14:37:29 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH 0/7] iio: amplifiers: ad8366: driver update and dt support
Date: Mon, 19 Jan 2026 14:36:54 +0000
Message-Id: <20260119-iio-ad8366-update-v1-0-8044e23e964a@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIZBbmkC/x3MQQqAIBBA0avErBtIQ4muEi1GnWo2KVoRRHdPW
 r7F/w8UzsIFxuaBzJcUiXuFahvwG+0ro4Rq0J02SmmFIhEpDL21eKZAB6Ox5MibwTlPULuUeZH
 7f07z+345fOTvYwAAAA==
X-Change-ID: 20251121-iio-ad8366-update-56abac58bbca
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768833448; l=1845;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=dwwTpaKA7gIHT3p11HWy39HHGkQKNmQErjgBN0eXz+Q=;
 b=LwuV+V5aYEDkwYsj9rglG1B7ZsDII5mtBFR12tzQcMRm+1C2kxTWOxd6djNG598KOCIjXorFu
 jL2l9tl6Fn1Brj93UiGuB2mdUsEEK5clqbTsMtC9fUla2TZjjahuTTT
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

This patch series updates the AD8366 amplifier/attenuator driver with
modern resource management, including support for additional device
variants.

Device Support Expansion:
- Adds support for multiple digital step attenuators:
- ADRF5720: 0.5 dB LSB, 6-Bit, Digital Attenuator, 9 kHz to 40 GHz
- ADRF5730: 0.5 dB LSB, 6-Bit, Digital Attenuator, 100 MHz to 40 GHz
- ADRF5731: 2 dB LSB, 4-Bit, Digital Attenuator, 100 MHz to 40 GHz
- HMC271A: 1 dB LSB, 5-bit, Digital Attenuator, 0.7 - 3.7 GHz
- HMC1018A: 1.0 dB LSB GaAs MMIC 5-BIT DIGITAL ATTENUATOR, 0.1 - 30 GHz
- HMC1019A: 0.5 dB LSB GaAs MMIC 5-BIT DIGITAL ATTENUATOR, 0.1 - 30 GHz

Device Tree Support:
- Adds device tree binding documentation
- Adds device tree compatible strings for all supported devices
- Favor chip info tables over device type.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
Rodrigo Alencar (7):
      MAINTAINERS: Add missing maintainer entry for AD8366 driver
      dt-bindings: iio: amplifiers: Add AD8366 support
      iio: amplifiers: ad8366: consume enable gpio for applicable parts
      iio: amplifiers: ad8366: Update device support
      iio: amplifiers: ad8366: use cleanup.h mutex guard
      iio: amplifiers: ad8366: simplify resource management
      iio: amplifiers: ad8366: add device tree support

 .../bindings/iio/amplifiers/adi,ad8366.yaml        |  85 +++++
 MAINTAINERS                                        |   9 +
 drivers/iio/amplifiers/Kconfig                     |   6 +
 drivers/iio/amplifiers/ad8366.c                    | 351 +++++++++++----------
 4 files changed, 285 insertions(+), 166 deletions(-)
---
base-commit: c30e80d68a7afb334fde7147ee0106f25dd58d3a
change-id: 20251121-iio-ad8366-update-56abac58bbca

Best regards,
-- 
Rodrigo Alencar <rodrigo.alencar@analog.com>



