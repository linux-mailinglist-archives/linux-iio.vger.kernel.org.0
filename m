Return-Path: <linux-iio+bounces-22542-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4242B20235
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 10:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9D7189F72B
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 08:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FB12DAFC7;
	Mon, 11 Aug 2025 08:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXWYsvec"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3647323B613;
	Mon, 11 Aug 2025 08:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754902216; cv=none; b=oyFsH80yQuegRlKVXJcVvzmazEtvYJyQre+d0rRN2LC8NCqLRcylysl0DVloGNPfurW5kaCO1O+0lMwEbLvAsHYI1mGdfTy05pm/p4VTdmj4v+ZTmXlSIMHtdLWzOZlCfDpkMU0Ii2nspHrXs4Xi872VeQrugBkpi6ez+94CSpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754902216; c=relaxed/simple;
	bh=1tEhzFiFE4m1Lk4a/0mPSKrAUs2Qiu8Mky/DoG1Ve78=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kus2CNKdhZkD7e+5aIk62i3nDcDkGEZcApt0bisieptzX/BXD/FDeVvj7De1tdxY/gCYdx/sNxpzQCyKlGoNMNlPThRTemcB36Sm9wlmofRByOCgHEZ1thK78IJIt6yW0nQmw2btTXq4moV7sVhcoORt1B2cY1Z+dzyuddYEpq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXWYsvec; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55b847a061dso5618905e87.1;
        Mon, 11 Aug 2025 01:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754902212; x=1755507012; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UiFNcJ5Lks652gb343jB2ALzQ3NlwwrN7DvrrORWDB8=;
        b=IXWYsvecOy2eS4r5j895lB8O3WBKJZxLuqjw855mA3Rd51T5oovxomAGYELPy5XDN1
         kyUM1dIfDaQbSWPbLWFStntT/De7WkB23+G7knFEXty0+t7UEPlxbLkRcG55LQHy1WB7
         oa2OqPcV0jZHFqedWe+RAdeSRX8AuXbGdjpFa0Rph0tIZNSwWmE9PN9/wn8IcRhqfOyx
         MXnojBRBIxAYRl/Lm9bIhQDJT3LBYvEkRTJCVUe/mlV262RKiDg7uJMEDDPnZa0kgrgU
         Xn3R4cqJ8qjihsFSqsQ/27Jr3NPe4j+P22qOfuNuCXkJbKMLf2T3PEwQjLWNG4EH3U9E
         yD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754902212; x=1755507012;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UiFNcJ5Lks652gb343jB2ALzQ3NlwwrN7DvrrORWDB8=;
        b=EcyqJdwSvynRtJ1cPHfDvJRypkru66kgop+JhNA9Ewr12AqMY67d0fwTMaB3tu/0zP
         K/a4ykBAjXwNWJn1SDX/2Yack78Bu7KkD83mqYWU61C06XNBBq09jVQLA0LQ++PFaXNm
         K61zEc/4mvTLXDdhDiWHFXk9+HM0+k7+FeqPypxULG65ITAJ594gPEj5bKi4/PcSmstP
         +A0EQ1YK+Enu6pLI2Is69AFbYR4RMsKRBA4SYPyR/2RaqcDg1sByiWz1WTSwemdxj+B1
         RULsR8YLlr67CMS2VsxR/p4Px2RvXB0GAOQ6UVWLNpRS08h4ve9sQKbsDUeRg5CDk3JR
         60BA==
X-Forwarded-Encrypted: i=1; AJvYcCVLSdOYrgEat5iYkRtK8nE00Uj+0ZnR6VwqzQfbZVho8IZ82YkI2w4pMExJmLLVZJpre+1O/R3km+HprgxB@vger.kernel.org, AJvYcCWM6QDwQUAD5xQ5N/+csweaOWER7KNMWUpK+ZfnYNvwQMtLbCu11ciPni0NTfZltsa0m+XUfqqYhj9C@vger.kernel.org, AJvYcCX6GxtcavkMSWy/hcTmragRkRgpaQK7vU6UbcuOTj3rYIi3wzk7W8AF7TGXLZoUISOiw5TJbcSVph/D@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6rWlm1ucBn6rzmaj4tfVObEkgPoyjzfrjL9UsMQyH0PRZxrLg
	IqfNFFEOrczzU6YmaiD/vlyfcO3V6NCLOWWHRry1iFZa/NMDB/Uuo28m
X-Gm-Gg: ASbGnctw4Y97QYwngUKG6Y0Ku3wOY6Br+VauRNA2/dWZbrUO4rXIu39U5jNnhC6VIhc
	IzumEqMIo3qlbka7b9gHEm1+FvlQP6ITAp8Ogy47SuUWnqleCSiw/vCVPsh05C9t8iy6IjYOwAN
	s0r0Re83tj71IzzlZuiqpK0rcY2X3m5ApfYNtHsY7wLXbZpt27SNqUfPSn1s1smdeuW/nSHI5I1
	oOTLVZPZlvFtvPRwb7NchSXqik6NFB+ELPs6pJUvnK99Z65JTBFABbXOPJmyMf2dw2XrjC5MlKf
	UtQ3ycWgUkua/hjDRN8kmg1YPKRGcca67VqLAboBUaiVydDin/oTCTJOuddT1LdkSnxbx4oREsa
	NpW0uTFpF0nfcPQOcvSHsaCZ+/rMR
X-Google-Smtp-Source: AGHT+IEveySLogBjYPUQ/NHkluxPlF3wuT8yMt78EZ+FB2Qi7ZqG8FmWim2JL9GpjHBj/bW+ltm1og==
X-Received: by 2002:a05:6512:2344:b0:55b:8285:3f31 with SMTP id 2adb3069b0e04-55cb61ec19bmr6010536e87.24.1754902211973;
        Mon, 11 Aug 2025 01:50:11 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cae34ca16sm2158988e87.119.2025.08.11.01.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 01:50:10 -0700 (PDT)
Date: Mon, 11 Aug 2025 11:50:00 +0300
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
Subject: [PATCH v4 00/11] Support ROHM BD79105 ADC
Message-ID: <cover.1754901948.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ms50P9IPMEIutg4c"
Content-Disposition: inline


--ms50P9IPMEIutg4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add support for the ROHM BD79105 ADC
(and do some minor simplifications to the ad7476 driver while at it).

The first 2 patches were originally sent as an RFC:
https://lore.kernel.org/all/cover.1754041258.git.mazziesaccount@gmail.com/

Revision history:
  v3 =3D> v4:
   - Add patch:
     8/11 "dt-bindings: iio: adc: ad7476: Drop redundant prop: true"
   - Drop redundant true -branches also from the bd79105 binding
   - Other patches unchanged.

  v2 =3D> v3:
   - Drop 5/10 "Limit the scope of the chip_info"
   - Add 5/10 "use *_cansleep GPIO APIs"
   - Multiple fixes as suggested during v2 review. More accurate
     changelog included in individual patches

  v1 =3D> v2:
   - Two new patches:
     5/10 "Limit the scope of the chip_info" and
     6/10 "Drop convstart chan_spec"
     Please, let me know if you think some of the changes should be
     squashed.
   - Multiple fixes as suggested during v1 review. More accurate
     changelog included in individual patches

  Simplification RFC =3D> ROHM BD79105 support series v1:
   - Use spi_get_device_match_data()
   - Fix uV to mV conversion
   - Rewording of commit message
   - Added patches 3 to 8.

Matti Vaittinen (11):
  iio: adc: ad7476: Simplify chip type detection
  iio: adc: ad7476: Simplify scale handling
  iio: adc: ad7476: Use mV for internal reference
  iio: adc: ad7476: Use correct channel for bit info
  iio: adc: ad7476: use *_cansleep GPIO APIs
  iio: adc: ad7476: Drop convstart chan_spec
  iio: adc: ad7476: Conditionally call convstart
  dt-bindings: iio: adc: ad7476: Drop redundant prop: true
  dt-bindings: iio: adc: ad7476: Add ROHM bd79105
  iio: adc: ad7476: Support ROHM BD79105
  MAINTAINERS: A driver for simple 1-channel SPI ADCs

 .../bindings/iio/adc/adi,ad7476.yaml          | 100 +++-
 MAINTAINERS                                   |   5 +
 drivers/iio/adc/ad7476.c                      | 461 +++++++++---------
 3 files changed, 311 insertions(+), 255 deletions(-)


base-commit: 93ef68672bb353838cdf8314be8765c05768916b
--=20
2.50.1


--ms50P9IPMEIutg4c
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiZrrUACgkQeFA3/03a
ocUcfwgAnwb5rtEFdTW5bCExybjxOD2M+/V9pgZ/yJpLYrlkMbO7GEe3afK2jzg0
JSkhKPnoklsHQAsoyNKTHMOo/ydP6m9B4Wk4DD1BLbjTGFkXyiG5cJ1kjk8IUvwj
7cGZXDvwUH2U2jWMrMH3t36Ue6fvRBAoOQIDZiNizLu70+zP72qiECGJA2SYevuk
hXgsz0lGu1xrMkSIkmL6O5sxLcERGGTUhgn/8yNNrKiSz5hjcV+hEIBM9BvOGie7
M3mV+WlO0kMc5SNJPAHU1+rNO16SbZJPs+qB6+u5PMOcQ9rBIxXG5rGfGNNTzEwW
BQWdUy2iCnKh0Q46bKka4SjeMdD2HA==
=mLV8
-----END PGP SIGNATURE-----

--ms50P9IPMEIutg4c--

