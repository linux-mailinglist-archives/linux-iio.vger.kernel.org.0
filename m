Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D60D2C3EED
	for <lists+linux-iio@lfdr.de>; Wed, 25 Nov 2020 12:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgKYLTd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Nov 2020 06:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgKYLTc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Nov 2020 06:19:32 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5D7C0613D4
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2020 03:19:32 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id k5so955892plt.6
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2020 03:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6PnGbqJc1R0ILZKw9tXrJf+3v8FDjiKiyzzyV9c+uCM=;
        b=YwGQ94v7yg7wOG9YbEazWs0dtIvF2NrEIVvSzCmIdBROlnKvtAGA6PcD1JN1qB5MsV
         1S9NV1kt0rl1S433gWbngbkchfTkVEGsdiAfiolCQNGQ5OisliriwhFW2hFLZLxyoaD0
         hEZw3PxRSzJmuzy0AItF+fBdSObo1xmMoe5xe5BPMoi7VovrtBcJmFhD78Z/CDTalbSJ
         vm5w34lUDnB8lsoe6+VqMOCL8A2puVL0wctRfYONDrVaJd7yKT0VP1gYOdByypc+/jQd
         3/SJWclysF+cD2MxrP9oUD57MeHm4DswgFcRiHjUJXJu3hop91tBz34kIBCYt3xfbNOp
         59hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6PnGbqJc1R0ILZKw9tXrJf+3v8FDjiKiyzzyV9c+uCM=;
        b=l+9pRMwMq6q1bkKVpUMXWJnyTRTlsxryjnw5gBW1N7t34P8pIMsH3mZApsaTJmEg+a
         odTGUp5eCF5DZMRfNg6gx44VY1DQUW6vQYQdz30ACqPvZ9xseQPJTMYu6O36h7LB3S9D
         jvnTTcLv535EECXdLdZbSOdfpyuCdA2H7kD4C4WzuXe20Wl+HwRZekjbucktqhfJEa6h
         R/gNScQKRONbsKzXr/nwDQCqotYT7tyg+gCRCEMaCZe+ItOYhiZYcffGIB+wCtev/V/K
         TQXpMMAZyG2cttYdTw1qUsdGDZFTVWHjc+QT2N+84B1DUMCE8hVGlmR+tYLcTV05bDWw
         Ev1A==
X-Gm-Message-State: AOAM530KPPRf67dfJ9MyhiEeD3tyDsjJjCfNfqqwU4PSQL3CaliQWoj1
        RBXDQUanHgJI4IxSl72RJcQ0RcNgDZ5WLQ32AVg=
X-Google-Smtp-Source: ABdhPJzdDGQcJU6WTMwiTBRp+5T5vg1QyJQFt05d3AFyk8IHVto61a6u2Ad5sT34uK+v6UebSEneIMUP3SqG5uwB/Sc=
X-Received: by 2002:a17:902:ac93:b029:d8:d2c5:e5b1 with SMTP id
 h19-20020a170902ac93b02900d8d2c5e5b1mr2608042plr.17.1606303172275; Wed, 25
 Nov 2020 03:19:32 -0800 (PST)
MIME-Version: 1.0
References: <20201125083618.10989-1-hdegoede@redhat.com> <20201125083618.10989-3-hdegoede@redhat.com>
 <CAHp75VcZQ1duxHnUTD9ewRhWxoHay8S6AQaEK3v3jJr+oQcbDw@mail.gmail.com> <ee0d26b1-ee54-0c2c-cd9f-40366e3b10d4@redhat.com>
In-Reply-To: <ee0d26b1-ee54-0c2c-cd9f-40366e3b10d4@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 25 Nov 2020 13:20:21 +0200
Message-ID: <CAHp75Vc7v4z=VkaopsfXoJfFMxt9GxS6iofjNvOcUQrauKhDXA@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: accel: bmc150: Check for a second ACPI device
 for BOSC0200
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Nov 25, 2020 at 1:11 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 11/25/20 11:55 AM, Andy Shevchenko wrote:
> > On Wed, Nov 25, 2020 at 10:37 AM Hans de Goede <hdegoede@redhat.com> wrote:

...

> > I'm wondering if we can meanwhile update hwdb to support
> > i2c-multi-instantiate cases in the future and in a few years switch to
> > it.
>
> Even if we fix current hwdb entries to match on both, then there
> is no guarantee newly added entries will also contain the new match.
>
> Now with the code to get the matrix from the ACPI tables new entries
> should happen less often, but I saw at least one model where the ACPI
> provided matrix appears to be wrong (if the ACPI matrix was always
> correct then breaking hwdb would not really be an issue).
>
> So I don't think this is going to work and all in all it feels like
> a lot of work for little gain.

Okay!

...

> >> +                       .dev_name = "BOSC0200:base",
> >
> > Hmm... Can we use '.' (dot) rather than ':' (colon) to avoid confusion
> > with ACPI device naming schema? (Or was it on purpose?)
>
> So with the ':' the end result is:
>
> [root@localhost ~]# cd /sys/bus/i2c/devices/
> [root@localhost devices]# ls | cat
> 6-0050
> i2c-0
> i2c-1
> i2c-2
> i2c-3
> i2c-4
> i2c-5
> i2c-6
> i2c-BOSC0200:00
> i2c-BOSC0200:base
> i2c-WCOM50BD:00
>
> Which looks nice and consistent, which is why I went with the ':'
> and since base is not a number, there is no chance on conflicting with
> ACPI device names (it does look somewhat like an ACPI device name, but
> it is an ACPI enumerated device, so ...).

I see. So this was made on purpose.

> Anyways if there is a strong preference for changing this to a '.'
> I would be happy to make this change.

No strong preferences from my side.

> > And this seems to be the only device in the system, second as this is
> > not allowed as far as I understand. Right?
>
> I don't understand what you are trying to say here, sorry.
>
> > But theoretically I can
> > create an ACPI SSDT with quite similar excerpt and sensor and
> > enumerate it via ConfigFS (I understand that is quite unlikely).

What if you have two devices with the same ID and both have two
I2cSerialBusV2() resources? Second one can't be instantiated because
'base' is already here.
Making it like i2c-BOSC0200:00.base would be much better in my opinion.

-- 
With Best Regards,
Andy Shevchenko
