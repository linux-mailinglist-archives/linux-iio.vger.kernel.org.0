Return-Path: <linux-iio+bounces-7951-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC15293D8C3
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 20:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6E2283B3C
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 18:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BF413FD66;
	Fri, 26 Jul 2024 18:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="giBRPYVi"
X-Original-To: linux-iio@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF0013CF9C;
	Fri, 26 Jul 2024 18:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722020039; cv=none; b=VBEFvqhJMyMZxkZxbie6qmOZViPp2t7QEZbq64AwqVnr9Y7ruAnVbFrnWTo7aduedkO1tcefOre372VxDF3grbB4Pl7MGvMDoFj7PD/4pxaazao7IfWmMKoQRJ0L6xTDMW7KGpgynSgJmU6fz3NWbIes/eVt06rvgRcuUVhg2g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722020039; c=relaxed/simple;
	bh=1KCDwBHzt4Q+DteenjlZeGia75XcgPCBUa4IrYWwLSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nHmOsbbMCVEVpNiApCdsJ2D0TzZthjRnNwqFdjzvbqvyE5OQ38N2qC4zxuR5xMpPy80vd+Rguhkl3m/VXtT9eZFdPpfrlSll7nDRl4Lj6uRiWngRB/w13UDqD5w0R379t96p/pDLIoipYbpxLMaaUz/sK8zps+g7fj7nfU2QqoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=giBRPYVi; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id A8F6F41645;
	Fri, 26 Jul 2024 20:53:56 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BSK8HtbJLmbS; Fri, 26 Jul 2024 20:53:56 +0200 (CEST)
From: Kaustabh Chakraborty <kauschluss@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1722020035; bh=1KCDwBHzt4Q+DteenjlZeGia75XcgPCBUa4IrYWwLSg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=giBRPYViicqa6jaK1ESAgoOEvIYZeIxLSPByH/ln3pWGzMjghfc0Ufa8U98JfuOCY
	 KdYJulBeC0RbMxTUFSTkl5X/uO8pO/k/waRObF96syRa/8DIbzFTRa4H81IeIb5A4f
	 cNaCUfIqtYnunGX9SvfRtE6+3edkVugErTi194fzBcrD1OztRMO1sRl7lzpfppxkdi
	 62eCpwlwcPLlg61UwDPKQuJlQsI9dohmg1IrEtcdxyh1C35lsEzNkNawq+TvPTWzj5
	 MQCL6m7IN0S7j+nujd4W1o9i2LQYFdb46ZGZr3hk2wnYvqcpeR4PDYFyz/tLNqSRmI
	 36BdQ6OP9dJ7g==
Date: Sat, 27 Jul 2024 00:23:33 +0530
Subject: [PATCH v4 3/3] dt-bindings: iio: light: stk33xx: add compatible
 for stk3013
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240727-stk3310-v4-3-02497b1407ba@disroot.org>
References: <20240727-stk3310-v4-0-02497b1407ba@disroot.org>
In-Reply-To: <20240727-stk3310-v4-0-02497b1407ba@disroot.org>
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
index f6e22dc9814a..e4341fdced98 100644
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
+          - sensortek,stk3310
+          - sensortek,stk3311
+          - sensortek,stk3335
+      - items:
+          - enum:
+              - sensortek,stk3013
+          - const: sensortek,stk3310
 
   reg:
     maxItems: 1

-- 
2.45.2


