Return-Path: <linux-iio+bounces-12817-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B6B9DE90A
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 16:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEB3016370C
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 15:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9329D13BC39;
	Fri, 29 Nov 2024 15:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="zqCLPsDo"
X-Original-To: linux-iio@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F4428EC;
	Fri, 29 Nov 2024 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732892502; cv=none; b=P2bRPCVP4irCT9KodhrKug17eKWmdg4+OBuCKEAfDCa7wKqDEeSy8eFaa+p14YIBJR6gm9KMvo8xi2rUMmX3GVTKPatlRwLIELdNSKtUYRLGaH9hUr67GQAXxr7004J+ab5gG8KF23LeVK0JJyPQJw1993hvDTzNRCc6rAPpkmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732892502; c=relaxed/simple;
	bh=RQfNdZisyJIMC3dzmKDXdUlXITuCgtVPLcmE52b1Gt4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ebrieJPPXDactq9mfS/UISY1+I+T/tB+H8d7N+eE8D6wAJCw9y4mhcKXT15Go5EmxAA41tpNXfu3xSq8bpfS97z5g9Qp3xpS18oq+j2jwL/hmmcZqzfrCcODIh7o91V1nRK9Ey4RSA6QnJYKBAijnEeRFe9pPj/vUebVxZ+7VVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=zqCLPsDo; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=dKoJgDZniSxpLiL/0A6gYr0rNSXYwQpxEjs8iGNoypU=; b=zq
	CLPsDovPTMiIupUT9xZBM3pew7rTLAg3UhZWqvreSp7h9RcY+XSN5UgZtdjLIY4fhFsGdCkv4YKd0
	6jWu7uOD07UcFO3FLEkK96qDbWN5FNJCfb51KGxiqKiOze0bVyffhgRpU/VzYtnbS+2nBGZlFCAS2
	MMBrnjR35GVZWfEDqoW7r+H7lucL4q71cNcdjib+w01zPvMbebUVbxHsplBTvCxE5PZ2ZAmi9Ry2E
	GbeynTGlGtPTFpDNyQ0vNFdblRF7hd98SYhnnsfLHA+SrbWt/u2sNF3Eed8GMInwVGMG7kdd2dbGy
	7pXNFJ3ILujbyN2V/+fVHRB6BkTbwpEQ==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tH2Uz-0001kX-Q9; Fri, 29 Nov 2024 16:01:37 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tH2Uz-000B0A-13;
	Fri, 29 Nov 2024 16:01:37 +0100
From: Sean Nyekjaer <sean@geanix.com>
Date: Fri, 29 Nov 2024 16:01:24 +0100
Subject: [PATCH] dt-bindings: iio: accel: fxls8962af: add wakeup-source
 property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241129-fxlsdt-v1-1-ff7697a47cca@geanix.com>
X-B4-Tracking: v=1; b=H4sIAEPXSWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQyNL3bSKnOKUEl0jA0MjU2OD5EQDczMloOKCotS0zAqwQdGxtbUAPNR
 3TFgAAAA=
X-Change-ID: 20241129-fxlsdt-2012530ca076
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27472/Fri Nov 29 10:38:16 2024)

Add the wakeup-source to enable this device as a wakeup source if
defined in DT.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
index 2d99e3811da07ea0453feafbcf82a227185ecea2..c175f4c4cbdb8f8debb0fe64ed21157f3a878d59 100644
--- a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
@@ -46,6 +46,11 @@ properties:
   drive-open-drain:
     type: boolean
 
+  wakeup-source:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Enable wake on accelerometer event
+
 required:
   - compatible
   - reg
@@ -69,6 +74,7 @@ examples:
             interrupt-parent = <&gpio0>;
             interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
             interrupt-names = "INT1";
+            wakeup-source;
         };
     };
   - |

---
base-commit: a61ff7eac77e86de828fe28c4e42b8ae9ec2b195
change-id: 20241129-fxlsdt-2012530ca076

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>


