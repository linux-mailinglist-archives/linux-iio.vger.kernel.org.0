Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C317D27C17
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2019 13:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730402AbfEWLrS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 May 2019 07:47:18 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35848 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729949AbfEWLrR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 May 2019 07:47:17 -0400
Received: by mail-ot1-f68.google.com with SMTP id c3so5120687otr.3;
        Thu, 23 May 2019 04:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rGBgzoOZoDnFHzdz7CD5+adtzMXvR/o9pLCWlsfPtRo=;
        b=WNuGPSbGfgHm4nL9GFLVdZ+AkDfdime+NAnnisR9zQdInVswQBhM4PHfYCVFgaGQs3
         OJtZGZWtWF8lPmF9fnAFcYpPaM7bgBKewrhAv1uuRgjbz6SVx7SKnxknARRjd1iflIly
         pyjB9Tw3lH+0Q6mi7DFpR5dhWxb/bvUY6KVA3OHdT1MopwFnNY+40cFElU/tZoy5Osrn
         DHpIla774HSf0o6Bjkikk/swO+TFK3YTzSmFfgcOgLfVxLSq9+c/Hu5fFfC3rpQ+6NzX
         aXMuyzNjnzDy/ZWCPW/7d/1YmdXONlC6nBR78gI5X40s4enWa035aDGU3m5NziGnYR73
         6FvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rGBgzoOZoDnFHzdz7CD5+adtzMXvR/o9pLCWlsfPtRo=;
        b=tp8nL09lGXlYoTeC6tyNmUXfoeAEbvoqW8YG0zWIObq0RQnfnTBbTQ9nLhVQlkAMLl
         Na/bWEi+eYi3mfukOh1vNuopiAjSsAAYT3c4Qb74QU579XrG4hrzcjNxBK26CflzaAfb
         hfPXM5QmNZANlZ7ryUfSaAts3UNcG1jdg0i6xdB9Gt40JaQLf4oWvepPYA/TdQosR4E1
         njtmkmI1vUaz+5FaaYm6By+F9zpV18u8ffo97/GjdRGo+jN1a/mhcsQ5PKiA0+gD9zO5
         IJ8v3TBvcedgLJsI2aRGq1+wHYNKa8E6uBFbIZtBwdoWcQ5FxSCGTmuabA0azlIHBLyH
         TQlA==
X-Gm-Message-State: APjAAAUbXFm3zn8uBNjP7E57EcaqMOMNS8JUlEkKrBn2tJkYv+7r65nU
        z1+MALwXpCDnIfH3lHQ2nStXtM7BPA7XS57j+HNgGMoEGTs=
X-Google-Smtp-Source: APXvYqx20uLH85/82ftTJ7ioOCikdEVaNQ31qSpq+DNHXYYSXr+s/E6A8Pm+IfABj47y7f1UCs+eSKiOwNZwLgg0fe4=
X-Received: by 2002:a9d:dca:: with SMTP id 68mr57493850ots.119.1558612036874;
 Thu, 23 May 2019 04:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <1557759185-167857-1-git-send-email-adam.michaelis@rockwellcollins.com>
In-Reply-To: <1557759185-167857-1-git-send-email-adam.michaelis@rockwellcollins.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 23 May 2019 14:47:05 +0300
Message-ID: <CA+U=DsoHuzt27CnwFK-2tdLhNMea1JttncdhZaBjRpfticgfEg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] iio: ad7949: Fix dummy read cycle placement
To:     Adam Michaelis <adam.michaelis@rockwellcollins.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <michael.hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        charles-antoine.couret@essensium.com, devicetree@vger.kernel.org,
        brandon.maier@rockwellcollins.com,
        clayton.shotwell@rockwellcollins.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Stefan Popa <stefan.popa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, May 13, 2019 at 7:18 PM Adam Michaelis
<adam.michaelis@rockwellcollins.com> wrote:
>
> The AD7949 requires two conversion cycles following the first
> configuration change, and one extra cycle following any other
> configuration change (including changing the analog channel being
> sampled). Therefore, adding a dummy read cycle when config is changed
> and removing the extra cycle at initial configuration (the first dummy
> cycle is now performed as part of applying the configuration change).
>

CC-ing my work email.
And Stefan as well.

We'll have to try this driver & changes internally a bit.
Hopefully we have a compatible device around the office.
Since it wasn't written by us, we're also unsure about things just by
looking at the code.

> Signed-off-by: Adam Michaelis <adam.michaelis@rockwellcollins.com>
> ---
>         V2:
>         - Add some defines to reduce use of magic numbers.
>         V3:
>         - Switch back to using a u32 data buffer.
>         - Add-back the second dummy cycle on initialization.
>         - Move to first patch in series.
> ---
>  drivers/iio/adc/ad7949.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> index ac0ffff6c5ae..c7fe27aa2519 100644
> --- a/drivers/iio/adc/ad7949.c
> +++ b/drivers/iio/adc/ad7949.c
> @@ -100,6 +100,23 @@ static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
>          * send a new command to the device
>          */
>         udelay(2);
> +
> +       /*
> +        * Perform extra read cycle to allow configuration, acquisition,
> +        * and conversion sequences to complete for new configuration.
> +        */
> +       ad7949_adc->buffer = 0;
> +
> +       spi_message_init_with_transfers(&msg, tx, 1);
> +
> +       ret = spi_sync(ad7949_adc->spi, &msg);
> +
> +       /*
> +        * This delay is to avoid a new request before the required time
> +        * to send a new command to the device.
> +        */
> +       udelay(2);
> +

Is this needed if the channel doesn't change ?
If it isn't, maybe add a check in ad7949_spi_read_channel() to skip
the call to ad7949_spi_write_cfg().

We should also take performance into account when doing SPI
transactions to the device, and if we can skip some of them, all the
better.
This change, introduces a performance penalty by doing this extra read + udelay.

>         return ret;
>  }
>
> @@ -229,11 +246,10 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
>         ret = ad7949_spi_write_cfg(ad7949_adc, 0x3C79, AD7949_MASK_TOTAL);
>
>         /*
> -        * Do two dummy conversions to apply the first configuration setting.
> +        * Do a dummy conversion to apply the first configuration setting.
>          * Required only after the start up of the device.
>          */
>         ad7949_spi_read_channel(ad7949_adc, &val, ad7949_adc->current_channel);
> -       ad7949_spi_read_channel(ad7949_adc, &val, ad7949_adc->current_channel);

The datasheet mentions that 2 dummy conversions are needed on power-up / init.

The way, this was done here was a bit easier to follow (or
straightforward) with the datasheet.

This isn't to say that this is bad, but if we need to do an extra SPI
read (and skip the SPI write part), then I would just add an SPI read
function, instead of moving it completely into ad7949_spi_write_cfg(),
which would then compact things in ad7949_spi_read_channel().

>
>         return ret;
>  }
> --
> 1.9.1
>
