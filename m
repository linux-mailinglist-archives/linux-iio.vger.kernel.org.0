Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE14476BC8
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 09:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhLPIVO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 16 Dec 2021 03:21:14 -0500
Received: from mslow1.mail.gandi.net ([217.70.178.240]:45335 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhLPIVO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 03:21:14 -0500
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 33BE8D3992
        for <linux-iio@vger.kernel.org>; Thu, 16 Dec 2021 08:16:15 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 9E5CDFF810;
        Thu, 16 Dec 2021 08:15:53 +0000 (UTC)
Date:   Thu, 16 Dec 2021 09:15:52 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 02/10] iio: core: Enhance the kernel doc of modes and
 currentmodes iio_dev entries
Message-ID: <20211216091552.0917520f@xps13>
In-Reply-To: <CA+U=Dsq_HewmCchxauGe6YKpWaNBAb5rP3xvzNQ6K7n7KpbpvA@mail.gmail.com>
References: <20211215151344.163036-1-miquel.raynal@bootlin.com>
        <20211215151344.163036-3-miquel.raynal@bootlin.com>
        <CA+U=Dsq_HewmCchxauGe6YKpWaNBAb5rP3xvzNQ6K7n7KpbpvA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Alexandru,

ardeleanalex@gmail.com wrote on Thu, 16 Dec 2021 08:24:51 +0200:

> On Wed, Dec 15, 2021 at 10:04 PM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> >
> > Let's provide more details about these two variables because their
> > understanding may not be straightforward for someone not used to the IIO
> > subsystem internal logic. The different modes will soon be also be more
> > documented for the same reason.
> >
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  include/linux/iio/iio.h | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > index 06433c2c2968..0312da2e83f8 100644
> > --- a/include/linux/iio/iio.h
> > +++ b/include/linux/iio/iio.h
> > @@ -487,8 +487,14 @@ struct iio_buffer_setup_ops {
> >
> >  /**
> >   * struct iio_dev - industrial I/O device
> > - * @modes:             [DRIVER] operating modes supported by device
> > - * @currentmode:       [INTERN] current operating mode
> > + * @modes:             [DRIVER] list of operating modes supported by the IIO  
> 
> I'd argue that it may make sense to highlight that this list of modes
> is represented as a bitmask.
> When reading docs, it may not be obvious at first (I guess).

That is a good idea. I'll add this to the next iteration.

> > + *                     device, this list should be initialized before
> > + *                     registering the IIO device and can be filed up by the
> > + *                     IIO core depending on the features advertised by the
> > + *                     driver during other steps of the registration
> > + * @currentmode:       [INTERN] operating mode currently in use, may be
> > + *                     eventually checked by device drivers but should be
> > + *                     considered read-only as this is a core internal bit
> >   * @dev:               [DRIVER] device structure, should be assigned a parent
> >   *                     and owner
> >   * @buffer:            [DRIVER] any buffer present
> > --
> > 2.27.0
> >  

Thanks,
Miquèl
