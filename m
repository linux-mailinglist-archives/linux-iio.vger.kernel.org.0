Return-Path: <linux-iio+bounces-24429-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9B2B9F48F
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 14:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E171B2710F
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 12:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088301A23B9;
	Thu, 25 Sep 2025 12:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gwbPt65L"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C20282F1;
	Thu, 25 Sep 2025 12:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758803877; cv=none; b=Iyz4CXqu91rwNrtucNuAbFjuhdDcXESV/alv2sW6qqQDsc0ymbu+77LHZjuYJIKJkczlcRemIKqa8zVkGNqqcgZnlLAgLZTiax73asIHA24zmvNeEtPMErRKeaRmLxAIhaLjM2Wjh35WupU4W55k+WhhFYLYVCr7A4N1OAw4Gjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758803877; c=relaxed/simple;
	bh=uJpTwfQeoXhfqX5HGJ5UH/C36Ak30a35D0FJrYV9/VQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pRowJJiTF2W0PiubN2SGCU8CcOd9m498ER7CRilgyleMhu0uq5Gg43xI89GMTRb37I0FlcSuDievBPHf//lveyKdMWeaWcuJ7LmEF0YZLw/wcRW/7M3Oj+xPravaeZM9kPS0/+7JE+GzXBb5MpMimoH8/jAbIu+ckk7X5zCL1Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gwbPt65L; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9C9231A0FCF;
	Thu, 25 Sep 2025 12:37:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 70D366062C;
	Thu, 25 Sep 2025 12:37:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 74EED102F17E6;
	Thu, 25 Sep 2025 14:37:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758803871; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=sOL16npzmbnhBXpX6q4u5OmdL1g7hGCfAy2JMJ9t0DA=;
	b=gwbPt65LpuytZkyBCZRGXliUd8I37qWjorY264kpH4VcowgPHXxJBIPeqFgJeZhCj929Of
	MMe0Gw3Wzb7tbyZVek/S145hBq3fp6Pw1pP36PfZzNqOTgdweTPb12h2EoeYlrBoOVN5F1
	NHLGbwCnUQPZPYmjE2jryswFpSVNmTd8L+/eoI3ObPrlSMtApk35wq+VUY75CSrMsxf2Es
	g1lna+XmwVglBDUELbfgBPEapRw0pFoh/lVgQYrQDrtaYdY7pMWPd7mfWH6hfG71JDJD0k
	7EqXUzg05OcyS6WMtvJ851xZTX6QQOmRL0cu7C5eLNpzaDon4uV2i6Xj+1Y2JA==
From: Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH v2 0/5] Add support for the LTM8054 voltage regulator
Date: Thu, 25 Sep 2025 14:37:32 +0200
Message-Id: <20250925-ltm8054-driver-v2-0-bb61a401a0dc@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI031WgC/13MywqDMBCF4VeRWTclE+Otq75HcaFmrANqJAmhR
 Xz3pnbX5X/gfDt4ckwebtkOjiJ7tmsKdclgmLr1SYJNalBSFbJStZjDUstCC+M4khOIw9jpSqM
 sC0inzdHIrxN8tKkn9sG69+lH/K4/qsHyn4oopBiNpqpGk+d9c++tDTOv18Eu0B7H8QHrAdjyr
 gAAAA==
X-Change-ID: 20250728-ltm8054-driver-11cfa4741065
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-iio@vger.kernel.org, Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Hello everyone,

These patches depend on the following series from Hans de Goede:

iio: processed channel handling fixes + Intel Dollar Cove TI PMIC ADC driver
(v4) https://lore.kernel.org/all/20250811155453.31525-1-hansg@kernel.org/

This is version two of my series which adds initial support of the Linear
Technology LTM8054 voltage regulator. The driver supports a fixed voltage and a
tunable output current limit using a DAC-controlled pin.

I'd say that the only unusual part of this series is the usage of the IIO
consumer API in a regulator driver. I think this makes sense here, since
the regulator driver has to access a DAC to read/set the output current
limit.

Since the regulator driver writes microvolts and the IIO consumer API takes
millivolts, the reads and writes to the CTL DAC have to be scaled by a
factor of 1000. Scaled reads are already supported in IIO, but scaled
writes are not, which is why I've implemented them in patch 2/4.

Please let me know what you think.

Thanks,

Romain

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
Changes in v2:
- Refactored iio_convert_processed_to_raw() to match what was done in Hans'
  series.
- Added unit tests for IIO division.
- Fixed coding style issues and removed unnecessary casts.
- Link to v1: https://lore.kernel.org/r/20250916-ltm8054-driver-v1-0-fd4e781d33b9@bootlin.com

---
Romain Gantois (5):
      regulator: dt-bindings: Add Linear Technology LTM8054 regulator
      iio: add processed write API
      Add kunit tests for iio_divide_by_value()
      regulator: Support the LTM8054 voltage regulator
      regulator: ltm8054: Support output current limit control

 .../devicetree/bindings/regulator/adi,ltm8054.yaml |  73 +++++++
 MAINTAINERS                                        |   6 +
 drivers/iio/inkern.c                               | 120 +++++++++++
 drivers/iio/test/Kconfig                           |  12 ++
 drivers/iio/test/Makefile                          |   1 +
 drivers/iio/test/iio-test-divide.c                 | 212 +++++++++++++++++++
 drivers/regulator/Kconfig                          |   9 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/ltm8054-regulator.c              | 235 +++++++++++++++++++++
 include/linux/iio/consumer.h                       |  36 ++++
 10 files changed, 705 insertions(+)
---
base-commit: bd89f4b281945a63659687ef5c70c4442d7e4940
change-id: 20250728-ltm8054-driver-11cfa4741065

Best regards,
-- 
Romain Gantois <romain.gantois@bootlin.com>


