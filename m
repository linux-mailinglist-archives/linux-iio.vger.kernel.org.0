Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 273EA18EB71
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 19:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgCVSPw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 14:15:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgCVSPw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Mar 2020 14:15:52 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D72520719;
        Sun, 22 Mar 2020 18:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584900951;
        bh=FRoKX4v7uPKKbY2jZ/bk15LpoXBLxOf+xA67aV49E9E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pxtqTQ/D0mx9+5/AJiz05LGw+YFBzdygikAq2OIiFIG4S/fOEHpeAlCrku+bAGzIr
         p5hWe6ftVZV6DAdJqzLhC08P7dzIeBm/hW7hqcgx16u96cfQD+woA420usBZrq5w+7
         v8mNjxkqJnYkJ0CDqsrdav3Y5ET30InUq68hezrA=
Date:   Sun, 22 Mar 2020 18:15:47 +0000
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
Subject: Re: [PATCH v2 3/6] iio: adis: Add adis_update_bits() APIs
Message-ID: <20200322181547.29691951@archlinux>
In-Reply-To: <20200316125312.39178-4-nuno.sa@analog.com>
References: <20200316125312.39178-1-nuno.sa@analog.com>
        <20200316125312.39178-4-nuno.sa@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Mar 2020 13:53:09 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> This patch adds a `regmap_update_bits()` like API to the ADIS library.
> It provides locked and unlocked variant.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>

hmm. This feels a bit 'too clever' but hopefully we won't get any subtle
bugs due to wrong local variable types etc.

I'll pick this up when the rest of the series is ready.

Jonathan

> ---
> Changes in v2:
>  * Add BUILD_BUG_ON() to avoid invalid types.
>=20
>  drivers/iio/imu/adis.c       | 26 ++++++++++++++++
>  include/linux/iio/imu/adis.h | 59 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 85 insertions(+)
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
> index ed41c6b96d14..94031b3fc9d5 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -333,6 +333,65 @@ static inline int adis_read_reg_32(struct adis *adis=
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
t.
> + */
> +#define adis_update_bits(adis, reg, mask, val) ({			\
> +	BUILD_BUG_ON(sizeof(val) =3D=3D 1 || sizeof(val) =3D=3D 8);		\
> +	__builtin_choose_expr(sizeof(val) =3D=3D 4,				\
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
t.
> + */
> +#define __adis_update_bits(adis, reg, mask, val) ({			\
> +	BUILD_BUG_ON(sizeof(val) =3D=3D 1 || sizeof(val) =3D=3D 8);		\
> +	__builtin_choose_expr(sizeof(val) =3D=3D 4,				\
> +		__adis_update_bits_base(adis, reg, mask, val, 4),	\
> +		__adis_update_bits_base(adis, reg, mask, val, 2));	\
> +})
> +
>  int adis_enable_irq(struct adis *adis, bool enable);
>  int __adis_check_status(struct adis *adis);
>  int __adis_initial_startup(struct adis *adis);

