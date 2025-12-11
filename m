Return-Path: <linux-iio+bounces-27006-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ED4CB5387
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 09:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9474E304E55B
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 08:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D622F6592;
	Thu, 11 Dec 2025 08:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="B8t9I1BI"
X-Original-To: linux-iio@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA8B41C71;
	Thu, 11 Dec 2025 08:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765442828; cv=none; b=OFFWzrrGSqSjtmLqOxIE8gLRoO5YTz//5CZ0doD+IhTotUh7wbnZ7U6/ePkbQP8hD0MhUDHmJ1DE9cjHTSPkxF6KYEeEWhNoRrUroPGy8qsLi5SqWUVt2lsm2oQDg4wAv0/hw/6zt9SteWlJUB3VIK46Rme0zzjj12nvI1gfrks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765442828; c=relaxed/simple;
	bh=IO32uN08wSLVBaTvAz1jQdyNr+G1ASvU88TQ4UeRBYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BBJ7Y+axR7MdgNbNJpa1IEfwvyUh+W0ziEDgC1OAo19NkdAAWfBfjuvYtvNfwUGeYUXoWTyq9g7FoYQQserlPIYHE+1PKS4/PaT1onRuFfRbj6iKDrAb5/rw13jUdI7K1NDIUCH8oqJdOSFD7GZLELo44o01qOBlOzwpEYom0N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=B8t9I1BI; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1765442824;
	bh=wKc2i0CrPvuU1yF1mbUmVahRwUdSF7nDlBOZD6lUOdk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=B8t9I1BIs5UeAK2qrj6W0cam9GDEz9JQEsllJCfUXrNppjnaHgcRHhW/9sQOYq5Y5
	 Ebhpy5xshRlM30oEfH8+BHfvFLG19aZ98PEloPYo/q9BIbt/YWuDd9UNbUOPY3Ufgf
	 RQs4vTNHdEr+XKoqQF/5SZLFQA36B3Gy8a89R2AhJoXirgahN0C0IjoanRa8wV50pq
	 +Gj9Oy36Q+S4+jRIcknK8OtPGfypeQxD1dBkbHZ2oKjrsey6rUGHSa+OHLwggUKLYG
	 //JetDhyHkm+nCznnAMj+skz8xW533V6aGKRFJQzrd4OmBEiN6NBWEXIdfGYSA5WAq
	 Jw4xesDSSU43g==
Received: from [127.0.1.1] (fs98a57d9c.tkyc007.ap.nuro.jp [152.165.125.156])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7081A7D6B0;
	Thu, 11 Dec 2025 16:46:59 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 11 Dec 2025 17:45:49 +0900
Subject: [PATCH RFC 07/16] ARM: dts: aspeed: Remove sdhci-drive-type
 property from AST2600 EVB
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-dev-dt-warnings-all-v1-7-21b18b9ada77@codeconstruct.com.au>
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

The property isn't specified in the bindings and is not used by the
corresponding driver, so drop it.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
index de83c0eb1d6e..3eba676e57f1 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
@@ -314,7 +314,6 @@ &sdhci0 {
 	status = "okay";
 	bus-width = <4>;
 	max-frequency = <100000000>;
-	sdhci-drive-type = /bits/ 8 <3>;
 	sdhci-caps-mask = <0x7 0x0>;
 	sdhci,wp-inverted;
 	vmmc-supply = <&vcc_sdhci0>;
@@ -326,7 +325,6 @@ &sdhci1 {
 	status = "okay";
 	bus-width = <4>;
 	max-frequency = <100000000>;
-	sdhci-drive-type = /bits/ 8 <3>;
 	sdhci-caps-mask = <0x7 0x0>;
 	sdhci,wp-inverted;
 	vmmc-supply = <&vcc_sdhci1>;

-- 
2.47.3


