Return-Path: <linux-iio+bounces-17527-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F8DA787D1
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 08:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 879CD1892B45
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 06:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDE5230BCB;
	Wed,  2 Apr 2025 06:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmfAX3nh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A99F136A;
	Wed,  2 Apr 2025 06:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743574078; cv=none; b=nOuXO9S0XTqbZLmdPAJjgCRaBruDVFa8FffQS9Sz9QfXA3ryY2aXU6dWbCTlC3vxU2CWR461ye3M/tcLAdxW0EZwMdZCZqgIh9d8pfFxOWtNAOgdnwOOeUzU6llq87/BztY7Bhs/THQxVRzwMMjI0cYI/vm4sqgJQsNNj6IM/Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743574078; c=relaxed/simple;
	bh=iQZKmcfrvYw2H4reyjMEFc/jtt0LL0qo90jgrTQGgyI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HLAecFvD7DNQPgZgujzYJJoN7IkEDd5iDNvpksGVCmFpGT5mCcjeEJMvPUugvT4hx4DD/1V2vxxtdNTKEs6shoLlOodcCjiOK22JLI824809Nlcu9AiFfYg837eBmPcVIMJ1G2DGVwHvfn9aF3AKqIjbfhJGHQ+HlIzEAKGFdKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmfAX3nh; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-549963b5551so638621e87.2;
        Tue, 01 Apr 2025 23:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743574074; x=1744178874; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=28Z4Zm2PHdjAhEdpwVfHLH7cBasyS+w3UaN8SRN8HgM=;
        b=RmfAX3nhiDBP0toJ5p8iHlBDF5ToWb2ICy+E79nWxV6ui2svnkXXWtL8hmYisqL33v
         WvjpHkbVyafts4npo6KP/5jEJ7iyvNxqPYISYtY2Q5QbgyNGgOdEV70L/0L52QaRLDX1
         yoM1ZxSL23SBpmlUYhWA9zjnSSEt2UI9HtwpveKyoGPZyOV51n9COW0Db801F+39jRdA
         3QXD3l6lNCPTeguxacXa52NS+h5sdfRiS9xoUZluLVJ1FfK36ARTuk1XCXPKKv1Kmt4O
         XRX4raof3GIcBr+Nk1ilH9TeMlC/aE7RMa1thmd9KugOtpBrYOfSbKw40Z2I17obk9C4
         Dahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743574074; x=1744178874;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=28Z4Zm2PHdjAhEdpwVfHLH7cBasyS+w3UaN8SRN8HgM=;
        b=BpZh8InCfWn484flBPA4jSPEOZbIHRlW/xMTVjogd4rjvgMrxn2QLmCi3RseHdyzGP
         QKyw/dUJ4EzvWVlVh669OpH/M4WZw3oHBkW3wc46Pv7/zSh9DXQSkodugvjF42CaFYrV
         2RNhcujUG9+1hYtAwrc9F4VUMptJbliQ0v4KYTfQP6sGS8PG/Y8U/gsw7uNoYlkjSRoO
         /lOjANZrNz7WXL4lYTWx/4zbeExgW3OkYMo1ZJJtfovXgD3hxXuJNKZD0b9uQDS6Q04s
         fM+sGJdV4f3RgdUA+EknhoEbl5in/sXgw1mEhrIYNkcEd8DrLBvFtzVm2jURrjGQdAS7
         yXrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO47+reIDrPdDBqFLi55bhdMqrd3FaSH9dErDWur96q+H5cb34/QOJUcQcdC50krGbAow+msJnP5ky@vger.kernel.org, AJvYcCVjfNwplvncnRqcnvjiFbtrFY3HiUgPrTsDEP9u/Z0fyeZ8t9eq/3kY6zRvTCBtrtQwQrQQOwzgY4zqMLnP@vger.kernel.org, AJvYcCX09epOhCfiDkh9rvAyJCOxhYb0eYhCrcaX9E/LQYFoUuFNR5yvaTorxz8hEyORBdN3Enb/6iPvMBdJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5epMWXB2hh2T9YKFPX7p3D45zuxoTr/H9Lk4A5JWCPTi9w8ZG
	BzC2O4ehTL+Jy2cOC4rWVKAYdVR8oU5v+vOobRbpyPfNwBtOyjA/
X-Gm-Gg: ASbGncvMjfr8HAU/mMOT2fq5uBe+ZbDOflDauGY2YK95Bmj/7iz73a1oExdFYXeIcSV
	LmYy66kzoBirEXHmmY145KKy1KQEZfTJXLA9VWejLGnJXdIUsLh37uEeQK1gyz1kWXFeH6MYctT
	uQyrG05KlyLHJEHShyjkV9IfBV0qovZzHhUY5r4C5MoPvbt+ti6yF575y7XuD/MWIAhMrxt7PQ+
	JHdq0wKDVToMArwNXBo0FiIVl6nMMPXDulsQbcXZxO+WFhKxaZXxurohG93R7pLyr5fOasICL6l
	Bz7QL3nnfslJrlx4/rRAlF6xcLnn/oKed92yYM+F67NrcJ0m/KmRl9NthT/K7w==
X-Google-Smtp-Source: AGHT+IFz/Tb81fyLheX+H39nO3tYuI+YUtWpwr4EWokF75+dQOzTOux5bsofMyR1sRfeQZditOKEiQ==
X-Received: by 2002:a2e:bc8c:0:b0:30b:efa3:b105 with SMTP id 38308e7fff4ca-30ef912cb2emr4122071fa.19.1743574074060;
        Tue, 01 Apr 2025 23:07:54 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30dd2ad6253sm18345221fa.61.2025.04.01.23.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 23:07:53 -0700 (PDT)
Date: Wed, 2 Apr 2025 09:07:46 +0300
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
Subject: [PATCH v2 0/7] Support ROHM BD79104 ADC
Message-ID: <cover.1743573284.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GCTXrN1+nWA5PRaT"
Content-Disposition: inline


--GCTXrN1+nWA5PRaT
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

Finally, I didn't find maintainer information for this driver from the
MAINTAINERS file. I would like to add myself as a reviewer for the
driver, so I can stay on track of the changes to it. AFAIR, having
R-entry without M-entry was not appreciated. Any suggestions how to
handle this?

This series was based on the v6.14, but it should apply cleanly on
iio/testing - please let me know if I should rebase.

Revision history:

v1 =3D> v2:
 - Drop the claim that original driver is broken for BE and rename the
   patch 0001 accordingly
 - Fix race when filling the SPI message
 - Check return value for the devm_mutex_init()
 - Add a RFC patch for dropping the support for variable Vref.

---

Matti Vaittinen (7):
  dt-bindings: ROHM BD79104 ADC
  iio: adc: ti-adc128s052: Simplify using be16_to_cpu()
  iio: adc: ti-adc128s052: Be consistent with arrays
  iio: adc: ti-adc128s052: Use devm_mutex_init()
  iio: adc: ti-adc128s052: Simplify using guard(mutex)
  iio: adc: ti-adc128s052: Support ROHM BD79104
  iio: ti-adc128s052: Drop variable vref

 .../bindings/iio/adc/rohm,bd79104.yaml        | 69 +++++++++++++
 drivers/iio/adc/Kconfig                       |  2 +-
 drivers/iio/adc/ti-adc128s052.c               | 99 +++++++++++--------
 3 files changed, 130 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/rohm,bd79104.=
yaml


base-commit: 543da6252b48bbfe13e194fb980bdd2b161f6838
--=20
2.49.0


--GCTXrN1+nWA5PRaT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfs1CsACgkQeFA3/03a
ocXRAggAnOHse1lh+eSdJikEPk+ErzHWKsGblEPh3Ggs5KsbaKxStanFqOAxGkvk
/oSOMV7i/CEh29eSOKAXj1if9t97KXse826Ughu7ZM/XD1NZfFklgrUKh+hAnr4Q
S88F8enDJHKLPM9QfriK/PpRY2qmZCWHKdaYxYIrC6oSUdmfxaXCzNY4ILjygSrJ
bUDEHyckYXio7HOfONNmM1K5CIsQLWHFO+v5HGBvFyR7q82kQTJqYc4uGyy5rUP3
coO59Fh6agbLMDu//ECpEWBAec8FOtXr1R1E5bTUf96tIqs11MbOCN5o6fByUW0h
8UHsC++uuGLC5Vg7vWpTfQrv0/go8w==
=J1QR
-----END PGP SIGNATURE-----

--GCTXrN1+nWA5PRaT--

