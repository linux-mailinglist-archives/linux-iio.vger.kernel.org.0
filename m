Return-Path: <linux-iio+bounces-17137-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F20A6A115
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 09:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ABB67AFB83
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 08:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDFA20C480;
	Thu, 20 Mar 2025 08:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nR0vIyLX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A0679C0;
	Thu, 20 Mar 2025 08:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742458845; cv=none; b=AJVSjp0EgzpNEvw8ozeu7K7Le6Md1Xp/1/3mMxfwcSRlzE4/yQHPyvoIEVo5AZI+sR60CA1N6BDQUkeCtgdIQPdQJQgAmDhvBQqfEdTMBG+2dn7Qw8d0KHl2xrr9n++hrbB8koLkH/hHNg02pwg8V4TYIhM9KYwGiELIGmfPcvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742458845; c=relaxed/simple;
	bh=ChysvofED6/qp4H6ckCX8CPGxxeohDJRgBl7V7bQEk8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m9n9akBfwapWOEOwEsWiwk/ER4x5gfR+tvuPY988KDjf1WwBBByGpHAMdzCiro1ycKT7i9mPlbog0J10jPbcvITM+DG1DcFDUVVlr6tdWg7qWqFKXpFCgYtWHC2emzvp+C1sw0FbUxo1L3KyCXjNGHCOpLbmRlEbxpuusyLWzjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nR0vIyLX; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30bd11bfec6so5595931fa.0;
        Thu, 20 Mar 2025 01:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742458841; x=1743063641; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qcBMPfg10XMsOOKKKa4T9Z75+9TBcciaNtXWqiNMB48=;
        b=nR0vIyLXkcstFYYEDevlVVa+W07TW8ZT8beyauOzMqWAIfxLsRExDGzg5TSy4Vv7xe
         dwmBpshgdOJn0vTZZN/LRN2AEGaZxVOS6KvDqPIxkFzhDnlKG4aGPEwajLKUFTSsx3uW
         LeoIE6S/cKzX01I7VJUgPGhtDHct8dJStQPkjzkUeXXD4z/ZBD8B8rjkqz/EgiTth+Wf
         fyYx6sJai6i0f5QiSYUnmR70+qqUXpwsgDTRvvCNw1CwglON8pvoNzj3tUUS3PY+IY59
         Vn2gqQ+deuxnZUa/uU7DJtY7LYrbkuRDVqYoLNfKBR0P9TbU/G6NnNA7HnIWtkvFdE1V
         GHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742458841; x=1743063641;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qcBMPfg10XMsOOKKKa4T9Z75+9TBcciaNtXWqiNMB48=;
        b=YYCxGwedfCFLEBlaOPOn2ZqiZxkvo67/oQG+jBF+JDfoxWWp11Wucpj2UY0QOweTpN
         wd2NImewb5Be1WLnHhNue1oIyoxpO1r+CzVwwLodE2W+gVMAUUqJUYlkepvttMvaAw+c
         LN/S9S+W+7VLqJSmrr+nJXfMgbCA6yDlKWxEz87VCU7A73ZIZKHkI2K2QX/cmPGI56le
         hgG6yJs+yJG7qhw3WpHxaxcshLTdltCsPUMEHCnRzoiAeCO0dTi30bWPFzpdjE4MnXDR
         KEQtQZ3nfFmTbI4/86QzhCYpFn8TSKhwIvRhw7dy9uw/qbJoqtJOu2Ho1d/+/NyT++7f
         6Fbg==
X-Forwarded-Encrypted: i=1; AJvYcCWKN9RsAPtDuJCP8CatxvnP3yTMe3f0k5LVIpgDJVMo8xOeDkh/n8NtMLxzSRKSq5rloCCezughhqfy@vger.kernel.org, AJvYcCWQ/TVbUzzxjLBQ6EF2NoqBQsXiOT2f4IZn4bOZl41KYQ0LcyHNyCns3eMmHVPaQWH9KDyTX59BJTS2rg==@vger.kernel.org, AJvYcCWyeT0cBEysUyy1YY54z4MBoatH8bRsmwB9NBdlSBxsEZpRGM/gcy1GAfMGQCD5k1NcR/CYrjlEZgu5@vger.kernel.org, AJvYcCXHsFG2eFKvvnoDiDc93QSYNSz3y5JaH3eg8perqpaDbR1eHXIFCaPFM/7Hnj07m1CXC6HVjb30wP/p+bCzHycjWP8=@vger.kernel.org, AJvYcCXU1xPW0Jl2AR0iOzROwhpiCUVLE2W/e/waUeKLw3YunOkta7+rB3kftXkttf+Kl3v6IJbUHjbE3T5TJgIL@vger.kernel.org
X-Gm-Message-State: AOJu0YzjlP1QHkFA6E8bKruvh5gOJAY1jiOtZEBPLpAGoNP7QKCWKOGP
	Zc2E1alSvGY7TSzy4LL6KiuG7tYnya2SOUl+9aY/tIxWCWVmYCar
X-Gm-Gg: ASbGncvEXA3OrxT/uuhsyp8RebLAV7MCWxyrNPFXciV+uuRreQvcgsgzjI0hwOQZS4+
	XehkEMJ5fXUGbrOgQDPtoD7+xbj0PoLmmFRqcFu3+7/6B5hAnvsjQGIbj+paRb563zrHwSc3bLZ
	FPBKF4Wt4CB2YTiQSK4KccE06pD6kMjfzzaPLeSxECoLHV/fsQsdTjqjd51yUDh+ShtHzHwjg2s
	xJQT3OpJ1y2iyGagdvxtPyIOti/GvGTW1fXhghiWrdPgERkGSXaTHWcnHDCVEbqRM77cOKyEhV/
	+iVhvaeQnIPu+EyPeHczy1DKBER2JuNBKnl0YLAFcRQxvv5dRVk=
X-Google-Smtp-Source: AGHT+IEB7xNRabtoDCrqpRPpYSHi1cLEIKy0GXAIlYchpxKvuhgZzcxQviLJ3YHh+2p0B1Ru98dxhA==
X-Received: by 2002:a2e:bc0f:0:b0:304:4e03:f9d9 with SMTP id 38308e7fff4ca-30d6a44cc9fmr22997491fa.28.1742458840786;
        Thu, 20 Mar 2025 01:20:40 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f1db81esm25239221fa.99.2025.03.20.01.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 01:20:39 -0700 (PDT)
Date: Thu, 20 Mar 2025 10:20:32 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v9 0/8] Support ROHM BD79124 ADC
Message-ID: <cover.1742457420.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YoKLVAxRz7wFwxMC"
Content-Disposition: inline


--YoKLVAxRz7wFwxMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Support ROHM BD79124 ADC.

This series adds also couple of IIO ADC helper functions for parsing the
channel information from the device tree. There are also new helpers
included for iterating and counting firmware child nodes with a specific
name.

The rzg2l_adc and the sun20i-gpadc are converted to use the new ADC helper.

There has been some discussion about how useful these ADC helpers are,
and whether they should support also differential and single ended channel
configurations. This version does not include support for those - with the
benefit of reduced complexity and easier to use API.

NOTE: The rzg2l_adc and the sun20i-gpadc are untested as I lack of relevant
HW. They have been compile tested only.

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

v8 =3D> v9:
 - Drop the gianfar and the thp7312 drivers from the series to limit the
   review noise and to simplify the merging. They can be submitted later
   as separate changes.
 - Drop the fwnode_for_each_available_named_child() as suggested by
   Sakari.
 - BD79124 driver styling and fixes

v7 =3D> v8:
  property helpers:
    - Fix the example in fwnode_get_named_child_node_count() documentation
      to use the fwnode_get_named_child_node_count() and not the
      device_get_named_child_node_count()
    - Fix the rest of the new macro's indentiations
  adc helpers:
    - Treat 0 ADC channels as an error in
      devm_iio_adc_device_alloc_chaninfo_se().
  rzg2l_adc / sun20i-gpadc:
    - Drop zero channels check from the ADC drivers using
      devm_iio_adc_device_alloc_chaninfo_se()
  BD79124:
    - Use unsigned for regmap values
    - Commit message fine tuning
    - Check devm_mutex_init() return value
    - Handle 'ALL pins as ADC or GPO' cleanly in BD79124 driver
    - BD79124 styling / typofixes

v6 =3D> v7:
 - Inline device_get_named_child_node_count()
 - Fix kernel-doc for fwnode_get_named_child_node_count()
 - Minor styling fixes
 More accurate changelog in individual patches.

v5 =3D> v6:
 - Drop applied patch
 - Add *_for_each_named_child_* iterators
 - Add a patch converting the thp7312 driver to use the new helper
 - Styling and minor things pointed by reviewers

v4 =3D> v5: Fixes as per various review comments. Most notably:
 - Drop the patch making the TI's ADC driver to respect device tree.
 - Add (RFC) patch converting gianfar driver to use new name child-node
   counting API as suggested by Andy.
 - Add fwnode_get_child_node_count_named() as suggested by Rob.
 - rebase to v6.14-rc5
 More accurate changelog in individual patches.

v3 =3D> v4:
 - Drop the ADC helper support for differential channels
 - Drop the ADC helper for getting only channel IDs by fwnode.
 - "Promote" the function counting the number of child nodes with a
   specific name to the property.h (As suggested by Jonathan).
 - Add ADC helpers to a namespace.
 - Rebase on v6.14-rc3
 - More minor changes described in individual patches.

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

Matti Vaittinen (8):
  dt-bindings: ROHM BD79124 ADC/GPO
  property: Add functions to iterate named child
  iio: adc: add helpers for parsing ADC nodes
  iio: adc: rzg2l_adc: Use adc-helpers
  iio: adc: sun20i-gpadc: Use adc-helpers
  iio: adc: Support ROHM BD79124 ADC
  MAINTAINERS: Add IIO ADC helpers
  MAINTAINERS: Add ROHM BD79124 ADC/GPO

 .../bindings/iio/adc/rohm,bd79124.yaml        |  114 ++
 MAINTAINERS                                   |   12 +
 drivers/base/property.c                       |   27 +
 drivers/iio/adc/Kconfig                       |   17 +
 drivers/iio/adc/Makefile                      |    3 +
 drivers/iio/adc/industrialio-adc.c            |   82 ++
 drivers/iio/adc/rohm-bd79124.c                | 1138 +++++++++++++++++
 drivers/iio/adc/rzg2l_adc.c                   |   39 +-
 drivers/iio/adc/sun20i-gpadc-iio.c            |   39 +-
 include/linux/iio/adc-helpers.h               |   27 +
 include/linux/property.h                      |   20 +
 11 files changed, 1470 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/rohm,bd79124.=
yaml
 create mode 100644 drivers/iio/adc/industrialio-adc.c
 create mode 100644 drivers/iio/adc/rohm-bd79124.c
 create mode 100644 include/linux/iio/adc-helpers.h


base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
--=20
2.48.1


--YoKLVAxRz7wFwxMC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfbz8wACgkQeFA3/03a
ocW2+Af/XifXJoPI6HJO09tF8ui3zqe7MXsN3HOrb+oqgxrNofGdGysmeb3+vqvE
4nyq5fXZZe0gv0KxwCqLba9TdOvwR5drPIZAVwW/UcVY/VAF2OFTxMnO452AqAIH
mtZG8kYI35jOwMZKODEU4hGkSgktm+KLdg0ifwLd9W5XZrQ6Je6mp31XMm8DOuMh
lCHIpWu7LUhOeMkRHs1WQuttYiyZzhHsa65Myrj04x2Pf7eMiS00MAOMFGLqvObi
ogV2CJD3ZqfGRQiBFbKeZltIDKnrTqetJb2F5cdEFKtmlPvyZ+jxaQhi9ilUbPaO
SsqjcdK5qBal2wasXx6P82n/+u1gqw==
=kDea
-----END PGP SIGNATURE-----

--YoKLVAxRz7wFwxMC--

