Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 138B11542F8
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 12:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgBFLY5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 06:24:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:58042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbgBFLY5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Feb 2020 06:24:57 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A706E20730;
        Thu,  6 Feb 2020 11:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580988296;
        bh=nveUzTkK3SAXe1XV2O7CxMbqKFRC1dGbyd31nxACb+I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VND0uD4FlfS/1Uavbf+jM+n+nW4tbxmLvBxCDoEey4ltzMh5ovFcNqIAB0HZvptUl
         bib8JMh8q4tOSl94eRmFhxu1BjMEZmhLmK1k38ybIqx2MgnQZxxV6fUsOG6+1IK3WG
         SgjmqlqqAYh+w3lk0wvF9P7/qVclR+pUKl/KwK6Q=
Date:   Thu, 6 Feb 2020 11:24:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Guido =?UTF-8?B?R8O8bnRoZXI=?= <agx@sigxcpu.org>
Cc:     Tomas Novotny <tomas@novotny.cz>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: vcnl4000: Use a single return when getting
 IIO_CHAN_INFO_RAW
Message-ID: <20200206112450.04004361@archlinux>
In-Reply-To: <86e272aaf6726d6d5171445e7f2df6cdbb74057f.1580721204.git.agx@sigxcpu.org>
References: <cover.1580721204.git.agx@sigxcpu.org>
        <86e272aaf6726d6d5171445e7f2df6cdbb74057f.1580721204.git.agx@sigxcpu.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  3 Feb 2020 10:17:01 +0100
Guido G=C3=BCnther <agx@sigxcpu.org> wrote:

> This will be useful when introducing runtime pm.
>=20
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/light/vcnl4000.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index b0e241aaefb4..8f198383626b 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -335,17 +335,18 @@ static int vcnl4000_read_raw(struct iio_dev *indio_=
dev,
>  		switch (chan->type) {
>  		case IIO_LIGHT:
>  			ret =3D data->chip_spec->measure_light(data, val);
> -			if (ret < 0)
> -				return ret;
> -			return IIO_VAL_INT;
> +			if (!ret)
> +				ret =3D IIO_VAL_INT;
> +			break;
>  		case IIO_PROXIMITY:
>  			ret =3D data->chip_spec->measure_proximity(data, val);
> -			if (ret < 0)
> -				return ret;
> -			return IIO_VAL_INT;
> +			if (!ret)
> +				ret =3D IIO_VAL_INT;
> +			break;
>  		default:
> -			return -EINVAL;
> +			ret =3D -EINVAL;
>  		}
> +		return ret;
>  	case IIO_CHAN_INFO_SCALE:
>  		if (chan->type !=3D IIO_LIGHT)
>  			return -EINVAL;

