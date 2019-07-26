Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53F3B770C7
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2019 19:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbfGZR73 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Jul 2019 13:59:29 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38202 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbfGZR73 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Jul 2019 13:59:29 -0400
Received: by mail-io1-f68.google.com with SMTP id j6so31390162ioa.5
        for <linux-iio@vger.kernel.org>; Fri, 26 Jul 2019 10:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mz6yFp/JdoMmP88Hd9wgTkqmhK5wh8hSxVlurnjVo58=;
        b=AqdQBSa+KR+uV7HGSwYjR8NLjKpjPepgw0zylTLXZ2QQt/1THpF/IcxTn9NEC2+a1o
         mEdqDuJaXZJSxYKkUXBcNCmPTgQq3dGfUhPsntmMSDH5QtHkMKiKDU86C/gca8cxTMd8
         6/yzBbfm3RVHl15/DODIgB3Cd/GPtXpUnJkV2SR4GLk5GbVLK8RwEW3EX2EtkejrFmNv
         HVjdQh5HsFf+GdZ0BQSIw5dMf1rZZwStF4kg1X0vW0pmSU3Lgs4BDbgxFVRlci6MTiKY
         tZK3xW9fmKhVo7LFGLcFqYWBmUa72CuL2KwU9npClRTQetuaBXMVcAyI7GofbWa4TVm4
         OFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mz6yFp/JdoMmP88Hd9wgTkqmhK5wh8hSxVlurnjVo58=;
        b=F//d5tUh3Bx9dMCkfSrRfT6S3XMWtEPTwkUQf6QdLgKyt8YsG7BOXI9SwKiF6442ZN
         mo6fegnDrgiZNmRTKFjltek6UmdWtr71kGZcSBaqcL0455b4EwAs6ffy0UbSM+c5g35M
         35fBhkVND910KVusd536KaSef35449eTAGG3xGib/K9EZS2DBC+xYdjdJbETetxOkKoc
         BPJZNE+NiIpoLx01f6vDSqKGkbnZZzAxC3Ft/PnB2hTMtD19kRNNFQx/IXdWho6Q1FCf
         nKEVPd6Lz5FbDxuw8Vaa87fLXRViG06aNR2Uda6Ibi2dcmCa0slHJe+UaKffnJ86fFD0
         VJqQ==
X-Gm-Message-State: APjAAAVCOyZBF7bcIJyufurLbA74gfPyXhuR2xvRaOeZeQUxnoqF3F06
        0urxxoYnN3r/Bh0pDALotyvcRosfTU7QF1GnMerPRQ==
X-Google-Smtp-Source: APXvYqxQgZBD3hEdmYQN0ATdE+xO3I4QX7GvRTvtCBuN9N9yUSx7Dm9vAjvX0rbeiciuckyUOL3NhdqK6yM+PYnGSzE=
X-Received: by 2002:a5d:9711:: with SMTP id h17mr16548342iol.280.1564163967979;
 Fri, 26 Jul 2019 10:59:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190725200817.31277-1-kartik.koolks@gmail.com> <0e273486f1c4fb6249896225837cdf2da0fd2415.camel@analog.com>
In-Reply-To: <0e273486f1c4fb6249896225837cdf2da0fd2415.camel@analog.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 26 Jul 2019 14:59:16 -0300
Message-ID: <CAHd-oW5sOry2g_tQbgQ9-dp1esVStmS+UF-TTYoB2mWmzR10jQ@mail.gmail.com>
Subject: Re: [PATCH] staging:iio:adc:ad7280a: add of_match_table entry
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "kartik.koolks@gmail.com" <kartik.koolks@gmail.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jul 26, 2019 at 2:30 AM Ardelean, Alexandru
<alexandru.Ardelean@analog.com> wrote:
>
> On Fri, 2019-07-26 at 01:38 +0530, Kartik Kulkarni wrote:
> > Add the of_device_id struct and the respective
> > of_match_device entry to complete device tree support.
> >
>
> This would be a [V2] I suppose.
>
> This change also does the rename of the driver name in a single go.
> Since it's a trivial change, it's fine from my side.

I think there was a small confusion when we sent the patches. Sorry
for that. Originally, Kartik made the rename in its own patch. Would
it be better if we resend the two patches separately?

Thanks,
Matheus

> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
>
>
> > Signed-off-by: Kartik Kulkarni <kartik.koolks@gmail.com>
> > Reviewed-by: Matheus Tavares <matheus.bernardino@usp.br>
> > ---
> >  drivers/staging/iio/adc/ad7280a.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> > index 19a5f244dcae..ded0ba093a28 100644
> > --- a/drivers/staging/iio/adc/ad7280a.c
> > +++ b/drivers/staging/iio/adc/ad7280a.c
> > @@ -1027,9 +1027,16 @@ static const struct spi_device_id ad7280_id[] = {
> >  };
> >  MODULE_DEVICE_TABLE(spi, ad7280_id);
> >
> > +static const struct of_device_id ad7280_of_match[] = {
> > +     { .compatible = "adi,ad7280a", },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(of, ad7280_of_match);
> > +
> >  static struct spi_driver ad7280_driver = {
> >       .driver = {
> > -             .name   = "ad7280",
> > +             .name   = "ad7280a",
> > +             .of_match_table = ad7280_of_match,
> >       },
> >       .probe          = ad7280_probe,
> >       .id_table       = ad7280_id,
>
> --
> You received this message because you are subscribed to the Google Groups "Kernel USP" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-usp+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kernel-usp/0e273486f1c4fb6249896225837cdf2da0fd2415.camel%40analog.com.
