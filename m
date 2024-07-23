Return-Path: <linux-iio+bounces-7830-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351A593A9A0
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 01:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6775A1C228C3
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2024 23:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFF9149001;
	Tue, 23 Jul 2024 23:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPd6GJlZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D7E148FE3;
	Tue, 23 Jul 2024 23:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721776163; cv=none; b=MmsxMYQVbvdfzJTIw2P1utwrYBkh9WYJV4h8BEnpHARpNUP+n0tiDcug1fPm8rgXqsDMGslJmOsqAsfoV2QwvMdhNaTM+CpIC5T3jHtqfSU++Bnaa0SBamEamTJ0Ps0CaDyVl1u8ygFprzLbG2v8DEnbMPQKNKneuh/+MszqriY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721776163; c=relaxed/simple;
	bh=j2EVut8i0tCcYSWzo0DB380672dQ74PXM4Z5BJKw5Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gGZaiy0MwxFV8r+vB4H8zdoWuQFZSz4ogskNuWMyteavdZ6p/K7AjKVyhoV+rjDPiXoXJ9DVUqVxarhsRoBxiJHdGLOE8n4pnDzYJR6pd9pINQ6ZXGLf1zi3XuT2glVR+m8XBw6BYc/YYq8sPsM0t9iy5Nr/GETzIdsOpYkckUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPd6GJlZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DAF9C4AF09;
	Tue, 23 Jul 2024 23:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721776162;
	bh=j2EVut8i0tCcYSWzo0DB380672dQ74PXM4Z5BJKw5Q8=;
	h=From:To:Cc:Subject:Date:From;
	b=OPd6GJlZ+8k0ARgi0N1puIpEMBIiUG+Q0DxEXuVAVcMml0KikUYKtkcC8jnJrt4Jt
	 aq+p4xwEI7KyRWLM0+OFaV6301LEHRJObpM+Q473+jRc17E8Pc+blsjf74WrZ5UhRD
	 Sgo4yM+DLoWeV4o8Mqu/yOGGOaE+GlvjBr9oAz51x/C3UUekDg1CcdeqUafK7wm21A
	 LXyAVQCbUL14dHIa5zDQjqit1n8omxUmD7mYDSBFOn9kK46tcuns7uhgDeLo9kzRQ/
	 hfY0kcPV4FHBwABKdChtNOnMQhcBF9ihklJ/VZ0dPS//tCN1fPXsFFN9HZkjuX9IDp
	 6LZQ7ilKUlTug==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: iio: adc: ad7192: Fix 'single-channel' constraints
Date: Tue, 23 Jul 2024 18:09:03 -0500
Message-ID: <20240723230904.1299744-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'single-channel' property is an uint32, not an array, so 'items' is
an incorrect constraint. This didn't matter until dtschema recently
changed how properties are decoded. This results in this warning:

Documentation/devicetree/bindings/iio/adc/adi,ad7192.example.dtb: adc@0: \
  channel@1:single-channel: 1 is not of type 'array'

Fixes: caf7b7632b8d ("dt-bindings: iio: adc: ad7192: Add AD7194 support")
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index a03da9489ed9..190889c7b62a 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -120,9 +120,8 @@ patternProperties:
         description:
           Positive input can be connected to pins AIN1 to AIN16 by choosing the
           appropriate value from 1 to 16. Negative input is connected to AINCOM.
-        items:
-          minimum: 1
-          maximum: 16
+        minimum: 1
+        maximum: 16
 
     oneOf:
       - required:
-- 
2.43.0


