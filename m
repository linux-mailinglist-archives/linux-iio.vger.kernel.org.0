Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE7EA22791
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2019 19:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfESRRW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 May 2019 13:17:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbfESRRV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 May 2019 13:17:21 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE7D8217D9;
        Sun, 19 May 2019 11:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558264780;
        bh=IU3z1lGeIXgWy+wPKVyg2cUICOUubab/isnFfeXG9XU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xkV07FOOaPmLt2IaWxZVVagvoCZ0zikunT4WzmMbDo9xzy15VXmHCEXzvGGdumDlz
         vOMofUuC1QLHUW6W7N16CmDsGOH1H3tDlcbEGmJwD36d5D8gJevDWm/yvZ6/hfGkvB
         9XoYoIAChIwFyKeIn97QB35zD1xgBY0jZ3zZnI7M=
Date:   Sun, 19 May 2019 12:19:35 +0100
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
Subject: Re: [PATCH] staging: iio: ad9832: Add device tree support
Message-ID: <20190519121935.341fd173@archlinux>
In-Reply-To: <20190518204825.4kh5qkqo2e5q2se6@smtp.gmail.com>
References: <20190518204825.4kh5qkqo2e5q2se6@smtp.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 18 May 2019 17:48:25 -0300
Jo=C3=A3o Seckler <joaoseckler@gmail.com> wrote:

> Add a of_device_id struct variable and subsequent call to
> MODULE_DEVICE_TABLE macro to support device tree.
>=20
> Signed-off-by: Jo=C3=A3o Seckler <joaoseckler@gmail.com>
> Signed-off-by: Anderson Reis <andersonreisrosa@gmail.com>
> Co-developed-by: Anderson Reis  <andersonreisrosa@gmail.com>
> Signed-off-by: Andre Tadeu de Carvalho <andre.tadeu.de.carvalho@gmail.com>
> Co-developed-by: Andre Tadeu de Carvalho <andre.tadeu.de.carvalho@gmail.c=
om>
Hi All,

Missing the setting of the relevant entry in the spi_driver structure.
Otherwise looks fine,

Thanks,

Jonathan
> ---
>  drivers/staging/iio/frequency/ad9832.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio=
/frequency/ad9832.c
> index 74308a2e72db..51e97c74c6b2 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -451,6 +451,13 @@ static int ad9832_remove(struct spi_device *spi)
>  	return 0;
>  }
> =20
> +static const struct of_device_id ad9832_of_match[] =3D {
> +	{ .compatible =3D "adi,ad9832", },
> +	{ .compatible =3D "adi,ad9835", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, ad9832_of_match);
> +
>  static const struct spi_device_id ad9832_id[] =3D {
>  	{"ad9832", 0},
>  	{"ad9835", 0},

