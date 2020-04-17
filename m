Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9061AE752
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 23:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgDQVLC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 17:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgDQVLB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 17:11:01 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E70C061A0C;
        Fri, 17 Apr 2020 14:11:01 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id w20so3925542iob.2;
        Fri, 17 Apr 2020 14:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OlJHu2tNIRXilHBPRkOqOH56O/SKw0eGa9SbGUKri/I=;
        b=IPvvVVaTbCBrVHxOQannxvijirEKYdyuFI3EY6lupoF4gZjUlVvngD0Bpe/lyCT9Uc
         jyVK/ASI1lavaq/GtpOeuDiVtlQARpmrpIJpF2uMVHQJgfe6+meMZ2+ToRSXf0BxSjzx
         I1GnhxOyCSZA1OcGlAU3LnRdsrnhcHjHhKoOH/Qyvx00+48r55qku3V7iR4R7p92foCS
         8IAPXE+fN7NUFhskpXc0lEbgXgfyG/HBkbG+I+Kz2PE6dHvP3gVKqcdOHQ5FZS5WEGXf
         zcjNe/ZU/mZyPfNizmlzBMnEkDdgZ3xk6vrtZq30n/ZCCOSYftArEWIEtD7qL6whdRjB
         nLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OlJHu2tNIRXilHBPRkOqOH56O/SKw0eGa9SbGUKri/I=;
        b=fum/YS7qLUhwPyC5Gye7JksuDZM4BAtY8jEb1XH5dNPd7EeuVB3AARuNjALLzI0Zh8
         BGIVJ+8b5F7v5fmpoN2cSo/CnAeM+la9a2xc4fNzRoiD9k/5OKTscnthmmFotjm6O57u
         dStde9sLHrGC7krQ53fyxYKJEZ1Rgv9YKZeahhepEOQTWzdxFSABJVYCh1c+eRNR1wBD
         eNawgNl7FYDO8o5I4ES1nL+CQVU1yKzndHRpZFzpY5rVRFcs90dU/SCbl9L7uD5RFaUw
         Fq+LflUFFSteaILJXc3Lrwu4+TRkjUQ+eo3syFE2MClzpzUyPVF1MCpPu7Ym+BR/YXYv
         SPFg==
X-Gm-Message-State: AGi0PuZYFasaT9c49Vt3uF1yRkGWqmMrmPvA+05mPU/8uJT1+EAyT8oQ
        Bh1k1HwVXNYZTVCdaltM7tWl2jU695+JaqM0Egg=
X-Google-Smtp-Source: APiQypIwrfIN47EKCM+k+nQMgN0YMdfXIBKXrLZf67ebNQ3PQCjJg4xmrZKDsH9ryfjvK/p0Dul/uUyUIvlovW5A+mw=
X-Received: by 2002:a6b:f60f:: with SMTP id n15mr5150493ioh.22.1587157861052;
 Fri, 17 Apr 2020 14:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200417202859.35427-1-contact@artur-rojek.eu> <20200417202859.35427-5-contact@artur-rojek.eu>
In-Reply-To: <20200417202859.35427-5-contact@artur-rojek.eu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 18 Apr 2020 00:10:49 +0300
Message-ID: <CAHp75VfRbnnuUhfyXpu+5dp4TutHSrHus=sX_vG_5F0dX4k0fQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 5/5] input: joystick: Add ADC attached joystick driver.
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-input <linux-input@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 17, 2020 at 11:21 PM Artur Rojek <contact@artur-rojek.eu> wrote:
>
> Add a driver for joystick devices connected to ADC controllers
> supporting the Industrial I/O subsystem.

...

> +#include <linux/of.h>

Do you really need this? (See below as well)

...

> +               sign = (tolower(joy->chans[i].channel->scan_type.sign) == 's');

Too many parentheses. But here it's up to you,

...

> +               case 2:

> +                       val = ((const u16 *)data)[i];

Can't you do this in each branch below?

> +                       if (endianness == IIO_BE)
> +                               val = be16_to_cpu(val);
> +                       else if (endianness == IIO_LE)
> +                               val = le16_to_cpu(val);
> +                       break;

...

> +       device_for_each_child_node(dev, child) {
> +               ret = fwnode_property_read_u32(child, "reg", &i);
> +               if (ret || i >= num_axes) {
> +                       dev_err(dev, "reg invalid or missing");
> +                       goto err;
> +               }
> +
> +               if (fwnode_property_read_u32(child, "linux,code",
> +                                            &axes[i].code)) {
> +                       dev_err(dev, "linux,code invalid or missing");
> +                       goto err;
> +               }
> +
> +               if (fwnode_property_read_u32_array(child, "abs-range",
> +                                                  axes[i].range, 2)) {
> +                       dev_err(dev, "abs-range invalid or missing");
> +                       goto err;
> +               }

> +       }
> +
> +       joy->axes = axes;
> +
> +       return 0;
> +
> +err:
> +       fwnode_handle_put(child);

> +       return -EINVAL;

Can we avoid shadowing the actual error code?

...

> +       bits = joy->chans[0].channel->scan_type.storagebits;

> +       if (!bits || (bits >> 3) > 2) {

Wouldn't be clear to use simple 'bits > 16'?

> +               dev_err(dev, "Unsupported channel storage size");
> +               return -EINVAL;
> +       }

...

> +static const struct of_device_id adc_joystick_of_match[] = {
> +       { .compatible = "adc-joystick", },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(of, adc_joystick_of_match);
> +
> +static struct platform_driver adc_joystick_driver = {
> +       .driver = {
> +               .name = "adc-joystick",

> +               .of_match_table = of_match_ptr(adc_joystick_of_match),

Drop this a bit harmful of_match_ptr() macro. It should go with ugly
#ifdeffery. Here you simple introduced a compiler warning.
On top of that, you are using device property API, OF use in this case
is contradictory (at lest to some extend).

> +       },
> +       .probe = adc_joystick_probe,
> +};

-- 
With Best Regards,
Andy Shevchenko
