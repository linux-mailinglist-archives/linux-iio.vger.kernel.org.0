Return-Path: <linux-iio+bounces-510-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BC47FF7F3
	for <lists+linux-iio@lfdr.de>; Thu, 30 Nov 2023 18:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0298BB2121C
	for <lists+linux-iio@lfdr.de>; Thu, 30 Nov 2023 17:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91DC56755;
	Thu, 30 Nov 2023 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/g5oOz2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6365556456;
	Thu, 30 Nov 2023 17:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137BAC433CB;
	Thu, 30 Nov 2023 17:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701364613;
	bh=NP5nEKKAbqzx7TvXe3SZBdwhS28a3lTCzwA7uNU8zG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d/g5oOz2xuqaGz9szs6S3Gitcw056NUkC39XnJcmxlvIVI/n+f7IUFgBXTvPB/wqA
	 fDqkxRnyKPIyfEPYQFVswnTj5a91wOE5Qdm4OexMXpgco6pwUlKlz5E9zFxdSF1JpU
	 aOy6W4GzWi8FOuS7OSRi1Qc1tGmdjE4l27Y8Y0FxRkzicHFZofLDTWHPL6TYdHqL/F
	 zNEC2g1PdGL3ldp5UInOaA/mbd8886I7DrYsc37qYNhKH88IQfIdL3NnVwTOjE3cAh
	 KKS+IGbHzgNJ5S4HSazLGs1GTgjGU3BEEwEImxW8dnz49wMmB5j/cIcsRiBgupS7LX
	 DAfQ9/9jnBHFA==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1r8kfG-0003Cg-1L;
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
Subject: [PATCH 1/6] dt-bindings: iio/adc: qcom,spmi-iadc: fix reg description
Date: Thu, 30 Nov 2023 18:16:23 +0100
Message-ID: <20231130171628.12257-2-johan+linaro@kernel.org>
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

The IADC register is just the base address in the SPMI PMIC and does not
include any length.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
index 73def67fbe01..e0e0aa9d5d5b 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
@@ -25,7 +25,7 @@ properties:
       - const: qcom,spmi-iadc
 
   reg:
-    description: IADC base address and length in the SPMI PMIC register map
+    description: IADC base address in the SPMI PMIC register map
     maxItems: 1
 
   qcom,external-resistor-micro-ohms:
-- 
2.41.0


