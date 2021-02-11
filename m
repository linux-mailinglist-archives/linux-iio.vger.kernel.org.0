Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74993319272
	for <lists+linux-iio@lfdr.de>; Thu, 11 Feb 2021 19:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhBKSnh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Feb 2021 13:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhBKSn3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Feb 2021 13:43:29 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE29C061574
        for <linux-iio@vger.kernel.org>; Thu, 11 Feb 2021 10:42:48 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id e17so8592323ljl.8
        for <linux-iio@vger.kernel.org>; Thu, 11 Feb 2021 10:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Igr2FZlUvTxjCK0EuZbn/KOwb0JoG4fwY+sYzbW8O5c=;
        b=K3G6/NUVoZiEiZV88epIgwRjvhAb3Ndtq43XXUwxTBRPud9vOgLNhu8OOTfA76PrN1
         b7BJaa8oOJGAj4KuOOWAEBpTTskpIeO92aIG3fGipOJMk0LycCiNr4YqBRCUMnaJZITH
         Obg36ntxjjogeXospwoeoQDNIahx6MZ+YP0MzlueEvoPe5ELZDlbzoWZXNHMvWCqtpcG
         +xFrYU0DNarUe/b+R9ALRrsvAsLNcMOQhDkMRz/oKzIaUHpQGEa4dOkYKXTE0WJsKoyU
         YfDzeGdxCG0cYXseUIQhHBeRctfv6jgdx3n74J8CJMY5dtcgofa3tgoKWEIu2C0gFeIq
         QFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Igr2FZlUvTxjCK0EuZbn/KOwb0JoG4fwY+sYzbW8O5c=;
        b=hIXb+ldgRi3vpTzNJ0VWVsT+zhJsEvjf/L4q9piSoEB6su6umBsy8g0hfMupc5wuoB
         7kgdKELlCtQ8t/Bg+OVLPQNBLAfWLNKjFS37fKsSF1zT9jeQnioUV2Cl+xxiK63HfEeg
         HG2a25x7IL/P0CZ7qWxAESNG/vDCXihW7l2DRuUjWDaiy/PY0ZHED85RdvBBifE3BzkI
         csxHu4jWtWmz7TOoj3sYxhcbXBti+ZJpAcFbpQ9JviYA+fppxKpM/vtCyoEBRAnZqjUT
         t7t+vgi+tr6arDk7mI9rUjbibBcDuomf2x+i7KpsrXOYE3ykKDvdefVOcgt/CF6JDhSP
         bN5g==
X-Gm-Message-State: AOAM533K+5/heECEN6Ten11EmjQi8upwkTXGUnPlTlBrzqycsosOZICe
        wAyARmZkyt9h1KucbSvt+LNuKfR5WeAk9grPA0c=
X-Google-Smtp-Source: ABdhPJwEHeEsg5J9ZrddT4WXjdsR2fCH5DUvj9UsVwM3zcUTmhDxFgKDuaVkBCYks/jRllkBPJX3S8kGI/Yja5c0fDs=
X-Received: by 2002:a05:651c:503:: with SMTP id o3mr6077229ljp.2.1613068967350;
 Thu, 11 Feb 2021 10:42:47 -0800 (PST)
MIME-Version: 1.0
References: <20210208142705.GA51260@ubuntu> <CAHp75Vc1VWYLO1rF-NNnW3qkgiGycgpTHvr5Q2Yn91aZcFuyJg@mail.gmail.com>
In-Reply-To: <CAHp75Vc1VWYLO1rF-NNnW3qkgiGycgpTHvr5Q2Yn91aZcFuyJg@mail.gmail.com>
From:   Wilfried Wessner <wilfried.wessner@gmail.com>
Date:   Thu, 11 Feb 2021 19:42:36 +0100
Message-ID: <CAMwq6HiAufEjLPn2hSnQ7iBvrrCZUzwE_hdFE8s51ewbuJOMYA@mail.gmail.com>
Subject: Re: [PATCH v3] iio: ad7949: fix wrong ADC result due to incorrect bit mask
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Feb 8, 2021 at 5:06 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Feb 8, 2021 at 4:27 PM Wilfried Wessner
> <wilfried.wessner@gmail.com> wrote:
> >
> > Fixes a wrong bit mask used for the ADC's result, which was caused by an
> > improper usage of the GENMASK() macro. The bits higher than ADC's
> > resolution are undefined and if not masked out correctly, a wrong result
> > can be given. The GENMASK() macro indexing is zero based, so the mask has
> > to go from [resolution - 1 , 0].
>
>
> > Fixes: 7f40e0614317f ("iio:adc:ad7949: Add AD7949 ADC driver family")
>
> >
>
> Shouldn't be blank like here, but I think Jonathan can fix when applying.
> Jonathan, can you also amend the subject (I totally forgot about
> subsubsystem prefix)?
> Should be like:
> "iio: adc: ad7949: fix wrong results due to incorrect bit mask"

Should I send a v4 with the changes proposed by Andy?
It would change the subject.

And if so, should I add the tags:
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Charles-Antoine Couret <charles-antoine.couret@essensium.com>

Please advise, thank you!
Best Regards,
Willi



>
> And FWIW,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> > Signed-off-by: Wilfried Wessner <wilfried.wessner@gmail.com>
> >
> > ---
> >
> > The issue was found in combination of an AD7682 ADC with an ARM based
> > iMX7-CPU. The SPI line was analyzed with a logic analyzer and a
> > discrepancy between applied voltage level and the ADC reported value
> > in user space was observed. Digging into the driver code revealed an
> > improper mask used for the ADC-result.
> >
> >
> >  drivers/iio/adc/ad7949.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> > index 5d597e5050f6..1b4b3203e428 100644
> > --- a/drivers/iio/adc/ad7949.c
> > +++ b/drivers/iio/adc/ad7949.c
> > @@ -91,7 +91,7 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
> >         int ret;
> >         int i;
> >         int bits_per_word = ad7949_adc->resolution;
> > -       int mask = GENMASK(ad7949_adc->resolution, 0);
> > +       int mask = GENMASK(ad7949_adc->resolution - 1, 0);
> >         struct spi_message msg;
> >         struct spi_transfer tx[] = {
> >                 {
> > --
> > 2.25.1
> >
>
>
> --
> With Best Regards,
> Andy Shevchenko
