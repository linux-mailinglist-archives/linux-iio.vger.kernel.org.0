Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30D43F0183
	for <lists+linux-iio@lfdr.de>; Wed, 18 Aug 2021 12:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbhHRKUI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Aug 2021 06:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbhHRKUB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Aug 2021 06:20:01 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EC7C06179A
        for <linux-iio@vger.kernel.org>; Wed, 18 Aug 2021 03:19:23 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id y23so1751520pgi.7
        for <linux-iio@vger.kernel.org>; Wed, 18 Aug 2021 03:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O/0AmWJ2zZ9jBOUKiBYokfwpQ0K25nIbKKNBnHZRFQ4=;
        b=UMAa8Q1DHk6z2OzI/1bDWuF/sm85HCg5YHHil3lDzeANeUjIofTkQHcUDoqJgAqeC3
         uq8CnLn8t5a8VRVlM6iPsmOmis/0XQ9uXkEJ5vNEYSgiunFGwpLOTNe3zPWkxEAjZ3Ep
         ZIJmsY7RHaNISMkEyBcscTtdpEBloyfd0NfdvKY/Nf+/xSzPH8XrrHjkvV4SZHw/ScCT
         yx/gfmUwYW+z0T1KZGy2bEY8gb1x9//p2DTDXuvoou98aQA2imV4qXs3jTqFBGmmIBt5
         Jim4zWfLdXZxAi8lhLEgUQ9uL7uKoEdOGnZ5MHN+kDGEMbRfAC0H/TNknYNJ802xaDiR
         GJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O/0AmWJ2zZ9jBOUKiBYokfwpQ0K25nIbKKNBnHZRFQ4=;
        b=MdnSGGtwnOfJOHwE0b4cEQ6VBOqq/c9TynXhmWqeMZzlG43Qwk404lW4wSFtNf9jlk
         1Oj1B+efyZ1No1C3VIbr5i2VPBdHOM3zF66tb9SgFk5ZCsPvd3y8MIl6+OrSmc03EAFx
         wXBFc1QVZz8I0CBqbXX+wI28QDW8JDWtAFlym8MSpAxowcNEd4IshnunnPOBhzkbauTr
         qOpZqdm/qAA98XjZ1N8uu5wVWdYC7qWea2yOZurYlAIrg0b24jLAPSj7xq8X1jgclaXn
         A1GEKExnkyHcZ1GJv8lcTuxw1487E3wpo1ofV3hTYmrYr6+B0T2eFZZsuBC1jrhEtMay
         BXhQ==
X-Gm-Message-State: AOAM5338CeYcMyhcZHb3e7l2a4Zx5xy0aocj27Fe/KiktwgliL3ryyEp
        p3Wf8nIiECee2UXe/C5Etw2pC/UuLIh8kFoOcxY=
X-Google-Smtp-Source: ABdhPJwW32NVPTbN6HfUGf3bcV/Wb6uAd0Ws+pIIoG/bq53OOueIr7okogFmq2yCOJAhonO279WzAv8yO5uUEmo935k=
X-Received: by 2002:a65:45c3:: with SMTP id m3mr8237777pgr.203.1629281963179;
 Wed, 18 Aug 2021 03:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210818092741.2114155-1-sean@geanix.com> <20210818092741.2114155-2-sean@geanix.com>
In-Reply-To: <20210818092741.2114155-2-sean@geanix.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 18 Aug 2021 13:18:46 +0300
Message-ID: <CAHp75VfymQu1dP6ku027B0psAHzWcfPcaGmJjJukCrafw91ihg@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: accel: fxls8962af: add wake on event
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 18, 2021 at 12:29 PM Sean Nyekjaer <sean@geanix.com> wrote:
>
> This add ways for the SoC to wake from accelerometer wake events.

adds

> In the suspend function we skip disabling the sensor if wakeup-source
> and events are activated.
> If the buffer is enabled it will be deactivated before suspend, as the
> buffer is quite small.

"..., because it is..."
Or what are you saying here?

...

> +       if (dev_fwnode(dev) && device_property_read_bool(dev, "wakeup-source"))

dev_fwnode() is redundant.

> +               device_init_wakeup(dev, true);

...

> +static int __maybe_unused fxls8962af_suspend(struct device *dev)
> +{
> +       struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +       struct fxls8962af_data *data = iio_priv(indio_dev);
> +
> +

One blank line is enough.

> +       if (device_may_wakeup(dev) && data->enable_event) {
> +               enable_irq_wake(data->irq);
> +
> +               /*
> +                * Disable buffer, as the buffer is so small the device will wake
> +                * almost immediately.
> +                */
> +               if (iio_buffer_enabled(indio_dev))
> +                       fxls8962af_buffer_predisable(indio_dev);
> +       } else {
> +               fxls8962af_runtime_suspend(dev);
> +       }
> +
> +       return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko
