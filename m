Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADBB42B2E70
	for <lists+linux-iio@lfdr.de>; Sat, 14 Nov 2020 17:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgKNQ0n (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Nov 2020 11:26:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:56236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgKNQ0n (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Nov 2020 11:26:43 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 887CD2067D;
        Sat, 14 Nov 2020 16:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605371202;
        bh=Um8aplap0SMlqpTrc6I4UxgV+Hi9nm8vXAN0ml1kEmU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NUrJMHqynHI3skhew4VzMIMrIhNGkcxmI59gU0eLnVmaH+WG/DTC09bkzncOOTPzc
         cGMFU9C3BwIZb/+nNySQjFzKjGcddVs0B2kGvv0gQCTYitOZuOADQqc3FM0vfzDWp7
         b1xk5rhuVhGbdAdIz9K1d9HU2JLnOiVrGok0M6DU=
Date:   Sat, 14 Nov 2020 16:26:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: buffer: Fix demux update
Message-ID: <20201114162638.6fbf55a8@archlinux>
In-Reply-To: <CY4PR03MB263146ADC49222DE28BB028999E60@CY4PR03MB2631.namprd03.prod.outlook.com>
References: <20201112144323.28887-1-nuno.sa@analog.com>
        <20201112172821.0000088b@Huawei.com>
        <CY4PR03MB263146ADC49222DE28BB028999E60@CY4PR03MB2631.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Nov 2020 07:55:21 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Sent: Thursday, November 12, 2020 6:28 PM
> > To: Sa, Nuno <Nuno.Sa@analog.com>
> > Cc: linux-iio@vger.kernel.org; Jonathan Cameron <jic23@kernel.org>;
> > Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler
> > <pmeerw@pmeerw.net>
> > Subject: Re: [PATCH] iio: buffer: Fix demux update
> >=20
> >=20
> > On Thu, 12 Nov 2020 15:43:22 +0100
> > Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
> >  =20
> > > When updating the buffer demux, we will skip a scan element from =20
> > the =20
> > > device in the case `in_ind !=3D out_ind` and we enter the while loop.
> > > in_ind should only be refreshed with `find_next_bit()` in the end of =
=20
> > the =20
> > > loop.
> > >
> > > Fixes: 5ada4ea9be16 ("staging:iio: add demux optionally to path from =
=20
> > device to buffer") =20
> > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com> =20
> >=20
> > Yikes that's been there a long time.
> >=20
> > Could you provide an example of a particular layout and the result of
> > this being wrong?
> >  =20
>=20
> Hi Jonathan,
>=20
> Let's say:
>=20
> iio_dev_mask: 0x0111
> buffer_mask: 0x0100
>=20
> We would get out_ind =3D 2 and in_ind =3D 0 and  enter the loop. In the f=
irst
> iteration we call find_next_bit() before doing the in_ind=3D0 computation=
 which means we=20
> will skip it and go directly to bit 1... And if we continue the path flow=
, we see that bit 2 will
> be computed two times, so if we are lucky and scan_index0_len =3D=3D scan=
_index2_len this
> will go unnoticed...
>=20
> Honestly, I didn't test this but it looks one of those things more or les=
s clear by reading
> the code or am I missing something here?

Mostly I was wondering why it hadn't bitten us before.  I think you've iden=
tified
why with your "if we are lucky and scan_index0_len =3D=3D scan_index2_len" =
then this will
go unnoticed.  =20

It's very rare (though not unheard of) for a device to have it's main chann=
els
of different widths (timestamp doesn't matter for this as it is always at t=
he
end).  The demux also only kicks in if we have a restricted channel
mask (or are using a kfifo and a buffer_cb which is rather rare).  I suspect
we have few if any devices that actually run into this problem.

I guess I originally tested this code with devices I had at the time and no=
ne of
them would have tripped this.

Anyhow, whilst I agree with your analysis I'd like to leave this on list for
perhaps another week before applying it on the basis I'm paranoid and would
ideally like a few more eyes on this.

Good spot!

Jonathan

>=20
> - Nuno S=C3=A1
>=20
> > Thanks,
> >=20
> > Jonathan
> >  =20

