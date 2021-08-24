Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5919D3F5DBE
	for <lists+linux-iio@lfdr.de>; Tue, 24 Aug 2021 14:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236983AbhHXMQy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Aug 2021 08:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236676AbhHXMQw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Aug 2021 08:16:52 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EF9C061757
        for <linux-iio@vger.kernel.org>; Tue, 24 Aug 2021 05:16:08 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id k24so19596215pgh.8
        for <linux-iio@vger.kernel.org>; Tue, 24 Aug 2021 05:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rfkPQDRQPY89UjZwFD8p2mGydRy98CMfz8jPGMPOoxQ=;
        b=k8Vu2W/1zwCKq6YEHKIj20okc11qBNKCkZUffz0tqBT73Yezc++wW2AWWHzoDl/LLi
         r76iH+F9xgs4QIe930XErWMfmpZgK7SC/Ys+4hBYVLnwsEhiWG3AFvJcYHXvfeM1BdHB
         sth0LqT37lvBobV/OKyNtBjKhgWzdBeIiDMVs/zIZrVZxEhImPhTXYN954jYAMR7qgGU
         wUDMt/9VWsdK6TakZP1QrJghks5sG5KfZ/wjd1YanIVJlBD8+5hO1WasoL86Yjv2Naz/
         PDhLg4cp//iu1XFgDbwiBIDLwpo39tnbCn1Mu00BbFErPWtqOOTC6w5pn9bAH5rAr0Ef
         s3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rfkPQDRQPY89UjZwFD8p2mGydRy98CMfz8jPGMPOoxQ=;
        b=U4ZeMVwh0w+yaPEUqYQTgbHku/wdz0T5PLr4r6fY65dNHdcISghVjO8M3tKqfbxCUW
         4cnyK436J72QBG+nbGK80Wf+sJsACSrNlquqfEp3V5KFzrAZj4T1ZxK9gm0z0c1VZ6oA
         bMIKBKQlmLiwKIn1wmS2ixb+TwnJXofEIwxmwCMM6N3uvuIwUDRhWl4I1VFZksZEctii
         agsoH+hOIjScOeBgmF9eL/NwALKV8+0LM0iWENsnCV28/utNzzZJ65FQL0PR5SCZ1Ber
         GElCGYhIg2lpx8N51yl0fWFu8cBMkFy12+4NY35sydqmtOBoqNHDFFcrqf6MYfDMLn3P
         66Uw==
X-Gm-Message-State: AOAM5319uqhTbLi2vieaF802r3N3axgumRD2y+5Qsv06x6JaegAqWqH8
        KZ3/xBM1iIK4jOv45Ejlw9LYJHr7EJpL1qQC8vA=
X-Google-Smtp-Source: ABdhPJyvLQRMLT2cEDieei8Eb+i/ALRZQcSO46dnPaaqaxLCHAY/LsNaehLWtiAFznXPDR8sGZNlwxzmeLp4YclxjQ8=
X-Received: by 2002:a63:4464:: with SMTP id t36mr4862019pgk.4.1629807367682;
 Tue, 24 Aug 2021 05:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210824113709.1834195-1-sean@geanix.com>
In-Reply-To: <20210824113709.1834195-1-sean@geanix.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 24 Aug 2021 15:15:28 +0300
Message-ID: <CAHp75VeMzs+xyksGB8Kcnr-09a740eoWYmEJQHgbhMNVbuzAwA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: accel: fxls8962af: add threshold event handling
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 24, 2021 at 2:38 PM Sean Nyekjaer <sean@geanix.com> wrote:

...

> Do we have some helper functions to do the 12 bit 2-complement numbers?

Probably not, look around where sign_extend32() is defined. More on this below.

...

> +       return regmap_update_bits(data->regmap, FXLS8962AF_INT_EN,
> +                                mask,
> +                                value);

One line?

...

> +       /*
> +        * Add the same value to the lower-threshold register with a reversed sign
> +        * in 2-complement 12 bit format.
> +        */
> +       data->lower_thres = (~val & GENMASK(11, 0)) + 1;

This looks suspicious.

0 => 0xfff + 1 => 0x1000. Is it what is wanted?
I thought that -val & mask is what you need.

Can you explain more in the comment (maybe with examples) on what is
coming and what is expected?

> +       data->upper_thres = val & GENMASK(10, 0);

...

> +       is_active = fxls8962af_is_active(data);
> +       if (is_active) {
> +               ret = fxls8962af_standby(data);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       ret = regmap_bulk_write(data->regmap, FXLS8962AF_SDCD_LTHS_LSB,
> +                               &data->lower_thres, chan->scan_type.storagebits / 8);
> +       if (ret)
> +               return ret;
> +
> +       ret = regmap_bulk_write(data->regmap, FXLS8962AF_SDCD_UTHS_LSB,
> +                               &data->upper_thres, chan->scan_type.storagebits / 8);
> +       if (ret)
> +               return ret;
> +
> +       if (is_active)
> +               ret = fxls8962af_active(data);

I would rewrite it with a helper

if (..._is_active(...)) {
  ret = ..._standby(...);
  ...
  ret = _set_thresholds(...);
  ...
  ret = _active(...);
} else {
  ret = _set_thresholds(...);
}
return ret;

or something closer to it.

> +       return ret;
> +}

...

> +       int ret;

Useless

> +       if (type != IIO_EV_TYPE_THRESH)
> +               return -EINVAL;
> +
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

> +       return ret;

Just return directly from the cases.

...

> +       ret = regmap_write(data->regmap, FXLS8962AF_SDCD_CONFIG2, enable_event ? 0xC0 : 0x00);

0xc0

> +       if (ret)
> +               return ret;

....

> +       .mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +                        BIT(IIO_EV_INFO_ENABLE),

One line?

-- 
With Best Regards,
Andy Shevchenko
