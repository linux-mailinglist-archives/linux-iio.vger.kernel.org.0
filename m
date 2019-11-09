Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8A6BF5EE4
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2019 13:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfKIMLz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Nov 2019 07:11:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:39610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbfKIMLz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Nov 2019 07:11:55 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F08C21882;
        Sat,  9 Nov 2019 12:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573301513;
        bh=HpjFC1WhaeBcOBbfvT8WSD8RRNNEKAwA+lR+SDS1ooo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1+/ryKk8NGYGXQq2LU6Fma5NAqS6FqzEMSIh3q7H+bkUivmJD+MbgrBeZFYUicB+x
         M995n5HY/bsZ6Xwi6x163vofFUpYSfONenLHvGC2jBHVb4FqtTKGY2HSFDNISZckXG
         Au6s0V7Pz3Xzqqe4UZY6Mk9F+hoxVzsi+k0fA4AQ=
Date:   Sat, 9 Nov 2019 12:11:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "martenli@axis.com" <martenli@axis.com>
Subject: Re: [PATCH] iio:adc:ti-adc084s021: Endian casting tidy ups.
Message-ID: <20191109121149.4ffec6bb@archlinux>
In-Reply-To: <a07e927d00802115b17a5b01a3b0db245e776d7e.camel@analog.com>
References: <20191013094722.1429243-1-jic23@kernel.org>
        <a07e927d00802115b17a5b01a3b0db245e776d7e.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 4 Nov 2019 15:08:12 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sun, 2019-10-13 at 10:47 +0100, jic23@kernel.org wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >=20
> > Highlighted by sparse:
> > CHECK   drivers/iio/adc/ti-adc084s021.c
> > drivers/iio/adc/ti-adc084s021.c:79:26: warning: incorrect type in
> > assignment (different base types)
> > drivers/iio/adc/ti-adc084s021.c:79:26:    expected unsigned short
> > [unsigned] [short] [usertype] <noident>
> > drivers/iio/adc/ti-adc084s021.c:79:26:    got restricted __be16 <noiden=
t>
> > drivers/iio/adc/ti-adc084s021.c:110:24: warning: cast to restricted
> > __be16
> > drivers/iio/adc/ti-adc084s021.c:110:24: warning: cast to restricted
> > __be16
> > drivers/iio/adc/ti-adc084s021.c:110:24: warning: cast to restricted
> > __be16
> > drivers/iio/adc/ti-adc084s021.c:110:24: warning: cast to restricted
> > __be16
> >  =20
>=20
Thanks for looking at this. I'd missed entirely that a void *
was hiding some more nastiness!

> This one looks a bit tricky.
> And looks like it could use a bit more cleanup than this.
> Otherwise sparse may come along and complain about more stuff.
>=20
> One thing that would be good, would be to change:
>=20
> int adc084s021_adc_conversion(struct adc084s021 *adc, void *data)
>=20
> to
>=20
> int adc084s021_adc_conversion(struct adc084s021 *adc, __be16 *data, int
> buf_size)   [1]
>=20
>=20
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: M=C3=A5rten Lindahl <martenli@axis.com>
> > ---
> >  drivers/iio/adc/ti-adc084s021.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-
> > adc084s021.c
> > index bdedf456ee05..42966f2eb3d8 100644
> > --- a/drivers/iio/adc/ti-adc084s021.c
> > +++ b/drivers/iio/adc/ti-adc084s021.c
> > @@ -68,7 +68,7 @@ static int adc084s021_adc_conversion(struct adc084s021
> > *adc, void *data)
> >  {
> >  	int n_words =3D (adc->spi_trans.len >> 1) - 1; /* Discard first word
> > */
> >  	int ret, i =3D 0;
> > -	u16 *p =3D data;
> > +	__be16 *p =3D data;
> > =20
> >  	/* Do the transfer */
> >  	ret =3D spi_sync(adc->spi, &adc->message);
> > @@ -87,6 +87,7 @@ static int adc084s021_read_raw(struct iio_dev
> > *indio_dev,
> >  {
> >  	struct adc084s021 *adc =3D iio_priv(indio_dev);
> >  	int ret;
> > +	__be16 value;
> > =20
> >  	switch (mask) {
> >  	case IIO_CHAN_INFO_RAW:
> > @@ -101,13 +102,13 @@ static int adc084s021_read_raw(struct iio_dev
> > *indio_dev,
> >  		}
> > =20
> >  		adc->tx_buf[0] =3D channel->channel << 3;
> > -		ret =3D adc084s021_adc_conversion(adc, val);
> > +		ret =3D adc084s021_adc_conversion(adc, &value); =20
>=20
> Following [1], this could be called with  "adc084s021_adc_conversion(adc,
> &value, 1)" to make sure it's not doing any stack corruption. I can't tell
> if this is doing any or not; the code is a bit fuzzy to me.

I'm fairly sure current code is safe as IIO_CHAN_INFO_RAW reads occur
with protection against buffered mode and when not in buffered mode the
magic length is 4 which is divided by 2 and has 1 subtracted giving a
safe value of 1.  This dance is ensure there is only one place where
the length is recorded and avoid recomputing it in *_buffer_trigger_handler.
We could stash it in the private data though for easier to read code.

Agreed that the type change to __be16 * definitely makes sense though.
Will respin with that.

>=20
> The neat part is that memcpy() could be used to then access the data on
> rx_buf.

We could do that, but as it's not part of the fix really I'd rather leave
that for another day.  Not sure anything stops us doing this whilst doing
this tidy up even without passing in the size.

Thanks,

Jonathan

>=20
>=20
> >  		iio_device_release_direct_mode(indio_dev);
> >  		regulator_disable(adc->reg);
> >  		if (ret < 0)
> >  			return ret;
> > =20
> > -		*val =3D be16_to_cpu(*val);
> > +		*val =3D be16_to_cpu(value);
> >  		*val =3D (*val >> channel->scan_type.shift) & 0xff;
> > =20
> >  		return IIO_VAL_INT; =20

