Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F742C7554
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732332AbgK1VtX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:46390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729414AbgK1S0z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Nov 2020 13:26:55 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6DE1246B7;
        Sat, 28 Nov 2020 15:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606578611;
        bh=IfftN0dR9Tkdvkb2rK5sv4Mu/EaSXV2+K2BEqn8JYnk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0wJ3aocbPTsVMTJR6ofukOEdXhGT7cYflHl9sVbcipM5LL6KNjRS1TsAzs6/+Ktyy
         kr04ZCySfXZBS/srHdw1yFjXyrI3aE1JQW9A6cQuknCgvxmDtFoZ4g6QdMQa05ERH6
         7iAtwEUtQAYyji1aYl7IVDAhYM+yQBt1SESIgyOo=
Date:   Sat, 28 Nov 2020 15:50:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: buffer: Fix demux update
Message-ID: <20201128155006.04f05fef@archlinux>
In-Reply-To: <20201114162638.6fbf55a8@archlinux>
References: <20201112144323.28887-1-nuno.sa@analog.com>
        <20201112172821.0000088b@Huawei.com>
        <CY4PR03MB263146ADC49222DE28BB028999E60@CY4PR03MB2631.namprd03.prod.outlook.com>
        <20201114162638.6fbf55a8@archlinux>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 14 Nov 2020 16:26:38 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 13 Nov 2020 07:55:21 +0000
> "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > > Sent: Thursday, November 12, 2020 6:28 PM
> > > To: Sa, Nuno <Nuno.Sa@analog.com>
> > > Cc: linux-iio@vger.kernel.org; Jonathan Cameron <jic23@kernel.org>;
> > > Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler
> > > <pmeerw@pmeerw.net>
> > > Subject: Re: [PATCH] iio: buffer: Fix demux update
> > >=20
> > >=20
> > > On Thu, 12 Nov 2020 15:43:22 +0100
> > > Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
> > >    =20
> > > > When updating the buffer demux, we will skip a scan element from   =
=20
> > > the   =20
> > > > device in the case `in_ind !=3D out_ind` and we enter the while loo=
p.
> > > > in_ind should only be refreshed with `find_next_bit()` in the end o=
f   =20
> > > the   =20
> > > > loop.
> > > >
> > > > Fixes: 5ada4ea9be16 ("staging:iio: add demux optionally to path fro=
m   =20
> > > device to buffer")   =20
> > > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>   =20
> > >=20
> > > Yikes that's been there a long time.
> > >=20
> > > Could you provide an example of a particular layout and the result of
> > > this being wrong?
> > >    =20
> >=20
> > Hi Jonathan,
> >=20
> > Let's say:
> >=20
> > iio_dev_mask: 0x0111
> > buffer_mask: 0x0100
> >=20
> > We would get out_ind =3D 2 and in_ind =3D 0 and  enter the loop. In the=
 first
> > iteration we call find_next_bit() before doing the in_ind=3D0 computati=
on which means we=20
> > will skip it and go directly to bit 1... And if we continue the path fl=
ow, we see that bit 2 will
> > be computed two times, so if we are lucky and scan_index0_len =3D=3D sc=
an_index2_len this
> > will go unnoticed...
> >=20
> > Honestly, I didn't test this but it looks one of those things more or l=
ess clear by reading
> > the code or am I missing something here? =20
>=20
> Mostly I was wondering why it hadn't bitten us before.  I think you've id=
entified
> why with your "if we are lucky and scan_index0_len =3D=3D scan_index2_len=
" then this will
> go unnoticed.  =20
>=20
> It's very rare (though not unheard of) for a device to have it's main cha=
nnels
> of different widths (timestamp doesn't matter for this as it is always at=
 the
> end).  The demux also only kicks in if we have a restricted channel
> mask (or are using a kfifo and a buffer_cb which is rather rare).  I susp=
ect
> we have few if any devices that actually run into this problem.
>=20
> I guess I originally tested this code with devices I had at the time and =
none of
> them would have tripped this.
>=20
> Anyhow, whilst I agree with your analysis I'd like to leave this on list =
for
> perhaps another week before applying it on the basis I'm paranoid and wou=
ld
> ideally like a few more eyes on this.
>=20
Ah well. I'll take silence as meaning either everyone is happy or no
one else is going to read it ;)

Applied with a bit more text in the description to highlight that,
whilst a bug, it's actually not a common situation.

Given timing I've applied this to the togreg branch of iio.git
ready for the next merge window.

thanks,

Jonathan

> Good spot!
>=20
> Jonathan
>=20
> >=20
> > - Nuno S=C3=A1
> >  =20
> > > Thanks,
> > >=20
> > > Jonathan
> > >    =20
>=20

