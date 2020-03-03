Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9D6178446
	for <lists+linux-iio@lfdr.de>; Tue,  3 Mar 2020 21:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731899AbgCCUs3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Mar 2020 15:48:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:42366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730274AbgCCUs2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 3 Mar 2020 15:48:28 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0894720848;
        Tue,  3 Mar 2020 20:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583268507;
        bh=eRhj8iCSE+FnwgT+1LUDs3GuksPLbB2hh4dzgtVvPgs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2VN/CMzYdSWZ/7sPR/63gvOYjv0shjKYWHIF1aIy+L1ILt5ZV6IJXDj4zPWt/zs31
         Xv6pwgkY2wCBMEcwzvtreu8QwqZxo/LYCFoZMkxA2xu5pwfttJQzUDJzDkdK88w9t0
         Grfg97oemE0DQ7vsN8DS6yQPzIX4MsvWLChGg15Y=
Date:   Tue, 3 Mar 2020 20:48:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 3/5] iio: adis: Add adis_update_bits() APIs
Message-ID: <20200303204820.272d2235@archlinux>
In-Reply-To: <20200225124152.270914-4-nuno.sa@analog.com>
References: <20200225124152.270914-1-nuno.sa@analog.com>
        <20200225124152.270914-4-nuno.sa@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 25 Feb 2020 13:41:50 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> This patch adds a `regmap_update_bits()` like API to the ADIS library.
> It provides locked and unlocked variant.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Mostly fine, but I wonder if we can avoid the need to have comments
on handling of 1 and 8 byte values by explicitly avoiding them happening.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis.c       | 26 +++++++++++++++
>  include/linux/iio/imu/adis.h | 61 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 87 insertions(+)
>=20
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index a8afd01de4f3..fa0ee35d96f0 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -223,6 +223,32 @@ int __adis_read_reg(struct adis *adis, unsigned int =
reg,
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(__adis_read_reg);
> +/**
> + * __adis_update_bits_base() - ADIS Update bits function - Unlocked vers=
ion
> + * @adis: The adis device
> + * @reg: The address of the lower of the two registers
> + * @mask: Bitmask to change
> + * @val: Value to be written
> + * @size: Size of the register to update
> + *
> + * Updates the desired bits of @reg in accordance with @mask and @val.
> + */
> +int __adis_update_bits_base(struct adis *adis, unsigned int reg, const u=
32 mask,
> +			    const u32 val, u8 size)
> +{
> +	int ret;
> +	u32 __val;
> +
> +	ret =3D __adis_read_reg(adis, reg, &__val, size);
> +	if (ret)
> +		return ret;
> +
> +	__val &=3D ~mask;
> +	__val |=3D val & mask;
> +
> +	return __adis_write_reg(adis, reg, __val, size);
> +}
> +EXPORT_SYMBOL_GPL(__adis_update_bits_base);
> =20
>  #ifdef CONFIG_DEBUG_FS
> =20
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index b4c35d137e2a..07073f698718 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -303,6 +303,67 @@ static inline int adis_read_reg_32(struct adis *adis=
, unsigned int reg,
>  	return ret;
>  }
> =20
> +int __adis_update_bits_base(struct adis *adis, unsigned int reg, const u=
32 mask,
> +			    const u32 val, u8 size);
> +/**
> + * adis_update_bits_base() - ADIS Update bits function - Locked version
> + * @adis: The adis device
> + * @reg: The address of the lower of the two registers
> + * @mask: Bitmask to change
> + * @val: Value to be written
> + * @size: Size of the register to update
> + *
> + * Updates the desired bits of @reg in accordance with @mask and @val.
> + */
> +static inline int adis_update_bits_base(struct adis *adis, unsigned int =
reg,
> +					const u32 mask, const u32 val, u8 size)
> +{
> +	int ret;
> +
> +	mutex_lock(&adis->state_lock);
> +	ret =3D __adis_update_bits_base(adis, reg, mask, val, size);
> +	mutex_unlock(&adis->state_lock);
> +	return ret;
> +}
> +
> +/**
> + * adis_update_bits() - Wrapper macro for adis_update_bits_base - Locked=
 version
> + * @adis: The adis device
> + * @reg: The address of the lower of the two registers
> + * @mask: Bitmask to change
> + * @val: Value to be written
> + *
> + * This macro evaluates the sizeof of @val at compile time and calls
> + * adis_update_bits_base() accordingly. Be aware that using MACROS/DEFIN=
ES for
> + * @val can lead to undesired behavior if the register to update is 16bi=
t. Also
> + * note that a 64bit value will be treated as an integer. In the same wa=
y,
> + * a char is seen as a short.

Are these 'edge' conditions desirable?  If not can we use the compile
time checking tricks to trigger a build failure if they occur?
BUILD_BUG_ON(sizeof(val) =3D=3D 1) etc.

> + */
> +#define adis_update_bits(adis, reg, mask, val) ({			\
> +	__builtin_choose_expr(sizeof(val) =3D=3D 8 || sizeof(val) =3D=3D 4,	\
> +		adis_update_bits_base(adis, reg, mask, val, 4),         \
> +		adis_update_bits_base(adis, reg, mask, val, 2));	\
> +})
> +
> +/**
> + * adis_update_bits() - Wrapper macro for adis_update_bits_base
> + * @adis: The adis device
> + * @reg: The address of the lower of the two registers
> + * @mask: Bitmask to change
> + * @val: Value to be written
> + *
> + * This macro evaluates the sizeof of @val at compile time and calls
> + * adis_update_bits_base() accordingly. Be aware that using MACROS/DEFIN=
ES for
> + * @val can lead to undesired behavior if the register to update is 16bi=
t. Also
> + * note that a 64bit value will be treated as an integer. In the same wa=
y,
> + * a char is seen as a short.
> + */
> +#define __adis_update_bits(adis, reg, mask, val) ({			\
> +	__builtin_choose_expr(sizeof(val) =3D=3D 8 || sizeof(val) =3D=3D 4,	\
> +		__adis_update_bits_base(adis, reg, mask, val, 4),	\
> +		__adis_update_bits_base(adis, reg, mask, val, 2));	\
> +})
> +
>  int adis_enable_irq(struct adis *adis, bool enable);
>  int __adis_check_status(struct adis *adis);
>  int __adis_initial_startup(struct adis *adis);

