Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006225E5AD2
	for <lists+linux-iio@lfdr.de>; Thu, 22 Sep 2022 07:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiIVFoC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Sep 2022 01:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiIVFoC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Sep 2022 01:44:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A6F7D7B1
        for <linux-iio@vger.kernel.org>; Wed, 21 Sep 2022 22:44:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1obEzy-0006ft-PU; Thu, 22 Sep 2022 07:43:46 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1obEzr-002C8N-VX; Thu, 22 Sep 2022 07:43:38 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1obEzp-002dyt-Jo; Thu, 22 Sep 2022 07:43:37 +0200
Date:   Thu, 22 Sep 2022 07:43:34 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Wei Yongjun <weiyongjun@huaweicloud.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/5 v3] iio: adc: ti-ads131e08: Silence no spi_device_id
 warnings
Message-ID: <20220922054334.a5t6zdxayx2zwjwd@pengutronix.de>
References: <20220921163620.805879-1-weiyongjun@huaweicloud.com>
 <20220921163620.805879-2-weiyongjun@huaweicloud.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xgv3my2wptn226cd"
Content-Disposition: inline
In-Reply-To: <20220921163620.805879-2-weiyongjun@huaweicloud.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--xgv3my2wptn226cd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 21, 2022 at 04:36:16PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
>=20
> SPI devices use the spi_device_id for module autoloading even on
> systems using device tree, after commit 5fa6863ba692 ("spi: Check
> we have a spi_device_id for each DT compatible"), kernel warns as
> follows since the spi_device_id is missing:
>=20
> SPI driver ads131e08 has no spi_device_id for ti,ads131e04
> SPI driver ads131e08 has no spi_device_id for ti,ads131e06
>=20
> Add spi_device_id entries to silence the warnings, and ensure driver
> module autoloading works.
>=20
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/iio/adc/ti-ads131e08.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e0=
8.c
> index 5235a93f28bc..fcfc46254313 100644
> --- a/drivers/iio/adc/ti-ads131e08.c
> +++ b/drivers/iio/adc/ti-ads131e08.c
> @@ -807,6 +807,8 @@ static int ads131e08_probe(struct spi_device *spi)
>  	int ret;
> =20
>  	info =3D device_get_match_data(&spi->dev);
> +	if (!info)
> +		info =3D (void *)spi_get_device_id(spi)->driver_data;

I wonder if this hunk is orthogonal to the patch? For the purpose
mentioned in the commit log it would be enough to skip this hunk and
don't provide driver_data in ads131e08_ids[] below, wouldn't it?

>  	if (!info) {
>  		dev_err(&spi->dev, "failed to get match data\n");
>  		return -ENODEV;
> @@ -926,12 +928,21 @@ static const struct of_device_id ads131e08_of_match=
[] =3D {
>  };
>  MODULE_DEVICE_TABLE(of, ads131e08_of_match);
> =20
> +static const struct spi_device_id ads131e08_ids[] =3D {
> +	{ "ads131e04", (kernel_ulong_t)&ads131e08_info_tbl[ads131e04] },
> +	{ "ads131e06", (kernel_ulong_t)&ads131e08_info_tbl[ads131e06] },
> +	{ "ads131e08", (kernel_ulong_t)&ads131e08_info_tbl[ads131e08] },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, ads131e08_ids);
> +
>  static struct spi_driver ads131e08_driver =3D {
>  	.driver =3D {
>  		.name =3D "ads131e08",
>  		.of_match_table =3D ads131e08_of_match,
>  	},
>  	.probe =3D ads131e08_probe,
> +	.id_table =3D ads131e08_ids,
>  };
>  module_spi_driver(ads131e08_driver);

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xgv3my2wptn226cd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMr9gQACgkQwfwUeK3K
7AkH+Af/WPGMjQLoIZWwIvXZ5ppnaeWq1HmAbuqXzZVVv32xhmR+NPdOykTs1NTi
p/nNEiC4voVqNwnjWzu4NBfWUxKpt2aK7B2Cq3gnjiatzbShb3nWkzTnYKLfnOvr
dMy1vthZ+HtlFz4RDqW40kfO+BpplwNpL3uqDIVfmvBJ28ddEhpEvapXopXs/51M
aA57l2hrB1BF+AfKnBSbxGHjqeBnfvNjc5vqdfL8HnAFB69DWuZ76QX3cpZsiYYd
CEWHI9SN9kE7stVXAHdcYhJ1hxANJYEIYykcAuOkqa4BEzMT51Xj02XqzIsNL6nr
/JgZwp4KdV3IZ13zJ9VWScWNTjQ3lw==
=sqzy
-----END PGP SIGNATURE-----

--xgv3my2wptn226cd--
