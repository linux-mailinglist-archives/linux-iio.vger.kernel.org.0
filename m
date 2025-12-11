Return-Path: <linux-iio+bounces-27002-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC1DCB52E2
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 09:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6010D300EE5D
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 08:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514C42F0C6B;
	Thu, 11 Dec 2025 08:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="TWkruskj"
X-Original-To: linux-iio@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713532F12D3;
	Thu, 11 Dec 2025 08:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765442806; cv=none; b=GTVZ9rivIfJ/1Y1Bb9IXQuQGVaYVEefMYDF0aVtL8+GfR+Vihwv4Gkrq7404lT+Koamw5G7I9W/uaVywOXcmu9bEHpmAioxhPIzIgCWHSj3qsk9vqya4KG0wZuV3FGNO/UhinEyA6SCiXETBC15OXUJVpulQ71+CB5QLYeGDAbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765442806; c=relaxed/simple;
	bh=g9KiP5YmfkIXRTFevBWBXT9Ni7Um26tLmaL5270MxGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bb/u9MQXqUS82cMDePDa3uColW+UUswx01xWfPk4mI3t0UY+5D4YsZ7sSSsEZpLrXjU+nfxCypVha1NK4afba5nPQaSSjOD0YgxEPPCIcWyThGL+/mu9fd6uafOge8Ag7ICE9QojRMIgxg0qu328ybE0E+UaANsjpTl1aeJPWbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=TWkruskj; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1765442802;
	bh=ZaCIgDIvXKFxlEh06PZUH9olbYn5peflfwgiHUXeKWQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TWkruskjvN7xj+MwWy10jjXI8sxa0fzMzbL6LBnv2B523ZUUvxFbWBWM2wCe00jbH
	 o0KiKfbCRlC7MsTUEs8PDWIINz5BZLriBTcb/D/OkEsNERjaYzeRe+2WUBSk6xWYyh
	 15LKTC2e3qhOlvQRf2dW+enVMbnkcKG8uRHJ605jPyOFgZmOlQ2SCZEeuqpdtodBt0
	 LUg6OJUfKZtSsb6Gx8lfRjOJqPtN4vmTtGLuHK4zjxooP/iZZZF/lJmbWmBXBSfdr6
	 CuGz5H4GA3zJoZJGURJgXXG1iLW9ozmv7i6cgoMeKsnP5iYw2w0TOvnLCtBQupmAc3
	 1BnOvhaK7Q7nw==
Received: from [127.0.1.1] (fs98a57d9c.tkyc007.ap.nuro.jp [152.165.125.156])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 85BCA7D6BB;
	Thu, 11 Dec 2025 16:46:37 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 11 Dec 2025 17:45:45 +0900
Subject: [PATCH RFC 03/16] pinctrl: aspeed: g5: Allow use of LPC node
 instead of LPC host controller
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-dev-dt-warnings-all-v1-3-21b18b9ada77@codeconstruct.com.au>
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

There's currently a wart where the Aspeed LPC host controller has no
binding specified, but the pinctrl binding depends on referencing its
node.

Allow specification of a phandle to the parent LPC controller instead.
Fall back to testing for a compatible parent node if the provided
phandle doesn't directly resolve to the LPC controller node.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
index d4c364d19d64..7d818b4da1e3 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
@@ -2648,24 +2648,34 @@ static struct regmap *aspeed_g5_acquire_regmap(struct aspeed_pinmux_data *ctx,
 	}
 
 	if (ip == ASPEED_IP_LPC) {
-		struct device_node *np;
+		struct device_node *np, *rnp;
 		struct regmap *map;
 
 		np = of_parse_phandle(ctx->dev->of_node,
 					"aspeed,external-nodes", 1);
-		if (np) {
-			if (!of_device_is_compatible(np->parent, "aspeed,ast2500-lpc-v2"))
-				return ERR_PTR(-ENODEV);
-
-			map = syscon_node_to_regmap(np->parent);
-			of_node_put(np);
-			if (IS_ERR(map))
-				return map;
-		} else
+		if (!np)
 			return ERR_PTR(-ENODEV);
 
+		if (of_device_is_compatible(np, "aspeed,ast2500-lpc-v2")) {
+			rnp = np;
+		} else if (of_device_is_compatible(np->parent, "aspeed,ast2500-lpc-v2")) {
+			/* Maintain compatibility with old aspeed,ast2500-lhc node */
+			rnp = np->parent;
+		} else {
+			map = ERR_PTR(-ENODEV);
+			goto put_external_node;
+		}
+
+		map = syscon_node_to_regmap(rnp);
+		if (IS_ERR(map))
+			goto put_external_node;
+
 		ctx->maps[ASPEED_IP_LPC] = map;
 		dev_dbg(ctx->dev, "Acquired LPC regmap");
+
+put_external_node:
+		of_node_put(np);
+
 		return map;
 	}
 

-- 
2.47.3


