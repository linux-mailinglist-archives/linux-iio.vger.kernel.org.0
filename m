Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0987154264
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 11:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgBFKy3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 05:54:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:50718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727806AbgBFKy3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Feb 2020 05:54:29 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E03D920658;
        Thu,  6 Feb 2020 10:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580986468;
        bh=Sxr16M7dFW1xpT2P06VSa79b/VGwR3IXkmHkQFvqlZc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oYArSKQM8xjIwmiT98AGgLIRYAVgHfzntNLGxd/f7Wqd6yhS7AztKW75uy2CVWwRI
         dxgvXvAvR5vYZgTY3GBgA2Q3I65FAjIkqk5MpktuDpfgffrvZJPaXf+FxsaFCjz+o0
         0QQo9cJ9OruFVLAdycHXb+4DudGCe9ihil42d/HA=
Date:   Thu, 6 Feb 2020 10:54:22 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>,
        Silvan Murer <silvan.murer@gmail.com>
Subject: Re: [PATCH 2/3] iio: dac: ltc2632: drop some duplicated data
Message-ID: <20200206105422.52273454@archlinux>
In-Reply-To: <20200130131549.1170-2-u.kleine-koenig@pengutronix.de>
References: <20200130131549.1170-1-u.kleine-koenig@pengutronix.de>
        <20200130131549.1170-2-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 30 Jan 2020 14:15:48 +0100
Uwe Kleine-K=C3=B6nig         <u.kleine-koenig@pengutronix.de> wrote:

> The channel data for ltc2632l12 and ltc2632h12 are identical. So there
> is no gain in using two different (but identical) channel descriptions.
> The only side effect of this change is some memory savings.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Applied.
> ---
>  drivers/iio/dac/ltc2632.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
> index 643d1ce956ce..7ab92e178496 100644
> --- a/drivers/iio/dac/ltc2632.c
> +++ b/drivers/iio/dac/ltc2632.c
> @@ -192,37 +192,33 @@ static const struct iio_chan_spec_ext_info ltc2632_=
ext_info[] =3D {
>  		LTC2632_CHANNEL(1, _bits), \
>  	}
> =20
> -static DECLARE_LTC2632_CHANNELS(ltc2632l12, 12);
> -static DECLARE_LTC2632_CHANNELS(ltc2632l10, 10);
> -static DECLARE_LTC2632_CHANNELS(ltc2632l8, 8);
> -
> -static DECLARE_LTC2632_CHANNELS(ltc2632h12, 12);
> -static DECLARE_LTC2632_CHANNELS(ltc2632h10, 10);
> -static DECLARE_LTC2632_CHANNELS(ltc2632h8, 8);
> +static DECLARE_LTC2632_CHANNELS(ltc2632x12, 12);
> +static DECLARE_LTC2632_CHANNELS(ltc2632x10, 10);
> +static DECLARE_LTC2632_CHANNELS(ltc2632x8, 8);
> =20
>  static const struct ltc2632_chip_info ltc2632_chip_info_tbl[] =3D {
>  	[ID_LTC2632L12] =3D {
> -		.channels	=3D ltc2632l12_channels,
> +		.channels	=3D ltc2632x12_channels,
>  		.vref_mv	=3D 2500,
>  	},
>  	[ID_LTC2632L10] =3D {
> -		.channels	=3D ltc2632l10_channels,
> +		.channels	=3D ltc2632x10_channels,
>  		.vref_mv	=3D 2500,
>  	},
>  	[ID_LTC2632L8] =3D  {
> -		.channels	=3D ltc2632l8_channels,
> +		.channels	=3D ltc2632x8_channels,
>  		.vref_mv	=3D 2500,
>  	},
>  	[ID_LTC2632H12] =3D {
> -		.channels	=3D ltc2632h12_channels,
> +		.channels	=3D ltc2632x12_channels,
>  		.vref_mv	=3D 4096,
>  	},
>  	[ID_LTC2632H10] =3D {
> -		.channels	=3D ltc2632h10_channels,
> +		.channels	=3D ltc2632x10_channels,
>  		.vref_mv	=3D 4096,
>  	},
>  	[ID_LTC2632H8] =3D  {
> -		.channels	=3D ltc2632h8_channels,
> +		.channels	=3D ltc2632x8_channels,
>  		.vref_mv	=3D 4096,
>  	},
>  };

