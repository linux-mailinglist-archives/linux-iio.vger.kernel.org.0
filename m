Return-Path: <linux-iio+bounces-15264-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FA7A2EFFC
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 15:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7DA71672E1
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 14:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57612236FC;
	Mon, 10 Feb 2025 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTgSMVwv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D65252916;
	Mon, 10 Feb 2025 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739198190; cv=none; b=fPVU1hy03ZDC3UZCLQPNKT7PaEyYfuM1UHG7ZSEkzxytahzsD4mFJz9/oFPFVuv5k11rwZML9F2HP2gjdEsgta3le1w5sAjjXZ7Wsq5IqGfbMIMsftzVIR6ONaNFLwbL9yPwrSqLgcXRVgoCVgiACavXuwyOVF8y+lu4gnC9ksQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739198190; c=relaxed/simple;
	bh=sT7t3DJuatcuKZvixf6dR95oYoRlkPug+NHm8gEIqLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YM2UgNNlh7maIj/RwKD4pfJanvaGnC4rfGaI8aVmW1kQfItke83tr53tW2NNZynZegUiOJX66BonSZqG8L95HX7N1bSIhWFzAc6QiukgKGeP6XaVqiIKhgvzWJO7dv9UtNxtkDGse06skWB+uUnHj6sMY6JZYTdh4QD6Q+nYw+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTgSMVwv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013F5C4CED1;
	Mon, 10 Feb 2025 14:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739198190;
	bh=sT7t3DJuatcuKZvixf6dR95oYoRlkPug+NHm8gEIqLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kTgSMVwvxmkfippSsmURLqGz1913LkCdHzGbdqMBC5oMIJux1JJ0AoRTmva+a0gt1
	 ohPzO/DTv9OxygYfdgSb9eUm4tJboqu6rIHo8wM8e681wSySH1t/N9WRHazG6OFDTh
	 7DI76PJGOk5AZCasKymYVoJ0fyAnVCXYVeKLcQfBCK2JpRq4nOW+lkD5FO+baC3cSt
	 0mcbMnZB152sjHJCb1D/gWHfRY2lRpt/9cHieD11ZPUDnAjhtH875/Az3Tg34UDwGS
	 jP1ysIqAeHS45vskDFI+eBlpczvN9KA8sN69erkieH+DKydWvrP/qmQZX18uqeAv24
	 OyUAIP/rk/AQA==
Date: Mon, 10 Feb 2025 14:36:24 +0000
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [PATCH v8 00/17] spi: axi-spi-engine: add offload support
Message-ID: <544c0100-54a9-40e6-b9b7-b79555056237@sirena.org.uk>
References: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QYNrgk6GkUqCktJq"
Content-Disposition: inline
In-Reply-To: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
X-Cookie: A beer delayed is a beer denied.


--QYNrgk6GkUqCktJq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2025 at 02:08:57PM -0600, David Lechner wrote:
> Only very minor fixes in this revision.
>=20
> Also, now that trees are rebased on v6.14-rc1 we no longer have
> dependencies for the IIO patches. So Mark can pick up all of the
> patches if we want to go that way. In any case though, Jonathan will
> need an immutable branch since we have other IIO patches in-flight
> building on top of this series.

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-=
offload

for you to fetch changes up to 700a281905f2a4ccf6f3b2d3cd6985e034b4b021:

  spi: add offload TX/RX streaming APIs (2025-02-07 20:17:11 +0000)

----------------------------------------------------------------
spi: Add offload APIs

This series adds support for offloading complete SPI transactions,
including the initiation, to the hardware.

----------------------------------------------------------------
David Lechner (5):
      spi: add basic support for SPI offloading
      spi: offload: add support for hardware triggers
      dt-bindings: trigger-source: add generic PWM trigger source
      spi: offload-trigger: add PWM trigger driver
      spi: add offload TX/RX streaming APIs

 .../bindings/trigger-source/pwm-trigger.yaml       |  37 ++
 MAINTAINERS                                        |  12 +
 drivers/spi/Kconfig                                |  15 +
 drivers/spi/Makefile                               |   4 +
 drivers/spi/spi-offload-trigger-pwm.c              | 162 +++++++
 drivers/spi/spi-offload.c                          | 465 +++++++++++++++++=
++++
 drivers/spi/spi.c                                  |  10 +
 include/linux/spi/offload/consumer.h               |  39 ++
 include/linux/spi/offload/provider.h               |  47 +++
 include/linux/spi/offload/types.h                  |  99 +++++
 include/linux/spi/spi.h                            |  20 +
 11 files changed, 910 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/trigger-source/pwm-tr=
igger.yaml
 create mode 100644 drivers/spi/spi-offload-trigger-pwm.c
 create mode 100644 drivers/spi/spi-offload.c
 create mode 100644 include/linux/spi/offload/consumer.h
 create mode 100644 include/linux/spi/offload/provider.h
 create mode 100644 include/linux/spi/offload/types.h

--QYNrgk6GkUqCktJq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeqDucACgkQJNaLcl1U
h9BpnQf8D5JC+0bbrb5LIrxK3eCQeHgPhCf+oMbdnS8UY9RTlTw8icE9O7OO2Ba6
ukc9nzH+1n2gx057AL/7Jvv8lJufzeQ0DCPN9ii+WfcQct9cIAZlEFg2Xoxrd4jY
UASIr6zBuznSuMZYoOKzxUQl9j6k1OMFZM5OHQtm6dj6MGDAnHKJNe0WDYUWpoYf
XwDZRDQ6HuAUy0fAJm/Hffnp2lfYP+CmHL32H1QtwrxYC2HxyfyY3hyjZ3egxS5k
weP888xMslLJzX0tuiUcODAbjU6mxaw1t+qLRQZgSC+8V6A6o8ZnnZ5IvGAhsVr6
6vcgcEqL8Z0R9ZD6gGssxs1ficBvHA==
=QTWQ
-----END PGP SIGNATURE-----

--QYNrgk6GkUqCktJq--

