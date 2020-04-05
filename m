Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3BD19EA71
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 12:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgDEKis (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 06:38:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42447 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbgDEKis (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Apr 2020 06:38:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id g6so4108814pgs.9;
        Sun, 05 Apr 2020 03:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qdLT95uUUHQQjan6IE7MImhuwtChu6BiQ6bgREKm7VM=;
        b=MXLhu3KBzqbM7vGo8jZvb7194ZggQq+Rej3BI7Vu8KoJUXc36JHdoH3rU0SK24Q/N9
         IdzsJGJ4LCDiyF0OfwAezRI30kFwJ08BUB8yJsFZz9EwPYD6JoiiLKBM3E/4qIv6HT6S
         grhT/7ubthWiKfmBX95cGAsY3jVuTaLkP7V3ZpJZM54+jZoxtKhHCFfzK8z8BTdZTiTe
         707weLjiVp+vnaIEsJClyv1vSvUL4YpocdJsP63n88sdSPK3CubOfMyw7LXqaL6d/FmG
         UsOKCY6yzhfebMpt5GNWTIDIKfVf/GYUiUki1nEMB3eZSMH57CXpOlMaE/eArrZYhYl0
         8EdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qdLT95uUUHQQjan6IE7MImhuwtChu6BiQ6bgREKm7VM=;
        b=ea0rNsaS8lE7K7f7u2XIzSwquQfvX7wU8WL2cO/THBuAfWlL4ziZJ3EYhqrCwu483q
         bsAZkbOdzHVK7EsHIFibtwrtlNjsqwhlTMpNzmnMAmHEVVe32zxEvombij0H4grGEf3G
         7N/hFGtpHjEKSWwE++NJZlu0ltUniUtHs8iJU0L0igUjhKsEAvJUTyv2zlcwqDg+yHqN
         EWPpvJNCCnCIayLhJjzYURCKGz8P4fbhjA7NQwuU/quaUERCOYTWAE+GQodBNAiykxyd
         P4Xvbau7cr0L7gmYEIqkcUhEnwYWzX9bydpJDZLZle7V5iu8trORoB+A2Rhzbluwncc+
         HZKg==
X-Gm-Message-State: AGi0Pua3Czw9nTzOTS5TL6WuSJBls9blWA+JhMjnEVlE4cDdW2/kBljf
        /DXEvXF5E0gDbwra2r2qDqnfsvLivi4anzERGacf8ZP01LM=
X-Google-Smtp-Source: APiQypIdZjZrO4aeX+/9G7UXEKP7hP1w5JadaMQbG06oUiIQ8NjExQZ7der4QrwRDuenrob6GM+iG+QvYzm3UfSS+fE=
X-Received: by 2002:a63:1c1:: with SMTP id 184mr17155666pgb.203.1586083127176;
 Sun, 05 Apr 2020 03:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200401162416.24474-1-i.mikhaylov@yadro.com> <20200401162416.24474-3-i.mikhaylov@yadro.com>
 <CAHp75VcdDR-owtFuFMqNLFh_-L902fXODG14_6Dh416tTwjidA@mail.gmail.com>
 <1e2c9b590a3626abee330a28cca86cbae7affb39.camel@yadro.com>
 <CAHp75VdaM_pumyWyeHJxCQXrKUAW=ktJme1uYxH0w4e9an0X2A@mail.gmail.com> <20200405111341.0912468d@archlinux>
In-Reply-To: <20200405111341.0912468d@archlinux>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 5 Apr 2020 13:38:36 +0300
Message-ID: <CAHp75VeQ7LNve3bUEgzH2YrMwcihSDs+LHB3fgxy=b6pKH4RcA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] iio: proximity: Add driver support for vcnl3020
 proximity sensor
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Apr 5, 2020 at 1:13 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Thu, 2 Apr 2020 15:42:02 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Thu, Apr 2, 2020 at 11:24 AM Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
> > > On Wed, 2020-04-01 at 19:35 +0300, Andy Shevchenko wrote:
> > > > On Wed, Apr 1, 2020 at 7:24 PM Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:

> > > > > +       indio_dev->name = VCNL_DRV_NAME;
> > > >
> > > > It's definitely not a driver name. You have to put part number here.
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iio/light/tsl4531.c?h=v5.6#n199
> That one is actually fine (if not very pretty) because the driver only supports one part and it happens
> to also be the name of the driver.
>
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iio/light/max44009.c?h=v5.6#n507
> Also only one part supported, so fine if liable to accidentally get broken if we support more parts.
>
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iio/light/vl6180.c?h=v5.6#n515
>
> Again, one part supported and the driver has the same name.
>
> >
> > Let's Jonathan speak up.
>
> So, the real point here is not the value being assigned but the fact it's
> explicitly linked to the name of the driver.  I'd argue that you could use
> VCNL_NAME as the define and that link is clearly broken. Or just put the string
> inline in both places and don't worry about the tiny bit of replication!

My comments, except this one, to this version are quite minor, so,
after addressing this in a way Jonathan likes,

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

P.S. Don't forget to include given tags in the commit message of next
(fixed) version.

-- 
With Best Regards,
Andy Shevchenko
