Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD08227C1
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2019 19:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfESRcW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 May 2019 13:32:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:37306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbfESRcW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 May 2019 13:32:22 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E78B214C6;
        Sun, 19 May 2019 10:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558261606;
        bh=1zR31saxehPnsex0bI+S/uyzkj4IbV2AcviDgFyjyAY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QDQRfaND21P7wsMyDDuUyDGn8uC3Pd+MQ199hpzMvL0lcxzr920C+mKtU79wyWlil
         9Xq2DQESYKE+4MAWJZVohn2oIWoMs7rMalAzuCPP6akKnwpMCa2bGWVTbW3GJ8i7Cz
         Vck/q2rtdZDhVgBxcOZzXo4I8Yu0kAFxedvDCz3U=
Date:   Sun, 19 May 2019 11:26:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?QsOhcmJhcmE=?= Fernandes <barbara.fernandes@usp.br>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Wilson Sales <spoonm@spoonm.org>
Subject: Re: [PATCH 2/2] staging: iio: cdc: ad7150: create macro for
 capacitance channels
Message-ID: <20190519112641.23f05287@archlinux>
In-Reply-To: <20190518224136.16942-3-barbara.fernandes@usp.br>
References: <20190518224136.16942-1-barbara.fernandes@usp.br>
        <20190518224136.16942-3-barbara.fernandes@usp.br>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 18 May 2019 19:41:36 -0300
B=C3=A1rbara Fernandes <barbara.fernandes@usp.br> wrote:

> Create macro for capacitance channels in order to remove the repeated
> code and improve its readability.
>=20
> Signed-off-by: B=C3=A1rbara Fernandes <barbara.fernandes@usp.br>
> Signed-off-by: Wilson Sales <spoonm@spoonm.org>
> Co-developed-by: Wilson Sales <spoonm@spoonm.org>
Not a totally clear cut case given there are only two instances, but
I think, on balance that it is an improvement.

As this isn't really connected to patch 1 in the series (or the fix
going via the other tree) I'll apply this one now.  Please only
send a new version of patch 1.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders (0-day etc) to see if they can find anything
we have missed.

Some time after those test results have come in, I'll push the tree
out as togreg, and in a few weeks send a pull request to Greg to
hopefully have it pulled into his tree which is part of Linux next
and from which he will then send a pull request to Linus in the
next merge window.

Thanks,

Jonathan


> ---
>  drivers/staging/iio/cdc/ad7150.c | 29 ++++++++++++-----------------
>  1 file changed, 12 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/a=
d7150.c
> index 072094227e1b..d8c43cabce25 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -468,24 +468,19 @@ static const struct iio_event_spec ad7150_events[] =
=3D {
>  	},
>  };
> =20
> +#define AD7150_CAPACITANCE_CHAN(_chan)	{			\
> +		.type =3D IIO_CAPACITANCE,			\
> +		.indexed =3D 1,					\
> +		.channel =3D _chan,				\
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |	\
> +		BIT(IIO_CHAN_INFO_AVERAGE_RAW),			\
> +		.event_spec =3D ad7150_events,			\
> +		.num_event_specs =3D ARRAY_SIZE(ad7150_events),	\
> +	}
> +
>  static const struct iio_chan_spec ad7150_channels[] =3D {
> -	{
> -		.type =3D IIO_CAPACITANCE,
> -		.indexed =3D 1,
> -		.channel =3D 0,
> -		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> -		BIT(IIO_CHAN_INFO_AVERAGE_RAW),
> -		.event_spec =3D ad7150_events,
> -		.num_event_specs =3D ARRAY_SIZE(ad7150_events),
> -	}, {
> -		.type =3D IIO_CAPACITANCE,
> -		.indexed =3D 1,
> -		.channel =3D 1,
> -		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> -		BIT(IIO_CHAN_INFO_AVERAGE_RAW),
> -		.event_spec =3D ad7150_events,
> -		.num_event_specs =3D ARRAY_SIZE(ad7150_events),
> -	},
> +	AD7150_CAPACITANCE_CHAN(0),
> +	AD7150_CAPACITANCE_CHAN(1)
>  };
> =20
>  /*

