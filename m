Return-Path: <linux-iio+bounces-22320-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 745FFB1C0DD
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 09:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BA814E302A
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 07:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8822135DD;
	Wed,  6 Aug 2025 07:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTYXDA3C"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67151E572F;
	Wed,  6 Aug 2025 07:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754463754; cv=none; b=ZGEI0KmPbDkMpLAipG96lD6JN8lyr1OFVzLAn3uQi2kGOvH4JX3DePZfLJsJd4OwjS9a9z3lYHLZm7pvXFuAvHDRl9oYUVnORmTvz3crNqC3zmPtMrKUMIbA+qpRFQeoOIInSreXQQRJ+0IbHRHvrQr1zmotjEbP+MlXaBW5sow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754463754; c=relaxed/simple;
	bh=poC4XVaA8B7YjkMeMwvT4Z2vsTNM3GbduKIm2z/TI3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Gkre/VCu6COWAjnTmg1HNUl0kg8Z8guDVFfRq2UwC5vSThGjIeodCpzwsFrTkEHh8674mTtjX5mBPjyc6RTnXXWL2UWgK4KI2pmaHmkKj2lYALKt0Efe7YbfQSEQDeUXAQ9yAAXxQpgK/gxdJq8YeLrh4XOBmrNAjEeaIKVlFhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTYXDA3C; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55b93104888so5403028e87.1;
        Wed, 06 Aug 2025 00:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754463751; x=1755068551; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S+EPybaLVAUi5QIFTBdyFeFLaZuSxryGuhqzOkKwhms=;
        b=PTYXDA3Cj5JUw0Fr6bu+rRN01k0jZG5ScOlxu4nYDT5qd6NVRAPawaXwOoOZ6MvZji
         Es8CePRee2UUVlmsLgBEtEjIBzS0SmydO4lvHNCy7tCuvns0+ylaNJuI7RGRpL0ugOlW
         QuG5eQfrLBe6Tv7hg+rVVFlSuX0qqusRJvs0cFEx4C5vjNzJkQwsBszvWvm/cyVzgRYh
         WdmjpZkVJpm6DsuI836T2q5u1md7UHoxG7Gv+fx8Vif+jnh6WILTohJiuWIMu3aPjceV
         IFtm+RhLP6BQDAcCqr0UGRyRtMCpH4Qe0Vg/FYHfDz7VaJ+UvICIOJxiY1hy6UfZoRzW
         TpaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754463751; x=1755068551;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S+EPybaLVAUi5QIFTBdyFeFLaZuSxryGuhqzOkKwhms=;
        b=iUIz+D0rP1qFVwOWrg9gD8J41YvfcITINbhTpoZzTLf2e47HaAtAXEHX1btMIwsAIw
         xEfQbs9g/mOqXnqUVHZuO9P0kfMG2ZsXa/tIxLQ5eo7CjnoW1W599HVDop745W7+01JS
         c0ADbbwDQBJu8hI7sopBZ4XN4alhHU0swtHn6DMGjExV5mPmlaGiXjWPS1FMNI8rSAcT
         hXAhS/r711z/JdS/obzgG6BvS55c9J3qf9oXNEFsDsHRzEvO0MHaVszJxWVih7opO/pm
         ZjIDvQK7WKK8bIFPZYSdnegU2bJmglYqKEIjheLJZC9xjgeJEH9dlJuT8IToWSAg1I4F
         x95w==
X-Forwarded-Encrypted: i=1; AJvYcCUzvI0o85rW3oR+Latt5Lh06ooUo0SwH+nOG3EDfPVsv79NWzo8kA8O5dkGL6jtAAOggkiok7VmU9nB@vger.kernel.org, AJvYcCVmZ+xX47XFNUPFZQGahVEQWX/yS+hkMlDgKA4ntb/W++s5d2w8h7raxjxa3Svu4tio9Eaf5oYogxzA9zDq@vger.kernel.org, AJvYcCXWH0F0hjot7xh4qfqkyHsTjexI6Mw500JGwZ4JOWFUPWjNO/95jYIqelk7wgwNmT00rnJM1WnB4N1R@vger.kernel.org
X-Gm-Message-State: AOJu0YytzrPmWacuYBg2Z3S8L0myueo4RpNFiiXc2yjGgeC5ps4X96Fk
	g1o8ZcDZdFy/nxCiRR3V+nYPWHBda/EaBtCmgRGxJ6K8dLYqxsnq7LDp
X-Gm-Gg: ASbGncsQsolDz4VN3+E0Ew1440ZotIRcfUVgCGA/aXRprlGTKrzQGei1lp3TjqnjQhh
	4td9ae0kJJMqbxjbd5sBt0Xn8qksue1IkzJmt7FXRGareGsT4MQj/q1NhCaHGR7IVysjdPSsGDV
	lRXZWXi7v0Y+l47mM17KupxriyDT/fD/d/0a3tSooFBtTFaSDwj3gMkCIgmGHaGKWnKBat1mN0M
	RRNMHUL4v0tJixjxWXpReXcxA4us91KgsM2T40ObrE3jxguYgbb2hmkU+WKbvBI/X77wl7OltS1
	XsXbs4zsmSrdohgymxpDon6uF8B4opi7toxgC365E8NeegJ5b7jZWvptzT3jDblG9MmwbNLcJc9
	OADhF4/HKSj1r30bBazqB6bd22+Vb
X-Google-Smtp-Source: AGHT+IGE2pjKmZUujmGI1tpTWxY40tAh/zfONWVeuViemxGcZKuUptVoLESwZyRVp+SKJAwZO+k6CA==
X-Received: by 2002:a05:6512:12cd:b0:55b:9647:8e64 with SMTP id 2adb3069b0e04-55caf37a531mr587209e87.36.1754463750298;
        Wed, 06 Aug 2025 00:02:30 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889ac54fsm2230928e87.62.2025.08.06.00.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 00:02:29 -0700 (PDT)
Date: Wed, 6 Aug 2025 10:02:23 +0300
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
Subject: [PATCH 0/8] Support ROHM BD79105 ADC
Message-ID: <cover.1754463393.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="orNGruq7eq6exArY"
Content-Disposition: inline


--orNGruq7eq6exArY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add support for the ROHM BD79105 ADC
(and do some minor simplifications to the ad7476 driver while at it).

The first 2 patches were originally sent as an RFC:
https://lore.kernel.org/all/cover.1754041258.git.mazziesaccount@gmail.com/

Revision history:
  Simplification RFC =3D> ROHM BD79105 support series v1:
   - Use spi_get_device_match_data()
   - Fix uV to mV conversion
   - Rewording of commit message
   - Added patches 3 to 8.

Matti Vaittinen (8):
  iio: adc: ad7476: Simplify chip type detection
  iio: adc: ad7476: Simplify scale handling
  iio: adc: ad7476: Use mV for internal reference
  iio: adc: ad7476: Use correct channel for bit info
  iio: adc: ad7476: Conditionally call convstart
  dt-bindings: iio: adc: ad7476: Add ROHM bd79105
  iio: adc: ad7476: Support ROHM BD79105
  MAINTAINERS: A driver for simple 1-channel SPI ADCs

 .../bindings/iio/adc/adi,ad7476.yaml          |  16 +
 MAINTAINERS                                   |   5 +
 drivers/iio/adc/ad7476.c                      | 428 +++++++++---------
 3 files changed, 231 insertions(+), 218 deletions(-)

--=20
2.50.1


--orNGruq7eq6exArY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiS/egACgkQeFA3/03a
ocVo5Qf/cQqbMFbY5+GAjw5vzJ+wO4+ixRM4WZMvkvzZwCmXPXhdslzfU6S0USut
j2PjuZOStq/3kHKEpkB9rMD8Blo70upg+dnIdiGThB322xwblksKxjrDuao3vFbH
8hd0hxZ+Cq4+CdLxMxv+esaQ8XynSTcp2N+/BpQn8BwvHBUxCNH7a72I2pUTNnEb
mph/8lJHOuZGTvxGqRyOU7WB7oB+jmWzCvjXwpRxPRHRDgWG5bVqff38r7zgpHTO
vzvAlWSexoV2+nu6jogR8M6voVCsKUnkdvJZF4FW2eK4tK0B4MFF2VbesLhGBDCO
bul4q9fhQUr5dal0jvqwwIjhbxBv7g==
=gJ6O
-----END PGP SIGNATURE-----

--orNGruq7eq6exArY--

