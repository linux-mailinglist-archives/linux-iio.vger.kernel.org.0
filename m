Return-Path: <linux-iio+bounces-17750-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254A2A7DB68
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 12:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E89D616B0C5
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 10:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AF0237163;
	Mon,  7 Apr 2025 10:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="At47Mu+Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CF6155312;
	Mon,  7 Apr 2025 10:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744022699; cv=none; b=hICuTnKzQEkXf/yNnZ4hjusKN7xbwUsMg6ETAahHU0DEiJYXna5nZSBNuavVPNhVxnJZS778W9qfRA+dBgyfz3Fpd/j9+itsz5pjyFAsuxiC82Nu9VK7xINnWKnCCOFWfh0uZbxPjqz9sqS0Ud2wVLYBcYLThs7kOBHhPX4gixU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744022699; c=relaxed/simple;
	bh=QiqFrvmmVw+N2Uw2KU5ql7TcSX6YQZ4iOivPYU7G8d4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=n45/yJVBjSBU5SOUxSnu21RVItwjR73bhAjRUNk9MxlWTz6/TzBn2yxq/BTa4EyOO1JXmhT5t8k9m9GyLZThUziENwtgBPvxCy+foUE8eIhqmGw3MaXg13TM23Pr4IkaH96CDCBbCapGMFvB91PzrlI1Zg32frO/r6w3q47AzXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=At47Mu+Y; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54ac9b3ddf6so3913345e87.1;
        Mon, 07 Apr 2025 03:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744022695; x=1744627495; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fedk0NTG7dIvyZOxge8ehVPeLKkiS67A38IL6ZEQtH4=;
        b=At47Mu+YcRCXfwO4zb+5z9cKCHmf+CWE5PqpF4h8hnsSmc6sTTMQ/TVQwPSnZIhJz/
         AXFQX7YHElbzuFy7ixfQ7nbaMDcbzLiRyJysnW7W8w/W09B6en7ZIgmSTgjFvXLCCjD9
         5wclLNUI/wsOHginvD9ONKCO7S3/dySWZgRR19oKHzM9uuXu0V4CkIzYh/owTeoXdT+d
         Z9cL46CgZQjGxD1I3eakdhkLZc7ZLBcUIEbKWh3SbsAKfGBO1m+qIJ74043aYWQIF+xg
         2u1VA18fal8fSXYnSquLVy69GQSRDJ8+Ei5NBL7ccfHHXNAd+zr96rzpL+gKefOs+yoG
         DvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744022695; x=1744627495;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fedk0NTG7dIvyZOxge8ehVPeLKkiS67A38IL6ZEQtH4=;
        b=I/HeuEtsY6iFuE+6kXJPU6vFXOdK7hDd74yOrr021dyA17a6QDUQ01ZoNV0HgpfkTJ
         BxpV7zs07MPX+TdHJoHMEHjQqqz6I5v8fwTm0+EkGLXFRmyFwMqy6lYkldKLqkW7Odr8
         i81nfe4bx6F40qKB5fmdNJL2ivHquzjgP2EyMiwRG4J6dsefiYuv86zBxAuyzgrZ3WYz
         nTi5lKUckg4CqfRuuXq/yySJf+qMcVI3fnM59f/QTKMEuFkl640bV/lMTpxPf8uYmeYV
         wC+XONFj80RJ2TpU9w7lVvE2WgOwUyOPCmkw4NXZ9s31sDn8LdQnwymHqzFZYVA3IsGk
         UMwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVspaFNsX7wPHa8weWc4C3WSqZwk8O+VUkI7jDM/WLe4z4KuP7b00DmVGr93NgW2CnVWef9ro7DZenQqlEg@vger.kernel.org, AJvYcCVz88rosD0bUeSb/6p4CxOv3oojhDBvAkKhO5aXgcoWxKFAM4aV8gGcmP8uZ9bF2HG4wWKtNdu4AYrD@vger.kernel.org, AJvYcCXPAA0kv+a2V4nQ31v3JqsdSuxLRIxl64EYvQYHQoj1zSzNoacmQGOXCJQ/vXU5etUbSgT0x47508pf@vger.kernel.org
X-Gm-Message-State: AOJu0YwmFi1O2GpppPV4yW05jJrM+DeL4Xct8ZWMnWYDuNJHhIeXyTg9
	ZOIihQ2mZ2SWqDfqed57F3TUySU9ynteZmE6u+qbJNzI1xBTowb9UamA3w==
X-Gm-Gg: ASbGncvkgU0CH7L86OR9dB0vi8WoROdanTTvpK7Cc03UtvQFgqgHna1P7VW1xOZAsw5
	byAKG0mVjdG5KrQDE1oBVuNMRzZdpI6ytPbNgiKngBh3hDK+mQ7BxdAESWcF/ta/UJDXRiYPygx
	bhn6BIU8hjCil8Lgu124tKV6mH26w5KuBwylkvyr/cxd3h+phLMg4OQhHPjvDr2UDcpRRBKc+z2
	H+XV+W94pctw2lIFK0Qpc5Uv047nDpm8jUG7lLxjoYp3d0Lxi52kzRyu39RY+dszGEnmo/3mKGn
	on6Uao8l8ImC/kK714RjIR1iz0RzojvFfhu2VuUzBBPP69fzOP0=
X-Google-Smtp-Source: AGHT+IEX4hEYrJq0c6xrNV8StN79EKIII9msXPaeyu0uJbkmxcP8gqMKNDTktthUksFdKHnPNdqsSQ==
X-Received: by 2002:a05:6512:3ba4:b0:54b:117b:952d with SMTP id 2adb3069b0e04-54c29848292mr2222175e87.54.1744022695230;
        Mon, 07 Apr 2025 03:44:55 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c1e671fa8sm1205737e87.218.2025.04.07.03.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 03:44:54 -0700 (PDT)
Date: Mon, 7 Apr 2025 13:44:46 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/8] Support ROHM BD79104 ADC
Message-ID: <cover.1744022065.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1xOCUHzjGimHh1+K"
Content-Disposition: inline


--1xOCUHzjGimHh1+K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD79104 ADC is a 12 bit, 8-channel ADC controlled via SPI.

The communication over SPI uses similar protocol as the ti-adc128s052.
In order to avoid code duplication, the support for the ROHM IC is
added in the same driver.

The driver side differencies between the ti-adc128s052 and the ROHM
BD79104 are related to the supply regulator handling. The BD79104
requires supplies for the VDD and IOVDD. The ti-adc128s052 driver
handles only the reference voltage supply, even though the TI data-sheet
indicates it can also have separate supplies.

Hardware vise the ROHM BD79104 requires SPI MODE 3, and has also some SPI
frequency limitations.

I decided to add own binding document for the ROHM BD79104 so it is
easier to document the SPI limitations. It also allows using the supply
names from the data sheet. And finally, it gives users of this IC a
better hint that it is supported.

I added myself as a maintainer for the driver, so I can stay on track of
the changes to it. If anyone with experience with (and acces to) the
TI's ICs has the energy ... feel free to add more maintainers.

This series was based on the v6.15-rc1

Revision history:

v2 =3D v3:
 - Rebase on v6.15-rc1
 - Minor improvements to the Vref handling
 - Add MAINTAINERS entry
v1 =3D> v2:
 - Drop the claim that original driver is broken for BE and rename the
   patch 0001 accordingly
 - Fix race when filling the SPI message
 - Check return value for the devm_mutex_init()
 - Add a RFC patch for dropping the support for variable Vref.

---

Matti Vaittinen (8):
  dt-bindings: ROHM BD79104 ADC
  iio: adc: ti-adc128s052: Simplify using be16_to_cpu()
  iio: adc: ti-adc128s052: Be consistent with arrays
  iio: adc: ti-adc128s052: Use devm_mutex_init()
  iio: adc: ti-adc128s052: Simplify using guard(mutex)
  iio: adc: ti-adc128s052: Support ROHM BD79104
  MAINTAINERS: A driver for TI/ROHM ADCs
  iio: ti-adc128s052: Drop variable vref

 .../bindings/iio/adc/rohm,bd79104.yaml        | 69 +++++++++++++
 MAINTAINERS                                   |  6 ++
 drivers/iio/adc/Kconfig                       |  2 +-
 drivers/iio/adc/ti-adc128s052.c               | 96 ++++++++++++-------
 4 files changed, 135 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/rohm,bd79104.=
yaml

--=20
2.49.0


--1xOCUHzjGimHh1+K
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfzrJoACgkQeFA3/03a
ocUttQgAvbxsJJotInDDIxfSYu1p1RzxNQsE9UIOT2xrutffLQjr4+HBwCMRq37B
ErzZCvHwdqy47Mamj5yN+Xo9ZQF8sfwShJNNX44anufj3fyWj+8pEo/MDQB12TxK
pxDkLZvznQL9MnUFaIV8rROIYSnepPbs4dv9eacAZcnMZjtMOJVrjAn+e1RL08NK
gjgnb48TP2yqHdsRno/z8AcYxn9F7PM/vJCleTQxac6cwSvo4sclq/BaEpGoyBy9
2ez05x1RnQokGx6927Kq3PQc8S9zFaTXvbeo9WOasMMOMBRAsu0jvw4GlpABLSo0
CpwPdeqz48ir8m1MoBLodmYyqNPc5w==
=qd6o
-----END PGP SIGNATURE-----

--1xOCUHzjGimHh1+K--

