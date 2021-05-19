Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399B638984B
	for <lists+linux-iio@lfdr.de>; Wed, 19 May 2021 23:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbhESVB3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 May 2021 17:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhESVB3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 May 2021 17:01:29 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D7CC06175F;
        Wed, 19 May 2021 14:00:08 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so12986121otg.2;
        Wed, 19 May 2021 14:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OJ4xddo6HAByAS2Mf+0gozS0xDegLbhMxvUwK7ZPGQE=;
        b=VivXWrAmQJS1ZtwNhQsFioYbvNDe5wUeAf96SQhqtUXt61nrqGgtVHUJBXvbRofAYS
         Tgj/M+3x2YsYiKgLn8ToP5/3MYBnUwqk6dTbEb7ALDluGGq08B1OJZyJHDCEM3qLu3wz
         s7W4F7zUgDygZrRx3sv7dC9lKdlgJmXG8b6RL8FVTx42zALLeMadOFvAmU0UyAaCPdJI
         CpxyhsKzMOeTEnlF074GU8J/mMSudCNA6wpM8PJ6O/yC05Jfd5IfxErSqfuON5Ev1276
         esJqQzRxcsh9zbqWNiDCZebD4ExckjEN+9xmcMwx2/2zTzSGY9nGC1JxQ0kpPVVY+cSY
         0IWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OJ4xddo6HAByAS2Mf+0gozS0xDegLbhMxvUwK7ZPGQE=;
        b=Cf5eHqMzeq7HdL0h7t4jVDhpM0pbKgoUn+2rrfgNn/uEM1tNWJ4h1Eg8UrmV7lJJLf
         gIWW2LnfOtwqZ0JMryNOenVhncKPpjewpsprx4GaoF9jG2sv/QypWk/m1fgnZWLcc1G7
         ZPnU+NubXiXLLN++AQfEtwXzF/SJAdC8Ez9ZStdjQCg7BuZvZqRulaR/K1CjJ8aKAHg/
         E1lc/9N3KP8kAQ/zJ77t2dvKYZcPexS4ceW5htuulmoDDlfEaOzbR23FOkOoKUaKBeby
         cBbTGYVfiHyWGCAgaAwcJcyLt7FE/Pj4hW9zpmXziyi4zvszuB9b2uRhKEmXBXuDeNoq
         R0cQ==
X-Gm-Message-State: AOAM533/OVmY6UHuEZnGaZNm7PXGc/SRa3oqeXeHt9mciUZ8oSAd1ANB
        NtTUNU0LLg1Gr8/6I+qG3AyNzCwPBppbPMzuwpLp4t6/dmL54Q==
X-Google-Smtp-Source: ABdhPJywbnkY5hJthZVCokPPffVXR6mbseppLvL9bW9/9/nIywzZCsiRbwYwYyLwRkfgNDP4Zo8QzYqvHBxXU4qaxBM=
X-Received: by 2002:a9d:5a9b:: with SMTP id w27mr1177123oth.362.1621458007340;
 Wed, 19 May 2021 14:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1619841953.git.lucas.p.stankus@gmail.com> <20210502185002.4c2faead@jic23-huawei>
In-Reply-To: <20210502185002.4c2faead@jic23-huawei>
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
Date:   Wed, 19 May 2021 17:59:31 -0300
Message-ID: <CACKVXZCxKpBwzmy4L+TEmbO5nYUVMEjZd7SZ3+1KTOaz3hp89A@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] staging: iio: cdc: ad7746: add dt properties for
 capacitive channel setup
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 2, 2021 at 2:49 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat, 1 May 2021 09:32:03 -0300
> Lucas Stankus <lucas.p.stankus@gmail.com> wrote:
>
> > This patch series aims to replace the platform_struct for the ad7746 driver
> > in favor of device tree bindings, creating the dt-binding documentation in
> > the process.
> >
> > Since the header file was only used to define the struct and the excitation
> > level values, it was possible to remove the file entirely.
> >
> > Changelog v2 -> v3:
> > - Add application reference note for the inverted EXCX dt bindings
> > - Replace macro with lookup table for setting the capacitive channel
> >   excitation voltage
> >
> > Lucas Stankus (2):
> >   dt-bindings: staging: iio: cdc: ad7746: add binding documentation for
> >     AD7746
> >   staging: iio: cdc: ad7746: use dt for capacitive channel setup.
>
> Looks good to me.  Thanks!
>
> Will leave time for Rob or anyone else to take a look etc before applying.
>
> If I seem to have lost it then feel free to give me a poke in a few weeks
> (it's happened a few times in the past :(
>
> Thanks,
>
> Jonathan
> >
> >  .../bindings/iio/cdc/adi,ad7746.yaml          | 77 +++++++++++++++++++
> >  drivers/staging/iio/cdc/ad7746.c              | 54 ++++++++-----
> >  drivers/staging/iio/cdc/ad7746.h              | 28 -------
> >  3 files changed, 110 insertions(+), 49 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml
> >  delete mode 100644 drivers/staging/iio/cdc/ad7746.h
> >
>

Hey Jonathan,

It has been a week or so without any more feedback, so I'm just a pinging here
to know if this can be applied.

Thanks,
Lucas
