Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC85220477
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jul 2020 07:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgGOFpR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jul 2020 01:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgGOFpQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jul 2020 01:45:16 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DF4C061755
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2020 22:45:16 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t6so1911153plo.3
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2020 22:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AhZlGITo8F+I2ehGq+ny8oOoue4nWLdn9PaTAOHL9Bw=;
        b=qwMuZ9GUf0isKNeMEStLE0Hre9Fj9dA+sPmRjTC/6+J7NME2XbYRcN6sj33paiPnO0
         AqokYHva8O8HGX13l1D7pXUAoQU3bxuoloJA1u2tk0eBPmlNXNW6hn949pScLbLMfPpw
         /SlD33a//Jp4W7/rMWjdS0Sg531DvYtwMOWgCNDLHXYp57+UE7yrmRxqJOtQ+MoYApqe
         nFxXmqS93VXXUpHq9S8s2533aXOmFxL/UXhkIaYXXCSUdZJBrBuBgTFqq3djJ1M8boCm
         j+3fpZZVudtC9E3VmDSA8CHOP+mspEFWNbHsLjpTjhDwLDPFQmPWjygoDEkGr5dOgLNz
         TKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AhZlGITo8F+I2ehGq+ny8oOoue4nWLdn9PaTAOHL9Bw=;
        b=cDTRWgiAt6l2AQ5gn1Xxkx015QAjxI1DyDAWLHx4/70e/X3/p7Fh/PD4Vt4pUPpswU
         8CEqYSsg7gSTGkS+u2kuc3T3iFkBoPTYiwIsesC1I9sb93O+rvCU2A+ZCYMS9AsLSVeZ
         Wl8BndMfS3H70reGlqR5CyXtzD+SfFJnbzBPNM/WNkynhIvVi4iprd0KvGi1YKkmOKNK
         Ad6fPBgQGmE0OrV++Y7kbZl9K2L1ceTt5epC2if8m5y1zI0vqy+PcYM80Kt3sqQwq7Q6
         azwCxw1lJ0hLCnIpkeQTunvYd4psiAdpqaLbHA5nojBMhHbOr06rtatvhqsj0gnADLfr
         B4oQ==
X-Gm-Message-State: AOAM530W3v50T8WojrP2RCkJ9I362FCxVBd8MKgTuvrmNFzIQ3ekG+22
        egV2io0Tdb86GLzaAYwaEvMAJupLoFnvs9BUlIQmI+Zn
X-Google-Smtp-Source: ABdhPJx9+KbK/7uwhYjYAHMv/99thcQSTbQutcok79IaecOswQDvEZ+Umasjd4IMd4EzdOSXlzhqD5LPyKTg3PTl9RQ=
X-Received: by 2002:a17:90b:3547:: with SMTP id lt7mr8331465pjb.181.1594791915231;
 Tue, 14 Jul 2020 22:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200715050226.9751-1-dan@dlrobertson.com> <20200715050226.9751-2-dan@dlrobertson.com>
In-Reply-To: <20200715050226.9751-2-dan@dlrobertson.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Jul 2020 08:44:59 +0300
Message-ID: <CAHp75Vc0H0C01kBsVHfmD6QbS-6Wh3R7HCua8RQ+2vHrQUqoig@mail.gmail.com>
Subject: Re: [PATCH 1/1] iio: accel: bma400: add PM_SLEEP support
To:     Dan Robertson <dan@dlrobertson.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 15, 2020 at 8:05 AM Dan Robertson <dan@dlrobertson.com> wrote:
>
>  - Add system sleep ops if CONFIG_PM_SLEEP is set.
>  - Add attribute for setting the power mode of the
>    device.

...

> -static const struct iio_chan_spec_ext_info bma400_ext_info[] = {

> -};
> -
> -#define BMA400_ACC_CHANNEL(_axis) { \

> -}
> -
> -static const struct iio_chan_spec bma400_channels[] = {

> -};
> -

I'm not sure how this part is related.

...

> +static const char * const bma400_power_modes[] = {
> +       "sleep",
> +       "low-power",
> +       "normal"

Missed comma.

> +};

...

> +#ifdef CONFIG_PM_SLEEP

__maybe_unused looks better.

> +static int bma400_suspend(struct device *dev)
> +{

> +}
> +
> +static int bma400_resume(struct device *dev)
> +{

> +}
> +#endif
> +
> +const struct dev_pm_ops bma400_pm_ops = {

> +#ifdef CONFIG_PM_SLEEP

Why?

> +       SET_SYSTEM_SLEEP_PM_OPS(bma400_suspend, bma400_resume)
> +#endif
> +};
> +EXPORT_SYMBOL(bma400_pm_ops);

...

>         .driver = {
>                 .name = "bma400",
>                 .of_match_table = bma400_of_i2c_match,
> +               .pm = &bma400_pm_ops

Missed comma.

>         },

...

>         .driver = {
>                 .name = "bma400",
>                 .of_match_table = bma400_of_spi_match,
> +               .pm = &bma400_pm_ops

Ditto.

>         },

-- 
With Best Regards,
Andy Shevchenko
