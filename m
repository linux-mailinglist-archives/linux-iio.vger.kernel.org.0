Return-Path: <linux-iio+bounces-508-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 259BB7FF7EB
	for <lists+linux-iio@lfdr.de>; Thu, 30 Nov 2023 18:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5771A1C21007
	for <lists+linux-iio@lfdr.de>; Thu, 30 Nov 2023 17:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848C55646B;
	Thu, 30 Nov 2023 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdG7j/lI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F3E537FA;
	Thu, 30 Nov 2023 17:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11242C433C9;
	Thu, 30 Nov 2023 17:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701364613;
	bh=4MvuIkotlM5v0azTQRz27GQ7u2cpqGPTVAW6vocygAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RdG7j/lIAxBP7TZ8CJ1EyZJIdXgVdM05abTwVJ/edPcsRn59jedppdTJPM3i7bv6j
	 U9THyxyINKw09aXL8XurqtVdLZuMg3r5D70aNkP5LeG2JQr1uV+zknK4FGf+lcXNyM
	 qGIBp9LLGMTZ80l4nt6ml9S3KS6BVD1BZJd1vRhaIRrXYPBENDBBxIvre1Q+Tk2iau
	 jeyU4MKBSUa2hz0CfSkWAa3A44zMH5LpvODbgzNMgq050fSwIZCIGnKGFRKuLjpKMW
	 DXBYweJq6oVBx7bgQZ4JM5hFiGVZij0+tvH3bjk/0/2/bFike3rfFMcIsj1CCCbK+2
	 UezkC/fgPX9Xw==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1r8kfG-0003Ck-1t;
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
Subject: [PATCH 3/6] dt-bindings: iio/adc: qcom,spmi-iadc: clean up example
Date: Thu, 30 Nov 2023 18:16:25 +0100
Message-ID: <20231130171628.12257-4-johan+linaro@kernel.org>
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

Clean up the IADC example by adding a newline separator, dropping an
unnecessary label and removing stray white space.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml          | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
index 16889d2d3575..5ed893ef5c18 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
@@ -54,12 +54,13 @@ examples:
     pmic {
         #address-cells = <1>;
         #size-cells = <0>;
-        pmic_iadc: adc@3600 {
+
+        adc@3600 {
             compatible = "qcom,pm8941-iadc", "qcom,spmi-iadc";
             reg = <0x3600>;
             interrupts = <0x0 0x36 0x0 IRQ_TYPE_EDGE_RISING>;
             qcom,external-resistor-micro-ohms = <10000>;
-            #io-channel-cells  = <1>;
+            #io-channel-cells = <1>;
         };
     };
 ...
-- 
2.41.0


