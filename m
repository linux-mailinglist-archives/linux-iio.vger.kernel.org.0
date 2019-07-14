Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7FD6803A
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2019 18:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbfGNQa5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jul 2019 12:30:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728106AbfGNQa5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jul 2019 12:30:57 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BB7C2089C;
        Sun, 14 Jul 2019 16:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563121856;
        bh=3B4TvzJE5x1tLkpsdLUDGRNudIhb22g/3330h2LrM6U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pnAf4ftXKOZDLj0MwK503NBE0xySOj4mlmEX4S8nMUlEc4IJoWT85vnYIBFJDwTQZ
         64YZq3/3zv2IHDirEgmXq+SZnDKSN3wdO//6OBj0tm9gKnfYXnlpiJP5CDaiMzh/HD
         OUVT07tcoup6GIIFGHW5ccE+2AWdVaMkMWbBBUpE=
Date:   Sun, 14 Jul 2019 17:30:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?QsOhcmJhcmE=?= Fernandes <barbara.fernandes@usp.br>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        stefan.popa@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com, Wilson Sales <spoonm@spoonm.org>
Subject: Re: [PATCH v2] staging: iio: ad7192: create of_device_id array
Message-ID: <20190714173050.2b6306a0@archlinux>
In-Reply-To: <20190628194922.13277-1-barbara.fernandes@usp.br>
References: <20190628194922.13277-1-barbara.fernandes@usp.br>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 28 Jun 2019 16:49:22 -0300
B=C3=A1rbara Fernandes <barbara.fernandes@usp.br> wrote:

> Create list of compatible device ids to be matched with those stated in
> the device tree.
>=20
> Signed-off-by: B=C3=A1rbara Fernandes <barbara.fernandes@usp.br>
> Signed-off-by: Wilson Sales <spoonm@spoonm.org>
> Co-developed by: Wilson Sales <spoonm@spoonm.org>
> ---
Patch is fine and applied to the togreg branch of iio.git.

Only thing to note is that reviewers and maintainers often have
poor memories (or are jet lagged which is my excuse today!)
so it helps to put a change log here under the ---

Thanks,

Jonathan

>  drivers/staging/iio/adc/ad7192.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/a=
d7192.c
> index 3d74da9d37e7..70118db98d94 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -810,11 +810,23 @@ static const struct spi_device_id ad7192_id[] =3D {
>  	{"ad7195", ID_AD7195},
>  	{}
>  };
> +
>  MODULE_DEVICE_TABLE(spi, ad7192_id);
> =20
> +static const struct of_device_id ad7192_of_match[] =3D {
> +	{ .compatible =3D "adi,ad7190" },
> +	{ .compatible =3D "adi,ad7192" },
> +	{ .compatible =3D "adi,ad7193" },
> +	{ .compatible =3D "adi,ad7195" },
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(of, ad7192_of_match);
> +
>  static struct spi_driver ad7192_driver =3D {
>  	.driver =3D {
>  		.name	=3D "ad7192",
> +		.of_match_table =3D ad7192_of_match,
>  	},
>  	.probe		=3D ad7192_probe,
>  	.remove		=3D ad7192_remove,

