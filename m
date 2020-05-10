Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B2E1CCA29
	for <lists+linux-iio@lfdr.de>; Sun, 10 May 2020 12:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgEJKSV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 May 2020 06:18:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgEJKSV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 May 2020 06:18:21 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B354206A3;
        Sun, 10 May 2020 10:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589105900;
        bh=hWjMKAwdWJ/o3HUisSHzH/Arf2sL2ZTVDPjCrm5zbH4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OGLl2JKDfvH2Ur+1aNbw18uED6v58CRY5LqE65pjP90KaaC//OKKJyYjVK5Z3kH/l
         9KfWvCxjfjMuOO5cfA/GOxJVAOBt0psGHlIafhBjFqgWldl32u2Jd7jilwaBAEWkst
         9ru1gVeloHx6i0AwiKvHN+MdnvJ/wwWD9PrR10k0=
Date:   Sun, 10 May 2020 11:18:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] staging: iio: ad5933: attach life-cycle of kfifo
 buffer to parent device
Message-ID: <20200510111817.07e6bf72@archlinux>
In-Reply-To: <20200508143936.17845-1-alexandru.ardelean@analog.com>
References: <20200508143936.17845-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 8 May 2020 17:39:35 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change makes the use of devm_iio_kfifo_allocate() to attach the
> life-cycle of the kfifo buffer to the parent (client->dev) object.
>=20
> This removes the need to explicitly free 'indio_dev->buffer' via
> iio_kfifo_free(), which is the main intent.
>=20
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
*mutters darkly*.  Technically this patch adds a non obvious ordering
issue in remove, but then you fix it in the next one so I'll let that go.

However, you've not tried building patch 1 on it's own..

drivers/staging/iio/impedance-analyzer/ad5933.c:752:17: error: label 'error=
_unreg_ring' was not declared
drivers/staging/iio/impedance-analyzer/ad5933.c:756:17: error: label 'error=
_unreg_ring' was not declared
  CC [M]  drivers/staging/iio/impedance-analyzer/ad5933.o
drivers/staging/iio/impedance-analyzer/ad5933.c: In function =E2=80=98ad593=
3_probe=E2=80=99:
drivers/staging/iio/impedance-analyzer/ad5933.c:756:3: error: label =E2=80=
=98error_unreg_ring=E2=80=99 used but not defined
  756 |   goto error_unreg_ring;
      |   ^~~~
make[4]: *** [scripts/Makefile.build:267: drivers/staging/iio/impedance-ana=
lyzer/ad5933.o] Error 1
make[3]: *** [scripts/Makefile.build:488: drivers/staging/iio/impedance-ana=
lyzer] Error 2
make[2]: *** [scripts/Makefile.build:488: drivers/staging/iio] Error 2
make[1]: *** [scripts/Makefile.build:488: drivers/staging] Error 2
make: *** [Makefile:1722: drivers] Error 2

Easiest option here is just to merge the two patches into one. I've
done that and mashed the two commit messages into one semi-coherent whole.

Applied both patches as one to the togreg branch of iio.git and pushed out
as testing for the autobuilders to play with it.

thanks,

Jonathan

> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/st=
aging/iio/impedance-analyzer/ad5933.c
> index af0bcf95ee8a..633adf1a08c1 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -602,11 +602,12 @@ static const struct iio_buffer_setup_ops ad5933_rin=
g_setup_ops =3D {
>  	.postdisable =3D ad5933_ring_postdisable,
>  };
> =20
> -static int ad5933_register_ring_funcs_and_init(struct iio_dev *indio_dev)
> +static int ad5933_register_ring_funcs_and_init(struct device *dev,
> +					       struct iio_dev *indio_dev)
>  {
>  	struct iio_buffer *buffer;
> =20
> -	buffer =3D iio_kfifo_allocate();
> +	buffer =3D devm_iio_kfifo_allocate(dev);
>  	if (!buffer)
>  		return -ENOMEM;
> =20
> @@ -742,7 +743,7 @@ static int ad5933_probe(struct i2c_client *client,
>  	indio_dev->channels =3D ad5933_channels;
>  	indio_dev->num_channels =3D ARRAY_SIZE(ad5933_channels);
> =20
> -	ret =3D ad5933_register_ring_funcs_and_init(indio_dev);
> +	ret =3D ad5933_register_ring_funcs_and_init(&client->dev, indio_dev);
>  	if (ret)
>  		goto error_disable_mclk;
> =20
> @@ -756,8 +757,6 @@ static int ad5933_probe(struct i2c_client *client,
> =20
>  	return 0;
> =20
> -error_unreg_ring:
> -	iio_kfifo_free(indio_dev->buffer);
>  error_disable_mclk:
>  	clk_disable_unprepare(st->mclk);
>  error_disable_reg:
> @@ -772,7 +771,6 @@ static int ad5933_remove(struct i2c_client *client)
>  	struct ad5933_state *st =3D iio_priv(indio_dev);
> =20
>  	iio_device_unregister(indio_dev);
> -	iio_kfifo_free(indio_dev->buffer);
>  	regulator_disable(st->reg);
>  	clk_disable_unprepare(st->mclk);
> =20

