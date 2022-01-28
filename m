Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435C749FD3C
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jan 2022 16:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349725AbiA1P5R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Jan 2022 10:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349743AbiA1P5R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Jan 2022 10:57:17 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0C5C06173B
        for <linux-iio@vger.kernel.org>; Fri, 28 Jan 2022 07:57:16 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id r65so19657527ybc.11
        for <linux-iio@vger.kernel.org>; Fri, 28 Jan 2022 07:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YGNOHfcg1rOKMh16+fBSqtpeDBJsw3Sozhktm0UkkeA=;
        b=TQWk7HVbDe7SRhXENTymRrV1vqaQO3yVZ94ZrJahHtBEPgrxbFOi9hmd5PUDrbZ/Jh
         jVyqw3HLUDPFrtXMG66DF2TdAoJuwRaG/G7YIWXC3Afr9TCcfM+/ctkv3NYXWL0xTZ3y
         rwa4SO+j1wmLFq86GGtt3HwTA+N89ilCHIucxy4pswCSbVLMLWhyNoav8No0wev93zNv
         VzUGem13A6MHaejmtl3enndoVv4Nbd4geFRmlho+oW9/8mUxJAuilUp6g9QbK2x6tCP8
         Daa6rMngMjya/ywfRjwDXx/5ENRVdkyG39H51Wtcyo4o7avKX6H4XR9Fi0sXutkpTqsu
         PJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YGNOHfcg1rOKMh16+fBSqtpeDBJsw3Sozhktm0UkkeA=;
        b=e8hsbZwYOIYjLctpVDzRrt9y6WedQILNUvMcBrQdh6O5dL0o7xz4murKnceDe63FdJ
         c732QAcwZfrSVBuw2zlH543bbAxw3KNdXhJt4XEqQzl7vsDYb00P1IZCfY5822jmGVKr
         CV8NBR6X6Q8rv05Umu0xljCS6yp69JNwrZW9Zj/DeX3jNV4jYg8AkoiBV7lFIR+1b6Bu
         lmiTKGkBDeG+IYiiTlck2ED+AdqFdHD4rs+ZAR1ja7EZfUc8HIjFiw7/PWG3USw4HpEW
         oEk/IxIDzdvW13lictt8HakAlXR5tgsn4rP8LH2w7gzwVU+iJMRW+/9TkbP5nPk02CK+
         2pwA==
X-Gm-Message-State: AOAM532A+o4wZKTQW4Ep4hE10/mYGEh8dCKZF/rwXTG02FBhx9Zo/Isz
        867U6/EJ/DU3qy8V+ChLSvLX7mUoCyIE4M6jOG5tSqbaPIE=
X-Google-Smtp-Source: ABdhPJz1kfLZxX0MXQJzm/n74kcsr2pqNGwFdGrRrm0k4mluBiVXSVU6PP1hnpb4bRJZQoC4/kiZ38ZFWJFQe516J6s=
X-Received: by 2002:a25:8011:: with SMTP id m17mr13340785ybk.284.1643385436001;
 Fri, 28 Jan 2022 07:57:16 -0800 (PST)
MIME-Version: 1.0
References: <20210412122331.1631643-1-linus.walleij@linaro.org>
 <CAMuHMdUYOxKECcF+aM3+pTpgp-412YbL5vMDZpmEqJmLigpdVw@mail.gmail.com> <CACRpkdbrX-JiPJh2pnVPt39mNgNNrAFkOfS8Q9kO002+oVagyg@mail.gmail.com>
In-Reply-To: <CACRpkdbrX-JiPJh2pnVPt39mNgNNrAFkOfS8Q9kO002+oVagyg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Jan 2022 16:57:04 +0100
Message-ID: <CACRpkdYGYQNQ27DD5HaUt8ERgoiNjxGE95W8EHbZRFNaXsH8VQ@mail.gmail.com>
Subject: Re: [PATCH] iio: st-sensors: Update ST Sensor bindings
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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

On Fri, Jan 28, 2022 at 4:51 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Jan 26, 2022 at 3:59 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Mon, Apr 12, 2021 at 2:24 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> > >    interrupts:
> > > +    description: interrupt line(s) connected to the DRDY line(s) and/or the
> > > +      Intertial interrupt lines INT1 and INT2 if these exist. This means up to
> > > +      three interrupts, and the DRDY must be the first one if it exists on
> >
> > So this says three (the LSM9DS0 datasheet agrees)...
> >
> > > +      the package. The trigger edge of the interrupts is sometimes software
> > > +      configurable in the hardware so the operating system should parse this
> > > +      flag and set up the trigger edge as indicated in the device tree.
> > >      minItems: 1
> > > +    maxItems: 2
> >
> > ... while this says two?
>
> Looks like a bug, could you send a patch? (I'm a bit preoccupied right now.)

Oh wait a minute, LSM9DS0 is one of those with more than one component
inside it isn't it?

While it is a bit awkward, we do bindings per-subcomponent on these, so
for example lsm330dlc registers as "st,lsm330dlc-accel" and "st,lsm330dlc-gyro"
and it makes a bit of sense because they each have different I2C addresses
as well.

I see it as two components just sharing a physical package rather than one
component in a package.

So the IRQs are per-subcomponent, not for the entire package.

Does this influence the situation you have with LSM9DS0?

Yours,
Linus Walleij
