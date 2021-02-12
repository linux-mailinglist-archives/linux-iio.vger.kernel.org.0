Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36579319BD4
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 10:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhBLJYG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 04:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhBLJXj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Feb 2021 04:23:39 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03AAC061786
        for <linux-iio@vger.kernel.org>; Fri, 12 Feb 2021 01:22:58 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id w36so12152202lfu.4
        for <linux-iio@vger.kernel.org>; Fri, 12 Feb 2021 01:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0qh8Pdw9qka2TYE2ZgoHexsZ5dGrw0h903IxKKwLo7w=;
        b=Fa3Fe7P9ew+sbMFs79guYw2cPpaCCLJiiFVkJwqgHaMj0sGMSjLfZutWZ0Ja7Yxnh/
         RBbooQsjB6f9xB8Yih70bYFqnkabOj+9G0uoPD56BJLOVSDna1oJ5+By8wWYHvw5qAL/
         xLsY3HpEcA9pFN+wkH8fwiRqRDBp105I3xgVoSmdVkvgNt7oeqNW+5nCjJhpD1kOK+Iu
         VbN9SWvxE2JI4TJtpIT95Z8weUmBO7xxO3OxFppWrHj7+HkD5ZOe9PjbaQndcdJfojtM
         xZMN5zHu06UGDsL99wop9QduCoau+e0Kz2/6j7w7pAopTWdaWnYE0vKlKcJQT+rpXdVO
         v50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0qh8Pdw9qka2TYE2ZgoHexsZ5dGrw0h903IxKKwLo7w=;
        b=pv4Pr4ZOW9wWwUrN/BE5Wj4+LQ7za1NZfriVl6D2BJWIrOn4kATcpM3b8ArHt01cI8
         eQsg9XormnJjTFribojb3S9Cc5UiK/OLEMy2my10H9MX33XbBukJ0EJnNoU6Q3V3gqJB
         KUb+fi3pjfxBZLzHxy1YOspd4gyF2KZpiE3WO/+JocBVZQ++M5zriZ488NWjl2iDJ/4C
         podlnkqUM7BTdzK6RVuQQ54Za8NwvZ0erKpYUbnZK55MtwDNq+AyTatnECVikUm7/ToS
         ytzppj2ecawEIG2gJGc3PdF1RmbPR3gZKGjI4J+IakSbAk/+OQ7S2oP/46gI+tChKpTY
         hliw==
X-Gm-Message-State: AOAM532XDGTuOdZZfGVZDOt8DtSroVaM5eLuUvHYuYPLyu69y1HbVsyR
        qail+FzpvF3ZewZSnAPjRVsKbMqeFDEcZHLPm4VHSQ==
X-Google-Smtp-Source: ABdhPJxEZTrr/PlUo4553XsMa6M1hrTG1Gm7V/GzNiXVb+ZhQVSiS2yPH7AWx++cfkHS/sPVuQALveIu9hqiYxRXO5I=
X-Received: by 2002:a19:8bc6:: with SMTP id n189mr1061111lfd.291.1613121777318;
 Fri, 12 Feb 2021 01:22:57 -0800 (PST)
MIME-Version: 1.0
References: <20210208135347.18494-1-o.rempel@pengutronix.de>
 <20210208135347.18494-2-o.rempel@pengutronix.de> <20210210184138.GA2504266@robh.at.kernel.org>
In-Reply-To: <20210210184138.GA2504266@robh.at.kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 12 Feb 2021 10:22:46 +0100
Message-ID: <CACRpkdYLH-D84BinPNvhw2YDvRp=KMeBLqWYhyJQBh+hGFB9Dg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: counter: add event-counter binding
To:     Rob Herring <robh@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Feb 10, 2021 at 7:41 PM Rob Herring <robh@kernel.org> wrote:
> On Mon, Feb 08, 2021 at 02:53:46PM +0100, Oleksij Rempel wrote:

> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  gpios:
> > +    description: Optional diagnostic interface to measure signal level
>
> This description seems wrong in the case of only having a GPIO.
>
> Also, a GPIO only implies polled mode because if the GPIO is interrupt
> capable, 'interrupts' should be required. For gpio-keys, we split the
> compatible strings in this case. I leave it to you if you want to make
> it more explicit.

Ouch. This is a bit of semantic confusion where I see different things
if I put my Linux hat on than if I put my DT hat on ... :/

Linux (or some other OS I suppose) has the ability to look up an
interrupt resource for a GPIO line and that is used quite extensively.

In this case it is certainly possible to write a Linux driver that only take
a GPIO resource and looks up a corresponding interrupt without the
involvement of any DT interrupt resources. This happens a lot.

A typical example is cd-gpios in
Documentation/devicetree/bindings/mmc/mmc-controller.yaml

The operating system will take cd-gpios and infer the corresponding
IRQ from the GPIO hardware by OS-internal mechanisms (in the Linux
case simply using irqdomain) in almost cases, and that is how that is
used today. It is an hardware interrupt
that gets allocated and used but the DT is blissfully ignorant about.

The reason is that GPIO is "general purpose" so they don't have very
specific use cases and the interrupts are general purpose as well.
A certain GPIO line may not even have a certain interrupt associated
with it: there exist GPIO controllers with e.g. 32 GPIO lines but
only 8 interrupts that can be assigned to GPIO lines on a
first-come-first-serve basis so there could not be anything like
a cell in the bindings pointing to a certain interrupt: it has to be
resolved by software, at runtime.

In many cases the corresponsing GPIO hardware will have both
gpio-controller and interrupt-controller flags, but I bet there exist
cases that are only flagged with gpio-controller and then the drivers
in the OS goes and implement interrupts using its abstractions and
assign them anyway.

I don't know if this can be solved in a generic way (solved as in DT
needs to know all about the systems interrupt resources, and the OS
should not be handing out interrupts behind the back of the DT description
for things that are not flagged as interrupt-controller) or if this ambiguity
around GPIO chips just has to stay around forever.

I think it may be one of those cases where DT bindings can't be
all that imperialistic about controlling every resource, but there may
be other views on this.

Yours,
Linus Walleij
