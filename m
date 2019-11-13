Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0706FAD75
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2019 10:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfKMJqe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 13 Nov 2019 04:46:34 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37799 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfKMJqd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Nov 2019 04:46:33 -0500
Received: by mail-oi1-f193.google.com with SMTP id y194so1218427oie.4;
        Wed, 13 Nov 2019 01:46:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=grATdiINrLQEcjShNKetMHR+1iFUrTj1Oa6wxu6nBC8=;
        b=eydRv2+RcZ1p3E04nROAsIM4JJmmCQ9CXgB9ztszZ70YtViFy9cHtParOFLhV0wlrO
         ba/CVyibzzKKn645L0PqCU7e1n9ZFUcv3jXFLivq4UnVZ/clf5ofMKWt60OikSUrjzuG
         8+kRTpQlAlnvNKpIwNqji/crBB4bZtD0s/J13aBJg4tqY55MI6laN1I8Jqyu/CvfBWkE
         VWT3l8VJ4rl3Uglwc9bf2phs+oR/hUmhMPED/a4lipEhm/W8Ggr5nUC+3T9VTJngeKeM
         en5kQ0ZlrOlzmjvf/NK/yi+0C97rvvmrBy38TuHnBrLjMF/s70FCq96T4svMyCrIH7Fp
         Pphw==
X-Gm-Message-State: APjAAAUngXhpigi/usK03BVN1WwUdq5ayGwbM2L5cF6HthcIaUbUOQXI
        JRTBrCQc1mqBHqyWxth+S2HH2iTGIqj+pzZvpsU=
X-Google-Smtp-Source: APXvYqw+WwVtEe652SidlkvEW7B6vqqkKKweJ/P/bvZDfiZHNkn+wQC3h+/WzUWedgTHJtP2cYCoaHreFx44nnvn/Uk=
X-Received: by 2002:aca:3a86:: with SMTP id h128mr2099125oia.131.1573638392868;
 Wed, 13 Nov 2019 01:46:32 -0800 (PST)
MIME-Version: 1.0
References: <20191113092133.23723-1-geert+renesas@glider.be> <20191113093828.vk5qqtlr7bs5z5fb@uno.localdomain>
In-Reply-To: <20191113093828.vk5qqtlr7bs5z5fb@uno.localdomain>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Nov 2019 10:46:21 +0100
Message-ID: <CAMuHMdUeY62SBvzgHCMxjeDO6f_c3isbw82FKJatzny=qiDULQ@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: max9611: Fix too short conversion time delay
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-iio@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jacopo,

On Wed, Nov 13, 2019 at 10:36 AM Jacopo Mondi <jacopo@jmondi.org> wrote:
> On Wed, Nov 13, 2019 at 10:21:33AM +0100, Geert Uytterhoeven wrote:
> > As of commit b9ddd5091160793e ("iio: adc: max9611: Fix temperature
> > reading in probe"), max9611 initialization sometimes fails on the
> > Salvator-X(S) development board with:
> >
> >     max9611 4-007f: Invalid value received from ADC 0x8000: aborting
> >     max9611: probe of 4-007f failed with error -5
> >
> > The max9611 driver tests communications with the chip by reading the die
> > temperature during the probe function, which returns an invalid value.
> >
> > According to the datasheet, the typical ADC conversion time is 2 ms, but
> > no minimum or maximum values are provided.  However, the driver assumes
> > a 1 ms conversion time.  Usually the usleep_range() call returns after
> > more than 1.8 ms, hence it succeeds.  When it returns earlier, the data
> > register may be read too early, and the previous measurement value will
> > be returned.  After boot, this is the temperature POR (power-on reset)
> > value, causing the failure above.
> >
> > Fix this by increasing the delay from 1000-2000 µs to 2000-2200 µs.
> >
> > Note that this issue has always been present, but it was exposed by the
> > aformentioned commit.
> >
> > Fixes: 69780a3bbc0b1e7e ("iio: adc: Add Maxim max9611 ADC driver")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > This problem was exposed in v5.3.
> >
> > After this patch, probing of the two max9611 sensors succeeded during
> > ca. 3000 boot cycles on Salvator-X(S) boards, equipped with various
> > R-Car H3/M3-W/M3-N SoCs.
> > ---
> >  drivers/iio/adc/max9611.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> > index da073d72f649f829..b0755f25356d700d 100644
> > --- a/drivers/iio/adc/max9611.c
> > +++ b/drivers/iio/adc/max9611.c
> > @@ -89,6 +89,11 @@
> >  #define MAX9611_TEMP_SCALE_NUM               1000000
> >  #define MAX9611_TEMP_SCALE_DIV               2083
> >
> > +/*
> > + * Conversion time is 2 ms (typically)
> > + */
> > +#define MAX9611_CONV_TIME_US_RANGE   2000, 2200
> > +
>
> Is a 20% sleep range enough or should it be slightly lengthen ?

10%?

This only impacts the variation, so what really happens depends on the
rate of the hrtimer (if present).
On R-Car Gen3, I think that uses the ARM Architectured Timer (cp15),
which has a period of 120 ns.

> Apart from this, thanks a lot for finding the issue root cause!
>
> Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
