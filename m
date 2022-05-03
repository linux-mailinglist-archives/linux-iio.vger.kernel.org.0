Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47715186A6
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 16:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbiECObP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 10:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237036AbiECObO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 10:31:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A7C31906
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 07:27:40 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nltV5-0004OO-1c; Tue, 03 May 2022 16:27:39 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nltUt-000874-Fx; Tue, 03 May 2022 16:27:26 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nltUr-007K7y-8v; Tue, 03 May 2022 16:27:25 +0200
Date:   Tue, 3 May 2022 16:27:25 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>,
        Alexandru Lazar <alazar@startmail.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Cristian Pop <cristian.pop@analog.com>,
        David Lechner <david@lechnology.com>,
        Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        =?utf-8?Q?M=C3=A5rten?= Lindahl <martenli@axis.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Michael Welling <mwelling@ieee.org>,
        Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Navin Sankar Velliangiri <navin@linumiz.com>,
        Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Phil Reid <preid@electromag.com.au>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Robert Jones <rjones@gateworks.com>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 01/92] iio: core: Fix IIO_ALIGN as it was not
 sufficiently large on some platforms.
Message-ID: <20220503142725.h6pcf2socuxgteix@pengutronix.de>
References: <20220503085935.1533814-1-jic23@kernel.org>
 <20220503085935.1533814-2-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2yuard5pl57sjjxr"
Content-Disposition: inline
In-Reply-To: <20220503085935.1533814-2-jic23@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--2yuard5pl57sjjxr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 03, 2022 at 09:58:04AM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Discussion of the series:
> https://lore.kernel.org/all/20220405135758.774016-1-catalin.marinas@arm.c=
om/
> mm, arm64: Reduce ARCH_KMALLOC_MINALIGN brought to my attention that
> our current IIO usage of L1CACHE_ALIGN is insufficient as their are Arm
> platforms out their with non coherent DMA and larger cache lines at
> at higher levels of their cache hierarchy.
>=20
> Note this patch will greatly reduce the padding on some architectures
> that have smaller requirements for DMA safe buffers.
>=20
> The history of changing values of ARCH_KMALLOC_MINALIGN via
> ARCH_DMA_MINALIGN on arm64 is rather complex. I'm not tagging this
> as fixing a particular patch from that route as it's not clear what to ta=
g.
>=20
> Most recently a change to bring them back inline was reverted because
> of some Qualcomm Kryo cores with an L2 cache with 128-byte lines
> sitting above the point of coherency.
>=20
> c1132702c71f Revert "arm64: cache: Lower ARCH_DMA_MINALIGN to 64 (L1_CACH=
E_BYTES)"
> That reverts:
> 65688d2a05de arm64: cache: Lower ARCH_DMA_MINALIGN to 64 (L1_CACHE_BYTES)=
 which
> refers to the change originally being motivated by Thunder x1 performance
> rather than correctness.
>=20
> Fixes: 6f7c8ee585e9d ("staging:iio: Add ability to allocate private data =
space to iio_allocate_device")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  include/linux/iio/iio.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index faf00f2c0be6..30937f8f9424 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -9,6 +9,7 @@
> =20
>  #include <linux/device.h>
>  #include <linux/cdev.h>
> +#include <linux/slab.h>
>  #include <linux/iio/types.h>
>  #include <linux/of.h>
>  /* IIO TODO LIST */
> @@ -657,8 +658,13 @@ static inline void *iio_device_get_drvdata(const str=
uct iio_dev *indio_dev)
>  	return dev_get_drvdata(&indio_dev->dev);
>  }
> =20
> -/* Can we make this smaller? */
> -#define IIO_ALIGN L1_CACHE_BYTES
> +/*
> + * Used to ensure the iio_priv() structure is aligned to allow that stru=
cture
> + * to in turn include IIO_ALIGN'd elements such as buffers which must no=
t share
> + * cachelines with the rest of the structure, thus making them safe for =
use with
> + * non-coherent DMA.
> + */
> +#define IIO_ALIGN ARCH_KMALLOC_MINALIGN

Given the purpose of IIO_ALIGN is to define the alignment for DMA'able
memory, I wonder why it's called "IIO_ALIGN" and not for example
"DMA_MINALIGN".

There is nothing iio specific about this value, is there? Then
consequently it doesn't need to be defined in an iio header, but
somewhere generic. Or even one step further: Why isn't there a macro
__align_for_dma that can be used directly to annotate the relevant
member in a struct?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2yuard5pl57sjjxr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJxO8oACgkQwfwUeK3K
7Anbugf/cMOyWz2WCpx5diLQTbOq9AJo7HqgNxU3lZvflhkhD2yfEWyp9C6POX8d
JSkB58wDV4dGFXyl5lS7vMbRQtSFnAUavix884L+icuwPidQtDMpKmHuNtJpy4Ya
wUho79CKEc3CEgTb2hcuDXgI2JVTaX7aLIJdvVCuBG+k1F67dFHWFrvoI5umWnOE
sTpSgJ1GJ2fGGkVbXQmKKXyp4NSI8f/3WGcMTbgVP5LSHf0SY9sw0/qNOp73KUF+
AMM4Xq2eivHLWISJDwzeztXUNnLKJ/VLHIAXHb9lotHtDn+JrFTLUuJGe8KnVLxb
XvyCTZR4YL5nHMow734+QAlKr+N0tQ==
=gmJw
-----END PGP SIGNATURE-----

--2yuard5pl57sjjxr--
