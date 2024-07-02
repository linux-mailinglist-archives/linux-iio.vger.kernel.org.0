Return-Path: <linux-iio+bounces-7124-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 427CD923CE0
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 13:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72F801C21F97
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 11:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C0B15B14C;
	Tue,  2 Jul 2024 11:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nhr3Snwu"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2791DFD8;
	Tue,  2 Jul 2024 11:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719921198; cv=none; b=SAqA5c9c4eaEwUkPDuC/xCb2O1HEdzywWmzR653KsHS6KJmiS3DhBZuK2CjBICNu7whxtxcHEPrBMWEKaJ9f8teAY7jxXj5vEDZ62CVV2tnsfGPBwcUfpqw9755cNQTlLUYZ5lIfsCATFYgZk/osUFtd40dizmvzO0QLX6Jl0R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719921198; c=relaxed/simple;
	bh=RlghZNhgXISYu/QWn07AlHSmBEhiIKk8bKXRDyj7W9k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WIzx9Cs/zjRq7lMigMrWtBvHI4q1o/2IOe/jRDxePGQQhvA0twFhLjna/qQwJ4nyGddP46ZwpI8iq+9Jn1Ntr6BYyHClGF7pnO+lfe2nIPfvXt+ZJ/S5eHu/wTio4D8jGt09OJSUpQgUz54W+qh8whBPhXPuk6I5PcJhJdwRU6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nhr3Snwu; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 13B4E1BF207;
	Tue,  2 Jul 2024 11:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719921193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g0xw6PXJD/+VJObPpeeMreW5bakIQ/1Rdvob+72LtCc=;
	b=nhr3SnwuX1kCJUXH05YboKYnDNmWl8wwWmlaiSorc2ntHVq6NoXsja3zz9wgCB64zhDbxE
	2K3NBgoVv65iCITj6rj4RZYEfU+xrYhpOi9rQ4Ae0gslIjTn4YkYApFyQnfrinXstou1Ba
	vYlDpI6soPRD0B8TUtgxmRxVp2vm8T5nJet3l7C7DrCcpLxjkRXQDFbjuHgD2PlfU0GqiE
	vwhPKRJkmZTSCY7mrkkXFT4ZOs/GUhJjSCSkwPdsBMJKel32+TfZLGq/5CzL+lVxcOu6g/
	RQcIJrcG8CUYNd01FGPEp/bMkDDYpzQC78t0hKXqwRxb9aOwFkq4o+lWPu+hZQ==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Subject: [PATCH 0/3] Add SARADC support on Sophgo SoC
Date: Tue, 02 Jul 2024 13:52:20 +0200
Message-Id: <20240702-sg2002-adc-v1-0-ac66e076a756@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPTpg2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUyNz3eJ0IwMDI93ElGRdSyOTJAszo+QU4zQjJaCGgqLUtMwKsGHRsbW
 1ANr/7VNcAAAA
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
Thomas Bonnefille (3):
      dt-bindings: iio: adc: sophgo,cv18xx-saradc.yaml: Add Sophgo SARADC binding documentation
      iio: adc: sophgo-saradc: Add driver for Sophgo SARADC
      riscv: dts: sophgo: Add SARADC configuration

 .../bindings/iio/adc/sophgo,cv18xx-saradc.yaml     |  51 +++++
 MAINTAINERS                                        |   6 +
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi             |  14 ++
 drivers/iio/adc/Kconfig                            |   9 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/sophgo-adc.c                       | 223 +++++++++++++++++++++
 6 files changed, 304 insertions(+)
---
base-commit: be18997d95c888e7a432d46045644f396286775b
change-id: 20240527-sg2002-adc-924b862cd3f2

Best regards,
-- 
Thomas Bonnefille <thomas.bonnefille@bootlin.com>


