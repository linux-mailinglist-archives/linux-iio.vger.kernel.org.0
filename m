Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEDA48F78C
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jan 2022 16:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbiAOPpr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Jan 2022 10:45:47 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33652 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiAOPpq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Jan 2022 10:45:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5A9AB8006F
        for <linux-iio@vger.kernel.org>; Sat, 15 Jan 2022 15:45:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF67C36AE3;
        Sat, 15 Jan 2022 15:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642261544;
        bh=Sf1NHer2n/l56okfaVD4zqGHx/8rj6SddR6NuW+/QEU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=isg41jA2/qpf5EHT1HhqT7aIcj+1moHZGjrPItwFGFQtKFZoUECpHRYiYkwwg4bhu
         7lyKZt7PEGaNnnZ/51JZq1MFxrhhOLY1uL6wySMS+6R6ABzj0WYDrvYJeNhBuiIbbB
         WIbbAjuS8ZiypNOU1xu0ItnLE+651aAl0Gqeu1f8Oqirq0jE9DM8jCIurDfS4HWuW0
         4FxmwDYJ9Rro9DN9wDKroqAWSFTVLXSEPwDaLOjtS2L2HPQoFIZFRfrTzdWRTu24Wj
         J7mhC64SsFopeQgsaw3qbympsGCGvOE5YPWpcNodAqDo7Q/WoiAfKylCCPENkPKhpd
         aJPVS7u3Wd/Lg==
Date:   Sat, 15 Jan 2022 15:51:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 02/10] iio: core: Enhance the kernel doc of modes and
 currentmodes iio_dev entries
Message-ID: <20220115155145.4f5ec151@jic23-huawei>
In-Reply-To: <20211216091552.0917520f@xps13>
References: <20211215151344.163036-1-miquel.raynal@bootlin.com>
        <20211215151344.163036-3-miquel.raynal@bootlin.com>
        <CA+U=Dsq_HewmCchxauGe6YKpWaNBAb5rP3xvzNQ6K7n7KpbpvA@mail.gmail.com>
        <20211216091552.0917520f@xps13>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Dec 2021 09:15:52 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Alexandru,
>=20
> ardeleanalex@gmail.com wrote on Thu, 16 Dec 2021 08:24:51 +0200:
>=20
> > On Wed, Dec 15, 2021 at 10:04 PM Miquel Raynal
> > <miquel.raynal@bootlin.com> wrote: =20
> > >
> > > Let's provide more details about these two variables because their
> > > understanding may not be straightforward for someone not used to the =
IIO
> > > subsystem internal logic. The different modes will soon be also be mo=
re
> > > documented for the same reason.
> > >
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  include/linux/iio/iio.h | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > > index 06433c2c2968..0312da2e83f8 100644
> > > --- a/include/linux/iio/iio.h
> > > +++ b/include/linux/iio/iio.h
> > > @@ -487,8 +487,14 @@ struct iio_buffer_setup_ops {
> > >
> > >  /**
> > >   * struct iio_dev - industrial I/O device
> > > - * @modes:             [DRIVER] operating modes supported by device
> > > - * @currentmode:       [INTERN] current operating mode
> > > + * @modes:             [DRIVER] list of operating modes supported by=
 the IIO   =20
> >=20
> > I'd argue that it may make sense to highlight that this list of modes
> > is represented as a bitmask.
> > When reading docs, it may not be obvious at first (I guess). =20
>=20
> That is a good idea. I'll add this to the next iteration.

Good.

>=20
> > > + *                     device, this list should be initialized before
> > > + *                     registering the IIO device and can be filed u=
p by the
> > > + *                     IIO core depending on the features advertised=
 by the
> > > + *                     driver during other steps of the registration

Perhaps make it a little clearer that some bits are set as a result of
enabling particular features.  Maybe even call out which functions do it.
=46rom what I recall, that's a very short list.

> > > + * @currentmode:       [INTERN] operating mode currently in use, may=
 be
> > > + *                     eventually checked by device drivers but shou=
ld be
> > > + *                     considered read-only as this is a core intern=
al bit

We should add an accessor function to read it.  (maybe later in your series=
? :)

> > >   * @dev:               [DRIVER] device structure, should be assigned=
 a parent
> > >   *                     and owner
> > >   * @buffer:            [DRIVER] any buffer present
> > > --
> > > 2.27.0
> > >   =20
>=20
> Thanks,
> Miqu=C3=A8l

