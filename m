Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F8C2BB512
	for <lists+linux-iio@lfdr.de>; Fri, 20 Nov 2020 20:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732302AbgKTTRW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Nov 2020 14:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732256AbgKTTRV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Nov 2020 14:17:21 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F07C0613CF
        for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2020 11:17:20 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id a19so3726287ilm.3
        for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2020 11:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n72QtqxwvMxLCx1CU/CeXC/nwzGmQTMNnKWTylUj9HA=;
        b=BvvYqyJhvp0WkLBJ0Zd+GJ51me9Hv41gxzxpDRWj4y+ecErZ51cEg9e8l2TRlCJq33
         jCGJ54LzHnaHMMI655yLzdstOnV6003l/fNT7/hZEthsoUp1tJkPVzB58A8xqXY379l6
         dYgBLT+8oJir4k7sYVH2TvcdrYbgNRvK9xpNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n72QtqxwvMxLCx1CU/CeXC/nwzGmQTMNnKWTylUj9HA=;
        b=DkbFDTVLPMQAGdC/MOoLAJ/SlkO5ZwGvmxy4hTRGK/trmNLwT3GcjMSP2bcQMqtZ1A
         S4XLtVeDfVikNXZd/GKJudsT+0potcfpUF3Ozbo1tg87aiksJnxskKWxl1EqkdA/wgDJ
         JVgwooHu8gK0FMM//khvb7nCMCaXVo+OqwsYCuqR094N9eU4JcrRxr7k8tDhAG0//ymt
         wA0qbJzdxKCAezWPNwLQFtuQUsmiY0BprdohZH9YkVK/WO4NZJgwphjthreVFh/P8fC2
         5IjoLKJWR6JTzgnZyM9GuYQKDrIFw5N3SZY7/DO8T2BfQvR8qEk+8bRYYOZZrrOGv5VL
         nofQ==
X-Gm-Message-State: AOAM531VzBbdeK+EQNinZrAdTzigJ1ZrZILu5N8bQH+/GG1zK8PNHRbS
        UGrHD7JXpmAz0qkwU8t0GNcyiOa1AYdubLW1/J1d7tS/VQnHsg==
X-Google-Smtp-Source: ABdhPJyrgCfV8zWO65OhrRScNT1yfRDIROgX3hTXf8/a+y8PDb2MofLyUfW4zJbzuJcv45Sx69/c2wiEAFeFOlJPZn8=
X-Received: by 2002:a92:5f03:: with SMTP id t3mr28675217ilb.25.1605899839781;
 Fri, 20 Nov 2020 11:17:19 -0800 (PST)
MIME-Version: 1.0
References: <20201120030103.36138-1-matt.ranostay@konsulko.com> <CALUj-guTNWK9m-bwmkRC3st9VExhFkXPiUevXw_EA9xamR6BYA@mail.gmail.com>
In-Reply-To: <CALUj-guTNWK9m-bwmkRC3st9VExhFkXPiUevXw_EA9xamR6BYA@mail.gmail.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Fri, 20 Nov 2020 11:17:08 -0800
Message-ID: <CAJCx=gn=jAeYkVtLQ8Ou7P9xRpvSaXpuUk5XWDxMD_HPMTzH+Q@mail.gmail.com>
Subject: Re: [PATCH] HID: mcp2221: add ADC support
To:     rishi gupta <gupt21@gmail.com>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Nov 20, 2020 at 5:15 AM rishi gupta <gupt21@gmail.com> wrote:
>
> On Fri, Nov 20, 2020 at 8:31 AM Matt Ranostay
> <matt.ranostay@konsulko.com> wrote:
> >
> > Add support for the three 10-bit ADC channels registered via
> > the IIO subsystem.
> >
> > Cc: linux-input@vger.kernel.org
> > Cc: linux-iio@vger.kernel.org
> > CC: Rishi Gupta <gupt21@gmail.com>
> > Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> > ---
> >  drivers/hid/Kconfig       |  1 +
> >  drivers/hid/hid-mcp2221.c | 65 ++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 65 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > index 05315b434276..4795744d9979 100644
> > --- a/drivers/hid/Kconfig
> > +++ b/drivers/hid/Kconfig
> > @@ -1157,6 +1157,7 @@ config HID_MCP2221
> >         tristate "Microchip MCP2221 HID USB-to-I2C/SMbus host support"
> >         depends on USB_HID && I2C
> >         depends on GPIOLIB
> > +       depends on IIO
> I am wondering what will happen on systems which do not enable IIO.
> This driver can not be used there.
> Is my understanding correct?

Actually yeah this should be "select IIO" to avoid that issue.

- Matt

> >         help
> >         Provides I2C and SMBUS host adapter functionality over USB-HID
> >         through MCP2221 device.
> > diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
> > index 0d27ccb55dd9..7e62f1dc54d3 100644
> > --- a/drivers/hid/hid-mcp2221.c
> > +++ b/drivers/hid/hid-mcp2221.c
> > @@ -18,6 +18,9 @@
> >  #include <linux/gpio/driver.h>
> >  #include "hid-ids.h"
> >
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +
> >  /* Commands codes in a raw output report */
> >  enum {
> >         MCP2221_I2C_WR_DATA = 0x90,
> > @@ -56,6 +59,7 @@ enum {
> >   */
> >  struct mcp2221 {
> >         struct hid_device *hdev;
> > +       struct iio_dev *indio_dev;
> >         struct i2c_adapter adapter;
> >         struct mutex lock;
> >         struct completion wait_in_report;
> > @@ -67,6 +71,11 @@ struct mcp2221 {
> >         struct gpio_chip *gc;
> >         u8 gp_idx;
> >         u8 gpio_dir;
> > +       u16 adc_values[3];
> > +};
> > +
> > +struct mcp2221_iio {
> > +       struct mcp2221 *mcp;
> >  };
> >
> >  /*
> > @@ -712,6 +721,7 @@ static int mcp2221_raw_event(struct hid_device *hdev,
> >                                 break;
> >                         }
> >                         mcp->status = mcp_get_i2c_eng_state(mcp, data, 8);
> > +                       memcpy(&mcp->adc_values, &data[50], 6);
> >                         break;
> >                 default:
> >                         mcp->status = -EIO;
> > @@ -791,11 +801,54 @@ static int mcp2221_raw_event(struct hid_device *hdev,
> >         return 1;
> >  }
> >
> > +static int mcp2221_read_raw(struct iio_dev *indio_dev,
> > +                           struct iio_chan_spec const *channel, int *val,
> > +                           int *val2, long mask)
> > +{
> > +
> > +       struct mcp2221_iio *priv = iio_priv(indio_dev);
> > +       struct mcp2221 *mcp = priv->mcp;
> > +       int ret;
> > +
> > +       mutex_lock(&mcp->lock);
> > +
> > +       /* Read ADC values */
> > +       ret = mcp_chk_last_cmd_status(mcp);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       *val = le16_to_cpu(mcp->adc_values[channel->channel]);
> > +
> > +       mutex_unlock(&mcp->lock);
> > +
> > +       return IIO_VAL_INT;
> > +}
> > +
> > +static const struct iio_info mcp2221_info = {
> > +       .read_raw = &mcp2221_read_raw,
> > +};
> > +
> > +#define MCP2221_ADC_CHANNEL(idx) \
> > +       { \
> > +               .type = IIO_VOLTAGE, \
> > +               .indexed = 1, \
> > +               .channel = idx, \
> > +               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> > +               .scan_index = -1, \
> > +       }
> > +
> > +static const struct iio_chan_spec mcp2221_channels[] = {
> > +       MCP2221_ADC_CHANNEL(0),
> > +       MCP2221_ADC_CHANNEL(1),
> > +       MCP2221_ADC_CHANNEL(2),
> > +};
> > +
> >  static int mcp2221_probe(struct hid_device *hdev,
> >                                         const struct hid_device_id *id)
> >  {
> >         int ret;
> >         struct mcp2221 *mcp;
> > +       struct mcp2221_iio *iio;
> >
> >         mcp = devm_kzalloc(&hdev->dev, sizeof(*mcp), GFP_KERNEL);
> >         if (!mcp)
> > @@ -869,8 +922,17 @@ static int mcp2221_probe(struct hid_device *hdev,
> >         if (ret)
> >                 goto err_gc;
> >
> > -       return 0;
> > +       mcp->indio_dev = devm_iio_device_alloc(&hdev->dev, sizeof(*iio));
> > +       iio = iio_priv(mcp->indio_dev);
> > +       iio->mcp = mcp;
> > +
> > +       mcp->indio_dev->name = "mcp2221_adc";
> > +       mcp->indio_dev->modes = INDIO_DIRECT_MODE;
> > +       mcp->indio_dev->info = &mcp2221_info;
> > +       mcp->indio_dev->channels = mcp2221_channels;
> > +       mcp->indio_dev->num_channels = ARRAY_SIZE(mcp2221_channels);
> >
> > +       return iio_device_register(mcp->indio_dev);
> >  err_gc:
> >         i2c_del_adapter(&mcp->adapter);
> >  err_i2c:
> > @@ -884,6 +946,7 @@ static void mcp2221_remove(struct hid_device *hdev)
> >  {
> >         struct mcp2221 *mcp = hid_get_drvdata(hdev);
> >
> > +       iio_device_unregister(mcp->indio_dev);
> >         i2c_del_adapter(&mcp->adapter);
> >         hid_hw_close(mcp->hdev);
> >         hid_hw_stop(mcp->hdev);
> > --
> > 2.20.1
> >
