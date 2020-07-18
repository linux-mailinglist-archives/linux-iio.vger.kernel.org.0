Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544E1224CE2
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 18:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgGRQON (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 12:14:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgGRQON (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 12:14:13 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71B3F2070E;
        Sat, 18 Jul 2020 16:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595088852;
        bh=Osp/gKISTVnGXNKf6iQAKCzlIBxB7UoGrG0JXnknpOY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UmQESmDDKfJQC0zatRyjCf0uJkvMfUFCOGjQNf8Ai7/L7fsjfGmojzF4y0C86iQxh
         bZJ1CeeQrBwmWyRmIgoNHCtR7Veatn4WXEuKB4BEzy88xrt/zKcTFcxRSpXN80ny50
         DGcACR0bLV8SFv0Nj3OpcKAhBHKR7NqefcBMgD00=
Date:   Sat, 18 Jul 2020 17:14:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [PATCH 29/30] iio: imu: st_lsm6dsx: st_lsm6dsx: Mark
 'st_lsm6dsx_accel_ext_info' as __maybe_unused
Message-ID: <20200718171408.3bd958d0@archlinux>
In-Reply-To: <20200717165538.3275050-30-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
        <20200717165538.3275050-30-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Jul 2020 17:55:37 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> It doesn't make sense to move it into '*core*' as it's co-located with
> other, similar definitions which are used in multiple locations.
>=20
> Fixes the following W=3D1 kernel build warning(s):
>=20
>  In file included from drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c:17:
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h:497:44: warning: =E2=80=98st_lsm=
6dsx_accel_ext_info=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  497 | static const struct iio_chan_spec_ext_info st_lsm6dsx_accel_ext_in=
fo[] =3D {
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~
>  In file included from drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c:17:
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h:497:44: warning: =E2=80=98st_lsm=
6dsx_accel_ext_info=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  497 | static const struct iio_chan_spec_ext_info st_lsm6dsx_accel_ext_in=
fo[] =3D {
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~
>  In file included from drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c:16:
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h:497:44: warning: =E2=80=98st_lsm=
6dsx_accel_ext_info=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  497 | static const struct iio_chan_spec_ext_info st_lsm6dsx_accel_ext_in=
fo[] =3D {
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
> Cc: Denis Ciocca <denis.ciocca@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
> index 3e47a9287938b..d82ec6398222f 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -494,7 +494,8 @@ st_lsm6dsx_get_mount_matrix(const struct iio_dev *iio=
_dev,
>  	return &hw->orientation;
>  }
> =20
> -static const struct iio_chan_spec_ext_info st_lsm6dsx_accel_ext_info[] =
=3D {
> +static const
> +struct iio_chan_spec_ext_info __maybe_unused st_lsm6dsx_accel_ext_info[]=
 =3D {
>  	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, st_lsm6dsx_get_mount_matrix),
>  	{ }
>  };

