Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 833FC18EC7F
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 22:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgCVVP1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 17:15:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41181 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgCVVP1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 17:15:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id b1so6096291pgm.8
        for <linux-iio@vger.kernel.org>; Sun, 22 Mar 2020 14:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DM5vGCEAD5juZQZvjN1SKehHr/xQbmYyxIO056QW6tk=;
        b=MAK2kGTD7sfhKO68YGiZBZNRc2noil0jvlXx9sO6xQuTmDtZpIPXUV45Xw2teNppP4
         EbQQ6KesqOYM3f7sYeeKTjaXpg4IqIDadnA3t09+maTrHpgcFA4cZ0W/o7rA0THJG2pS
         4Nw27/NiKZaI8eBUNZgtEW8o8Bv+7o13EOiINZruogLReNAjtmHzmjnqQyrjJFn4h1yt
         ckb6ck7djnPgxpE1Xm9zmhSInlmMLy7VDjBGSZ9glioDKE3hWHT5/Fu5HUj3NV57BM02
         XsSuXUk2PmocFDl01YRFoDbUTtZ7wZMEGz3ZpE62YXJIi6zQ88hIRVwinIknwoVjz2VG
         uFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DM5vGCEAD5juZQZvjN1SKehHr/xQbmYyxIO056QW6tk=;
        b=aQFojUo7ltG5a8ZEbNms56P7dmgEGhSiSaODXwk4f9qS+J9uaH04eI5Wd+IxpP0BsN
         8sgb+UZAYHVAbhUxzLyubuHVOzNg88+eNUzqfEq+gPSRvxcCYSdsX6VMx8Bpu6AsZCHy
         mUg0WgxcvQ7Xy43af+/hyPIXwt361AfDaTqlBFNKR7C1Nccigy2my0d2yG7xYvtkB0b3
         02xzPAyyjq66UtJ18o1szfyb+TvWs2Gtm2zWmrBpLZkp2qXfrhGW32ZoympqFUYiaLcc
         iu4quee36Q9BjLCahpy1+Fi/naK9LHxEVg45QP8thPWA0fUDLv/IOpFZdB4ovAlY0bzr
         i7kQ==
X-Gm-Message-State: ANhLgQ3JxKjIFoFx8JlZ4kA8rD7oKwjf0GKUBEDYU3Vt+x5/OwOkR5ka
        YrMWSb87eKAlk3t7upT+itQ3e2GBiTqXLsT0wIw=
X-Google-Smtp-Source: ADFU+vs1pN1PsyEvI7L1IbZShlZS1a1wbf80BPyPkudZ/sSSgVdplK4hye/yUSNzKWGc2zLSlPbGva/BdmBd1YeUaIw=
X-Received: by 2002:a63:5859:: with SMTP id i25mr18226091pgm.74.1584911725309;
 Sun, 22 Mar 2020 14:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200317101813.30829-1-andriy.shevchenko@linux.intel.com> <20200322171216.3260cd37@archlinux>
In-Reply-To: <20200322171216.3260cd37@archlinux>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 22 Mar 2020 23:15:13 +0200
Message-ID: <CAHp75VcUPSmCnKFSm8y6Nq_qCcMHHihACC+49FyzrawAqMjQDA@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] iio: pressure: bmp280: Tolerate IRQ before registering
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 22, 2020 at 7:14 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Tue, 17 Mar 2020 12:18:09 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> > With DEBUG_SHIRQ enabled we have a kernel crash
> >
> > [  116.482696] BUG: kernel NULL pointer dereference, address: 0000000000000000
> >
> > ...
> >
> > [  116.606571] Call Trace:
> > [  116.609023]  <IRQ>
> > [  116.611047]  complete+0x34/0x50
> > [  116.614206]  bmp085_eoc_irq+0x9/0x10 [bmp280]
> >
> > because DEBUG_SHIRQ mechanism fires an IRQ before registration and drivers
> > ought to be able to handle an interrupt happening before request_irq() returns.
> >
> > Fixes: aae953949651 ("iio: pressure: bmp280: add support for BMP085 EOC interrupt")
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Hmm. Nasty corner case but fair enough to fix it up.
> I guess we should audit other drivers for similar paths...

One can easily test, no device even needed (however in this case I have one)

...

> > -     if (data->use_eoc)
> > -             init_completion(&data->done);
> > +     reinit_completion(&data->done);
>
> reinit on the completion when we don't even have an interrupt
> (hence data->use_eoc == false) seems excessive.  Why did
> you drop the conditional?

It's harmless and gives less code I believe.
But if you insist I can put it back.

-- 
With Best Regards,
Andy Shevchenko
