Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC4F4549C3
	for <lists+linux-iio@lfdr.de>; Wed, 17 Nov 2021 16:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhKQPVJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Nov 2021 10:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbhKQPVJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Nov 2021 10:21:09 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F479C061764;
        Wed, 17 Nov 2021 07:18:10 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id e3so12752037edu.4;
        Wed, 17 Nov 2021 07:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5b1ArDlfRpWUYORBp6mYD8zbRzEon0uoWQaodJhZwNk=;
        b=MfaVlhQjC9PO09u2u7ItaF6y7A83+pOX/2MQzK6+blwt6zezPz20GTTgWJZa9R1LPJ
         uhABCkeFaTySkNKDEeKD0A5KbbvwY80xHw0BMj0Y6xi0+T7k3hfjrz6q1yyGX7h0asv8
         vSf87Jk3tMhMoq32iBlMy7Za1I2j/AbGxv6fMa2gXiD5EQQo3mPIzMN4dthqWM89/eIx
         8gcNIefuw7VP8Fw9/xj/WSWgiMCLxROKLICIBU7Abvfkbg4yDNA7SqNW162ECLC7EM8x
         4xXxxI/uibn4iMwIW5WL5eawsgclDnQ1IUY9TPDAa1VchGiln/xDy2xDNNLFhH7rNxhZ
         XBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5b1ArDlfRpWUYORBp6mYD8zbRzEon0uoWQaodJhZwNk=;
        b=o51wEKKbhx3i42UyijvpJ7xbEnH1okZwDOuB6lTFXxxRHYO/+4rvvIO/l0JC3GCyI9
         IOq3nQyr/WwfUmfF3ujSpDpvrzeaihn+iRtsec1oDg4Z6X74/TRfau33iBsW/S8yNc2v
         ZZwazXFagIeA6jdjMvmfJxEvQCtlnU+DtwAhsKHH+vMrX2TTc+Ey98UgAxRLtQn++aZM
         Yaw7FpndpOwZARYtlZxGzw0jWdUVZ70niVoWTovEQnVhU7jXIL+Vf531cCjWOGuDKmMp
         WujTuxrUnJiTSAGDzazWwJc/pQksUe7TnWh4q8u9jc+mZdf6N5cma/YdR/7h0hyxqvQA
         /iXw==
X-Gm-Message-State: AOAM533+qBKKdTsnUi5MXdlRHwHlYgQUv5hOgzfJQrUnYBZPxLhG1+kN
        kGq7aXxS7cvamK6uEg6CZ8txd21lfJGx/aBiRPU=
X-Google-Smtp-Source: ABdhPJxJH/O8kiyGhcKjVIHY/SHj73yt3zclF7y+pZOCKVew4WTgYCKXC67lXUlbd1Utw5bJqcwm7qk3CRjWNxZV/7M=
X-Received: by 2002:a17:906:489b:: with SMTP id v27mr22321628ejq.567.1637162289058;
 Wed, 17 Nov 2021 07:18:09 -0800 (PST)
MIME-Version: 1.0
References: <20211116150842.1051-1-anand.ashok.dumbre@xilinx.com>
 <20211116150842.1051-6-anand.ashok.dumbre@xilinx.com> <YZPtW5igA8RBYLWv@smile.fi.intel.com>
 <BY5PR02MB69168A6537474DF8948C3D0BA99A9@BY5PR02MB6916.namprd02.prod.outlook.com>
In-Reply-To: <BY5PR02MB69168A6537474DF8948C3D0BA99A9@BY5PR02MB6916.namprd02.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 17 Nov 2021 17:17:28 +0200
Message-ID: <CAHp75VdaO4+DxMn2eJx7t0_UFgrHGV2vgzXvRB=qwZi-ZpMaOA@mail.gmail.com>
Subject: Re: [PATCH v9 5/5] MAINTAINERS: Add maintainer for xilinx-ams
To:     Anand Ashok Dumbre <ANANDASH@xilinx.com>,
        Joe Perches <joe@perches.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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

On Wed, Nov 17, 2021 at 5:00 PM Anand Ashok Dumbre <ANANDASH@xilinx.com> wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Tuesday 16 November 2021 5:42 PM
> > On Tue, Nov 16, 2021 at 03:08:42PM +0000, Anand Ashok Dumbre wrote:
> > > Add maintaner entry for xilinx-ams driver.
> >
> > Have you run checkpatch?
>
> Yes I did.
> I don't see any error on this.

Hmm... Perhaps it needs an unobvious parameter?
Joe, X is definitely after M, any idea why checkpatch hasn't caught this up?

> > >  S: Maintained
> > >  F: drivers/net/ethernet/xilinx/xilinx_axienet*
> >
> > X...
> >
> >
> > > +XILINX AMS DRIVER
> >
> > M...
> >
> > > +M: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> > > +L: linux-iio@vger.kernel.org
> > > +S: Maintained
> > > +F: Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> > > +F: drivers/iio/adc/xilinx-ams.c

-- 
With Best Regards,
Andy Shevchenko
