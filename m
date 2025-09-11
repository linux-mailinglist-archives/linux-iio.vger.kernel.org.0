Return-Path: <linux-iio+bounces-23980-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CC7B5329B
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 14:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B07B484896
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 12:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC243322C9A;
	Thu, 11 Sep 2025 12:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XM1A9Ec6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90406322767
	for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757594634; cv=none; b=WEPPegzJtYLuU2eYmbU6TGoF46PFXrYnP+dQnnmGmMNifv2xyFip+tjFWh6xxp1ajbjMABXfPMmdSF+NI8CAlbOC1f74X6Bn7jPmXs3FVjFEZ0o9a/pFmTmfBc9SsQ8mfj0NTsCGng6PheFw7f5lcU4wBcoPdTHV4e97Ovh1hlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757594634; c=relaxed/simple;
	bh=a+1IafQzMkRqd9Hy7+2ryDB7W6wFRG7cDp4dZjBJvkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G13Sb5y77GE+Y9WlAMpZSL9IzDbxM2tasCJhFhOi/FPDbxjOU0prH1BTVfZdawltpvhuxNZLJmEhESpHM9mBZUe2SP/DZIte93t21HS+t8lk6fBjf9+/jrH423rdo3YFsjJnRuQIVQTiQNxcUxGp1eg2K/aNgqrvYD6hyAR3uWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XM1A9Ec6; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45dfe95bbb7so5974595e9.1
        for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 05:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757594630; x=1758199430; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hoN8KhslkXmRFB53xJxTZys7BqlERNC+NzX0ipuiFjA=;
        b=XM1A9Ec63PIL6dD/4D84TuFrAs1yt7BbgsD9kQGQpLf9tve9uBlsTcOOhMiyufDtkC
         +SCZCAYRbQunKnm8I92kPkmlZ/3aaDTE4QomeQw32b+XCy2U0tGL6kIv+JHS+K/hFM3X
         TEQ64ZP4yo/NZuIrGAYtt8PZ/FgnTaQR50j3h21oFITAwMhTmKr03QOV6lh8Lw2rbVx4
         MBkURDx6eT6LuyWCL+9UYJXFFXTMgpii/hsiz3Asss8BT+L14KcQeFsQqk9Xkl8FS5+y
         MlYI63r/k9TLP+zWw+HG7RKxRVHmf+lUrWmaulbSPyRaxuRi2o/tAAH1k0XfMdYR5V2W
         ULMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757594630; x=1758199430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hoN8KhslkXmRFB53xJxTZys7BqlERNC+NzX0ipuiFjA=;
        b=wJwV0fJE8JE9FbveuKawvuvmrKJ+meUkJWyD7rCTgIiYOjqGVWhmDrAhGHGcXxEr0a
         Jt3NZYDo5icGsW2GMMoAYUH8W4z7P0z92LSOs2CmSWevoZA/2v+0gzwBUxYP6Itcdr/o
         UDOooUscNaBCHkupGRl6CLE7kwMGVuOWGcWMRYLNdKXiXddtTGEiOXFo8sKxRERQ6t7d
         0yHyYAd1PuMmhSR7joxdM/Kx2iik3nhbo/CmV4TZUwo4R2LQlbtsq+wXcYPkpIu11UmN
         JUWBtvIAf5Nml44Rh3x0K3mGVr92YM5XW+n6dRS1vDRsRFnVpq6BFwmNApSFX6kuDhzV
         Kf4A==
X-Forwarded-Encrypted: i=1; AJvYcCVtgAdyvedzN9Ea/1ihoDk+eZ8X9Zg/EZTWVdsHdaZomkstmZbizmXSvo2ANs/RqaReOmfSuFtkLc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyetDB2RDBEwvKxj/H8OgNpQ1+UonlC5GYJLHnAZjKGJAhUdHhP
	RcrJ6zbarvqydIwtjPqxycXlsPk4aNNzuyMGOtrbX7yMHAy34jU67xCx
X-Gm-Gg: ASbGncsecPfHmb4/I/nBZx1X304WCbnBdmcC+TlRqYxICsG2jwVpTuM07AHwSt4VK+m
	gncxMoVHzzee8m6BA8TIEq40TOXztqMtaIPmVQwv1kmLwk8Yz946prQFJeFxKM3htBKdVJDY2T5
	pZR0KWKO8bw6xgEqVIn9ipXKUhwBiIIuta0aJSwBFpAXVJRSBn4OXA2DHs8/ltKa3DGRxN0cXNu
	opubnb367XxeFJw2myVK2j99lAMvGtAJ1Bs7XcoQ6xa/38a5fdcuuo7ThizU1DRsJAucmhVdVJB
	NK1UF+nMuKNbZ+vECyME1zVcr/NMxxik7FMNY25/YWyi8etrq+qfLCHHdDZ7CapqnCbTDpTKp9I
	KeApx/QR/kWQiYZXtNy1AzhmHOzYi9QxZsHaxPZwCRp12HYkxNi9/3P63PrTJO+Pm9W20Htlywf
	+g
X-Google-Smtp-Source: AGHT+IGe1XpReT0Pizyuk+QKSriouplCWFhyveLmKS0j9Z8nPLjbNJUdn7tPUVc9o8qqTN1eAfqofQ==
X-Received: by 2002:a05:600c:3b1a:b0:45b:9291:320d with SMTP id 5b1f17b1804b1-45ddded3454mr190632425e9.31.1757594629743;
        Thu, 11 Sep 2025 05:43:49 -0700 (PDT)
Received: from Radijator.localdomain (93-143-13-188.adsl.net.t-com.hr. [93.143.13.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e03729c76sm22591495e9.6.2025.09.11.05.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 05:43:49 -0700 (PDT)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <dujemihanovic32@gmail.com>
Date: Thu, 11 Sep 2025 14:43:44 +0200
Subject: [PATCH v4 1/3] dt-bindings: mfd: 88pm886: Add #io-channel-cells
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250911-88pm886-gpadc-v4-1-60452710d3a0@dujemihanovic.xyz>
References: <20250911-88pm886-gpadc-v4-0-60452710d3a0@dujemihanovic.xyz>
In-Reply-To: <20250911-88pm886-gpadc-v4-0-60452710d3a0@dujemihanovic.xyz>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Karel Balej <balejk@matfyz.cz>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: David Wronek <david@mainlining.org>, phone-devel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1291;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=8lO4nr828tWQwLxmjjV752k5xLRe27/oDan4m5yXVVA=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBmHjjA+mxQe8XOnYVTbmVm3Gx2atTRdJabx75wyq3Zf6
 aVbtmzzOkpZGMS4GGTFFFly/zte4/0ssnV79jIDmDmsTCBDGLg4BWAiB00YGd48eV8Wb/rMZhvX
 7OxNz3zvl31c9OLnza+ZZaYe2tIWLd8YGT5wprVvncL8rHe6ZNFE1fLQGbG54esFlARtBF83uCz
 ZzwgA
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

From: Duje Mihanović <duje@dujemihanovic.xyz>

Add an #io-channel-cells property to the Marvell 88PM886 PMIC binding to
allow referencing the IO channels exposed by its GPADC.

Acked-by: Karel Balej <balejk@matfyz.cz> # for the PMIC
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
v3:
- Update trailers

v2:
- New patch
---
 Documentation/devicetree/bindings/mfd/marvell,88pm886-a1.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/marvell,88pm886-a1.yaml b/Documentation/devicetree/bindings/mfd/marvell,88pm886-a1.yaml
index d6a71c912b76f7d24787d346d4b4cd51919b1cf6..92a72a99fd790805e775727e39d457608fa1795d 100644
--- a/Documentation/devicetree/bindings/mfd/marvell,88pm886-a1.yaml
+++ b/Documentation/devicetree/bindings/mfd/marvell,88pm886-a1.yaml
@@ -35,6 +35,9 @@ properties:
         description: LDO or buck regulator.
         unevaluatedProperties: false
 
+  '#io-channel-cells':
+    const: 1
+
 required:
   - compatible
   - reg
@@ -53,6 +56,7 @@ examples:
         reg = <0x30>;
         interrupts = <0 4 IRQ_TYPE_LEVEL_HIGH>;
         interrupt-parent = <&gic>;
+        #io-channel-cells = <1>;
         wakeup-source;
 
         regulators {

-- 
2.51.0


