Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66E138D6C4
	for <lists+linux-iio@lfdr.de>; Sat, 22 May 2021 20:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhEVSEo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 May 2021 14:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbhEVSEo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 May 2021 14:04:44 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F89DC061574
        for <linux-iio@vger.kernel.org>; Sat, 22 May 2021 11:03:19 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id e17so6792086pfl.5
        for <linux-iio@vger.kernel.org>; Sat, 22 May 2021 11:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kgByPaKMRlbcsDoWOQvJ40jszq+jqFURhAL/dvpTFDI=;
        b=muQq2swWToOetBfoBOYs1Mg8IYHvDznj2Jhoo8O9OU/LiJPmSmfac3lYdZqP+s7qSb
         TiB0dQLXmwOnWW5us5j8zEXY7Pt1CVWoYQrUzkR5PxQpxMUCkdABZfsUDlLgK0JxWUh+
         LgogKyArKWvUKf4iqV3/RaWNEt4MwUlDAHOg2Aglnam4mZOM1u+5rXiHq32mWLxjWtuX
         S2Kr6gSkjwIKVy4tH856Q+H3CPLnB4QA5AkNVObSLFwzHwvv5z4jU1GwMGpB7sMTrW9H
         O44h2flPw1iBXpT6Pn2TLuA/NAiGYDN8ZP06ovw10EB53Ydxvb/mTy7JR3TD2F0eAUkw
         neTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kgByPaKMRlbcsDoWOQvJ40jszq+jqFURhAL/dvpTFDI=;
        b=s7G27siJOjnMEirXcwbEruvLIgjTTX/xqaw5B2RocmxV47tVe8t//D+vKTFwfgJ9KU
         41SyO6UGOH44VdzOSvXIJF4NG4lqpceWO3kWoqpIEACWTbbHOKrpaAuyvaAYITUnd8Vz
         qHea/XLwU0RAVUluiMM1KumXnxJfWiikuW6XnKLRC0Z8BAp1sPGuxTP/WdSK+4Fg1TZg
         hNuS3EGp+bGpLzUpGly5UhccDuDDYNpgRB0lENQ+8EGV/Vu5mcUXnOrdijuzr0KPV15o
         1nGoOw8vesZkL2RFFlzvk/vZOrr1Ytph9cGG56hFYGa7tBUdzEMsyG1zuVd+UlFgO4m4
         QJGg==
X-Gm-Message-State: AOAM530ah81hlb6NiKJgJioc1n5Rg+L7RcxEwS4nAu+an+ZaCZi8aPBA
        HFF3bYgLdIKBIlzWrgMh7BhFLL1iQG0oQXDLf6xLioXBCxJ2Uw==
X-Google-Smtp-Source: ABdhPJwzsYfuD2dQ49rIqZhTOcduPoAw+ran4Gh3eObbejt7z4KWqRGyayVLp46Rm4esYOYdVjEqeqjd8GEo9AAZVP8=
X-Received: by 2002:a63:4145:: with SMTP id o66mr5279957pga.4.1621706598731;
 Sat, 22 May 2021 11:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210521171418.393871-1-hdegoede@redhat.com> <20210522190138.1715b095@jic23-huawei>
In-Reply-To: <20210522190138.1715b095@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 22 May 2021 21:03:02 +0300
Message-ID: <CAHp75Vex3uvGz+g9rkuU3wMwFOui-fASxvcP7b3KNCQ2CrBH3A@mail.gmail.com>
Subject: Re: [PATCH 0/8] iio: accel: bmc150: Add support for yoga's with dual
 accelerometers with an ACPI HID of DUAL250E
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        patches@opensource.cirrus.com,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 22, 2021 at 9:00 PM Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 21 May 2021 19:14:10 +0200
> Hans de Goede <hdegoede@redhat.com> wrote:

> > Some 360 degree hinges (yoga) style 2-in-1 devices use 2 bmc150 accels
> > to allow the OS to determine the angle between the display and the base
> > of the device, so that the OS can determine if the 2-in-1 is in laptop
> > or in tablet-mode.
> >
> > We already support this setup on devices using a single ACPI node
> > with a HID of "BOSC0200" to describe both accelerometers. This patch
> > set extends this support to also support the same setup but then
> > using a HID of "DUAL250E".
> >
> > While testing this I found some crashes on rmmod, patches 1-2
> > fix those patches, patch 3 does some refactoring and patch 4
> > adds support for the "DUAL250E" HID.
> >
> > Unfortunately we need some more special handling though, which the
> > rest of the patches are for.
> >
> > On Windows both accelerometers are read (polled) by a special service
> > and this service calls a DSM (Device Specific Method), which in turn
> > translates the angles to one of laptop/tablet/tent/stand mode and then
> > notifies the EC about the new mode and the EC then enables or disables
> > the builtin keyboard and touchpad based in the mode.
> >
> > When the 2-in-1 is powered-on or resumed folded in tablet mode the
> > EC senses this independent of the DSM by using a HALL effect sensor
> > which senses that the keyboard has been folded away behind the display.
> >
> > At power-on or resume the EC disables the keyboard based on this and
> > the only way to get the keyboard to work after this is to call the
> > DSM to re-enable it (similar to how we also need to call a special
> > DSM in the kxcjk-1013.c accel driver to re-enable the keyboard).
> >
> > Patches 5-7 deal with the DSM mess and patch 8 adds labels to the
> > 2 accelerometers specifying which one is which.
>
> Given only thing I'm planning to do is tweak the line wrapping, I'm
> happy to pick this series up.
>
> The two fixes will slow things down a bit though as we should probably
> get those upstream this cycle.
>
> I'm going to leave this on list for a few days before I take anything
> though, to give others time to take a look.

You are, guys, too fast :-)

I have few (minor) comments on a few patches, in general they are okay!
So, after settling on the comments,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
for the entire series.

Thanks, Hans, for doing this!

> One side note, cc list includes a few random choices... Seems you've
> accidentally included alsa people as well as IIO ones.


-- 
With Best Regards,
Andy Shevchenko
