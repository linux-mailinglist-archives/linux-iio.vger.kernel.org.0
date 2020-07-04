Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27EA2147B2
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jul 2020 19:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgGDRV4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jul 2020 13:21:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbgGDRV4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Jul 2020 13:21:56 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1228620739;
        Sat,  4 Jul 2020 17:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593883315;
        bh=KN5Ud8zwCmABorjFBUXyfyJV0YKjP1OGp6TebiazR9U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZffCS8EpPt9aa2u6YyOd6cmBddivf11YfZ8ZBuCthdFL7mx0puv/GpXGuGJSujmgM
         exrAf0fVuIEvaBJq/+j1KRBukKGG28B9wuKNIx9cIRNP7/yql9gcZzUTSnCq/yhE5S
         0oqiXvfZkqAOTN9mFIS2rF3RRvPl3u2DhYPloRnM=
Date:   Sat, 4 Jul 2020 18:21:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Oskar Andero <oskar.andero@gmail.com>,
        =?UTF-8?B?U8O4cmVu?= Andersen <san@rosetechnology.dk>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 12/23] iio:adc:mcp320x: Drop CONFIG_OF and of_match_ptr
 protections
Message-ID: <20200704182151.7b4bd7ea@archlinux>
In-Reply-To: <20200628123654.32830-13-jic23@kernel.org>
References: <20200628123654.32830-1-jic23@kernel.org>
        <20200628123654.32830-13-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 28 Jun 2020 13:36:43 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> These just prevent the driver being used with ACPI PRP0001.
> They also get cut and paste into new drivers and we want to discourage
> this from happening by cleaning it out in general.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Oskar Andero <oskar.andero@gmail.com>
> Cc: S=C3=B8ren Andersen <san@rosetechnology.dk>
> Cc: Lukas Wunner <lukas@wunner.de>
Applied

> ---
>  drivers/iio/adc/mcp320x.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
> index e533f1064cf8..bb37e66ff7dc 100644
> --- a/drivers/iio/adc/mcp320x.c
> +++ b/drivers/iio/adc/mcp320x.c
> @@ -41,6 +41,7 @@
>  #include <linux/delay.h>
>  #include <linux/spi/spi.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/iio/iio.h>
>  #include <linux/regulator/consumer.h>
> =20
> @@ -469,7 +470,6 @@ static int mcp320x_remove(struct spi_device *spi)
>  	return 0;
>  }
> =20
> -#if defined(CONFIG_OF)
>  static const struct of_device_id mcp320x_dt_ids[] =3D {
>  	/* NOTE: The use of compatibles with no vendor prefix is deprecated. */
>  	{ .compatible =3D "mcp3001" },
> @@ -497,7 +497,6 @@ static const struct of_device_id mcp320x_dt_ids[] =3D=
 {
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, mcp320x_dt_ids);
> -#endif
> =20
>  static const struct spi_device_id mcp320x_id[] =3D {
>  	{ "mcp3001", mcp3001 },
> @@ -520,7 +519,7 @@ MODULE_DEVICE_TABLE(spi, mcp320x_id);
>  static struct spi_driver mcp320x_driver =3D {
>  	.driver =3D {
>  		.name =3D "mcp320x",
> -		.of_match_table =3D of_match_ptr(mcp320x_dt_ids),
> +		.of_match_table =3D mcp320x_dt_ids,
>  	},
>  	.probe =3D mcp320x_probe,
>  	.remove =3D mcp320x_remove,

