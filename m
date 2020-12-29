Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A7F2E72BC
	for <lists+linux-iio@lfdr.de>; Tue, 29 Dec 2020 18:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgL2Reg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Dec 2020 12:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgL2Ref (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Dec 2020 12:34:35 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AC2C061574
        for <linux-iio@vger.kernel.org>; Tue, 29 Dec 2020 09:33:55 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id n7so9600862pgg.2
        for <linux-iio@vger.kernel.org>; Tue, 29 Dec 2020 09:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2//MIsONO3mriIbu81WX8XglKAS1thN17aZm4kItRSk=;
        b=sLCIwj6xfAcMDSekky4cnBR22KlrJwKtqAT2jWCe5pWyBxmwRjNC//o75Fdt2ClygV
         cLY/5MWRvpR/kE2+Agy3ccRM71XEUwXOFkUt6O5MAcR/dgX7MmWDoODvxzpMj3r66Du7
         U0dqh5QrgaEdwg7fjJLVpCVLWdHYDpCtI2gO6TSqWM1y3CMgekv5xA0MFw9SJ+NeP5Lr
         9gVTvNAiCiI009Tmv1L3DVOHe/vv/jTe6fP2w7QzD1YZMkrbYk2FpzYgEmRoxSjxAN/+
         bcD+rFWKvpTUtoFpnUGu/LiCx6UoiiGjFhQD8UVhvhGJij+P0wTG3oAJ0HQYsnBU+PWk
         Y4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2//MIsONO3mriIbu81WX8XglKAS1thN17aZm4kItRSk=;
        b=kMhdRoCa8i03rjGo1lLJdhRD3V08phdXdkVzXmYgdUY/hNxDTypKwbghxgjx3UkwzQ
         pKpr4FQxE/2IS2bCTtmFvSYtMs+WJoUzJcUrclH3hSUVgoszDaKLbL16psD5lbyZT6UN
         7/opHnd3wQ03TeGKOWs8YxgMRHdKXTptUkB899CAuPN+naf7pLDtBlL1Iy8YGRMFGw4E
         AMGDdci4P3FcZmMm7ujWHJZPBa4pJug5d5bsMYJ5IKDFxbIHe9OEZuDVj8kCgmfQ80Vi
         wEh6NfU9QK+Y1qKqwZWegqIRBrI70JE/1ST696eXwHh5AE4LWUzS9JTHYdnKrrGkc+sz
         4T1A==
X-Gm-Message-State: AOAM530H287npGazYDRvVQ/opI8RUoCY7wp+94v3hyGS2YKTlL6rs0Rr
        CFJUtFe8Zqn+yB5Bxz/cjMxS3R5ke6S1+ZhstWs=
X-Google-Smtp-Source: ABdhPJwEvt6bUXc2dXQRhiUA3gTXvJocf5w7Y3cNFKDKpDejGZO75kxdopYpudwM84lp6GRyuvYmgog/mio8brHhfJs=
X-Received: by 2002:a05:6a00:170a:b029:19d:afca:4704 with SMTP id
 h10-20020a056a00170ab029019dafca4704mr24813247pfc.7.1609263235356; Tue, 29
 Dec 2020 09:33:55 -0800 (PST)
MIME-Version: 1.0
References: <20201216214107.774969-1-gwendal@chromium.org> <20201216214107.774969-4-gwendal@chromium.org>
 <CAHp75Vfn=KtzN7zpm+pRES3L6R9k77GhHUFkxjrHcV67Vwx7kA@mail.gmail.com> <20201229172439.2a65580f@archlinux>
In-Reply-To: <20201229172439.2a65580f@archlinux>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 29 Dec 2020 19:33:39 +0200
Message-ID: <CAHp75VdQF7truiuWshYbvCAan2Qc0TomTesLwv2dDFhF5qkxqg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] iio: acpi_als: Add trigger support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Dec 29, 2020 at 7:24 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Thu, 17 Dec 2020 00:38:06 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> > On Wed, Dec 16, 2020 at 11:41 PM Gwendal Grignou <gwendal@chromium.org> wrote:
> > >
> > > As some firmware does not notify on illuminance changes, add a
> > > trigger to be able to query light via software (sysfs-trigger or
> > > hrtrigger).
> > > Add a hardware trigger set as the default trigger to maintain backward
> > > compatibility.
> > >
> > > Check iio_info reports the sensor as buffer capable:
> > >   iio:device0: acpi-als (buffer capable)
> > >
> > > To test, check we can get data on demand on an Intel based chromebook:
> > >
> > >   IIO_DEV="iio:device0"
> > >   echo 1 > iio_sysfs_trigger/add_trigger
> > >   cat trigger2/name > ${IIO_DEV}/trigger/current_trigger
> > >   for i in ${IIO_DEV}/scan_elements/*_en ${IIO_DEV}/buffer/enable ; do
> > >     echo 1 > $i
> > >   done
> > >   od -x /dev/${IIO_DEV} &
> > >   echo 1 > trigger2/trigger_now
> >
> > Few nitpicks below. After addressing, take my
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > assuming that backward compatibility has been tested as well.

...

> > > +       if (!iio_buffer_enabled(indio_dev) ||
> > > +           !iio_trigger_using_own(indio_dev))
> >
> > I guess it can be located on one line.
> >
> > I hope those functions have no side effects. In that case you may
> > invert logic (save 2 characters)
> >
> >        if (iio_buffer_enabled(indio_dev) && iio_trigger_using_own(indio_dev))
>
> You can but at cost of indenting the whole following block on level further.
> I'm not that fussed, but in general that doesn't seem like a good idea to
> save two characters here.

I didn't get it. The proposed change, in case of no side effect, is an
equivalent to the existing one, just 2 characters less.
How does it affect code block indentation?

-- 
With Best Regards,
Andy Shevchenko
