Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D406F49FDC1
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jan 2022 17:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbiA1QPC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Jan 2022 11:15:02 -0500
Received: from mail-ua1-f52.google.com ([209.85.222.52]:46913 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbiA1QPC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Jan 2022 11:15:02 -0500
Received: by mail-ua1-f52.google.com with SMTP id c36so7842611uae.13;
        Fri, 28 Jan 2022 08:15:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6xpYGVcpStWXVZD8NX6CXca3wP3nNUgixB30d/cjdB4=;
        b=5vNcjQLzJ3g2AJfWbOWJHqlsbm1mJTlaQmy3rMa6MdhtZEe3Vx5bJamb372bIHLJRJ
         F+cGPJKSHrE1qjChIMleNzDM8Z9IXGMGSjGnKuyZiSRISfqa27aFh9xGBoHPwjNfrV9V
         EWVHDExBieZXTbWrMWQPHOWmNE8wtNugScPziOCpBX1yXSUD/+crWIQS8Xc+pnf+U68Y
         BokZxJy97e0ha+STTna3KsTxaFq1Xk5TfR/I5KxBcaJse7NOX+tMZsyDuFRAqH8HWBmw
         pGgjEpDKMQAlag8ifKYTluXbfNNMHIJsY2Duo79BtTtmpxjtjfiE2wdge1wiqesGfH9j
         DqtA==
X-Gm-Message-State: AOAM531KKRRnEtTbAWG3kN3AbagXvFSkR43ApayAftcBjD7Z6/sCwipM
        OFl+ADuoCuGWV7Q1Hb9BdnwE2TBHBekUUg==
X-Google-Smtp-Source: ABdhPJxADLEyY82yun7XnfLrVqlACgJdzqtPDiszvId6CTrK4oMF3dQVkbd+Tf81PiswNiYusf1Hug==
X-Received: by 2002:ab0:778c:: with SMTP id x12mr4230037uar.33.1643386501600;
        Fri, 28 Jan 2022 08:15:01 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id n123sm1563204vkn.10.2022.01.28.08.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 08:15:01 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id t20so3614656vsq.12;
        Fri, 28 Jan 2022 08:15:00 -0800 (PST)
X-Received: by 2002:a67:5f83:: with SMTP id t125mr3985540vsb.68.1643386500786;
 Fri, 28 Jan 2022 08:15:00 -0800 (PST)
MIME-Version: 1.0
References: <20210412122331.1631643-1-linus.walleij@linaro.org>
 <CAMuHMdUYOxKECcF+aM3+pTpgp-412YbL5vMDZpmEqJmLigpdVw@mail.gmail.com>
 <CACRpkdbrX-JiPJh2pnVPt39mNgNNrAFkOfS8Q9kO002+oVagyg@mail.gmail.com> <CACRpkdYGYQNQ27DD5HaUt8ERgoiNjxGE95W8EHbZRFNaXsH8VQ@mail.gmail.com>
In-Reply-To: <CACRpkdYGYQNQ27DD5HaUt8ERgoiNjxGE95W8EHbZRFNaXsH8VQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 28 Jan 2022 17:14:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV1-WV0c=tnjPgw70tQHYc-GEVs_OPidXmD-LbedLQacw@mail.gmail.com>
Message-ID: <CAMuHMdV1-WV0c=tnjPgw70tQHYc-GEVs_OPidXmD-LbedLQacw@mail.gmail.com>
Subject: Re: [PATCH] iio: st-sensors: Update ST Sensor bindings
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Linus,

On Fri, Jan 28, 2022 at 4:57 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Jan 28, 2022 at 4:51 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Wed, Jan 26, 2022 at 3:59 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Mon, Apr 12, 2021 at 2:24 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > > >    interrupts:
> > > > +    description: interrupt line(s) connected to the DRDY line(s) and/or the
> > > > +      Intertial interrupt lines INT1 and INT2 if these exist. This means up to
> > > > +      three interrupts, and the DRDY must be the first one if it exists on
> > >
> > > So this says three (the LSM9DS0 datasheet agrees)...
> > >
> > > > +      the package. The trigger edge of the interrupts is sometimes software
> > > > +      configurable in the hardware so the operating system should parse this
> > > > +      flag and set up the trigger edge as indicated in the device tree.
> > > >      minItems: 1
> > > > +    maxItems: 2
> > >
> > > ... while this says two?
> >
> > Looks like a bug, could you send a patch? (I'm a bit preoccupied right now.)
>
> Oh wait a minute, LSM9DS0 is one of those with more than one component
> inside it isn't it?

Yes it is. And thus it needs 2 device nodes in DT.

> While it is a bit awkward, we do bindings per-subcomponent on these, so
> for example lsm330dlc registers as "st,lsm330dlc-accel" and "st,lsm330dlc-gyro"
> and it makes a bit of sense because they each have different I2C addresses
> as well.
>
> I see it as two components just sharing a physical package rather than one
> component in a package.
>
> So the IRQs are per-subcomponent, not for the entire package.

OK, that makes sense.

> Does this influence the situation you have with LSM9DS0?

Yes, it does. Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
