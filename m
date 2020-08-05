Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FD123C6FB
	for <lists+linux-iio@lfdr.de>; Wed,  5 Aug 2020 09:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgHEHdX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Aug 2020 03:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHEHdW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Aug 2020 03:33:22 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75805C06174A;
        Wed,  5 Aug 2020 00:33:21 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id h12so12570288pgf.7;
        Wed, 05 Aug 2020 00:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6VHFh0vko2JNomHrwvJl3llHBkgB6xy1r3raHHKX4XE=;
        b=d68kUP+O6O6E3CXbyCzCMbvOTSRN5iFrLjSS8IeRPCMjigrCTlihYZLDxM1riTVPVn
         4s1FvvmKbUsGaMUFA+t85YpzvitCyQ2wD3kSnNhPiybSPV5KHsp4+mgn7SM9r9VF8fHK
         xP/Y7VqJc4LNle3WYlMQeHFfZD2nGwbeDWsbM5LEAQlC02x4fgjTI2/Va4Ha1n5Toemw
         o2Xc0qSPyZ3ms+NHNuGwZq9J/LhH+SY0EKF7KSPmgm22krRsZco/Ooy2vItEwhD+QrtA
         VBRS5mdFvGqR2qiRqb2weZAQ/m8hlMG2RiDFIlpY7kr/HDl/FoZJnZVQnf1oNrnruNWl
         vW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6VHFh0vko2JNomHrwvJl3llHBkgB6xy1r3raHHKX4XE=;
        b=DJKvrOFWpcUilu0czbWc2iAxpBCLGuXf1xTIj875r6HjIUr5ka8CdgAIGvCMNmMn6e
         sLiAjYhk/R9ibeOzGCzuu/ivhr70+WSwJM54NHfXfftgdZxGAxS/s41ebWvovZLhBH/K
         WNlexOTm/Rs64BjUTK1bxM2ZXA5LisWYYQFFXqOuRf8GTXwPXgzWJN9UoO3+zFHY0SFV
         CpwSsvaSJVaClptibSGyPxZe2P7Csj0fd14usDE0W05INXj0SDP4hm0MnoW7tLEbYu89
         vSxljH6KriUQudjytk1OcnWfITZai+Ht+aSfkLaIhDNtgo6O1WA7f+2m/BhBMAG/87av
         u7tg==
X-Gm-Message-State: AOAM532ZrqCfL3XkxDOFV568z9VKD/Rb1DwSNhzxjBDxv2wNs0dkFjXv
        i8o44Hp0tlNQXQTh2l/ishh0LFCw9SDpioAAcHo=
X-Google-Smtp-Source: ABdhPJyCNnmLOYWZi9JFIbJ2pxRzZLSSeGnZ/mXDoD3ie5aomNvJFDei5vYV3wIm6k8yK5UYzRgnFjox1/z4gtYcmlk=
X-Received: by 2002:a63:f24a:: with SMTP id d10mr1883033pgk.4.1596612800868;
 Wed, 05 Aug 2020 00:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200804100414.39002-1-alexandru.ardelean@analog.com>
In-Reply-To: <20200804100414.39002-1-alexandru.ardelean@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 5 Aug 2020 10:33:03 +0300
Message-ID: <CAHp75VcpOpXxb9Dz6GiixX9dQNjDUTe9ghU9QO8DUbU7h6LYfQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: imu: adis16480: Add support for burst read function
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Stefan Popa <stefan.popa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 4, 2020 at 1:04 PM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:

> +static irqreturn_t adis16480_trigger_handler(int irq, void *p)
> +{
> +       struct iio_poll_func *pf = p;
> +       struct iio_dev *indio_dev = pf->indio_dev;
> +       struct adis16480 *st = iio_priv(indio_dev);
> +       struct adis *adis = &st->adis;

> +       int ret, bit, offset, i = 0;

It makes it easier to understand the code if the assignment will be
attached to the actual user, i.e. for_each_set_bit() below.

> +       __be16 data[ADIS16495_BURST_MAX_DATA], *buffer, *d;

> +       if (!adis->buffer)
> +               return -ENOMEM;

Is it possible?

> +       mutex_lock(&adis->state_lock);
> +       if (adis->current_page != 0) {
> +               adis->tx[0] = ADIS_WRITE_REG(ADIS_REG_PAGE_ID);
> +               adis->tx[1] = 0;
> +               spi_write(adis->spi, adis->tx, 2);
> +       }
> +
> +       ret = spi_sync(adis->spi, &adis->msg);
> +       if (ret)

> +               dev_err(&adis->spi->dev, "Failed to read data: %d\n", ret);

No bail out? Then it's dev_warn().

> +       adis->current_page = 0;
> +       mutex_unlock(&adis->state_lock);
> +
> +       if (!(adis->burst && adis->burst->en)) {
> +               buffer = adis->buffer;
> +               goto push_to_buffers;
> +       }
> +       /*
> +        * After making the burst request, the response can have one or two
> +        * "don't care" 16-bit responses, before the BURST_ID.
> +        */
> +       d = (__be16 *)adis->buffer;
> +       for (offset = 0; offset < 3; offset++) {
> +               if (d[offset] == ADIS16495_BURST_ID) {
> +                       offset += 2; /* TEMP_OUT */
> +                       break;
> +               }
> +       }

So, we can end up with offset == 3 here. Is it by design?
Otherwise, offset+=2 maybe moved out of the loop.
And in any case comment is needed.

> +       for_each_set_bit(bit, indio_dev->active_scan_mask,
> +                       indio_dev->masklength) {
> +               /*
> +                * When burst mode is used, temperature is the first data
> +                * channel in the sequence, but the temperature scan index
> +                * is 10.
> +                */
> +               if (bit == ADIS16480_SCAN_TEMP) {
> +                       data[2 * i] = d[offset];
> +               } else {
> +                       /* The lower register data is sequenced first */

> +                       data[2 * i] = d[2 * bit + offset + 2];

I would do ' + 0', but it's up to you.

> +                       data[2 * i + 1] = d[2 * bit + offset + 1];
> +               }
> +               i++;
> +       }
> +
> +       buffer = data;
> +
> +push_to_buffers:
> +       iio_push_to_buffers_with_timestamp(indio_dev, buffer,
> +               pf->timestamp);
> +
> +       iio_trigger_notify_done(indio_dev->trig);
> +
> +       return IRQ_HANDLED;
> +}

...

> +       /* If burst mode is supported, enable it by default */
> +       if (st->chip_info->burst) {
> +               st->adis.burst = st->chip_info->burst;
> +               st->adis.burst_extra_len = st->chip_info->burst->extra_len;
> +       }

You may use it directly (the sizeof struct somelike 16 bytes and one
pointer on a 64-bit machine is 8, simply embed it into the struct and
assign it always.

...

+       .extra_len = 12 * sizeof(u16),

__be16 would be precise?

-- 
With Best Regards,
Andy Shevchenko
