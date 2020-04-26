Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641691B8F20
	for <lists+linux-iio@lfdr.de>; Sun, 26 Apr 2020 12:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgDZKug (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Apr 2020 06:50:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgDZKug (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Apr 2020 06:50:36 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B75C2071C;
        Sun, 26 Apr 2020 10:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587898235;
        bh=v4fChj3LpwH4K2rCU498iCs5BoJmqy8Myo+qfvH8RkM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u/FD5Ybr4FiV0nDtwbEJdKBTAgDw3P1AubrDhGR5u7nAwk4Hf50e0Rl+JdNY2E/Ey
         svjQ909AvOWIwz1nGmIdrZvDVsCtvrQkbHjob+RcAnOBAqWDa7OtMeCxqVvP9UAbNe
         5SY8gkzr4dnYCiB+8cegqYkwx59zj6RqRh4lYfC0=
Date:   Sun, 26 Apr 2020 11:50:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [RFC PATCH 4/4] iio: Track enabled channels on a per channel
 basis
Message-ID: <20200426115031.2eb0bb3c@archlinux>
In-Reply-To: <CY4PR03MB33506FD8C2BF3921FE9BA2DD99D00@CY4PR03MB3350.namprd03.prod.outlook.com>
References: <20200424051818.6408-1-alexandru.ardelean@analog.com>
        <20200424051818.6408-5-alexandru.ardelean@analog.com>
        <CY4PR03MB33506FD8C2BF3921FE9BA2DD99D00@CY4PR03MB3350.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 24 Apr 2020 07:51:05 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org>
> > On Behalf Of Alexandru Ardelean
> > Sent: Freitag, 24. April 2020 07:18
> > To: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org
> > Cc: jic23@kernel.org; lars@metafoo.de; Ardelean, Alexandru
> > <alexandru.Ardelean@analog.com>
> > Subject: [RFC PATCH 4/4] iio: Track enabled channels on a per channel b=
asis
> >=20
> > From: Lars-Peter Clausen <lars@metafoo.de>
> >=20
> > Now that we support multiple channels with the same scan index we can no
> > longer use the scan mask to track which channels have been enabled.
> > Otherwise it is not possible to enable channels with the same scan index
> > independently.
> >=20
> > Introduce a new channel mask which is used instead of the scan mask to
> > track which channels are enabled. Whenever the channel mask is changed a
> > new scan mask is computed based on it.
> >=20
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/iio/industrialio-buffer.c | 62 +++++++++++++++++++++----------
> >  drivers/iio/inkern.c              | 19 +++++++++-
> >  include/linux/iio/buffer_impl.h   |  3 ++
> >  include/linux/iio/consumer.h      |  2 +
> >  4 files changed, 64 insertions(+), 22 deletions(-)
> >=20
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrial=
io-buffer.c
> > index c06691281287..1821a3e32fb3 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -216,12 +216,20 @@ int iio_buffer_alloc_scanmask(struct iio_buffer
> > *buffer,
> >  	if (buffer->scan_mask =3D=3D NULL)
> >  		return -ENOMEM;
> >=20
> > +	buffer->channel_mask =3D bitmap_zalloc(indio_dev->num_channels,
> > +					     GFP_KERNEL);
> > +	if (buffer->channel_mask =3D=3D NULL) {
> > +		bitmap_free(buffer->scan_mask);
> > +		return -ENOMEM;
> > +	}
> > +
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(iio_buffer_alloc_scanmask);
> >=20
> >  void iio_buffer_free_scanmask(struct iio_buffer *buffer)
> >  {
> > +	bitmap_free(buffer->channel_mask);
> >  	bitmap_free(buffer->scan_mask);
> >  }
> >  EXPORT_SYMBOL_GPL(iio_buffer_free_scanmask);
> > @@ -285,7 +293,7 @@ static ssize_t iio_scan_el_show(struct device *dev,
> >=20
> >  	/* Ensure ret is 0 or 1. */
> >  	ret =3D !!test_bit(to_iio_dev_attr(attr)->address,
> > -		       indio_dev->buffer->scan_mask);
> > +		       indio_dev->buffer->channel_mask);
> >=20
> >  	return sprintf(buf, "%d\n", ret);
> >  }
> > @@ -330,11 +338,12 @@ static bool iio_validate_scan_mask(struct iio_dev
> > *indio_dev,
> >   * buffers might request, hence this code only verifies that the
> >   * individual buffers request is plausible.
> >   */
> > -static int iio_scan_mask_set(struct iio_dev *indio_dev,
> > -		      struct iio_buffer *buffer, int bit)
> > +static int iio_channel_mask_set(struct iio_dev *indio_dev,
> > +				struct iio_buffer *buffer, int bit)
> >  {
> >  	const unsigned long *mask;
> >  	unsigned long *trialmask;
> > +	unsigned int ch;
> >=20
> >  	trialmask =3D bitmap_zalloc(indio_dev->masklength, GFP_KERNEL);
> >  	if (trialmask =3D=3D NULL)
> > @@ -343,8 +352,11 @@ static int iio_scan_mask_set(struct iio_dev
> > *indio_dev,
> >  		WARN(1, "Trying to set scanmask prior to registering
> > buffer\n");
> >  		goto err_invalid_mask;
> >  	}
> > -	bitmap_copy(trialmask, buffer->scan_mask, indio_dev- =20
> > >masklength); =20
> > -	set_bit(bit, trialmask);
> > +
> > +	set_bit(bit, buffer->channel_mask);
> > +
> > +	for_each_set_bit(ch, buffer->channel_mask, indio_dev- =20
> > >num_channels) =20
> > +		set_bit(indio_dev->channels[ch].scan_index, trialmask); =20
>=20
> So, here if the channels all have the same scan_index, we will end up wit=
h a scan_mask which is
> different that channel_mask, right? I saw that in our internal driver's w=
e then just access the
> channel_mask field directly to know what pieces/channels do we need to en=
able prior to
> buffering, which implies including buffer_impl.h.
Given that we handle the demux only at the level of scan elements that won'=
t work in general
(even if it wasn't a horrible layering issue).

>=20
> So, for me it would make sense to compute scan_mask so that it will be th=
e same as channel_mask
> (hmm but that would be a problem when computing the buffer size...) and d=
rivers can correctly use
> ` validate_scan_mask ()` cb. Alternatively, we need to expose channel_mas=
k either on a new cb or
> change the ` validate_scan_mask ()` footprint.=20

Excellent points. We need to address support for:

1) available_scan_mask - if we have complicated rules on mixtures of channe=
ls inside
   a given buffer element.

2) channel enabling though I'm sort of inclined to say that if you are usin=
g this approach
   you only get information on channels that make up a scan mask element.  =
Tough luck you
   may end up enabling more than you'd like.

It might be possible to make switch to using a channel mask but given the c=
hannel index is
implicit that is going to be at least a little bit nasty.

How much does it hurt to not have the ability to separately control channel=
s within
a given buffer element?   Userspace can enable / disable them but reality i=
s you'll
get data for all the channels in a buffer element if any of them are enable=
d.

Given the demux will copy the whole element anyway (don't want to waste tim=
e doing
masking inside an element), userspace might get these extra channels anyway=
 if another
consumer has enabled them.

Jonathan


>=20
> - Nuno S=C3=A1

