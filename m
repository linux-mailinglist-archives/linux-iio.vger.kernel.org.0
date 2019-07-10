Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26C4F64CE7
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jul 2019 21:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbfGJToN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Jul 2019 15:44:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727846AbfGJToN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 10 Jul 2019 15:44:13 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.63.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A935B2087F;
        Wed, 10 Jul 2019 19:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562787851;
        bh=KQ9dpBUN+zkkfv1JhBanSAaY9RnA/Nj1iA945a/BcG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kReqj31G3gpMk681VjGLc1NjF9uqTpJjvf0QCoIrZoZDaNnJQFvnXCyd55XD6o+V0
         lRRx0x34f5Twyj3QftyZd4pE5y+5PjinXtI+Q6oAr2v5xtHnvkWR2dAR0dLcYJnvW3
         zztPHQohMHqeZ0hcBfXylERq3kaM/KD+OnV/gGfw=
Date:   Wed, 10 Jul 2019 21:44:05 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     linux-iio@vger.kernel.org, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        bbrezillon@knernel.org, Joao.Pinto@synopsys.com
Subject: Re: [PATCH v3 3/3] iio: imu: st_lsm6dsx: add i3c basic support for
 LSM6DSO and LSM6DSR
Message-ID: <20190710194405.GA10520@lore-desk-wlan.lan>
References: <cover.1562767521.git.vitor.soares@synopsys.com>
 <73955529ae0c31f428221abb88031ab3b4165659.1562767521.git.vitor.soares@synopsys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <73955529ae0c31f428221abb88031ab3b4165659.1562767521.git.vitor.soares@synopsys.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> For today the st_lsm6dsx driver support LSM6DSO and LSM6DSR sensor only in
> spi and i2c mode.
>=20
> The LSM6DSO and LSM6DSR are also i3c capable so lets give i3c support to
> them.

Hi Vitor,

just few comments inline.

Regards,
Lorenzo

>=20
> Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes in v3:
>   Remove unnecessary st_lsm6dsx_i3c_data table used to hold device name
>   Use st_lsm6dsx_probe new form
>=20
> Changes in v2:
>   Add support for LSM6DSR
>   Set pm_ops to st_lsm6dsx_pm_ops
>=20
>  drivers/iio/imu/st_lsm6dsx/Kconfig          |  8 +++-
>  drivers/iio/imu/st_lsm6dsx/Makefile         |  1 +
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c | 61 +++++++++++++++++++++++=
++++++
>  3 files changed, 69 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
>=20

[...]

> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c b/drivers/iio/im=
u/st_lsm6dsx/st_lsm6dsx_i3c.c
> new file mode 100644
> index 0000000..f683754
> --- /dev/null
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
> + *
> + * Author: Vitor Soares <vitor.soares@synopsys.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/i3c/device.h>
> +#include <linux/i3c/master.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +
> +#include "st_lsm6dsx.h"
> +
> +static const struct i3c_device_id st_lsm6dsx_i3c_ids[];
> +

why do we need this? I guess you can just move st_lsm6dsx_i3c_ids definitio=
n here

> +static const struct regmap_config st_lsm6dsx_i3c_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +};
> +
> +static int st_lsm6dsx_i3c_probe(struct i3c_device *i3cdev)
> +{
> +	const struct i3c_device_id *id =3D i3c_device_match_id(i3cdev,
> +							    st_lsm6dsx_i3c_ids);

i3c_device_match_id can theoretically fail so is it better to check
return value here? (maybe I am too paranoid :))

> +	struct regmap *regmap;
> +	int hw_id =3D (int)id->data;

I guess we do not need this since we use it just in st_lsm6dsx_probe(),
we can just do:

return st_lsm6dsx_probe(&i3cdev->dev, 0, (int)id->data, regmap);
> +
> +	regmap =3D devm_regmap_init_i3c(i3cdev, &st_lsm6dsx_i3c_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&i3cdev->dev, "Failed to register i3c regmap %d\n",
> +			(int)PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +
> +	return st_lsm6dsx_probe(&i3cdev->dev, 0, hw_id, regmap);
> +}
> +
> +static const struct i3c_device_id st_lsm6dsx_i3c_ids[] =3D {
> +	I3C_DEVICE(0x0104, 0x006C, (void *)ST_LSM6DSO_ID),
> +	I3C_DEVICE(0x0104, 0x006B, (void *)ST_LSM6DSR_ID),
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(i3c, st_lsm6dsx_i3c_ids);
> +
> +static struct i3c_driver st_lsm6dsx_driver =3D {
> +	.driver =3D {
> +		.name =3D "st_lsm6dsx_i3c",
> +		.pm =3D &st_lsm6dsx_pm_ops,
> +	},
> +	.probe =3D st_lsm6dsx_i3c_probe,
> +	.id_table =3D st_lsm6dsx_i3c_ids,
> +};
> +module_i3c_driver(st_lsm6dsx_driver);
> +
> +MODULE_AUTHOR("Vitor Soares <vitor.soares@synopsys.com>");
> +MODULE_DESCRIPTION("STMicroelectronics st_lsm6dsx i3c driver");
> +MODULE_LICENSE("GPL v2");
> --=20
> 2.7.4
>=20

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXSZAAgAKCRA6cBh0uS2t
rEdhAP9qPkBeOryzKC0RGfqKR+Qp8cZ9cqsNUGpjjM+aDt3PkgD/Z4fhMOTocnhw
qCQjPYrnX4PkPS1JmbrgxP6WO3svsgs=
=KFKC
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
