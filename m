Return-Path: <linux-iio+bounces-24064-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A037B561DA
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 17:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8DDE3A7338
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 15:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460CB2F28FC;
	Sat, 13 Sep 2025 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="nNtz6+M/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C14C2F1FEF;
	Sat, 13 Sep 2025 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757778014; cv=none; b=TBerhn6YvGEHm2MRczqjXfENWOwEsDCHLLLmDk+gqdR1eXgUbA5w/WN1Rzj/S/A7lT8u1p8h/TZ806Ra92+dRjEmhUG5Hewtpduw0W5QQZlrvJzENMOVJiwkxz57Se1+xHWjVnmA/1fHOf0BWLHOZBNeJ+NQhwrQQ7GpxWp3UZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757778014; c=relaxed/simple;
	bh=EBNhVOW8hBoqmeWeZW+H82GxsVcMw+E2abP5SetbUuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gn7aObSuVpFNMEwkljFyfx7dHE3pvQuUMJCNtaA+kBtFwY07MbZgdWIb8TDvBE10qu70/ED2oCHEzF8U0+Unm4cKKxF/hEJVnpNjsnwN2NQNVqT+kwBB8RpxcD5k2BJ0wvtoAvHu5Iwhs/cvo8yI5Rb7wwK96AzKMlq2w8bfslU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=nNtz6+M/; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 1E962173BEB;
	Sat, 13 Sep 2025 18:40:05 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757778005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HdRafdIBJZDMJaY2Ja0JkowRHXTp0cry90yvfDRdsX4=;
	b=nNtz6+M/gA2wq4Z+VmheNknfPBKB4sIqTWTFjQYBYhhxc/SaUejSg3f9v+N9NdA3bSlbVg
	WizwP2GnR5FY65aBq6JqFoYgYDhXAvxQ6kUp/apLtBIFxoAoA+t75+gC2YpmzQ4SOIklm/
	JuIJ1lVSgwbEf8J4kpi8lWXgVETVtuX4dE30lGZDNj5LIXaMTyIlr6Ck4OuBpsVHDzmEms
	w3KugByp06By4bbow5oGt7i0xgNh+vpMKo99YMcSN3Z062Wu8WsVwtgKAfRBydr7ayGCrX
	Ib6VgL5j/9SbamWLaAqlGya4ie5UA7W5qICst9+dPgryj2y9mwhIKobXOTkQ4g==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sat, 13 Sep 2025 18:39:24 +0300
Subject: [PATCH v3 03/18] dt-bindings: iio: accel: bosch,bma220 set irq
 type in example block
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-b4-bma220_improvements-v3-3-0b97279b4e45@subdimension.ro>
References: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
In-Reply-To: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Petre Rodan <petre.rodan@subdimension.ro>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1094;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=EBNhVOW8hBoqmeWeZW+H82GxsVcMw+E2abP5SetbUuE=;
 b=owEBbQKS/ZANAwAIAc8mmZmETn8wAcsmYgBoxZBRtiIAzJv+T4Ow7l6Wu/0PLqOA4B4xOamB5
 LSPnNpopUaJAjMEAAEIAB0WIQTYCn/BdhUZNew+X6nPJpmZhE5/MAUCaMWQUQAKCRDPJpmZhE5/
 MBy0EADI9uDRc6yD5c6XyGoVrncIff7P+rNP4/klJN4P0/tmWSGOywWYZzrl98ZUHFIpbIO13RW
 YcvzvIO+dZT8OX1ElRDGLwnC0lKjlo3z442BeBDGXd4H+2/MD5FgqUavt2v3DqEBPSE4LFHrVeW
 b8g48P2i2B/usNhejdoZmi+RQOdONX4mqc9AuKfgLzomZJ3QJt8eUCD3yZQwZkxs+ecYoThWVM0
 HpQEHDXRlTX8xhKfLEgCVIyfFbxYbcs1IPjkx1SiQ49Xgr/9fXlVdNTTuPU+KES/Wx4YNEzoosW
 6hSnMPBj8igE8e9TvbEz20BgiwFDsZDd6vcwpKK9lbO33REJ4QpEDJ9rXD+TxFmNJNQuvskCJUg
 sdgjFNDIm6qtO/IA5/iGF5tEIycc+vFAXu/hQ9V5KZomZdc9BV49I7/vIvHUVk4qYgUU13ncRQC
 AHQYMa2MfopKft9c+1iIcSial98B38QlPLvASp/PftumAGirkBy/BKbSizS6e1PON4WBIgnVk6T
 4b7n8BaPiurAYlq7kQrkHzM6ykZWkVZyhKHYwDr7tCTlrys5NCqYZGRdwbIVpgSYM1p2Vk72alN
 GnwPvWoVsn++0dGSZMKaUVAvC8si/r8irJrnK/Mi2KIoNafrx9O0HeYD0iuQST8GkYweMUMKnx6
 tzYR1HEHdZaLuAA==
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Set the interrupt type to rising edge within the example block in order
to match the new driver.

The entry that got replaced was not in use by the original driver.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1->v2
split out from a bigger patch file (Krzysztof)
v2->v3
reword commit (Krzysztof)
---
 Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
index 0e27ec74065acca611e63309d6ae889b8a3134ce..8c820c27f781e8001bc14b4ca6ab1f293bdb18ca 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
@@ -50,7 +50,7 @@ examples:
             spi-cpol;
             spi-cpha;
             interrupt-parent = <&gpio0>;
-            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+            interrupts = <0 IRQ_TYPE_EDGE_RISING>;
         };
     };
 ...

-- 
2.49.1


