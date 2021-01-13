Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69EA72F403C
	for <lists+linux-iio@lfdr.de>; Wed, 13 Jan 2021 01:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392416AbhAMAnP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Jan 2021 19:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392292AbhAMAQI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Jan 2021 19:16:08 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F23C061575
        for <linux-iio@vger.kernel.org>; Tue, 12 Jan 2021 16:15:27 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id y19so625831iov.2
        for <linux-iio@vger.kernel.org>; Tue, 12 Jan 2021 16:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dS4I0Vmta6QahyszLm60tagdPq0B9cCR9FF+/LK5920=;
        b=fZBiSUD6P0LlhEPoP/Y5/GVldq67mfJgZh0eW9r0KdtvBbsEnVvfmRQ+r7aiw9l03a
         r4bUXdADrvZzJdwCAJJlPk+kTbJm+632VSg/OKQrEWSTVhu8gm4Wj88+BnGXUgKoUhBz
         Ns+hylr+C/FphYJTM50PA8Zvh/HQhSGkZj9TE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dS4I0Vmta6QahyszLm60tagdPq0B9cCR9FF+/LK5920=;
        b=sJ4Tquk0N2ya6LU9v1oG7A/ZEo2AF4Wce/83STD4HvfmKbzqLonoE+k7zAJFq4K4Gi
         QqJ+epY+jAFVJFG/XBhjPv2PyIU+9om+j6OWJrXpvFrVayLqXruS07vbHh+RjmEEP3rS
         +5Tj8DnfD/wsxt/rkT9939ruSN97FB+kzu+f3n05ksY/WpDF2k7dxFe9Qn6nBiBG/fqL
         UF1SiX+1mVXQChP8bPpa1w+ivObYPv8hAfU93/U/SZJM9ZUUSJMP/Z/qNAkP9O59rduM
         Fk41rDexqtw1tyrHd1DBVa60LWApaOCkdP396o2bW3iku75faACe8ZRtJdwiTBYnnuRy
         aP0Q==
X-Gm-Message-State: AOAM530n5P4YqMC4bFPccFCCZTfJNHInrdRLHVtJLGJ4MoiLA5Ur9wC1
        7DRF7dvaBDSMJLgl/cqj4XbilJWoVKKcWGBCQzxpGpPSGAA=
X-Google-Smtp-Source: ABdhPJxbBmSKGXFXBAkU01Ejd/kvCcuZk1UE8iTyYKj97xPFOZH+rEofmsZgCMlianst7NkmXJj40FY7YVR8qrzX/7A=
X-Received: by 2002:a6b:7501:: with SMTP id l1mr1366061ioh.92.1610496927312;
 Tue, 12 Jan 2021 16:15:27 -0800 (PST)
MIME-Version: 1.0
References: <20210112040923.2613711-1-gwendal@chromium.org> <CAHp75Vda3htVLApWwqoKb8uyoJaQWdOL2JK4kzMn_OH4OHa4Lg@mail.gmail.com>
In-Reply-To: <CAHp75Vda3htVLApWwqoKb8uyoJaQWdOL2JK4kzMn_OH4OHa4Lg@mail.gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Tue, 12 Jan 2021 16:15:15 -0800
Message-ID: <CAPUE2usVJU98D50enyf5+L3OdXcjzFnLdYt82g=AHCfeqgOyCA@mail.gmail.com>
Subject: Re: [PATCH v5] iio: hrtimer: Allow sub Hz granularity
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jan 12, 2021 at 6:22 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Jan 12, 2021 at 6:09 AM Gwendal Grignou <gwendal@chromium.org> wrote:
> >
> > Allow setting frequency below 1Hz or sub 1Hz precision.
> > Useful for slow sensors like ALS.
> >
> > Test frequency is set properly:
> > modprobe iio-trig-hrtimer && \
> > mkdir /sys/kernel/config/iio/triggers/hrtimer/t1 && \
>
> This && seems strange...
>
> > cd /sys/bus/iio/devices/triggerX ;
This is just for testing. X in triggerX should be replaced with the
newly created trigger.
>
> ...because if the above fails, the below becomes a total train wreck.
>
> > for i in 1 .1 .01 .001 ; do
> >   echo $i > sampling_frequency
> >   cat sampling_frequency
> > done
>
> Something like this perhaps (note {} and also I dropped unneeded ; and
> whitespace)
>   modprobe iio-trig-hrtimer && \
>   mkdir /sys/kernel/config/iio/triggers/hrtimer/t1 && { \
>     cd /sys/bus/iio/devices/triggerX
>     for i in 1 .1 .01 .001; do
>       echo $i > sampling_frequency
>       cat sampling_frequency
>     done
>   }
>
> ...
>
> > +       if (!val || val > NSEC_PER_SEC * 1000)
> >                 return -EINVAL;
>
> > +       info->period = NSEC_PER_SEC * 1000;
>
> I didn't get these * 1000 parts, why not define and use PSEC_PER_SEC?
Indeed only Nano and Femto SEC_PER_SEC are defined.

>
> I'll send a patch soon. You may include it in your series as prerequisite.
Thanks,

Gwendal.
>
> --
> With Best Regards,
> Andy Shevchenko
