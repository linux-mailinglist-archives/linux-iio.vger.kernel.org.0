Return-Path: <linux-iio+bounces-511-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2177FF7EF
	for <lists+linux-iio@lfdr.de>; Thu, 30 Nov 2023 18:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B55D281658
	for <lists+linux-iio@lfdr.de>; Thu, 30 Nov 2023 17:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23D256756;
	Thu, 30 Nov 2023 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTyb8IeZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636B856459;
	Thu, 30 Nov 2023 17:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EEC9C433C7;
	Thu, 30 Nov 2023 17:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701364613;
	bh=/8tQsSzXakQvV7ZmsK9dAEqEDr5RhMRB8tCyWBIx1O4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BTyb8IeZDOkZEoNwPOZxLdZNvFFbkNUfQ6TMLDPgwLrPbix9LOgXwehpmvqnIzcyB
	 uK1EG6SEDWs16muAw0JIwQMSNVwvB+FaU7NTHa5HYp/y8Ua73S5BZQah4ro59NTyeP
	 iRQdqqURGvMTh7oLOZLT9W7xP7ByuHYcT2eBjdUv0T9mNHokb2CMEOcvkOL+ElYBk8
	 XbpBAo3beCxxdf1xD9AAqKRm9R/URATP30cX5975CtGp40ZOtT3n3SFxXHyoV8NKyf
	 HGSkDCdVUC5+d3AmYyVu8msaEWtJisN+fTRiqZ0i0ffu+c4PaLvxzvhqvIW7Bdec4c
	 5qyU8QBvmPehg==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1r8kfG-0003Co-2N;
	Thu, 30 Nov 2023 18:17:26 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 5/6] dt-bindings: iio/adc: qcom,spmi-vadc: fix example node names
Date: Thu, 30 Nov 2023 18:16:27 +0100
Message-ID: <20231130171628.12257-6-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231130171628.12257-1-johan+linaro@kernel.org>
References: <20231130171628.12257-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VADC is a child of an SPMI PMIC, which in turn sits on an SPMI bus.

Fixes: 74e903461b17 ("dt-bindings: iio: adc: qcom,spmi-vadc: extend example")
Fixes: 5a471662b5d9 ("iio: adc: Convert the QCOM SPMI ADC bindings to .yaml format")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
index ad7d6fc49de5..eb02715bf691 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
@@ -236,7 +236,7 @@ additionalProperties: false
 
 examples:
   - |
-    spmi {
+    pmic {
         #address-cells = <1>;
         #size-cells = <0>;
         /* VADC node */
@@ -281,7 +281,7 @@ examples:
     #include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
     #include <dt-bindings/interrupt-controller/irq.h>
 
-    spmi {
+    pmic {
         #address-cells = <1>;
         #size-cells = <0>;
         adc@3100 {
-- 
2.41.0


