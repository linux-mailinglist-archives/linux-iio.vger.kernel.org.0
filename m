Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3BB311F6B
	for <lists+linux-iio@lfdr.de>; Sat,  6 Feb 2021 19:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhBFStU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Feb 2021 13:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbhBFStS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Feb 2021 13:49:18 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99569C06174A
        for <linux-iio@vger.kernel.org>; Sat,  6 Feb 2021 10:48:37 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id h12so15521158lfp.9
        for <linux-iio@vger.kernel.org>; Sat, 06 Feb 2021 10:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ApsRbO7WUbGWGjo4B0tsUvS5l8cS+gS1MCAwG42UOqU=;
        b=EQfrzYYyvZG+Vh0P8umlzxjtyQDFte4uVnT5BF9yBNrNae5jciSZlD0mvmTcQuL6Nr
         rNW9zr0PyFmvSsKrgG7/6OmluJGKmkLPegW88S4CeXkyhtyNI1tuBdCMnzgNDfnptQFb
         Qp3AN6Nv5b9EEd+vFD/1w00BYyXkc4TNSla+O5Bo6QZnDSntSOMbROQz1EGHx6+1zyvL
         /LnAGih3UnIXm3MnYIQKOreqcMOnokCJhhaPFyiyK53Sdc0dIJtnhAvn8WmxJtb2mV0k
         uC0N/tAOO/CUk4Tss4ExnQIUUeJtORHBwkW4HNcJpDpwtNhybn2RMTbsseQ/xB+5+TRU
         JB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ApsRbO7WUbGWGjo4B0tsUvS5l8cS+gS1MCAwG42UOqU=;
        b=TT/bBL9GcLZOUS1SC9j5o+DtRix3rRoITxKqdZUL4eCrB2tZT16Vch9lwGtZJ3HgWL
         GkgNoVuO/Kz5ekbeDyr1JBeiyF/SPxVR8Dnf94sncf3kiS9S8C4AEb49SS8eL41DXMY7
         5QJedPK2lTL91kisgmTAelLWVvMfPPuE7XFKr48jTLLn5fwH+gZBv7Ejud2awwFhrrvq
         Ye7SRY8hn5Qzt/j+bpK8E+qDClf7QSyi+SO3j58dERlBjab5Z6n0l22x4cnI3Cdi6jKh
         rXF2h6vEBw1tW6Xr4xOOrAUf/p8hxUo1AJYYu5JxcK9lty11UlIsgK1OpBqA+bK30w3M
         pDAg==
X-Gm-Message-State: AOAM530LECg42E+KKntGPLS9JSUiC8slrRDOp2QK0ShAdlG+8YGwOsh6
        EcpeUTdB76vSqlpwhcWIzijuU1YRexnK5dlKArI=
X-Google-Smtp-Source: ABdhPJzM0mo2IXOQ98OaCAX1Y7r9aUJm8RpNoeI3M/iId/UfjNGPI1cypzxHm5VQSLxGh5YIR6G45rXh3luuKwCrb1I=
X-Received: by 2002:a19:6d07:: with SMTP id i7mr6113052lfc.75.1612637316097;
 Sat, 06 Feb 2021 10:48:36 -0800 (PST)
MIME-Version: 1.0
References: <20210206145258.GA603024@ubuntu> <20210206170107.7db71f53@archlinux>
In-Reply-To: <20210206170107.7db71f53@archlinux>
From:   Wilfried Wessner <wilfried.wessner@gmail.com>
Date:   Sat, 6 Feb 2021 19:48:26 +0100
Message-ID: <CAMwq6HikxYvTPHsyQmWBtQRUgLnPpVeaGjy0mvF_ZQjeAOMkyg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: ad7949: fix wrong ADC result due to incorrect bit mask
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Feb 6, 2021 at 6:01 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat, 6 Feb 2021 15:52:58 +0100
> Wilfried Wessner <wilfried.wessner@gmail.com> wrote:
>
> > Fixes a wrong bit mask used for the ADC's result, which was caused by an
> > improper usage of the GENMASK() macro. The bits higher than ADC's
> > resolution are undefined and if not masked out correctly, a wrong result
> > can be given. The GENMASK() macro indexing is zero based, so the mask has
> > to go from [resolution - 1 , 0].
>
> Hi Wilfried,
>
> Welcome to IIO and kernel in general!
>
> It's useful to add to the description if the error was found by inspection / script
> or by observing an actual error on hardware?

The issue was found in combination of an AD7682 ADC with an ARM based iMX7-CPU.
The SPI line was analyzed with a logic analyzer and a discrepancy
between applied
voltage level and the ADC reported value in user space was observed.
Digging into
the driver code revealed the error.

>
> Also, needs a fixes tag so we can work out what kernels to back port it to.

Not sure about that, but I found the issue in:

commit 61556703b610a104de324e4f061dc6cf7b218b46 (HEAD -> master,
origin/master, origin/HEAD)
Merge: 3afe9076a7c1 7f3414226b58
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Feb 3 11:56:58 2021 -0800

    Merge tag 'for-linus-5.11-rc7' of
git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml

>
> +CC Charle-Antoine Couret as the original driver author.

done.
I wrote also an email to Charles-Antoine with the proposed fix, his comment was:
------
[Wilfried:]
>> since the GENMASK macro uses zero-based indexing?
>>
[Charles-Antoine:]
>You're right, it's a mistake.
>It wouldn't be a problem in many cases but it's better to be compliant.
[Wilfried:]
>> Could you pls. comment on that?
>>
[Charles-Antoine:]
>Good for me.
------


>
> Thanks,
>
> Jonathan
>
> >
> > Signed-off-by: Wilfried Wessner <wilfried.wessner@gmail.com>
> >
> > ---
> >  drivers/iio/adc/ad7949.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> > index 5d597e5050f6..1b4b3203e428 100644
> > --- a/drivers/iio/adc/ad7949.c
> > +++ b/drivers/iio/adc/ad7949.c
> > @@ -91,7 +91,7 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
> >       int ret;
> >       int i;
> >       int bits_per_word = ad7949_adc->resolution;
> > -     int mask = GENMASK(ad7949_adc->resolution, 0);
> > +     int mask = GENMASK(ad7949_adc->resolution - 1, 0);
> >       struct spi_message msg;
> >       struct spi_transfer tx[] = {
> >               {
>
