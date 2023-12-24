Return-Path: <linux-iio+bounces-1241-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0906481DAE2
	for <lists+linux-iio@lfdr.de>; Sun, 24 Dec 2023 15:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05FA1F21756
	for <lists+linux-iio@lfdr.de>; Sun, 24 Dec 2023 14:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8525695;
	Sun, 24 Dec 2023 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="kSM00V4u"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADB715D0;
	Sun, 24 Dec 2023 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id E016228B538;
	Sun, 24 Dec 2023 14:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1703428510;
	bh=gnzCEEr9FE5S/35WvgRN9WGB3sJnxOb4JQsoYP6j3nM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kSM00V4uakA2eSqATirN/KIGEm+h4F2zSk1Vf30fp+yZBeggqZ9oSy+VveDKh6LH5
	 PCrfCB5sGH9P/38gel27e6nbBolpDqbLiEZ62H9X0OKrY3mJng17GJvObeYIGHPHyp
	 veEb+EltaNU4Tm9UqbbxUq6eI7Vwav1Cj6eu553Q=
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v2 01/10] dt-bindings: iio: pressure: honeywell,mprls0025pa.yaml fix
Date: Sun, 24 Dec 2023 16:34:46 +0200
Message-ID: <20231224143500.10940-2-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231224143500.10940-1-petre.rodan@subdimension.ro>
References: <20231224143500.10940-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define enum inside the honeywell,transfer-function property block.

Set the correct irq edge in the example block.
Based on the datasheet, in table 13 on page 11:
"End-of-conversion indicator: This pin is set high when a measurement
and calculation have been completed and the data is ready to be
clocked out"

Add description on End-of-conversion interrupt.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 .../bindings/iio/pressure/honeywell,mprls0025pa.yaml       | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
index d9e903fbfd99..84ced4e5a7da 100644
--- a/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
@@ -42,6 +42,10 @@ properties:
     maxItems: 1

   interrupts:
+    description:
+      Optional interrupt for indicating End-of-conversion.
+      If not present, the driver loops for a while until the received status
+      byte indicates correct measurement.
     maxItems: 1

   reset-gpios:
@@ -65,6 +69,7 @@ properties:
       1 - A, 10% to 90% of 2^24 (1677722 .. 15099494)
       2 - B, 2.5% to 22.5% of 2^24 (419430 .. 3774874)
       3 - C, 20% to 80% of 2^24 (3355443 .. 13421773)
+    enum: [1, 2, 3]
     $ref: /schemas/types.yaml#/definitions/uint32

   vdd-supply:
@@ -93,7 +98,7 @@ examples:
             reg = <0x18>;
             reset-gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
             interrupt-parent = <&gpio3>;
-            interrupts = <21 IRQ_TYPE_EDGE_FALLING>;
+            interrupts = <21 IRQ_TYPE_EDGE_RISING>;
             honeywell,pmin-pascal = <0>;
             honeywell,pmax-pascal = <172369>;
             honeywell,transfer-function = <1>;
--
2.41.0


