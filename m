Return-Path: <linux-iio+bounces-1762-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E0E832C9E
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jan 2024 17:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE7F71C2338B
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jan 2024 16:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CF954F86;
	Fri, 19 Jan 2024 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bq9ffkOO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27EA54BE1;
	Fri, 19 Jan 2024 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705680069; cv=none; b=XchVw4tTIYQQnJM9ObHiASh76u7kulv+b+67eQc34OXEo26oXOy9/vngzZgQquVkv9//vjjNVOO/RS/UrWRZy/BH3iCpgdCD+9B5FaE0ire67CZ3xN59YYkJ5M/QwDjBqbH+GdS9pSp7YkZ6UrsO8Wv128xQ97m4Y42CLv3cynU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705680069; c=relaxed/simple;
	bh=Gyh97/yhmBY6SBtoSix+uXg8bS8pDPinzhK+HnPgz3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JoyTviATZUE2tYeLvoEeL+XlJYbHIWXTObWA70+G9bXxujL2Qt0BYPHa/gKnlFaNez1slLKix559aZa+ZuSn5shQzyVHDs85ZPBNeeQXsgG+BhI3ZZDvjGb+OnqV8CfOYynbaVMtdj+ZrgpCNquPWJUsvZy2ExqA2v98DI/dTUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bq9ffkOO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 787E1C433B2;
	Fri, 19 Jan 2024 16:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705680069;
	bh=Gyh97/yhmBY6SBtoSix+uXg8bS8pDPinzhK+HnPgz3g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bq9ffkOOVYK6Jmz+UdwF4VSLfFH+AYyUCQo+dlg1YqV3Ch7YSQsAQ12TircDKQHoj
	 uzmQfpAB4XTrarPEI5NDElA1tvCAlqgA8vUcWKhaktmnq5EOlVZYULvMCyQ/XYujqI
	 XNHfvus2RKQdCg4TCaEvgJd0W45O5fD+cRBr6jJ1OX9V359iDLY6JK8WZ0r7LUdjy0
	 TMnHtRQgd/4y9Zi1wZE/MwTNDP7nM7RY562PwQ3/Xl/C2Muq2s4BcO9BFdNzOpKZ9G
	 +49uO6zA1CD13hiiVQg6Z+LpaYMIjEVnQB/+j5T/EgHf8nvbOHihhyCBYrrIvr4rc2
	 ptZo22QNEeROg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537C8C47DD3;
	Fri, 19 Jan 2024 16:01:09 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 19 Jan 2024 17:00:48 +0100
Subject: [PATCH v6 2/8] dt-bindings: adc: axi-adc: update bindings for
 backend framework
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240119-iio-backend-v6-2-189536c35a05@analog.com>
References: <20240119-iio-backend-v6-0-189536c35a05@analog.com>
In-Reply-To: <20240119-iio-backend-v6-0-189536c35a05@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705680065; l=1695;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=JfEb/bzY7KUbX0bS1qTJLEVqmnweeO1n+vRJXjAwpXk=;
 b=lDqzlyRNlKdPnsmGHz+0fTGx652cG0MjxO8WF0Zf1mLTeMXeYOnuXG4CcZt9zIoy3ziGs1+iv
 RGo6PeVKc5lBqIXmV77o/f/HB28nk5H8o+nSYCfgn/2CcT4IGk94o8Z
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


