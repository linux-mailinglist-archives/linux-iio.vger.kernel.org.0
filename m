Return-Path: <linux-iio+bounces-7549-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6A092FD7B
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 17:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C12F41C239B6
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 15:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D23173357;
	Fri, 12 Jul 2024 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="KH8s7PT6"
X-Original-To: linux-iio@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0097173336;
	Fri, 12 Jul 2024 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720797918; cv=none; b=oK7P81f9PYaw/EIG1SuRTn9DkwJ1OUb6dLvuRmetspLfwjdK2kAT1JNLphsxwA5j/ynmXeD3LR5KzA9GB2Zqw0F+PMMrKoEbA26SOhSp4QEjBm4TqLlewFVzmJVjwxWzkvQlV084FSZMNdyQ0oCH7Q8FFZslQP5UsWW3aymgtmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720797918; c=relaxed/simple;
	bh=39UsyjL9EP1PAdrBgELTOcXGolrV68DGXQAkjwpdElU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPfxdFmb9rCgCHTXt8Y19sSFUrvoerdc+Ook/uZ+xaEe/h+eUA0rhS3MbzUwDFViThjcAtIAa0f2fmgOOqWoP1k1Y24VXO1VcJQybsyQNzlo3yX1mc8cJCQaADXnXE+A1F/CDNIEO9M4SudhYTwsBTcOmgAWK6cBYAO8gV2sVp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=KH8s7PT6; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id B996641A14;
	Fri, 12 Jul 2024 17:25:13 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H9SaWp3caJ0W; Fri, 12 Jul 2024 17:25:13 +0200 (CEST)
From: Kaustabh Chakraborty <kauschluss@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1720797913; bh=39UsyjL9EP1PAdrBgELTOcXGolrV68DGXQAkjwpdElU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KH8s7PT6MEGFVqT4+lo78frWDiDCVz0X3tehopeBT84CjPi8o/7HCgaT0YrzKsgsp
	 f9rhspMP9fdffAaLMg8hnljrLmy+oS4/PWXKZvSM/90wR0E8Fvq16d1sn10jz+UJev
	 lAhhLO9cyDN/l/Mx8pK2cswZRxjsmWyX4XCEEPzlkv54svcBL+m8vxD42aXb/lRq0v
	 eFU4OF6vnwm7YX2LMfx0L8MDeo92iwIc57sZrqf/xzmcV48XWwGa9CXTRMWMxnyAPM
	 N1OeXpaJEu9RvKQ2tW303HG0WlNxQLNwiIiXUJYrZZpkKDOH1+gsY4W5t4CkhlZFC+
	 3Zfq2uL81y1cA==
To: linux-iio@vger.kernel.org,
	jic23@kernel.org
Cc: devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH 3/3] dt-bindings: iio: light: stk33xx: add compatible for stk3013
Date: Fri, 12 Jul 2024 20:54:02 +0530
Message-ID: <20240712152417.97726-3-kauschluss@disroot.org>
In-Reply-To: <20240712152417.97726-1-kauschluss@disroot.org>
References: <20240712152417.97726-1-kauschluss@disroot.org>
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


