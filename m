Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A36360413
	for <lists+linux-iio@lfdr.de>; Thu, 15 Apr 2021 10:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhDOISS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Apr 2021 04:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbhDOISP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Apr 2021 04:18:15 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D652CC061574
        for <linux-iio@vger.kernel.org>; Thu, 15 Apr 2021 01:17:51 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t22so16425091pgu.0
        for <linux-iio@vger.kernel.org>; Thu, 15 Apr 2021 01:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/9AWoB4ye/0POiEbbIM/oDk0WhuOPc64+qLDIN/mbeQ=;
        b=OLI73ol7TlL70w3gmHZauoH4ow4D23caoG3K27RbUmmCKkjRWCf1F536iFI43EbQ4m
         EMhms311e0mAgqm90kk5hxa3o+npidJSd4UTOjh+h/rwwNAAnJ6QFT2pvqeY9fw1meQa
         nhHXCq5/xwZIPBCm0MS8FKrQ7VcrH+8nDSYySNk+JDd7d42GDimE4fKSOYBicy7VDWcY
         bMsiVMzadQDRT7VFpjlOQPrdBCPOmfNeq1JU3M+/IQGetWIWPQfmN8QmjWk/M9nlrCK9
         FJvXiAL8Y7lJIZah9G/cbw0bK4duVzVx70q0po7rvyxeZvySQZOMnp+t7YEMvUBPyHAC
         LSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/9AWoB4ye/0POiEbbIM/oDk0WhuOPc64+qLDIN/mbeQ=;
        b=JemDJCX+kyqCNDdEMr41kBijmU6oyipInEv583R6ZVac6DRiDt7x4VUsP+V4PAzck+
         gzcU16s5TRm8Ttc5ohVZQh3f0MciUA6paxnosa6y4YuWZ3yrQP4aKnG0cZEC1ViI3tB4
         GFnxZU+NLup906/07YFEgRnd51CcUGFhOZ/ohY5a+lQbL4nOsEdr+BnUK01HRStQy6TE
         fh8HNJETKCYrq1eoWpGbVkhl8e2zyIL1t4La8JOirjz41tZM0EPUKhxF9TPuBALcDgkY
         ejM7yHJ1oIFCbN8AnN7o1OeRCJ10EN7gPYFtCuce3Ok2MqaVEGFCrdltWzQKfONVx3QM
         A7uQ==
X-Gm-Message-State: AOAM5329I9+/59nAxYLnl46ptiqh3NOCuEg7LXxruM4ILuStL78E7yB2
        4CsZavgMXKE/xtE7ezeLxykEX/Hw2vgk5KIDgmf/YZJjcrTfVA==
X-Google-Smtp-Source: ABdhPJxqtWRI51BZsK46eeLVrdMaEqbzDRHUxYlBfK1ooJJCS9/GIwiZ+DQpWkaMJvhJcIB4CUJqDFlN9PEWpj7eXdk=
X-Received: by 2002:a62:3486:0:b029:24c:34c0:3c7a with SMTP id
 b128-20020a6234860000b029024c34c03c7amr2258503pfa.36.1618474671433; Thu, 15
 Apr 2021 01:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210413112105.69458-1-nuno.sa@analog.com> <20210413112105.69458-4-nuno.sa@analog.com>
 <CA+U=DsqFJ_qJk_vnyvxJeN0Cfm9uN82RfWmvrNV5uDX7qgWPGA@mail.gmail.com> <CY4PR03MB3112FE37268179DA1ED3436C994D9@CY4PR03MB3112.namprd03.prod.outlook.com>
In-Reply-To: <CY4PR03MB3112FE37268179DA1ED3436C994D9@CY4PR03MB3112.namprd03.prod.outlook.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 15 Apr 2021 11:17:40 +0300
Message-ID: <CA+U=DsrC=QFLn9YJNa7O7=gsLkm-utg3UKJwXMipgnzSzOhRNQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] iio: adis16475: do not return ints in irq handlers
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 15, 2021 at 10:38 AM Sa, Nuno <Nuno.Sa@analog.com> wrote:
>
>
> > From: Alexandru Ardelean <ardeleanalex@gmail.com>
> > Sent: Wednesday, April 14, 2021 9:27 AM
> > To: Sa, Nuno <Nuno.Sa@analog.com>
> > Cc: linux-iio <linux-iio@vger.kernel.org>; Jonathan Cameron
> > <jic23@kernel.org>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>; Lars-Peter Clausen
> > <lars@metafoo.de>
> > Subject: Re: [PATCH 3/7] iio: adis16475: do not return ints in irq
> > handlers
> >
> > [External]
> >
> > On Tue, Apr 13, 2021 at 5:45 PM Nuno Sa <nuno.sa@analog.com>
> > wrote:
> > >
> > > On an IRQ handler we should return normal error codes as
> > 'irqreturn_t'
> > > is expected.
> > >
> > > Fixes: fff7352bf7a3c ("iio: imu: Add support for adis16475")
> > >
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > ---
> > >  drivers/iio/imu/adis16475.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
> > > index 1de62fc79e0f..51b76444db0b 100644
> > > --- a/drivers/iio/imu/adis16475.c
> > > +++ b/drivers/iio/imu/adis16475.c
> > > @@ -1068,7 +1068,7 @@ static irqreturn_t
> > adis16475_trigger_handler(int irq, void *p)
> > >
> > >         ret = spi_sync(adis->spi, &adis->msg);
> > >         if (ret)
> > > -               return ret;
> > > +               goto check_burst32;
> >
> > This is also going to call adis16475_burst32_check().
> > Which in itself is [probably] an undesired behavior change.
> >
> > Maybe this needs a new 'irq_done' label?
>
> That was intentional. If someone changed the decimation or the FIR
> filters so that we can change to burst32, we can just do it now...
>

ack
