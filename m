Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6E61F11DE
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jun 2020 05:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgFHDsC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Jun 2020 23:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728763AbgFHDsA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Jun 2020 23:48:00 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE3CC08C5C3;
        Sun,  7 Jun 2020 20:47:59 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id a13so15435334ilh.3;
        Sun, 07 Jun 2020 20:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1BVaUAixWvTt5WtErptsO3tP6DKbMMPVMIbp5bkToTg=;
        b=GPZbee1Wrp9z8b27aPeqkytHNsHLuyoMrLecMsczdjrjhHLmGzgX1gEcZU6x0wUW0Y
         3dhCTyXptIlrdFwbuYyAtabHVwExW6Dc5T0E4xiCwPJ1SnaQb3xP7Yqe3CX4xqAK3bmK
         B0So2hHw1CJyOObYlkRnt7LBoMLR5vMh6u34hXEBsKbpvdkbx8XDD0lGbOURLpWfsdXi
         FiVv9/JWXxVfns8TAnRS5aVeAfDpsabNwngaVLuKc6CD+kF9uCwAVvlNwFXZ1XlbD7tj
         SkDpMSVT2ZnQCiwNSydq0aA2lnvDRRKCDglzgO71TWp53dz+ozxYpeszI8bqNa99jg+f
         cjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1BVaUAixWvTt5WtErptsO3tP6DKbMMPVMIbp5bkToTg=;
        b=T7DjojzD4oAc494xaYpUDHiF7Srjl3Ez1F4Z6YtIrU8WCpcQGKkeMPk7FXNLAHMnlU
         HlL/JtQKlUoFUVi5welkmz7k/VG7Okpl7p4y3oBcdWVAdi5DP0csm/3mk+tOIezm6d/h
         Pa5Irntg+aJqRMXOm3C+36R4xJBYlOsT5Jg2WI3KdZxNq9g6TMwvT0+lTCmrVRpNHyq8
         41KS8VV8KOXX2R+TbYPZbiquLD2Sf6QLph7llnpZtxlYO9Q0A99LLrX3ONRB6UB56dHR
         BCyefuBed96vkPnWsvG83uo+XRtaq48gtnqMY++g9qdzXIKlGi+Om6oJRqnhnwHRolgD
         /srw==
X-Gm-Message-State: AOAM532d2u4iH/QaDABWFWcO3XbKv2+lHFQvdaECfHbu5E0H35K2pac3
        e8271Yl4gAZvhAwjRPOIRgjXe/Wx5ABW1wbAMUg=
X-Google-Smtp-Source: ABdhPJykuldEnjkxysg7fzHCYSvtqif6Tsc2jA5532TVy0njbI9trWfbZiGLz9x25D5eNF5Is+vHlZx5gdwA797Gfz8=
X-Received: by 2002:a05:6e02:4d:: with SMTP id i13mr21094586ilr.227.1591588078478;
 Sun, 07 Jun 2020 20:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200605024445.35672-1-navid.emamdoost@gmail.com>
 <20200606171153.6824a326@archlinux> <CAHp75VeRaS0JBRSyr+MeCbkVsscLyxkag00eY+pMPXZ6Jvb2zQ@mail.gmail.com>
In-Reply-To: <CAHp75VeRaS0JBRSyr+MeCbkVsscLyxkag00eY+pMPXZ6Jvb2zQ@mail.gmail.com>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Sun, 7 Jun 2020 22:47:47 -0500
Message-ID: <CAEkB2ETaiZM9aQsH8_eeBSDPzTpjSLpWSeHV1S3mMxMjM+_TyA@mail.gmail.com>
Subject: Re: [PATCH] io: pressure: zpa2326: handle pm_runtime_get_sync failure
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "emamd001@umn.edu" <emamd001@umn.edu>,
        "wu000273@umn.edu" <wu000273@umn.edu>,
        "kjlu@umn.edu" <kjlu@umn.edu>,
        "smccaman@umn.edu" <smccaman@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jun 6, 2020 at 2:29 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
>
>
> On Saturday, June 6, 2020, Jonathan Cameron <jic23@kernel.org> wrote:
>>
>> On Thu,  4 Jun 2020 21:44:44 -0500
>> Navid Emamdoost <navid.emamdoost@gmail.com> wrote:
>>
>> > Calling pm_runtime_get_sync increments the counter even in case of
>> > failure, causing incorrect ref count. Call pm_runtime_put if
>> > pm_runtime_get_sync fails.
>> >
>> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
>>
>> Hi Navid,
>>
>> This looks to be a fix, be it for a case that we are hopefully
>> unlikely to ever hit.  Please could you add an appropriate
>> Fixes tag so we can work out how far to backport it?
>>
>> Patch looks good to me so if you just reply with a suitable
>> tag I can add it whilst applying.

Hi Jonathan,
Here is the fixes tag:

Fixes: 03b262f2bbf4 ("iio:pressure: initial zpa2326 barometer support")

>
>
>
> Should not be "iio: ..." in the prefix?

Yes! It should be "iio" in the patch name.


>>
>>
>> Thanks,
>>
>> Jonathan
>>
>> > ---
>> >  drivers/iio/pressure/zpa2326.c | 4 +++-
>> >  1 file changed, 3 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
>> > index 99dfe33ee402..245f2e2d412b 100644
>> > --- a/drivers/iio/pressure/zpa2326.c
>> > +++ b/drivers/iio/pressure/zpa2326.c
>> > @@ -664,8 +664,10 @@ static int zpa2326_resume(const struct iio_dev *indio_dev)
>> >       int err;
>> >
>> >       err = pm_runtime_get_sync(indio_dev->dev.parent);
>> > -     if (err < 0)
>> > +     if (err < 0) {
>> > +             pm_runtime_put(indio_dev->dev.parent);
>> >               return err;
>> > +     }
>> >
>> >       if (err > 0) {
>> >               /*
>>
>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>


-- 
Navid.
