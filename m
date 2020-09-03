Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECDC225BE14
	for <lists+linux-iio@lfdr.de>; Thu,  3 Sep 2020 11:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgICJHP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Sep 2020 05:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgICJHN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Sep 2020 05:07:13 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6FCC061244
        for <linux-iio@vger.kernel.org>; Thu,  3 Sep 2020 02:07:13 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e33so1634194pgm.0
        for <linux-iio@vger.kernel.org>; Thu, 03 Sep 2020 02:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KbvOazAUVOa2gnjjoypWoaT5wYesxpXszXuu6OhR1X8=;
        b=VAWFFUwM9gemBwGAvYKpDFMLSv2CLt0eemULOjbDdh+ySHJbeUKtE80NK6hnw77W9e
         gH9Rx4YcDrI5NrKqW50WpMSH+lTIwHRIvNmKnZyAA7Gc2740gd260f3svNWF2th+9LOt
         POa/qBERyTi1haVowl+x+uU/93lDov6DACAIdeDt8a/VTsD8rszQmp0+56L/VAhnj5b4
         63cyG4yiLCAlBsIDD/dXWrqkJH7QkYaP3z/mk6W9uk9uCQ0TDHuT7xBdDbZ4Wdpp89li
         f/BfQiNTI3KvI6EZ1Qg7nH/WHv0xsdYVT3+T34Gh9lAhissKgqNPihRPbnvM/1v5YwPW
         IIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KbvOazAUVOa2gnjjoypWoaT5wYesxpXszXuu6OhR1X8=;
        b=PcXbokrnTF3FSL7yfWY6RKgOLZuFHHt7lF99SKgXwTj6GItKtFUb6MkKlteZyNexe4
         +tOU6N2GZazsHJLlOmb/XZ/IwjqlhaYTX83FIxlNOuxOn0eh2yB7+d1PaSPDv7TwNp4P
         s6JfBKyhgHx74i6fcSV/OEv0KOILpNuAmDUHiGcfg/SYS1UkOGKYVBAqwNt3bzJxbjjL
         gcfxvEY1d7mgqXFeWwd4lc0AnMw8wQv1nI4zZQIl30bZ2WX9HxoH8ikkaN7ygBKYTfZT
         s23gM4FYtQ9hDDL9Mza9JC+tarwN5bGDBF7XPMAQlwjp9aaTZWPBAL7sJdZQufzAtoqo
         580A==
X-Gm-Message-State: AOAM532OWX7DnSIgPJ5TFAAicLoagRKjOlpJGLgTsbsrv+2QN9D2FJH+
        KwUimVMo+o1ZtI+u9ZXD4ZLACKYCFo+ul9syH+Q6KMmx4K0=
X-Google-Smtp-Source: ABdhPJy3CiupFLA/EO/TIr5bZAt5OgV3Y+sithkUUuG0gRP+j2Fryln1yU1qLiCJuR0f+iiwgusXzV+TgKTLsB3RmA8=
X-Received: by 2002:aa7:9781:: with SMTP id o1mr2865427pfp.93.1599124032651;
 Thu, 03 Sep 2020 02:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200831090813.78841-1-andriy.shevchenko@linux.intel.com>
 <20200831102145.0eaebb77@archlinux> <20200831114904.GH1891694@smile.fi.intel.com>
 <20200831151201.076c0f94@archlinux> <20200903092118.00001f79@Huawei.com>
In-Reply-To: <20200903092118.00001f79@Huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 3 Sep 2020 12:06:55 +0300
Message-ID: <CAHp75VdLSKFss+azbJROjNTuWrnXtRK58deJM06gkXDG7+DXJw@mail.gmail.com>
Subject: Re: [PATCH v1 1/8] iio: accel: bma220: Fix returned codes from
 bma220_init(), bma220_deinit()
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 3, 2020 at 11:23 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> On Mon, 31 Aug 2020 15:12:01 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> > On Mon, 31 Aug 2020 14:49:04 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Aug 31, 2020 at 10:21:45AM +0100, Jonathan Cameron wrote:

...

> > > P.S. Consider this series as an example what can be done to many IIO drivers
> > > in order to clean them up. My focus, of course, ACPI interaction:
> > >  - use of ACPI_PTR / ifdeffery
> > >  - inclusion of acpi.h
> > >  - ...

> > Thanks.  This is probably a good one for anyone who wants to grow their
> > experience in kernel patches etc.  I'll add it to my more or less
> > never ending list if not and get to it eventually.
> >
> > In the meantime we'll try to avoid introducing any new variants!

> Andy, one thing that might want adjusting is the docs that suggest
> doing ACPI_PTR and ifdeffery.
>
> https://elixir.bootlin.com/linux/v5.9-rc3/source/Documentation/firmware-guide/acpi/enumeration.rst#L254

I briefly looked at the text and it seems that there is not one
problem (typo, etc) in it. The entire document needs to be revisited.
Unfortunately I have no time right now to do that.
Regarding ACPI_PTR() it looks like case by case, because in the
example you pointed out it's just a style preference (and somebody may
actually want to save few dozen of bytes in their driver to reduce
memory footprint). That said, we rather need to describe both options
and tell the difference.

-- 
With Best Regards,
Andy Shevchenko
