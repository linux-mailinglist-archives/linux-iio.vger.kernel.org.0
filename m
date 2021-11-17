Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92066454BA4
	for <lists+linux-iio@lfdr.de>; Wed, 17 Nov 2021 18:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237339AbhKQRM0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Nov 2021 12:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbhKQRMX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Nov 2021 12:12:23 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEF0C061570;
        Wed, 17 Nov 2021 09:09:24 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id e3so14265987edu.4;
        Wed, 17 Nov 2021 09:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EG8fXz3z1cRFlDyXfb7JPvHRIm8+eVLHDTWBrdIanJI=;
        b=PNIjhyzBmmFBgtFF+rNb0BH8KKvDZrRuyTeF2SJMEQQ2E/E2SZbAPk2m++HS8TGsEq
         dYf0GSg2Uh0E5N/M5STTnaUmM3g/oZEAmZAaAaDcn1vrh9IYZvVS4mJjjZ9GAPTL6UVy
         avdFq2tK+8zUUsPavPdyZBCi+fgsr3loWyqsBVnUN1EX0t8knSn6GsCKceFb0mcrYyGE
         HP+bMv7XOb4pZ0NmV4PzOCxg/mG9HZ2nLrAIzpc0+6GlJXEJvc/bCJVObM8j52zKaPmx
         UhOpGoNFKv9sZlCas+BYcyO0qOdiKVcO3GiDgNS0YnK1OD8qZhhZVtGfu2OIm82P042I
         JrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EG8fXz3z1cRFlDyXfb7JPvHRIm8+eVLHDTWBrdIanJI=;
        b=64rBG2B+9WkC0f80N5/18oReT+LcHdQb9ifKsCA+JGyXgo7vTcV6ouri+9VcN5ZkSu
         Dmz2+sKpI5DJ1sRpvO060clkGgCMyW9mizs6Ly69P7ZPv5OgpAT5J+/xKrk4JFfvuEJM
         NfkoOmEk17ncVKn7bYuBBWHyUv99Lwbsbf6M7Q5qNHbTih9Xu6EySRNveR4B/BLKGfV7
         y/SMRvt1mO66i0T1H0n4db4Uocgoaw2sL9LbLOTo7KmQLBrBSlx6l6ptUEAumU7NXVsh
         do5aSK182yuz8CGBnAXyPJfvJTuQ3VLrtFZX/RW12gn7wRAB7otA+D5Dtx53ClKv4+d+
         pZhQ==
X-Gm-Message-State: AOAM532Jtql6FxqdJXtvZgXD2/W8SIL8MsGhe6mleTQZPwt3G3ye25c/
        xPyRHlGJR5luYSozFDQWVcM1wJozygPysyFd3h/z8lXMzZtusoXT
X-Google-Smtp-Source: ABdhPJwf0QrTgd26vQ6tCZzttQ0i7zjSqR3C36mIzEOjyH28+KMXzGZSdeYBjZ4EyeLlUdSFjRosKKtZgsXJ+TZ94/U=
X-Received: by 2002:a17:906:6a0a:: with SMTP id qw10mr24775789ejc.141.1637168963401;
 Wed, 17 Nov 2021 09:09:23 -0800 (PST)
MIME-Version: 1.0
References: <20211116150842.1051-1-anand.ashok.dumbre@xilinx.com>
 <20211116150842.1051-6-anand.ashok.dumbre@xilinx.com> <YZPtW5igA8RBYLWv@smile.fi.intel.com>
 <BY5PR02MB69168A6537474DF8948C3D0BA99A9@BY5PR02MB6916.namprd02.prod.outlook.com>
 <CAHp75VdaO4+DxMn2eJx7t0_UFgrHGV2vgzXvRB=qwZi-ZpMaOA@mail.gmail.com> <cf7ad8715a02f3a0e4fe0cd8a270585dcf84bb3a.camel@perches.com>
In-Reply-To: <cf7ad8715a02f3a0e4fe0cd8a270585dcf84bb3a.camel@perches.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 17 Nov 2021 19:08:41 +0200
Message-ID: <CAHp75VfJBwCcFwbv6fgvwf=Q1UdFXwgNex-4GqKLcf=ZhuqGjw@mail.gmail.com>
Subject: Re: [PATCH v9 5/5] MAINTAINERS: Add maintainer for xilinx-ams
To:     Joe Perches <joe@perches.com>
Cc:     Anand Ashok Dumbre <ANANDASH@xilinx.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        git <git@xilinx.com>, Michal Simek <michals@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Nov 17, 2021 at 6:05 PM Joe Perches <joe@perches.com> wrote:
> On Wed, 2021-11-17 at 17:17 +0200, Andy Shevchenko wrote:
> > On Wed, Nov 17, 2021 at 5:00 PM Anand Ashok Dumbre <ANANDASH@xilinx.com> wrote:
> > > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > Sent: Tuesday 16 November 2021 5:42 PM
> > > > On Tue, Nov 16, 2021 at 03:08:42PM +0000, Anand Ashok Dumbre wrote:

...

> > > > Have you run checkpatch?
> > >
> > > Yes I did.
> > > I don't see any error on this.
> >
> > Hmm... Perhaps it needs an unobvious parameter?
> > Joe, X is definitely after M, any idea why checkpatch hasn't caught this up?
>
> This is the suggested patch below right?

Correct.

> https://lore.kernel.org/lkml/20211116150842.1051-6-anand.ashok.dumbre@xilinx.com/
>
> It looks OK to me.

How come? See below.

> What do you think checkpatch is supposed to find?

XILINX AXI ETHERNET DRIVER
M:      Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
S:      Maintained
F:      drivers/net/ethernet/xilinx/xilinx_axienet*

--> patch adds XILINX AMS DRIVER here !!!

XILINX CAN DRIVER

To me AMS should precede AXI and not the other way around. Agree?

> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20640,6 +20640,13 @@ M:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
>  S:     Maintained
>  F:     drivers/net/ethernet/xilinx/xilinx_axienet*
>
> +XILINX AMS DRIVER
> +M:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> +L:     linux-iio@vger.kernel.org
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> +F:     drivers/iio/adc/xilinx-ams.c
> +
>  XILINX CAN DRIVER
>  M:     Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
>  R:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> --
> 2.17.1
>
>
>


-- 
With Best Regards,
Andy Shevchenko
