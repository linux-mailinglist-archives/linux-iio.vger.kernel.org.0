Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDDA2D9055
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 21:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgLMUPU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 15:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgLMUPN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Dec 2020 15:15:13 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6232DC0613CF;
        Sun, 13 Dec 2020 12:14:33 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id r24so24960915lfm.8;
        Sun, 13 Dec 2020 12:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lZB9aE3TmuoFmja0UZgEe4Pd4lsy6UpnTCXsS1s9/eg=;
        b=N8SoIQm5YgOPv6FVm30pkMvlq/Z5lN1qQEdujYjsPWGOrdRmWWFPyLLJAAVDey5bwF
         dwj8EpI0vnm6bNVBaJlYpceWNLV8+RZShYl5jRkGPIpZ3wrXyC90e6q3cfBbApCLD8xR
         dzQm5q9oryu+LxuHRdrpaIB39XMaiCFjwkpVcW281Uy/ThAROD13umvb1Jnm7l8YLSfN
         rHgk8KYPvDa0qblWkMnve7nE3dT1Z/jnfc+wwRu9+NHZ3F9WOLcsvpaxAdM/zS5wZusx
         LD3lXVdctAtNQSOZeft4XSH5UV20KhdAFonyaI5xrb4oZeT1ZEPAQNSMcICp23O6FGhO
         X+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZB9aE3TmuoFmja0UZgEe4Pd4lsy6UpnTCXsS1s9/eg=;
        b=pMc60lgP2mYt3vjx6UI76lJIQFU/2XfLuxR5CxEaYySwZ77lzoXkqxAqYSzL8Wxl3A
         XQgqfjecNlvbmky8kCuQLc2QWKRCpWjxBOYRFhRxytPJyYo6qZ8VmGwwD4UTu20CsHd3
         K8A4RGz4vBfmWESo6utQp91oi08eb+tjjzuDvGNbYK5H8aXnmvmbpOiwWgVHxvh3bWCz
         Q26JEtoV0HaZRlZlgHPoKM/v8ESVNeOZYiOOyOuQzkv28jDw7xg9wQbPAFriQIBcFqUq
         X7N/gh2VxEF09PsMpgPd+xVj6J8Wner255lxR5NT03fg/juFrp5giyJFXQnXalKoD5pv
         1zvA==
X-Gm-Message-State: AOAM530ljHyc6euXzDuD8VQfglvD8O1zD01mSgvNJF8r1xY4VwglSe2g
        gE7p7tcI63UjQDYuCSyJQA3YVQCtCgrZO+Gj9gU=
X-Google-Smtp-Source: ABdhPJzx0oQxJaerRcVE64TNeGX3jlCjm7sJysaNibZKyh54X30D2/OpThkoqLpXiWUyWz0NTcK11Bp0kRqp36tVPFc=
X-Received: by 2002:ac2:4d91:: with SMTP id g17mr1461389lfe.254.1607890471584;
 Sun, 13 Dec 2020 12:14:31 -0800 (PST)
MIME-Version: 1.0
References: <CANk7y0gAChikUBf-ap328YNQd4nrw63BiFH9dRLLDuZ0SnneMA@mail.gmail.com>
 <CA+U=Dsr=SCdSsbsbdY++NwD4xQjr6PZuoOqa_Ctq6ig+GuvO=w@mail.gmail.com>
 <dd7f7015-aed4-8628-0f23-e144fdacc9e7@roeck-us.net> <20201213151253.059e541c@archlinux>
 <729575c9-317c-a2ae-9ded-8732f3cc481d@roeck-us.net> <20201213165003.5b7c1896@archlinux>
In-Reply-To: <20201213165003.5b7c1896@archlinux>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Mon, 14 Dec 2020 01:44:20 +0530
Message-ID: <CANk7y0j1ujTDrxTKurs7EtRCmuP8s1V4Ueg6sDWzRbeP0zjvKA@mail.gmail.com>
Subject: Re: IIO Driver for TMP117 Temperature sensor
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Dec 13, 2020 at 10:20 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sun, 13 Dec 2020 08:08:26 -0800
> Guenter Roeck <linux@roeck-us.net> wrote:
>
> > On 12/13/20 7:12 AM, Jonathan Cameron wrote:
> > > On Wed, 9 Dec 2020 11:48:40 -0800
> > > Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > >> On 12/9/20 12:11 AM, Alexandru Ardelean wrote:
> > >>> On Tue, Dec 8, 2020 at 6:10 PM Puranjay Mohan <puranjay12@gmail.com> wrote:
> > >>>>
> > >>>> I have this TI's TMP117 sensor with me and I was thinking about writing an
> > >>>> IIO driver for it as a hobby project. Is the IIO subsystem the correct
> > >>>> place for this driver? if yes, can someone help me get started with this,
> > >>>> I haven't written an IIO driver before. I have this sensor and also a
> > >>>> raspberry pi with me for testing.
> > >>>
> > >>> This could also fit into drivers/hwmon.
> > >>> Looking at the HWMON subsystem there are more TMP drivers there
> > >>> (TMP102/103/108/401/513).
> > >>> The first 3 seem a bit more similar to TMP117 (in terms of register map).
> > >>>
> > >>
> > >> It would probably be better suited for hwmon (it has limit registers,
> > >> suggesting a common use as hardware monitoring device).
> > > It is a curious part.  I suspect TI based their design for a medical grade
> > > digital thermometer chip on an existing hwmon part.
> > >
> > > The limit registers are very simple so could be supported by IIO.
> > > This sits somewhere in the middle of high end thermocouple chips which
> > > tend to be in IIO and typically lower accuracy / range hwmon parts.
> > >
> > > It's in the fuzzy borderline region so I doubt anyone would raise strong
> > > objections to which subsystem it was in.  Guenter has fallen on the
> > > hwmon side of things and I'm fine with that.
> > >
> >
> > On the other side, it turns out that there is already tmp107 support
> > in iio, and tmp107 is pretty much the spi equivalent of the same chip.
> > So it really depends on the use case. If the user wants to use the iio
> > subsystem, I am fine with it. We just need to remind people that this
> > implies no or only limited hwmon support.
> >
> > [ I really need to spend the time to write a hwmon->iio bridge.
> >   The iio->hwmon bridge is a bit limited - I have not been able to
> >   figure out how to support limit registers (or event values)
> >   and events, and I don't think it is possible. ]
>
> So far IIO doesn't have an in kernel consumer interface for
> events. It shouldn't be that hard to add one though and it
> has been on the todo list for a very long time.  We've discussed
> it a few times and concluded that there are some short cuts such
> as sending all events to all consumers and relying on the receiver
> to do any necessary filtering. It's a bit messy but it makes for
> much simpler core code.
>
> Maybe I'll get bored enough over xmas to look at it...
>

Hi Jonathan,
Where can I access this TODO list, I would like to do some tasks on it.
I am a novice but I might be able to solve the easier tasks.

> Jonathan
>
> >
> > Guenter
> >
> > > Jonathan
> > >
> > >>
> > >>> Let's see what others have to add.
> > >>> But, all-in-all whatever driver you end up writing, the easiest method
> > >>> is to copy an existing similar driver and extend it.
> > >>> Sometimes, a part can be added to an existing driver.
> > >>> At a quick scan through existing drivers, it doesn't look like TMP117
> > >>> is similar to existing drivers, so it may require a new driver
> > >>> altogether.
> > >>
> > >> I don't see an immediate match either, but the tmp102 hwmon driver
> > >> might be a good start.
> > >>
> > >> Guenter
> > >>
> > >>> I may have missed something though.
> > >>>
> > >>> Thanks
> > >>> Alex
> > >>>
> > >>>>
> > >>>> --
> > >>>> Thanks and Regards
> > >>>>
> > >>>> Yours Truly,
> > >>>>
> > >>>> Puranjay Mohan
> > >>
> > >
> >
>


-- 
Thanks and Regards

Yours Truly,

Puranjay Mohan
