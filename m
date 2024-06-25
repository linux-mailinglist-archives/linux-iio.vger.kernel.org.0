Return-Path: <linux-iio+bounces-6914-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8BF916E8C
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 18:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 087E11C22CF1
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 16:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA202176254;
	Tue, 25 Jun 2024 16:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="hhlitPq3"
X-Original-To: linux-iio@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1176174ED2;
	Tue, 25 Jun 2024 16:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334368; cv=none; b=A/RH6wCMY1gmu27OT59G8/x2BnOp9GNZ9EAXqq+Lr6Du4fwrFL6Lv7WySRp+R4/O0YDSd1uJO1tCwRxwa34nbNZ6bwgcDt174tbP/m/dqgMOvs8M4p34tUi2GJ9xcz+/j8PMTR8Pw17L1NLZJpHMXQ1j0gEgyKxSoBGOEMBOpGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334368; c=relaxed/simple;
	bh=39UsyjL9EP1PAdrBgELTOcXGolrV68DGXQAkjwpdElU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLpsSDZPp532S+DXKzOpDYw7jDZA8Un55AjGO8F4mlb/UXKKCieSWB0dBjFoki4NM1/b1GGum86RQIxEMR8ml+QWbMfEKjdDsaFLxijrpp5xZTWWolS1piQRsVLehFCIMGEYIkVsqe+PjeEzfn8yIKxzogPFg/B9AC91Rn13Cz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=hhlitPq3; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
X-Virus-Scanned: SPAM Filter at disroot.org
From: Kaustabh Chakraborty <kauschluss@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1719334361; bh=39UsyjL9EP1PAdrBgELTOcXGolrV68DGXQAkjwpdElU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hhlitPq3Nvo4ZCypF+4Z3yToisK89YnVwB1+zYdefJQxIED3GIeS59QsSEsBjt4GI
	 kMqABX5ffDb10NjYo5TeL9e9m6FC0m+9xolBsG8rV2oQTayVg/Hqxm396XgYAEaqqi
	 2HuI31HnwytqTJoF0oz0/P9SK5WQnPR1nIVKiRt+GB7kORdnn1AoM2Wlm/uQhwwt5B
	 3gxd39wY6Ce/R3/5ZAHO8kGPKCob8OZBeCHMWQt+Yc1YZEVQcNdVYoHWW/NOp3IEI3
	 qHZ2GWWli7kEIGUMAKdpsPw60PqIPdFIhxQnMYaETRLTLpI7C2KCfKjLigPglIzQuo
	 op325CmX/4qNw==
To: linux-iio@vger.kernel.org,
	jic23@kernel.org
Cc: devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH 2/2] dt-bindings: iio: light: stk33xx: add compatible for stk3013
Date: Tue, 25 Jun 2024 22:21:06 +0530
Message-ID: <20240625165122.231182-2-kauschluss@disroot.org>
In-Reply-To: <20240625165122.231182-1-kauschluss@disroot.org>
References: <20240625165122.231182-1-kauschluss@disroot.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the compatible string of stk3013 to the existing list.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 Documentation/devicetree/bindings/iio/light/stk33xx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
index f6e22dc9814a..6003da66a7e6 100644
--- a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
+++ b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
@@ -19,6 +19,7 @@ allOf:
 properties:
   compatible:
     enum:
+      - sensortek,stk3013
       - sensortek,stk3310
       - sensortek,stk3311
       - sensortek,stk3335
-- 
2.45.2


