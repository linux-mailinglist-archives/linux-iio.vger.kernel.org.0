Return-Path: <linux-iio+bounces-756-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5039980A70C
	for <lists+linux-iio@lfdr.de>; Fri,  8 Dec 2023 16:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07D2A1F21353
	for <lists+linux-iio@lfdr.de>; Fri,  8 Dec 2023 15:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9B43033E;
	Fri,  8 Dec 2023 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXOeEfuW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7D6225D2;
	Fri,  8 Dec 2023 15:14:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75BAEC433CB;
	Fri,  8 Dec 2023 15:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702048450;
	bh=nIumbSNy2HNraI49E2yCha0tzF9sWGi5YKv48+JANO4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aXOeEfuWRWUOqFMl8YuF3Y4oR8K3sVpiwFILpJGv5Fq0Z1VnARtMJ7VZtHbAFrNHj
	 CAOpyP2+8BtMu++aRSwl+LUSycEgcnt3nv2x8eifn59rvyd+jsZUJJ80d8OYJXMdAm
	 U1Pr1+t0yye4L828Hou5Cv3aEi818yVSAwOKKpWQni4kQp6ad5jdA3Dn0tzaYTLbpL
	 7KLVHTMvcXt96bUzdKA+ghfU6y2mPMblN8u5Dj9+cg11BydLbkqnJ5MadkGlB+LjgN
	 asnGDHIggymT2aZnljd6+mqOAni2itybNDCSK2LWefr0iWUxNrHkzjl5ar6IFUgNQg
	 7E3zNf5JR+cQQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBE5C10F05;
	Fri,  8 Dec 2023 15:14:10 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 08 Dec 2023 16:14:08 +0100
Subject: [PATCH v2 1/8] dt-bindings: adc: ad9467: document io-backend
 property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231208-dev-iio-backend-v2-1-5450951895e1@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702048448; l=1040;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=D7q6W8VwWUTViQGqb/BMWILjEw70nj+zEHdZlbAYQfs=;
 b=LR+bQ8JVhYh8Nxd2JNwQ2wemBAt9u9NReHkrS52MLd7EI2VjnP6c7itJrlDnznmlpoXKAxwPM
 0RX0rSDKb6aBVntib++GIu8TwpMnqrN1RdQFd9gpdAjpMo76F6lHeeD
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

Add a new property to reference IIO backend devices.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
index 7aa748d6b7a0..ae74249b4726 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
@@ -44,6 +44,10 @@ properties:
       Pin that controls the powerdown mode of the device.
     maxItems: 1
 
+  io-backends:
+    description: Phandle to the IIO backend device.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
   reset-gpios:
     description:
       Reset pin for the device.
@@ -68,6 +72,7 @@ examples:
             reg = <0>;
             clocks = <&adc_clk>;
             clock-names = "adc-clk";
+            io-backends = <&iio_backend>;
         };
     };
 ...

-- 
2.43.0


