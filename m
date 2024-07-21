Return-Path: <linux-iio+bounces-7767-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35656938448
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jul 2024 12:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9B572814B5
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jul 2024 10:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35652156C65;
	Sun, 21 Jul 2024 10:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="FyOonOGn"
X-Original-To: linux-iio@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A82615687C;
	Sun, 21 Jul 2024 10:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721556965; cv=none; b=jxzCsDwmWbUTMTx5bmIjOMxkIOyIgA6XfUS6Of5TpUqmRCIng16wwNd1E+Ppiz269QwH0+FHMEDL8mkaRn3CZIAcHIj5Bs5miW3IVhFk7vIR5Ajl0wPyzgVFmx1gQo1hR6KNlu7ov6JYjWgcTueMH83P8dAU3+rkiw3AwL/1VOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721556965; c=relaxed/simple;
	bh=U4WEKP8OA3P3RwGwFW6NBkDsoThkdQYReyfDpw0XKf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZRYQOwAsZ7pHvIxtby99p+6rgUfSG9UEVrRNHy22Yj3DqIb9k0X2xYiZimf30GtIjngigAySVo9IiG/hSHBwsQAqo8pKSLckdM5VjYudPYzwwlEc/6Qk1MvMRyv50gPFORrNHoewRvskw9bpapN5CjajHR29Yayu0mvb4qHkuSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=FyOonOGn; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id EB9EC41A05;
	Sun, 21 Jul 2024 12:16:00 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cVJLL9jYySKI; Sun, 21 Jul 2024 12:16:00 +0200 (CEST)
From: Kaustabh Chakraborty <kauschluss@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1721556960; bh=U4WEKP8OA3P3RwGwFW6NBkDsoThkdQYReyfDpw0XKf4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FyOonOGnF0euP02JumhAUimPFvUkUZ0fD149n0FK6+luaDZGr3nGyZ0DB1BDDCBv6
	 PePpy7odLEnkJ/hUAaanLkN6zKpXFJ0Ju4th/2SZqtfhJQyeBntsDn2fA14VCro0Kb
	 IRMkkZv2ZOZ+NEBVW4VjirLqVIYxsfKConS90DJw+KN6kvmPHSZsKdsJxJsw+Faci6
	 BFu0nkOrm1mRSP3lh57IFlU+H9/402ql0J56Fu2f/UlPA17BPAKFE6ODDOHdlmy/0m
	 VR/rQNJAhecVmhOvcFnkX/Un8tcWkpE2q2a1MtLU3JvMdZq0xldmLqyjUmfAOBmx8W
	 P3XktJn8rrZZg==
Date: Sun, 21 Jul 2024 15:44:31 +0530
Subject: [PATCH v3 3/3] dt-bindings: iio: light: stk33xx: add compatible
 for stk3013
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240721-stk3310-v3-3-98fcb6f551a1@disroot.org>
References: <20240721-stk3310-v3-0-98fcb6f551a1@disroot.org>
In-Reply-To: <20240721-stk3310-v3-0-98fcb6f551a1@disroot.org>
To: Jonathan Cameron <jic23@kernel.org>, Conor Dooley <conor@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>

STK3013 is a proximity sensor by Sensortek, bearing chipid of 0x31. Despite
being marketed as a proximity sensor, it also appears to have ambient
light sensing capabilities.

The part is fully compatible with the existing implementation of the
device driver. Add the compatible string of stk3013 to the existing
list, with a fallback of stk3310.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 Documentation/devicetree/bindings/iio/light/stk33xx.yaml | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
index f6e22dc9814a..d5f6b622c8da 100644
--- a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
+++ b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
@@ -18,10 +18,15 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - sensortek,stk3310
-      - sensortek,stk3311
-      - sensortek,stk3335
+    oneOf:
+      - enum:
+        - sensortek,stk3310
+        - sensortek,stk3311
+        - sensortek,stk3335
+      - items:
+        - enum:
+          - sensortek,stk3013
+        - const: sensortek,stk3310
 
   reg:
     maxItems: 1

-- 
2.45.2


