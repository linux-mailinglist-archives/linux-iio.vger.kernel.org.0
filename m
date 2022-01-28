Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B701549FD22
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jan 2022 16:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349697AbiA1PvU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Jan 2022 10:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349696AbiA1PvU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Jan 2022 10:51:20 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42DDC061714
        for <linux-iio@vger.kernel.org>; Fri, 28 Jan 2022 07:51:19 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id g14so19653084ybs.8
        for <linux-iio@vger.kernel.org>; Fri, 28 Jan 2022 07:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NzzOa90r+UEhhQasjIhaGTCJXWBGOWkSCnnTDJnaUwE=;
        b=ILLs1bmBWcqYa8YcrpOTKdkOowUrHzTkrNlJ5UO6en4cr4NIsqhLkcvz/CGheI4f8s
         n6ls5mQuV6inYKKp9m1gXmodBtTthBxwCKBjH63zGuyZ8CZ2CSseTo7gWTJe3/cspyqu
         FXpPLXuxG6Ne5194jBNOd7vnkbz7i9+D4vzU1fV5O+qRA9PpO5xLCxqsXKKuDNYe+v03
         QvX4y1Fl3yJ3Ugm4VOP7uxA7iOq1dqfjmiGreTl2wfwXMuKa5Kw6c8WYzMFTJX1ug+Bi
         f8r8GFdxLm0UMROBVSGj7GJ2XsTnKvREksm9FXi9kAscnI7L3RN3yrzJXdeVMOSytbTV
         YEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NzzOa90r+UEhhQasjIhaGTCJXWBGOWkSCnnTDJnaUwE=;
        b=INxZiWoCxvEmg8QiX+vPjaIhZS/QfuR87RIGSOXnNQYIFh6x+nTqc/6jcS4kDmKlU7
         0OGR6xqxA7W4XU4vz6RXurWKK+jaiL8ihVHhLn8a1tXOHglUDk1e/WwW3H9qdk5ufQHe
         zQHMcd+0ioHHVyuRtWbQifSuO/j8LVE+qlfqcNRAhs1lMCzk9V825KRJCCXR4zGwVobu
         Bws6E+pEwHoiN3Yq+qBPXitw48RjS+GShMYnjMWWJLel4nV82oIIuEKNnsmZevBhElWJ
         dcAeNVlGRQgSOvwxUbgTst+HhmRh9CTbXzu73uE70p5UEGhnQpUPaFlb25xvJKRpp8D/
         x7gA==
X-Gm-Message-State: AOAM5336GTeSVwP9pCM7cWCyCR9bSdak7918zoh9gb45b6OVy3vo4jDg
        yWAHNh4caf7gd6ym8sUBjQkUVYGWZu6uu6uswPjyVA==
X-Google-Smtp-Source: ABdhPJwZSgwZ+c2EpsAkf0hqpurLM2P0YCb+u4F+wIreHiUnXpIcjSDgNYHFzA0l68cl3XUTjVD+EZHKbPz/o9WD0LE=
X-Received: by 2002:a25:df56:: with SMTP id w83mr13234791ybg.110.1643385078895;
 Fri, 28 Jan 2022 07:51:18 -0800 (PST)
MIME-Version: 1.0
References: <20210412122331.1631643-1-linus.walleij@linaro.org> <CAMuHMdUYOxKECcF+aM3+pTpgp-412YbL5vMDZpmEqJmLigpdVw@mail.gmail.com>
In-Reply-To: <CAMuHMdUYOxKECcF+aM3+pTpgp-412YbL5vMDZpmEqJmLigpdVw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Jan 2022 16:51:07 +0100
Message-ID: <CACRpkdbrX-JiPJh2pnVPt39mNgNNrAFkOfS8Q9kO002+oVagyg@mail.gmail.com>
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

On Wed, Jan 26, 2022 at 3:59 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, Apr 12, 2021 at 2:24 PM Linus Walleij <linus.walleij@linaro.org> wrote:

> >    interrupts:
> > +    description: interrupt line(s) connected to the DRDY line(s) and/or the
> > +      Intertial interrupt lines INT1 and INT2 if these exist. This means up to
> > +      three interrupts, and the DRDY must be the first one if it exists on
>
> So this says three (the LSM9DS0 datasheet agrees)...
>
> > +      the package. The trigger edge of the interrupts is sometimes software
> > +      configurable in the hardware so the operating system should parse this
> > +      flag and set up the trigger edge as indicated in the device tree.
> >      minItems: 1
> > +    maxItems: 2
>
> ... while this says two?

Looks like a bug, could you send a patch? (I'm a bit preoccupied right now.)

Thanks!
Linus Walleij
