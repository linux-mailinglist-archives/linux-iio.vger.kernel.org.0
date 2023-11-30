Return-Path: <linux-iio+bounces-509-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 039077FF7EE
	for <lists+linux-iio@lfdr.de>; Thu, 30 Nov 2023 18:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33DA01C20849
	for <lists+linux-iio@lfdr.de>; Thu, 30 Nov 2023 17:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B445256751;
	Thu, 30 Nov 2023 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYbxN6h/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6361156452;
	Thu, 30 Nov 2023 17:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3C9C433C8;
	Thu, 30 Nov 2023 17:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701364613;
	bh=KSdOCdB6xW/QIXdrCIh6E061B7HLNeGVfp8JXB/WYKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lYbxN6h/8sjKS050DPNMu/CrbBSEIQsmUhC7bMZrlOAM0P9SJLvRzEKwssT7T70G8
	 rfY4nYWSJORT8P6jzxdW+9Svfhs7gS10eb3B/76BbDXSiaLNQuRrGIP13QixL7tVKl
	 x0vKoScxZtJmP++Cce4hNxG/wJUMlPdFGOoEm0iZy5LA6K6owfc4ODPfrjd9VKZjhy
	 1HnbmwLDIKpz2I15IBIL8eVzFgsHbxp1n+ly/YMrbQeNP+Neu25vK7rdxo44A2Mtay
	 gZjBD6CUYyqj2UUnJ4GjDufjkkoVDCOHyy2oP5ZnYO101giLowpPZWfvUmzH4FDLAz
	 ZfNIjnEf3ze5w==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1r8kfG-0003Ci-1c;
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
Subject: [PATCH 2/6] dt-bindings: iio/adc: qcom,spmi-iadc: fix example node name
Date: Thu, 30 Nov 2023 18:16:24 +0100
Message-ID: <20231130171628.12257-3-johan+linaro@kernel.org>
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

The IADC is a child of an SPMI PMIC, which in turn sits on an SPMI bus.

Fixes: a4e6bf69418c ("dt-bindings:iio:adc:qcom,spmi-iadc: txt to yaml format conversion.")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
index e0e0aa9d5d5b..16889d2d3575 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
@@ -50,7 +50,8 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
-    spmi {
+
+    pmic {
         #address-cells = <1>;
         #size-cells = <0>;
         pmic_iadc: adc@3600 {
-- 
2.41.0


