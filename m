Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7371298A0
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 17:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfLWQVB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 11:21:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:57224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbfLWQVA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 11:21:00 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7324A20709;
        Mon, 23 Dec 2019 16:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577118060;
        bh=hhdnUL6rHEcifHPeujRobS5ZJEc5R0ISwhdIco1Ajxo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=diIudbJLGqHGJ28Rdqx/nMtyMXtb+qVO3QR0uGCo7sqtLvckIfPmW8yKzXqhwZM5A
         hwgopcTQpHt70hjuCPKnSohU3SxFUpngyk2Nu7pyO0UDDUEBIh6B+hejeyxA9ogzuK
         SnxN/FXC9r1x+E5yyMNcQDITGMv0Tnd9OKC1GtAg=
Date:   Mon, 23 Dec 2019 16:20:56 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1 5/9] iio: accel: st_accel: Mark default_accel_pdata
 with __maybe_unused
Message-ID: <20191223162056.36b3d3a5@archlinux>
In-Reply-To: <20191216173853.75797-5-andriy.shevchenko@linux.intel.com>
References: <20191216173853.75797-1-andriy.shevchenko@linux.intel.com>
        <20191216173853.75797-5-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Dec 2019 19:38:49 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Since we put static variable to a header file it's copied to each module
> that includes the header. But not all of them are actually used it.
>=20
> Mark default_accel_pdata with __maybe_unused to calm a compiler down:
>=20
> In file included from drivers/iio/accel/st_accel_i2c.c:19:
> drivers/iio/accel/st_accel.h:67:46: warning: =E2=80=98default_accel_pdata=
=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>    67 | static const struct st_sensors_platform_data default_accel_pdata =
=3D {
>       |                                              ^~~~~~~~~~~~~~~~~~~
> ...
Applied.

>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/accel/st_accel.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
> index af09943f38c9..5b13e293cade 100644
> --- a/drivers/iio/accel/st_accel.h
> +++ b/drivers/iio/accel/st_accel.h
> @@ -64,7 +64,7 @@ enum st_accel_type {
>  * struct st_sensors_platform_data - default accel platform data
>  * @drdy_int_pin: default accel DRDY is available on INT1 pin.
>  */
> -static const struct st_sensors_platform_data default_accel_pdata =3D {
> +static __maybe_unused const struct st_sensors_platform_data default_acce=
l_pdata =3D {
>  	.drdy_int_pin =3D 1,
>  };
> =20

