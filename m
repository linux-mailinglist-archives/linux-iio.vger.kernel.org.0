Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2534586335
	for <lists+linux-iio@lfdr.de>; Mon,  1 Aug 2022 06:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiHAEFH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Aug 2022 00:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiHAEFG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Aug 2022 00:05:06 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6354BCA1
        for <linux-iio@vger.kernel.org>; Sun, 31 Jul 2022 21:05:04 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id z132so7613925iof.0
        for <linux-iio@vger.kernel.org>; Sun, 31 Jul 2022 21:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=pTFXNdJ7FANVj/nV6EMUkIvCkQcIh5NNsEoFkkP5Jew=;
        b=EcL2y5/yw2zgLLJYFyBAyLWrJ88piSBgJIsK4cRBYZWpDXIGoGkdkG+w3wSkynWCw8
         EE4wSDeyrxldUqmyzr29JdbPTwhScdSj7G6nuaF3OFNhS335xxozCf5BfW15xrY7Elpv
         cFkJFMe/NlgXWp9PC8qSUnedn0VEU+AGJeU+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=pTFXNdJ7FANVj/nV6EMUkIvCkQcIh5NNsEoFkkP5Jew=;
        b=w8ptnUPTTyfH8KWgCpPkVqkV7AxaOXlxo1VZ3vltqAA5JtUJwa2apixRdzsXsIIGQ4
         WK0UdDESFSKdnzRtlAR7WEhqE9X2bCoYQcSgc0ZtP5APpUF9U9zqdrNfPp9OeWSiqBzP
         0Jd4/YBZEaXI4jjknSbCRSqIH3JBMJUXZr/ZM9BeRRnqb5u8LA3ct4X6MqSEDJpdAyoT
         48LLR7ZbS4UBeQrzAVTEZOTv8/2DWHdHX+pPm4eh46F1DWEi2Y5VQ94HZyWBpmnZ7/uK
         prKJbsmOpXAkrpuc2LKQfJ83pc0SE1gURLEOOiu2190Ycb4NuKfv66nhXHlpbhI/Cwv/
         QeWw==
X-Gm-Message-State: AJIora+/UUNfWVMOzEnmuide9aI6xwO68wC9B/C5HzWhmBeuFXs++ou5
        fHxgq/QO0WBCjtwVJB7pPqpEjSsgiOK6cJ9VSYe6gw==
X-Google-Smtp-Source: AGRyM1vOrIiZsl7D0Uqri99gjfjJEOD7BG5Vaweh586eSS4Cpd3ChinEt0YiCYnp3XF3wQPV3oCGPaQO16zpwbcPLJc=
X-Received: by 2002:a6b:7a41:0:b0:67b:ee1b:372d with SMTP id
 k1-20020a6b7a41000000b0067bee1b372dmr4825112iop.3.1659326703979; Sun, 31 Jul
 2022 21:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220729154723.99947-1-matt.ranostay@konsulko.com> <20220731125752.3e6b1919@jic23-huawei>
In-Reply-To: <20220731125752.3e6b1919@jic23-huawei>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Mon, 1 Aug 2022 12:04:52 +0800
Message-ID: <CAJCx=g=jc9KFQeu3uAD--tMJcLrSzy45vijCPpcxnRrgiYo-=Q@mail.gmail.com>
Subject: Re: [PATCH] HID: mcp2221: add ADC/DAC support via iio subsystem
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        Rishi Gupta <gupt21@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jul 31, 2022 at 7:47 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 29 Jul 2022 23:47:23 +0800
> Matt Ranostay <matt.ranostay@konsulko.com> wrote:
>
> > Add support for 3x 10-bit ADC and 1x DAC channels registered via
> > the iio subsystem.
> >
> > To prevent breakage and unexpected dependencies this support only is
> > only built if CONFIG_IIO is enabled, and is only weakly referenced by
> > 'imply IIO' within the respective Kconfig.
>
> Seems ok, but I've not seen this done before, so will rely on others
> to feedback on that element.
>
> Otherwise, various comments inline.
>
> >
> > Additionally the iio device only gets registered if at least one channel
> > is enabled in the power-on configuration read from SRAM.
> >
> > Cc: Rishi Gupta <gupt21@gmail.com>
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> > ---
> >  drivers/hid/Kconfig       |   3 +-
> >  drivers/hid/hid-mcp2221.c | 207 ++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 209 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > index 6ce92830b5d1..eb4f4bb05226 100644
> > --- a/drivers/hid/Kconfig
> > +++ b/drivers/hid/Kconfig
> > @@ -1298,7 +1298,8 @@ config HID_ALPS
> >  config HID_MCP2221
> >       tristate "Microchip MCP2221 HID USB-to-I2C/SMbus host support"
> >       depends on USB_HID && I2C
> > -     depends on GPIOLIB
> > +     select GPIOLIB
> > +     imply IIO
> >       help
> >       Provides I2C and SMBUS host adapter functionality over USB-HID
> >       through MCP2221 device.
> > diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
> > index de52e9f7bb8c..ab8ca2a65592 100644
> > --- a/drivers/hid/hid-mcp2221.c
> > +++ b/drivers/hid/hid-mcp2221.c
> > @@ -16,6 +16,8 @@
> >  #include <linux/hidraw.h>
> >  #include <linux/i2c.h>
> >  #include <linux/gpio/driver.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
>
> I can't immediately see why you need iio/sysfs.h
> That's normally only relevant if non standard ABI is in use.
>
> >  #include "hid-ids.h"
> >
> >  /* Commands codes in a raw output report */
> > @@ -30,6 +32,8 @@ enum {
> >       MCP2221_I2C_CANCEL = 0x10,
> >       MCP2221_GPIO_SET = 0x50,
> >       MCP2221_GPIO_GET = 0x51,
> > +     MCP2221_SET_SRAM_SETTINGS = 0x60,
> > +     MCP2221_GET_SRAM_SETTINGS = 0x61,
> >  };
> >
> >  /* Response codes in a raw input report */
> > @@ -89,6 +93,7 @@ struct mcp2221 {
> >       struct i2c_adapter adapter;
> >       struct mutex lock;
> >       struct completion wait_in_report;
> > +     struct delayed_work init_work;
> >       u8 *rxbuf;
> >       u8 txbuf[64];
> >       int rxbuf_idx;
> > @@ -97,6 +102,17 @@ struct mcp2221 {
> >       struct gpio_chip *gc;
> >       u8 gp_idx;
> >       u8 gpio_dir;
> > +     u8 mode[4];
> > +#if IS_REACHABLE(CONFIG_IIO)
> > +     struct iio_chan_spec iio_channels[3];
> > +     struct iio_dev *indio_dev;
> > +     u16 adc_values[3];
> > +     u8 dac_value;
> > +#endif
> > +};
> > +
> > +struct mcp2221_iio {
> > +     struct mcp2221 *mcp;
> >  };
> >
> >  /*
> > @@ -745,6 +761,10 @@ static int mcp2221_raw_event(struct hid_device *hdev,
> >                               break;
> >                       }
> >                       mcp->status = mcp_get_i2c_eng_state(mcp, data, 8);
> > +#if IS_REACHABLE(CONFIG_IIO)
> > +                     if (mcp->indio_dev)
> > +                             memcpy(&mcp->adc_values, &data[50], 6);
> > +#endif
> >                       break;
> >               default:
> >                       mcp->status = -EIO;
> > @@ -816,6 +836,32 @@ static int mcp2221_raw_event(struct hid_device *hdev,
> >               complete(&mcp->wait_in_report);
> >               break;
> >
> > +     case MCP2221_SET_SRAM_SETTINGS:
> > +             switch (data[1]) {
> > +             case MCP2221_SUCCESS:
> > +                     mcp->status = 0;
> > +                     break;
> > +             default:
> > +                     mcp->status = -EAGAIN;
> > +             }
> > +             complete(&mcp->wait_in_report);
> > +             break;
> > +
> > +     case MCP2221_GET_SRAM_SETTINGS:
> > +             switch (data[1]) {
> > +             case MCP2221_SUCCESS:
> > +                     memcpy(&mcp->mode, &data[22], 4);
> > +#if IS_REACHABLE(CONFIG_IIO)
> > +                     mcp->dac_value = data[6] & GENMASK(4, 0);
> Might be worth converting to more readable mask define and
> FIELD_GET()
>
> > +#endif
> > +                     mcp->status = 0;
> > +                     break;
> > +             default:
> > +                     mcp->status = -EAGAIN;
> > +             }
> > +             complete(&mcp->wait_in_report);
> > +             break;
> > +
> >       default:
> >               mcp->status = -EIO;
> >               complete(&mcp->wait_in_report);
> > @@ -824,6 +870,158 @@ static int mcp2221_raw_event(struct hid_device *hdev,
> >       return 1;
> >  }
> >
> > +#if IS_REACHABLE(CONFIG_IIO)
> > +static int mcp2221_read_raw(struct iio_dev *indio_dev,
> > +                         struct iio_chan_spec const *channel, int *val,
> > +                         int *val2, long mask)
> > +{
> > +
> No blank line here
> > +     struct mcp2221_iio *priv = iio_priv(indio_dev);
> > +     struct mcp2221 *mcp = priv->mcp;
> > +     int ret;
> > +
> > +     mutex_lock(&mcp->lock);
> For readability I'd prefer this duplicated in each of the
> branches so clearly matched against the unlocks.
>
> > +
> > +     if (channel->output) {
> > +             *val = mcp->dac_value;
> > +
> > +             mutex_unlock(&mcp->lock);
> > +     } else {
> > +             // Read ADC values
> As below.
>
> > +             ret = mcp_chk_last_cmd_status(mcp);
> > +             if (ret < 0) {
> > +                     mutex_unlock(&mcp->lock);
> > +                     return ret;
> > +             }
> > +
> > +             *val = le16_to_cpu(mcp->adc_values[channel->address]);
> > +
> > +             mutex_unlock(&mcp->lock);
> > +
> > +             // Confirm value is within 10-bit range
> > +             if (*val > GENMASK(9, 0))
> > +                     return -EINVAL;
> > +     }
> > +
> > +     return IIO_VAL_INT;
> > +}
> > +
> > +static int mcp2221_write_raw(struct iio_dev *indio_dev,
> > +                          struct iio_chan_spec const *chan,
> > +                          int val, int val2, long mask)
> > +{
> > +     struct mcp2221_iio *priv = iio_priv(indio_dev);
> > +     struct mcp2221 *mcp = priv->mcp;
> > +     int ret;
> > +
> > +     if (val < 0 || val > GENMASK(4, 0))
> This is a bit wierd.  I'd either expect comparison with a number
> rather than a mask, or FIELD_FIT()

Personally I'm fine with that or just using >= 31 for instance

>
>
> > +             return -EINVAL;
> > +
> Single blank line is enough.
> > +
> > +     hid_hw_power(mcp->hdev, PM_HINT_FULLON);
> > +
> > +     mutex_lock(&mcp->lock);
> > +
> > +     memset(mcp->txbuf, 0, 12);
> > +     mcp->txbuf[0] = MCP2221_SET_SRAM_SETTINGS;
> > +     mcp->txbuf[4] = BIT(7) | val;
>
> Given GENMASK usage above, FIELD_PREP() would make this
> more 'self documenting' both for the val and BIT(7)

BIT(7) signals that the field is changed for the transaction so it can
update the value.

>
> > +
> > +     ret = mcp_send_data_req_status(mcp, mcp->txbuf, 12);
> > +
> > +     hid_hw_power(mcp->hdev, PM_HINT_NORMAL);
> > +
> > +     if (ret) {
> > +             mutex_unlock(&mcp->lock);
> > +             return -EINVAL;
> > +     }
> > +
> > +     mcp->dac_value = val;
> > +
> > +     mutex_unlock(&mcp->lock);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct iio_info mcp2221_info = {
> > +     .read_raw = &mcp2221_read_raw,
> > +     .write_raw = &mcp2221_write_raw,
> > +};
> > +
> > +static int mcp_iio_channels(struct mcp2221 *mcp)
> > +{
> > +     int idx, cnt = 0;
> > +     bool dac_created = false;
> > +
> > +     // GP0 doesn't have ADC/DAC alternative function
>
> Not consistent with comment style in this driver. /* ... */
>
> > +     for (idx = 1; idx < MCP_NGPIO; idx++) {
> > +             struct iio_chan_spec *chan = &mcp->iio_channels[cnt];
> > +
> > +             switch (mcp->mode[idx]) {
> > +             case 2:
> > +                     chan->address = idx - 1;
> > +                     chan->channel = cnt++;
> > +                     break;
> > +             case 3:
> > +                     // GP1 doesn't have DAC alternative function
>
> As above.
>
> > +                     if (idx == 1 || dac_created)
> > +                             continue;
> > +                     // DAC1 and DAC2 outputs are connected to the same DAC
> > +                     dac_created = true;
> > +                     chan->output = 1;
> > +                     cnt++;
> > +                     break;
> > +             default:
> > +                     continue;
> > +             };
> > +
> > +             chan->type = IIO_VOLTAGE;
> > +             chan->indexed = 1;
> > +             chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> > +             chan->scan_index = -1;
> > +     }
> > +
> > +     return cnt;
> > +}
> > +
> > +static void mcp_init_work(struct work_struct *work)
> > +{
> > +     struct mcp2221 *mcp = container_of(work, struct mcp2221, init_work.work);
> > +     struct mcp2221_iio *iio;
> > +     int ret, num_channels;
> > +
> > +     hid_hw_power(mcp->hdev, PM_HINT_FULLON);
> > +
> > +     mutex_lock(&mcp->lock);
> > +
> > +     mcp->txbuf[0] = MCP2221_GET_SRAM_SETTINGS;
> > +
> > +     ret = mcp_send_data_req_status(mcp, mcp->txbuf, 1);
> > +
> > +     hid_hw_power(mcp->hdev, PM_HINT_NORMAL);
> > +     mutex_unlock(&mcp->lock);
> > +
> > +     if (ret)
> > +             return;
> > +
> > +     num_channels = mcp_iio_channels(mcp);
> > +     if (!num_channels)
> > +             return;
> > +
> > +     mcp->indio_dev = devm_iio_device_alloc(&mcp->hdev->dev, sizeof(*iio));
> This can fail.

Noted.

> > +
> > +     iio = iio_priv(mcp->indio_dev);
> > +     iio->mcp = mcp;
> > +
> > +     mcp->indio_dev->name = "mcp2221";
> > +     mcp->indio_dev->modes = INDIO_DIRECT_MODE;
> > +     mcp->indio_dev->info = &mcp2221_info;
> > +     mcp->indio_dev->channels = mcp->iio_channels;
> > +     mcp->indio_dev->num_channels = num_channels;
> > +
> > +     iio_device_register(mcp->indio_dev);
> As can this.  You need to check both.
>

Noted.

> > +}
> > +#endif
> > +
> >  static int mcp2221_probe(struct hid_device *hdev,
> >                                       const struct hid_device_id *id)
> >  {
> > @@ -902,6 +1100,11 @@ static int mcp2221_probe(struct hid_device *hdev,
> >       if (ret)
> >               goto err_gc;
> >
> > +#if IS_REACHABLE(CONFIG_IIO)
> > +     INIT_DELAYED_WORK(&mcp->init_work, mcp_init_work);
> > +     schedule_delayed_work(&mcp->init_work, msecs_to_jiffies(500));
> > +#endif
> > +
> >       return 0;
> >
> >  err_gc:
> > @@ -920,6 +1123,10 @@ static void mcp2221_remove(struct hid_device *hdev)
> >       i2c_del_adapter(&mcp->adapter);
> >       hid_hw_close(mcp->hdev);
> >       hid_hw_stop(mcp->hdev);
> > +#if IS_REACHABLE(CONFIG_IIO)
> > +     if (mcp->indio_dev)
> > +             iio_device_unregister(mcp->indio_dev);
> > +#endif
> I'd expect remove to be reverse order of probe. Mind you this driver has a fun
> mix of devm and non devm which makes it very hard to reason about correctness
> and potential race conditions.  I would personally advocate preceding this
> patch with a cleanup of that side of things (probably mass usage of devm_add_action_or_reset()
> and appropriate callbacks).

Yeah the mix of devm and non-devm i agree is less than ideal..

 - Matt
>
> Jonathan
>
> >  }
> >
> >  static const struct hid_device_id mcp2221_devices[] = {
>
