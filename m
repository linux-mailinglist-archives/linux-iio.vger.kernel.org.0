Return-Path: <linux-iio+bounces-757-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F69C80A70E
	for <lists+linux-iio@lfdr.de>; Fri,  8 Dec 2023 16:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E3628194D
	for <lists+linux-iio@lfdr.de>; Fri,  8 Dec 2023 15:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D6E3034B;
	Fri,  8 Dec 2023 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhkbZ8XL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8192375D;
	Fri,  8 Dec 2023 15:14:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E718C433C9;
	Fri,  8 Dec 2023 15:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702048450;
	bh=XWd29Bx/1zhG4PtnHJ4U/X7tJYkjXKd0pZlp34fkM/I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XhkbZ8XL8WAEx3BKq4T08io0BqY5bnIcoKrpJSNKD/AKee12edXucyrcCEnLtjfbU
	 4kz5yeuixubSYviSnNnYcPc0gn/MjYyZ3tEwVbHBqhSI8N9rsESocbykI/2Q0KgEF/
	 EP5Qif2Dnb2qvls9sFWIYyptdBaWxfTXTvPYsiYs2RDgsbJ88PKsD1TCOr6QikFJq3
	 AVAz/4CfLZ6Oo+kU3hF5g7FokTqyraQ1+zpP2w4FZzoTWxSFFm1t7WPQlZ27NzpGlP
	 UzunEadzB95v4QH2DaFyxG7Ihsuar+QDUmOSt0swumiwYv9bpCaeG/u5Gn/nHtHGS2
	 p1eiWj4PlhUpA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6705DC46CA3;
	Fri,  8 Dec 2023 15:14:10 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 08 Dec 2023 16:14:09 +0100
Subject: [PATCH v2 2/8] dt-bindings: adc: axi-adc: deprecate 'adi,adc-dev'
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231208-dev-iio-backend-v2-2-5450951895e1@analog.com>
References: <20231208-dev-iio-backend-v2-0-5450951895e1@analog.com>
In-Reply-To: <20231208-dev-iio-backend-v2-0-5450951895e1@analog.com>
To: devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702048448; l=1094;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=C0999kdXZfFVABxRP5fCA7vOPNscAFjvB6s0Z8D09gA=;
 b=zDjB/iYOjyvJ7QF1DU8YK6+7triYtNh7+cUHyCBceGsEVs5uERZNT61ndkHynca0weyJ22WQ7
 DZPXoFkQiGVDS7blablwvFkESTfLja4MB324FAt0Im9KpRepmc3WYjF
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

'adi,adc-dev' is now deprecated and must not be used anymore. Hence,
also remove it from being required.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
index 9996dd93f84b..835b40063343 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
@@ -39,12 +39,12 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
       A reference to a the actual ADC to which this FPGA ADC interfaces to.
+    deprecated: true
 
 required:
   - compatible
   - dmas
   - reg
-  - adi,adc-dev
 
 additionalProperties: false
 
@@ -55,7 +55,5 @@ examples:
         reg = <0x44a00000 0x10000>;
         dmas = <&rx_dma 0>;
         dma-names = "rx";
-
-        adi,adc-dev = <&spi_adc>;
     };
 ...

-- 
2.43.0


