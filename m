Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A381AEEB9
	for <lists+linux-iio@lfdr.de>; Sat, 18 Apr 2020 16:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgDROaJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Apr 2020 10:30:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgDROaI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Apr 2020 10:30:08 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CDF62070B;
        Sat, 18 Apr 2020 14:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587220207;
        bh=ehGpqlf+WuB6gPvhwQbBerRof0tkD3iElbdpMKVK6NI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H7xKC7dr3iyKDDlUWywl52QnSNjF65bFDuvwT5vh4VOxirF2A7CG5WJG80xA09cZq
         uPErkGIx2uFikY8rxoC+FZ8z5gbmkHl4o5XbM8FVIT9eM3OmwpvLjEwJOQoNrgV1uE
         pkLnBCZcAvtnMvfqEV76LbDHHQdy2E8+DTt9eanc=
Date:   Sat, 18 Apr 2020 15:30:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input@vger.kernel.org,
        Nick Reitemeyer <nick.reitemeyer@web.de>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH 1/3 v3] iio: magnetometer: ak8974: Correct realbits
Message-ID: <20200418153002.62626a88@archlinux>
In-Reply-To: <20200417140521.GB18337@qmqm.qmqm.pl>
References: <20200417114020.31291-1-linus.walleij@linaro.org>
        <20200417140521.GB18337@qmqm.qmqm.pl>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Apr 2020 16:05:21 +0200
Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl> wrote:

> On Fri, Apr 17, 2020 at 01:40:18PM +0200, Linus Walleij wrote:
> > The original AK8974 has 16 bits of actual value, while the
> > HSCDTD008A has 15 bits and the AMI305 and AMI306 has 12 bits.
> > Correct this by providing an extra parameter to the channel
> > macro and define a separate set of channels for each variant
> > of the chip. The resolution is the actual resolution of the
> > internal ADC of the chip.
> >=20
> > The values are stored in a S16 in 2's complement so all 16
> > bits are used for storing (no shifting needed).
> >=20
> > The AMI305, AMI306 and HSCDTD008A valid bits are picked from
> > respective datasheet.
> >=20
> > My best educated guess is that AK8974 is also 12 bits. The
> > AK8973 is an 8 bit and earlier version, and the sibling
> > drivers AMI305 and AMI306 are 12 bits, so it makes sense
> > to assume that the AK8974 is also 12 bits. =20
> [...]
> > -#define AK8974_AXIS_CHANNEL(axis, index)				\
> > +#define AK8974_AXIS_CHANNEL(axis, index, bits)				\
> >  	{								\
> >  		.type =3D IIO_MAGN,					\
> >  		.modified =3D 1,						\
> > @@ -662,16 +662,42 @@ static const struct iio_chan_spec_ext_info ak8974=
_ext_info[] =3D {
> >  		.scan_index =3D index,					\
> >  		.scan_type =3D {						\
> >  			.sign =3D 's',					\
> > -			.realbits =3D 16,					\
> > +			.realbits =3D bits,				\
> >  			.storagebits =3D 16,				\
> >  			.endianness =3D IIO_LE				\
> >  		},							\
> >  	}
> > =20
> > +/*
> > + * We have no datasheet for the AK8974 but we guess that its
> > + * ADC is 12 bits.
> > + */
> >  static const struct iio_chan_spec ak8974_channels[] =3D {
> > -	AK8974_AXIS_CHANNEL(X, 0),
> > -	AK8974_AXIS_CHANNEL(Y, 1),
> > -	AK8974_AXIS_CHANNEL(Z, 2),
> > +	AK8974_AXIS_CHANNEL(X, 0, 12),
> > +	AK8974_AXIS_CHANNEL(Y, 1, 12),
> > +	AK8974_AXIS_CHANNEL(Z, 2, 12),
> > +	IIO_CHAN_SOFT_TIMESTAMP(3),
> > +};
> > +
> > +/*
> > + * The AMI305 and AMI306 have 12 bit ADC resolution according to
> > + * datasheets.
> > + */
> > +static const struct iio_chan_spec ami30x_channels[] =3D {
> > +	AK8974_AXIS_CHANNEL(X, 0, 12),
> > +	AK8974_AXIS_CHANNEL(Y, 1, 12),
> > +	AK8974_AXIS_CHANNEL(Z, 2, 12),
> > +	IIO_CHAN_SOFT_TIMESTAMP(3),
> > +}; =20
>=20
> Maybe call it channels_12bit[] and then you wouldn't need to make
> am exact duplicate for ak8974?

Agreed they should be combined.  I've not problem with just picking
one device name though on a first come first named basis...

Up to you.

Jonathan



>=20
> Best Regards,
> Micha=C5=82 Miros=C5=82aw

