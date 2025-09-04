Return-Path: <linux-iio+bounces-23704-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7D5B43BC0
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 14:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C2605A3B2C
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 12:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846712FF16C;
	Thu,  4 Sep 2025 12:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xi+7DmpR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E1A2F4A16;
	Thu,  4 Sep 2025 12:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756989370; cv=none; b=t8AqxCxqbu2b+f2bfFeIK3UMvkrnnlPQzk7BF5tKOfkR66x4mF54MtaH8BC857DdHngrTjFC3dq6EQ7IbAY2eljT5GJlhBwGukVqgxFM8eQHoXQJNuE0Lb8Akn9gIy3vT8s/Qr5E6aVUrVuR87W3Str1Vj5ukJx8HuXuSvNSJxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756989370; c=relaxed/simple;
	bh=CNP6putEDGNEpgMU1751NZlPN2w4YY4PlVqvKde0IB8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PMSuC0c3G9AH7aRsZ1SykB9nKAhzs7jCOjPErclCISOuZt85T0NVg8v9kUzE0227ZeJkU/OyIMEyOBvPhblGbtIYKVmGYvNqKdPICi9UDrnCHv7MZjNPaP5l58RWHqJir93cI98IZaTKJjuhOqiqkZ4229dUaPR7faU3qqkJk7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xi+7DmpR; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55f7c0fb972so1034268e87.3;
        Thu, 04 Sep 2025 05:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756989366; x=1757594166; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mryZUL0pCDL7B/1SODNMAXz72J7dIK5/FVVepPrqf5k=;
        b=Xi+7DmpRCIu3Pe6A5SCm/NbnLDZYuncxPm+BaXNEuLnrlzjp84K4jRl4ARxIqR2CZv
         IZcDvz1I/zEEUvBslgXHjWXBcjn3HoI2O2P7dF+yQUzpCnrOzJqTU3BGpKT/hb/w21sB
         54ndbLJRjo2WjiVAIKGbTyrfMCuvaLDt5YGBNZcxcYA2667xZMoOSKX10q2+lR/MkWPQ
         qe3+l3+deEcd0+I9RaRUoAjkGStyMZWhLx5uZYeivqjnQYlfyMi5xoijcep6nWiIkvQk
         yHsL3EyVxxr+C+S1+tw/3ckBhmoUnq/kNNugljVrYXlpr8m/HiwBPo84XCR3TTa9IGLD
         /yTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756989367; x=1757594167;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mryZUL0pCDL7B/1SODNMAXz72J7dIK5/FVVepPrqf5k=;
        b=jx+QntWWU5gng1wTmhNvlP+f4P6A6qgv0tHwcUlX9GxQNMi58VuonKy6jM1Czsj6+9
         AMM0hVVteDyOvsbwOTnQZO7fHf+kMJ+gjMe0xSubLiUmIiGLGEH4O0V0+yh83TO03KEq
         3bSmnW6bpiM851u6MTmGrQa3OJuSIG/8EZ7qpbYNaZ2nFadswdGfMRcFPXGwm03iLhAG
         NacUXbaZP35Xp/UWqJRVYhGOX0Anpm0o3KmnPNjYk7Oeo63PDobVAumW8pe8Q5yGUP7z
         hRleUi46roB89aCn7hkz/tn5KWstfOcdDmep85E6ae3AGMRjkIzMcZk5xhaNpZgGeKKJ
         MvRA==
X-Forwarded-Encrypted: i=1; AJvYcCVJk3ZexRiaSXtH4J6gs0ESHm59MFF7UrZ1keDnpsPM5N4fSmq5nT0BMurel/hAhNfmA5xAd3v9AAGVIg==@vger.kernel.org, AJvYcCVpPt3rlsWHiQM24+wkrEMk5f/Y4JXegNVZIgyFEax3hMnrUneL0Y9UXJ5Ojvg4vgqDNTzD9SP7bQ1X5xZQ@vger.kernel.org, AJvYcCXjaruyi1+ZD+3Tu4z9vvs9OCxnWe844bpiDEA0BBH4xBBiu+3sRFMRjCKvovJdZwtJFY3F8eHfdt9e@vger.kernel.org, AJvYcCXue9kOTbR+t3eXLKhhFARKdos0iBUMqKnD2h+nPintnIXho3HScAyBLcCpBTegJgjMBks+F8wk+K+F@vger.kernel.org
X-Gm-Message-State: AOJu0YyvsZ+m5t93ZGHfk2SiEpoWQMvn0AriVjBNAwGhJgKenGWnKV16
	Hmyj30b2M22Htu8+Ohm6yihL8tjk5R6bYOpXZaTt1qcmdWNCcY430DiT
X-Gm-Gg: ASbGncvn/cgaszxMqa3Z7kOTpUdALE4gjUwQb60CoZ7/0bA5ykFI5JMaukg6s0pOP6q
	MG1UM0fLQJskGfqB3R1hxZJ1Bs8ULrzgAgZem5Db65SodhH8M1bnzGD1F9zN5WSiBuPqzrItn8s
	3ZwqIyaFWbika0jGHlI+v7sKdOu6TjsOOJDRR4Mxebi+F8UAibxJUJUhls495RUaeOPvSX0WjKX
	X7zCVCGRKoqULMCu6JC3uOmbo+Aj5Q20Ww3KQnoB3ygpjAfuBjjxZOHf4WJYDOACrK/rlaEvYuR
	bx++2i8no0FL2EntdH7XgqKvQDNDKk1s1YaodgRSKQ7C6l/ZLAucbTM+dQEEe1Ao03NUTElm6GO
	SUFJnLpFvJ7V9OjZM3Nnh4TuSFgzStX5gEN0d
X-Google-Smtp-Source: AGHT+IH830YEuyB4MXdUdEOOD+dHMQpl/fhkJereu7+ffNxmg5xdyPgfx8goLirZSrcse92QUZOgxg==
X-Received: by 2002:a05:6512:605:20b0:560:8b56:5da8 with SMTP id 2adb3069b0e04-5608b565ed6mr1699649e87.20.1756989366242;
        Thu, 04 Sep 2025 05:36:06 -0700 (PDT)
Received: from mva-rohm ([213.255.186.37])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ace9cb5sm1186072e87.95.2025.09.04.05.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 05:36:05 -0700 (PDT)
Date: Thu, 4 Sep 2025 15:35:57 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Eason Yang <j2anfernee@gmail.com>,
	Pop Ioan Daniel <pop.ioan-daniel@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH v2 0/3] Support ROHM BD79112 ADC
Message-ID: <cover.1756988028.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0G9+05Z+H+ZUP5BH"
Content-Disposition: inline


--0G9+05Z+H+ZUP5BH
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

Revision history:
v1 =3D> v2:
 - Plenty of fixes to the driver (thanks to reviewers, Andy and David)
 - Add gpio-controller information to the device-tree bindings
 See individual patches for more accurate changelog

---

Matti Vaittinen (3):
  dt-bindings: iio: adc: ROHM BD79112 ADC/GPIO
  iio: adc: Support ROHM BD79112 ADC/GPIO
  MAINTAINERS: Support ROHM BD79112 ADC

 .../bindings/iio/adc/rohm,bd79112.yaml        | 116 ++++
 MAINTAINERS                                   |   3 +-
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/rohm-bd79112.c                | 551 ++++++++++++++++++
 5 files changed, 680 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/rohm,bd79112.=
yaml
 create mode 100644 drivers/iio/adc/rohm-bd79112.c


base-commit: d1487b0b78720b86ec2a2ac7acc683ec90627e5b
--=20
2.51.0


--0G9+05Z+H+ZUP5BH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmi5h6YACgkQeFA3/03a
ocVg6wf9HSDLo23Jyafhlb+ggSOjPlV0Eqqpd2DwwDC4T65DekhgFbXHXDgHNvcZ
n1xKGXifavDK1R1nR2uC1C97V0EgPZO+FIkrQEdG9qaW0cjNzZ42g9cNoAASs6ib
aB1EzTNvwoY2r/r+xtQmWA5BdjirXc3Ldhy8CbFrTEFkuoLY5srdwFGkehPSBbO3
vqndCYXs85jKL88YjiJCbcZsyCzomKRP3q+6SjT4y+NOdoEZYjNWafFwRZPKmNmn
EAkdmQhhtiXJga/lRoQi+ITiWl5rjn2G2hDIlvIHZzAvwdjfF1ENwAgv+xGj/cyb
PqP9sfZwlfeNVuBU6ZOmaNAzz+3HGg==
=gkU2
-----END PGP SIGNATURE-----

--0G9+05Z+H+ZUP5BH--

