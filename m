Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D1A2D9054
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 21:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgLMUL1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 15:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbgLMUL1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Dec 2020 15:11:27 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F740C0613CF;
        Sun, 13 Dec 2020 12:10:47 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id u18so24954953lfd.9;
        Sun, 13 Dec 2020 12:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XTm0eaUt/xYCeTTbYO2e5zQruwXgfgvsHAqOaCJWwkc=;
        b=Ona6i0bTl9DuPKx9p3STr7Bht48/al++TKkVjrwhB+TFbUYIjx7yIYekl8AErDShGx
         MssfbzHeFJmXf+95LvbG/CguKazHqAicxwKdc4fL3dhHi6Ol9VF7brQ3+xu+LVSjzfK+
         j0sT9W4yfB0DXzjWZI2fXtOx2bjp6RS/1o4sXvj03CioLc5eT41wL+Xxx6719Qigv+ay
         vRklsqwKP/6npczHYvSNlVdDW8tr+52mJ2YqtG0so3bUN88fzqW4kdEJotBEQLMNTm2P
         hD0TTRCfXzDBHeV/Agk1PQVFh9qDw9s+RoHSS75iAGM2QpTuMG3rqaFjKEx/rZdH9va3
         wZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XTm0eaUt/xYCeTTbYO2e5zQruwXgfgvsHAqOaCJWwkc=;
        b=o/+zWGfRAdOY009ziBW7Q09gRWnj6nPPy+fhUASvcQg5fAinGwWRymQ+KM/AARDwoq
         WFB3sNosceNiHgrODfJIG/hmjbat6qxPgYSjzgVfp8mWDmA7SV8L00gQkgiKOX0afTLs
         nu0LTQMcMc4uK59n87Z8MkBH9sb5WAd8YTJw5mFYKy42X3kbosdFY+zKTCLpakIEcxPX
         gWchiijGi2zPtP+ax1mqLwyEkAvbrHjvMcNBAMFmX9M6Fu1SOO7ST5w7pqI9BLScUWsj
         wRV1wvUGJXaavp4dIXDb0eKXLU0Nq3yT3CK1j6qTTStEVNHkZ2q8fB+xW+WV67TI68P6
         dsQg==
X-Gm-Message-State: AOAM533caC4Sf2YtfWTZJDJthop44r4oHlAuXC7UKbBxvWPsH3MlMa1E
        wVhhjs67BOur6aTD/KWR8tSMUMoElwxj9kqG5Mk=
X-Google-Smtp-Source: ABdhPJxdaGVPHp2RzANbQ2jc302kNfnl+Y+7A/vimpTO6UTIA6SWB0qxAo9FTX6SP78WqCJATaFOeJgdXNO1ghom+SY=
X-Received: by 2002:a19:48c6:: with SMTP id v189mr7601380lfa.360.1607890244243;
 Sun, 13 Dec 2020 12:10:44 -0800 (PST)
MIME-Version: 1.0
References: <CANk7y0gAChikUBf-ap328YNQd4nrw63BiFH9dRLLDuZ0SnneMA@mail.gmail.com>
 <CA+U=Dsr=SCdSsbsbdY++NwD4xQjr6PZuoOqa_Ctq6ig+GuvO=w@mail.gmail.com>
 <dd7f7015-aed4-8628-0f23-e144fdacc9e7@roeck-us.net> <20201213151253.059e541c@archlinux>
 <729575c9-317c-a2ae-9ded-8732f3cc481d@roeck-us.net>
In-Reply-To: <729575c9-317c-a2ae-9ded-8732f3cc481d@roeck-us.net>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Mon, 14 Dec 2020 01:40:32 +0530
Message-ID: <CANk7y0gaq9Qb6BBpv4PY8T50Xep19Vh=wEx3hBWG_jDcqGSZJg@mail.gmail.com>
Subject: Re: IIO Driver for TMP117 Temperature sensor
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Dec 13, 2020 at 9:38 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 12/13/20 7:12 AM, Jonathan Cameron wrote:
> > On Wed, 9 Dec 2020 11:48:40 -0800
> > Guenter Roeck <linux@roeck-us.net> wrote:
> >
> >> On 12/9/20 12:11 AM, Alexandru Ardelean wrote:
> >>> On Tue, Dec 8, 2020 at 6:10 PM Puranjay Mohan <puranjay12@gmail.com> wrote:
> >>>>
> >>>> I have this TI's TMP117 sensor with me and I was thinking about writing an
> >>>> IIO driver for it as a hobby project. Is the IIO subsystem the correct
> >>>> place for this driver? if yes, can someone help me get started with this,
> >>>> I haven't written an IIO driver before. I have this sensor and also a
> >>>> raspberry pi with me for testing.
> >>>
> >>> This could also fit into drivers/hwmon.
> >>> Looking at the HWMON subsystem there are more TMP drivers there
> >>> (TMP102/103/108/401/513).
> >>> The first 3 seem a bit more similar to TMP117 (in terms of register map).
> >>>
> >>
> >> It would probably be better suited for hwmon (it has limit registers,
> >> suggesting a common use as hardware monitoring device).
> > It is a curious part.  I suspect TI based their design for a medical grade
> > digital thermometer chip on an existing hwmon part.
> >
> > The limit registers are very simple so could be supported by IIO.
> > This sits somewhere in the middle of high end thermocouple chips which
> > tend to be in IIO and typically lower accuracy / range hwmon parts.
> >
> > It's in the fuzzy borderline region so I doubt anyone would raise strong
> > objections to which subsystem it was in.  Guenter has fallen on the
> > hwmon side of things and I'm fine with that.
> >
>
> On the other side, it turns out that there is already tmp107 support
> in iio, and tmp107 is pretty much the spi equivalent of the same chip.

Yes, you are right, tmp107 is very similar to tmp117, but it is less accurate
and it doesn't include the OFFSET functionality. Actually, I had seen the
tmp107 register in IIO and thought that tmp117 should go in IIO,
hence, I wrote this email.

So, is it fine if I write the IIO driver for this sensor? Actually,
this will just
be a hobby project for me so It doesn't bother me if it goes in hwmon or IIO.

> So it really depends on the use case. If the user wants to use the iio
> subsystem, I am fine with it. We just need to remind people that this
> implies no or only limited hwmon support.
>
> [ I really need to spend the time to write a hwmon->iio bridge.
>   The iio->hwmon bridge is a bit limited - I have not been able to
>   figure out how to support limit registers (or event values)
>   and events, and I don't think it is possible. ]
>
> Guenter
>
> > Jonathan
> >
> >>
> >>> Let's see what others have to add.
> >>> But, all-in-all whatever driver you end up writing, the easiest method
> >>> is to copy an existing similar driver and extend it.
> >>> Sometimes, a part can be added to an existing driver.
> >>> At a quick scan through existing drivers, it doesn't look like TMP117
> >>> is similar to existing drivers, so it may require a new driver
> >>> altogether.
> >>
> >> I don't see an immediate match either, but the tmp102 hwmon driver
> >> might be a good start.
> >>
> >> Guenter
> >>
> >>> I may have missed something though.
> >>>
> >>> Thanks
> >>> Alex
> >>>
> >>>>
> >>>> --
> >>>> Thanks and Regards
> >>>>
> >>>> Yours Truly,
> >>>>
> >>>> Puranjay Mohan
> >>
> >
>


-- 
Thanks and Regards

Yours Truly,

Puranjay Mohan
