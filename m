Return-Path: <linux-iio+bounces-513-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AEB7FF7F5
	for <lists+linux-iio@lfdr.de>; Thu, 30 Nov 2023 18:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4FA1B20EFE
	for <lists+linux-iio@lfdr.de>; Thu, 30 Nov 2023 17:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA1756773;
	Thu, 30 Nov 2023 17:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVd8TUgE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E0156743;
	Thu, 30 Nov 2023 17:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18632C433CC;
	Thu, 30 Nov 2023 17:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701364613;
	bh=AowRuTyqJMXQ7HEnVFHNnSTtCHBVspL3ySQdRhlv0+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pVd8TUgECZ3Ltm18UYL+yMIBPmjh9fIaAg8O44hlvh37FNdLjzT+PKv9xAmIq1bFT
	 9LYOD+GDKOC2FHtS8nX6EABu00l8tsZ/eax4/Eb+CNwoh9StRoh9Z8wro5B33Cl9bC
	 gh6HzUHQNgG34J82HoutJ+nNjwtumtY4bKfjcIyFS+L+UOsJCzOIMjCLzD2GyHIBq4
	 XqpOazbJX6O/EX9POji3EYZpmqZY4DN44YeBjFi+slZOnf2RZvJwvdcu9H5ik+nXt1
	 rGZ1fXx4EKm20KLNORGZuoV5pzkDp9FVUevuIdGXaAqcYSvul10RKrt8Bwi5W3m8GT
	 UqQWZ1+2xCoSg==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1r8kfG-0003Cm-28;
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
Subject: [PATCH 4/6] dt-bindings: iio/adc: qcom,spmi-rradc: clean up example
Date: Thu, 30 Nov 2023 18:16:26 +0100
Message-ID: <20231130171628.12257-5-johan+linaro@kernel.org>
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

Clean up the RRADC example by dropping an unnecessary label and removing
stray white space.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml          | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
index b3a626389870..f39bc92c2b99 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
@@ -43,9 +43,9 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
 
-        pmic_rradc: adc@4500 {
+        adc@4500 {
             compatible = "qcom,pmi8998-rradc";
             reg = <0x4500>;
-            #io-channel-cells  = <1>;
+            #io-channel-cells = <1>;
         };
     };
-- 
2.41.0


