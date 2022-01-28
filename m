Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AD449FC3C
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jan 2022 15:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343537AbiA1O4u (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Jan 2022 09:56:50 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:55179 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245578AbiA1O4r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Jan 2022 09:56:47 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1D026100015;
        Fri, 28 Jan 2022 14:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643381805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TVfawNb8/rB/bxCTxT2oK4tA0DYWVmfmQBDpSOezWEw=;
        b=WKSGNDvZiL8Utl2HY58MmWy8zfHUhNiziE4cgCbaQBkniP5ZUtCjFazTadIkK1XlNRDnWW
        7I/4mI2SQyhB33UckpwGm76KtOlZKqjt0wkMbk8WB4S9+VxFCnoSD+jFkDwtImn07Gz5cr
        NuzXIhffAhT4xIf1bpxcovPkLUjw0Hfl+YxOblOf/9dvRx2paRPwazwE0Ozhp6TWrMqtQ6
        oaRzRz9r3RG0bNU7YtR6yiCGZo7Cs4ttuBx+xpClhy9d4FJtAKNkFU0MUkMaZawBl7IDzP
        XagZd10JwC3PzgKzuC4Z4tqqA5THQJXBesNLB31gRYfmd1ytHpM65LzPhcYh0A==
Date:   Fri, 28 Jan 2022 15:56:37 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 02/10] iio: core: Enhance the kernel doc of modes and
 currentmodes iio_dev entries
Message-ID: <20220128155637.05147239@xps13>
In-Reply-To: <20220115155145.4f5ec151@jic23-huawei>
References: <20211215151344.163036-1-miquel.raynal@bootlin.com>
        <20211215151344.163036-3-miquel.raynal@bootlin.com>
        <CA+U=Dsq_HewmCchxauGe6YKpWaNBAb5rP3xvzNQ6K7n7KpbpvA@mail.gmail.com>
        <20211216091552.0917520f@xps13>
        <20220115155145.4f5ec151@jic23-huawei>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

jic23@kernel.org wrote on Sat, 15 Jan 2022 15:51:45 +0000:

> On Thu, 16 Dec 2021 09:15:52 +0100
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>=20
> > Hi Alexandru,
> >=20
> > ardeleanalex@gmail.com wrote on Thu, 16 Dec 2021 08:24:51 +0200:
> >  =20
> > > On Wed, Dec 15, 2021 at 10:04 PM Miquel Raynal
> > > <miquel.raynal@bootlin.com> wrote:   =20
> > > >
> > > > Let's provide more details about these two variables because their
> > > > understanding may not be straightforward for someone not used to th=
e IIO
> > > > subsystem internal logic. The different modes will soon be also be =
more
> > > > documented for the same reason.
> > > >
> > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > ---
> > > >  include/linux/iio/iio.h | 10 ++++++++--
> > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > > > index 06433c2c2968..0312da2e83f8 100644
> > > > --- a/include/linux/iio/iio.h
> > > > +++ b/include/linux/iio/iio.h
> > > > @@ -487,8 +487,14 @@ struct iio_buffer_setup_ops {
> > > >
> > > >  /**
> > > >   * struct iio_dev - industrial I/O device
> > > > - * @modes:             [DRIVER] operating modes supported by device
> > > > - * @currentmode:       [INTERN] current operating mode
> > > > + * @modes:             [DRIVER] list of operating modes supported =
by the IIO     =20
> > >=20
> > > I'd argue that it may make sense to highlight that this list of modes
> > > is represented as a bitmask.
> > > When reading docs, it may not be obvious at first (I guess).   =20
> >=20
> > That is a good idea. I'll add this to the next iteration. =20
>=20
> Good.

Done.

>=20
> >  =20
> > > > + *                     device, this list should be initialized bef=
ore
> > > > + *                     registering the IIO device and can be filed=
 up by the
> > > > + *                     IIO core depending on the features advertis=
ed by the
> > > > + *                     driver during other steps of the registrati=
on =20
>=20
> Perhaps make it a little clearer that some bits are set as a result of
> enabling particular features.  Maybe even call out which functions do it.
> From what I recall, that's a very short list.

Done.

>=20
> > > > + * @currentmode:       [INTERN] operating mode currently in use, m=
ay be
> > > > + *                     eventually checked by device drivers but sh=
ould be
> > > > + *                     considered read-only as this is a core inte=
rnal bit =20
>=20
> We should add an accessor function to read it.  (maybe later in your seri=
es? :)

Yup!

>=20
> > > >   * @dev:               [DRIVER] device structure, should be assign=
ed a parent
> > > >   *                     and owner
> > > >   * @buffer:            [DRIVER] any buffer present
> > > > --
> > > > 2.27.0
> > > >     =20
> >=20
> > Thanks,
> > Miqu=C3=A8l =20
>=20


Thanks,
Miqu=C3=A8l
