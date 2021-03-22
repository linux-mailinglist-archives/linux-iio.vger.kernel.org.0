Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90563446BF
	for <lists+linux-iio@lfdr.de>; Mon, 22 Mar 2021 15:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhCVOJF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Mar 2021 10:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbhCVOIV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Mar 2021 10:08:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59075C061763
        for <linux-iio@vger.kernel.org>; Mon, 22 Mar 2021 07:08:20 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lOLE6-0002AP-Q6; Mon, 22 Mar 2021 15:08:14 +0100
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1lOLE6-0003Fv-4W; Mon, 22 Mar 2021 15:08:14 +0100
Date:   Mon, 22 Mar 2021 15:08:14 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Robin van der Gracht <robin@protonic.nl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v3 3/3] iio: adc: add ADC driver for the TI TSC2046
 controller
Message-ID: <20210322140814.kp23m4b3xx7bapag@pengutronix.de>
References: <20210319144509.7627-1-o.rempel@pengutronix.de>
 <20210319144509.7627-4-o.rempel@pengutronix.de>
 <CAHp75Vcn=g-3NRXAEd5jEu4uxD_fHbybiDg=t9QiY80TNZuTgQ@mail.gmail.com>
 <20210322103034.bd6swzn2udpvm66o@pengutronix.de>
 <CAHp75VeemLnMJWQOHL8qrqaher2kOn1xTye1tK2OPtpSHhwOcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75VeemLnMJWQOHL8qrqaher2kOn1xTye1tK2OPtpSHhwOcA@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 14:53:44 up 110 days,  4:00, 42 users,  load average: 0.11, 0.05,
 0.01
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 22, 2021 at 03:41:22PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 22, 2021 at 12:30 PM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > On Fri, Mar 19, 2021 at 07:42:41PM +0200, Andy Shevchenko wrote:
> > > On Fri, Mar 19, 2021 at 4:45 PM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> ...
> 
> > > > +static u16 tsc2046_adc_get_value(struct tsc2046_adc_atom *buf)
> > > > +{
> > > > +       /* Last 3 bits on the wire are empty */
> > >
> > > Last?! You meant Least significant?
> >
> > ACK. LSB
> >
> > > Also, don't we lose precision if a new compatible chip appears that
> > > does fill those bits?
> >
> > ACK. All of controllers supported by this driver:
> > drivers/input/touchscreen/ads7846.c:
> > - ti,tsc2046
> > - ti,ads7843
> > - ti,ads7845
> > - ti,ads7846
> > - ti,ads7873 (hm, there is no ti,ads7873, is it actually analog devices AD7873?)
> >
> > support 8- or 12-bit resolution. Only 12 bit mode is supported by this
> > driver. It is possible that some one can produce a resistive touchscreen
> > controller based on X > 12bit ADC, but this will probably not increase precision
> > of this construction (there is a lot of noise any ways...). With other
> > words, it is possible, but not probably that some one will really do it.
> >
> > > Perhaps define the constant and put a comment why it's like this.
> 
> Okay, and what happens here is something like cutting LSBs, but it
> sounds strange to me. If you get 16 bit values, the MSBs should not be
> used?
> 
> So, a good comment is required to explain the logic behind.
> 
> > > > +       return get_unaligned_be16(&buf->data) >> 3;
> > > > +}
> 
> ...
> 
> > > > +static size_t tsc2046_adc_group_set_layout(struct tsc2046_adc_priv *priv,
> > > > +                                          unsigned int group,
> > > > +                                          unsigned int ch_idx)
> > > > +{
> > > > +       struct tsc2046_adc_ch_cfg *ch = &priv->ch_cfg[ch_idx];
> > > > +       struct tsc2046_adc_group_layout *prev, *cur;
> > > > +       unsigned int max_count, count_skip;
> > > > +       unsigned int offset = 0;
> > > > +
> > > > +       if (group) {
> > > > +               prev = &priv->l[group - 1];
> > > > +               offset = prev->offset + prev->count;
> > > > +       }
> > >
> > > I guess you may easily refactor this by supplying a pointer to the
> > > current layout + current size.
> >
> > Sure, but this will not make code more readable and it will not affect
> > the performance. Are there any other reason to do it? Just to make one
> > line instead of two?
> 
> It's still N - 1 unneeded checks and code is slightly harder to read.

fixed

> > > > +       cur = &priv->l[group];
> > >
> > > Also, can you move it down closer to the (single?) caller.
> > >
> > > > +}
> 
> ...
> 
> > > > +               dev_err_ratelimited(dev, "SPI transfer filed: %pe\n",
> > > > +                                   ERR_PTR(ret));
> > >
> > > One line?
> >
> > it will exceed the 80 char rule
> 
> It's fine here.

fixed

> ...
> 
> > > > +       spin_lock_irqsave(&priv->trig_lock, flags);
> > > > +
> > > > +       disable_irq_nosync(priv->spi->irq);
> > >
> > > > +       atomic_inc(&priv->trig_more_count);
> > >
> > > You already have a spin lock, do you need to use the atomic API?
> >
> > I can only pass review comment from my other driver:
> > Memory locations that are concurrently accessed needs to be
> > marked as such, otherwise the compiler is allowed to funky stuff:
> > https://lore.kernel.org/lkml/CAGzjT4ez+gWr3BFQsEr-wma+vs6UZNJ+mRARx_BWoAKEJSsN=w@mail.gmail.com/
> >
> > And here is one more link:
> > https://lwn.net/Articles/793253/#How%20Real%20Is%20All%20This?
> >
> > Starting with commit 62e8a3258bda atomic API is using READ/WRITE_ONCE,
> > so I assume, I do nothing wrong by using it. Correct?
> 
> Hmm... What I don't understand here is why you need a second level of
> atomicity. spin lock already makes this access atomic (at least I have
> checked couple of places and in both the variable is being accessed
> under spin lock).

fixed

> > > > +       iio_trigger_poll(priv->trig);
> > > > +
> > > > +       spin_unlock_irqrestore(&priv->trig_lock, flags);
> 
> ...
> 
> > > > +       name = devm_kasprintf(dev, GFP_KERNEL, "%s-%s",
> > > > +                             TI_TSC2046_NAME, dev_name(dev));
> > >
> > > No NULL check?
> > > Should be added or justified.
> >
> > name is set not optionally  by the spi_add_device()->spi_dev_set_name()
> 
> I didn't get it.
> You allocate memory and haven't checked against NULL. Why?

> If the name field is optional and having it's NULL is okay (non-fatal
> error), put a comment.

ah... I missed the point. You was talking about name == NULL, i was
thinking about dev_name(dev) == NULL.

fixed

> ...
> 
> > > > +       trig->dev.parent = indio_dev->dev.parent;
> > >
> > > Don't we have this done by core (some recent patches in upstream)?
> >
> > can you please point to the code which is doing it?
> 
> I believe it's this one:
> 
> commit 970108185a0be29d1dbb25202d8c12d798e1c3a5
> Author: Gwendal Grignou <gwendal@chromium.org>
> Date:   Tue Mar 9 11:36:13 2021 -0800
> 
>    iio: set default trig->dev.parent

ok, found it on iio/testing and rebased against it..

fixed

Thank you,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
