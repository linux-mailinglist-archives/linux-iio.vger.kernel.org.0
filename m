Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94AB832B3FD
	for <lists+linux-iio@lfdr.de>; Wed,  3 Mar 2021 05:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236208AbhCCELg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Mar 2021 23:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350743AbhCBPq1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Mar 2021 10:46:27 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C66C061794
        for <linux-iio@vger.kernel.org>; Tue,  2 Mar 2021 07:37:17 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id u4so31965324lfs.0
        for <linux-iio@vger.kernel.org>; Tue, 02 Mar 2021 07:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4MgbZOgNW8uixaX7A/+b9oSIGLPsBpXoCjq0KvgA0Vs=;
        b=Sh8OBszE7R3d8uy7nbh6mGISl/xCEmQuyh4gsiTAsNoq0BctI45bGAlwpUnecy1kA2
         7IyIPkl7uPlD9RIGSpEwCItMHd4J1HSMUVEOIfFGWOb1iSQlyd8JBsrwTPeRYNYEwWIL
         4F0Oiifpjpe4z0u4pT36uIJse9yGuU21a4gqFsTthZKHpVuqyyNxzCku3CVqOvhEgXoE
         SEIoh2gDqqJBZHlPiZQgS3vgDgHjUakA1AcpsijE7EI52oMQTvx+0qKk0ZdjmFSwKnmk
         APLEgSd+JFLMwGBh4Pbg5ePTydmtKuUTzi/U75LRZvA8luBff0oR7xz5+PzrwnIK3UAJ
         Z6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4MgbZOgNW8uixaX7A/+b9oSIGLPsBpXoCjq0KvgA0Vs=;
        b=NE7HXjGlQyO66wqBTIUFIDMQAf8wCOkVlbXqoHuAbyvoDgK4mLIphTv/g0NOcTp4J1
         icgcY16oQAPJEYbz/3+Ce04nQCCIISSbjHOZKYlCyeIQc6910tabj8NvotIrbPqlrA4h
         Zhg0Lm7S4LbM3txggwSaNFUoT7Kh6h0xh923f9lHHhiWIDIqSvWaLJvpXGBe2hCvYSlu
         nDbyupQA/48OsSkKPo9eCnSnBKFBIn653E9BQPBobQjgBsP7q60Pqq4U+Dskh0t0vWak
         yNo8gPGUscpdB2hr/A7MFkoi0mx1o0hpQAW8c4cJpiLBs+kVkjwV19r1SKCQxwLeokwl
         JjHg==
X-Gm-Message-State: AOAM530zWjVFOqBebeTdSZ6fhGp+87T+FFAI00m/R/VObN2mNST2swvr
        dLAl3+OEqvMWnXpskQoD+4a6vFyJflircG6Awf3YQw==
X-Google-Smtp-Source: ABdhPJw4x/G20E257/e052t5Gg9ElQhvDjsYdCfPJESaXuqZZBAOAPdVPZrOW8Pyw0S1XLAm4uKTuwetVf8NZN0spvM=
X-Received: by 2002:ac2:5d21:: with SMTP id i1mr12099756lfb.649.1614699436419;
 Tue, 02 Mar 2021 07:37:16 -0800 (PST)
MIME-Version: 1.0
References: <20210208135347.18494-1-o.rempel@pengutronix.de>
 <20210208135347.18494-3-o.rempel@pengutronix.de> <YCjlPhEtyH+vfSi4@shinobu>
 <20210215091737.fx6dwiz7tt56wbkr@pengutronix.de> <YDMMJJ985Zq9oEOv@shinobu>
 <20210223100656.efbshsh5bz66uhj5@pengutronix.de> <20210223174516.wjlh7hnrd5qe5s6w@pengutronix.de>
 <YDW7Hihg0gGQh8UR@shinobu>
In-Reply-To: <YDW7Hihg0gGQh8UR@shinobu>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Mar 2021 16:37:05 +0100
Message-ID: <CACRpkdY7GSPiadVORECLcdK91AORY6LgtWi8BBLNK_Sj0Jc3LA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] counter: add IRQ or GPIO based event counter
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
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

On Wed, Feb 24, 2021 at 3:34 AM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
> On Tue, Feb 23, 2021 at 06:45:16PM +0100, Oleksij Rempel wrote:

> > > to make this possible, i would need hack gpiolib framework and add
> > > name/label exporter. But after endless rounds of pingponging me for
> > > renaming the driver and removing interrupt handler, i feel like we are
> > > not having serious discussion for mainlining this driver.
> >
> > Probably for good reason, struct gpio_desc was made local and is located
> > in the drivers/gpio/gpiolib.h. It feels like additional hack to include
> > it. I assume, it should be done properly so there is a function to
> > provide gpio name or label.
> >
> > @Linus Walleij are there any good way to get the GPIO name? And which
> > name will be actually used? A label provided over devicetree?
>
> Perhaps one of the GPIO subsystem maintainers can provide more guidance
> here, but I was under the impression that this name was provided
> statically by the respective GPIO driver via their struct gpio_chip. I
> think you can see the array of names via priv->gpio->gdev->chip->names.

These names can be set either through device properties on the
GPIO chip "line-names" such as through device tree, or as static
names in the .names array on struct gpio_chip for chips that
are e.g. hot-pluggable and does not have a hardware
description associated. These names should be something
like what the signal is called on the circuit board rail.

gpiolib further has a function:
gpiod_set_consumer_name() that can be used by consumers to
set their use case for the line, which makes it appear in debugfs
etc. The consumer name does not need to be unique.

These names have no practical use other than debugging or
userspace representation.

I hope this helps.

Yours,
Linus Walleij
