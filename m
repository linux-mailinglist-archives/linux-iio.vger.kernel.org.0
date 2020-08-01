Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C332352DA
	for <lists+linux-iio@lfdr.de>; Sat,  1 Aug 2020 16:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgHAOwp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Aug 2020 10:52:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgHAOwo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Aug 2020 10:52:44 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91FD32071E;
        Sat,  1 Aug 2020 14:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596293564;
        bh=4S0kIiBlEp7ju38+PP8R+cgjFKqK5pJylWhbCNVeObU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P6CLjjBtrCsK6bjdoyX69reUFmz2dXUAsQVqqeJtkaW/qvTE4ZBOpOIfSXXJC7orj
         DcvVq3KcWB6AsLT/kwxh0IiafnL+MuaKUEGPTy8w9mSwYCN7mLypVBgBzTMfDTUWGi
         B/h5PFEhdtmsc8GWrePbowubqiybkYegqwhPedi4=
Date:   Sat, 1 Aug 2020 15:52:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Daniel Campello <campello@chromium.org>,
        LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 06/15] iio: sx9310: Fixes various memory handling
Message-ID: <20200801155239.463917db@archlinux>
In-Reply-To: <CAHp75VeMGtnhCEuMODNO3K6JfFTbm=gLr4yZdZHV-JsBW0eS_A@mail.gmail.com>
References: <20200731164853.3020946-1-campello@chromium.org>
        <20200731104555.v3.6.I8accffd77d616cb55b29bc3021cb0f5e1da3b68a@changeid>
        <CAHp75VeMGtnhCEuMODNO3K6JfFTbm=gLr4yZdZHV-JsBW0eS_A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 31 Jul 2020 22:24:47 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Jul 31, 2020 at 7:49 PM Daniel Campello <campello@chromium.org> wrote:
> >
> > Makes use __aligned(8) to ensure that the timestamp is correctly aligned
> > when we call io_push_to_buffers_with_timestamp().
> > Also makes use of sizeof() for regmap_bulk_read instead of static value.  
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> > Signed-off-by: Daniel Campello <campello@chromium.org>
> > ---
> >
> > Changes in v3:
> >  - Changed buffer to struct type to align timestamp memory properly.
> >
> > Changes in v2:
> >  - Fixed commit message from "iio: sx9310: Align memory"
> >
> >  drivers/iio/proximity/sx9310.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> > index 2ed062d01634bc..c46584b4817b4a 100644
> > --- a/drivers/iio/proximity/sx9310.c
> > +++ b/drivers/iio/proximity/sx9310.c
> > @@ -132,8 +132,11 @@ struct sx9310_data {
> >          */
> >         bool prox_stat[SX9310_NUM_CHANNELS];
> >         bool trigger_enabled;
> > -       __be16 buffer[SX9310_NUM_CHANNELS +
> > -                     4]; /* 64-bit data + 64-bit timestamp */
> > +       /* Ensure correct alignment of timestamp when present. */
> > +       struct {
> > +               __be16 channels[SX9310_NUM_CHANNELS];
> > +               s64 ts __aligned(8);
> > +       } buffer;
> >         /* Remember enabled channels and sample rate during suspend. */
> >         unsigned int suspend_ctrl0;
> >         struct completion completion;
> > @@ -346,7 +349,7 @@ static int sx9310_read_prox_data(struct sx9310_data *data,
> >         if (ret < 0)
> >                 return ret;
> >
> > -       return regmap_bulk_read(data->regmap, chan->address, val, 2);
> > +       return regmap_bulk_read(data->regmap, chan->address, val, sizeof(*val));
> >  }
> >
> >  /*
> > @@ -697,10 +700,10 @@ static irqreturn_t sx9310_trigger_handler(int irq, void *private)
> >                 if (ret < 0)
> >                         goto out;
> >
> > -               data->buffer[i++] = val;
> > +               data->buffer.channels[i++] = val;
> >         }
> >
> > -       iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> > +       iio_push_to_buffers_with_timestamp(indio_dev, data->buffer.channels,

Whilst it's the same address, it makes more sense to push &data->buffer
Technically buffer.channels isn't large enough to meant the requirements
of iio_push_to_buffers_with_timestamp.

Otherwise, looks good.

Thanks,


Jonathan

> >                                            pf->timestamp);
> >
> >  out:
> > --
> > 2.28.0.163.g6104cc2f0b6-goog
> >  
> 
> 
> --
> With Best Regards,
> Andy Shevchenko

