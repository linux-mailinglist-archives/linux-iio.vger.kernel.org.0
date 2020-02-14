Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12CE315D959
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2020 15:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgBNOW5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Feb 2020 09:22:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:53894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727822AbgBNOW5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Feb 2020 09:22:57 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99E2B206B6;
        Fri, 14 Feb 2020 14:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581690175;
        bh=NrpwgcFyLC71POgcYEKydVUSwSfQCR1E53fLHq0K2gY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=v5Fm96Q2R8JiYbF6ih9KmaHB3WC1xxDgdAFTBw85miZHH0U+hcR3FNwObtjmLRJ+y
         vt2fkjUHPAg+oDFOKoayKu6O0CphuHZHskmPGGI09DtOeniAjPv7J2xyy4MCM/YHJ0
         jSGwD56JvmUhkKIyqZcDly64c7pEN4HRII+fIub0=
Date:   Fri, 14 Feb 2020 14:22:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Maxime =?UTF-8?B?Um91c3Npbi1Cw6lsYW5nZXI=?= 
        <maxime.roussinbelanger@gmail.com>
Cc:     linux-iio@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net,
        Guillaume Champagne <champagne.guillaume.c@gmail.com>
Subject: Re: [PATCH] iio: si1133: read 24 signed integer for measurement
Message-ID: <20200214142251.6c50ccf2@archlinux>
In-Reply-To: <20200207160740.29508-1-maxime.roussinbelanger@gmail.com>
References: <20200207160740.29508-1-maxime.roussinbelanger@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  7 Feb 2020 11:07:40 -0500
Maxime Roussin-B=C3=A9langer         <maxime.roussinbelanger@gmail.com> wro=
te:

> The chip is configured in 24 bit mode. The values read from it must
> always be treated as is. This fixes the issue by replacing the previous
> 16 bits value by a 24 bits buffer.
>=20
> This changes affects the value output by previous version of the driver,
> since the least significant byte was missing. The upper half of 16
> bit values previously output are now the upper half of a 24 bit value.
>=20
> Co-authored-by: Guillaume Champagne <champagne.guillaume.c@gmail.com>
> Signed-off-by: Maxime Roussin-B=C3=A9langer <maxime.roussinbelanger@gmail=
.com>
Patch looks fine, so question is whether we treat this as an enhancement,
or a fix? If it's a fix please provide a suitable fixes tag.

Thanks,

Jonathan

> ---
>  drivers/iio/light/si1133.c | 37 ++++++++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
> index 777b1a0848c9..509af982e185 100644
> --- a/drivers/iio/light/si1133.c
> +++ b/drivers/iio/light/si1133.c
> @@ -102,6 +102,9 @@
>  #define SI1133_INPUT_FRACTION_LOW	15
>  #define SI1133_LUX_OUTPUT_FRACTION	12
>  #define SI1133_LUX_BUFFER_SIZE		9
> +#define SI1133_MEASURE_BUFFER_SIZE	3
> +
> +#define SI1133_SIGN_BIT_INDEX 23
> =20
>  static const int si1133_scale_available[] =3D {
>  	1, 2, 4, 8, 16, 32, 64, 128};
> @@ -234,13 +237,13 @@ static const struct si1133_lux_coeff lux_coeff =3D {
>  	}
>  };
> =20
> -static int si1133_calculate_polynomial_inner(u32 input, u8 fraction, u16=
 mag,
> +static int si1133_calculate_polynomial_inner(s32 input, u8 fraction, u16=
 mag,
>  					     s8 shift)
>  {
>  	return ((input << fraction) / mag) << shift;
>  }
> =20
> -static int si1133_calculate_output(u32 x, u32 y, u8 x_order, u8 y_order,
> +static int si1133_calculate_output(s32 x, s32 y, u8 x_order, u8 y_order,
>  				   u8 input_fraction, s8 sign,
>  				   const struct si1133_coeff *coeffs)
>  {
> @@ -276,7 +279,7 @@ static int si1133_calculate_output(u32 x, u32 y, u8 x=
_order, u8 y_order,
>   * The algorithm is from:
>   * https://siliconlabs.github.io/Gecko_SDK_Doc/efm32zg/html/si1133_8c_so=
urce.html#l00716
>   */
> -static int si1133_calc_polynomial(u32 x, u32 y, u8 input_fraction, u8 nu=
m_coeff,
> +static int si1133_calc_polynomial(s32 x, s32 y, u8 input_fraction, u8 nu=
m_coeff,
>  				  const struct si1133_coeff *coeffs)
>  {
>  	u8 x_order, y_order;
> @@ -614,23 +617,24 @@ static int si1133_measure(struct si1133_data *data,
>  {
>  	int err;
> =20
> -	__be16 resp;
> +	u8 buffer[SI1133_MEASURE_BUFFER_SIZE];
> =20
>  	err =3D si1133_set_adcmux(data, 0, chan->channel);
>  	if (err)
>  		return err;
> =20
>  	/* Deactivate lux measurements if they were active */
>  	err =3D si1133_set_chlist(data, BIT(0));
>  	if (err)
>  		return err;
> =20
> -	err =3D si1133_bulk_read(data, SI1133_REG_HOSTOUT(0), sizeof(resp),
> -			       (u8 *)&resp);
> +	err =3D si1133_bulk_read(data, SI1133_REG_HOSTOUT(0), sizeof(buffer),
> +			       buffer);
>  	if (err)
>  		return err;
> =20
> -	*val =3D be16_to_cpu(resp);
> +	*val =3D sign_extend32((buffer[0] << 16) | (buffer[1] << 8) | buffer[2],
> +			     SI1133_SIGN_BIT_INDEX);
> =20
>  	return err;
>  }
> @@ -704,9 +708,9 @@ static int si1133_get_lux(struct si1133_data *data, i=
nt *val)
>  {
>  	int err;
>  	int lux;
> -	u32 high_vis;
> -	u32 low_vis;
> -	u32 ir;
> +	s32 high_vis;
> +	s32 low_vis;
> +	s32 ir;
>  	u8 buffer[SI1133_LUX_BUFFER_SIZE];
> =20
>  	/* Activate lux channels */
> @@ -719,9 +723,16 @@ static int si1133_get_lux(struct si1133_data *data, =
int *val)
>  	if (err)
>  		return err;
> =20
> -	high_vis =3D (buffer[0] << 16) | (buffer[1] << 8) | buffer[2];
> -	low_vis =3D (buffer[3] << 16) | (buffer[4] << 8) | buffer[5];
> -	ir =3D (buffer[6] << 16) | (buffer[7] << 8) | buffer[8];
> +	high_vis =3D
> +		sign_extend32((buffer[0] << 16) | (buffer[1] << 8) | buffer[2],
> +			      SI1133_SIGN_BIT_INDEX);
> +
> +	low_vis =3D
> +		sign_extend32((buffer[3] << 16) | (buffer[4] << 8) | buffer[5],
> +			      SI1133_SIGN_BIT_INDEX);
> +
> +	ir =3D sign_extend32((buffer[6] << 16) | (buffer[7] << 8) | buffer[8],
> +			   SI1133_SIGN_BIT_INDEX);
> =20
>  	if (high_vis > SI1133_ADC_THRESHOLD || ir > SI1133_ADC_THRESHOLD)
>  		lux =3D si1133_calc_polynomial(high_vis, ir,

