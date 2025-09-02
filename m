Return-Path: <linux-iio+bounces-23632-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2537DB40059
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 14:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7328E7A8807
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 12:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C22A28750B;
	Tue,  2 Sep 2025 12:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bA1097Dy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B5921FF44;
	Tue,  2 Sep 2025 12:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756815815; cv=none; b=kRXj2j6+k5MaqesR6n74TN/UOuu5VALXxu6n2FgXOwS6Bld9K/XiFMJS4VB05wDQMS4GBc4DjJKzNVG8eXKQD+bOWcl+O4lKlgTpA8VqRqFHnsv/6RSpCjqVWRVnpHgSj8LoZo4dUITy0inaMajSkpB3SOknhDlZiBzhIjLKwm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756815815; c=relaxed/simple;
	bh=FLDyaeitWgzyjtbtKS1qQH+5m7paa4bJfoFRItnpzkE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PGmE6IcAJMKyBjJU8HgJ2IVh6pcO7IXS6zxde0+pyW0jVfn/RnTjUoM9vzmDnVEhFbDKPtDoyirIyCMWh8ht+B/pZo8BXAKmbVXxgCnLYYNoIQbyQ2msJcm47fDTX55ZgOdvwVWmrunY+4gMNDpk5t764UD5PQ1ucOT0qFy2Fpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bA1097Dy; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-336d2b0ea8dso17340321fa.3;
        Tue, 02 Sep 2025 05:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756815811; x=1757420611; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8a9r+uc+llMMsKTvoOHfvAxI18eXAggU7U6vypTQdKI=;
        b=bA1097DyLv70Us0DE+ve0+v+RrAWbFLd+swLigWo47YpsQFznB3cCI7lMihDxEyW/j
         fnoLz13RtiHlLbyvHkxtw2mBID2aJ9uR+8JBM9zfGyDD0nX+e6OSllpn5WP8jF4nUDrU
         cHzLMgDWHZzpLfpItbnRe14xK04lib422m4KSHEhlLrnL5oCoBwI/1MM30Xnp4HLNyLJ
         BsdUcBaEd5Puek8V6NArh3sAFOL8L0MGgJmVD7cSfN/EsyIucSs6G6q4ChQ23EbHTyGv
         9fAtcGGhm7jSyomVRITlODGCvoVsBBfA+xKWTg7xsvPukjE8gK70bGz5bmsoJt8oGdXi
         cHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756815811; x=1757420611;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8a9r+uc+llMMsKTvoOHfvAxI18eXAggU7U6vypTQdKI=;
        b=Eb2/6QSgRd/qm5GrAhSyUms5+YKxKTO1BH/YdjYQRq40vzGADVLxNOCPT4sFmczdfa
         F5ZFpPv2iXNvKo1LlCKoba2DaKTrw7WR/axPITq6PBJAr2u6qlp37dEk3ljU0W1au5cB
         5WbP/zTBjJ47yztzLeYOG313wE3rkOK4CGCdrmbCK7AyP6iHaUaHWRms7MffpqOgW1tq
         z/HsB1DqPc8ZhE1Ss0NzddH4g17JbDK15E0Tt6udPJmg05dshRz1hRbL3OtyWVJ9Sz0a
         FM4hzhOXfK6s+eKJ3rl2kUj9advsph7oCYvRR77xdfaTi9hEatpHFYw0xtsKKu7roFe4
         idqg==
X-Forwarded-Encrypted: i=1; AJvYcCUjA0bUI7Rk4rvbJEmPDSvy5FiJKf9qIF/4fwZOOVytv5nwfJs2sKVRAtdAXFLl5oclpaHkUE5PAyNc@vger.kernel.org, AJvYcCWA1zQHcr2EoTlW1KPyMnS+OE8iLWCbm67EoMl0mMsLS5RtTCMTjjn9kSwugOJs2UTt6u16pOauLTrQug==@vger.kernel.org, AJvYcCWt/d6dzORZxarFh0TCn4pUgbT6ndEJiVHEmYo6Vwdu1OhU4Hs5Kr9sv3xv7vPPW+qtJaiV0i8Awd+5qEe1@vger.kernel.org, AJvYcCXmcTwCLXLBmwVK7+dw94OWxRfunEZ18Z9O25ur7Z5M+DPpTvRv6M3dMOoRS2GioVtu+HLV8Pt6udoF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz46GP2mGeDTB+isTFOz2qRMk8jIG17C3BgkP5cYdCnVG+Uo8ui
	KTb3kRa3rgaO0D0QwUlOFvk/vDaHR6Gtrsa9Jtr5Lgb9Nut6vhKt5GNP
X-Gm-Gg: ASbGncsOyMH58pR7eRnI94fUUW8eg/XtT3A/s21P5ksnYlpNjEhtqgGjqHtfjId+JZN
	oSM4oWnW8xYOa9bBhFEN5tbQCHbsRYgVz7J1TlntM7h8lOIvYwjNh50FETnt0BI01Rx//UJuc03
	GYNLAeraW+CwJepYcf1oA3Hg5OZNgJ2N7XOMC0rJs86r7uzOJ5kNBer3zU8EH2Z7EX043iJpRA8
	sj96l9A6EHzOUdEwTzhRjlyIK1EvD+ENMJNPk9CBA+uXLkG6WIwj3FX1q02rgiTm747ruAtgDlm
	Y2ETrZFCJq3qmXYOGoHR+xr1jxIJqBO9Y4aLv4vU2pX/B9GJodzK3TjaVHw+1PWSqHAzzNAPnqv
	2G0gTJVIQ32L6tE6bUIqqqwgpKw==
X-Google-Smtp-Source: AGHT+IERSU0Al6GV+1NxCq8D0rP4/idbDWR0KPpTpIWo4vTHuwaD/BNUvBHzhNzNaPhPpGVUyD0qVA==
X-Received: by 2002:a05:651c:2353:20b0:333:fff0:7c96 with SMTP id 38308e7fff4ca-336ca8de791mr27244971fa.8.1756815810259;
        Tue, 02 Sep 2025 05:23:30 -0700 (PDT)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f5032aaesm4247251fa.37.2025.09.02.05.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 05:23:29 -0700 (PDT)
Date: Tue, 2 Sep 2025 15:23:21 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Hans de Goede <hansg@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH 0/3] Support ROHM BD79112 ADC
Message-ID: <cover.1756813980.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ba9oyCntt7GsOc2k"
Content-Disposition: inline


--ba9oyCntt7GsOc2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Support ROHM BD79112 ADC/GPIO

The ROHM BD79112 is a 12-bit, 32 channel SAR ADC / GPIO IC. Or, a "Signal
Monitor Hub IC" as data-sheet describes it.

Data sheet states the maximum sampling rate to be 1 MSPS, but achieving
this would probably require the SPI and samples to be processed by
something else but the CPU running Linux. This could work with the "SPI
offloading" which has recently landed upstream - but I have no HW to test
this so nothing fancy is implemented here. It's still worth mentioning
if someone needs the speed and wants to try implementing it :)

The SPI protocol is slightly peculiar. Accesses are done in 16-bit
sequences, separated by releasing and re-aquiring the chip-select.

Register write takes 1 such sequence. The 8-bit register data to write,
is stored in the last 8 bits. The high 8 bits contain register address
and an I/O-bit which needs to be set for register accesses.

Register read consists of two 16-bit sequences (separated by
chip-select). First sequence has again the register address and an IO
bit in the high byte. Additionally, reads must have a 'read bit' set.
The last 8 bits must be zero. The register data will be carried in the
last 8 bits of the next 16-bit sequence while high bits in reply are zero.

ADC data reading is similar to register reading except:
 - No R/W bit or I/O bit should be set.
 - Register address is replaced by channel number (0 - 31).
 - Reply data is carried in the 12 low bits (instead of 8 bits) of the
   reply sequence.

The protocol is implemented using custom regmap read() and write()
operations.

Other than that, pretty standard device and driver.

Matti Vaittinen (3):
  dt-bindings: iio: adc: ROHM BD79112 ADC/GPIO
  iio: adc: Support ROHM BD79112 ADC/GPIO
  MAINTAINERS: Support ROHM BD79112 ADC

 .../bindings/iio/adc/rohm,bd79112.yaml        | 118 ++++
 MAINTAINERS                                   |   3 +-
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/rohm-bd79112.c                | 542 ++++++++++++++++++
 5 files changed, 673 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/rohm,bd79112.=
yaml
 create mode 100644 drivers/iio/adc/rohm-bd79112.c


base-commit: d1487b0b78720b86ec2a2ac7acc683ec90627e5b
--=20
2.51.0


--ba9oyCntt7GsOc2k
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmi24bUACgkQeFA3/03a
ocUVhQgA0tsCPjD06/OPfuWM0thN6JnisysIu/ZFFMGBMG581MMRLhsZ+y36oulR
liyT9bqNvWJe6JDYQ0s89xpOIbBSYUhRPcKMz3ZJRYsfkD85dxeJGDy0aWjSzSX2
PVdSnm7ipibYv8wQfATcBWlXcmbDexOLTY89EDx3OshMD59eJqV2P4YuPfl+C/TL
Ff2aMLY1Pi+R4dIdDSsXEpQPtqaeROnDvXaw3nF2kkxInl9/5XOyRr7hg80+KCLE
zCAd+7ClmfsCdshXDDrtePefVQs9Mut9yjGOekyp/ZqE9ftev+HpI4rk+wdfnMIJ
EttOgMVBIWNSZm6bfpw6B56iDzz+pg==
=IrgE
-----END PGP SIGNATURE-----

--ba9oyCntt7GsOc2k--

