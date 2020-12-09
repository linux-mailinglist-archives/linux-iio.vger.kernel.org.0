Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A57A2D46CB
	for <lists+linux-iio@lfdr.de>; Wed,  9 Dec 2020 17:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbgLIQds (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Dec 2020 11:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbgLIQdr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Dec 2020 11:33:47 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B38C0613CF
        for <linux-iio@vger.kernel.org>; Wed,  9 Dec 2020 08:33:07 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 131so1339107pfb.9
        for <linux-iio@vger.kernel.org>; Wed, 09 Dec 2020 08:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NCwSc/Najcsr0WP91BSb9FcXmTA4Mh4hT76R8VMqk0k=;
        b=lkVJe8iP8HPNWKBRvaEQziVyUoPv8tCycCF+emsVUpuhegTgioG/PWjirN/hymIbJX
         N/13Bxi40ZToG7q4vSyCfUO3gAeyzlzPkerAzM6+XCvmsrzsGy1LomeqOqewE7jZXB6x
         2C3P1Anuk9wPtRRZBkdJ2/ERmyEn8Q/wj6dG1KXd42Ojp2xJQab/t0r0ppXOxwbsRfxo
         EzDyqE0s8docwXETDFFUlAgp90wYx1xgAYQCYzwygx/E00XmNA9eZmmrlRtPh62fe3XT
         QKKCdYDFq83sgVFN0Yc0RJCbi8LNPKwbzOopiXb6BQNsdPn2dlQCVJcVoqJoyij9y0LW
         fGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NCwSc/Najcsr0WP91BSb9FcXmTA4Mh4hT76R8VMqk0k=;
        b=Ir8TY2c5x1KKryIprdK88MfJixgyngDSjSBx8j05Z7aiKhjf1VRLsWNU0vRhMS5Gg+
         ExZSsp+mEM1IcPwKpaKXx7CCgAJvaIpY/I/Q9ZJ/AN7mn1oRI4xyHXUcUb2W0w1MbuGe
         9TVaNSCY7NeqUK+y2knxJmT7lB4loYOwEYB1zzk5pp51votOA2e5Kpt5tWm3KfHadpio
         Rt+wV15vfI1fjASK1BC9A4H015HvYFqwyZAviqJOxerGkFES9UcAeg/9YWTWhkInLgCg
         9Wp4TItjZP0ICP8h6MgTIz2Bw3+iaPPgemaevj8nDxq8Nu0Q4wmkO6E8eWKvkBZQwCsh
         ppiw==
X-Gm-Message-State: AOAM530yYqmTaiP2xRJQHw+zpJer74GXK1YWBhJixVxx+b3Ru3S7DbaT
        pdN6vewkGubsiC9Tdqaki4p9zzf9NGykVJSNQ5U=
X-Google-Smtp-Source: ABdhPJxxwpDat2guRgPp4nn4fsAKGg3OdUQVbZnmIZZ6maQugQppSWG+WcMoO9ZuP6QQU4tBViTcgc0m4Jz+aMxBVzo=
X-Received: by 2002:a62:445:0:b029:19c:162b:bbef with SMTP id
 66-20020a6204450000b029019c162bbbefmr3087760pfe.40.1607531587107; Wed, 09 Dec
 2020 08:33:07 -0800 (PST)
MIME-Version: 1.0
References: <CAHp75VcDJd_ROcPE6GJvz3J4fTp_a=PX2GpjRc3RV16edzYmrA@mail.gmail.com>
 <688821bc-f93c-c98c-974c-ec46fa4111bd@metafoo.de>
In-Reply-To: <688821bc-f93c-c98c-974c-ec46fa4111bd@metafoo.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 9 Dec 2020 18:33:55 +0200
Message-ID: <CAHp75Vc5b_=KuvJxgxBJgijkKOp_bnbxGo_K04_-svB3oGds5w@mail.gmail.com>
Subject: Re: kernel bug tracker
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 9, 2020 at 6:07 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
>
> On 12/9/20 4:58 PM, Andy Shevchenko wrote:
> > Hi!
> >
> > Does the I2O actually refer to IIO on kernel bugzilla?
> > In any case, default there is Alan Cox' email and I didn't find
> > Jonathan's there.
> > If the answer is "yes" for above, does make sense to:
> >   - change its name to IIO
> >   - put mailing list as default assignee?
> >
> >
> There used to be an I2O subsystem, but which has been removed[1].
>
> I supposed if it is used for IIO drivers at the moment I supposed we can
> take over the tag and rename it to IIO, given that there should be no
> new I2O tickets.

Sent request to the help desk.

P.S. I reverted the subsystem to I2O in one bug (#209889) to be able
to filter them out all when we will have a proper component
registered.


--
With Best Regards,
Andy Shevchenko
