Return-Path: <linux-iio+bounces-514-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 837737FF7F4
	for <lists+linux-iio@lfdr.de>; Thu, 30 Nov 2023 18:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D935281739
	for <lists+linux-iio@lfdr.de>; Thu, 30 Nov 2023 17:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB6B56456;
	Thu, 30 Nov 2023 17:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnEsVTJd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959A556746;
	Thu, 30 Nov 2023 17:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49647C4167E;
	Thu, 30 Nov 2023 17:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701364613;
	bh=9nLDbjfs+ETvIRCdX91WOICNCR5DUplnKXVMUpaXXB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KnEsVTJdjSBUQaLPsCQL0d2FNDhsnCvl6hHPfUhJyz59OJTEAytUzQvzizXXw5cxU
	 6KH68/88eackPZ0fLFaAhHZ30S1oLoysIVlSp/a+yw6whuayJuy+rIk9iM9Zuj7GxW
	 5I/n7E43rVg3MoSfupdD9KU2yHQHaB/7+JRAGwemo7Y9dHTYAR9XONXXAOAgPCcYKj
	 LJjtXYwvtsDRIGJbji+L9rwozmxwwWAY4BkOMbSYUHHsjbeM//6OFnrvHGoujquE4L
	 DjF282SnZk3rKxPS4wurGq40mY0x6mYpS9cbchkbS7vZ7t5rRAUg0/iz9PVYet1u+i
	 utUzEpQ5KkkuQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1r8kfG-0003Cr-2b;
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
Subject: [PATCH 6/6] dt-bindings: iio/adc: qcom,spmi-vadc: clean up examples
Date: Thu, 30 Nov 2023 18:16:28 +0100
Message-ID: <20231130171628.12257-7-johan+linaro@kernel.org>
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

Clean up the VADC examples by dropping a comment, dropping unnecessary
labels and adding newline separators.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml          | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
index eb02715bf691..40fa0710f1f0 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
@@ -239,8 +239,8 @@ examples:
     pmic {
         #address-cells = <1>;
         #size-cells = <0>;
-        /* VADC node */
-        pmic_vadc: adc@3100 {
+
+        adc@3100 {
             compatible = "qcom,spmi-vadc";
             reg = <0x3100>;
             interrupts = <0x0 0x31 0x0 0x1>;
@@ -284,6 +284,7 @@ examples:
     pmic {
         #address-cells = <1>;
         #size-cells = <0>;
+
         adc@3100 {
             reg = <0x3100>;
             compatible = "qcom,spmi-adc7";
-- 
2.41.0


