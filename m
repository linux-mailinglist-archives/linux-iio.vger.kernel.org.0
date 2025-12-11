Return-Path: <linux-iio+bounces-27003-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD73CB531B
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 09:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D701302CF5B
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 08:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDA52F39B0;
	Thu, 11 Dec 2025 08:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="NOPKQ5h5"
X-Original-To: linux-iio@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A82E2F12D3;
	Thu, 11 Dec 2025 08:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765442811; cv=none; b=PbJ6Q/wU6ZdkrwVStc1rgcs5MQwQnai/jGPhxpzElcc5m+Onf6PQ/Vais16pcagDDezu8m5VDvQ132c2AtDoeTA1juFsWmWOZoga3KeoMM6rklyggfxCEkn7If4gSJsBB+ouHYHLs6H6Vnv2Ieb8zqrHH7JULw3Iguz429TEtmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765442811; c=relaxed/simple;
	bh=/WlEc6U8pyS/3j8HZHZ66ZlBF5zag4AvRyo+osavLtw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C87RaqwXJ4tNk9HxuCQl5asKv25ETSAE3g7u7GA2UujzYfW90yUxWxuS9rRqzPJULwki26i2EuanoYhW7TZl41k150XJLs4sGeCdwXBvdlH/m3dNgxLx1PWVoSdEPdXhntgO6MA1M10C4a3aFx2hHkQeAG7FfRbGx/1YoU6uXzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=NOPKQ5h5; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1765442807;
	bh=64vyUWdNJftGuOm7IF2XaSwKPBkVJqodvt65O40/0gY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NOPKQ5h57DpM3vqHy81icDlrF63oyfNJcef/hUzn3NKElWk3qOLQggAftbYFRRIZp
	 nr93F74IYe1LigaTyenaCOjJPFMHRIGWWSv4VsDY81q5pIHdcEHSMq6aN0JqM7k73B
	 ayIoYa+pA5hSNsFS7mWVQnmhI+gjiFu2XXBvrhbupO7QRXeON5QsLIvOdwKy7pTR/t
	 zaaVcXEz5HkF/uoSOYHqGVJylkJ4G8bXmMz5wni4RDF6CdfjUIOk+FH6YfaqQRt23i
	 9ui0jkpD4X4IjsxSkQtsE3CBE2lhHehLuiNk4qsC79QHXFKITRqp6/IW6mwu4rWgbS
	 xrZborwCkR4JQ==
Received: from [127.0.1.1] (fs98a57d9c.tkyc007.ap.nuro.jp [152.165.125.156])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id DE9BE7D6BF;
	Thu, 11 Dec 2025 16:46:42 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 11 Dec 2025 17:45:46 +0900
Subject: [PATCH RFC 04/16] ARM: dts: aspeed: g5: Use LPC phandle for
 pinctrl aspeed,external-nodes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-dev-dt-warnings-all-v1-4-21b18b9ada77@codeconstruct.com.au>
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

The LPC host controller has no binding specified, and the pinctrl driver
can now determine whether its been provided a phandle to the LPC host
controller or the parent LPC controller. Switch to using the LPC node
phandle to avoid specifying a binding for the LPC host controller for
the moment.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
index 39500bdb4747..1456f04c2139 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
@@ -251,7 +251,7 @@ silicon-id@7c {
 				pinctrl: pinctrl@80 {
 					compatible = "aspeed,ast2500-pinctrl";
 					reg = <0x80 0x18>, <0xa0 0x10>;
-					aspeed,external-nodes = <&gfx>, <&lhc>;
+					aspeed,external-nodes = <&gfx>, <&lpc>;
 				};
 			};
 

-- 
2.47.3


