Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B03DE22811
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2019 19:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbfESRwV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 May 2019 13:52:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfESRwV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 May 2019 13:52:21 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1671A21734;
        Sun, 19 May 2019 10:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558262647;
        bh=hpwbVfmn2fxc4zYpjdxBfzApp8qMJssloRB3VH4zxj4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HcZRRlrOQijMKrZyA1qTt28Ejb7F7BqzkAs/QKXjwVJ06XeEIL5f4LgRLMLBLZ+Sx
         pvSECfzmtq3JP1nSelueUiOlQzYJmpKMciv6P49U4jx252MSKR9uZN1W0o+z1hT981
         WwOZ6rLU/SLcZKkq5HCn69jbmuUVTfRaA0FpH5ew=
Date:   Sun, 19 May 2019 11:44:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?QsOhcmJhcmE=?= Fernandes <barbara.fernandes@usp.br>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Wilson Sales <spoonm@spoonm.org>
Subject: Re: [RESEND PATCH] staging: iio: adt7316: create of_device_id array
Message-ID: <20190519114400.5cc29c77@archlinux>
In-Reply-To: <20190518224333.18067-1-barbara.fernandes@usp.br>
References: <20190518224333.18067-1-barbara.fernandes@usp.br>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 18 May 2019 19:43:33 -0300
B=C3=A1rbara Fernandes <barbara.fernandes@usp.br> wrote:

> Create structure of type of_device_id in order to register all devices
> the driver is able to manage.
>=20
> Signed-off-by: B=C3=A1rbara Fernandes <barbara.fernandes@usp.br>
> Signed-off-by: Wilson Sales <spoonm@spoonm.org>
> Co-developed-by: Wilson Sales <spoonm@spoonm.org>
Looks good to me.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/addac/adt7316-spi.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/ii=
o/addac/adt7316-spi.c
> index 8294b9c1e3c2..9968775f1d23 100644
> --- a/drivers/staging/iio/addac/adt7316-spi.c
> +++ b/drivers/staging/iio/addac/adt7316-spi.c
> @@ -127,9 +127,22 @@ static const struct spi_device_id adt7316_spi_id[] =
=3D {
> =20
>  MODULE_DEVICE_TABLE(spi, adt7316_spi_id);
> =20
> +static const struct of_device_id adt7316_of_spi_match[] =3D {
> +	{ .compatible =3D "adi,adt7316" },
> +	{ .compatible =3D "adi,adt7317" },
> +	{ .compatible =3D "adi,adt7318" },
> +	{ .compatible =3D "adi,adt7516" },
> +	{ .compatible =3D "adi,adt7517" },
> +	{ .compatible =3D "adi,adt7519" },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, adt7316_of_spi_match);
> +
>  static struct spi_driver adt7316_driver =3D {
>  	.driver =3D {
>  		.name =3D "adt7316",
> +		.of_match_table =3D adt7316_of_spi_match,
>  		.pm =3D ADT7316_PM_OPS,
>  	},
>  	.probe =3D adt7316_spi_probe,

