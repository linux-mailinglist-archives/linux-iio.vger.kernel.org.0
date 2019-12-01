Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 360AF10E1C8
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2019 13:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfLAMKe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Dec 2019 07:10:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:50580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfLAMKe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Dec 2019 07:10:34 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C46E620725;
        Sun,  1 Dec 2019 12:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575202233;
        bh=TCN3a70UHSC4otm7f4c00Voc64ZxXYntmJgLHPKRQPQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CsGk9D9b5kB2P3LNLE4LR2AZcnDCIkgpBEUhMT6lMTepIWSAh4XlKm40AM4T4Ijvd
         DnOtOWurXKFN7jFkUxjw0BeDV0VrBffDD9gyi5IqrjY6FAolWj5sjIFVLyO6lyp4Wn
         maJ/QXol0aewOV7tMOR6+nTIn8zrJJjThw4J9kzk=
Date:   Sun, 1 Dec 2019 12:10:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Lars =?UTF-8?B?TcO2bGxlbmRvcmY=?= <lars.moellendorf@plating.de>,
        linux-iio@vger.kernel.org
Subject: Re: iio_compute_scan_bytes does not seem to account for alignment
 if first channel uses more storagebits than its successors
Message-ID: <20191201121029.6addd974@archlinux>
In-Reply-To: <fef18238-85cc-00e7-ee7d-a52c62509c22@metafoo.de>
References: <ff5a3ea4-4d15-5be3-9cb8-9fd7c716e2e6@plating.de>
        <fef18238-85cc-00e7-ee7d-a52c62509c22@metafoo.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 29 Nov 2019 18:23:37 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 11/29/19 3:30 PM, Lars M=C3=B6llendorf wrote:
> > Hi,
> >=20
> > I have written a custom kernel module implementing the IIO device API
> > backed by an IIO triggered buffer.
> >=20
> > My IIO device provides 3 channels + timestamp. The sizes of the channel=
s are
> >=20
> > index  | iio_chan_spec.scan_type.storagebits
> > -------|------------------------------------------------
> >    0   |  32
> >    1   |  16
> >    2   |  16
> >=20
> > If I select channel 0 (32bit) and one of channel 1 or 2 (16bit)
> > indio_dev.scan_bytes and iio_buffer.bytes_per_datum have a value of 6
> > Byte which does not account for any alignment.
> >=20
> >=20
> > After having a closer look at  `iio_compute_scan_bytes` which is
> > responsible for calculating both, `indio_dev.scan_bytes` and
> > `iio_buffer.bytes_per_datum` it seems to me that the order of channels
> > matter:
> >=20
> > ```c
> > 	/* How much space will the demuxed element take? */
> > 	for_each_set_bit(i, mask,
> > 			 indio_dev->masklength) {
> > 		length =3D iio_storage_bytes_for_si(indio_dev, i);
> > 		bytes =3D ALIGN(bytes, length);
> > 		bytes +=3D length;
> > 	}
> > ```
> >=20
> > I understand that in case the length of each scan element is smaller
> > then the length of the successive scan elements, this algorithm works
> > because it aligns the current element to its own length. But if, as in
> > my case, the length of channel 0's scan elements  is greater then the
> > size of the samples of the consecutive channels no alignment seems to be
> > taken into account. Do I miss something here? =20
> [...]
> > But in my case the latter would bloat the buffer from 16 Byte to 4*16 =
=3D
> > 64 Byte per scan if all channels are selected and timestamp is active.
> >=20
> > For now, I will work around this by using 32 storagebits for all my
> > channels. This gives my 4 Bytes of overhead per scan if all elements are
> > selected and additional 2 Byte if timestamp is active.
> >=20
> > In "Why do you align the buffer pointer to a multiple of the size of the
> > current scan element in iio_buffer_foreach_sample()?" on
> > https://github.com/analogdevicesinc/libiio/issues/324 I have been
> > pointed to this mailing list. =20
>=20
> Hi Lars,
I managed to crash my email client whilst sending a first reply to this
so no idea if anyone got it!
>=20
> The way this is supposed to work is that each element is aligned to its
> own natural alignment. What seems to be missing at the moment is that
> the total length is also aligned to the size of the first element, so
> that alignment is preserved for multiple consecutive samples. I feel
> like we had that at some point, but maybe I'm misremembering.

It's more than possible we broke this in a cleanup at some stage
and a bit surprising it hasn't caused problems before as we definitely
have other sensors with similar channel patterns. I guess maybe they
always have the timestamp enabled.

Good spot by the way.

>=20
> E.g. putting something like
>=20
>  unsigned int first_index =3D find_first_bit(mask, indio_dev->masklength);
>  length =3D iio_storage_bytes_for_si(indio_dev, first_index);
>  bytes =3D ALIGN(bytes, length);
>=20
> below the loop should do the trick I believe.
It would work for Lars case, but I think a combination of both approaches
is needed to handle cases like

u16
u16 (may be padding)
u32
u16

We need to realign to the largest sized element whereever it occurs in the
channels list.  So find that whilst computing the individual alignments,
and apply it only once at the end.

Thanks,

Jonathan

>=20
> - Lars
>=20

