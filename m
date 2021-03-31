Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6C434F9D1
	for <lists+linux-iio@lfdr.de>; Wed, 31 Mar 2021 09:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbhCaHaJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 Mar 2021 03:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbhCaHaE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 Mar 2021 03:30:04 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B592C061574
        for <linux-iio@vger.kernel.org>; Wed, 31 Mar 2021 00:30:04 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id j16so7831970ilq.13
        for <linux-iio@vger.kernel.org>; Wed, 31 Mar 2021 00:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0IXgDPogmVHsC43hFYfwXOJx3MDjPkn2TdZl5CqQ+D4=;
        b=snbybGZZfcVZihw8f8abFT7OEMehddyJ6zDqPo2GMOYFJDIGBBWjVOei9xqPe50+xD
         zqAnmgGCPicPVSIwv2BsQtHrU32laIWPiO8s4CgmgVga4PJwBw+x6pkyrr7QZHqq4ikq
         +EvJv8P/vB1uPIm1dK2FJyJBJ7hpUOO0juAK0ZengfAqbqxxyz4X3vaHN1MffxnpY4EK
         XOMTG2Rc2Ts+IkQUoeI10gloN24N0hQSe20jhLzEUopXbGstKdaNVV/nfNAgW+1x3+jG
         xBt7xfrnjVUK2WqyLlLVTZHDrGDSrkmTsYiqRFoyvFCvMc4SOp4W7UW+wwMcD3fN5oG6
         r6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0IXgDPogmVHsC43hFYfwXOJx3MDjPkn2TdZl5CqQ+D4=;
        b=CPO1nHla/ST1P3MAgqevMHRLlaYy4ZupFLpJ3F/6FBUwA/7ji0mZ6yhcG8JG2Isvyq
         YV4W2CSGoZpG+VjKwjaUqX6ITLkNV0Bb9LkPN9KjN6luvFGosOYGbZzo/Qd0bOr34dgy
         8n8HA0k7kOG0zen6H0yGolT8zY9XMYkuKLjrALEpb/rlqZsU/2vRF+zC0jyZet3y8RhY
         zfgnRG7r3gEZc3yootqag1JXY8RoH9njUIJl1atIKeEj1FarnOm/2gLGSo6o21M4aIAv
         qV3reGXAuwZd/1UvXsR/dogWVKPmC4VHheo8WsU/8DHN7StlwpVZ6CPLQQIUf24yAsRA
         Jxzg==
X-Gm-Message-State: AOAM532bc3SxKjHCmf2FLowqjqFzZfvB3CnBFljrgn7jLh4xCIxS0Cf+
        IXstHagAx86gOvg2+2tBYr+svSAoCehXULZFV3g=
X-Google-Smtp-Source: ABdhPJzCDotRtMiAikx9VQsoVwcoAtSYiCNhFvpJeEPy6lVYSmgBSv2vmbtgdYrqL1aQ1JaZnPGoqptC5w4Et4+N5yU=
X-Received: by 2002:a05:6e02:f06:: with SMTP id x6mr1659182ilj.292.1617175803377;
 Wed, 31 Mar 2021 00:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210314181511.531414-1-jic23@kernel.org> <20210314181511.531414-13-jic23@kernel.org>
In-Reply-To: <20210314181511.531414-13-jic23@kernel.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 31 Mar 2021 10:29:51 +0300
Message-ID: <CA+U=DsqYjVSyPqBGU+pnY1iJxePiZyWyzzqrxT=cYBtbaX-tLQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/24] staging:iio:cdc:ad7150: Rework interrupt handling.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Rob Herring <Robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 14, 2021 at 8:17 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Note this doesn't support everything the chip can do as we ignore
> window mode for now (in window / out of window).
>
> * Given the chip doesn't have any way of disabling the threshold
>   pins, use disable_irq() etc to mask them except when we actually
>   want them enabled (previously events were always enabled).
>   Note there are race conditions, but using the current state from
>   the status register and disabling interrupts across changes in
>   type of event should mean those races result in interrupts,
>   but no events to userspace.
>
> * Correctly reflect that there is one threshold line per channel.
>
> * Only take notice of rising edge. If anyone wants the other edge
>   then they should set the other threshold (they are available for
>   rising and falling directions).  This isn't perfect but it makes
>   it a lot simpler.
>
> * If insufficient interrupts are specified in firnware, don't support
>   events.
>
> * Adaptive events use the same pos/neg values of thrMD as non adaptive
>   ones.
>
> Tested against qemu based emulation.
>

Overall looks ok.
A few minor issues with the device-matching and OF.
And maybe with the interrupt handling.


> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Link: https://lore.kernel.org/r/20210207154623.433442-13-jic23@kernel.org
> ---
>  drivers/staging/iio/cdc/ad7150.c | 258 ++++++++++++++++++-------------
>  1 file changed, 153 insertions(+), 105 deletions(-)
>
> diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
> index f8183c540d5c..24be97456c03 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -11,6 +11,7 @@
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/i2c.h>
> +#include <linux/irq.h>
>  #include <linux/module.h>
>
>  #include <linux/iio/iio.h>
> @@ -60,8 +61,6 @@ enum {
>  /**
>   * struct ad7150_chip_info - instance specific chip data
>   * @client: i2c client for this device
> - * @current_event: device always has one type of event enabled.
> - *     This element stores the event code of the current one.
>   * @threshold: thresholds for simple capacitance value events
>   * @thresh_sensitivity: threshold for simple capacitance offset
>   *     from 'average' value.
> @@ -70,21 +69,23 @@ enum {
>   *     value jumps to current value.  Note made up of two fields,
>   *      3:0 are for timeout receding - applies if below lower threshold
>   *      7:4 are for timeout approaching - applies if above upper threshold
> - * @old_state: store state from previous event, allowing confirmation
> - *     of new condition.
> - * @conversion_mode: the current conversion mode.
>   * @state_lock: ensure consistent state of this structure wrt the
>   *     hardware.
> + * @interrupts: one or two interrupt numbers depending on device type.
> + * @int_enabled: is a given interrupt currently enabled.
> + * @type: threshold type
> + * @dir: threshold direction
>   */
>  struct ad7150_chip_info {
>         struct i2c_client *client;
> -       u64 current_event;
>         u16 threshold[2][2];
>         u8 thresh_sensitivity[2][2];
>         u8 thresh_timeout[2][2];
> -       int old_state;
> -       char *conversion_mode;
>         struct mutex state_lock;
> +       int interrupts[2];
> +       bool int_enabled[2];
> +       enum iio_event_type type;
> +       enum iio_event_direction dir;
>  };
>
>  /*
> @@ -158,8 +159,8 @@ static int ad7150_read_event_config(struct iio_dev *indio_dev,
>         switch (type) {
>         case IIO_EV_TYPE_THRESH_ADAPTIVE:
>                 if (dir == IIO_EV_DIR_RISING)
> -                       return !thrfixed && (threshtype == 0x3);
> -               return !thrfixed && (threshtype == 0x2);
> +                       return !thrfixed && (threshtype == 0x1);
> +               return !thrfixed && (threshtype == 0x0);
>         case IIO_EV_TYPE_THRESH:
>                 if (dir == IIO_EV_DIR_RISING)
>                         return thrfixed && (threshtype == 0x1);
> @@ -179,11 +180,9 @@ static int ad7150_write_event_params(struct iio_dev *indio_dev,
>  {
>         struct ad7150_chip_info *chip = iio_priv(indio_dev);
>         int rising = (dir == IIO_EV_DIR_RISING);
> -       u64 event_code;
>
> -       event_code = IIO_UNMOD_EVENT_CODE(IIO_CAPACITANCE, chan, type, dir);
> -
> -       if (event_code != chip->current_event)
> +       /* Only update value live, if parameter is in use */
> +       if ((type != chip->type) || (dir != chip->dir))
>                 return 0;
>
>         switch (type) {
> @@ -231,52 +230,91 @@ static int ad7150_write_event_config(struct iio_dev *indio_dev,
>         int ret;
>         struct ad7150_chip_info *chip = iio_priv(indio_dev);
>         int rising = (dir == IIO_EV_DIR_RISING);
> -       u64 event_code;
> -
> -       /* Something must always be turned on */
> -       if (!state)
> -               return -EINVAL;
>
> -       event_code = IIO_UNMOD_EVENT_CODE(chan->type, chan->channel, type, dir);
> -       if (event_code == chip->current_event)
> +       /*
> +        * There is only a single shared control and no on chip
> +        * interrupt disables for the two interrupt lines.
> +        * So, enabling will switch the events configured to enable
> +        * whatever was most recently requested and if necessary enable_irq()
> +        * the interrupt and any disable will disable_irq() for that
> +        * channels interrupt.
> +        */
> +       if (!state) {
> +               if ((chip->int_enabled[chan->channel]) &&
> +                   (type == chip->type) && (dir == chip->dir)) {
> +                       disable_irq(chip->interrupts[chan->channel]);
> +                       chip->int_enabled[chan->channel] = false;
> +               }
>                 return 0;
> +       }
> +
>         mutex_lock(&chip->state_lock);
> -       ret = i2c_smbus_read_byte_data(chip->client, AD7150_CFG);
> -       if (ret < 0)
> -               goto error_ret;
> +       if ((type != chip->type) || (dir != chip->dir)) {
>
> -       cfg = ret & ~((0x03 << 5) | BIT(7));
> +               /*
> +                * Need to temporarily disable both interrupts if
> +                * enabled - this is to avoid races around changing
> +                * config and thresholds.
> +                * Note enable/disable_irq() are reference counted so
> +                * no need to check if already enabled.
> +                */
> +               disable_irq(chip->interrupts[0]);
> +               disable_irq(chip->interrupts[1]);
>
> -       switch (type) {
> -       case IIO_EV_TYPE_THRESH_ADAPTIVE:
> -               adaptive = 1;
> -               if (rising)
> -                       thresh_type = 0x3;
> -               else
> -                       thresh_type = 0x2;
> -               break;
> -       case IIO_EV_TYPE_THRESH:
> -               adaptive = 0;
> -               if (rising)
> -                       thresh_type = 0x1;
> -               else
> -                       thresh_type = 0x0;
> -               break;
> -       default:
> -               ret = -EINVAL;
> -               goto error_ret;
> -       }
> +               ret = i2c_smbus_read_byte_data(chip->client, AD7150_CFG);
> +               if (ret < 0)
> +                       goto error_ret;
>
> -       cfg |= (!adaptive << 7) | (thresh_type << 5);
> +               cfg = ret & ~((0x03 << 5) | BIT(7));
>
> -       ret = i2c_smbus_write_byte_data(chip->client, AD7150_CFG, cfg);
> -       if (ret < 0)
> -               goto error_ret;
> +               switch (type) {
> +               case IIO_EV_TYPE_THRESH_ADAPTIVE:
> +                       adaptive = 1;
> +                       if (rising)
> +                               thresh_type = 0x1;
> +                       else
> +                               thresh_type = 0x0;
> +                       break;
> +               case IIO_EV_TYPE_THRESH:
> +                       adaptive = 0;
> +                       if (rising)
> +                               thresh_type = 0x1;
> +                       else
> +                               thresh_type = 0x0;

this can be ignored; it's a minor nit;
the if (rising) {} else {} block looks duplicate;
it could be moved after the switch() block;

> +                       break;
> +               default:
> +                       ret = -EINVAL;
> +                       goto error_ret;
> +               }
>
> -       chip->current_event = event_code;
> +               cfg |= (!adaptive << 7) | (thresh_type << 5);
> +
> +               ret = i2c_smbus_write_byte_data(chip->client, AD7150_CFG, cfg);
> +               if (ret < 0)
> +                       goto error_ret;
> +
> +               /*
> +                * There is a potential race condition here, but not easy
> +                * to close given we can't disable the interrupt at the
> +                * chip side of things. Rely on the status bit.
> +                */
> +               chip->type = type;
> +               chip->dir = dir;
> +
> +               /* update control attributes */
> +               ret = ad7150_write_event_params(indio_dev, chan->channel, type,
> +                                               dir);
> +               if (ret)
> +                       goto error_ret;
> +               /* reenable any irq's we disabled whilst changing mode */
> +               enable_irq(chip->interrupts[0]);
> +               enable_irq(chip->interrupts[1]);

i'm wondering if we need to set   'chip->int_enabled[ for 0 & 1 ] = true;'
tbh i am not sure if there is a chance of mismatch between
'int_enabled' and the actual enable_irq()

maybe it might make sense to add an  ad7150_{enable/disable}_irq()
that checks the per-channel 'int_enabled' field;


> +       }
> +       if (!chip->int_enabled[chan->channel]) {
> +               enable_irq(chip->interrupts[chan->channel]);
> +               chip->int_enabled[chan->channel] = true;
> +       }
>
> -       /* update control attributes */
> -       ret = ad7150_write_event_params(indio_dev, chan->channel, type, dir);
>  error_ret:
>         mutex_unlock(&chip->state_lock);
>
> @@ -434,59 +472,44 @@ static const struct iio_chan_spec ad7151_channels_no_irq[] = {
>         AD7150_CAPACITANCE_CHAN_NO_IRQ(0),
>  };
>
> -static irqreturn_t ad7150_event_handler(int irq, void *private)
> +static irqreturn_t __ad7150_event_handler(void *private, u8 status_mask,
> +                                         int channel)
>  {
>         struct iio_dev *indio_dev = private;
>         struct ad7150_chip_info *chip = iio_priv(indio_dev);
> -       u8 int_status;
>         s64 timestamp = iio_get_time_ns(indio_dev);
> -       int ret;
> +       int int_status;
>
> -       ret = i2c_smbus_read_byte_data(chip->client, AD7150_STATUS);
> -       if (ret < 0)
> +       int_status = i2c_smbus_read_byte_data(chip->client, AD7150_STATUS);
> +       if (int_status < 0)
>                 return IRQ_HANDLED;
>
> -       int_status = ret;
> -
> -       if ((int_status & AD7150_STATUS_OUT1) &&
> -           !(chip->old_state & AD7150_STATUS_OUT1))
> -               iio_push_event(indio_dev,
> -                              IIO_UNMOD_EVENT_CODE(IIO_CAPACITANCE,
> -                                                   0,
> -                                                   IIO_EV_TYPE_THRESH,
> -                                                   IIO_EV_DIR_RISING),
> -                               timestamp);
> -       else if ((!(int_status & AD7150_STATUS_OUT1)) &&
> -                (chip->old_state & AD7150_STATUS_OUT1))
> -               iio_push_event(indio_dev,
> -                              IIO_UNMOD_EVENT_CODE(IIO_CAPACITANCE,
> -                                                   0,
> -                                                   IIO_EV_TYPE_THRESH,
> -                                                   IIO_EV_DIR_FALLING),
> -                              timestamp);
> -
> -       if ((int_status & AD7150_STATUS_OUT2) &&
> -           !(chip->old_state & AD7150_STATUS_OUT2))
> -               iio_push_event(indio_dev,
> -                              IIO_UNMOD_EVENT_CODE(IIO_CAPACITANCE,
> -                                                   1,
> -                                                   IIO_EV_TYPE_THRESH,
> -                                                   IIO_EV_DIR_RISING),
> -                              timestamp);
> -       else if ((!(int_status & AD7150_STATUS_OUT2)) &&
> -                (chip->old_state & AD7150_STATUS_OUT2))
> -               iio_push_event(indio_dev,
> -                              IIO_UNMOD_EVENT_CODE(IIO_CAPACITANCE,
> -                                                   1,
> -                                                   IIO_EV_TYPE_THRESH,
> -                                                   IIO_EV_DIR_FALLING),
> -                              timestamp);
> -       /* store the status to avoid repushing same events */
> -       chip->old_state = int_status;
> +       /*
> +        * There are race conditions around enabling and disabling that
> +        * could easily land us here with a spurious interrupt.
> +        * Just eat it if so.
> +        */
> +       if (!(int_status & status_mask))
> +               return IRQ_HANDLED;
> +
> +       iio_push_event(indio_dev,
> +                      IIO_UNMOD_EVENT_CODE(IIO_CAPACITANCE, channel,
> +                                           chip->type, chip->dir),
> +                      timestamp);
>
>         return IRQ_HANDLED;
>  }
>
> +static irqreturn_t ad7150_event_handler_ch1(int irq, void *private)
> +{
> +       return __ad7150_event_handler(private, AD7150_STATUS_OUT1, 0);
> +}
> +
> +static irqreturn_t ad7150_event_handler_ch2(int irq, void *private)
> +{
> +       return __ad7150_event_handler(private, AD7150_STATUS_OUT2, 1);
> +}
> +
>  static IIO_CONST_ATTR(in_capacitance_thresh_adaptive_timeout_available,
>                       "[0 0.01 0.15]");
>
> @@ -533,12 +556,44 @@ static int ad7150_probe(struct i2c_client *client,
>
>         indio_dev->modes = INDIO_DIRECT_MODE;
>
> -       if (client->irq) {
> +       chip->interrupts[0] = fwnode_irq_get(dev_fwnode(&client->dev), 0);
> +       if (chip->interrupts[0] < 0)
> +               return chip->interrupts[0];
> +       if (id->driver_data == AD7150) {

checking  'id->driver_data'  will be flaky after the of_match_table is added;
either we defer the of_match_table patch, or we update it somehow;
maybe a chip_info struct is an idea;
otherwise we need to do void pointer to int conversions [which look nasty];

i'm also seeing that there is a 'type' field inside of_device_id that
is underused, but looks useful for cases like this;
i'm also a bit paranoid to use it; because it may not be compatible
with acpi_device_id

> +               chip->interrupts[1] = fwnode_irq_get(dev_fwnode(&client->dev), 1);
> +               if (chip->interrupts[1] < 0)
> +                       return chip->interrupts[1];
> +       }
> +       if (chip->interrupts[0] &&
> +           (id->driver_data == AD7151 || chip->interrupts[1])) {
> +               irq_set_status_flags(chip->interrupts[0], IRQ_NOAUTOEN);
> +               ret = devm_request_threaded_irq(&client->dev,
> +                                               chip->interrupts[0],
> +                                               NULL,
> +                                               &ad7150_event_handler_ch1,
> +                                               IRQF_TRIGGER_RISING |
> +                                               IRQF_ONESHOT,
> +                                               "ad7150_irq1",
> +                                               indio_dev);
> +               if (ret)
> +                       return ret;
> +
>                 indio_dev->info = &ad7150_info;
>                 switch (id->driver_data) {
>                 case AD7150:
>                         indio_dev->channels = ad7150_channels;
>                         indio_dev->num_channels = ARRAY_SIZE(ad7150_channels);
> +                       irq_set_status_flags(chip->interrupts[1], IRQ_NOAUTOEN);
> +                       ret = devm_request_threaded_irq(&client->dev,
> +                                                       chip->interrupts[1],
> +                                                       NULL,
> +                                                       &ad7150_event_handler_ch2,
> +                                                       IRQF_TRIGGER_RISING |
> +                                                       IRQF_ONESHOT,
> +                                                       "ad7150_irq2",
> +                                                       indio_dev);
> +                       if (ret)
> +                               return ret;
>                         break;
>                 case AD7151:
>                         indio_dev->channels = ad7151_channels;
> @@ -548,25 +603,18 @@ static int ad7150_probe(struct i2c_client *client,
>                         return -EINVAL;
>                 }
>
> -               ret = devm_request_threaded_irq(&client->dev, client->irq,
> -                                               NULL,
> -                                               &ad7150_event_handler,
> -                                               IRQF_TRIGGER_RISING |
> -                                               IRQF_ONESHOT,
> -                                               "ad7150_irq1",
> -                                               indio_dev);
> -               if (ret)
> -                       return ret;
>         } else {
>                 indio_dev->info = &ad7150_info_no_irq;
>                 switch (id->driver_data) {
>                 case AD7150:
>                         indio_dev->channels = ad7150_channels_no_irq;
> -                       indio_dev->num_channels = ARRAY_SIZE(ad7150_channels_no_irq);
> +                       indio_dev->num_channels =
> +                               ARRAY_SIZE(ad7150_channels_no_irq);
>                         break;
>                 case AD7151:
>                         indio_dev->channels = ad7151_channels_no_irq;
> -                       indio_dev->num_channels = ARRAY_SIZE(ad7151_channels_no_irq);
> +                       indio_dev->num_channels =
> +                               ARRAY_SIZE(ad7151_channels_no_irq);
>                         break;
>                 default:
>                         return -EINVAL;
> --
> 2.30.2
>
