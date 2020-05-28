Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CA11E5837
	for <lists+linux-iio@lfdr.de>; Thu, 28 May 2020 09:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgE1HJn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 May 2020 03:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE1HJn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 May 2020 03:09:43 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51961C05BD1E;
        Thu, 28 May 2020 00:09:43 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id EBC5D2A3C90
Received: by earth.universe (Postfix, from userid 1000)
        id 356733C08C7; Thu, 28 May 2020 09:09:39 +0200 (CEST)
Date:   Thu, 28 May 2020 09:09:39 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Saravanan Sekar <sravanhome@gmail.com>, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [GIT PULL] Immutable branch between MFD, IIO and Power due for
 the v5.8 merge window
Message-ID: <20200528070939.7btxjwuqn7bhf4xe@earth.universe>
References: <20200526090646.25827-1-sravanhome@gmail.com>
 <20200526094702.GN3628@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u56qdvhxw5elq2g6"
Content-Disposition: inline
In-Reply-To: <20200526094702.GN3628@dell>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--u56qdvhxw5elq2g6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for taking care of it Lee, merged!

-- Sebastian

On Tue, May 26, 2020 at 10:47:02AM +0100, Lee Jones wrote:
> Enjoy!
>=20
> The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f31=
36:
>=20
>   Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-i=
io-power-v5.8
>=20
> for you to fetch changes up to 904ac71f4b0c1c26ec47ff597cb3d3c7d36e618d:
>=20
>   MAINTAINERS: Add entry for mp2629 Battery Charger driver (2020-05-26 10=
:42:02 +0100)
>=20
> ----------------------------------------------------------------
> Immutable branch between MFD, IIO and Power due for the v5.8 merge window
>=20
> ----------------------------------------------------------------
> Saravanan Sekar (6):
>       dt-bindings: mfd: Add document bindings for mp2629
>       mfd: mp2629: Add support for mps battery charger
>       iio: adc: mp2629: Add support for mp2629 ADC driver
>       power: supply: Add support for mps mp2629 battery charger
>       power: supply: mp2629: Add impedance compensation config
>       MAINTAINERS: Add entry for mp2629 Battery Charger driver
>=20
>  Documentation/ABI/testing/sysfs-class-power-mp2629 |   8 +
>  .../devicetree/bindings/mfd/mps,mp2629.yaml        |  62 ++
>  MAINTAINERS                                        |   5 +
>  drivers/iio/adc/Kconfig                            |  10 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/mp2629_adc.c                       | 208 +++++++
>  drivers/mfd/Kconfig                                |   9 +
>  drivers/mfd/Makefile                               |   2 +
>  drivers/mfd/mp2629.c                               |  79 +++
>  drivers/power/supply/Kconfig                       |  10 +
>  drivers/power/supply/Makefile                      |   1 +
>  drivers/power/supply/mp2629_charger.c              | 669 +++++++++++++++=
++++++
>  include/linux/mfd/mp2629.h                         |  26 +
>  13 files changed, 1090 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-power-mp2629
>  create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
>  create mode 100644 drivers/iio/adc/mp2629_adc.c
>  create mode 100644 drivers/mfd/mp2629.c
>  create mode 100644 drivers/power/supply/mp2629_charger.c
>  create mode 100644 include/linux/mfd/mp2629.h
>=20
> --=20
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog

--u56qdvhxw5elq2g6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl7PY7IACgkQ2O7X88g7
+poM1Q/7BstB7OTUZNZlaC3toSNbFJvmHo/CweUuu6n3S6ma19S+EhqKyHMmnM7V
d639+SscU+s9STHZVe25IRiQtq2SuXLvYtr0L5KyU7ImnLjck7zcLLV55omb9MdH
OtXW1WaqFar+tnI73HJNgpvEc6uD/yJWsW2z4TZaMQCrvPeCiBQ5VYqfzRIjG9Ws
F2WhzFpxwqq4C0FOPEuXRCbCQHYgyXr6de6meuEZg0SzMkKwN+ZMHDjJtTZu1xhT
DqrbDq+3SnGUKbPXmLS043SCHvc4bSh1GY3i02lClmUa1bZXxevSPe+UVOL4rvst
EmRxmgatGLI5BJIUg7IpIQUnX2bti6xfZRlG86HI+4OYVVDu/7XYRX0Eb6HR9TGQ
hux2kdG70ziIkVFXpWobUOsyI7/OJ6CRjD+McejZuKRkzBTM6A9tmiZhdh0i3+cY
VAQWLhf8sDcd9FRxSGX8pIB2/M0nSggh0BbbaZK6CjFHOooNrM6MfDE5K7wSa+lk
xu/8X5NLFVRsQM8pfBd8Q3vQSioXBlrqaYNgX+5B5sGsPQWLzayu738StP+6SK2j
ea4AU6ydsnkSbB/bs8MhxGAXIbY8vZWA/lo5xvg9v8QpTMiFGMRJiIvxneMhy7/w
Z0SAo1anPC5lVefMxQc+rOjiD7Sc7dMvGfLv5ZCt6sQRTz78oic=
=Y15j
-----END PGP SIGNATURE-----

--u56qdvhxw5elq2g6--
