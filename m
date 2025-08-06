Return-Path: <linux-iio+bounces-22327-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59438B1C0F3
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 09:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 151526253F6
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 07:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E097E217709;
	Wed,  6 Aug 2025 07:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yjk6R0rp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40ED18C008;
	Wed,  6 Aug 2025 07:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754463876; cv=none; b=Li+yEoQvOf7exoRm0/TxIc5dn1tJtXIB+DFVQ4r/kIuSayMAa5/ql70nXcEOf6rgj0uXTHsbfGAZIgU5kU9TeJTOj/5mfSx/T2ryZTMMlKN0zoXIzKrcaNCOkwpxPrBL6lCXSi05u4xnbEr7Z9lJb2xodNl0n/suZbOCqpQOOzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754463876; c=relaxed/simple;
	bh=HIDATdxLWAtsTFrhPpUwodNtkOkXVxvzJzTt2F1oVNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=juznQWya1Ghx09Kx6VDpmWa5RzxDEjHLLatqjf7+92LOoyiopNXb74JLyONfUMBL2SwRkTP0az+CaXhFfJxnMmymbIqru+HUMAqIOYjI2v7gUUDh04FyDCjeNoZuuaHJ5FLVofokp47VxBdeUvKh+Arnjll1FgNB0WLAQwSJ9ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yjk6R0rp; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55ba26abd62so3531912e87.1;
        Wed, 06 Aug 2025 00:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754463873; x=1755068673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V4XHFY1HiaT/lA+RfXIKJtk3qW/DhRf7LAbT41Q0vUY=;
        b=Yjk6R0rp6aknBlWQx/nEQoLAyelezgNi5tPfKeFasY9knlTiI6IiH0LRs4OpscujnA
         9RQIpYc04dLeucsacypifTLX8DxMm/pn6oEVWM9aNPlxuDTT7Vyko0kav1oP6UykrKRD
         PCKtShdu+3A3syT9QX2qNMDmgU4+kaFrE+UO6BpI+snO0L7Ux2/2Wr2EUJQGB9oUjLxz
         TC/pMHNtBjkBSVvjamlIdHFUnW/t2LPlbH0noLe7g8RZH9IoWv8lTjiJMzGdim1x/Pjw
         FeKLn9uvzKgAtFi4aae2T7jGOsF9XbX7fXbxW/A/mMoTR+VqDzfsTfrspYWaMDuVV/9l
         5kNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754463873; x=1755068673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4XHFY1HiaT/lA+RfXIKJtk3qW/DhRf7LAbT41Q0vUY=;
        b=IKfzv65wR3aq0OHPzkjFuzGjDqBabMy+qMriUcFWXNykzZk9kRORHD36mS00sc3GOP
         fER8UlBS7CmXrowBpjV/nTwuBrFKT5IlcoOdtJ1Wmn3XnzNKoCcDbPxD5XqC8pKWjIpO
         8qeIEgZwlxHrWpMM8RkAnbCCp8EUziAZYeztWjLGXc+QwHXbVoHYdiVlc0qEuHePVHTS
         7SNr56Vc4BuToZBn0YPFbZZNQexdiLhxbzQmJNik1LlPQ9TiEsUOWC4EzL3ERu8fCMpw
         8k3AuiEmXVfaWdydxcKNTCTUTj0iUc7Ya+5oDbXPbQepaZGXaEmLwH2aLdInQVdHEKKe
         AWGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMCUTkRKt1pMBB+vgPW10LjiYCHEvDSQ3iK0Ij/tBO+F8ZdX5DdZM6o2oagDSCDhtMPboZqCdZsn0Q@vger.kernel.org, AJvYcCWzmjF0jm1jvivLQl7bYimYTh/lPuRSDtGlKs6EVZRyzbvWHRevm6iVAINfoJBv9oCpiYYt/rqwLb/0@vger.kernel.org, AJvYcCXdbNr9I3NhrdyMwWmDkK0NzE7Hr1kwAiED/0m2jtmQFtcfi6WGhaFM0QP56bPnGtPwNbVXSYRCqkQtQ7ZW@vger.kernel.org
X-Gm-Message-State: AOJu0YxRn7JlZ8sLLqisfXyK+41F6NZ9pekTqr2HdZV1N6O5Sf6unnTU
	r9Cfa38MeKrAebL4jPi2gRMDW+Hn2xxqGRUBs6SJofs59yebuse9YWp5
X-Gm-Gg: ASbGnctdYymFMwo7IfWh+apVj40e3i7uldfGXZGob52Ffubl5G7e2x4ZFWN2/8CdDBl
	TX3caG5xXSLgI3OATAlHJHtG2OrCXVXYkfHNo9BxYCbY5alHAo3bNPqHSoUUrYQkj/SfXdmsTw5
	+IgzbQ+CWMcfKdlKBF6H39he0VDU5YHNfxdv1CN+YwvCrYnnltEywmP+YRdNHqG4nNu2nn+9YYg
	S2eAs5PJr1YqWR+wa9h2xQRj0CWUR6ckugKpOHFqjvbRaLHWZR5ARyDEo2dcseiVP3WXJEOSzIg
	mDFXeWNV6LmYvxb8RwJEC7Ly/7na6KwXGhTZA0FW3+C3I8tyLV8jC2ElCg4B3UjHdOsXQGR5vJy
	V+YhTi+8sUissswv98mHeRXl9Lbxd
X-Google-Smtp-Source: AGHT+IESKhQ2uRa8zByMU9hE+VEGDd9j1erNp4bb6696/MYMSRzxIOBe3Hge85NbBhQlSd5N8bGYdQ==
X-Received: by 2002:a05:6512:3d0d:b0:55b:861a:d2cf with SMTP id 2adb3069b0e04-55caf34c46dmr509218e87.26.1754463872602;
        Wed, 06 Aug 2025 00:04:32 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889a1942sm2194053e87.53.2025.08.06.00.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 00:04:31 -0700 (PDT)
Date: Wed, 6 Aug 2025 10:04:28 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] dt-bindings: iio: adc: ad7476: Add ROHM bd79105
Message-ID: <3066337cb183afa5f53a4e6cf94ce15a36d14ec8.1754463393.git.mazziesaccount@gmail.com>
References: <cover.1754463393.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZCvq7TjMx19kadkQ"
Content-Disposition: inline
In-Reply-To: <cover.1754463393.git.mazziesaccount@gmail.com>


--ZCvq7TjMx19kadkQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD79105 is a simple, 16-bit, 1-channel ADC with a 'CONVSTART'
pin used to start the ADC conversion. Other than the 'CONVSTART', there
are 3 supply pins (one used as a reference), analog inputs, ground and
communication pins. It's worth noting that the pin somewhat confusingly
labeled as 'DIN', is a pin which should be used as a chip-select. The IC
does not have any writable registers.

The device is designed so that the output pin can, in addition to
outputting the data, be used as a 'data-ready'-IRQ. This, however, would
require the IRQ to be masked from host side for the duration of the data
reads - and it wouldn't also work when the SPI is shared. (As access to
the other SPI devices would cause data line changes to be detected as
IRQs - and the BD79105 provides no means to detect if it has generated
an IRQ).

Hence the device-tree does not contain any IRQ properties.

Add a compatible for the bd79105.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7476.yaml  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml b/Do=
cumentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
index d0cb32f136e5..16d3866dd633 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
@@ -41,6 +41,7 @@ properties:
               - adi,ad7910
               - adi,ad7920
               - adi,ad7940
+              - rohm,bd79105
               - ti,adc081s
               - ti,adc101s
               - ti,adc121s
@@ -115,6 +116,7 @@ allOf:
               - adi,ad7274
               - adi,ad7475
               - lltc,ltc2314-14
+              - rohm,bd79105
     then:
       properties:
         vref-supply: true
@@ -131,6 +133,7 @@ allOf:
               - adi,ad7274
               - adi,ad7475
               - lltc,ltc2314-14
+              - rohm,bd79105
     then:
       required:
         - vref-supply
@@ -141,6 +144,7 @@ allOf:
             enum:
               - adi,ad7475
               - adi,ad7495
+              - rohm,bd79105
     then:
       properties:
         vdrive-supply: true
@@ -154,6 +158,7 @@ allOf:
             enum:
               - adi,ad7091
               - adi,ad7091r
+              - rohm,bd79105
     then:
       properties:
         adi,conversion-start-gpios: true
@@ -161,6 +166,17 @@ allOf:
       properties:
         adi,conversion-start-gpios: false
=20
+  # Devices with a convstart GPIO where it is not optional
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rohm,bd79105
+    then:
+      required:
+        - adi,conversion-start-gpios
+
 unevaluatedProperties: false
=20
 examples:
--=20
2.50.1


--ZCvq7TjMx19kadkQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiS/nsACgkQeFA3/03a
ocVgjwgAh7N5dXRIVibVB+7bUJYdSrDzP6cdNLHxxq2GsuBcdRn74PbuiDYj8KSp
2RTYUw1+WpfOTjczWC9SwNFCZZTpucaBADet8T93Y3uXEG7MnxVkAW+8CTipKjlD
NVFJwjmlTsv3kum/hTVONaMhCBq9qGD0ZzMISEmIft7vIqElX7zNi2kyyCuMaGt8
xyVuRyrQYUep2O68PmjS4QBf1gMLQc2iYr50tlwU1oxyW+BF6v0fN9Rlq8conOh8
fc1TjI/VhwSSyvwa6WV6A92PNr/yhUZ+pG7LR20lfc2aDRYGkfFj2pwU3BNr+6L8
+jRkJ/2Yc2Ii7Pv84qsBC1GzIeUx0A==
=HlMW
-----END PGP SIGNATURE-----

--ZCvq7TjMx19kadkQ--

