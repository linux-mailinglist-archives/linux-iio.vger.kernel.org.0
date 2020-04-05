Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4C9B19EA46
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 12:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgDEKCX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 06:02:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:42306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbgDEKCW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 06:02:22 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36878206B8;
        Sun,  5 Apr 2020 10:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586080941;
        bh=TgQpx9hq6D3QkwAPHJyK2OPiZ7Gy/fKQy9Cv9VKvvRA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lJe32lWUZKjEn4eRJQeKQaMyvXIV7kRlv6drB38HsdjcLdVd5AzTNN0xHR+oGCn00
         trQXz0D0PRE0T2rhyE3RzyedQTPurUOKkLWDoL7Q1Ut54Ntu/AxKrjPUJYS2cN+Oim
         2v/uQqHp+PgTAsN0h0LuQ9xYWVWrkBVoy7SGHICI=
Date:   Sun, 5 Apr 2020 11:02:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?R2HDq3RhbiBBbmRyw6k=?= <rvlander@gaetanandre.eu>
Cc:     <linux-iio@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>
Subject: Re: [PATCH] iio: st_sensors: make scale channels also shared by
 type
Message-ID: <20200405110217.0f6a38d0@archlinux>
In-Reply-To: <20200330145920.441528-1-rvlander@gaetanandre.eu>
References: <20200330145920.441528-1-rvlander@gaetanandre.eu>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Mar 2020 16:59:20 +0200
Ga=C3=ABtan Andr=C3=A9 <rvlander@gaetanandre.eu> wrote:

> Scale channels are available by axis. For example for accelerometers,
> in_accel_x_scale, in_accel_y_scale and in_accel_z_scale are available.
>=20
> However, they should be shared by type as documented in
> Documentation/ABI/testing/sysfs-bus-iio.
>=20
> For each sensor (acceleros, gyros and magnetos) only one value is specifi=
ed
> for all the axes.
>=20
> Existing, by axis, entries are preserved in order to to leave the old ABI
> untouched.
Hi Ga=C3=ABtan,

Thanks for this.  Whilst I agree the ideal ABI would be to have just the
shared version userspace should cope with the current version anyway as
it would be the right option if for example the scale of x and y are contro=
lled
by one register field and z by another (this used to be common for accelero=
meters)

Any userspace software using this will have to assign a precedence to the
two files that result and the most likely option is more specific first mea=
ning
the shared version is unused.

Hence I'd argue we aren't broke (just non ideal) and adding the additional
interface just confuses matters.  Hence I would rather leave things how they
currently are.  Do we have some userspace that is broken by this being less
than ideal?

Thanks

Jonathan

>=20
> Signed-off-by: Ga=C3=ABtan Andr=C3=A9 <rvlander@gaetanandre.eu>
> ---
>  include/linux/iio/common/st_sensors.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/co=
mmon/st_sensors.h
> index 33e939977444..f31e309f0fd1 100644
> --- a/include/linux/iio/common/st_sensors.h
> +++ b/include/linux/iio/common/st_sensors.h
> @@ -52,6 +52,7 @@
>  	.type =3D device_type, \
>  	.modified =3D mod, \
>  	.info_mask_separate =3D mask, \
> +	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE), \
>  	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ), \
>  	.scan_index =3D index, \
>  	.channel2 =3D ch2, \
>=20
> base-commit: b723e9431b77976b83efb90178dfcada3405321c

