Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7AD4797D1
	for <lists+linux-iio@lfdr.de>; Sat, 18 Dec 2021 01:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhLRA1g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Dec 2021 19:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhLRA1g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Dec 2021 19:27:36 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FA5C061574
        for <linux-iio@vger.kernel.org>; Fri, 17 Dec 2021 16:27:35 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id 15so2942528ilq.2
        for <linux-iio@vger.kernel.org>; Fri, 17 Dec 2021 16:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XRnM3iYXRrA5hI+uLod0cFBd1M8IeHaDnlgl6Fbf3kY=;
        b=X6c4fBz5IQy3aWDCLMRdA7iELjhTe/snLmGR8Bwmq0OvCSUJt7rYdKM+OkNsbmG9ia
         ADEDnehzpKzqFXK2px2EiXPXGpZyn3KKhMWcyx1VY4puRgGtvXQshzplFv6ySyyocly3
         XSWlupf+ba3exf/OBrbYcdgxNcSortl4L2l0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XRnM3iYXRrA5hI+uLod0cFBd1M8IeHaDnlgl6Fbf3kY=;
        b=quSRbPt6AhFeXyCSjNdCPg0J2FdLKbJT/Kr8dIW+mxsKZj9pkrxl6Ow3nwen4XxjNs
         azByDS4Z/aeQx5wV07XYgf0/r1W1mn/Mt3R5lX/TBfTRrKYcn0mJTNdTyl3SmYQAedAp
         hMhCuQGs65iTApO67FhxqkyuOLqN6JKm0n6OX0f50kCB7NJyi2tjbDSDn7wqUrjkXxIV
         4X1Qs8/u3zfN2Xly/gWliEyMH0czwi3qnq2xP7i1VuMjBIFduInG9mFqeEzHQymLoO7v
         duvkbskhnsX5ayPyoTWVOO2hZ6pHq+bB0wJHZQW3OoVY61v4xcdSrDV5ocyFWCRAGqyy
         VnQw==
X-Gm-Message-State: AOAM533A40t3c5OHzpZRAT4jEJdGaT5SSk2CRnn5hZQ18NHHzCY8KzO3
        V79MbQstVS4rNadMh7Zt7VZy3o9/DSUZPztwBFtKow==
X-Google-Smtp-Source: ABdhPJwXjaZuiH5rnZ38SiA6xLzsSzNgHLP2WWliN/7z9OjQi3Le20f4DWV+srZH3hZx3taV/xH/8an1gMCUPxXbtkw=
X-Received: by 2002:a92:c244:: with SMTP id k4mr2815118ilo.299.1639787255211;
 Fri, 17 Dec 2021 16:27:35 -0800 (PST)
MIME-Version: 1.0
References: <20211213024057.3824985-1-gwendal@chromium.org>
 <20211213024057.3824985-3-gwendal@chromium.org> <20211216162139.6008820e@jic23-huawei>
In-Reply-To: <20211216162139.6008820e@jic23-huawei>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Fri, 17 Dec 2021 16:27:23 -0800
Message-ID: <CAPUE2usrH8z_QuePonFv4kQrZbYHtovsJ7+DfSChW9xpA9GrTA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] iio: proximity: Add sx9360 support
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     robh+dt@kernel.org, lars@metafoo.de, swboyd@chromium.org,
        andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 16, 2021 at 8:16 AM Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:
>
> On Sun, 12 Dec 2021 18:40:55 -0800
> Gwendal Grignou <gwendal@chromium.org> wrote:
>
> > A simplified version of SX9324, it only have one pin and
> > 2 phases (aka channels).
> > Only one event is presented.
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
>
> You don't use the modifier defined in the previous
> patch...
>
> > ---
> > Changes since v2:
> > - Fix issues reported during sx9324 driver review:
> >   - fix include with iwyu
> >   - Remove call to ACPI_PTR to prevent unused variable warning.
> > - Fix panic when setting frequency to 0.
> > - Add offset to decipher interrupt register
> > - Fix default register value.
> >
> > Changes since v1:
> > - Remove SX9360_DRIVER_NAME
> > - Simplify whoami function
> > - Define WHOAMI register value internally.
> > - Handle negative values when setting sysfs parameters.
> >
> >  drivers/iio/proximity/Kconfig  |  14 +
> >  drivers/iio/proximity/Makefile |   1 +
> >  drivers/iio/proximity/sx9360.c | 807 +++++++++++++++++++++++++++++++++
> >  3 files changed, 822 insertions(+)
> >  create mode 100644 drivers/iio/proximity/sx9360.c
> >
> ....
>
>
> > +static const struct iio_chan_spec sx9360_channels[] = {
> > +     {
> > +             .type = IIO_PROXIMITY,
> > +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +                                   BIT(IIO_CHAN_INFO_HARDWAREGAIN),
> > +             .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> > +             .info_mask_separate_available =
> > +                     BIT(IIO_CHAN_INFO_HARDWAREGAIN),
> > +             .info_mask_shared_by_all_available =
> > +                     BIT(IIO_CHAN_INFO_SAMP_FREQ),
> > +             .extend_name = "reference",
>
> You defined the modifier for this and then didn't use it?
> I've suggested in review of patch 1 you might want to use label though
> via the read_label() callback.
I see, I should have used .cannel2 instead of extend_name. Using label now.
>
>
> > +             .address = SX9360_REG_USEFUL_PHR_MSB,
> > +             .channel = 0,
> > +             .scan_index = 0,
> > +             .scan_type = {
> > +                     .sign = 's',
> > +                     .realbits = 12,
> > +                     .storagebits = 16,
> > +                     .endianness = IIO_BE,
> > +             },
> > +     },
> > +     {
> > +             .type = IIO_PROXIMITY,
> > +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +                                   BIT(IIO_CHAN_INFO_HARDWAREGAIN),
> > +             .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> > +             .info_mask_separate_available =
> > +                     BIT(IIO_CHAN_INFO_HARDWAREGAIN),
> > +             .info_mask_shared_by_all_available =
> > +                     BIT(IIO_CHAN_INFO_SAMP_FREQ),
> > +             .address = SX9360_REG_USEFUL_PHM_MSB,
> > +             .event_spec = sx_common_events,
> > +             .num_event_specs = ARRAY_SIZE(sx_common_events),
> > +             .channel = 1,
> > +             .scan_index = 1,
> > +             .scan_type = {
> > +                     .sign = 's',
> > +                     .realbits = 12,
> > +                     .storagebits = 16,
> > +                     .endianness = IIO_BE,
> > +             },
> > +     },
> > +     IIO_CHAN_SOFT_TIMESTAMP(2),
> > +};
> > +
>
> ...
>
> > +
> > +static int sx9360_read_samp_freq(struct sx_common_data *data,
> > +                              int *val, int *val2)
> > +{
> > +     int ret, divisor;
> > +     __be16 buf;
> > +
> > +     ret = regmap_bulk_read(data->regmap, SX9360_REG_GNRL_CTRL1,
> > +                            &buf, sizeof(buf));
> > +     if (ret < 0)
> > +             return ret;
> > +     divisor = be16_to_cpu(buf);
> > +     if (divisor == 0) {
> > +             *val = 0;
> > +             return IIO_VAL_INT;
> > +     }
> > +
> > +     *val = SX9360_FOSC_HZ;
> > +     *val2 = be16_to_cpu(buf) * 8192;
>
> *val2 = divisor * 8192;?
Done
>
> > +
> > +     return IIO_VAL_FRACTIONAL;
> > +}
> > +
>
> ...
>
> > +static int sx9360_write_raw(struct iio_dev *indio_dev,
> > +                         const struct iio_chan_spec *chan, int val, int val2,
> > +                         long mask)
> > +{
> > +     struct sx_common_data *data = iio_priv(indio_dev);
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_SAMP_FREQ:
> > +             return sx9360_set_samp_freq(data, val, val2);
> > +     case IIO_CHAN_INFO_HARDWAREGAIN:
> > +             return sx9360_write_gain(data, chan, val);
> > +     }
> > +
>
> Slight preference for this as a default in the switch.
Done, changed sx9360_read_avail() as well.
>
> > +     return -EINVAL;
> > +}
>
> ...
>
>
> > +static int sx9360_check_whoami(struct device *dev,
> > +                             struct iio_dev *indio_dev)
>
> Will fit on one line under 80 chars I think..
Done.
>
> > +{
> > +     /*
> > +      * Only one sensor for this driver. Assuming the device tree
> > +      * is correct, just set the sensor name.
> > +      */
> > +     indio_dev->name = "sx9360";
> > +     return 0;
> > +}
> > +
>
> > +
> > +static int __maybe_unused sx9360_suspend(struct device *dev)
> > +{
> > +     struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>
> I don't feel particularly strongly about this, as there are arguments
> either way but this is the same as
>
>         struct iio_dev *indio_dev = dev_get_drvdata(dev);
>
Done in both suspend and resume.

> > +     struct sx_common_data *data = iio_priv(indio_dev);
> > +     unsigned int regval;
> > +     int ret;
> > +
> > +     disable_irq_nosync(data->client->irq);
> > +
> > +     mutex_lock(&data->mutex);
> > +     ret = regmap_read(data->regmap, SX9360_REG_GNRL_CTRL0, &regval);
> > +
> > +     data->suspend_ctrl =
> > +             FIELD_GET(SX9360_REG_GNRL_CTRL0_PHEN_MASK, regval);
> > +
> > +     if (ret < 0)
> > +             goto out;
> > +
> > +     /* Disable all phases, send the device to sleep. */
> > +     ret = regmap_write(data->regmap, SX9360_REG_GNRL_CTRL0, 0);
> > +
> > +out:
> > +     mutex_unlock(&data->mutex);
> > +     return ret;
> > +}
> > +
>
