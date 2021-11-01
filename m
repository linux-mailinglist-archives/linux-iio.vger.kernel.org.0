Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F18441C86
	for <lists+linux-iio@lfdr.de>; Mon,  1 Nov 2021 15:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbhKAOYA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Nov 2021 10:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhKAOYA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Nov 2021 10:24:00 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35FEC061714
        for <linux-iio@vger.kernel.org>; Mon,  1 Nov 2021 07:21:26 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id f8so43367583edy.4
        for <linux-iio@vger.kernel.org>; Mon, 01 Nov 2021 07:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F1es8/Gj4/wggwgRqpuj2H6GasTNoGYTHVZoKDoD8fc=;
        b=eCJjNNrt9wwjuEH+Uv0bP+X8R27Jm6sbyPLa77dLEN7Ql2aY5ZdTiP8qQjvx99yDPN
         DjQ72mLLwJPrJAw59Gq5yFQU7CNAektvxkWQnhCxvo6ynWQDHj8pIWP4abtwrsDZgdtJ
         lAwQ7IxKjfv8tzCqL+DyGw93KMI+vC30XzHv2yqS2xJanYGDVtt8sn9kJYpRCq2XJf7d
         ngmy9p1uunX+/gYK5dU4n77Ntm7tpC9Cy/cfpSeYS0tXvlWpijgPyMafrYmhlJXAHGp+
         WqEVD3vUYqdU59Bgrjz61NktyAOMeM6pPbhgLEwuymuiiIa5OfZQkB7GGImapP+BIqKo
         vAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F1es8/Gj4/wggwgRqpuj2H6GasTNoGYTHVZoKDoD8fc=;
        b=PPH74FjWjlE9ZpN2NeEkwc6cRJujcqiFCrZ53HnbYu78pD3JRQ02dDgbRVOuPVqGbE
         raq5/fCwtnFHxg08Wsb92NeYvPGVKISMa91YGEjshb6HxNfq1b5GbMzKDjJQjZx9lP5U
         ju5FGChQFsbt4LsIJblD7LZTErtWAei8hImDc7gY+9WQLxfoSiZzF0lVr3yRGSP7zdFP
         0wZ81FubrbbTpcrBMgyaeCaqAYUopNyBSprfnlUeUG9G7r09CZOXmCABn+QRBeGYMCU/
         r2mdb1h/RfXWHpI17lSkfYzKnRWE2MS28U7R/YqzAVTSLIAP5jSTOFpNXm5Q0hbD8QX1
         Vcfw==
X-Gm-Message-State: AOAM532YL2SW1RJvC2Ed/BH0ja/e1T16awZP36qY3nk3Fp0SsbkPA1EV
        d5oJ4Qx+hkWmOeOXQst7BME1Gen36JlVbr98LP0=
X-Google-Smtp-Source: ABdhPJwVqgCBvXatoJBQ9PCRcA8wli1MsPiiJQSDpEG7WgWqmnyWcBrDGJxnRjxnDjsi3tnhTTSQy9h7T7o8xmKFKSI=
X-Received: by 2002:aa7:c44b:: with SMTP id n11mr20353882edr.238.1635776485370;
 Mon, 01 Nov 2021 07:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211031164603.4343-1-maslovdmitry@seeed.cc> <CAHp75Vd99uk+wZHpVyYEveNGTaK9Nj5-oYTRua2UhOKjtYnS_g@mail.gmail.com>
 <1d537660.dd.17cdbca2bb6.Coremail.maslovdmitry@seeed.cc>
In-Reply-To: <1d537660.dd.17cdbca2bb6.Coremail.maslovdmitry@seeed.cc>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 1 Nov 2021 16:20:35 +0200
Message-ID: <CAHp75Vc+Yqcq=gtpMgzb5pDc9nuNbzzwVjfsTg20hZ7VfAQ88w@mail.gmail.com>
Subject: Re: Re: [PATCH v3] iio: light: ltr501: Added ltr303 driver support
To:     Dmitry Maslov <maslovdmitry@seeed.cc>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, north_sea@qq.com,
        baozhu.zuo@seeed.cc, jian.xiong@seeed.cc
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Nov 1, 2021 at 3:57 PM Dmitry Maslov <maslovdmitry@seeed.cc> wrote:
> > From: "Andy Shevchenko" <andy.shevchenko@gmail.com>
> > Sent Time: 2021-10-31 22:07:09 (Sunday)
> > On Sun, Oct 31, 2021 at 6:46 PM Maslov Dmitry <maslovdmitry@seeed.cc> wrote:

...

> > > Signed-off-by: Maslov Dmitry <maslovdmitry@seeed.cc>
> >
> > I believe it should be Dmitry Maslov, i.e. First name Last name.
>
> I could change that, but I do not think there is an international standard for that. The reason I put Maslov Dmitry
> is to be in line with corporate email address, which belongs to a Chinese company - in China surname is put first
> on the legal documents.

Hmm... You are right, there is no such requirement in the Submitting
Patches document.
...

> > > @@ -1597,6 +1610,7 @@ static const struct acpi_device_id ltr_acpi_match[] = {
> > >         {"LTER0501", ltr501},
> > >         {"LTER0559", ltr559},
> > >         {"LTER0301", ltr301},
> > > +       {"LTER0303", ltr303},
> >
> > Any evidence of this ACPI ID being in the wild, please?
>
> I'm sorry, I do not exactly understand the question. Do you mean where that particular sensor is used?

Can you provide a name of the machine which has this ID in its DSDT
table, please?

-- 
With Best Regards,
Andy Shevchenko
