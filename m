Return-Path: <linux-iio+bounces-27012-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BA0CB5402
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 09:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DD393019195
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 08:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2752F9DA4;
	Thu, 11 Dec 2025 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="mPJU9qQD"
X-Original-To: linux-iio@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915122F99A8;
	Thu, 11 Dec 2025 08:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765442861; cv=none; b=hGDIrNdoLXHee4ziuy4BMo765LSVa0hX9ovX8zn0QnTXZFdN5r6YGKl7rWQOC7pADzuer1rX+gyN+VtfsTEsC6VPOjKELlfmY0eHPOPj4F0WDNyDDPbKumSoRc+02HpRwIY/v+sqozHDrc7t1PT9D28KuneEnT/Bhne7N6iwbbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765442861; c=relaxed/simple;
	bh=3E0U1888CNiG0hMbqtJXyoQs/PvdX6OIhDZML47p3YI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C7HTJpXcnzO31BLWRaVjUuLrFMP2+FET2zi9yssSQmzr2yQHttMKy6IbzTk7aBZ3TOycCjkg0TdjN3FVncEfWHQNAm6lcTLd+nPxTtevALKpBD7/4YuRvmKldLQ0gQB+Ds7Shrs1vvWTbFGnhwpb1PV8ucXKPzsWxKzjWUuEboc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=mPJU9qQD; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1765442857;
	bh=rpT9+i/Mb1SzFndodK6pjHk1FnR6Em20V+C0liaihVU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mPJU9qQDNoqh6NyKrVyLU5d/zHaZ3HmrsgYxTaXWxGDJqrLl9XCO5Kyym/D44eTwb
	 kw3QVLMOGJo0VhETRgFYBiU0uaQUx/4B831bSKtILSHUHMLX+9NU2qc8owG/48faS6
	 VfbuLxJRbGLUJmhfw01dlr+OJrYK1h2k8VVY2ycPQoJ2PKNEt0i/Kwu4GcaJ7cWDly
	 XJuikW9rtL/XPJF8nFDxgHeOM2duqxRRlLO0KUMuRt19FeCfqi0gKNNF7nhS7kCgoi
	 GgnaR3/gCJhRcVhSrYyWsnBQTrJxgkhKzdlt5wthe8DSysaNhnzafs8KSTLLOmIGop
	 ZgjwksnDNe0Tg==
Received: from [127.0.1.1] (fs98a57d9c.tkyc007.ap.nuro.jp [152.165.125.156])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B49F87D6B0;
	Thu, 11 Dec 2025 16:47:32 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 11 Dec 2025 17:45:55 +0900
Subject: [PATCH RFC 13/16] ARM: dts: aspeed: ast2600-evb: Tidy up A0
 work-around for UART5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-dev-dt-warnings-all-v1-13-21b18b9ada77@codeconstruct.com.au>
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

Changing the compatible changes the properties allowed -
snps,dw-apb-uart doesn't specify no-loopback-test, so remove it.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
index c51977dcb56b..3f2ca9da0be2 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
@@ -205,6 +205,7 @@ flash@0 {
 &uart5 {
 	// Workaround for A0
 	compatible = "snps,dw-apb-uart";
+	/delete-property/ no-loopback-test;
 };
 
 &i2c0 {

-- 
2.47.3


