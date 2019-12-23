Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47EAC1298A1
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 17:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfLWQVQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 11:21:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:57312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbfLWQVP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 11:21:15 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2C7820709;
        Mon, 23 Dec 2019 16:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577118074;
        bh=Q8ZhTsCugfNo8m6nl/xAe7DdRSys4zaMNgu1MvrpQKA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Qv/NhqnxnkJcWD6O6B9pQpHZpxtR3/pZEqOcW0JDiAPqkNY/tNTcHz+jn2h1eovns
         m625xf/BmtMQZYzzaFCjlM+1LHUYwH5LBcLtbjeH6GGsrzbq9VYaPY/JV4E+b1fCMV
         srBt0mapS7HEfPE4Tu+u86erW/XSnhQ+Pc95wCDY=
Date:   Mon, 23 Dec 2019 16:21:11 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1 6/9] iio: pressure: st_press: Mark
 default_press_pdata with __maybe_unused
Message-ID: <20191223162111.0e185af1@archlinux>
In-Reply-To: <20191216173853.75797-6-andriy.shevchenko@linux.intel.com>
References: <20191216173853.75797-1-andriy.shevchenko@linux.intel.com>
        <20191216173853.75797-6-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Dec 2019 19:38:50 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Since we put static variable to a header file it's copied to each module
> that includes the header. But not all of them are actually used it.
>=20
> Mark default_press_pdata with __maybe_unused to calm a compiler down:
>=20
> In file included from drivers/iio/pressure/st_pressure_spi.c:18:
> drivers/iio/pressure/st_pressure.h:40:46: warning: =E2=80=98default_press=
_pdata=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>    40 | static const struct st_sensors_platform_data default_press_pdata =
=3D {
>       |                                              ^~~~~~~~~~~~~~~~~~~
> ...
>=20
Applied.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/pressure/st_pressure.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/pressure/st_pressure.h b/drivers/iio/pressure/st=
_pressure.h
> index c2e47a6c3118..5c746ff6087e 100644
> --- a/drivers/iio/pressure/st_pressure.h
> +++ b/drivers/iio/pressure/st_pressure.h
> @@ -37,7 +37,7 @@ enum st_press_type {
>   * struct st_sensors_platform_data - default press platform data
>   * @drdy_int_pin: default press DRDY is available on INT1 pin.
>   */
> -static const struct st_sensors_platform_data default_press_pdata =3D {
> +static __maybe_unused const struct st_sensors_platform_data default_pres=
s_pdata =3D {
>  	.drdy_int_pin =3D 1,
>  };
> =20

