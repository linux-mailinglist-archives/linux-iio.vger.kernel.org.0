Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8291A224BC7
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 16:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgGROYo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 10:24:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbgGROYo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 10:24:44 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F42E2073A;
        Sat, 18 Jul 2020 14:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595082283;
        bh=5YO//9L/hKsayZKzu3oCnEDLo/YamLgoJh09Ng+5A2U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P4F+nghObuMVBezJ0WlFpwmdMcTMKaSFtUaG3xxTkSsYeLXy6eAJvEO0ovXxGXRJ9
         xUowJteOEgACxrmyYhJUlCviECf61Ja7P9va3U4Zzqghk24hTwZJZdJMzWv3g+ACdZ
         dBmdJr7XSCV/MoSmzZ3/qqUTHcSKntsoFx0aHO8Q=
Date:   Sat, 18 Jul 2020 15:24:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 01/30] iio: adc: ad_sigma_delta: Remove unused variable
 'ret'
Message-ID: <20200718152439.32a48328@archlinux>
In-Reply-To: <20200716135928.1456727-2-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
        <20200716135928.1456727-2-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jul 2020 14:58:59 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Fixes the following W=3D1 kernel build warning(s):
>=20
>  drivers/iio/adc/ad_sigma_delta.c: In function =E2=80=98ad_sd_trigger_han=
dler=E2=80=99:
>  drivers/iio/adc/ad_sigma_delta.c:405:6: warning: variable =E2=80=98ret=
=E2=80=99 set but not used [-Wunused-but-set-variable]
>  405 | int ret;
>  | ^~~
>=20
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Hi Lee,

My only thought on this one is perhaps we should put a warning in there
if ret isn't as expected.  Still never been one yet so I doubt anyone
minds too much.

Applied to the togreg branch of iio.git and pushed out as testing.
Note there is time for reviews from others before I push this out as
a non rebasing branch.  I'm also going to need to rebase it once
as previous pull hasn't quite gotten into staging/staging-next yet.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad_sigma_delta.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_=
delta.c
> index dd3d54b3bc8bb..f269b926440da 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -402,7 +402,6 @@ static irqreturn_t ad_sd_trigger_handler(int irq, voi=
d *p)
>  	unsigned int reg_size;
>  	unsigned int data_reg;
>  	uint8_t data[16];
> -	int ret;
> =20
>  	memset(data, 0x00, 16);
> =20
> @@ -419,14 +418,12 @@ static irqreturn_t ad_sd_trigger_handler(int irq, v=
oid *p)
>  	case 4:
>  	case 2:
>  	case 1:
> -		ret =3D ad_sd_read_reg_raw(sigma_delta, data_reg, reg_size,
> -			&data[0]);
> +		ad_sd_read_reg_raw(sigma_delta, data_reg, reg_size, &data[0]);
>  		break;
>  	case 3:
>  		/* We store 24 bit samples in a 32 bit word. Keep the upper
>  		 * byte set to zero. */
> -		ret =3D ad_sd_read_reg_raw(sigma_delta, data_reg, reg_size,
> -			&data[1]);
> +		ad_sd_read_reg_raw(sigma_delta, data_reg, reg_size, &data[1]);
>  		break;
>  	}
> =20

