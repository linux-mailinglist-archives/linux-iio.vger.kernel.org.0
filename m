Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2111C1132
	for <lists+linux-iio@lfdr.de>; Fri,  1 May 2020 12:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbgEAKtd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 May 2020 06:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728352AbgEAKtd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 May 2020 06:49:33 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CAFC08E859;
        Fri,  1 May 2020 03:49:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 5231A2A2C65
Received: by earth.universe (Postfix, from userid 1000)
        id 92FCD3C08C7; Fri,  1 May 2020 12:49:29 +0200 (CEST)
Date:   Fri, 1 May 2020 12:49:29 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v11 0/6]  Add battery charger driver support for MP2629
Message-ID: <20200501104929.zkkmxolusjyxx7aw@earth.universe>
References: <20200430155810.21383-1-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="smmvzv2hcec4kvwn"
Content-Disposition: inline
In-Reply-To: <20200430155810.21383-1-sravanhome@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--smmvzv2hcec4kvwn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I expect, that Lee will provide an immutable branch for me and
Jonathan once the MFD bits have been reviewed. Please tell me,
if I should prepare one instead.

-- Sebastian

On Thu, Apr 30, 2020 at 05:58:04PM +0200, Saravanan Sekar wrote:
> changes in v11:
>  - module_remove part replaced by devm_add_action_or_reset in charger pat=
ch
>  - minor review comments solved in mfd and adc patch
>=20
> changes in v10:
>  - fixed typo, \n in dev_err
>  - dt bindings Warning (unit_address_vs_reg) reported by bot
>=20
> changes in v9:
>  - fixed review comments in mp2629 power supply such as resource based
>    iio channel, replace workqueue by threaded irq, irq get with "_optiona=
l"
>=20
> changes in v8:
>  - fixed order of call in probe/remove in iio adc
>  - add ABI documentation for mp2629 power supply
>=20
> changes in v7:
>  - fixed probe/remove order, managed and unmanaged call mix use in adc.
>  - Documentation dual license, i2c node with controller address
>=20
> Overall looks good to me, FWIW,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>=20
> One question though in reply to patch 4.
>=20
> changes in v6:
>  - removed includes types.h in mfd, of_device.h in adc.
>  - fixed review comments parentheses, err check, kstrtouint
>=20
> changes in v5:
>  - removed platfrom data stored in mfd and directly accessed mfd struct i=
n child
>  - fixed spell check and capitalization in mfd and documentation
>=20
> changes in v4:
>  - fixed capitalization in mfg Kconfig and documentation
>=20
> changes in v3:
>  - regmap for children passed using platform data and remove mfd driver i=
nfo
>    access directly from children
>=20
> changes in v2:
>  - removed EXPORT_SYMBOL of register set/get helper
>  - regmap bit filed used, fixed other review comments
>=20
> This patch series add support for Battery charger control driver for Mono=
lithic
> Power System's MP2629 chipset, includes MFD driver for ADC battery & input
> power supply measurement and battery charger control driver.
>=20
> Thanks,
> Saravanan
>=20
> Saravanan Sekar (6):
>   dt-bindings: mfd: add document bindings for mp2629
>   mfd: mp2629: Add support for mps battery charger
>   iio: adc: mp2629: Add support for mp2629 ADC driver
>   power: supply: Add support for mps mp2629 battery charger
>   power: supply: mp2629: Add impedance compensation config
>   MAINTAINERS: Add entry for mp2629 Battery Charger driver
>=20
>  .../ABI/testing/sysfs-class-power-mp2629      |   8 +
>  .../devicetree/bindings/mfd/mps,mp2629.yaml   |  62 ++
>  MAINTAINERS                                   |   5 +
>  drivers/iio/adc/Kconfig                       |  10 +
>  drivers/iio/adc/Makefile                      |   1 +
>  drivers/iio/adc/mp2629_adc.c                  | 208 ++++++
>  drivers/mfd/Kconfig                           |   9 +
>  drivers/mfd/Makefile                          |   2 +
>  drivers/mfd/mp2629.c                          |  79 +++
>  drivers/power/supply/Kconfig                  |  10 +
>  drivers/power/supply/Makefile                 |   1 +
>  drivers/power/supply/mp2629_charger.c         | 669 ++++++++++++++++++
>  include/linux/mfd/mp2629.h                    |  26 +
>  13 files changed, 1090 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-power-mp2629
>  create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
>  create mode 100644 drivers/iio/adc/mp2629_adc.c
>  create mode 100644 drivers/mfd/mp2629.c
>  create mode 100644 drivers/power/supply/mp2629_charger.c
>  create mode 100644 include/linux/mfd/mp2629.h
>=20
> --=20
> 2.17.1
>=20

--smmvzv2hcec4kvwn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6r/rkACgkQ2O7X88g7
+ppJzQ/+Pl+h8Mja3VuvUz1EULhJGLuGlk766XIvMy2WuaEVC5+x6/uH4zbxEnwA
OqpLQ5HD2eCN5Go28N+MeEo/EIMOSARYyO1QzXT+8KpEqHF8jzbRTUCSuODfOm9Z
X/rVT1nALiF1zDyHceZe0D7pgwo2gjV/kjng76ZG4LGCe0mLUm1v4OMXKnNGcN2a
R6TF3aWhDVHoFFXq9Ze03C7wHSlDFGvFD4jE5NFcww7bvQFcL7L/n/abxHXYcJxa
6Bro7s/AWP/cEgRM6z1qFdhg1vVQ7MJec5DmEg4H96MdltITrWoM7gZFo4bwlXK4
+a4V0iq5IeDBYnbGCJ5kp4yzQ0On9DL+UOjBNiYecWkvlvdrYKNElDplcfpKUX0y
rAEqidD5phapvJb7nCtI0SFJcBx2jqC/9fJmiX27Up37lMFp1YpL1u3RQaToZ425
ZcwD82Dn6diUvRv4LJSVGMVKl0db4vzjCE/bm3AnUw8H+jcXqZYcsus+08p+IsTK
D9cSAc2AfueJaigcUq2hTw2MsFoXD2+kTQqaOn60w5WSlrFAAt/y4zNEGvxI3eN9
JfIi9X5qWB4s8j4rSb2qHftFdoq6bglELPvIt1b1vd+XFv6hVd03Umkzkw7tO//c
yaPx9J3MPD42Jq3BwP8kWopZt3g6/aV749+/RRg3wQBy6896QaY=
=obwC
-----END PGP SIGNATURE-----

--smmvzv2hcec4kvwn--
