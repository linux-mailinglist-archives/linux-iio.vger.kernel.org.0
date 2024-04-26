Return-Path: <linux-iio+bounces-4544-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B848B3BE4
	for <lists+linux-iio@lfdr.de>; Fri, 26 Apr 2024 17:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D9F1C22D45
	for <lists+linux-iio@lfdr.de>; Fri, 26 Apr 2024 15:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39387156649;
	Fri, 26 Apr 2024 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCPdsD5Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A2A14AD3D;
	Fri, 26 Apr 2024 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714146150; cv=none; b=RhKaD8prc4xJinbapxPd7/A68BM7JCGK/+wOHKxNrWKGE0E7j7AdUpf4yhLwD0yzJ50t+jtnXJZeqnys5EVlke2ivYuidGPNRsAnoUmKPlA6CnAnJba02zDlGK3QtnJTGMJSPRvPKiDDkEDRNI4iXecN2fsRltyoC9fAcF8lMBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714146150; c=relaxed/simple;
	bh=4rO3Z460OWVFFUr9q1DYa57hPeqpXtQlX9nHpGrbGDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R7f2tMLr9QcCo2f08fXJASydgO+G7LO5gRKEsQy1VSO/TkvN0MGsEOB/6GvLM5qiWmQPWoV/75fv4+a0BrQt+Kgs133XAasz0OKkJyc6jH0X4603IcHyUo0Nkw2bYcWEVEhks1Qb0As2u6/JbV0CcSvSqc4+9MtOuNIseq3fUxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCPdsD5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92AF1C32783;
	Fri, 26 Apr 2024 15:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714146149;
	bh=4rO3Z460OWVFFUr9q1DYa57hPeqpXtQlX9nHpGrbGDo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jCPdsD5ZHIrq1lsvdnJzvJJuk+RFsWVFWAuPmYaqNPGmgru6jmAGLPOt7d9xqcDiZ
	 JyKf6o7QCnDOb8+JeCeCmemcoQQ95gW27udq8RT2NidsjkxO9n5K1Uav5pFRAsrf6q
	 mu6HUpolVhekesgqYcI+kZtfUegMA2A6R9j/Txr0+hT0uGeqzS4PNksJpGZCzvXz98
	 rAHMkMu9Hd5A+XdTRqVGv+Oxg4z/AncVuaJVWaaP6vAe6TNCa9DABuXMvf0k8Vg2S/
	 MBla9RFxxbf2PCZsrNXHlAUFqTz9B+blzI8Wj5e7qKMv8JLtYQRqKCgBBwdWmRm46V
	 44ui319l6RJTA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DB5C25B5C;
	Fri, 26 Apr 2024 15:42:29 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 26 Apr 2024 17:42:12 +0200
Subject: [PATCH v2 3/7] dt-bindings: adc: axi-adc: add clocks property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-ad9467-new-features-v2-3-6361fc3ba1cc@analog.com>
References: <20240426-ad9467-new-features-v2-0-6361fc3ba1cc@analog.com>
In-Reply-To: <20240426-ad9467-new-features-v2-0-6361fc3ba1cc@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714146147; l=1362;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=Kji5f67mZEzci00M6vCqK7nqcsD4CPN32lsTL2M54tY=;
 b=2PLktNW4hBVWhtlf7tXvDHJdFNDsnNv7SWATfWUTWw1p65eSQWZ3Ofj4EWJrA/MDiUSCeQvEh
 JHwKmwH/XC9DezBpZhQqTbVcd9PbIhzmNpLmhTmpfkTwPDIY/sp+QnH
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Add a required clock property as we can't access the device registers if
the AXI bus clock is not properly enabled.

Note this clock is a very fundamental one that is typically enabled
pretty early during boot. Independently of that, we should really rely on
it to be enabled.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Fixes: 96553a44e96d ("dt-bindings: iio: adc: add bindings doc for AXI ADC driver")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
index 3d49d21ad33d..e1f450b80db2 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
@@ -28,6 +28,9 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+
   dmas:
     maxItems: 1
 
@@ -48,6 +51,7 @@ required:
   - compatible
   - dmas
   - reg
+  - clocks
 
 additionalProperties: false
 
@@ -58,6 +62,7 @@ examples:
         reg = <0x44a00000 0x10000>;
         dmas = <&rx_dma 0>;
         dma-names = "rx";
+        clocks = <&axi_clk>;
         #io-backend-cells = <0>;
     };
 ...

-- 
2.44.0



