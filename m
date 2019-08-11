Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70083890B5
	for <lists+linux-iio@lfdr.de>; Sun, 11 Aug 2019 10:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbfHKIn3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Aug 2019 04:43:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbfHKIn3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Aug 2019 04:43:29 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B3302085B;
        Sun, 11 Aug 2019 08:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565513008;
        bh=Uz7UmkDTB6qXO93AGoCGWU8AydoXx37sRXoooqBiQa0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oeJ2in80mLxzLAcvOQcFuEU5/iKREKQza9/XYf9WyptF/ARMYv4sB7xnNfPgdcGOh
         Ah3QhwohPYQZ62kEGE8dbPAu/lxRP2zArFolU5EPpyyx8I5uMcmcdvkXb8oX0d86ot
         fCRd9Yyvn5MwRoP5sIq01bIflWU0H4E3LtlAQhjg=
Date:   Sun, 11 Aug 2019 09:43:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rodrigo <rodrigorsdc@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH] staging: iio: accel: adis16240: Improve readability on
 write_raw function
Message-ID: <20190811094322.063ad682@archlinux>
In-Reply-To: <20190810150058.3509-1-rodrigorsdc@gmail.com>
References: <20190810150058.3509-1-rodrigorsdc@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 10 Aug 2019 12:00:58 -0300
Rodrigo <rodrigorsdc@gmail.com> wrote:

> From: Rodrigo Carvalho <rodrigorsdc@gmail.com>
>=20
> Improve readability by using GENMASK macro, changing switch statement
> by if statement and removing unnecessary local variables.

=46rom your description it sounds like multiple changes in one patch.
Always preferable to have one type of change in a patch and more
small patches.

Based on comments below, I would leave the switch statement alone,
but put in your GENMASK change as that one is good and gets
rid of the odd local variable 'bits' as well :)

Thanks,

Jonathan


>=20
> Signed-off-by: Rodrigo Ribeiro Carvalho <rodrigorsdc@gmail.com>
> ---
>  drivers/staging/iio/accel/adis16240.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/=
accel/adis16240.c
> index 62f4b3b1b457..68f165501389 100644
> --- a/drivers/staging/iio/accel/adis16240.c
> +++ b/drivers/staging/iio/accel/adis16240.c
> @@ -309,17 +309,15 @@ static int adis16240_write_raw(struct iio_dev *indi=
o_dev,
>  			       long mask)
>  {
>  	struct adis *st =3D iio_priv(indio_dev);
> -	int bits =3D 10;
> -	s16 val16;
> +	int m;
>  	u8 addr;
> =20
> -	switch (mask) {
> -	case IIO_CHAN_INFO_CALIBBIAS:
> -		val16 =3D val & ((1 << bits) - 1);
> -		addr =3D adis16240_addresses[chan->scan_index][0];
> -		return adis_write_reg_16(st, addr, val16);
> -	}
> -	return -EINVAL;
> +	if (mask !=3D IIO_CHAN_INFO_CALIBBIAS)
> +		return -EINVAL;

Hmm. We generally encourage the use of switch statements in these
cases because they reduce churn as new features are added.

In this particular case, we don't have any control of sampling frequency
in the driver, but the hardware appears to support it (table 23 on the
datasheet).


> +
> +	m =3D GENMASK(9, 0);
> +	addr =3D adis16240_addresses[chan->scan_index][0];
> +	return adis_write_reg_16(st, addr, val & m);
Why the local variable m?  Can we not just do

	return adis_write_reg_16(st, addr, val & GENMASK(9, 0));

If anything I think that is a little more readable than your
version.  There is a reasonable argument for just having
addr inline as well.=20

	return adis_write_reg_16(st,
			         adis16240_addresses[chan->scan_index][0],
				 val & GENMASK(9, 0));

However, given I'm suggesting you leave it as a switch statement, it
will be too long with addr inline.

>  }
> =20
>  static const struct iio_chan_spec adis16240_channels[] =3D {

