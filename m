Return-Path: <linux-iio+bounces-23732-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B73C9B44E0E
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 08:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59966A06740
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 06:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7187F2C0260;
	Fri,  5 Sep 2025 06:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbWv+LFL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774AA2AD2F;
	Fri,  5 Sep 2025 06:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757054490; cv=none; b=NCP8d3jml9K5E+2b+QYZPLcGEAZv6vqfynTeFAWSCO8GsH7F2kbiRYAjqUNqQV0f5AIBtLyok2WDTMUJl7o6SDaIR5t8Z8mmj9RC+CUe5HT1m5qVT3Yc7M80Bew+A4JBqpW6C/3nPtQ7N91TPm6xOjqe7ErzVq2kz18mfLAMdIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757054490; c=relaxed/simple;
	bh=NZFkseZkjzL6Fkv0b6NxwoHKiu8b5mIGz+R6t2D1ZbM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LlKSAB6fBMbQGUJvD69iz04kc3W/S632WcVP9itkNxvTe8HElofNwFlk5LeeDp4QJTkrURvPTENMPJjA710Jk1D4yoRcHJkY6r3ZbwFwoWMZGXkpIx1qv/hHBGYhapUtxTG8y7eD7MJz/SGabgGaynOrY6C3mZKLEAiUSARCauU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbWv+LFL; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55f6f7edf45so1826508e87.2;
        Thu, 04 Sep 2025 23:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757054486; x=1757659286; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VjdBUoIejYQ0d1liNcdBl+wSNDEtAg+1bA2FnYRKKT4=;
        b=UbWv+LFLdklKa2szFdso1BVx8zaqREOntSVYTYrD0fKJuJmayPKZBJViDnlFYcwPRe
         9eW75K+l6v8XDh+nSyWPQH+tZdDcj3tXWCr7U8V/zoSRN0i39KhekukBCUZw3WySvG3C
         maTIvFBRwDpu7b8MLJ4PjJkHW9Jy9onKlOS2nywYFt6tVRccZj7MGb+Psna0uRr5M8QM
         UKDHPMGdG12FFYYej8+HQiIiDC35iZNQIxe7LIoYP7fs4fHjRciwk/FMgZP0HZC5kyY0
         Te2afbAg3eGW6c9bIXjOi7Bc3QU772UDbegKtgIVapQ9UIEUfbVH6s4A80MsljO5Onar
         k8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757054486; x=1757659286;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VjdBUoIejYQ0d1liNcdBl+wSNDEtAg+1bA2FnYRKKT4=;
        b=Abd4vdIFFu1Zzdrxyuqt5L2um5yORRCT6AGBHpcy62vDaTjvQZ10OWPVyj198XZdwZ
         CTU9EK+w4Sue/H5qHkg1zbkhm8bnuoza0gZ87VlCO84eG0I8Y85dU1z7vJztB6aWMS+Z
         rmFzw8gx/IB8GYVHtoHEbC5bqBHa4/20O2UdpW/EUM9e0WQtqxEZMGvdUnWWIvbxaHeC
         5JVqHKQlWeeNDA4bf60CTasZg/kd03m2YcWGAeYbR6mIhW0mzILqan+vDpBPJ3uyC0dv
         kR6CDDNpCt76ReduYgrCYtOguT7skKPQxBIADTK+StQyJTLUr8jmia95MV7IU45clEfS
         g0Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUA8TtrP7xiRiSGetBFvynIfozixNQGYAk2n8pKgElYg432qjHJwv0iuYBiq16DSp32YKwU9V4MJnAa@vger.kernel.org, AJvYcCVjZoYnLjSAb64YQ5EjMRTVrPDU3KNsq1PJcEC7bEGJ1nsmoGg64dX3AekEbMJGBHzhE6O0hitfQPzHoA==@vger.kernel.org, AJvYcCVkCNS5FCA/bOGmN2JDe89WXildC4Jt8weJ01p7tYVTc5TqlTnzkMyyDHZL43q99LXC4qW30tK1FK+YvhMI@vger.kernel.org, AJvYcCWzqj2GVY6VLMirYiA/JhbsS8af/DhXtXUrZbH+pafFuw/tll8pdMvdPyZDkWYYryUVPr8smk2+stNV@vger.kernel.org
X-Gm-Message-State: AOJu0YxnZVnKCr/5TzMQNa5E7Xw7iywcy38GMOS7KTwcztQlVaOmcQML
	8FUP6k6F/q5h3Uv8dqx2+AioQFVD+jcRPATunEEwb6mZsA1ZZjvYUNmh
X-Gm-Gg: ASbGncslvYw1RhvDPvGjTY4DE4EEH3pldp+uhyW8mbkwHBH2w7Rj5ha+nywA8D4eqkH
	i/piV++4NYsSoU0XjI3IhoCK7eQrGEzfhLzqj0hmCyxaqeBSO8WDAz4QyigxW+xVgms+BYM5ns2
	3yZui3BIgUgfObLDEhDf/Ao/cTB0LV0BD4PjRYNVY5APPjY8yGvjdyWFGteuaCNv2+B13sJVXBw
	vUO5/7rX+SuVq3meShuT+dSi3A4rcVOvhHpssIX27fUfhiCj7ajYYMOcPnTrNeSAlD7M+tby6iD
	G8mCy0zG6sViS/S30fAXZO2c/Obaf+Q7/Btmonny6RZdXhs0Oq+ixagv3+7fWj2xsSepACuMLkx
	0rKuHItLTxDPI+JHPUiyKtDypG8ilpw==
X-Google-Smtp-Source: AGHT+IEbLkFl3txe5G1HbR7RZN6w2pzEdTHoGNMvuNcVeSEtMS6A2m9FCsGIxZ3RMv5fS/n1bDB+Ug==
X-Received: by 2002:a05:6512:2347:b0:55f:6ddb:25 with SMTP id 2adb3069b0e04-55f708a2b1amr7633064e87.3.1757054486339;
        Thu, 04 Sep 2025 23:41:26 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ab93ebcsm1649573e87.47.2025.09.04.23.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 23:41:25 -0700 (PDT)
Date: Fri, 5 Sep 2025 09:41:19 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	v3-0001-dt-bindings-iio-adc-ROHM-BD79112-ADC-GPIO.patch@mva-rohm.smtp.subspace.kernel.org,
	v3-0002-iio-adc-Support-ROHM-BD79112-ADC-GPIO.patch@mva-rohm.smtp.subspace.kernel.org,
	v3-0003-MAINTAINERS-Support-ROHM-BD79112-ADC.patch@mva-rohm.smtp.subspace.kernel.org
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
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Hans de Goede <hansg@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH v3 0/3] Support ROHM BD79112 ADC
Message-ID: <cover.1757053456.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UFdqrImNvPq8YtRT"
Content-Disposition: inline


--UFdqrImNvPq8YtRT
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
 v2 =3D> v3:
 - Mostly cosmetic changes to the driver
 - dt-bindings and MAINTAINERS unchanged

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
 drivers/iio/adc/rohm-bd79112.c                | 547 ++++++++++++++++++
 5 files changed, 676 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/rohm,bd79112.=
yaml
 create mode 100644 drivers/iio/adc/rohm-bd79112.c


base-commit: d1487b0b78720b86ec2a2ac7acc683ec90627e5b
--=20
2.51.0


--UFdqrImNvPq8YtRT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmi6hgkACgkQeFA3/03a
ocX5mQgAgZX2gG6uk6+4Vq5z5rhopLNRaYgcYTmAKLy85KASCFJytTw3zKijiKDY
xV3qproNsBPUspXwTwygaVtNWWwgcBEFgmrukcrsQK5qaHa46uIro4VbcK+Rs2W8
toc4ozHJvvwwXuGuCkGeGc9waOijnq03rd6Jsb2TIVdzkI4jxh7dbim5fJWC3aQq
/CtKYjsmn2SL6yKFWc648OWGWCtJKNg1prFhiUOVXh3Jije8Rcx2XNp8ivO7aAY2
X4M0zPwzxECJTpqLQqFY3Q+9Wsd3rSput0bKsKC/rMR74I/FLuqHbkPtwH6QJPxt
gpIcMH5BTPhOEKuAPw5ebvBMMSJPcQ==
=PK4a
-----END PGP SIGNATURE-----

--UFdqrImNvPq8YtRT--

