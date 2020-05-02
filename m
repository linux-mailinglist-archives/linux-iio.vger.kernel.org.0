Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF7F1C2738
	for <lists+linux-iio@lfdr.de>; Sat,  2 May 2020 19:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgEBRTf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 2 May 2020 13:19:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728382AbgEBRTe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 May 2020 13:19:34 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 398E92071E;
        Sat,  2 May 2020 17:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588439973;
        bh=qosBcG3BRg4WRxkSTjRhEFcy1o28piu0+aIZLMBwg/0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WFeLEfrIu1BOu9rxlTSz8x8yKaEICaF9pUs7xIBpFgky6g6ztUgpbdBKzrk+C/8rE
         5UaarWvuDfuPDBHQt37zboOHhC63W5slvStO4RXHReCVYPl0vxVs9HWd3X1XgmItnK
         vCUTxA6knkqYDoC93+067CrcWoOPVVVseyqVWMU0=
Date:   Sat, 2 May 2020 18:19:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [RFC PATCH 4/4] iio: Track enabled channels on a per channel
 basis
Message-ID: <20200502181929.2409dcde@archlinux>
In-Reply-To: <CY4PR03MB3350C865423E5FF97834BD3F99AF0@CY4PR03MB3350.namprd03.prod.outlook.com>
References: <20200424051818.6408-1-alexandru.ardelean@analog.com>
        <20200424051818.6408-5-alexandru.ardelean@analog.com>
        <CY4PR03MB33506FD8C2BF3921FE9BA2DD99D00@CY4PR03MB3350.namprd03.prod.outlook.com>
        <20200426115031.2eb0bb3c@archlinux>
        <CY4PR03MB3350C865423E5FF97834BD3F99AF0@CY4PR03MB3350.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 27 Apr 2020 12:09:18 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org>
> > On Behalf Of Jonathan Cameron
> > Sent: Sonntag, 26. April 2020 12:51
> > To: Sa, Nuno <Nuno.Sa@analog.com>
> > Cc: Ardelean, Alexandru <alexandru.Ardelean@analog.com>; linux-
> > iio@vger.kernel.org; linux-kernel@vger.kernel.org; lars@metafoo.de
> > Subject: Re: [RFC PATCH 4/4] iio: Track enabled channels on a per chann=
el
> > basis
> >=20
> > On Fri, 24 Apr 2020 07:51:05 +0000
> > "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
> >  =20
> > > > From: linux-iio-owner@vger.kernel.org <linux-iio- =20
> > owner@vger.kernel.org> =20
> > > > On Behalf Of Alexandru Ardelean
> > > > Sent: Freitag, 24. April 2020 07:18
> > > > To: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org
> > > > Cc: jic23@kernel.org; lars@metafoo.de; Ardelean, Alexandru
> > > > <alexandru.Ardelean@analog.com>
> > > > Subject: [RFC PATCH 4/4] iio: Track enabled channels on a per chann=
el =20
> > basis =20
> > > >
> > > > From: Lars-Peter Clausen <lars@metafoo.de>
> > > >
> > > > Now that we support multiple channels with the same scan index we c=
an =20
> > no =20
> > > > longer use the scan mask to track which channels have been enabled.
> > > > Otherwise it is not possible to enable channels with the same scan =
index
> > > > independently.
> > > >
> > > > Introduce a new channel mask which is used instead of the scan mask=
 to
> > > > track which channels are enabled. Whenever the channel mask is =20
> > changed a =20
> > > > new scan mask is computed based on it.
> > > >
> > > > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > > > ---
> > > >  drivers/iio/industrialio-buffer.c | 62 +++++++++++++++++++++------=
----
> > > >  drivers/iio/inkern.c              | 19 +++++++++-
> > > >  include/linux/iio/buffer_impl.h   |  3 ++
> > > >  include/linux/iio/consumer.h      |  2 +
> > > >  4 files changed, 64 insertions(+), 22 deletions(-)
> > > >
> > > > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/indust=
rialio- =20
> > buffer.c =20
> > > > index c06691281287..1821a3e32fb3 100644
> > > > --- a/drivers/iio/industrialio-buffer.c
> > > > +++ b/drivers/iio/industrialio-buffer.c
> > > > @@ -216,12 +216,20 @@ int iio_buffer_alloc_scanmask(struct iio_buff=
er
> > > > *buffer,
> > > >  	if (buffer->scan_mask =3D=3D NULL)
> > > >  		return -ENOMEM;
> > > >
> > > > +	buffer->channel_mask =3D bitmap_zalloc(indio_dev->num_channels,
> > > > +					     GFP_KERNEL);
> > > > +	if (buffer->channel_mask =3D=3D NULL) {
> > > > +		bitmap_free(buffer->scan_mask);
> > > > +		return -ENOMEM;
> > > > +	}
> > > > +
> > > >  	return 0;
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(iio_buffer_alloc_scanmask);
> > > >
> > > >  void iio_buffer_free_scanmask(struct iio_buffer *buffer)
> > > >  {
> > > > +	bitmap_free(buffer->channel_mask);
> > > >  	bitmap_free(buffer->scan_mask);
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(iio_buffer_free_scanmask);
> > > > @@ -285,7 +293,7 @@ static ssize_t iio_scan_el_show(struct device =
=20
> > *dev, =20
> > > >
> > > >  	/* Ensure ret is 0 or 1. */
> > > >  	ret =3D !!test_bit(to_iio_dev_attr(attr)->address,
> > > > -		       indio_dev->buffer->scan_mask);
> > > > +		       indio_dev->buffer->channel_mask);
> > > >
> > > >  	return sprintf(buf, "%d\n", ret);
> > > >  }
> > > > @@ -330,11 +338,12 @@ static bool iio_validate_scan_mask(struct =20
> > iio_dev =20
> > > > *indio_dev,
> > > >   * buffers might request, hence this code only verifies that the
> > > >   * individual buffers request is plausible.
> > > >   */
> > > > -static int iio_scan_mask_set(struct iio_dev *indio_dev,
> > > > -		      struct iio_buffer *buffer, int bit)
> > > > +static int iio_channel_mask_set(struct iio_dev *indio_dev,
> > > > +				struct iio_buffer *buffer, int bit)
> > > >  {
> > > >  	const unsigned long *mask;
> > > >  	unsigned long *trialmask;
> > > > +	unsigned int ch;
> > > >
> > > >  	trialmask =3D bitmap_zalloc(indio_dev->masklength, GFP_KERNEL);
> > > >  	if (trialmask =3D=3D NULL)
> > > > @@ -343,8 +352,11 @@ static int iio_scan_mask_set(struct iio_dev
> > > > *indio_dev,
> > > >  		WARN(1, "Trying to set scanmask prior to registering
> > > > buffer\n");
> > > >  		goto err_invalid_mask;
> > > >  	}
> > > > -	bitmap_copy(trialmask, buffer->scan_mask, indio_dev- =20
> > > > >masklength); =20
> > > > -	set_bit(bit, trialmask);
> > > > +
> > > > +	set_bit(bit, buffer->channel_mask);
> > > > +
> > > > +	for_each_set_bit(ch, buffer->channel_mask, indio_dev- =20
> > > > >num_channels) =20
> > > > +		set_bit(indio_dev->channels[ch].scan_index, trialmask); =20
> > >
> > > So, here if the channels all have the same scan_index, we will end up=
 with a =20
> > scan_mask which is =20
> > > different that channel_mask, right? I saw that in our internal driver=
's we =20
> > then just access the =20
> > > channel_mask field directly to know what pieces/channels do we need t=
o =20
> > enable prior to =20
> > > buffering, which implies including buffer_impl.h. =20
> > Given that we handle the demux only at the level of scan elements that
> > won't work in general
> > (even if it wasn't a horrible layering issue). =20
>=20
> Yes, and the driver just adds 16 channels and points all of them to scan_=
index 0. It then
> sets real_bits and the shift so that userspace can get the right channel =
bit. So, in the end
> we have just one buffer/scan element with 16bits. My problem here is more=
 architectural...
> We should not directly include "buffer_impl.h" in drivers...
>=20
> > >
> > > So, for me it would make sense to compute scan_mask so that it will b=
e the =20
> > same as channel_mask =20
> > > (hmm but that would be a problem when computing the buffer size...) a=
nd =20
> > drivers can correctly use =20
> > > ` validate_scan_mask ()` cb. Alternatively, we need to expose =20
> > channel_mask either on a new cb or =20
> > > change the ` validate_scan_mask ()` footprint. =20
> >=20
> > Excellent points. We need to address support for:
> >=20
> > 1) available_scan_mask - if we have complicated rules on mixtures of
> > channels inside
> >    a given buffer element. =20
>=20
> Maybe one solution to expose channel mask is to check if channel_mask !=
=3D scan_mask
> before calling the ` validate_scan_mask()`. If it is, we pass channel_mas=
k to the callback.
> Driver's should then know what to do with it...

That's liable to be flakey as there is no requirement for the scan_mask to
be ordered or indeed not have holes.

>=20
> > 2) channel enabling though I'm sort of inclined to say that if you are =
using this
> > approach
> >    you only get information on channels that make up a scan mask elemen=
t.
> > Tough luck you
> >    may end up enabling more than you'd like. =20
>=20
> Not sure if I'm fully understanding this point. I believe with this appro=
ach channel
> enablement works as before since the core is kind of mapping channel_mask=
 to
> scan_mask. So if we have 16 channels using only 1 scan_element we can sti=
ll
> enable/disable all 16 channels.

Its more subtle than that.  Because of the mux, a number of different chann=
els can
be enabled by different consumers, but all that is exposed to the driver is
the resulting fused scan_mask across all consumers.  It has no idea what ch=
annels
have been enabled if they lie within a scan_mask element.

Hence, whilst there can be individual channel enable and disable attributes
they driver only seems enable and disable of scan mask elements. That means
it needs to turn on ALL of the channels within one scan mask element.
To do anything more complex requires us to carry all the following to the d=
emux
calculator

1) scan_mask
2) channel_mask
3) mapping from channel mask to scan mask

It could be done, but it's potentially nasty.  Even then we don't want to
get into breaking out particular elements within a scan mask element so we'd
end up providing all enabled channels (within each scan mask element)
to the all consumers who are after any of them.

We'd also have to expose the fused channel mask as well as scan mask
to the driver which is not exactly elegant.

That's why I'd suggest initial work uses scan mask as the fundamental
unit of enable / disable, not the channel mask.

Nothing stops then improving that later to deal with the channel mask
fusion needed to work out the enables, but it's not something I'd do
for step 1.

>=20
> In the end, if we have a traditional driver with one channel per scan_ind=
ex, channel_mask
> should be equal to scan_mask. As we start to have more than one channel p=
ointing to the
> same scan_index, these masks will be different.
>=20
> > It might be possible to make switch to using a channel mask but given t=
he
> > channel index is
> > implicit that is going to be at least a little bit nasty.
> >=20
> > How much does it hurt to not have the ability to separately control cha=
nnels
> > within
> > a given buffer element?   Userspace can enable / disable them but reali=
ty is
> > you'll =20
>=20
> As long as we are "ok" with the extra amount of allocated memory, I think=
 it would work.
> Though drivers will have to replicate the same data trough all the enable=
d scan elements...

Hmm. I think we are talking about different things.  Let me give an example.

8 channels in scan mask element 0 size 8 bits, 8 channels in scan mask elem=
ent 1

Enable a channel in scan mask element 0 on consumer 0, and a
different one on consumer 1.  If they were in different scan mask elements
we'd deliver the first element only to consumer 0 and the second element
only to consumer 1 (that's what the demux does for us)

Here, in what I would suggest for the initial implementation, channel mask
is not exposed at all to buffer setup op (update_scan_mask) - so we
don't know which channels in that scan mask element are needed.
Only answer, turn all 8 on.

In this case we would deliver one 8 bit buffer element to each of the consu=
mers
but it would include the values for all 8 channels (but none from the 8 cha=
nnels
in our second scan mask element).

This keeps the channel mask logic (for now) separate from the demux
and the buffered capture setup logic, but at the cost of sampling channels
no one cares about.  Note we often do that anyway as a lot of hardware does
not have per channel enables, or is more efficient if we grab all the chann=
els
in a single transaction.

Jonathan

>=20
> - Nuno S=C3=A1
>=20
> > get data for all the channels in a buffer element if any of them are en=
abled.
> >=20
> > Given the demux will copy the whole element anyway (don't want to waste
> > time doing
> > masking inside an element), userspace might get these extra channels
> > anyway if another
> > consumer has enabled them.
> >=20
> > Jonathan
> >=20
> >  =20
> > >
> > > - Nuno S=C3=A1 =20
>=20

