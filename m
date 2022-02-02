Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31504A6CC4
	for <lists+linux-iio@lfdr.de>; Wed,  2 Feb 2022 09:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239168AbiBBIRB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Feb 2022 03:17:01 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:56267 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbiBBIRB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Feb 2022 03:17:01 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6393CC0007;
        Wed,  2 Feb 2022 08:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643789819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=171quQntck/f0EJOEAvbuJglDt8hXUlPvxraF0lIYtM=;
        b=DnMa9+jFrHa+VNRiC3jtlHqynnahHwb4Az9ZKi1nSOiBYI1YaE9vEQxNbyNygw0W71S22e
        tSD9LtuVD3rv39cW1x/wdIpmVGqY+mo+puc3g6V/PFeejeu+/NY0p65FYRNss5hRvgsiaQ
        6WLHpnbOu0zKXX/Tqh7GbBVAcpqavV7FPBqjhxCTYueFk3MWH286K0gK47rP83KQnGDz/u
        6h1LRY8lfWSoHE/FVS+NtUrBFoyqABVHfqbJ3xJx7FeCLXreTYYvzVIdnjk8y+pfqXActj
        HeH9abDhwWlXOnhGCUj5fkqnl5Yp2VQf/U/LYETQbSi3POQ0uRXQBj0CeaScvw==
Date:   Wed, 2 Feb 2022 09:16:58 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 07/10] iio: core: Hide write accesses to
 iio_dev->currentmode
Message-ID: <20220202091658.51edfeac@xps13>
In-Reply-To: <20220115165616.48e34e52@jic23-huawei>
References: <20211215151344.163036-1-miquel.raynal@bootlin.com>
        <20211215151344.163036-8-miquel.raynal@bootlin.com>
        <20220115165616.48e34e52@jic23-huawei>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

jic23@kernel.org wrote on Sat, 15 Jan 2022 16:56:16 +0000:

> On Wed, 15 Dec 2021 16:13:41 +0100
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>=20
> > In order to later move this variable within the opaque structure and now
> > that there is a read-only helper for it, let's create a write helper.
> >=20
> > The idea behind these changes is to limit the temptation of using =20
> > ->currentmode directly, and this will soon be fully addressed by making=
   =20
> > the modification to this variable impossible from a device driver by
> > moving it to the opaque structure. But for now, let's just do a
> > transparent change and use a new helper when ->currentmode needs to be
> > accessed for modifications.
> >=20
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com> =20
>=20
> You can probably guess from my comments on the previous but I'd prefer th=
at
> we don't do this. We don't need an accessor to do the set so let's skip
> doing so.
>=20
> Given next patch makes the write from drivers impossible anyway we don't
> need to do this step.

I personally prefer hiding accesses behind helpers, especially when
there is a move happening, but that's only a personal preference, I'll
drop this helper entirely and limit the use of the getter to
out-of-the-core callers.

> One more thing inline... No need to export the symbol currently (that
> might change if any of the other core modules ever use it but it's not
> needed at this time.

Yeah that is perfectly right, I didn't notice it when writing the patch.

>=20
> > ---
> >  drivers/iio/industrialio-buffer.c |  6 +++---
> >  drivers/iio/industrialio-core.c   | 11 +++++++++++
> >  include/linux/iio/iio.h           |  1 +
> >  3 files changed, 15 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrial=
io-buffer.c
> > index f4dbab7c44fa..190f9cc5fb2c 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -1065,7 +1065,7 @@ static int iio_enable_buffers(struct iio_dev *ind=
io_dev,
> >  	indio_dev->active_scan_mask =3D config->scan_mask;
> >  	indio_dev->scan_timestamp =3D config->scan_timestamp;
> >  	indio_dev->scan_bytes =3D config->scan_bytes;
> > -	indio_dev->currentmode =3D config->mode;
> > +	iio_set_internal_mode(indio_dev, config->mode);
> > =20
> >  	iio_update_demux(indio_dev);
> > =20
> > @@ -1132,7 +1132,7 @@ static int iio_enable_buffers(struct iio_dev *ind=
io_dev,
> >  	if (indio_dev->setup_ops->postdisable)
> >  		indio_dev->setup_ops->postdisable(indio_dev);
> >  err_undo_config:
> > -	indio_dev->currentmode =3D INDIO_DIRECT_MODE;
> > +	iio_set_internal_mode(indio_dev, INDIO_DIRECT_MODE);
> >  	indio_dev->active_scan_mask =3D NULL;
> > =20
> >  	return ret;
> > @@ -1181,7 +1181,7 @@ static int iio_disable_buffers(struct iio_dev *in=
dio_dev)
> > =20
> >  	iio_free_scan_mask(indio_dev, indio_dev->active_scan_mask);
> >  	indio_dev->active_scan_mask =3D NULL;
> > -	indio_dev->currentmode =3D INDIO_DIRECT_MODE;
> > +	iio_set_internal_mode(indio_dev, INDIO_DIRECT_MODE);
> > =20
> >  	return ret;
> >  }
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio=
-core.c
> > index a1d6e30d034a..5c7e0c9e1f59 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -2068,6 +2068,17 @@ int iio_get_internal_mode(struct iio_dev *indio_=
dev)
> >  }
> >  EXPORT_SYMBOL_GPL(iio_get_internal_mode);
> > =20
> > +/**
> > + * iio_set_internal_mode() - helper function providing write-only acce=
ss to the
> > + *			     internal @currentmode variable
> > + * @indio_dev:		IIO device structure for device
> > + **/
> > +void iio_set_internal_mode(struct iio_dev *indio_dev, int mode)
> > +{
> > +	indio_dev->currentmode =3D mode;
> > +}
> > +EXPORT_SYMBOL_GPL(iio_set_internal_mode); =20
>=20
> If we did do this, you don't need to export it as industrialio_buffer and=
 industriaio_core
> are both built into the same module.
>=20
> > +
> >  subsys_initcall(iio_init);
> >  module_exit(iio_exit);
> > =20
> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > index dcab17f44552..27551d251904 100644
> > --- a/include/linux/iio/iio.h
> > +++ b/include/linux/iio/iio.h
> > @@ -679,6 +679,7 @@ struct iio_trigger *devm_iio_trigger_alloc(struct d=
evice *parent,
> >  					   const char *fmt, ...);
> > =20
> >  int iio_get_internal_mode(struct iio_dev *indio_dev);
> > +void iio_set_internal_mode(struct iio_dev *indio_dev, int mode);
> > =20
> >  /**
> >   * iio_buffer_enabled() - helper function to test if the buffer is ena=
bled =20
>=20


Thanks,
Miqu=C3=A8l
