Return-Path: <linux-iio+bounces-27013-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA78CB541A
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 09:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DE5A301E1B8
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 08:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06742FB610;
	Thu, 11 Dec 2025 08:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="N0E4UmYM"
X-Original-To: linux-iio@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109722FAC12;
	Thu, 11 Dec 2025 08:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765442866; cv=none; b=TG/XlUqsDSdVW6goTN5qGyLES9C6WrXiwO1umoWamz4ohC7pbBoZhaQJIE0KUj3K5fhpJXXZbsN+wRabPjcmX02N6UioXe01Y3ipWiJAPn5ddigZAo20RO03ZQHTW622ZC+MhQ/X8hL6H4rpLOd3lsOdmZ1+S2dHSfWdXGQSbkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765442866; c=relaxed/simple;
	bh=/LULOcnqq7YfCJ3+GZ+GGEf0N6F2nMNlE9wT7DTQI+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QCRL7PbVxXmkT7C9jbBaG+x0r5ZLKnfUs/ouBQAVKumLwO+0vSuFQmOyu5OxgumpdcvzTdC6/76hOVsN/WmQkUXFR+ukrepWfn8gS9cQftu/XDWInQyhTyogyVxXtJK7yOTE+NFDeGhiDfAenhutXpQ+cs9h74QYjiZRQutzV1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=N0E4UmYM; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1765442862;
	bh=QA5RNQcEfirms9HgWj8AssmGCc/5FNo1GGf/ysp2RSE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=N0E4UmYMR2ijnu8okYEs3ej0qTmDYPSsnolgBDBHQXQUyBeklOSMTxvmwqiB1XfUU
	 kN3ZpVQfS67dqTf19F28O4LUE8MSV38xyX7ibzXktLyUNi69uS23ZIJyY28lE5N+df
	 VBeUUNrZlX9i0MzdEEuxqoysSM/GgXD6esgTzWtH5H6Tcyoev2EhySg4EOCEDJk8XJ
	 GIa23Q/YY58ZvlrfHve5yA73oxn2+tA8rBnZhDPbz5bfvIEBVDYSuHX8w25wP0uPqw
	 /wg5SoDm2WGhjTpspHP7NTxW6ekroF7I+DLH+mP2eSdQELxc/1fLg0vNh+4Qd/zpZ5
	 kJ/XRzBv/LSKw==
Received: from [127.0.1.1] (fs98a57d9c.tkyc007.ap.nuro.jp [152.165.125.156])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 29A0C7D6BB;
	Thu, 11 Dec 2025 16:47:37 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 11 Dec 2025 17:45:56 +0900
Subject: [PATCH RFC 14/16] dt-bindings: iio: adc: Allow interrupts property
 for AST2600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-dev-dt-warnings-all-v1-14-21b18b9ada77@codeconstruct.com.au>
References: <20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>
In-Reply-To: <20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: Joel Stanley <joel@jms.id.au>, linux-hwmon@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
 linux-mmc@vger.kernel.org, linux-crypto@vger.kernel.org, 
 linux-iio@vger.kernel.org, Andrew Jeffery <andrew@codeconstruct.com.au>
X-Mailer: b4 0.14.3

The device has interrupts allocated according to the datasheet, and
the devicetree already defines the interrupt property. Address existing
warnings by allowing the property.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml b/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
index 509bfb1007c4..249101b55cf4 100644
--- a/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
@@ -44,6 +44,9 @@ properties:
       Input clock used to derive the sample clock. Expected to be the
       SoC's APB clock.
 
+  interrupts:
+    maxItems: 1
+
   resets:
     maxItems: 1
 

-- 
2.47.3


