Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9AAE224CB6
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 17:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgGRPyM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 11:54:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:50168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgGRPyM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:54:12 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA1AD2076A;
        Sat, 18 Jul 2020 15:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595087650;
        bh=i5Zz97+ICJSBOjFnb4Oeh+45/uRYCq/NpnvVHou4D/k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sfm13BfGUFxxiJ2S3hoWPAnMb65aBeN0J1ZHjSlCoE9DLrjcifU/5QDUI88kv8hNT
         UoRNpBGDK1UVl/HoLrc0M/ZfXSkJ4CVAFqb3lD8xLsaG4pc2gw++KsjuLTdac0oGTT
         N6onXZkixfe9EaO3bnBelmXySOvd/Ade/KXiLZDc=
Date:   Sat, 18 Jul 2020 16:54:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Rui Miguel Silva <rmfrfs@gmail.com>
Subject: Re: [PATCH 18/30] iio: gyro: fxas21002c: Move
 'fxas21002c_reg_fields' to the only file its used
Message-ID: <20200718165406.1c46c5ae@archlinux>
In-Reply-To: <20200717165538.3275050-19-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
        <20200717165538.3275050-19-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Jul 2020 17:55:26 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> 'fxas21002c_reg_fields' is only used in '*core*', meaning that '*i2c*'
> and '*spi*' complain of a defined but not used const variable.  Let's
> move it into the source file.
>=20
> Fixes the following W=3D1 kernel build warning(s):
>=20
>  In file included from drivers/iio/gyro/fxas21002c_i2c.c:14:
>  drivers/iio/gyro/fxas21002c.h:79:31: warning: =E2=80=98fxas21002c_reg_fi=
elds=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>  79 | static const struct reg_field fxas21002c_reg_fields[] =3D {
>  | ^~~~~~~~~~~~~~~~~~~~~
>  In file included from drivers/iio/gyro/fxas21002c_spi.c:14:
>  drivers/iio/gyro/fxas21002c.h:79:31: warning: =E2=80=98fxas21002c_reg_fi=
elds=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>  79 | static const struct reg_field fxas21002c_reg_fields[] =3D {
>  | ^~~~~~~~~~~~~~~~~~~~~
>=20
> Cc: Rui Miguel Silva <rmfrfs@gmail.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Sensible solution.

Applied

Thanks,

Jonathan

> ---
>  drivers/iio/gyro/fxas21002c.h      | 66 ------------------------------
>  drivers/iio/gyro/fxas21002c_core.c | 66 ++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+), 66 deletions(-)
>=20
> diff --git a/drivers/iio/gyro/fxas21002c.h b/drivers/iio/gyro/fxas21002c.h
> index 566d92de26763..c81cecee121cb 100644
> --- a/drivers/iio/gyro/fxas21002c.h
> +++ b/drivers/iio/gyro/fxas21002c.h
> @@ -76,72 +76,6 @@ enum fxas21002c_fields {
>  	F_MAX_FIELDS,
>  };
> =20
> -static const struct reg_field fxas21002c_reg_fields[] =3D {
> -	[F_DR_STATUS]		=3D REG_FIELD(FXAS21002C_REG_STATUS, 0, 7),
> -	[F_OUT_X_MSB]		=3D REG_FIELD(FXAS21002C_REG_OUT_X_MSB, 0, 7),
> -	[F_OUT_X_LSB]		=3D REG_FIELD(FXAS21002C_REG_OUT_X_LSB, 0, 7),
> -	[F_OUT_Y_MSB]		=3D REG_FIELD(FXAS21002C_REG_OUT_Y_MSB, 0, 7),
> -	[F_OUT_Y_LSB]		=3D REG_FIELD(FXAS21002C_REG_OUT_Y_LSB, 0, 7),
> -	[F_OUT_Z_MSB]		=3D REG_FIELD(FXAS21002C_REG_OUT_Z_MSB, 0, 7),
> -	[F_OUT_Z_LSB]		=3D REG_FIELD(FXAS21002C_REG_OUT_Z_LSB, 0, 7),
> -	[F_ZYX_OW]		=3D REG_FIELD(FXAS21002C_REG_DR_STATUS, 7, 7),
> -	[F_Z_OW]		=3D REG_FIELD(FXAS21002C_REG_DR_STATUS, 6, 6),
> -	[F_Y_OW]		=3D REG_FIELD(FXAS21002C_REG_DR_STATUS, 5, 5),
> -	[F_X_OW]		=3D REG_FIELD(FXAS21002C_REG_DR_STATUS, 4, 4),
> -	[F_ZYX_DR]		=3D REG_FIELD(FXAS21002C_REG_DR_STATUS, 3, 3),
> -	[F_Z_DR]		=3D REG_FIELD(FXAS21002C_REG_DR_STATUS, 2, 2),
> -	[F_Y_DR]		=3D REG_FIELD(FXAS21002C_REG_DR_STATUS, 1, 1),
> -	[F_X_DR]		=3D REG_FIELD(FXAS21002C_REG_DR_STATUS, 0, 0),
> -	[F_OVF]			=3D REG_FIELD(FXAS21002C_REG_F_STATUS, 7, 7),
> -	[F_WMKF]		=3D REG_FIELD(FXAS21002C_REG_F_STATUS, 6, 6),
> -	[F_CNT]			=3D REG_FIELD(FXAS21002C_REG_F_STATUS, 0, 5),
> -	[F_MODE]		=3D REG_FIELD(FXAS21002C_REG_F_SETUP, 6, 7),
> -	[F_WMRK]		=3D REG_FIELD(FXAS21002C_REG_F_SETUP, 0, 5),
> -	[F_EVENT]		=3D REG_FIELD(FXAS21002C_REG_F_EVENT, 5, 5),
> -	[FE_TIME]		=3D REG_FIELD(FXAS21002C_REG_F_EVENT, 0, 4),
> -	[F_BOOTEND]		=3D REG_FIELD(FXAS21002C_REG_INT_SRC_FLAG, 3, 3),
> -	[F_SRC_FIFO]		=3D REG_FIELD(FXAS21002C_REG_INT_SRC_FLAG, 2, 2),
> -	[F_SRC_RT]		=3D REG_FIELD(FXAS21002C_REG_INT_SRC_FLAG, 1, 1),
> -	[F_SRC_DRDY]		=3D REG_FIELD(FXAS21002C_REG_INT_SRC_FLAG, 0, 0),
> -	[F_WHO_AM_I]		=3D REG_FIELD(FXAS21002C_REG_WHO_AM_I, 0, 7),
> -	[F_BW]			=3D REG_FIELD(FXAS21002C_REG_CTRL0, 6, 7),
> -	[F_SPIW]		=3D REG_FIELD(FXAS21002C_REG_CTRL0, 5, 5),
> -	[F_SEL]			=3D REG_FIELD(FXAS21002C_REG_CTRL0, 3, 4),
> -	[F_HPF_EN]		=3D REG_FIELD(FXAS21002C_REG_CTRL0, 2, 2),
> -	[F_FS]			=3D REG_FIELD(FXAS21002C_REG_CTRL0, 0, 1),
> -	[F_ELE]			=3D REG_FIELD(FXAS21002C_REG_RT_CFG, 3, 3),
> -	[F_ZTEFE]		=3D REG_FIELD(FXAS21002C_REG_RT_CFG, 2, 2),
> -	[F_YTEFE]		=3D REG_FIELD(FXAS21002C_REG_RT_CFG, 1, 1),
> -	[F_XTEFE]		=3D REG_FIELD(FXAS21002C_REG_RT_CFG, 0, 0),
> -	[F_EA]			=3D REG_FIELD(FXAS21002C_REG_RT_SRC, 6, 6),
> -	[F_ZRT]			=3D REG_FIELD(FXAS21002C_REG_RT_SRC, 5, 5),
> -	[F_ZRT_POL]		=3D REG_FIELD(FXAS21002C_REG_RT_SRC, 4, 4),
> -	[F_YRT]			=3D REG_FIELD(FXAS21002C_REG_RT_SRC, 3, 3),
> -	[F_YRT_POL]		=3D REG_FIELD(FXAS21002C_REG_RT_SRC, 2, 2),
> -	[F_XRT]			=3D REG_FIELD(FXAS21002C_REG_RT_SRC, 1, 1),
> -	[F_XRT_POL]		=3D REG_FIELD(FXAS21002C_REG_RT_SRC, 0, 0),
> -	[F_DBCNTM]		=3D REG_FIELD(FXAS21002C_REG_RT_THS, 7, 7),
> -	[F_THS]			=3D REG_FIELD(FXAS21002C_REG_RT_SRC, 0, 6),
> -	[F_RT_COUNT]		=3D REG_FIELD(FXAS21002C_REG_RT_COUNT, 0, 7),
> -	[F_TEMP]		=3D REG_FIELD(FXAS21002C_REG_TEMP, 0, 7),
> -	[F_RST]			=3D REG_FIELD(FXAS21002C_REG_CTRL1, 6, 6),
> -	[F_ST]			=3D REG_FIELD(FXAS21002C_REG_CTRL1, 5, 5),
> -	[F_DR]			=3D REG_FIELD(FXAS21002C_REG_CTRL1, 2, 4),
> -	[F_ACTIVE]		=3D REG_FIELD(FXAS21002C_REG_CTRL1, 1, 1),
> -	[F_READY]		=3D REG_FIELD(FXAS21002C_REG_CTRL1, 0, 0),
> -	[F_INT_CFG_FIFO]	=3D REG_FIELD(FXAS21002C_REG_CTRL2, 7, 7),
> -	[F_INT_EN_FIFO]		=3D REG_FIELD(FXAS21002C_REG_CTRL2, 6, 6),
> -	[F_INT_CFG_RT]		=3D REG_FIELD(FXAS21002C_REG_CTRL2, 5, 5),
> -	[F_INT_EN_RT]		=3D REG_FIELD(FXAS21002C_REG_CTRL2, 4, 4),
> -	[F_INT_CFG_DRDY]	=3D REG_FIELD(FXAS21002C_REG_CTRL2, 3, 3),
> -	[F_INT_EN_DRDY]		=3D REG_FIELD(FXAS21002C_REG_CTRL2, 2, 2),
> -	[F_IPOL]		=3D REG_FIELD(FXAS21002C_REG_CTRL2, 1, 1),
> -	[F_PP_OD]		=3D REG_FIELD(FXAS21002C_REG_CTRL2, 0, 0),
> -	[F_WRAPTOONE]		=3D REG_FIELD(FXAS21002C_REG_CTRL3, 3, 3),
> -	[F_EXTCTRLEN]		=3D REG_FIELD(FXAS21002C_REG_CTRL3, 2, 2),
> -	[F_FS_DOUBLE]		=3D REG_FIELD(FXAS21002C_REG_CTRL3, 0, 0),
> -};
> -
>  extern const struct dev_pm_ops fxas21002c_pm_ops;
> =20
>  int fxas21002c_core_probe(struct device *dev, struct regmap *regmap, int=
 irq,
> diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21=
002c_core.c
> index 89d2bb2282eac..f20033afc714c 100644
> --- a/drivers/iio/gyro/fxas21002c_core.c
> +++ b/drivers/iio/gyro/fxas21002c_core.c
> @@ -42,6 +42,72 @@ enum fxas21002c_mode_state {
> =20
>  #define FXAS21002C_AXIS_TO_REG(axis) (FXAS21002C_REG_OUT_X_MSB + ((axis)=
 * 2))
> =20
> +static const struct reg_field fxas21002c_reg_fields[] =3D {
> +	[F_DR_STATUS]		=3D REG_FIELD(FXAS21002C_REG_STATUS, 0, 7),
> +	[F_OUT_X_MSB]		=3D REG_FIELD(FXAS21002C_REG_OUT_X_MSB, 0, 7),
> +	[F_OUT_X_LSB]		=3D REG_FIELD(FXAS21002C_REG_OUT_X_LSB, 0, 7),
> +	[F_OUT_Y_MSB]		=3D REG_FIELD(FXAS21002C_REG_OUT_Y_MSB, 0, 7),
> +	[F_OUT_Y_LSB]		=3D REG_FIELD(FXAS21002C_REG_OUT_Y_LSB, 0, 7),
> +	[F_OUT_Z_MSB]		=3D REG_FIELD(FXAS21002C_REG_OUT_Z_MSB, 0, 7),
> +	[F_OUT_Z_LSB]		=3D REG_FIELD(FXAS21002C_REG_OUT_Z_LSB, 0, 7),
> +	[F_ZYX_OW]		=3D REG_FIELD(FXAS21002C_REG_DR_STATUS, 7, 7),
> +	[F_Z_OW]		=3D REG_FIELD(FXAS21002C_REG_DR_STATUS, 6, 6),
> +	[F_Y_OW]		=3D REG_FIELD(FXAS21002C_REG_DR_STATUS, 5, 5),
> +	[F_X_OW]		=3D REG_FIELD(FXAS21002C_REG_DR_STATUS, 4, 4),
> +	[F_ZYX_DR]		=3D REG_FIELD(FXAS21002C_REG_DR_STATUS, 3, 3),
> +	[F_Z_DR]		=3D REG_FIELD(FXAS21002C_REG_DR_STATUS, 2, 2),
> +	[F_Y_DR]		=3D REG_FIELD(FXAS21002C_REG_DR_STATUS, 1, 1),
> +	[F_X_DR]		=3D REG_FIELD(FXAS21002C_REG_DR_STATUS, 0, 0),
> +	[F_OVF]			=3D REG_FIELD(FXAS21002C_REG_F_STATUS, 7, 7),
> +	[F_WMKF]		=3D REG_FIELD(FXAS21002C_REG_F_STATUS, 6, 6),
> +	[F_CNT]			=3D REG_FIELD(FXAS21002C_REG_F_STATUS, 0, 5),
> +	[F_MODE]		=3D REG_FIELD(FXAS21002C_REG_F_SETUP, 6, 7),
> +	[F_WMRK]		=3D REG_FIELD(FXAS21002C_REG_F_SETUP, 0, 5),
> +	[F_EVENT]		=3D REG_FIELD(FXAS21002C_REG_F_EVENT, 5, 5),
> +	[FE_TIME]		=3D REG_FIELD(FXAS21002C_REG_F_EVENT, 0, 4),
> +	[F_BOOTEND]		=3D REG_FIELD(FXAS21002C_REG_INT_SRC_FLAG, 3, 3),
> +	[F_SRC_FIFO]		=3D REG_FIELD(FXAS21002C_REG_INT_SRC_FLAG, 2, 2),
> +	[F_SRC_RT]		=3D REG_FIELD(FXAS21002C_REG_INT_SRC_FLAG, 1, 1),
> +	[F_SRC_DRDY]		=3D REG_FIELD(FXAS21002C_REG_INT_SRC_FLAG, 0, 0),
> +	[F_WHO_AM_I]		=3D REG_FIELD(FXAS21002C_REG_WHO_AM_I, 0, 7),
> +	[F_BW]			=3D REG_FIELD(FXAS21002C_REG_CTRL0, 6, 7),
> +	[F_SPIW]		=3D REG_FIELD(FXAS21002C_REG_CTRL0, 5, 5),
> +	[F_SEL]			=3D REG_FIELD(FXAS21002C_REG_CTRL0, 3, 4),
> +	[F_HPF_EN]		=3D REG_FIELD(FXAS21002C_REG_CTRL0, 2, 2),
> +	[F_FS]			=3D REG_FIELD(FXAS21002C_REG_CTRL0, 0, 1),
> +	[F_ELE]			=3D REG_FIELD(FXAS21002C_REG_RT_CFG, 3, 3),
> +	[F_ZTEFE]		=3D REG_FIELD(FXAS21002C_REG_RT_CFG, 2, 2),
> +	[F_YTEFE]		=3D REG_FIELD(FXAS21002C_REG_RT_CFG, 1, 1),
> +	[F_XTEFE]		=3D REG_FIELD(FXAS21002C_REG_RT_CFG, 0, 0),
> +	[F_EA]			=3D REG_FIELD(FXAS21002C_REG_RT_SRC, 6, 6),
> +	[F_ZRT]			=3D REG_FIELD(FXAS21002C_REG_RT_SRC, 5, 5),
> +	[F_ZRT_POL]		=3D REG_FIELD(FXAS21002C_REG_RT_SRC, 4, 4),
> +	[F_YRT]			=3D REG_FIELD(FXAS21002C_REG_RT_SRC, 3, 3),
> +	[F_YRT_POL]		=3D REG_FIELD(FXAS21002C_REG_RT_SRC, 2, 2),
> +	[F_XRT]			=3D REG_FIELD(FXAS21002C_REG_RT_SRC, 1, 1),
> +	[F_XRT_POL]		=3D REG_FIELD(FXAS21002C_REG_RT_SRC, 0, 0),
> +	[F_DBCNTM]		=3D REG_FIELD(FXAS21002C_REG_RT_THS, 7, 7),
> +	[F_THS]			=3D REG_FIELD(FXAS21002C_REG_RT_SRC, 0, 6),
> +	[F_RT_COUNT]		=3D REG_FIELD(FXAS21002C_REG_RT_COUNT, 0, 7),
> +	[F_TEMP]		=3D REG_FIELD(FXAS21002C_REG_TEMP, 0, 7),
> +	[F_RST]			=3D REG_FIELD(FXAS21002C_REG_CTRL1, 6, 6),
> +	[F_ST]			=3D REG_FIELD(FXAS21002C_REG_CTRL1, 5, 5),
> +	[F_DR]			=3D REG_FIELD(FXAS21002C_REG_CTRL1, 2, 4),
> +	[F_ACTIVE]		=3D REG_FIELD(FXAS21002C_REG_CTRL1, 1, 1),
> +	[F_READY]		=3D REG_FIELD(FXAS21002C_REG_CTRL1, 0, 0),
> +	[F_INT_CFG_FIFO]	=3D REG_FIELD(FXAS21002C_REG_CTRL2, 7, 7),
> +	[F_INT_EN_FIFO]		=3D REG_FIELD(FXAS21002C_REG_CTRL2, 6, 6),
> +	[F_INT_CFG_RT]		=3D REG_FIELD(FXAS21002C_REG_CTRL2, 5, 5),
> +	[F_INT_EN_RT]		=3D REG_FIELD(FXAS21002C_REG_CTRL2, 4, 4),
> +	[F_INT_CFG_DRDY]	=3D REG_FIELD(FXAS21002C_REG_CTRL2, 3, 3),
> +	[F_INT_EN_DRDY]		=3D REG_FIELD(FXAS21002C_REG_CTRL2, 2, 2),
> +	[F_IPOL]		=3D REG_FIELD(FXAS21002C_REG_CTRL2, 1, 1),
> +	[F_PP_OD]		=3D REG_FIELD(FXAS21002C_REG_CTRL2, 0, 0),
> +	[F_WRAPTOONE]		=3D REG_FIELD(FXAS21002C_REG_CTRL3, 3, 3),
> +	[F_EXTCTRLEN]		=3D REG_FIELD(FXAS21002C_REG_CTRL3, 2, 2),
> +	[F_FS_DOUBLE]		=3D REG_FIELD(FXAS21002C_REG_CTRL3, 0, 0),
> +};
> +
>  static const int fxas21002c_odr_values[] =3D {
>  	800, 400, 200, 100, 50, 25, 12, 12
>  };

