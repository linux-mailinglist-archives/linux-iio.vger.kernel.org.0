Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFCF2D8D11
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 13:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406194AbgLMMRA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 07:17:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:33558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405806AbgLMMRA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Dec 2020 07:17:00 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A787D206B7;
        Sun, 13 Dec 2020 12:16:18 +0000 (UTC)
Date:   Sun, 13 Dec 2020 12:16:15 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: afe: iio-rescale: Support processed channels
Message-ID: <20201213121615.55a86f77@archlinux>
In-Reply-To: <435ebb1b-431c-fdeb-023e-39c6f6102e22@axentia.se>
References: <20201101232211.1194304-1-linus.walleij@linaro.org>
        <CACRpkdZc=qGasbsL7DWbbRGyvxaX8hh2iU-QfLpkYGCD3UrqOw@mail.gmail.com>
        <435ebb1b-431c-fdeb-023e-39c6f6102e22@axentia.se>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 13 Dec 2020 00:22:17 +0100
Peter Rosin <peda@axentia.se> wrote:

> On 2020-12-12 13:26, Linus Walleij wrote:
> > On Mon, Nov 2, 2020 at 12:22 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> >   
> >> It happens that an ADC will only provide raw or processed
> >> voltage conversion channels. (adc/ab8500-gpadc.c).
> >> On the Samsung GT-I9070 this is used for a light sensor
> >> and current sense amplifier so we need to think of something.
> >>
> >> The idea is to allow processed channels and scale them
> >> with 1/1 and then the rescaler can modify the result
> >> on top.
> >>
> >> Cc: Peter Rosin <peda@axentia.se>
> >> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>  
> > 
> > Did we reach any conclusion on this? I really need to use
> > the rescaler on an ADC that only handles processed channels...
> > 
> > I'm sorry that I can't make this ADC disappear :D  
> 
> Hi!
> 
> My conclusion was that the patch is buggy since it presents inconsistent
> information. That needs to be fixed one way or the other. If the offending
> information cannot be filtered out for some reason, I don't know what to
> do. Details in my previous comment [1]. BTW, I still do not know the answer
> to the .read_avail question at the end of that message, and I don't have
> time to dig into it. Sorry.

Unless I'm missing something, I think it presents no information unless
we strangely have a driver providing read_avail for _RAW but only
_PROCESSED channels which is a bug.  I'm not that bothered about
missing information in this particular, somewhat obscure, corner case.

So I think we should take the patch as it stands.  It's missed the
merge window now anyway unfortunately.  So Peter, I would suggest we
take this and perhaps revisit to tidy up loose corners when we all have
more time.

Thanks,

Jonathan


> 
> Cheers,
> Peter
> 
> [1] https://lore.kernel.org/linux-iio/320464d8-659c-01de-0e08-34e4c744ef16@axentia.se/

