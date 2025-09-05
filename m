Return-Path: <linux-iio+bounces-23767-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B76B45588
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 13:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059071C8234D
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 11:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4845342C8B;
	Fri,  5 Sep 2025 11:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="auxSZN6V"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A03D265CA2;
	Fri,  5 Sep 2025 11:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070093; cv=none; b=FZmCDrVDRYQ3lxbQRWLPyS6ijqfzRgEiMYSu0gRiWKZGcr7xeCZpY5YuryzZ2WtxK86LRezNDw553plpLaGfSybWdB5u/ERje9pb62HE+liVxHrqcE86Q6OlFwtymsTTM0+n3+BI0gprXt+YeG8u7VyvtT4Is+YrJuBg7fSALYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070093; c=relaxed/simple;
	bh=Q/F3vdGPrInicj4pqHOWJ3LfYlIQedwsrx/RlWTjWoE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=I0KP5J1mN/zzmmwcw6N7zo22M1OOlJJFWuHH15zueAH1gmDJR99PHkrar5PbTQY6MtU9meqhW++OqLkYnfTCQiv+QDFm4Pq7HE9afo8cit3dbGWrP1N9IHRW9FZInv8tHyPr4mto0MoT1SloYhF4RxnEGu3/1zfIljOs9qvTijQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=auxSZN6V; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=YeME77c9vu1Q61ETUQEIXofBh9SzJIyBAylBCZ+54Xo=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:Message-Id:Message-Id:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1757070064; v=1; x=1757502064;
 b=auxSZN6VGC+gIt93s0YIrQhFBshVbOXflIeIjYGDKjZKJSu4Jduc78n2jVn/Yso1D2NQGHQF
 Kc538qEu1OCiObeZXWS3qYXcUEVq0zlkrOe/F5BVGMIU5V6VHg5Ks71odNAAzQLX6gezqqc9pPt
 KLvQxf1lg8Gn/FXhu3D2xm2ECfeC/vQgh6Kd661Tc8CFxHIKO2L3VO4pJFOGm10Emxn22Kw5R7z
 ycIZcRHvy5Hm6Y+00IKp8eHdRaXXmxvwVfXcKa7MKmlO9qEM29HIUUj7BV9AMTCyDMm5aFkHsAf
 1zi3fKHUudtLf9JRA/YTq9F0Eg1wmpZFqWNCAsNzE3iJA==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 0e3c747f; Fri, 05 Sep 2025 13:01:04 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Subject: [PATCH v3 0/3] Marvell 88PM886 PMIC GPADC driver
Date: Fri, 05 Sep 2025 13:00:53 +0200
Message-Id: <20250905-88pm886-gpadc-v3-0-4601ad9ccb51@dujemihanovic.xyz>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOXCumgC/23O3wrCIBTH8VcJrzP0LJ3rqveILkSPm8H+oCVbY
 ++eGwQxuvz+4Hw4M4kYPEZyOcwkYPLR912O4nggptFdjdTb3AQYCKagpEoNrVKS1oO2hiqOYDS
 3AgySfDMEdH7cvNs9d+Pjsw/Txie+rl+p2kmJU0adZCABpHSor/b1wNbnJ/rkzWmc3mQVE/woB
 d8rkJVSVIYjP9tKuH/KsiwfmhdKtfgAAAA=
X-Change-ID: 20250827-88pm886-gpadc-81e2ca1d52ce
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Karel Balej <balejk@matfyz.cz>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: David Wronek <david@mainlining.org>, phone-devel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1473;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=Q/F3vdGPrInicj4pqHOWJ3LfYlIQedwsrx/RlWTjWoE=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBm7Dr3nsTpmsnWyV+ZeKeml7U/vbpdxLVtm9/jEwVP/b
 538I7NKpqOUhUGMi0FWTJEl97/jNd7PIlu3Zy8zgJnDygQyhIGLUwAm8uYfI8PnamXN+wVzfsVL
 tN8/tSn/1v//E5wZLzkXMAedXBFUN+sxw//ixMSiOQHbXnQeOfx8geukk+EWU/0eRWzzy5Zx+Gz
 f5ccAAA==
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

This series adds a driver for the GPADC found on the Marvell 88PM886
PMIC. The GPADC monitors various system voltages and is a prerequisite
for battery monitoring on boards using the PMIC.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
Changes in v3:
- Refactor driver according to comments
- Update trailers
- Rebase on v6.17-rc4
- Link to v2: https://lore.kernel.org/r/20250831-88pm886-gpadc-v2-0-759c1e14d95f@dujemihanovic.xyz

Changes in v2:
- Refactor driver according to comments
- Add binding patch
- Link to v1: https://lore.kernel.org/r/20250829-88pm886-gpadc-v1-0-f60262266fea@dujemihanovic.xyz

---
Duje Mihanović (3):
      dt-bindings: mfd: 88pm886: Add #io-channel-cells
      iio: adc: Add driver for Marvell 88PM886 PMIC ADC
      mfd: 88pm886: Add GPADC cell

 .../bindings/mfd/marvell,88pm886-a1.yaml           |   4 +
 MAINTAINERS                                        |   5 +
 drivers/iio/adc/88pm886-gpadc.c                    | 388 +++++++++++++++++++++
 drivers/iio/adc/Kconfig                            |  13 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/mfd/88pm886.c                              |   1 +
 include/linux/mfd/88pm886.h                        |  58 +++
 7 files changed, 470 insertions(+)
---
base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
change-id: 20250827-88pm886-gpadc-81e2ca1d52ce

Best regards,
-- 
Duje Mihanović <duje@dujemihanovic.xyz>


