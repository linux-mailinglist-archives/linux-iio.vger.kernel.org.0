Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4FA351048
	for <lists+linux-iio@lfdr.de>; Thu,  1 Apr 2021 09:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbhDAHnR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Apr 2021 03:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbhDAHnM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Apr 2021 03:43:12 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063A1C0613E6
        for <linux-iio@vger.kernel.org>; Thu,  1 Apr 2021 00:43:12 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id f19so770693vsl.10
        for <linux-iio@vger.kernel.org>; Thu, 01 Apr 2021 00:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YJrK4mYFZFwvTaiQJ9F7l/TZJEMR8HDPj90iLG/Fhyc=;
        b=ixUjA+PpLBTs58SQBCBoWxyS1LXp24xNclnTExRPYdOqi5f5446cguR8WiSGq+s6Pz
         Pi5m6LKzO32wQG2mY2U5slZ423LeHjzqsgLHqz4qihh6wh4rQO94RxzSUo3tN4n4eOSq
         sSK0z3xElWUGp9VVoHlCfEcH0vw5DHmrGPYqJvNsa6grIBpF2Z6S/IK1i/A2cV4g2ydc
         JKN2xB/mgxH1Yzhy5qfKLD566tCTzG4GrwIreSugbd6AMBj0uF/G+Fk++RoSPT/94ygN
         qEdxpnSmHzmGjiHoH+Sv02dJY33qet+efvGymkQY2Nc+RPcpgxnyD7r8iS9jHSlIoO2B
         qYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YJrK4mYFZFwvTaiQJ9F7l/TZJEMR8HDPj90iLG/Fhyc=;
        b=ki8xRkk98hc6MYfD1C9rKv/ITA8ClEyueMbTIZz3OJBszrzY5mX0ECnF+FDrd3uGKx
         qGjbEF+dWJdvWb0QKlnABC6Uxr794S5of3HFXKm4Wac8Y/dd/7UGtZzdg0MlIJkUXPT9
         Uc0rtqSSWS3BHjlScVhFGLRikgoac1GxCUrAz4VngOZbtOlgNDFrnefiC1aey397kjrI
         5RIKgfOBmuL1yk/gAsW+RhcAJWOoQd02iUgKN2fiQPYNeyzKp4JO+KYRZuwGzU0gnS5J
         YdheYEkWP74Yt7Wy7eFN7PYiyjyNKjbSOXNLLrTa+QnWF//zjmEJSgX/vqXBzBtDtMLc
         ld9w==
X-Gm-Message-State: AOAM5302ojqnGniYsoLg/alaMbwarB+YrUedjpwIlj6MZrLtqd7cFKX/
        /mVmCsUEDXw6bySUnfVfobzsDaIxeHKWepegj3u7WA==
X-Google-Smtp-Source: ABdhPJyIXeshsCuo5jXsvGMEL5kY3vZ4UkfLC6fyLU1VclcAGEabrKzIztCCc93C8s2fIOa2nXtTj1PRfCpTW1IF5hc=
X-Received: by 2002:a67:694d:: with SMTP id e74mr4047282vsc.16.1617262991057;
 Thu, 01 Apr 2021 00:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210314181511.531414-1-jic23@kernel.org> <20210314181511.531414-13-jic23@kernel.org>
 <CA+U=DsqYjVSyPqBGU+pnY1iJxePiZyWyzzqrxT=cYBtbaX-tLQ@mail.gmail.com> <20210331130517.0f6c6449@jic23-huawei>
In-Reply-To: <20210331130517.0f6c6449@jic23-huawei>
From:   Alexandru Ardelean <aardelean@deviqon.com>
Date:   Thu, 1 Apr 2021 10:42:59 +0300
Message-ID: <CAASAkoaLt3VwcES9=8g-iJtV2m20Fw+Gms76nTad-c8JiVgG3w@mail.gmail.com>
Subject: Re: [PATCH v2 12/24] staging:iio:cdc:ad7150: Rework interrupt handling.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <Robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 31 Mar 2021 at 15:05, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Wed, 31 Mar 2021 10:29:51 +0300
> Alexandru Ardelean <ardeleanalex@gmail.com> wrote:
>
> > On Sun, Mar 14, 2021 at 8:17 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > Note this doesn't support everything the chip can do as we ignore
> > > window mode for now (in window / out of window).
> > >
> > > * Given the chip doesn't have any way of disabling the threshold
> > >   pins, use disable_irq() etc to mask them except when we actually
> > >   want them enabled (previously events were always enabled).
> > >   Note there are race conditions, but using the current state from
> > >   the status register and disabling interrupts across changes in
> > >   type of event should mean those races result in interrupts,
> > >   but no events to userspace.
> > >
> > > * Correctly reflect that there is one threshold line per channel.
> > >
> > > * Only take notice of rising edge. If anyone wants the other edge
> > >   then they should set the other threshold (they are available for
> > >   rising and falling directions).  This isn't perfect but it makes
> > >   it a lot simpler.
> > >
> > > * If insufficient interrupts are specified in firnware, don't support
> > >   events.
> > >
> > > * Adaptive events use the same pos/neg values of thrMD as non adaptive
> > >   ones.
> > >
> > > Tested against qemu based emulation.
> > >
> >
> > Overall looks ok.
> > A few minor issues with the device-matching and OF.
> > And maybe with the interrupt handling.
>
> Hopefully answers below address those two.

Looks good.
Thanks for the clarifications.
I'm still a bit paranoid about the int_enabled stuff, but I'll take
your word for it.

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>


>
>
> >
> >
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Link: https://lore.kernel.org/r/20210207154623.433442-13-jic23@kernel.org
> > > ---
> > >  drivers/staging/iio/cdc/ad7150.c | 258 ++++++++++++++++++-------------
> > >  1 file changed, 153 insertions(+), 105 deletions(-)
> > >
> > > diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
> > > index f8183c540d5c..24be97456c03 100644
> > > --- a/drivers/staging/iio/cdc/ad7150.c
> > > +++ b/drivers/staging/iio/cdc/ad7150.c
> > > @@ -11,6 +11,7 @@
> > >  #include <linux/kernel.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/i2c.h>
> > > +#include <linux/irq.h>
> > >  #include <linux/module.h>
> > >
> > >  #include <linux/iio/iio.h>
> > > @@ -60,8 +61,6 @@ enum {
> > >  /**
> > >   * struct ad7150_chip_info - instance specific chip data
> > >   * @client: i2c client for this device
> > > - * @current_event: device always has one type of event enabled.
> > > - *     This element stores the event code of the current one.
> > >   * @threshold: thresholds for simple capacitance value events
> > >   * @thresh_sensitivity: threshold for simple capacitance offset
> > >   *     from 'average' value.
> > > @@ -70,21 +69,23 @@ enum {
> > >   *     value jumps to current value.  Note made up of two fields,
> > >   *      3:0 are for timeout receding - applies if below lower threshold
> > >   *      7:4 are for timeout approaching - applies if above upper threshold
> > > - * @old_state: store state from previous event, allowing confirmation
> > > - *     of new condition.
> > > - * @conversion_mode: the current conversion mode.
> > >   * @state_lock: ensure consistent state of this structure wrt the
> > >   *     hardware.
> > > + * @interrupts: one or two interrupt numbers depending on device type.
> > > + * @int_enabled: is a given interrupt currently enabled.
> > > + * @type: threshold type
> > > + * @dir: threshold direction
> > >   */
> > >  struct ad7150_chip_info {
> > >         struct i2c_client *client;
> > > -       u64 current_event;
> > >         u16 threshold[2][2];
> > >         u8 thresh_sensitivity[2][2];
> > >         u8 thresh_timeout[2][2];
> > > -       int old_state;
> > > -       char *conversion_mode;
> > >         struct mutex state_lock;
> > > +       int interrupts[2];
> > > +       bool int_enabled[2];
> > > +       enum iio_event_type type;
> > > +       enum iio_event_direction dir;
> > >  };
> > >
> > >  /*
> > > @@ -158,8 +159,8 @@ static int ad7150_read_event_config(struct iio_dev *indio_dev,
> > >         switch (type) {
> > >         case IIO_EV_TYPE_THRESH_ADAPTIVE:
> > >                 if (dir == IIO_EV_DIR_RISING)
> > > -                       return !thrfixed && (threshtype == 0x3);
> > > -               return !thrfixed && (threshtype == 0x2);
> > > +                       return !thrfixed && (threshtype == 0x1);
> > > +               return !thrfixed && (threshtype == 0x0);
> > >         case IIO_EV_TYPE_THRESH:
> > >                 if (dir == IIO_EV_DIR_RISING)
> > >                         return thrfixed && (threshtype == 0x1);
> > > @@ -179,11 +180,9 @@ static int ad7150_write_event_params(struct iio_dev *indio_dev,
> > >  {
> > >         struct ad7150_chip_info *chip = iio_priv(indio_dev);
> > >         int rising = (dir == IIO_EV_DIR_RISING);
> > > -       u64 event_code;
> > >
> > > -       event_code = IIO_UNMOD_EVENT_CODE(IIO_CAPACITANCE, chan, type, dir);
> > > -
> > > -       if (event_code != chip->current_event)
> > > +       /* Only update value live, if parameter is in use */
> > > +       if ((type != chip->type) || (dir != chip->dir))
> > >                 return 0;
> > >
> > >         switch (type) {
> > > @@ -231,52 +230,91 @@ static int ad7150_write_event_config(struct iio_dev *indio_dev,
> > >         int ret;
> > >         struct ad7150_chip_info *chip = iio_priv(indio_dev);
> > >         int rising = (dir == IIO_EV_DIR_RISING);
> > > -       u64 event_code;
> > > -
> > > -       /* Something must always be turned on */
> > > -       if (!state)
> > > -               return -EINVAL;
> > >
> > > -       event_code = IIO_UNMOD_EVENT_CODE(chan->type, chan->channel, type, dir);
> > > -       if (event_code == chip->current_event)
> > > +       /*
> > > +        * There is only a single shared control and no on chip
> > > +        * interrupt disables for the two interrupt lines.
> > > +        * So, enabling will switch the events configured to enable
> > > +        * whatever was most recently requested and if necessary enable_irq()
> > > +        * the interrupt and any disable will disable_irq() for that
> > > +        * channels interrupt.
> > > +        */
> > > +       if (!state) {
> > > +               if ((chip->int_enabled[chan->channel]) &&
> > > +                   (type == chip->type) && (dir == chip->dir)) {
> > > +                       disable_irq(chip->interrupts[chan->channel]);
> > > +                       chip->int_enabled[chan->channel] = false;
> > > +               }
> > >                 return 0;
> > > +       }
> > > +
> > >         mutex_lock(&chip->state_lock);
> > > -       ret = i2c_smbus_read_byte_data(chip->client, AD7150_CFG);
> > > -       if (ret < 0)
> > > -               goto error_ret;
> > > +       if ((type != chip->type) || (dir != chip->dir)) {
> > >
> > > -       cfg = ret & ~((0x03 << 5) | BIT(7));
> > > +               /*
> > > +                * Need to temporarily disable both interrupts if
> > > +                * enabled - this is to avoid races around changing
> > > +                * config and thresholds.
> > > +                * Note enable/disable_irq() are reference counted so
> > > +                * no need to check if already enabled.
> > > +                */
> > > +               disable_irq(chip->interrupts[0]);
> > > +               disable_irq(chip->interrupts[1]);
> > >
> > > -       switch (type) {
> > > -       case IIO_EV_TYPE_THRESH_ADAPTIVE:
> > > -               adaptive = 1;
> > > -               if (rising)
> > > -                       thresh_type = 0x3;
> > > -               else
> > > -                       thresh_type = 0x2;
> > > -               break;
> > > -       case IIO_EV_TYPE_THRESH:
> > > -               adaptive = 0;
> > > -               if (rising)
> > > -                       thresh_type = 0x1;
> > > -               else
> > > -                       thresh_type = 0x0;
> > > -               break;
> > > -       default:
> > > -               ret = -EINVAL;
> > > -               goto error_ret;
> > > -       }
> > > +               ret = i2c_smbus_read_byte_data(chip->client, AD7150_CFG);
> > > +               if (ret < 0)
> > > +                       goto error_ret;
> > >
> > > -       cfg |= (!adaptive << 7) | (thresh_type << 5);
> > > +               cfg = ret & ~((0x03 << 5) | BIT(7));
> > >
> > > -       ret = i2c_smbus_write_byte_data(chip->client, AD7150_CFG, cfg);
> > > -       if (ret < 0)
> > > -               goto error_ret;
> > > +               switch (type) {
> > > +               case IIO_EV_TYPE_THRESH_ADAPTIVE:
> > > +                       adaptive = 1;
> > > +                       if (rising)
> > > +                               thresh_type = 0x1;
> > > +                       else
> > > +                               thresh_type = 0x0;
> > > +                       break;
> > > +               case IIO_EV_TYPE_THRESH:
> > > +                       adaptive = 0;
> > > +                       if (rising)
> > > +                               thresh_type = 0x1;
> > > +                       else
> > > +                               thresh_type = 0x0;
> >
> > this can be ignored; it's a minor nit;
> > the if (rising) {} else {} block looks duplicate;
> > it could be moved after the switch() block;
>
> If you are happy with rest I'll just roll that in whilst applying.
>
> >
> > > +                       break;
> > > +               default:
> > > +                       ret = -EINVAL;
> > > +                       goto error_ret;
> > > +               }
> > >
> > > -       chip->current_event = event_code;
> > > +               cfg |= (!adaptive << 7) | (thresh_type << 5);
> > > +
> > > +               ret = i2c_smbus_write_byte_data(chip->client, AD7150_CFG, cfg);
> > > +               if (ret < 0)
> > > +                       goto error_ret;
> > > +
> > > +               /*
> > > +                * There is a potential race condition here, but not easy
> > > +                * to close given we can't disable the interrupt at the
> > > +                * chip side of things. Rely on the status bit.
> > > +                */
> > > +               chip->type = type;
> > > +               chip->dir = dir;
> > > +
> > > +               /* update control attributes */
> > > +               ret = ad7150_write_event_params(indio_dev, chan->channel, type,
> > > +                                               dir);
> > > +               if (ret)
> > > +                       goto error_ret;
> > > +               /* reenable any irq's we disabled whilst changing mode */
> > > +               enable_irq(chip->interrupts[0]);
> > > +               enable_irq(chip->interrupts[1]);
> >
> > i'm wondering if we need to set   'chip->int_enabled[ for 0 & 1 ] = true;'
> > tbh i am not sure if there is a chance of mismatch between
> > 'int_enabled' and the actual enable_irq()
> >
> > maybe it might make sense to add an  ad7150_{enable/disable}_irq()
> > that checks the per-channel 'int_enabled' field;
>
> Ah.  I'm playing a bit of a game here. (there is a comment at the irq_disable() calls
> that was meant to indicate what was going on).
>
> There is a difference between when chip->int_enabled[] is changed in conjunction
> with enable_irq()/disable_irq() and when enable_irq()/disable_irq() are change on their own.
>

I reserve the right remain paranoid about it :p

> The intent is that int_enabled[] reflects non-transient state of whether
> the interrupt is enabled - I don't want to update it during transient states.
>
> We are fine to do the disable_irq() calls on irqs that aren't enabled because
> disable_irq() calls can be safely nested.  Only when you have more enable_irq()
> calls (including startup if it's auto enabled) than you have disable_irq() calls
> will the interrupt be enabled.
>
> https://elixir.bootlin.com/linux/latest/source/kernel/irq/manage.c#L771
> https://elixir.bootlin.com/linux/latest/source/include/linux/irqdesc.h#L28
> The depth field in irq_desc is used for this.
>
> >
> >
> > > +       }
> > > +       if (!chip->int_enabled[chan->channel]) {
> > > +               enable_irq(chip->interrupts[chan->channel]);
> > > +               chip->int_enabled[chan->channel] = true;
> > > +       }
> > >
> > > -       /* update control attributes */
> > > -       ret = ad7150_write_event_params(indio_dev, chan->channel, type, dir);
> > >  error_ret:
> > >         mutex_unlock(&chip->state_lock);
> > >
> > > @@ -434,59 +472,44 @@ static const struct iio_chan_spec ad7151_channels_no_irq[] = {
> > >         AD7150_CAPACITANCE_CHAN_NO_IRQ(0),
> > >  };
> > >
> > > -static irqreturn_t ad7150_event_handler(int irq, void *private)
> > > +static irqreturn_t __ad7150_event_handler(void *private, u8 status_mask,
> > > +                                         int channel)
> > >  {
> > >         struct iio_dev *indio_dev = private;
> > >         struct ad7150_chip_info *chip = iio_priv(indio_dev);
> > > -       u8 int_status;
> > >         s64 timestamp = iio_get_time_ns(indio_dev);
> > > -       int ret;
> > > +       int int_status;
> > >
> > > -       ret = i2c_smbus_read_byte_data(chip->client, AD7150_STATUS);
> > > -       if (ret < 0)
> > > +       int_status = i2c_smbus_read_byte_data(chip->client, AD7150_STATUS);
> > > +       if (int_status < 0)
> > >                 return IRQ_HANDLED;
> > >
> > > -       int_status = ret;
> > > -
> > > -       if ((int_status & AD7150_STATUS_OUT1) &&
> > > -           !(chip->old_state & AD7150_STATUS_OUT1))
> > > -               iio_push_event(indio_dev,
> > > -                              IIO_UNMOD_EVENT_CODE(IIO_CAPACITANCE,
> > > -                                                   0,
> > > -                                                   IIO_EV_TYPE_THRESH,
> > > -                                                   IIO_EV_DIR_RISING),
> > > -                               timestamp);
> > > -       else if ((!(int_status & AD7150_STATUS_OUT1)) &&
> > > -                (chip->old_state & AD7150_STATUS_OUT1))
> > > -               iio_push_event(indio_dev,
> > > -                              IIO_UNMOD_EVENT_CODE(IIO_CAPACITANCE,
> > > -                                                   0,
> > > -                                                   IIO_EV_TYPE_THRESH,
> > > -                                                   IIO_EV_DIR_FALLING),
> > > -                              timestamp);
> > > -
> > > -       if ((int_status & AD7150_STATUS_OUT2) &&
> > > -           !(chip->old_state & AD7150_STATUS_OUT2))
> > > -               iio_push_event(indio_dev,
> > > -                              IIO_UNMOD_EVENT_CODE(IIO_CAPACITANCE,
> > > -                                                   1,
> > > -                                                   IIO_EV_TYPE_THRESH,
> > > -                                                   IIO_EV_DIR_RISING),
> > > -                              timestamp);
> > > -       else if ((!(int_status & AD7150_STATUS_OUT2)) &&
> > > -                (chip->old_state & AD7150_STATUS_OUT2))
> > > -               iio_push_event(indio_dev,
> > > -                              IIO_UNMOD_EVENT_CODE(IIO_CAPACITANCE,
> > > -                                                   1,
> > > -                                                   IIO_EV_TYPE_THRESH,
> > > -                                                   IIO_EV_DIR_FALLING),
> > > -                              timestamp);
> > > -       /* store the status to avoid repushing same events */
> > > -       chip->old_state = int_status;
> > > +       /*
> > > +        * There are race conditions around enabling and disabling that
> > > +        * could easily land us here with a spurious interrupt.
> > > +        * Just eat it if so.
> > > +        */
> > > +       if (!(int_status & status_mask))
> > > +               return IRQ_HANDLED;
> > > +
> > > +       iio_push_event(indio_dev,
> > > +                      IIO_UNMOD_EVENT_CODE(IIO_CAPACITANCE, channel,
> > > +                                           chip->type, chip->dir),
> > > +                      timestamp);
> > >
> > >         return IRQ_HANDLED;
> > >  }
> > >
> > > +static irqreturn_t ad7150_event_handler_ch1(int irq, void *private)
> > > +{
> > > +       return __ad7150_event_handler(private, AD7150_STATUS_OUT1, 0);
> > > +}
> > > +
> > > +static irqreturn_t ad7150_event_handler_ch2(int irq, void *private)
> > > +{
> > > +       return __ad7150_event_handler(private, AD7150_STATUS_OUT2, 1);
> > > +}
> > > +
> > >  static IIO_CONST_ATTR(in_capacitance_thresh_adaptive_timeout_available,
> > >                       "[0 0.01 0.15]");
> > >
> > > @@ -533,12 +556,44 @@ static int ad7150_probe(struct i2c_client *client,
> > >
> > >         indio_dev->modes = INDIO_DIRECT_MODE;
> > >
> > > -       if (client->irq) {
> > > +       chip->interrupts[0] = fwnode_irq_get(dev_fwnode(&client->dev), 0);
> > > +       if (chip->interrupts[0] < 0)
> > > +               return chip->interrupts[0];
> > > +       if (id->driver_data == AD7150) {
> >
> > checking  'id->driver_data'  will be flaky after the of_match_table is added;
>
> It's not, though the path is a bit obscure and only works if you don't use
> probe_new() - if using probe_new() you to call i2c_match_id() directly.
>
> I remember raising this in a review I did a few years back and chasing it down.
> I just sanity checked and it still works ;)
>

ack;
thanks for the info;

> So, even if we do an of_based registration the following happens
>
> of_i2c_register_device()
> -> of_i2c_get_board_info() // gets the of_node pointer
> -> i2c_new_client_device(adap, &info);
> ..  some time later the i2c_bus_type.probe() gets called for the devices we added
>    and
>
>
> -> i2c_device_probe()
>   -> driver->probe(client, i2c_match_id(driver->id_table, client))
>     -> i2c_match_id() //matches against id table and hence gets us the driver_data.
>
>
>
> > either we defer the of_match_table patch, or we update it somehow;
> > maybe a chip_info struct is an idea;
> > otherwise we need to do void pointer to int conversions [which look nasty];
> >
> > i'm also seeing that there is a 'type' field inside of_device_id that
> > is underused, but looks useful for cases like this;
> > i'm also a bit paranoid to use it; because it may not be compatible
> > with acpi_device_id
>
> We can refactor this at some point, but I don't think it is necessary to move
> the driver out of staging as a lot of drivers are doing things the same
> way we do it here.

ack


>
> >
> > > +               chip->interrupts[1] = fwnode_irq_get(dev_fwnode(&client->dev), 1);
> > > +               if (chip->interrupts[1] < 0)
> > > +                       return chip->interrupts[1];
> > > +       }
> > > +       if (chip->interrupts[0] &&
> > > +           (id->driver_data == AD7151 || chip->interrupts[1])) {
> > > +               irq_set_status_flags(chip->interrupts[0], IRQ_NOAUTOEN);
> > > +               ret = devm_request_threaded_irq(&client->dev,
> > > +                                               chip->interrupts[0],
> > > +                                               NULL,
> > > +                                               &ad7150_event_handler_ch1,
> > > +                                               IRQF_TRIGGER_RISING |
> > > +                                               IRQF_ONESHOT,
> > > +                                               "ad7150_irq1",
> > > +                                               indio_dev);
> > > +               if (ret)
> > > +                       return ret;
> > > +
> > >                 indio_dev->info = &ad7150_info;
> > >                 switch (id->driver_data) {
> > >                 case AD7150:
> > >                         indio_dev->channels = ad7150_channels;
> > >                         indio_dev->num_channels = ARRAY_SIZE(ad7150_channels);
> > > +                       irq_set_status_flags(chip->interrupts[1], IRQ_NOAUTOEN);
> > > +                       ret = devm_request_threaded_irq(&client->dev,
> > > +                                                       chip->interrupts[1],
> > > +                                                       NULL,
> > > +                                                       &ad7150_event_handler_ch2,
> > > +                                                       IRQF_TRIGGER_RISING |
> > > +                                                       IRQF_ONESHOT,
> > > +                                                       "ad7150_irq2",
> > > +                                                       indio_dev);
> > > +                       if (ret)
> > > +                               return ret;
> > >                         break;
> > >                 case AD7151:
> > >                         indio_dev->channels = ad7151_channels;
> > > @@ -548,25 +603,18 @@ static int ad7150_probe(struct i2c_client *client,
> > >                         return -EINVAL;
> > >                 }
> > >
> > > -               ret = devm_request_threaded_irq(&client->dev, client->irq,
> > > -                                               NULL,
> > > -                                               &ad7150_event_handler,
> > > -                                               IRQF_TRIGGER_RISING |
> > > -                                               IRQF_ONESHOT,
> > > -                                               "ad7150_irq1",
> > > -                                               indio_dev);
> > > -               if (ret)
> > > -                       return ret;
> > >         } else {
> > >                 indio_dev->info = &ad7150_info_no_irq;
> > >                 switch (id->driver_data) {
> > >                 case AD7150:
> > >                         indio_dev->channels = ad7150_channels_no_irq;
> > > -                       indio_dev->num_channels = ARRAY_SIZE(ad7150_channels_no_irq);
> > > +                       indio_dev->num_channels =
> > > +                               ARRAY_SIZE(ad7150_channels_no_irq);
> > >                         break;
> > >                 case AD7151:
> > >                         indio_dev->channels = ad7151_channels_no_irq;
> > > -                       indio_dev->num_channels = ARRAY_SIZE(ad7151_channels_no_irq);
> > > +                       indio_dev->num_channels =
> > > +                               ARRAY_SIZE(ad7151_channels_no_irq);
> > >                         break;
> > >                 default:
> > >                         return -EINVAL;
> > > --
> > > 2.30.2
> > >
>
