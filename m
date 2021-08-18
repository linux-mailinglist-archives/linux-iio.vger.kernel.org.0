Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6EE03F0158
	for <lists+linux-iio@lfdr.de>; Wed, 18 Aug 2021 12:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbhHRKKk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Aug 2021 06:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbhHRKKk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Aug 2021 06:10:40 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4687C061764
        for <linux-iio@vger.kernel.org>; Wed, 18 Aug 2021 03:10:05 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id q2so1454701plr.11
        for <linux-iio@vger.kernel.org>; Wed, 18 Aug 2021 03:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UQgzKsT+OypRap9xoc5KjAxY+4qy+e7aPAFuNdSXi6Y=;
        b=r62gedh0CTDdbKEThV/tkJMzOzB1PghfNm7kI3Yu3CLNIw25KUEbpGkdtUQeyGA8KY
         2YKLS9BWOHtB/TXt/bbYyUjFJs/83lY9rrRmVPpsmXvDdDALdfIVdYyl8oMH2/4NusBx
         uTDepmgATFCQwuP8SIpsOEpg/zWoaUZozyYAqWMeeAb0nP1DwRtGMSolQZMCY5CPNQz1
         tcu5w+m9YUqe392uU5l0fsIDNb3hd//zgUWmRHOdsVBtnAev+nhKUGk69Ry7Q0EFaDBf
         xaDsOzOSo272KvBAkVPbIpip3780ztDRoJ6gCdRgURkUog5NydnMhAwdBl2x2jfkT8Ae
         JgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UQgzKsT+OypRap9xoc5KjAxY+4qy+e7aPAFuNdSXi6Y=;
        b=ugMht62vUnjjeIl0KDKGwklxs1HlSUzthEoxujxW4uqmMpNxxKqeA389oDJGU3u1Tg
         yGnbph35WmDIAxRyJyWKH5PwMEcDBSMHhcquYYZVG9LG8v58YOLlgvQH7mjy9PweOCHY
         119GPiGF1YJFy8IqGY9pth58zJzUQWxQHZifb0jStoFvwgWjKRR1OnaynAeBaCmJBg7F
         +XR1TzjQe/2YunY7LuXPwkcIa+FluffoANBTOX/Kb4A0owJK371eT+CXhTveVF0ppRMs
         DZT5koEMZzjfbCWiRgvWEu8LDV3Cmbx+vH4XjrrDSck5GJflyuN8cPptcmjB2FgPSKcU
         eVSA==
X-Gm-Message-State: AOAM533jRNCln4Tj3H5mRogMKHQag4HEGtfYr31QTm9PFVc345/1LDEa
        OQ5bR1KQFlGCS3BGB7XlfTsi9Vnq5p+NQG4W/zM=
X-Google-Smtp-Source: ABdhPJzUlT2xJh3Oltp9+Ssqfl6PHwl13CmHBi1y9IliNpiHjfgZMgvtC0S42mrLAXveAERwC6p2ubhuhU1rX+FZ97M=
X-Received: by 2002:a17:90a:cf18:: with SMTP id h24mr8601097pju.228.1629281405354;
 Wed, 18 Aug 2021 03:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210818092741.2114155-1-sean@geanix.com>
In-Reply-To: <20210818092741.2114155-1-sean@geanix.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 18 Aug 2021 13:09:28 +0300
Message-ID: <CAHp75VdAE=NAgE5yTOo-6Zf+96R1noOAGGrmr8t3vqZMo06Oqw@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: accel: fxls8962af: add threshold event handling
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 18, 2021 at 12:29 PM Sean Nyekjaer <sean@geanix.com> wrote:
>
> Add event channels that controls the creation of motion events.

'channel' or 'control' decide which one should be plural.

> +static int fxls8962af_event_setup(struct fxls8962af_data *data, int state)
> +{
> +       int ret;
> +
> +       /* Enable wakeup interrupt */
> +       ret = regmap_update_bits(data->regmap, FXLS8962AF_INT_EN,
> +                                FXLS8962AF_INT_EN_SDCD_OT_EN,
> +                                state ? FXLS8962AF_INT_EN_SDCD_OT_EN : 0);
> +
> +       return ret;

Redundant ret. Besides that use simply

int mask = FXLS8962AF_INT_EN_SDCD_OT_EN;
int value = state ? mask : 0;

return regmap(..., mask, value);

> +}

...

> +       ret = regmap_bulk_read(data->regmap, FXLS8962AF_SDCD_UTHS_LSB,
> +                              &raw_val, (chan->scan_type.storagebits / 8));

Too many parentheses.
Check also the rest of the code for all comments I have given in this email.

> +       if (ret)
> +               return ret;

...

> +       if (val < 0 || val > 2047)
> +               return -EINVAL;

Can be performed as (val >> 11), but the above is more explicit I think.

...

> +       /* Add the same value to the lower-threshold register with a reversed sign */
> +       data->lower_thres = (-val & 0x80000000) >> 20 | (val & 0x7FF);
> +       data->upper_thres = (val & 0x80000000) >> 20 | (val & 0x7FF);

Why is it so complicated?

Wouldn't lower = -val & GENMASK(10, 0); work?
The upper, btw, has a dead code.

...

> +       ret = regmap_bulk_write(data->regmap, FXLS8962AF_SDCD_LTHS_LSB,
> +                               &data->lower_thres, (chan->scan_type.storagebits / 8));

Missed error check.

> +       ret = regmap_bulk_write(data->regmap, FXLS8962AF_SDCD_UTHS_LSB,
> +                               &data->upper_thres, (chan->scan_type.storagebits / 8));

Ditto.

> +       if (is_active)
> +               ret = fxls8962af_active(data);
> +
> +       return ret;

...

> +       switch (chan->channel2) {
> +       case IIO_MOD_X:
> +               ret = FXLS8962AF_SDCD_CONFIG1_X_OT_EN & data->enable_event;
> +               break;
> +       case IIO_MOD_Y:
> +               ret = FXLS8962AF_SDCD_CONFIG1_Y_OT_EN & data->enable_event;
> +               break;
> +       case IIO_MOD_Z:
> +               ret = FXLS8962AF_SDCD_CONFIG1_Z_OT_EN & data->enable_event;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +

> +       return !!ret;

This is strange.

...

> +       ret = regmap_write(data->regmap, FXLS8962AF_SDCD_CONFIG2, enable_event > 0 ? 0xC0 : 0x00);

Redundant ' > 0'

> +       if (ret)
> +               return ret;

...

> +       if (data->enable_event > 0) {

Ditto.

> +               fxls8962af_active(data);
> +               ret = fxls8962af_power_on(data);
> +       } else {
> +               if (!iio_buffer_enabled(indio_dev))
> +                       ret = fxls8962af_power_off(data);
> +       }

...

> +static const struct iio_event_spec fxls8962af_event = {
> +       .type = IIO_EV_TYPE_THRESH,
> +       .dir = IIO_EV_DIR_EITHER,
> +       .mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +                        BIT(IIO_EV_INFO_ENABLE)

+ comma

> +};

...

> +       if (data->enable_event == 0)

if (!enable_event)

> +               fxls8962af_power_off(data);

...

> +       ret = regmap_read(data->regmap, FXLS8962AF_SDCD_INT_SRC1, &reg);
> +       if (ret | (reg < 0))

This is weird and shadows an actual error.

> +               return -EINVAL;

-- 
With Best Regards,
Andy Shevchenko
