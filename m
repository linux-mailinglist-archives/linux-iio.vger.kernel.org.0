Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FBA343DE8
	for <lists+linux-iio@lfdr.de>; Mon, 22 Mar 2021 11:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhCVKbE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Mar 2021 06:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhCVKao (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Mar 2021 06:30:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312C5C061574
        for <linux-iio@vger.kernel.org>; Mon, 22 Mar 2021 03:30:44 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lOHpT-0006LZ-Qh; Mon, 22 Mar 2021 11:30:35 +0100
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1lOHpS-0003Ta-SN; Mon, 22 Mar 2021 11:30:34 +0100
Date:   Mon, 22 Mar 2021 11:30:34 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 3/3] iio: adc: add ADC driver for the TI TSC2046
 controller
Message-ID: <20210322103034.bd6swzn2udpvm66o@pengutronix.de>
References: <20210319144509.7627-1-o.rempel@pengutronix.de>
 <20210319144509.7627-4-o.rempel@pengutronix.de>
 <CAHp75Vcn=g-3NRXAEd5jEu4uxD_fHbybiDg=t9QiY80TNZuTgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75Vcn=g-3NRXAEd5jEu4uxD_fHbybiDg=t9QiY80TNZuTgQ@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:30:51 up 109 days, 22:37, 40 users,  load average: 0.22, 0.16,
 0.06
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 19, 2021 at 07:42:41PM +0200, Andy Shevchenko wrote:
> On Fri, Mar 19, 2021 at 4:45 PM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> >
> > Basically the TI TSC2046 touchscreen controller is 8 channel ADC optimized for
> > the touchscreen use case. By implementing it as an IIO ADC device, we can
> > make use of resistive-adc-touch and iio-hwmon drivers.
> >
> > So far, this driver was tested with a custom version of resistive-adc-touch driver,
> > since it needs to be extended to make use of Z1 and Z2 channels. The X/Y
> > are working without additional changes.
> 
> Since kbuild bot found some issues and it will be v4, some additional
> comments from me below.
> ...
> 
> > +#define        TI_TSC2046_SAMPLE_BITS \
> > +       (sizeof(struct tsc2046_adc_atom) * BITS_PER_BYTE)
> 
> Isn't it something like BITS_PER_TYPE(struct ...) ?

sounds good.

> ...
> 
> > +struct tsc2046_adc_atom {
> > +       /*
> > +        * Command transmitted to the controller. This filed is empty on the RX
> > +        * buffer.
> > +        */
> > +       u8 cmd;
> > +       /*
> > +        * Data received from the controller. This filed is empty for the TX
> > +        * buffer
> > +        */
> > +       __be16 data;
> > +} __packed;
> 
> filed -> field in both cases above.

done

> ...
> 
> > +       /*
> > +        * Lock to protect the layout and the spi transfer buffer.
> 
> SPI
> 
> > +        * tsc2046_adc_group_layout can be changed within update_scan_mode(),
> > +        * in this case the l[] and tx/rx buffer will be out of sync to each
> > +        * other.
> > +        */
> 
> ...
> 
> > +static unsigned int tsc2046_adc_time_to_count(struct tsc2046_adc_priv *priv,
> > +                                             unsigned long time)
> > +{
> > +       unsigned int bit_count, sample_count;
> > +
> > +       bit_count = DIV_ROUND_UP(time * NSEC_PER_USEC, priv->time_per_bit_ns);
> 
> Does it survive 32-bit builds?

ACK. I develop and test it on 32bit ARM

> > +       sample_count = DIV_ROUND_UP(bit_count, TI_TSC2046_SAMPLE_BITS);
> > +
> > +       dev_dbg(&priv->spi->dev, "Effective speed %u, time per bit: %u, count bits: %u, count samples: %u\n",
> > +               priv->effective_speed_hz, priv->time_per_bit_ns,
> > +               bit_count, sample_count);
> > +
> > +       return sample_count;
> > +}
> 
> ...
> 
> > +       /*
> > +        * if PD bits are 0, controller will automatically disable ADC, VREF and
> > +        * enable IRQ.
> > +        */
> > +       if (keep_power)
> > +               pd = TI_TSC2046_PD0_ADC_ON;
> > +       else
> > +               pd = 0;
> 
> Can be ternary on one line, but it's up to you.

ACK. I'll keep it

> ...
> 
> > +static u16 tsc2046_adc_get_value(struct tsc2046_adc_atom *buf)
> > +{
> > +       /* Last 3 bits on the wire are empty */
> 
> Last?! You meant Least significant?

ACK. LSB

> Also, don't we lose precision if a new compatible chip appears that
> does fill those bits?

ACK. All of controllers supported by this driver:
drivers/input/touchscreen/ads7846.c:
- ti,tsc2046
- ti,ads7843
- ti,ads7845
- ti,ads7846
- ti,ads7873 (hm, there is no ti,ads7873, is it actually analog devices AD7873?)

support 8- or 12-bit resolution. Only 12 bit mode is supported by this
driver. It is possible that some one can produce a resistive touchscreen
controller based on X > 12bit ADC, but this will probably not increase precision
of this construction (there is a lot of noise any ways...). With other
words, it is possible, but not probably that some one will really do it.

> Perhaps define the constant and put a comment why it's like this.
> 
> > +       return get_unaligned_be16(&buf->data) >> 3;
> > +}
> 
> ...
> 
> > +static size_t tsc2046_adc_group_set_layout(struct tsc2046_adc_priv *priv,
> > +                                          unsigned int group,
> > +                                          unsigned int ch_idx)
> > +{
> > +       struct tsc2046_adc_ch_cfg *ch = &priv->ch_cfg[ch_idx];
> > +       struct tsc2046_adc_group_layout *prev, *cur;
> > +       unsigned int max_count, count_skip;
> > +       unsigned int offset = 0;
> > +
> > +       if (group) {
> > +               prev = &priv->l[group - 1];
> > +               offset = prev->offset + prev->count;
> > +       }
> 
> I guess you may easily refactor this by supplying a pointer to the
> current layout + current size.

Sure, but this will not make code more readable and it will not affect
the performance. Are there any other reason to do it? Just to make one
line instead of two?

> 
> > +       cur = &priv->l[group];
> 
> Also, can you move it down closer to the (single?) caller.
> 
> > +}
> 
> ...
> 
> > +static int tsc2046_adc_scan(struct iio_dev *indio_dev)
> > +{
> > +       struct tsc2046_adc_priv *priv = iio_priv(indio_dev);
> > +       struct device *dev = &priv->spi->dev;
> > +       int group;
> > +       int ret;
> > +
> > +       ret = spi_sync(priv->spi, &priv->msg);
> > +       if (ret < 0) {
> 
> > +               dev_err_ratelimited(dev, "SPI transfer filed: %pe\n",
> > +                                   ERR_PTR(ret));
> 
> One line?

it will exceed the 80 char rule

> > +               return ret;
> > +       }
> 
> > +       ret = iio_push_to_buffers_with_timestamp(indio_dev, &priv->scan_buf,
> > +                                                iio_get_time_ns(indio_dev));
> > +       /* If consumer is kfifo, we may get a EBUSY here - ignore it. */
> 
> the consumer
> 
> > +       if (ret < 0 && ret != -EBUSY) {
> > +               dev_err_ratelimited(dev, "Failed to push scan buffer %pe\n",
> > +                                   ERR_PTR(ret));
> > +
> > +               return ret;
> > +       }
> > +
> > +       return 0;
> > +}
> 
> 
> ...
> 
> > +static enum hrtimer_restart tsc2046_adc_trig_more(struct hrtimer *hrtimer)
> > +{
> > +       struct tsc2046_adc_priv *priv = container_of(hrtimer,
> > +                                                    struct tsc2046_adc_priv,
> > +                                                    trig_timer);
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&priv->trig_lock, flags);
> > +
> > +       disable_irq_nosync(priv->spi->irq);
> 
> > +       atomic_inc(&priv->trig_more_count);
> 
> You already have a spin lock, do you need to use the atomic API?

I can only pass review comment from my other driver:
Memory locations that are concurrently accessed needs to be
marked as such, otherwise the compiler is allowed to funky stuff:
https://lore.kernel.org/lkml/CAGzjT4ez+gWr3BFQsEr-wma+vs6UZNJ+mRARx_BWoAKEJSsN=w@mail.gmail.com/

And here is one more link:
https://lwn.net/Articles/793253/#How%20Real%20Is%20All%20This?

Starting with commit 62e8a3258bda atomic API is using READ/WRITE_ONCE,
so I assume, I do nothing wrong by using it. Correct?


> > +       iio_trigger_poll(priv->trig);
> > +
> > +       spin_unlock_irqrestore(&priv->trig_lock, flags);
> > +
> > +       return HRTIMER_NORESTART;
> > +}
> 
> ...
> 
> > +       size_t size = 0;
> 
> Move the assignment closer to the actual use of the variable.
> 
> ...
> 
> > +       /*
> > +        * In case SPI controller do not report effective_speed_hz, use
> > +        * configure value and hope it will match
> 
> Missed period.
> 
> > +        */
> > +       if (!priv->effective_speed_hz)
> > +               priv->effective_speed_hz = priv->spi->max_speed_hz;
> 
> Also can be ternary on one line, but it's up to you.

it is better readable for me.

> ...
> 
> > +       name = devm_kasprintf(dev, GFP_KERNEL, "%s-%s",
> > +                             TI_TSC2046_NAME, dev_name(dev));
> 
> No NULL check?
> Should be added or justified.

name is set not optionally  by the spi_add_device()->spi_dev_set_name() 

> ...
> 
> > +       trig->dev.parent = indio_dev->dev.parent;
> 
> Don't we have this done by core (some recent patches in upstream)?

can you please point to the code which is doing it?

> ...
> 
> > +       ret = devm_iio_device_register(dev, indio_dev);
> > +       if (ret) {
> > +               dev_err(dev, "Failed to register iio device\n");
> 
> > +               return ret;
> > +       }
> > +
> > +       return 0;
> 
>   return ret;
> or even
>   return devm_iio_device_register(dev, indio_dev);

good point,

regards,
Oleksij

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
