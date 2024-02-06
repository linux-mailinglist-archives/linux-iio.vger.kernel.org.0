Return-Path: <linux-iio+bounces-2230-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA1D84B1FE
	for <lists+linux-iio@lfdr.de>; Tue,  6 Feb 2024 11:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ABB0287158
	for <lists+linux-iio@lfdr.de>; Tue,  6 Feb 2024 10:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2883112E1C3;
	Tue,  6 Feb 2024 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVwPg+Mr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D140912D765;
	Tue,  6 Feb 2024 10:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214123; cv=none; b=soXD1eds4aXvIZQcC3we4mlroF2l1Sa0esncacLIImHDSnT19fpxgRl9gi/YMgMxPrqzjV4utsJoVl7mbL/yWIZrcTR91ow1yW8G0mtUCqQS/1dhxGi6lUoEmeK/6l3oC2BMrbWw0blW2Hl/7fM7dFxGMGXc+CFBdRpfknxJYM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214123; c=relaxed/simple;
	bh=24R8nrdSmyLIh1d5uj5NStGn8J1aqMGzG1MRfh1bbkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uv+GZu4u6VNa/QTXThryJ5davkazNO6T7taY/uy9CNF7iXWEEITfyXdezLyjZwuoOswt4ASiP7ASXvxhQpGXU2tbKBKNtG0rzL/9bM9lj1uhEImNiUhQcoX+oWRUb4aRURA9Zg46rE4dQX04++lS/UjWh7fzvTbf5YbWt7sg3Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVwPg+Mr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F6D0C43399;
	Tue,  6 Feb 2024 10:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707214123;
	bh=24R8nrdSmyLIh1d5uj5NStGn8J1aqMGzG1MRfh1bbkY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FVwPg+MrpQX5M9HSiiXcq4+r+7QTrYcLDLWvsl0BkdCQgwz0gEAEar34nzpZMTM8a
	 AjkeDW4HKKJS5Z8LN58M0J3xm0kWVHWs5lYqffhj8wK4A6VoAiSiAe1O7hOHhpweCO
	 Llk6U6u7qSgiGsaf1/qGRDy+tQygFfg/2rop6Il+HPyTMUEz6w5CQzKYToGe/IxpII
	 iapkLySLZD2NVT0T+Bar08157y0SHP4xaraiDgPYXVrIqXNleJa63TVo2y7aAXir7g
	 3a055Ak87V3M144NorfYeTDDPiOXM/uLyLO65rpi8dU/sd8gqUe2u2zSg7WaOmM+4T
	 bVsnxA0UHHzkQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DEFC4828D;
	Tue,  6 Feb 2024 10:08:43 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 06 Feb 2024 11:08:25 +0100
Subject: [PATCH v9 2/7] dt-bindings: adc: axi-adc: update bindings for
 backend framework
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240206-iio-backend-v9-2-df66d159c000@analog.com>
References: <20240206-iio-backend-v9-0-df66d159c000@analog.com>
In-Reply-To: <20240206-iio-backend-v9-0-df66d159c000@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, andy.shevchenko@gmail.com, 
 Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707214121; l=1738;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=BNYirLxnGTOI/A1w2hu7+GFUDO+PsuDMfEgRy7j6TjM=;
 b=xVAWF12r44OH2chI2PBmj62sevGqEieI5WXufTZhPXXRm6+PWK/QHSwwp+y47CSqhaNF5vjAI
 qRWi93Cs1HGBxLX/6i3oejFiZ1PrEnf1XrHJPPDi/RD8DxXrWv3xIqk
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


