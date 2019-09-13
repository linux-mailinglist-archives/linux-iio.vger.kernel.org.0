Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A292B193D
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 09:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfIMH5L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 03:57:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39257 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfIMH5L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 03:57:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id r3so940448wrj.6
        for <linux-iio@vger.kernel.org>; Fri, 13 Sep 2019 00:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=+/yOZszLKaf9DuLXpXNH++07GcZPakWa5Tih2uKFC7I=;
        b=ryRgx+jTq3041wljdKgXgmLh1UsyQKTGk4gts6PAdyADs9sB+dhyZEA97wdPT8jGb5
         8RPKDGV/Gtcz/vDfeCoxbKwz5nlc6+dG6rles+2RKtAkTJrDOwy8Tq463waSWMe+m0uM
         CsUfRfygEjo6+VWHCLapaEShIQXhePcSdfuV0AbQyzzq2OifMFuae2iIrlctmAtuTv+D
         HwSlUocDDQl99r0B5xURv2RpoWUBJ25dcypGPjBWbkoD3xtZ9kcVO+/n5edLYawqQx8D
         ZE9aEPS8QU3wWHViyF4eY/81TpnsR+RhILxcz/EhXO4xxqaODLLkBqVWPB0Hy/7jJtjK
         XgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=+/yOZszLKaf9DuLXpXNH++07GcZPakWa5Tih2uKFC7I=;
        b=GuoRVRosS9BZ2HzfMYH3qNOiCBtoq/O8fYlpPFfumDh2OLENacfyzRRCMRhN+RI3tv
         61WIKXUqmtFk6YjVK4awKwapylrth3/e7PHQKtwyV5neY2B+oF3fHPuvpwHmYqGGE84q
         nxS0x5a/Cwo/JmBXNKTmLBP5DkWBa+gNxbXn+GeLaCNNMi60lKj/7B9dkGlZ4kLfIgAM
         v7K1pFIMOoGbSx6xxfMvik8er01DEiV/eiAryXCqTKaltwiISZrlkj3vEL0mzGl9+C1L
         nlBSCemgypi+aYCuoMPZ3uuUUN2L/2i/CYtBqcUY+WTeyVfctvjZ84RVCRQjfyjMV0p8
         cdOQ==
X-Gm-Message-State: APjAAAU6NPpXZfRe7YpB2xfl/i9s1AvcDm1mMo5GGunMsMs7Hy72AtS2
        8EjMfYbS5wsRx1dQ0+MMxRzc3kDiYqlsI3NXUIcwsZha
X-Google-Smtp-Source: APXvYqxrrAYAk8/PrZafTfiWoHjIdZ+L0VJ0eFz3RCQOEsqollJl/6I8p9mBFg3KXXYWWiuRU2VQv4LnpL/kyE+SH+k=
X-Received: by 2002:a5d:5281:: with SMTP id c1mr6626871wrv.339.1568361427336;
 Fri, 13 Sep 2019 00:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190912144310.7458-1-andrea.merello@gmail.com>
 <20190912144310.7458-3-andrea.merello@gmail.com> <3fe869be01ce7c81fd463158c05e0a4a115bdd6a.camel@analog.com>
In-Reply-To: <3fe869be01ce7c81fd463158c05e0a4a115bdd6a.camel@analog.com>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Fri, 13 Sep 2019 09:56:56 +0200
Message-ID: <CAN8YU5MpLDVEfVBUBe9XsuYT6yohruiHAMQgOVjZs-2JyO=NNQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] iio: ad7949: fix incorrect SPI xfer len
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        antoine.couret@essensium.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Il giorno ven 13 set 2019 alle ore 08:46 Ardelean, Alexandru
<alexandru.Ardelean@analog.com> ha scritto:
>
> On Thu, 2019-09-12 at 16:43 +0200, Andrea Merello wrote:
> > [External]
> >
> > This driver supports 14-bits and 16-bits devices. All of them have a 14-bit
> > configuration registers. All SPI trasfers, for reading AD conversion
> > results and for writing the configuration register, fit in two bytes.
> >
> > The driver always uses 4-bytes xfers which seems at least pointless (maybe
> > even harmful). This patch trims the SPI xfer len and the buffer size to
> > two bytes.
> >
>
> The length reduction proposal is fine.
>
> But, this patch raises a question about endianess.
> I'm actually wondering here if we need to see about maybe using a __be16 vs u16.
>
> I'm not that kernel-savy yet about some of these low-level things to be completely sure here.
> So, I'd let someone else maybe handle it.

Good point.. It seems that indeed not much care has been taken about
endianess here.. Probably we need also some le16_to_cpu() and
firends..

Maybe another separate patch can be made to take care about endianess later on?

BTW Also, the  ____cacheline_aligned is a bit scaring :) I don't know
what is that for...

>
> Thanks
> Alex
>
> > Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> > ---
> >  drivers/iio/adc/ad7949.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> > index 518044c31a73..5c2b3446fa4a 100644
> > --- a/drivers/iio/adc/ad7949.c
> > +++ b/drivers/iio/adc/ad7949.c
> > @@ -54,7 +54,7 @@ struct ad7949_adc_chip {
> >       u8 resolution;
> >       u16 cfg;
> >       unsigned int current_channel;
> > -     u32 buffer ____cacheline_aligned;
> > +     u16 buffer ____cacheline_aligned;
> >  };
> >
> >  static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
> > @@ -67,7 +67,7 @@ static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
> >       struct spi_transfer tx[] = {
> >               {
> >                       .tx_buf = &ad7949_adc->buffer,
> > -                     .len = 4,
> > +                     .len = 2,
> >                       .bits_per_word = bits_per_word,
> >               },
> >       };
> > @@ -95,7 +95,7 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
> >       struct spi_transfer tx[] = {
> >               {
> >                       .rx_buf = &ad7949_adc->buffer,
> > -                     .len = 4,
> > +                     .len = 2,
> >                       .bits_per_word = bits_per_word,
> >               },
> >       };
