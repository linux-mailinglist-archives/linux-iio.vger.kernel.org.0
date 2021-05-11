Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDD4379FEC
	for <lists+linux-iio@lfdr.de>; Tue, 11 May 2021 08:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhEKGr3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 May 2021 02:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhEKGr3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 May 2021 02:47:29 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A66DC061574;
        Mon, 10 May 2021 23:46:23 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q15so10828303pgg.12;
        Mon, 10 May 2021 23:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R8EwDQcP5dXlqw1ZUG9G8NrXJImpox+QEmMv1x2YmLw=;
        b=mryw+plkFx+G8e4zTqB+dXbCQ5BV5naDf2dQTtuzgrSZhSIhFJFuqX+S7ikJu8PAUF
         U1Ofu46wB1goCdFiaEecWS6NcjiMM86BJ2H1LjA3JAxT+jHJg8rJ1ufHwzAlAm6MlXaT
         LWMoAp7XOo8DMJeWLSzsXwWmV33OO7gamDElnUROkK25MHs5aiPgM+EEw9zFTEKLRPq4
         G31dLb+Vtd0hEehwnHAJ7CGazlGMHeJjTrbfaJFXgPDPs/5WPt+SXIXn5zmoA1c5mTRK
         jvwVhHZj/OwTA/NY5u7YE1GmCosHowSUJeJ9Urt4ZFD74VSKIuudQnjtwNLAdVzELwlM
         +RYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R8EwDQcP5dXlqw1ZUG9G8NrXJImpox+QEmMv1x2YmLw=;
        b=s5sf6RcovKJIW7DnOWJPQL4JnL6Hgv/IT3wv70MOa+6ChWbt4B+dffi6capruwn4hu
         mM9z+xvglO88MI/AvbUppj3vGcL0qWqp7QaPaUbx9gEOE8/037DXKVpfTi8B9FNcRogX
         n8XR5p+uBT1nfqpH2BA6NFe1d+kpKXz8Ze7MJUBau584KjWaC7xNxbLoQDaRoLUxRA78
         Vb24+YDdyelbkZAKoAuH8GKPft2LklC3PZiumPtOl2CoGcS34cCEVVMb7QAYKQgfLJ5i
         QqHWqrVIYKbGbJcxjwcNOB0NWHt9LFpoDu4zkEXpyZ0NjZ9ndFz+LKOvZt3KZIYAxetn
         f3DQ==
X-Gm-Message-State: AOAM5327FuUFwg4cDlqj7jbA7nzBKlW8QNNgGaykKQAP/3ZzbGkP9NGt
        gBvYTaHyYPWJToC9TFws4U8xQnd3iHDImemHSjM=
X-Google-Smtp-Source: ABdhPJwCkFDHy6Kcfy0TzDnvTx6RBIhOsFmYcS4mCSqNYHzJTtkZnRqwUhGDrk47wny4mKFa3zciq8+FfWulf+xUHlk=
X-Received: by 2002:a63:b243:: with SMTP id t3mr20241621pgo.253.1620715582970;
 Mon, 10 May 2021 23:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210510125523.1271237-1-aardelean@deviqon.com> <20210510184927.00000e6d@Huawei.com>
In-Reply-To: <20210510184927.00000e6d@Huawei.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 11 May 2021 09:46:11 +0300
Message-ID: <CA+U=Dsq-_a8KwJ7WGOi-kD6dF5h_JSuRwf6JW+Yp0mZ6k+eObw@mail.gmail.com>
Subject: Re: [PATCH 00/11] ad_sigma_delta: convert all drivers to device-managed
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        linux@deviqon.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, May 10, 2021 at 8:52 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 10 May 2021 15:55:12 +0300
> Alexandru Ardelean <aardelean@deviqon.com> wrote:
>
> > Well, for lack of a better title that's what this series does.
> > It merges Jonathan's patches from:
> >   * https://lore.kernel.org/linux-iio/20210508182319.488551-1-jic23@kernel.org/
> >     Patch 3/3 was a polished a bit with my comments from that review and also
> >     to use the devm_ad_sd_setup_buffer_and_trigger() function.
> >   * https://lore.kernel.org/linux-iio/20210509114118.660422-1-jic23@kernel.org/
> >     Added only to base the conversion to devm_
> >
> > The AD Sigma Delta family of ADC drivers share a lot of the logic in the
> > ad_sigma_delta lib-driver.
> >
> > This set introduces a devm_ad_sd_setup_buffer_and_trigger() call, which
> > aims to replace the 'ad_sd_{setup,cleanup}_buffer_and_trigger()' pair.
> >
> > This helps with converting the AD7780, AD7791, AD7793 and AD7192
> > drivers use be fully converted to device-managed functions.
>
> Almost perfect code wise (just the one bug that predates this series I think).
>
> Couple of notes on series from process point of view.
>
> 1) Fixes at the front. Makes for uglier series but nicer backporting.

ack

> 2) Sign-off on everything - even the ones from me that you didn't change. From DCO
>    point of view you handled them (passed them back to me ;) so need your
>    sign off.  I have occasionally wondered if I should sign off again when this
>    happens :)

ack; will do it;

>
> If you don't do a v2, just reply to say you are fine with me fixing the sign offs
> and I can do it whilst applying.

i'll send a V2

>
> Thanks,
>
> Jonathan
>
> >
> > Alexandru Ardelean (7):
> >   iio: adc: ad_sigma_delta: introduct
> >     devm_ad_sd_setup_buffer_and_trigger()
> >   iio: adc: ad7793: convert to device-managed functions
> >   iio: adc: ad7791: convert to device-managed functions
> >   iio: adc: ad7780: convert to device-managed functions
> >   iio: adc: ad7192: use devm_clk_get_optional() for mclk
> >   iio: adc: ad7192: convert to device-managed functions
> >   iio: adc: ad_sigma_delta: remove
> >     ad_sd_{setup,cleanup}_buffer_and_trigger()
> >
> > Jonathan Cameron (4):
> >   iio: adc: ad7192: Avoid disabling a clock that was never enabled.
> >   iio: adc: ad7124: Fix missbalanced regulator enable / disable on
> >     error.
> >   iio: adc: ad7124: Fix potential overflow due to non sequential channel
> >     numbers
> >   iio: adc: ad7124: Use devm_ managed calls for all of probe() + drop
> >     remove()
> >
> >  drivers/iio/adc/ad7124.c               | 84 ++++++++++--------------
> >  drivers/iio/adc/ad7192.c               | 90 +++++++++++---------------
> >  drivers/iio/adc/ad7780.c               | 38 +++--------
> >  drivers/iio/adc/ad7791.c               | 44 ++++---------
> >  drivers/iio/adc/ad7793.c               | 53 +++++----------
> >  drivers/iio/adc/ad_sigma_delta.c       | 82 ++++++++---------------
> >  include/linux/iio/adc/ad_sigma_delta.h |  4 +-
> >  7 files changed, 141 insertions(+), 254 deletions(-)
> >
>
