Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B422E06AA
	for <lists+linux-iio@lfdr.de>; Tue, 22 Dec 2020 08:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgLVHWo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Dec 2020 02:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgLVHWo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Dec 2020 02:22:44 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87C6C0613D3;
        Mon, 21 Dec 2020 23:22:03 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id w17so4530204ilj.8;
        Mon, 21 Dec 2020 23:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I2u/p95HFAgUInWm+oTbwloJHBZZQQY403Ouq8HbVgs=;
        b=AwIv6s55JEf1nH8N7x2Zv2dps4FbCsh63q0Ml7aDOcZls2PW4sYpgu0DhbJ67gOiHo
         0y2qnkvwXFSmi+P22mBJU+sZv3/37aiiyOKGHhzys7EP69b2nEwig16l8dUbzRT70AM/
         AFa72XA+z2JYJLczhqgbFOvKNUqN2Mq07M+DsPvzUUt/ODArTrv2OZ6jqTOXFIU2dA6I
         Cu/ESC5BeqVZc2tlcg1sSItO/66M4pPMAYrcYjwz9mzXVnSEIPNyhM87YB22lu3Ui+nQ
         WjxRcMjtv9XmLts2IHGoJDln8Goc+fB/mz2hXyFk5iJf8f6o7xaKRV9B9AZZYyyI5wQg
         LzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I2u/p95HFAgUInWm+oTbwloJHBZZQQY403Ouq8HbVgs=;
        b=i2kpIkUxbdJPdDBnAyJnUjYdL2bT26YfaH4SeA1caj88+Yy+vtNBAuBmRe3vDzSCyr
         3RrbPjzHtToCXmo8U1Px5SwBrtMNdJha5+kh0v9GBARwJYuqS+scUOYGdsD4yQ/7HH88
         0YwpNmYvZYjLYpUpTaHrTT/mF0EKla6kI39khD2WAzuPb62cNvV6qQSPwC1CzxH8PRR9
         MOlyLT8q8Dj5Kvvkki87ZtsDVrZA30QR2twfTuRN//q33X6gGM1M243EWIO2vzGnt2TK
         aMX7D3UszHccf2OIJ1FJYEOZfqQwmmda5ZyfQ2hqlcYRVoAGZm50kJ9uzn//N4bQq/Lo
         8jSw==
X-Gm-Message-State: AOAM5316aQF+doubodXSlt4RcQJuShuzhqU4f4PUF2OBqwdiyFgTBGDa
        qTMTWRazkel3j2gI0T4Pnw5B2NALYECB4PXfymq1+74yA39ydg==
X-Google-Smtp-Source: ABdhPJyxI331doQShMhYnTgKTb2dBJtom9BVR2JnkLAOtcmIT31qMr8g/Xh+Ad8LWnbsFTYDFnA1+4MeuIk2n2BYNzA=
X-Received: by 2002:a92:155b:: with SMTP id v88mr20184086ilk.303.1608621723257;
 Mon, 21 Dec 2020 23:22:03 -0800 (PST)
MIME-Version: 1.0
References: <20201221151551.52511-1-alexandru.ardelean@analog.com> <CAHp75Ve6GHU50WO3Ygmfz8GU=22jpLi+JeDoA3TiY8bp76T09A@mail.gmail.com>
In-Reply-To: <CAHp75Ve6GHU50WO3Ygmfz8GU=22jpLi+JeDoA3TiY8bp76T09A@mail.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 22 Dec 2020 09:21:52 +0200
Message-ID: <CA+U=Dsont-N2Ev3bbO+O_v23OAx11MhkLYsHJjAisNyu4kO2Bw@mail.gmail.com>
Subject: Re: [PATCH v4] iio: Handle enumerated properties with gaps
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Dec 21, 2020 at 8:02 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Dec 21, 2020 at 5:11 PM Alexandru Ardelean
> <alexandru.ardelean@analog.com> wrote:
> >
> > From: Lars-Peter Clausen <lars@metafoo.de>
> >
> > Some enums might have gaps or reserved values in the middle of their value
> > range. E.g. consider a 2-bit enum where the values 0, 1 and 3 have a
> > meaning, but 2 is a reserved value and can not be used.
> >
> > Add support for such enums to the IIO enum helper functions. A reserved
> > values is marked by setting its entry in the items array to NULL rather
> > than the normal descriptive string value.
>
> ...
>
> > I tried a few shots at working with 'lib/string.c', and that went
> > slow. The __sysfs_match_string_with_gaps() approach has stalled.
> > https://lore.kernel.org/linux-iio/20190422140251.8960-1-alexandru.ardelean@analog.com/
>
> Hmm... If you are not going to push that forward, perhaps better is to  provide
> iio_sysfs_match_string() and if we need it in the future for other
> users, it would be easier to find and export. Also it will be a matter
> of one line change in the caller.

That can work as well.
Maybe add the __sysfs_match_string_with_gaps() here directly?

>
> --
> With Best Regards,
> Andy Shevchenko
