Return-Path: <linux-iio+bounces-1880-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3ED1839250
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jan 2024 16:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11A05B24BC8
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jan 2024 15:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A7C5FEFD;
	Tue, 23 Jan 2024 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="no0rMQsT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386A15FDCD;
	Tue, 23 Jan 2024 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022874; cv=none; b=hfrq2EDK4S2Iyx6neHLK2WgMF9JJ3tdMHvcg8vg7X4SAMWxSr8kBEOZVYa7td2x+Q0nxAA/nDtFXtWiOCM4nMoY8EgxNh1nPhOCvyhQkBbnNkT9OOvtKZH4qM3qs7WFBFGBRXR1oXBmrAsiR/BuA546XhEwYfiZ/7FeplVJrUrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022874; c=relaxed/simple;
	bh=mM6TTDzmT8c9b+zSIXYzN5EneJISfMEUqOB2Clmh47Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TkhYYWh6qroWNd7Tz2npmnS6XeFAuIKgeY/AaV2NFj1ZeMLELkvzKdPcyn+3WWyOwQFcP8tNU+gs48zYiIQNis9mEjWhQJcMGsc0L/hIBLdWp3q1voK0209LNOfzoZdjsMgNg0a/Vu5aao+TlgmqKBa1L8hitslhGCMqqDrAIds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=no0rMQsT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB919C4166A;
	Tue, 23 Jan 2024 15:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706022873;
	bh=mM6TTDzmT8c9b+zSIXYzN5EneJISfMEUqOB2Clmh47Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=no0rMQsTtRr34Y3i2sTm6zgif5zm2sayTyPrRJxxSPAVi4PsL4r7GFgnvGJ1gSYjP
	 8hJJzFpDzQ35yl8+88d5ppKkuX3n0Ru46z9tue5lQd9NoDtTcEaAzOnCSs6GxvOy4G
	 MyLcsbkPsCAjysq7Q08pJvs7Dj5s8IGKoybbuU4sPsVp3m70xMo+vPWdxh1lJm3wYU
	 SQpdjzmVyyEPEX8jYKO4hd30PchwRY8Q/F6+DiOMt4c2riiiEwPhRbG4CeJrGbX9Zy
	 kHvexta69DFegZ0gGm2sluivjQKFYPYlNMlvWfYc+QfjhoRJIi+4R6iSn2UpDIDIR5
	 SgkgEcNwgIfDA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B966EC47DDF;
	Tue, 23 Jan 2024 15:14:33 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 23 Jan 2024 16:14:24 +0100
Subject: [PATCH v7 3/9] dt-bindings: adc: axi-adc: update bindings for
 backend framework
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-iio-backend-v7-3-1bff236b8693@analog.com>
References: <20240123-iio-backend-v7-0-1bff236b8693@analog.com>
In-Reply-To: <20240123-iio-backend-v7-0-1bff236b8693@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Saravana Kannan <saravanak@google.com>, Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706022871; l=1739;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=araWL3MBWOdTthhIEzT+iX7Wos0rotGDe8HqcId2NUg=;
 b=TmRlUPcTqQ7yHtySwvIe/LJr9awQYYA1hLmJI5TE2Cdr+Hc4pp0CFNntohcbbJTwccPqBDWco
 r4TyNeI/b2vBUooAibyeXNqJT4oGv7kZpoQdvGV7lIeecCV65PAib1U
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
index 9996dd93f84b..add10b22dcac 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
@@ -39,12 +39,15 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
       A reference to a the actual ADC to which this FPGA ADC interfaces to.
+    deprecated: true
+
+  '#io-backends-cells'
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
+        #io-backends-cells = <0>;
     };
 ...

-- 
2.43.0


