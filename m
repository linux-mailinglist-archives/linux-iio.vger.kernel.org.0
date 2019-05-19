Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD053227AE
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2019 19:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfESR1W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 May 2019 13:27:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbfESR1V (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 May 2019 13:27:21 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14829208C3;
        Sun, 19 May 2019 10:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558261294;
        bh=RMAcnNdzYjfx2XpG3oSH8rKO9nCYYU3tLEvOgbs2bfw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ALJneouBfemWqoMOmAVZQyy5VwLTVanD2N7pDQjKN6NgjR1MN8XgrsbhrDjMjcQAB
         dCnkOpMTz6TD/BDEe8+8mX+tl3tAIGfhY9R/Wg5fPQlhCA7HVQzC6jE9YTjYc0X/cR
         9FXKEx6QaOyBgxBKsxhyCiQp6ki3Bt12xIoyUTos=
Date:   Sun, 19 May 2019 11:21:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?QsOhcmJhcmE=?= Fernandes <barbara.fernandes@usp.br>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Melissa Wen <melissa.srw@gmail.com>,
        Wilson Sales <spoonm@spoonm.org>
Subject: Re: [PATCH 1/2] staging: iio: cdc: ad7150: create of_device_id
 array
Message-ID: <20190519112129.5d83e393@archlinux>
In-Reply-To: <20190518224136.16942-2-barbara.fernandes@usp.br>
References: <20190518224136.16942-1-barbara.fernandes@usp.br>
        <20190518224136.16942-2-barbara.fernandes@usp.br>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 18 May 2019 19:41:35 -0300
B=C3=A1rbara Fernandes <barbara.fernandes@usp.br> wrote:

> Create structure of type of_device_id in order to register all devices
> the driver is able to manage.
>=20
> Signed-off-by: B=C3=A1rbara Fernandes <barbara.fernandes@usp.br>
> Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
> Co-developed-by: Melissa Wen <melissa.srw@gmail.com>
> Signed-off-by: Wilson Sales <spoonm@spoonm.org>
> Co-developed-by: Wilson Sales <spoonm@spoonm.org>

Hi,

One really minor point inline, otherwise looks good to me.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/cdc/ad7150.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/a=
d7150.c
> index 4b1c90e1b0ea..072094227e1b 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -655,11 +655,21 @@ static const struct i2c_device_id ad7150_id[] =3D {
>  	{}
>  };
> =20
> +static const struct of_device_id ad7150_of_i2c_match[] =3D {
> +	{ .compatible =3D "adi,ad7150" },
> +	{ .compatible =3D "adi,ad7151" },
> +	{ .compatible =3D "adi,ad7156" },
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(of, ad7150_of_i2c_match);
> +
I would suggest keeping the below MODULE_DEVICE_TABLE
entry next to the definition of ad7150_id rather than putting
this new block in between them.

In short, just move your additions below the next line.

Thanks,

Jonathan

>  MODULE_DEVICE_TABLE(i2c, ad7150_id);
> =20
>  static struct i2c_driver ad7150_driver =3D {
>  	.driver =3D {
>  		.name =3D "ad7150",
> +		.of_match_table =3D ad7150_of_i2c_match
>  	},
>  	.probe =3D ad7150_probe,
>  	.id_table =3D ad7150_id,

