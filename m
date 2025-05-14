Return-Path: <linux-iio+bounces-19507-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64583AB6303
	for <lists+linux-iio@lfdr.de>; Wed, 14 May 2025 08:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D9F3A5571
	for <lists+linux-iio@lfdr.de>; Wed, 14 May 2025 06:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F771FDA89;
	Wed, 14 May 2025 06:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHxnYFdU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D98C1FC7E7;
	Wed, 14 May 2025 06:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747203922; cv=none; b=OekSpb45sErmAUEVx70q5aF2ok2uUqm1sNy02JVU1100I9XbPJwHmnOrj2TYXupwuIRUUA/UtH540/Tyc4NJmzqoJpMFKZeoll/+w5mqNO/evkeY8UwxcainbR/ICq2YQ9X6bytbPl0MtNXheyR+y+RNEycBPlahpdhDohzB4ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747203922; c=relaxed/simple;
	bh=SxFtNj3A/V71eVMZQHnVZ4xd0hC12ZVeGOedJhpQlmA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ln1AdlHjndCMthIv01RJFYw/tlm23jXnHMDbC5cWbUhuo3uu2sIeLZ5yEfHPNAwA37a2h87p9EgygAbx7ew8tcfMc0aQjro3tRkuUUOkfLWjj2diuhcPKGi1/UhIW8R27WofaYnjSPzGtaA+aoUIfl+RSMRuNjjIUZ3h9fswU2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHxnYFdU; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-326cd354cf3so18126301fa.1;
        Tue, 13 May 2025 23:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747203919; x=1747808719; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/GlegKmII1NP1WUaApvwkeaPmRs0nyMlhrzEpWMeltc=;
        b=lHxnYFdU+NUHldhQ8DBSnDaypY9R5urduNGJjnaAsD6Vwnz3tcQ20Hb1WVCXBRrJSi
         xLb5R/5osepxyz3Zl+0AMF/TlneG36d+STYNnKLgBQADj5B/qtYRjFymPwucJnPyYJbb
         bZA7G/uunhjGrOzStwNUnjkMXqIS1+pnCiaj4OLe0+TUNHvbjKcf3m7ReBKCgC7j2rfD
         fLl2AyzAQnT3fXNkSqRZ0eksB4m+qCh3uy3h6vwVAFlzmTBt1K5jP4+Sz5+SFX2dTPb/
         ALxuvXLW/SLMB+5Hk7PIv1hzm4m7tb1LguPUwKh86U7UWwWc7NMA3vws5hUtVjhhw6d4
         DrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747203919; x=1747808719;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/GlegKmII1NP1WUaApvwkeaPmRs0nyMlhrzEpWMeltc=;
        b=gSemEWsMGDAXkWoI/LRzCwMcvkLhNjkcHKL5sTvUvd6cP0GzgALWpdZq1WXwNsnHov
         r/qLyaC2fjwhyBruVT1uEPVWsOq5tQTNjf3UJ3CjTLTPSkGW8GAsMElCz3t0ZJ7fsjyb
         9mg8E7iGJk9eH9JMOs6x8JvOecEwb1gP2208Ng8U3TwqQg8MBjiWMkZY2PhcBf4tEnRO
         0VxyWR9LQJfpeGR6RZon+A1bFr/RSjWyCT2oPsBppzkg61F49nlF7wciQBeHRCifoo8z
         +kRf+Vd4ooHAbi38FL1+yymLRhfT+NYOY3Vd1YR4+y0/uj/tGjyijUXbtrCNTfJSXGZu
         gwtg==
X-Forwarded-Encrypted: i=1; AJvYcCU914gKrvCtFbUb2KWNXC9iLY9dNyUJienjxP+ze+Js4okSH4CGxvaZokAW76notEw0j5SMdwkUHOwsJjQv@vger.kernel.org, AJvYcCWPR+IFQ/sS2GIa2XTm5aJ+8Y+T6VUHjAOoh/S5UWKWb0VrZdmAvJfTNuI+8Ab1WWT9bteOtyM5XslV@vger.kernel.org, AJvYcCXB+tSo2id2rDw1LkIhlZu+jF39dhhPsL9KiZILlfmcfXSC9xo0jEGjR8NdsgMBaOe1ALy+CmXb3oOy@vger.kernel.org
X-Gm-Message-State: AOJu0YzhWwIiH/SKZswfxB/nDE1SMMVwlWCxJcbZxkl/1n/L+5O1DfGc
	H2nOgfXOE8dR+HZ9qLvWfIP8qWaXfKTw4Kco4zFqVTS2z7qpuNOJ
X-Gm-Gg: ASbGncvsTGj0wbNn54V2mLw9HHpDmETyt88Wd07vS3MNpTI0qaoUyRHXp1auXab7dfp
	ADrjPzkn9FP7JhI0QsxsMUgri3X9fzFAbKDNRyzqqrMZCoqsWeuDgYHvrfxo8zUKi5k4BEkAuXY
	rbQuYO1I3eu/83+rHCouHCy+IA1/ksfTUe9N2otB69+JkULPkso4eVZySvY8PNiuE/ixH90Dum4
	A8T5ZpJC7GKml7CPja+S95ekZcvhPjB4pXn2++Ja+s7856y9XR4SZwoTSvz4kwafUO0kofyqwax
	zOFw6p1ZmGi9bSvg1AGVvya23YXQ0TA1+x85zSs8B6S8OzGSrn4R2vBTsg==
X-Google-Smtp-Source: AGHT+IHoB6FO6g2Ohune4q/gbUojXZCtKJpNzYPO/vslgLH49xlJeujPpeKYHdJgKT8/e9+l7ZVjwg==
X-Received: by 2002:a2e:b88a:0:b0:30b:f775:bae0 with SMTP id 38308e7fff4ca-327ed22671fmr7294321fa.36.1747203918906;
        Tue, 13 May 2025 23:25:18 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-326c358ba95sm18713261fa.110.2025.05.13.23.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 23:25:17 -0700 (PDT)
Date: Wed, 14 May 2025 09:25:13 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: iio: adc: Add ROHM BD79100G
Message-ID: <4907a096eee1f54afae834213cf721b551382d4e.1747203712.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="D+TIE2Xv0NKK201S"
Content-Disposition: inline


--D+TIE2Xv0NKK201S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD79100G is a 12-bit ADC which can be read over SPI. Device has
no MOSI pin. ADC results can be read from MISO by clocking in 16 bits.
The 4 leading bits will be zero, last 12 containig the data.

Device has only VCC supply pin, which acts also as a VFS, determining the
voltage for full 12-bits. Specifying it is mandatory.

This seems identical to the ti,ads7866.

Support ROHM BU79100G using ti,ads7866 as a fallback.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision history:
v1 =3D> v2:
 - Support BU79100G using ti,ads7866 as a fallback to avoid duplicated
   driver code.

v1 link:
https://lore.kernel.org/all/cover.1747123883.git.mazziesaccount@gmail.com/

 .../bindings/iio/adc/adi,ad7476.yaml          | 63 ++++++++++---------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml b/Do=
cumentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
index 44c671eeda73..d0cb32f136e5 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
@@ -17,35 +17,40 @@ description: |
=20
 properties:
   compatible:
-    enum:
-      - adi,ad7091
-      - adi,ad7091r
-      - adi,ad7273
-      - adi,ad7274
-      - adi,ad7276
-      - adi,ad7277
-      - adi,ad7278
-      - adi,ad7466
-      - adi,ad7467
-      - adi,ad7468
-      - adi,ad7475
-      - adi,ad7476
-      - adi,ad7476a
-      - adi,ad7477
-      - adi,ad7477a
-      - adi,ad7478
-      - adi,ad7478a
-      - adi,ad7495
-      - adi,ad7910
-      - adi,ad7920
-      - adi,ad7940
-      - ti,adc081s
-      - ti,adc101s
-      - ti,adc121s
-      - ti,ads7866
-      - ti,ads7867
-      - ti,ads7868
-      - lltc,ltc2314-14
+    oneOf:
+      - items:
+          - enum:
+              - adi,ad7091
+              - adi,ad7091r
+              - adi,ad7273
+              - adi,ad7274
+              - adi,ad7276
+              - adi,ad7277
+              - adi,ad7278
+              - adi,ad7466
+              - adi,ad7467
+              - adi,ad7468
+              - adi,ad7475
+              - adi,ad7476
+              - adi,ad7476a
+              - adi,ad7477
+              - adi,ad7477a
+              - adi,ad7478
+              - adi,ad7478a
+              - adi,ad7495
+              - adi,ad7910
+              - adi,ad7920
+              - adi,ad7940
+              - ti,adc081s
+              - ti,adc101s
+              - ti,adc121s
+              - ti,ads7866
+              - ti,ads7867
+              - ti,ads7868
+              - lltc,ltc2314-14
+      - items:
+          - const: rohm,bu79100g
+          - const: ti,ads7866
=20
   reg:
     maxItems: 1

base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
--=20
2.49.0


--D+TIE2Xv0NKK201S
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmgkNz8ACgkQeFA3/03a
ocVIhggAkUcDwTET84K8Jpgp1axDZyw34ScLv1pecnLENUK6WOUud4BMZSMBV/eQ
oEcHKdrYw/Rsjni09OsAMd+295/LmIMrSdPY3v9K2R6FEH/CRBLn1wWeZz98IW7v
rr77xRXxu1DS6p3teZCUDT9e0aomfLkRvh6mFp6Eh7C0eEfbP0lMifaaT6Qsticj
/qm16JFeFbD7gNP3ixrCNj84x9FswUitlOF0H+2IQ/a7+n/++ylocGMLISgo8Q3S
RL9pKrG2mmgTMEKnbSwE0C/f0Kgd6WNpVCxXHV5gqrgNtZhqQjF21Eqmmhq3lIlP
yu940QZgWsjxDFJOSc7dUVaVibVLsg==
=e3t3
-----END PGP SIGNATURE-----

--D+TIE2Xv0NKK201S--

