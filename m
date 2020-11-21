Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0282BC00D
	for <lists+linux-iio@lfdr.de>; Sat, 21 Nov 2020 15:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgKUOrq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Nov 2020 09:47:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:37274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728098AbgKUOrp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Nov 2020 09:47:45 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0D7522201;
        Sat, 21 Nov 2020 14:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605970064;
        bh=Cl4E3d2JPq+RWEtQZw6I3IJe+3MOIsFWQMC3attam+M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ASmt0X5x+fFQoqwZ6jgmyyImbqNul1uBJZPdUHLThnJSWxuViJByQLjtHTZ6ONUHp
         Bu/yvX//4/NaOKLPGDaol+pE1WasIoemqK8ByH1FP8RU7zBfxbvX/uSThyHAGLYq2O
         ZDkt63PLgShZPdVZ5sv89MixPBeK8VfY6CcYBo/I=
Date:   Sat, 21 Nov 2020 14:47:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        groeck@chromium.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH v3 7/9] iio: cros_ec: use
 devm_iio_triggered_buffer_setup_ext()
Message-ID: <20201121144739.338dadb3@archlinux>
In-Reply-To: <CA+U=Dsqsz37HD0rjQLemnkOjdLOSBXoyVbpL_8svKS732jA-Uw@mail.gmail.com>
References: <20200929125949.69934-1-alexandru.ardelean@analog.com>
        <20200929125949.69934-8-alexandru.ardelean@analog.com>
        <CAHp75VerL3x7L=AeLfnT6D01a=FyY3JE4vbwNFMaJz-v=f2k9w@mail.gmail.com>
        <CA+U=DsoKM6S+1vrhE6txB-zQLhpJE1St19D_tmHa0=bbqj-g8w@mail.gmail.com>
        <20200929164010.75f191c3@archlinux>
        <CA+U=Dsqsz37HD0rjQLemnkOjdLOSBXoyVbpL_8svKS732jA-Uw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 18 Nov 2020 12:35:16 +0200
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Tue, Sep 29, 2020 at 6:40 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Tue, 29 Sep 2020 17:31:55 +0300
> > Alexandru Ardelean <ardeleanalex@gmail.com> wrote:
> >  
> > > On Tue, Sep 29, 2020 at 4:09 PM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:  
> > > >
> > > > On Tue, Sep 29, 2020 at 3:55 PM Alexandru Ardelean
> > > > <alexandru.ardelean@analog.com> wrote:
> > > >  
> > > > > This change switches to the new devm_iio_triggered_buffer_setup_ext()
> > > > > function and removes the iio_buffer_set_attrs() call, for assigning the
> > > > > HW FIFO attributes to the buffer.  
> > > >
> > > > Sorry, you were too fast with the version, below one nit.
> > > >  
> > > > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > > > > ---
> > > > >  .../common/cros_ec_sensors/cros_ec_sensors_core.c | 15 +++++++++------
> > > > >  1 file changed, 9 insertions(+), 6 deletions(-)
> > > > >
> > > > > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > > > > index c62cacc04672..1eafcf04ad69 100644
> > > > > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > > > > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > > > > @@ -353,19 +353,22 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
> > > > >                         if (ret)
> > > > >                                 return ret;
> > > > >                 } else {
> > > > > +                       const struct attribute **fifo_attrs;
> > > > > +
> > > > > +                       if (has_hw_fifo)
> > > > > +                               fifo_attrs = cros_ec_sensor_fifo_attributes;
> > > > > +                       else
> > > > > +                               fifo_attrs = NULL;
> > > > > +
> > > > >                         /*
> > > > >                          * The only way to get samples in buffer is to set a
> > > > >                          * software trigger (systrig, hrtimer).
> > > > >                          */
> > > > > -                       ret = devm_iio_triggered_buffer_setup(  
> > > >  
> > > > > +                       ret = devm_iio_triggered_buffer_setup_ext(
> > > > >                                         dev, indio_dev, NULL, trigger_capture,
> > > > > -                                       NULL);
> > > > > +                                       NULL, fifo_attrs);  
> > > >
> > > > Perhaps it's time to reformat a bit, i.e. move dev to the first line
> > > > and do the rest accordingly?  
> > >
> > > this feels like a mix of preferences here;
> > > for once, the patch here [as-is], is the minimal form for this change
> > > [in terms of patch-noise];
> > > so, some people would choose the least noisiest patch;
> > >
> > > also, this indentation was chosen [as-is here] from the start [for
> > > this code block];
> > > not sure if it was preferred; i'd suspect it was due to the old 80-col limit;
> > >
> > > i'd leave it as-is [for now], or defer the decision to a maintainer to
> > > decide [either IIO or chromium];  
> >
> > The indenting of this whole code block is a bit too deep.
> >
> > Looks to me like we should flip the sense of the outer if statement
> >
> > if (!physical_device)
> >         return 0;
> >
> > That would lead to a whole bunch of reformatting around here including
> > picking up this.
> >
> > For now I can just shuffle it a bit whilst applying.
> >
> > This set isn't likely to make the merge window anyway now as I'd like
> > it to sit on list a little longer just because it touches several
> > drivers with active maintainers and I'd like time for them to sanity
> > check.
> >  
> 
> ping on this;
> should i do a V4 for this?
Yes, probably worth sending out again. I'd like to see a few more acks
on the individual drivers ideally and a v4 will get this to the
top of peoples' inboxes.

If we don't get them I won't let it block this series, but it's nice
to try at least!

Thanks,

Jonathan

> 
> this is related to the multiple IIO buffer support:
> https://lore.kernel.org/linux-iio/20201117162340.43924-1-alexandru.ardelean@analog.com/T/#t
> 
> it's one of the patchsets i could split away on it's own;
> 
> > Jonathan
> >
> >  
> > >  
> > > >  
> > > > >                         if (ret)
> > > > >                                 return ret;
> > > > > -
> > > > > -                       if (has_hw_fifo)
> > > > > -                               iio_buffer_set_attrs(indio_dev->buffer,
> > > > > -                                                    cros_ec_sensor_fifo_attributes);
> > > > >                 }
> > > > >         }
> > > > >
> > > > > --
> > > > > 2.17.1
> > > > >  
> > > >
> > > >
> > > > --
> > > > With Best Regards,
> > > > Andy Shevchenko  
> >  

