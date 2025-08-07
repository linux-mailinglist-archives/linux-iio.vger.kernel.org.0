Return-Path: <linux-iio+bounces-22384-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DCCB1D4BB
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 11:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AF1517C22F
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 09:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70778226CF0;
	Thu,  7 Aug 2025 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5BaBtU9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88284374D1;
	Thu,  7 Aug 2025 09:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754559231; cv=none; b=LiUQ2LfBHNBb2lJ6HyY3vR3mDonj2yBRYpxhhcBCgSBqik+dcMadOqsonLq6i8Jf9nXK6Gis26Q24kEF4Py9WgaEyy+jBxsZcn1D++vPJZ1b+Rc//4ArsUkt8w6qi9KYfRdkxX5dW5ubhXYAEPjQJsfzZZBabBMKRiU/KNZDdoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754559231; c=relaxed/simple;
	bh=POAFDVc5buo5ffaBoB1MEDN5er5R9LexfnJTqepuhIc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qDXvoAPUbN+L2dhzNhaWlV5fUxISOOyhn4zyry+9w8PZDttQ7FICGA019rvK6fgDPeIdx70Zz+554BgIK/tGLvHJ4lUkXamzBoSqrD+Vx3QPPeLUyW7tKftaAxdx7W9zNzLavbBIT+/ZDZO+avL4i+twB5EyPekTgZ8lUQslKM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5BaBtU9; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32cd0dfbdb8so6854541fa.0;
        Thu, 07 Aug 2025 02:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754559228; x=1755164028; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GIhKxsp1yT1z/3bNUZufj9mCqe61VCKH+882nrrfiLg=;
        b=C5BaBtU9q/URGzbZpnb4oZ/pij/Zs4LeJoFyUkvdLf1JnyPEk04/AvqRjB8ICE9JuR
         rjU96IYVOVRwb6mxvfMU3MKxbwMCepv1FiL4LAeR/qtqOyWT/sHpPS9lHOxeZun6J3VZ
         k5/YfRCZAWokO2RFwOwp6nlHnDToFZqPpBVesn9FHAATCRhEPuTDy7Wf7KkZiB+r2zDB
         e3oz54EwRe/S4vbVTdwSusWZtzHTz0NL825aicrjQOyaBNSUY99RX79mNc/Z5QkcT91Y
         5nlEyrcERE4DOcRovTyAkpJ6cIeYYlIQsSrgSjbjHEH4PylX49rQzIXU2tfUk5qI8yWq
         OXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754559228; x=1755164028;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GIhKxsp1yT1z/3bNUZufj9mCqe61VCKH+882nrrfiLg=;
        b=OrCeA3R/eUt4rMdFkkVQM4oSOGja2kERMTOeJgVhxnSwc77cXENWb/Z7x2l9/5vYn4
         hPJenN1Rzm1zrfzUVTj3uSe7DEmWs+nXBszitaqqSD3vT91ZVZlghi+Hsk6Y7kO4nM/p
         a9sFJvZpJsNHeL/dsUX9vc6yz2kYWFYeJ/LW0WrCgnhSoGqhmNr/XhnfH9h1dWgSF8DA
         f7mG1IXKfNkZyp7uc04zpynEFHYo66M7emgRcfHm/7S5wID4n7tjTfTDMgv3lQmeaD1U
         IVpEHggc0lG5ivs7/4Fp5XOW7eZYr+ywsOvtRsnWn5m1ZROc4D0azC4aMH++AsQbr9wA
         DISA==
X-Forwarded-Encrypted: i=1; AJvYcCU+rG3Na+Td11UXe/DnAchHctqySNGAeszHntH584NJ/43MkdOalvxGpQ+q2VOXOb9YlP+PKG/lFVBB@vger.kernel.org, AJvYcCUWor5idrAZFNbHcAhgkVvOtsoFQfLvUReeEue8IVbZPxEIoRy9KyHjD79sFcS3be7bjh7th9tLxKmUt6RU@vger.kernel.org, AJvYcCWLnNkrmkh4bxeaW2CRUZmma3h5PxxS/wPkGhL6wt6jKYtJ0oAm4cqIABz32rB47IQC3sDWYu5lhT57@vger.kernel.org
X-Gm-Message-State: AOJu0YzG36HDsWcWGkioXrR0E/ZZSwvXHkGlbNID7BVnKvL2bvs7G+e9
	1h01ubR0e/F3pbDhIfYdeWejOYR+nSumH6BI70X5YA524ezl5rZcCBBz
X-Gm-Gg: ASbGnct/CIPbhpNAsskjem8AmTAgXsg3EJz1BaQGPcpxhwRhNpbkVpeu0lJ54uI/8Zv
	bg6JmI7J2ub+pznaiC6iuQfy0fjpbIWwq6Uzg41wsROZsXcivEJDzsnRXZnRcPc4tX+7jXWVcbR
	Erxreo4sp3iNl4QY9ePdmYtf8nW6cOZT7VWrLd+h68AEPAld3RtjnVukWeml7CEzFOfCfXTOIh5
	zc45xSDQbPFUsgJFu0QgeW9nJ9QPZcmTcs2VdEAKD4fZ7UPjxVLqD68KsdMNIYUxkFGe6nR8I9H
	YHFxM5SR+3Ddf11rbzMzR0GPnlztC4ws6zc42FaBFY6+NRAFXHFnt9vxJwmPVLgLooGIh8VvwJi
	iV1HzLfFIrF0AR+WBo29sT7q4MGE1
X-Google-Smtp-Source: AGHT+IEZltvCamUz6g398jQBPtEYZI0Tv0/NKdtEQouhNBlFuOxUNqvaa0h6T0ixaoVNtLXWE8ONxQ==
X-Received: by 2002:a05:6512:1192:b0:55b:9444:b165 with SMTP id 2adb3069b0e04-55caf59ccffmr2482183e87.24.1754559227325;
        Thu, 07 Aug 2025 02:33:47 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88ca3f87sm2547682e87.138.2025.08.07.02.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 02:33:46 -0700 (PDT)
Date: Thu, 7 Aug 2025 12:33:42 +0300
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
Subject: [PATCH v2 00/10] Support ROHM BD79105 ADC
Message-ID: <cover.1754559149.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QVIWjNiNy+tAERlC"
Content-Disposition: inline


--QVIWjNiNy+tAERlC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add support for the ROHM BD79105 ADC
(and do some minor simplifications to the ad7476 driver while at it).

The first 2 patches were originally sent as an RFC:
https://lore.kernel.org/all/cover.1754041258.git.mazziesaccount@gmail.com/

Revision history:
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

Matti Vaittinen (10):
  iio: adc: ad7476: Simplify chip type detection
  iio: adc: ad7476: Simplify scale handling
  iio: adc: ad7476: Use mV for internal reference
  iio: adc: ad7476: Use correct channel for bit info
  iio: adc: ad7476: Limit the scope of the chip_info
  iio: adc: ad7476: Drop convstart chan_spec
  iio: adc: ad7476: Conditionally call convstart
  dt-bindings: iio: adc: ad7476: Add ROHM bd79105
  iio: adc: ad7476: Support ROHM BD79105
  MAINTAINERS: A driver for simple 1-channel SPI ADCs

 .../bindings/iio/adc/adi,ad7476.yaml          |  54 ++
 MAINTAINERS                                   |   5 +
 drivers/iio/adc/ad7476.c                      | 462 +++++++++---------
 3 files changed, 290 insertions(+), 231 deletions(-)


base-commit: 93ef68672bb353838cdf8314be8765c05768916b
--=20
2.50.1


--QVIWjNiNy+tAERlC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiUcu8ACgkQeFA3/03a
ocViwwf+NKPk2yVTLJuSN8SP71xAgAVwKzlUuR5KjPi6CJmjh//us+a8FX+56pIu
v0zXMo5QOVWAGRN/kv4Z3QLRNupUczmk3ZdbrtF2aohCmHUHIKSCfORfRJAtT0yg
+DNmeNZJxaeJDClDAVdqktyfsPb7lYTDqhWJrsKl20/5/UA0uNXkxlynIwjMoOfq
iGvFf/9fAGBh/mMAo60GKcgraaxwq90ZbhbHqLMdHMnXj0VLN6Da5cMZV1XyXx8I
n3pD+cEJApHTRy7AusbQ6LU1n5fs3+eqHClXs9Nqxl0E7z/PIUUyJV8HB52xx4j4
VZsYYpDZ/TKYEsrjySQklNebtIYjJg==
=XXB0
-----END PGP SIGNATURE-----

--QVIWjNiNy+tAERlC--

