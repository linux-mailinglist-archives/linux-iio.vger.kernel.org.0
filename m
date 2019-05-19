Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1CB02276C
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2019 19:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfESRCW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 May 2019 13:02:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfESRCW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 May 2019 13:02:22 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28C9E2177B;
        Sun, 19 May 2019 11:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558263775;
        bh=mBpAhk//8WvsbTtXPi/GRsgbj/yowPAq5t4mJK5gccY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pYZptuxyzCXeqdm4KC3jNE70+82Jk/nhhiTgXH5L3lozFHn2Bt2SRB5qrN7GITWoX
         53y8XAbO4rR2LQGiNSswervuiIzCkuzDTVpR6En2/W6ZddHlODiPc3/sGaLzFj04i5
         JvRvo6cyOt1Us/mBYWwqQN4zNOJNQHySnd00HXvw=
Date:   Sun, 19 May 2019 12:02:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?Sm/Do28=?= Seckler <joaoseckler@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: ad7746: add device tree support
Message-ID: <20190519120250.4644c255@archlinux>
In-Reply-To: <20190518222733.2ttcgvy7fct4awra@smtp.gmail.com>
References: <20190518222733.2ttcgvy7fct4awra@smtp.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 18 May 2019 19:27:33 -0300
Jo=C3=A3o Seckler <joaoseckler@gmail.com> wrote:

> Add a of_device_id struct variable and subsequent call to
> MODULE_DEVICE_TABLE macro to support device tree.
>=20
> Signed-off-by: Jo=C3=A3o Seckler <joaoseckler@gmail.com>
> Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
> Co-developed-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

For a future improvement, try to explain the 'why' rather than
'what' of a patch in the description.   This particular change
is so common I don't mind that much, but it is a good habit to
get into!

Thanks,

Jonathan
> ---
>  drivers/staging/iio/cdc/ad7746.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/a=
d7746.c
> index 47610d863908..21527d84f940 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -748,9 +748,19 @@ static const struct i2c_device_id ad7746_id[] =3D {
> =20
>  MODULE_DEVICE_TABLE(i2c, ad7746_id);
> =20
> +static const struct of_device_id ad7746_of_match[] =3D {
> +	{ .compatible =3D "adi,ad7745" },
> +	{ .compatible =3D "adi,ad7746" },
> +	{ .compatible =3D "adi,ad7747" },
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, ad7746_of_match);
> +
>  static struct i2c_driver ad7746_driver =3D {
>  	.driver =3D {
>  		.name =3D KBUILD_MODNAME,
> +		.of_match_table =3D ad7746_of_match,
>  	},
>  	.probe =3D ad7746_probe,
>  	.id_table =3D ad7746_id,

