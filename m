Return-Path: <linux-iio+bounces-27983-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEC4D3B460
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 18:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4BE2304205C
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 17:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA29D329C56;
	Mon, 19 Jan 2026 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JM71DKmT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FD0324712;
	Mon, 19 Jan 2026 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768843209; cv=none; b=iLt5BC+/yxsig3TTW2fwgZUKxwdBZ3UloYvnEseC2b0X/Db3XArHQd0uOcxbpyTPgChHWnLA8KT+m65wCqUT0t1G3NPRlV8h8PDOxFO9K5zhmlPUFXLId2onUahztbZfmViv9l093eRRopclkD2y8F0C6Fb18HIh1mYkBGVZ+xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768843209; c=relaxed/simple;
	bh=L5Oz3azqPZDLg50OLnMaEbRamF2YpBEBXH94OvTmD1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KyxKy2OGcxA8+IUN2LNPZXW6A5nj0ZiEhEsYUJC8FoMoVJYdp/IJOa6hamW7FKNjot+MhfuLyCc6UOyOJx+eGTMM2AmNPG+YqWjBSy+ZPprRl5uqd4wSU2ae65V6yEKiF+B5IPXoyjpdqqS+8W50XdjN12sEotyUvrf7cXZd3DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JM71DKmT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF4A6C19424;
	Mon, 19 Jan 2026 17:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768843209;
	bh=L5Oz3azqPZDLg50OLnMaEbRamF2YpBEBXH94OvTmD1g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JM71DKmTHLxy0aB6B8XN5G63d7Bp0znpY2dnOfyvf8YzdAkc+iEK/cnP3RuApJUyC
	 yloX31ZeSVT49vHau7tknodB9q3nb4cuGBIOixeX9K5ZgRJsLnGP3D+mfeMNr0vAEB
	 7iux7623Ldcd/b/XPObfKJhcBcrDCWD8G4CU+YbTbHPkHVUkPtonwuiGR0Iu79X+G2
	 2GlS4btcNA8z0885GX8ou8KlI5gcWp/0qDYP4Y9afSBzT1dDVMprmHH1GmDw6+US2j
	 BJQztSHJtNm+wv/qG1kVMlzkA7e1HjoO2B8xEqz6JG8FYuGmOWLzVLov+r+gKTHoBx
	 DVukxGNK0b1zw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8499D29C32;
	Mon, 19 Jan 2026 17:20:08 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Mon, 19 Jan 2026 18:19:55 +0100
Subject: [PATCH 1/4] iio: proximity: vl53l0x-i2c: Add optional vddio
 regulator
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-vl53l0x-v1-1-cf71715a1353@protonmail.com>
References: <20260119-vl53l0x-v1-0-cf71715a1353@protonmail.com>
In-Reply-To: <20260119-vl53l0x-v1-0-cf71715a1353@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768843207; l=816;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=BV4POcOIZq8QUHOdmdM1SwxBCDON6elezUBUerTNxcg=;
 b=cPVYUMmL1kFKjDAF78n8ou5j2xqWoELiWi5TaQSfe2CUAq3cwCY9ROgWsOIyJv4dGbNP3qK9n
 OaZDney50bkDwL21eO/vxCVlTJo0+ID6CgM28xfqQFO0po7uxBTJjZk
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
Reply-To: petr.hodina@protonmail.com

From: Petr Hodina <petr.hodina@protonmail.com>

The VL53L0X can be powered using separate core (VDD) and I/O (VDDIO)
supplies. Add support for an optional vio regulator and enable/disable
it during power on/off when present.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml b/Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
index 322befc41de6..f7e55d427fe4 100644
--- a/Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
@@ -24,6 +24,8 @@ properties:
 
   vdd-supply: true
 
+  vio-supply: true
+
 required:
   - compatible
   - reg

-- 
2.52.0



