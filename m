Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865C853D7F3
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jun 2022 18:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238892AbiFDQsF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jun 2022 12:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238847AbiFDQsE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jun 2022 12:48:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B5FDEAB
        for <linux-iio@vger.kernel.org>; Sat,  4 Jun 2022 09:48:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF31760EED
        for <linux-iio@vger.kernel.org>; Sat,  4 Jun 2022 16:48:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D5DC385B8;
        Sat,  4 Jun 2022 16:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654361282;
        bh=3ivT9PXy6icmgU9Iu0djqXUoi+X3SKa6WsfkhLP+nuc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eMks49+axnOzkrxKW+emSNSQ2Oq9HaOqwRnxXHyOK4fDbWCi5UdH4Sa5Qeqt+ok39
         Mk6fNPPddgvnzM/No8Qzkyv1BS6wYa9yDzYojNYbsg/cfwPPgkPcJjfyK7QZl3HRUA
         EkardrfTNmbRwv6zVCYxNy0UPneJZsAP2p1W5DYdy/eMJdLBD45m228wKLGVDI3vxv
         YaEwbnl6Thqy0B0ATscUmmO+cfmpxwQM5msd+wy4C8AEvz3cy5ZURgMl5/ER5fISDJ
         aR/k9tp/u+Wt943VQABNqtV1mYb5+xManIwGOy3CPElr3DPgQnx0r9VTaUFKROMAxl
         /gz84+pTmoThg==
Date:   Sat, 4 Jun 2022 17:56:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Alexandru Lazar <alazar@startmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        David Lechner <david@lechnology.com>,
        Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        =?UTF-8?B?TcOlcnRlbg==?= Lindahl <martenli@axis.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Michael Welling <mwelling@ieee.org>,
        Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Navin Sankar Velliangiri <navin@linumiz.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Phil Reid <preid@electromag.com.au>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Robert Jones <rjones@gateworks.com>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 01/92] iio: core: Fix IIO_ALIGN and rename as it was
 not sufficiently large
Message-ID: <20220604175657.1f309718@jic23-huawei>
In-Reply-To: <20220508175712.647246-2-jic23@kernel.org>
References: <20220508175712.647246-1-jic23@kernel.org>
        <20220508175712.647246-2-jic23@kernel.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  8 May 2022 18:55:41 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

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
> Rename the define to make it's purpose more explicit. It will be used
> much more widely going forwards (to replace incorrect ____cacheline_align=
ed
> markings.
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
> Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com>

This crossed with a patch adding another use of IIO_ALIGN in bma400. I've f=
ixed that
rename up whilst applying.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/adi-axi-adc.c   |  7 ++++---
>  drivers/iio/industrialio-core.c |  4 ++--
>  include/linux/iio/iio.h         | 10 ++++++++--
>  3 files changed, 14 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index a73e3c2d212f..099be9d47223 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -84,7 +84,8 @@ void *adi_axi_adc_conv_priv(struct adi_axi_adc_conv *co=
nv)
>  {
>  	struct adi_axi_adc_client *cl =3D conv_to_client(conv);
> =20
> -	return (char *)cl + ALIGN(sizeof(struct adi_axi_adc_client), IIO_ALIGN);
> +	return (char *)cl + ALIGN(sizeof(struct adi_axi_adc_client),
> +				  IIO_DMA_MINALIGN);
>  }
>  EXPORT_SYMBOL_GPL(adi_axi_adc_conv_priv);
> =20
> @@ -169,9 +170,9 @@ static struct adi_axi_adc_conv *adi_axi_adc_conv_regi=
ster(struct device *dev,
>  	struct adi_axi_adc_client *cl;
>  	size_t alloc_size;
> =20
> -	alloc_size =3D ALIGN(sizeof(struct adi_axi_adc_client), IIO_ALIGN);
> +	alloc_size =3D ALIGN(sizeof(struct adi_axi_adc_client), IIO_DMA_MINALIG=
N);
>  	if (sizeof_priv)
> -		alloc_size +=3D ALIGN(sizeof_priv, IIO_ALIGN);
> +		alloc_size +=3D ALIGN(sizeof_priv, IIO_DMA_MINALIGN);
> =20
>  	cl =3D kzalloc(alloc_size, GFP_KERNEL);
>  	if (!cl)
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-c=
ore.c
> index e1ed44dec2ab..b4218f3b1ac2 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1640,7 +1640,7 @@ struct iio_dev *iio_device_alloc(struct device *par=
ent, int sizeof_priv)
> =20
>  	alloc_size =3D sizeof(struct iio_dev_opaque);
>  	if (sizeof_priv) {
> -		alloc_size =3D ALIGN(alloc_size, IIO_ALIGN);
> +		alloc_size =3D ALIGN(alloc_size, IIO_DMA_MINALIGN);
>  		alloc_size +=3D sizeof_priv;
>  	}
> =20
> @@ -1650,7 +1650,7 @@ struct iio_dev *iio_device_alloc(struct device *par=
ent, int sizeof_priv)
> =20
>  	indio_dev =3D &iio_dev_opaque->indio_dev;
>  	indio_dev->priv =3D (char *)iio_dev_opaque +
> -		ALIGN(sizeof(struct iio_dev_opaque), IIO_ALIGN);
> +		ALIGN(sizeof(struct iio_dev_opaque), IIO_DMA_MINALIGN);
> =20
>  	indio_dev->dev.parent =3D parent;
>  	indio_dev->dev.type =3D &iio_device_type;
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index faf00f2c0be6..c4ce02293f1f 100644
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
> + * to in turn include IIO_DMA_MINALIGN'd elements such as buffers which
> + * must not share  cachelines with the rest of the structure, thus making
> + * them safe for use with non-coherent DMA.
> + */
> +#define IIO_DMA_MINALIGN ARCH_KMALLOC_MINALIGN
>  struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv);
> =20
>  /* The information at the returned address is guaranteed to be cacheline=
 aligned */

