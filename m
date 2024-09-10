Return-Path: <linux-iio+bounces-9437-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF1F974699
	for <lists+linux-iio@lfdr.de>; Wed, 11 Sep 2024 01:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4E091F26013
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 23:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00C31B9B2A;
	Tue, 10 Sep 2024 23:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SW2SCJzQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A379F1B791A;
	Tue, 10 Sep 2024 23:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011886; cv=none; b=K5oj3p+vAX09zAB2hlyuLyb6QcF7pJm2zIptgSyjctPbZ3oBKZfEF6pTPRc9c3PIazWzlorScjwEW+xvweg1TvZ/sFMjscFlUi2zsDb0jjLOrv6J0OdElfkQv/oGzbNHMkg3g4TWt8vAE1UPHjsbuGoF1wHkVfL58Cpokcq4O1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011886; c=relaxed/simple;
	bh=s6DRljvjzpmcG+YQ94B0VJq9e8xKed/uTGHw63/egMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fDMw5RTltQA8Vi58N/vyoRofc9un43xcEzUf3+1EJkBFjb+Cztaxyzx2fXQ+xAP2aZlbJfR5QI5+l8r8asLdwSr1UtPXcYSwspsUbrk75o8GEfBK6bAdszGlLHKyDUyJeVRipKe9WHlNXA8kLjAmVwfL4vqWT2Slnk7mySfLkIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SW2SCJzQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50413C4AF09;
	Tue, 10 Sep 2024 23:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726011886;
	bh=s6DRljvjzpmcG+YQ94B0VJq9e8xKed/uTGHw63/egMU=;
	h=From:To:Cc:Subject:Date:From;
	b=SW2SCJzQjoZlj4PwplsrMwhU20et/Y9P0xizvenw25vLaA6oUP+HBj3VV5YMxuL0w
	 qfPqEarx05kzu/CqT/PZI9ZVq1aQZxf5cg5SdFP32/YQRPVShqdX+plgcN29oMgrYa
	 tnDFtpPG/kYmCi0WKVIG0Oa5rj6yJ43LY51Yln0ajDuxwzIXEqydEBGSmZZWV42aX3
	 zeKSs4YfX544xrfN1GDRWPT5U1Zik4KZl8ZnV4r/Q4J49eTdaRFdF25iuNEfFJsHB0
	 wIJ9CMxaWOquWJQtUQqN6ow6LElTDrhUMKWLyhthcPJuvfVrzCBYSvVaDmbGJ4IlA6
	 BJfho+K6uVDnQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Auchter <michael.auchter@ni.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: iio: dac: adi,ad56xx: Fix duplicate compatible strings
Date: Tue, 10 Sep 2024 18:44:39 -0500
Message-ID: <20240910234440.1045098-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

adi,ad5686.yaml and adi,ad5696.yaml duplicate all the I2C device
compatible strings with the exception of "adi,ad5337r". Since
adi,ad5686.yaml references spi-peripheral-props.yaml, drop the I2C
devices from it making it only SPI devices. Update the titles to make
the distinction clear.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/iio/dac/adi,ad5686.yaml          | 53 ++++++-------------
 .../bindings/iio/dac/adi,ad5696.yaml          |  3 +-
 2 files changed, 19 insertions(+), 37 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
index b4400c52bec3..713f535bb33a 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/dac/adi,ad5686.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Analog Devices AD5360 and similar DACs
+title: Analog Devices AD5360 and similar SPI DACs
 
 maintainers:
   - Michael Hennerich <michael.hennerich@analog.com>
@@ -12,41 +12,22 @@ maintainers:
 
 properties:
   compatible:
-    oneOf:
-      - description: SPI devices
-        enum:
-          - adi,ad5310r
-          - adi,ad5672r
-          - adi,ad5674r
-          - adi,ad5676
-          - adi,ad5676r
-          - adi,ad5679r
-          - adi,ad5681r
-          - adi,ad5682r
-          - adi,ad5683
-          - adi,ad5683r
-          - adi,ad5684
-          - adi,ad5684r
-          - adi,ad5685r
-          - adi,ad5686
-          - adi,ad5686r
-      - description: I2C devices
-        enum:
-          - adi,ad5311r
-          - adi,ad5337r
-          - adi,ad5338r
-          - adi,ad5671r
-          - adi,ad5675r
-          - adi,ad5691r
-          - adi,ad5692r
-          - adi,ad5693
-          - adi,ad5693r
-          - adi,ad5694
-          - adi,ad5694r
-          - adi,ad5695r
-          - adi,ad5696
-          - adi,ad5696r
-
+    enum:
+      - adi,ad5310r
+      - adi,ad5672r
+      - adi,ad5674r
+      - adi,ad5676
+      - adi,ad5676r
+      - adi,ad5679r
+      - adi,ad5681r
+      - adi,ad5682r
+      - adi,ad5683
+      - adi,ad5683r
+      - adi,ad5684
+      - adi,ad5684r
+      - adi,ad5685r
+      - adi,ad5686
+      - adi,ad5686r
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
index 56b0cda0f30a..b5a88b03dc2f 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/dac/adi,ad5696.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Analog Devices AD5696 and similar multi-channel DACs
+title: Analog Devices AD5696 and similar I2C multi-channel DACs
 
 maintainers:
   - Michael Auchter <michael.auchter@ni.com>
@@ -16,6 +16,7 @@ properties:
   compatible:
     enum:
       - adi,ad5311r
+      - adi,ad5337r
       - adi,ad5338r
       - adi,ad5671r
       - adi,ad5675r
-- 
2.45.2


