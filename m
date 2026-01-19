Return-Path: <linux-iio+bounces-27979-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E32DD3B3DA
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 18:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C2A830864D4
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 17:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E6C329392;
	Mon, 19 Jan 2026 17:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9EE1uJf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CCF31A7E1;
	Mon, 19 Jan 2026 17:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768843159; cv=none; b=dG1ssZUCtyP98pQq38z1IUvIfuR6X5ZoR2U73vRVMSqe6QbMY3SaGOBa3UxJdVLV59OlfYuwgWk5Fz2TD+FTKNbw1nT+pZ0M0iC9tvFzqJVPsLay5LNaq5nERAODzAlNt9lc8+Fr/94U5FkU3g+L9KTMKHyEas6vc7TWYDh3y2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768843159; c=relaxed/simple;
	bh=VeK13ypBHOfjYHA6gWEHJp+oDUN8gaTIycXBoszv1bQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k3FezAW0po+smVtYj7yKXCUKf6TDlfB3DQB4qQyb5bplyn+AkCeMin9XGVe83CDhg4K8Uktclyk4089+yOg1unEXuxaQFkkoor6cLssPalO/LaXzdwvOC69X2rQaPOJyeOkQAvdrH0UJ9FXV1insQJs1WfHajFJDv9gX9T+wh2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9EE1uJf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF730C116C6;
	Mon, 19 Jan 2026 17:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768843158;
	bh=VeK13ypBHOfjYHA6gWEHJp+oDUN8gaTIycXBoszv1bQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=e9EE1uJf9A2JAXo4qxgRBfkeWXy+MiOTzi9kHEvhixB7WQ+VOE0U/DbPo6GTBofF5
	 7mqm/KiEzqDuTp3nqKiy2XS8vPlSpczXiIJvUvG6ZZfRH3Ix9qzESxs87UaIknEWzf
	 DURhrdYeOsJdH4SKhQQ70Ss4KGEwbWJ35nQdCfouoVlvHUUB/3/1zKrA+5LGji1xvz
	 n1qyHtnjZB0g82uRkJ0KgvCbH+BsZ/L+nEfUTCfj23IzJRjuFPqN00iQPmSPf6Nz+3
	 IekcIsRzg2mU7bE3CyMD9xzOBJzm7f8zQ6GTYJmXYNNIYzbzjJoQJTIM0rt0rArNQC
	 ZSVLcNc42xZPw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE58DD29C32;
	Mon, 19 Jan 2026 17:19:18 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Subject: [PATCH 0/3] iio: light: add AMS TCS3400 driver
Date: Mon, 19 Jan 2026 18:19:05 +0100
Message-Id: <20260119-tsc3400-v1-0-82a65c5417aa@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIlnbmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQ0NL3ZLiZGMTAwNdM4tES8MUi2RDY1NTJaDqgqLUtMwKsEnRsbW1ANA
 32vFZAAAA
X-Change-ID: 20260119-tsc3400-68a91d8c1355
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, David Heidelberg <david@ixit.cz>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768843157; l=1197;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=VeK13ypBHOfjYHA6gWEHJp+oDUN8gaTIycXBoszv1bQ=;
 b=WK3hd2ENhnZO6FOBcTgdGO+GUM2e8gxz72WPSWqDbwW9wEmdU1p9Tv/xjNVCh0YHBM1iFSU3j
 PGDMetvtTJ2BZ/ljOfBRccGMsXYYYq7c61jxkt+dPJxN9Qk1yY6+nvC
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
Reply-To: petr.hodina@protonmail.com

Hi,

This patch adds an IIO driver for the AMS TCS3400 color light-to-digital
converter.

The TCS3400 is an I2C-connected RGB color sensor supporting RGBC and
RGB-IR measurement modes, programmable integration time, selectable
gain, optional interrupt-driven sampling, and regulator-based power
control.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
Petr Hodina (3):
      doc: add Device Tree binding for AMS TCS3400 light sensor
      iio: light: add AMS TCS3400 RGB and RGB-IR color sensor driver
      sdm845: tama: Add AMS TCS3400 ambient light sensor

 .../devicetree/bindings/iio/light/ams,tcs3400.yaml |  54 +++
 MAINTAINERS                                        |   7 +
 .../boot/dts/qcom/sdm845-sony-xperia-tama.dtsi     |  36 +-
 drivers/iio/light/Kconfig                          |  11 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/tcs3400.c                        | 505 +++++++++++++++++++++
 6 files changed, 613 insertions(+), 1 deletion(-)
---
base-commit: 46fe65a2c28ecf5df1a7475aba1f08ccf4c0ac1b
change-id: 20260119-tsc3400-68a91d8c1355

Best regards,
-- 
Petr Hodina <petr.hodina@protonmail.com>



