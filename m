Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1ECF224CB8
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 17:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgGRPyw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 11:54:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgGRPyw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:54:52 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 265732076A;
        Sat, 18 Jul 2020 15:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595087691;
        bh=cX88xjUh6k23MhOXafKP1+nDk7IVvQx3jZHuzTNKMrM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fDFttJ7l8n2GW38lMbyPK8AdO6ePV5tV/UrMeW1J7vjEzyscvCKuDBddpPhnfzWc+
         4u5nUEiQYOx0mkLhqiVdEsVt12IVkayoaA94PeM6W2bB+w9hXvlD+CfX1uhcFE7Fpv
         DPNQCJ7XXSAyiyejKpv6c4tr/HckF5NGVFe9ngJ0=
Date:   Sat, 18 Jul 2020 16:54:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [PATCH 19/30] iio: imu: st_lsm6dsx: st_lsm6dsx: Reorder
 'inline' declaration
Message-ID: <20200718165447.7b804080@archlinux>
In-Reply-To: <20200717165538.3275050-20-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
        <20200717165538.3275050-20-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Jul 2020 17:55:27 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Fixes the following W=3D1 kernel build warning(s):
>=20
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h:487:1: warning: =E2=80=98inline=
=E2=80=99 is not at beginning of declaration [-Wold-style-declaration]
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h:497:44: warning: =E2=80=98st_lsm=
6dsx_accel_ext_info=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>=20
> Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
> Cc: Denis Ciocca <denis.ciocca@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied. Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
> index b56df409ed0fa..3e47a9287938b 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -484,7 +484,7 @@ st_lsm6dsx_write_locked(struct st_lsm6dsx_hw *hw, uns=
igned int addr,
>  	return err;
>  }
> =20
> -static const inline struct iio_mount_matrix *
> +static inline const struct iio_mount_matrix *
>  st_lsm6dsx_get_mount_matrix(const struct iio_dev *iio_dev,
>  			    const struct iio_chan_spec *chan)
>  {

