Return-Path: <linux-iio+bounces-27984-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 272BDD3B462
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 18:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8991730407E3
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 17:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4F332A3D7;
	Mon, 19 Jan 2026 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPsmg+x5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610C9325719;
	Mon, 19 Jan 2026 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768843209; cv=none; b=atBsJNWIt/706kZjRwbjN0r2o7tZIxGzl5wjIjy7n4vxszhWBgj21HyAbOH0n8spStangKPk4B+n04k25ql6SXbbZKuurcm9sgNnMDV38RsZy2wehNCTy4cP18RK4WUmTR6VauGGXBtMsPxBcOhhF0CBfXwPiU5xyH92dNRIDBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768843209; c=relaxed/simple;
	bh=v3If7khaoVa8/stoqUkdZXkFNHufWZUfyfb/J2p7VVM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WyMYwjdTsjhUvX42s0CilG+tOLXrFSbIEt+XZdu7/w/cKSLB6qSQOKxwDnYzjLPHbSBQk1nuI85sZEcLeOJIuA4ize5pNc2q2ts1+zHcegAFs5YjgMRixh6sC3hZr7GM9i6IPLfNIuBOKj3gDJ4/18GUMix9l65JG0sBDCzbte4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPsmg+x5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E29B7C116C6;
	Mon, 19 Jan 2026 17:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768843209;
	bh=v3If7khaoVa8/stoqUkdZXkFNHufWZUfyfb/J2p7VVM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=PPsmg+x5JH6wNYAk95iZN2n2eB5kid8O+1HZEiWpMzJ9jg0eNKS0wXRBhr3kdR0GY
	 agOffxGbKxnUfIrbMyfIq//rbHg9J4Z/Mfbdwx+0tkfToLfm7ipKOgQdcg2Zh5uG1S
	 GugHwJG5KsjhjhGwd/BFTiD7IEXCPI+uQgp6Zef+jEnEuaoNn5Td4cgHgTwrvMz//j
	 ZWdyHAv18enb4Mf8QINJlTJqZwC2WRNokT1WjnYQZFLd0+zQivOG11/siEAVxhlmaA
	 86KLapDtXjl1y/8Z0ptTAOxMTUatuiHkkp+fPTb1NM3B6HDMQSAlnVxJfaeiteSsSv
	 AdTNE8yR+VZew==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AF0D29C4D;
	Mon, 19 Jan 2026 17:20:08 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Subject: [PATCH 0/4] iio: proximity: vl53l0x: power sequencing, optional
 VDDIO, raw I2C ID read
Date: Mon, 19 Jan 2026 18:19:54 +0100
Message-Id: <20260119-vl53l0x-v1-0-cf71715a1353@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALpnbmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIyML3bIcU+McgwpdU3NjUxPDVAPjNIMUJaDqgqLUtMwKsEnRsbW1ANV
 5BkpZAAAA
X-Change-ID: 20251228-vl53l0x-573541e03f0d
To: Song Qiang <songqiang1304521@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, David Heidelberg <david@ixit.cz>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768843207; l=1309;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=v3If7khaoVa8/stoqUkdZXkFNHufWZUfyfb/J2p7VVM=;
 b=JnT1c7WAoLWRO4MGX2Wz5wMnYHdcY/2xR1OV0jNPWqSFWofL9q5ASYhwg9Xd12B8M5pS/H6Hs
 mQpw6SZc5L1CsPxqtOWmZklNuoZsGkMVSGTc/xG9MnAx/hlv8FtbHQU
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
Reply-To: petr.hodina@protonmail.com

Hi,

this series improves robustness and hardware compatibility of the
VL53L0X IIO proximity driver.

Patch 1 and 2 adds support for an optional VDDIO (vio) regulator and documents
it in the device tree binding.

Patch 3 fixes the reset and power-up sequencing. The previous logic drove
the reset GPIO in a way that does not match the datasheet timing and
level requirements.

Patch 4 switches the initial device identification from SMBus helpers to
raw I2C transfers and reads the full 16-bit model and revision IDs.

The series has been tested on hardware - Sony Xperia XZ3 (akatsuki).

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
Petr Hodina (4):
      iio: proximity: vl53l0x-i2c: Add optional vddio regulator
      iio: proximity: vl53l0x-i2c: Add optional vddio supply
      iio: proximity: vl53l0x-i2c: Fix reset sequence
      iio: proximity: vl53l0x-i2c: Use raw I2C access and read full device ID

 .../bindings/iio/proximity/st,vl53l0x.yaml         |  2 +
 drivers/iio/proximity/vl53l0x-i2c.c                | 71 +++++++++++++++++++---
 2 files changed, 63 insertions(+), 10 deletions(-)
---
base-commit: 46fe65a2c28ecf5df1a7475aba1f08ccf4c0ac1b
change-id: 20251228-vl53l0x-573541e03f0d

Best regards,
-- 
Petr Hodina <petr.hodina@protonmail.com>



