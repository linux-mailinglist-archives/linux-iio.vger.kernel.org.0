Return-Path: <linux-iio+bounces-27005-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 106DECB536A
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 09:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CF3B3042FD6
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 08:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974352F3600;
	Thu, 11 Dec 2025 08:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="LBexYCu5"
X-Original-To: linux-iio@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FDF29BDBA;
	Thu, 11 Dec 2025 08:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765442824; cv=none; b=hWE0nDCuef46iHjkOPx6fGWHOafZJStRzINu6Y+70YPokDHnuLL5qVuSz74xSdN+7+y6qDgG7NV6ikdL/ESM0usSyyRy/iYOKhsLymE0j+i2lk/F+56WHFEGgSRvEMchxE7ThSFc337RhPgZH/AHUnDdQ4FWM2MTtLWspXTWDW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765442824; c=relaxed/simple;
	bh=5c/EtVOwEFrZpuLYD48rxEyL1ambe2YWVVgA5y5GtMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aMP+E58WUMEEBDAVQ9tBTXR4+3j0ilrTU+LVnI71GyVizZ4PA5+FucHDqH+0B7LgsJWMqzlAfm2rB+Y47V0o8WhPaN4ldzSu3LT5mHdl9t0eaxcuOWAFxJPnJjnFSRBIAMqqEzH7Kga954DKKtnRatxJ1DvlyfeCWfygVplVr2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=LBexYCu5; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1765442818;
	bh=xzi4Fz/8qdzZMUIpWOM8hn8WXDg65D2r48ph45pVRFM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LBexYCu5FLXa70UuDT+IeSRE9494xvFnAQ5B1VicNIsbUW/qZG3jj6tGJ59lFFv0I
	 R46vEDyKtZxOXwmamOgLKTDcuGERt+/frBHXX6bUkc69HCtm3sg+06255Mp4KZ2dxb
	 stTMwTcVtHS/42CGKOwJLJVKUU9oFQ43SFhZtRmkpOsnn/lPqpi+y0kxyagQv+DqSG
	 H4axat0DbeF83B/6ycx3p61xRxKqi2PeoKRDTFjs+PBJOsLyADQGkNcalLG6gLIEvv
	 Cv6cuNW6EQuYeXPn9nrSIxWREXM2hmAl7sseCtAKg8d+Db5a7WdhH8NvUyOJKvGirY
	 zTGENCcHCgpMw==
Received: from [127.0.1.1] (fs98a57d9c.tkyc007.ap.nuro.jp [152.165.125.156])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7F8D67D6BB;
	Thu, 11 Dec 2025 16:46:53 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 11 Dec 2025 17:45:48 +0900
Subject: [PATCH RFC 06/16] dt-bindings: mmc: Switch ref to
 sdhci-common.yaml
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-dev-dt-warnings-all-v1-6-21b18b9ada77@codeconstruct.com.au>
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

Enable use of common SDHCI-related properties such as sdhci-caps-mask as
found in the AST2600 EVB DTS.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
index 9fce8cd7b0b6..d24950ccea95 100644
--- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
@@ -41,7 +41,7 @@ properties:
 patternProperties:
   "^sdhci@[0-9a-f]+$":
     type: object
-    $ref: mmc-controller.yaml
+    $ref: sdhci-common.yaml
     unevaluatedProperties: false
 
     properties:

-- 
2.47.3


