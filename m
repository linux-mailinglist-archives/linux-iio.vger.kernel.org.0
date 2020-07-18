Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E451224BC9
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 16:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgGRO0h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 10:26:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbgGRO0g (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 10:26:36 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEE6B2064B;
        Sat, 18 Jul 2020 14:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595082396;
        bh=w6czAsvpNg2cm9Khs9Qdb3lqGpKLxOJ+OI2goZLSpEw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tji3EW27SXNK/AaLGoFd1oNjGMxFdvKcVjs+Hpv/fC8GBBCvAoNPK/gcY7+07MC9Z
         3Df/Orc2GYQ8cKs929AE5u/DrzgFQYDuXOhUDm7ATIT2do3zh3LP4vvZIE8oVtTVga
         iFA3itOHHY1DWRrhSg9/u+LfWXib8181Gfhb35EE=
Date:   Sat, 18 Jul 2020 15:26:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Tiberiu Breana <tiberiu.a.breana@intel.com>
Subject: Re: [PATCH 02/30] iio: accel: bma220_spi: Do not define 'struct
 acpi_device_id' when !CONFIG_ACPI
Message-ID: <20200718152632.3bf5686a@archlinux>
In-Reply-To: <20200716135928.1456727-3-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
        <20200716135928.1456727-3-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jul 2020 14:59:00 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Since ACPI_PTR() is used to NULLify the value when !CONFIG_ACPI,
> struct 'bma220_acpi_id' becomes defined but unused.
>=20
> Fixes the following W=3D1 kernel build warning(s):
>=20
>  drivers/iio/accel/bma220_spi.c:312:36: warning: =E2=80=98bma220_acpi_id=
=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>  312 | static const struct acpi_device_id bma220_acpi_id[] =3D {
>  | ^~~~~~~~~~~~~~
>=20
> Cc: Tiberiu Breana <tiberiu.a.breana@intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobulders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/bma220_spi.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_sp=
i.c
> index cae905039cb62..439618d815594 100644
> --- a/drivers/iio/accel/bma220_spi.c
> +++ b/drivers/iio/accel/bma220_spi.c
> @@ -309,12 +309,14 @@ static const struct spi_device_id bma220_spi_id[] =
=3D {
>  	{}
>  };
> =20
> +#ifdef CONFIG_ACPI
>  static const struct acpi_device_id bma220_acpi_id[] =3D {
>  	{"BMA0220", 0},
>  	{}
>  };
> =20
>  MODULE_DEVICE_TABLE(spi, bma220_spi_id);
> +#endif
> =20
>  static struct spi_driver bma220_driver =3D {
>  	.driver =3D {

