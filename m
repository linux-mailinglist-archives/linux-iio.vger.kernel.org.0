Return-Path: <linux-iio+bounces-431-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F617FA55A
	for <lists+linux-iio@lfdr.de>; Mon, 27 Nov 2023 16:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B12281747
	for <lists+linux-iio@lfdr.de>; Mon, 27 Nov 2023 15:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF6034CE0;
	Mon, 27 Nov 2023 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SriQa6OJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29164347AD;
	Mon, 27 Nov 2023 15:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2A02C433C8;
	Mon, 27 Nov 2023 15:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701100540;
	bh=2dwPEiIKh1vP1LKJt7FEPcploNyGC3+4S6+K4B/naJw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SriQa6OJMdXkuvV8O8hUuUMYMUOGYPzqJQkmYcSC0Hqj3AXsNdPlt0zAq2YwEdFkS
	 7PXJ7v2dou60iwk2A2n+0gu0Dz/YI+H1Ztyczx+dF2sV1vXdFMC1EMTQvEZHDss59E
	 fV1Gb8rypaftEyh2435FBKKpe/4A+8B98b/UI1RqP+godvouM4r36Q7K7LrtB8hL82
	 QXgy5DDyAaFwx7WtUi2ZhRq06RNVfTB5L6ydBqGW3zvZ9z/BYw+FtC9Kx808QvUwfQ
	 oe770C2y1xmeP/B5S06NiqEFwaCNdsYpOMMKNMUN2ypO3EA7ctvN0UgEfGkbtT1P2p
	 ea5Ha1Z7EQgpA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969DAC0755A;
	Mon, 27 Nov 2023 15:55:40 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 27 Nov 2023 16:55:34 +0100
Subject: [PATCH 1/2] dt-bindings: adi,ad5791.yaml: Add support for
 controlling RBUF
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231127-ad5791-michael-stuff-v1-1-04167b3edc56@analog.com>
References: <20231127-ad5791-michael-stuff-v1-0-04167b3edc56@analog.com>
In-Reply-To: <20231127-ad5791-michael-stuff-v1-0-04167b3edc56@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Hennerich <michael.hennerich@analog.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701100539; l=917;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=0oarBF+t5l1h1kCQzFI2KDQV3L8snvDLRqcv7MsxVLA=;
 b=yOBKk0YqB2bxsTHK2s/2IGCZKAEIOMEAIb3uoyxh1efS7ryT+NoBuWnMKNtXYUCyiKDGk/6cm
 NNL4gGKa5a/A9VaMcG3d0iAiyoglAqFeBZGtLWkOMMH04Qx1RNJR040
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

This patch adds support for an external amplifier to be connected in a
gain of two configuration.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
index 3a84739736f6..c81285d84db7 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
@@ -26,6 +26,11 @@ properties:
   vdd-supply: true
   vss-supply: true
 
+  adi,rbuf-gain2-en:
+    description: Specify to allow an external amplifier to be connected in a
+      gain of two configuration.
+    type: boolean
+
 required:
   - compatible
   - reg

-- 
2.43.0


