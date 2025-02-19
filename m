Return-Path: <linux-iio+bounces-15777-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF145A3BE08
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 13:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 332DA7A5C60
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 12:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFE61E130F;
	Wed, 19 Feb 2025 12:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2MTT+q9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDE51DDA3B;
	Wed, 19 Feb 2025 12:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739968203; cv=none; b=tqETQ9qTklnLeOnVJG31fK0LsQH/SwM/dV10EJi8vbjK30rXKelOusQUzNP58ed/AdZ0C09KYk067d6KwXIqdScHGrN+02TsM9CBWY7Bewz+uZISFDzaHJB9UnddFZ2NmDUjJGwfYpsxbOVy3mFQLCfw5ldARzUQWJAUybvmXFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739968203; c=relaxed/simple;
	bh=SlKuG0AdBwn/S5pE8rkdaa+Z4RfGUwCknA7f5LLdKiI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NxxCPf+M/+FjBrbN8ceuABiU9JCXsQeoAI230yjc6iBTKCnKTznhoNc4Nt3azKeLBVCrONmihOLolBTiExy+VcpezFnlzrHkg4m8r+B5BzOo9NJaHtrPbDIaV4d6d7Fy+CIPn1iEgkw3Z64xQuKvcoJyjNn2e5CgoXnZWdp8jqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2MTT+q9; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30737db1aa9so62782881fa.1;
        Wed, 19 Feb 2025 04:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739968199; x=1740572999; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+24dvPWABcFd9MeuF3ZS2A94KuzubvQXMwsC3UbrqGc=;
        b=C2MTT+q90QiIPNteIYC5JHSmFGLICmiuotjQUYATnTbhyFIx4faaau8K+yog+ot4O8
         MPgzThoz/Zd9J26CdQEgdH+1WZqBZNAeL+VZR73+4BRzSPIpCc1t2G7FK8nuXtsSRa8z
         Lg/b3yzQwxWOQhLwesC/XovGvQwGaOhZ/3i8sUb21KCYvWnNBZkdUEemlZTw+U7UOzJH
         XVSNXCRgVe4PIOa6JYUMqkNwQGzR10wwT2dejt4NbV64S6SrWxYQNoDn3BaIqelY4iUT
         4cv9/j0EaSPbyOJyqkF1lv4ttnGsg/GNe0ZzThlUh4h6yw8MUTGhyXM1VdGJHVTAv3wP
         XYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739968199; x=1740572999;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+24dvPWABcFd9MeuF3ZS2A94KuzubvQXMwsC3UbrqGc=;
        b=T4tEiIjxrv6E2KbnM8asLWLy3Vw0SAUG0hIV0BuwevscgJoqthv4sXNfTM2RJylnQw
         jqwE6H6vaIsS3lo7FtjWjyTSSS+6fZQSFOCNq2QYeBazvH7HorEh9nO7kSgmE1kBSBbC
         OBJwUSCK3NyxMNJk8QJymkQBNhOwMu3TkmDc/EB0+KcScymC5WoZBBVFyKxzJwI7jveL
         Z0ZOUa+9AcZKmqbZ2apP1oE7OU+jUJ4K6Z2psGn/NAwrfR2BMa7IvIgsfPFkVZwOqr0y
         j/nnWXoD0LOmJ1eobnghaVa811N5QmBYuNgFV+vJwV9j1D4MU66rxCEu8kiBr5Zi+WHS
         +gmw==
X-Forwarded-Encrypted: i=1; AJvYcCU2zbcxIg3uKulKlCX5w2fAfZLSS9yWGf09AXxapcofwypWqlD1unFqRslBeMNr5EJah/4rZ5SoSRBfwvlY@vger.kernel.org, AJvYcCU9Wimoiok+CcpqWcC4jOOw5JkqnCHKM6sBz0HcHhUM8I+MrajFTH4Z2MWwfbmrKTUAb8aqHiHUwXbR@vger.kernel.org, AJvYcCW42NdxEle7rixBe1LLibE8yd0e6YJlGsh66VGXVKO8T82suOiwMKW3LKB1KyPs+OACvIBtU7XgiS4VmTRGcqC8ALU=@vger.kernel.org, AJvYcCWCS9//0CoDsFAh5uKFqiUjlg0uM42D0uhObXZBZmL3voH2aDW10VLHoJKxkNJcrUd2tjHfcviYPQLg@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1jjmH5Fxz0cA0Ro1hRkUxhRlz/8hXNfCiKIkgQlQlpYXqVAYp
	n68uTFs/dA+9BVcNxBAXn2QqlCyBZQXSSmQY5ziOdnjzHioiumyT8DvQDA==
X-Gm-Gg: ASbGncsIHyDkDz5WODuRnuPlbPhs5T+YYvAF1f7sFKUuQCUVcGgveLF8yInv8x9RVjv
	JderfyZyGMTic2/kBP+Z50exySL0T6Fu4Qw8/WIUbSKF9QgV48v2qG6AgS4Tbfya9WlHZT030y+
	wK5dgHKxffZ3Q9BMX1HH5OL71WMRoD6VIZM00/pqiLxQP6zgg6PasPth41TlevxtvNPdd8GOrb2
	Tcyi9ZXJRU1Z8skRgT4Khd52Yh6fGUPzPgVnUMOyJM/KE0yawuEsWn9Y3fucR9uRK5sBTey4oor
	sVro2jqEfPe4PXcbI73qoQ==
X-Google-Smtp-Source: AGHT+IFQyrXqy5NpHLF7+Lu4p1h9WASYPxxPIwKuoow2XXCkQtMPyIwZy0Fsi378ablFiyznjOaaqg==
X-Received: by 2002:a2e:95ca:0:b0:308:da52:5672 with SMTP id 38308e7fff4ca-30a44dbb8eamr9477541fa.6.1739968199067;
        Wed, 19 Feb 2025 04:29:59 -0800 (PST)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3091029b75esm22556451fa.103.2025.02.19.04.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:29:56 -0800 (PST)
Date: Wed, 19 Feb 2025 14:29:45 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3 0/9] Support ROHM BD79124 ADC
Message-ID: <cover.1739967040.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VPbxCdjMCaKD7rlG"
Content-Disposition: inline


--VPbxCdjMCaKD7rlG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Support ROHM BD79124 ADC.

This series adds also couple of helper functions for parsing the channel
information from the device tree. There has been some discussion about
how useful these are, and whether they should support also differential
and single ended channel configurations. This version adds support for
those - with the cost of added complexity and somewhat harder to use
API. I've babbled more about that in the patch 2/9. (And, I actually
wonder if I should've returned this to RFC?)

The last couple of patches are examples of drivers which could utilize
these added helpers:
 - 6/9 converts rzg2l_adc to use helpers
 - 7/9 converts sun20i-gpadc to use helpers
 - 9/9 makes the ti-ads7924 to respect the channel specification give in
   the device-tree using these helpers.

patch 8/9 is small simplification for the ti-ads7924, and it can be
taken independently from the rest of the series.

NOTE: Patches 6...9 are untested as I lack of relevant HW. They have
been compile tested only.

The ROHM BD79124 ADC itself is quite usual stuff. 12-bit, 8-channel ADC
with threshold monitoring.

Except that:
 - each ADC input pin can be configured as a general purpose output.
 - manually starting an ADC conversion and reading the result would
   require the I2C _master_ to do clock stretching(!) for the duration
   of the conversion... Let's just say this is not well supported.
 - IC supports 'autonomous measurement mode' and storing latest results
   to the result registers. This mode is used by the driver due to the
   "peculiar" I2C when doing manual reads.

Furthermore, the ADC uses this continuous autonomous measuring,
and the IC keeps producing new 'out of window' IRQs if measurements are
out of window - the driver disables the event for 1 seconds when sending
it to user. This prevents generating storm of events

Revision history:
v2 =3D> v3:
 - Restrict BD79124 channel numbers as suggested by Conor and add
   Conor's Reviewed-by tag.
 - Support differential and single-ended inputs
 - Convert couple of existing drivers to use the added ADC helpers
 - Minor fixes based on reviews
Link to v2:
https://lore.kernel.org/all/cover.1738761899.git.mazziesaccount@gmail.com/

RFC v1 =3D> v2:
 - Drop MFD and pinmux.
 - Automatically re-enable events after 1 second.
 - Export fwnode parsing helpers for finding the ADC channels.

---

Matti Vaittinen (9):
  dt-bindings: ROHM BD79124 ADC/GPO
  iio: adc: add helpers for parsing ADC nodes
  iio: adc: Support ROHM BD79124 ADC
  MAINTAINERS: Add IIO ADC helpers
  MAINTAINERS: Add ROHM BD79124 ADC/GPO
  iio: adc: rzg2l_adc: Use adc-helpers
  iio: adc: sun20i-gpadc: Use adc-helpers
  iio: adc: ti-ads7924 Drop unnecessary function parameters
  iio: adc: ti-ads7924: Respect device tree config

 .../bindings/iio/adc/rohm,bd79124.yaml        |  114 ++
 MAINTAINERS                                   |   12 +
 drivers/iio/adc/Kconfig                       |   15 +
 drivers/iio/adc/Makefile                      |    2 +
 drivers/iio/adc/industrialio-adc.c            |  304 +++++
 drivers/iio/adc/rohm-bd79124.c                | 1162 +++++++++++++++++
 drivers/iio/adc/rzg2l_adc.c                   |   41 +-
 drivers/iio/adc/sun20i-gpadc-iio.c            |   42 +-
 drivers/iio/adc/ti-ads7924.c                  |   85 +-
 include/linux/iio/adc-helpers.h               |   56 +
 10 files changed, 1742 insertions(+), 91 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/rohm,bd79124.=
yaml
 create mode 100644 drivers/iio/adc/industrialio-adc.c
 create mode 100644 drivers/iio/adc/rohm-bd79124.c
 create mode 100644 include/linux/iio/adc-helpers.h


base-commit: 5bc55a333a2f7316b58edc7573e8e893f7acb532
--=20
2.48.1


--VPbxCdjMCaKD7rlG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAme1zrIACgkQeFA3/03a
ocUsDQf+MzovJEb2dg7/IVoqkcsWktNipBVWqti1q0SzAim/n4IZOlirx8H9AIrL
fJ2XTMTWXnBwILjIocXuJFYRVnOqvycj24bKxfPxDFf1+FUdmi5fH7DfpLkhdYCS
2eODnHijf63nwjWWd5b/IlljdDtaD5G3B60dNiZ7lFqGsS1gC/qlSCJhU9L2N4UE
o6+uv9mTZMDGIS50sFRwLHPQmLTCeERT2BISZEvUx2tja3oRyUcn6mDj78qeiTFy
5GNg5n2ReMybSVjkK07jlToFJtVy1A+WRU+3BVURyB0vfoaOywcPwj2px8GqUF2Q
nheY0QtC2h8bZvny4IEeWB6TcsLDuw==
=T+fL
-----END PGP SIGNATURE-----

--VPbxCdjMCaKD7rlG--

