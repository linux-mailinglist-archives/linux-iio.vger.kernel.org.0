Return-Path: <linux-iio+bounces-2384-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CB185065C
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 21:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A16285CA5
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 20:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86FE5FBBE;
	Sat, 10 Feb 2024 20:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MR+LyIzx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7EA5F55D;
	Sat, 10 Feb 2024 20:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707598641; cv=none; b=PowejR5pFV4GF4kUq7+Uz08t4LnY/ZQw+3g3dJHA5jAXXjv7Mo1xxXhy7Ti4Oo1pYqJUvtm0aHNl7K+toAegDhO35Ywgte14i8MTdipruZyRQHa4wTkfB9nbbstZxmB3lMpaBhZTpIOF29xggHGU1FzZ6lSW1eos0NKC28Jwjsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707598641; c=relaxed/simple;
	bh=24R8nrdSmyLIh1d5uj5NStGn8J1aqMGzG1MRfh1bbkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iVz+/xfeA4E2WTU/Ytrv9hB10svZP+sGaFsIT6hat6lV6flls7p2xlZBvtbqWzJ9SbUhte6s4VhqjJYAAD//Iud1M/agIvyskVjEVd5HxTP76/rnD6ZubWNzoUTjNer2ywk9Lqd4CE9o82jSEnmUloDLH8POQgANjmQVf7708M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MR+LyIzx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20162C43394;
	Sat, 10 Feb 2024 20:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707598641;
	bh=24R8nrdSmyLIh1d5uj5NStGn8J1aqMGzG1MRfh1bbkY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MR+LyIzxMFQFrlzRoNW69m5vE+RoIcKIAKeQ3t/p16l8LUSR3WRQBR7q3HUb6+uoX
	 H6pd7ch/4v/1uctdSWJEvb605kTFX/bu3mzBqpUjlK2P0X6WV+2MmTai9XUdeNop8S
	 jP13qYomofUZdE9p8tbtBChwzhQ7/YW1G2pdu6OscNkdhX3bzQOGCJD8qH5/ZoBIf/
	 gw6UtxFkfuDzCN6FLn+9R7yeCcAbDcV0I5xJC00B4YkjDPgEn0yr8vLpkhF4Vtcitc
	 xdnYNRbhG8oe53QFZig58M0vLYoVXJGQr0EpCTH1ZfbrYL6u4kbZ5TTVWvDWNKVEBQ
	 kLvA+6/An81rw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BE3C4829F;
	Sat, 10 Feb 2024 20:57:21 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Sat, 10 Feb 2024 21:57:14 +0100
Subject: [PATCH v11 2/7] dt-bindings: adc: axi-adc: update bindings for
 backend framework
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-iio-backend-v11-2-f5242a5fb42a@analog.com>
References: <20240210-iio-backend-v11-0-f5242a5fb42a@analog.com>
In-Reply-To: <20240210-iio-backend-v11-0-f5242a5fb42a@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, andy.shevchenko@gmail.com, 
 Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707598639; l=1738;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=BNYirLxnGTOI/A1w2hu7+GFUDO+PsuDMfEgRy7j6TjM=;
 b=eYo/6F8udyd2xj0EU47VIn8EF0uzb8tCtZCfY+eeLFSjNZi3kCTJwHl3rTo0T//Qr1FN3Sppu
 J07ybUAfSbyDTWRzmiayWxE6jxxIO47STzzjszP/5Nts2j3HCNW1c1Q
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

'adi,adc-dev' is now deprecated and must not be used anymore. Hence,
also remove it from being required.

The reason why it's being deprecated is because the axi-adc CORE is now
an IIO service provider hardware (IIO backends) for consumers to make use
of. Before, the logic with 'adi,adc-dev' was the opposite (it was kind
of consumer referencing other nodes/devices) and that proved to be wrong
and to not scale.

Now, IIO consumers of this hardware are expected to reference it using the
io-backends property. Hence, the new '#io-backend-cells' is being added
so the device is easily identified as a provider.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
index 9996dd93f84b..3d49d21ad33d 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
@@ -39,12 +39,15 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
       A reference to a the actual ADC to which this FPGA ADC interfaces to.
+    deprecated: true
+
+  '#io-backend-cells':
+    const: 0
 
 required:
   - compatible
   - dmas
   - reg
-  - adi,adc-dev
 
 additionalProperties: false
 
@@ -55,7 +58,6 @@ examples:
         reg = <0x44a00000 0x10000>;
         dmas = <&rx_dma 0>;
         dma-names = "rx";
-
-        adi,adc-dev = <&spi_adc>;
+        #io-backend-cells = <0>;
     };
 ...

-- 
2.43.0


