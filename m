Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59CD83A9582
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jun 2021 11:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhFPJGz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Jun 2021 05:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbhFPJGz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Jun 2021 05:06:55 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60543C061574
        for <linux-iio@vger.kernel.org>; Wed, 16 Jun 2021 02:04:49 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id i13so3081358lfc.7
        for <linux-iio@vger.kernel.org>; Wed, 16 Jun 2021 02:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qlUuRPIap9krUUuGBD2YgqR3N27moBZehgRZaq+lcds=;
        b=OpI5Hkp8ficohScwsAWgIYQ7M7xAv8FbP/AQDzJhwFNVDhtFolZNOo39Uf7GAF2EKU
         /YiC6sr+rB+nNFdwUyhrTPQGPsy575GI0jgO/sdphrox8vxciBJLJ7djwKV4kO7fRhJe
         n+DtgNFtjGjGXOqtWcwhTq9a6nyi/4fo3ttsKLD0mJf40mO302Pl/bCscBRwCkOv6zPx
         jzPfXFbMLLrTmq2crvZe5YD3msrBtMsU2HSF+A0OUkbFlDziNgLi4PCYI93rQb8MZg6B
         Cj0p5/h7AI2uHgFc2Mspn2ldD2EV43FYpp5tDB2a1scYDnWvIjtknQTaIxWNskUXgERW
         HJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qlUuRPIap9krUUuGBD2YgqR3N27moBZehgRZaq+lcds=;
        b=gmYiihvUYDrcB6QR4P8a+0kbvwzwoEFw2qzSDCs0vFI7jbcEzm+8DrI7LRSXChMFZv
         X9a+vUSOnWZ+jiRTok3flMR8fY4H+TaaWhxwVYjA5zJ1+biZMWiETrjcPFmpCvqrPQ37
         uENWYXbxloBLQjffoa+GgPH79V39x86TtFNM6iGBPOwfFb6uG3gh7PyokejLQNoniKno
         Mjc/cN4Z8trT3lMRi0Y/CLzsNaXYJCt9Gt8H+aLVe2Y9K8WYJTG/8SCC9fb65PYAaxL2
         WwZF5o7vy4oy6miwiDTUoG37h84IBup+nhp/28V9MISrMNpVSqjsUE9DjwySsy4o749d
         spkA==
X-Gm-Message-State: AOAM532V5j9eSRqHYh0/KCx4nBT5gvHS+15mwsGa9Bgr+Zy1bik2gAi0
        6i7IilUgVe7bJaZlDFOq7ZUtEyvFcofPVOLSGn97PQ==
X-Google-Smtp-Source: ABdhPJxadH5RsFn0ITtL7v3Zq9p30r2QuRPgng3f06II5Hz7mEkRPbkdlOso901OroXs7nBxgftqQNu3J7I3Uw6rzZk=
X-Received: by 2002:a05:6512:3241:: with SMTP id c1mr3081763lfr.29.1623834287659;
 Wed, 16 Jun 2021 02:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210614163150.7774-1-stephan@gerhold.net> <20210614163150.7774-4-stephan@gerhold.net>
In-Reply-To: <20210614163150.7774-4-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 16 Jun 2021 11:04:36 +0200
Message-ID: <CACRpkdb2xrWH8=FZg1AAby1Verof2Z_of9+=JNF+nn_U-jtj3w@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: iio: accel: bma255: Merge bosch,bma180 schema
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jun 14, 2021 at 6:34 PM Stephan Gerhold <stephan@gerhold.net> wrote:

> In Linux the bma180 and bmc150-accel driver cover fairly similar chips
> from Bosch (just with minor register differences). For the DT schema,
> this does not make any difference: They both represent I2C/SPI devices,
> have one or two interrupts plus a vdd/vddio-supply.
>
> This means there is no need to duplicate the schema, we can just
> document the compatibles for both drivers in a single DT schema.
>
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> Some additional notes:
>   - The datasheet links in bma180 sadly seem all broken for me so
>     I just dropped them.

Fair enough, but some people would be able to obtain them using the
Wayback machine.

>   - I separated the bma180/bmc150-accel compatibles using a comment.
>     This is just for clarity, it has no influence on the schema.

Some DT binding maintainers may be allergic to any mention of
Linux particulars in binding documents but I am not so fine by me.

>   - I added myself as second maintainer for the bma255 binding since
>     Jonathan seemed to be happy to get unlisted for bma180. :)

Thanks!

> In the future we could consider combining even more schemas.
> In particular bosch,bma400.yaml and bosch,bmi088.yaml are also
> almost identical, although they currently specify different interrupt
> types. I think in general the situation for those Bosch sensors is
> exactly the same: The sensors can be configured to either active-high
> or active-low level. However, at the moment neither bma400 or bmi088
> actually implement interrupt support. For now I kept those schemas
> as-is, I think this is better left up for follow-up patches.

The situation is caused by Bosch sensortec
division not being particularly involved with the maintenance of these
drivers in the Linux kernel. (They did send a few initial patches
some years back, but since have not been heard from.)

It would be great to get the attention of someone in charge
@bosch-sensortec.com.

Their own drivers seem to target stuff like Arduino but more
generally on the "OS independence shim"-paradigm:
https://github.com/BoschSensortec

They have their own community here:
https://community.bosch-sensortec.com/t5/Bosch-Sensortec-Community/ct-p/bst_community
Their users ask questions about Linux sensor support all the time.
Their stance seem to be to work directly with companies making
products through FAE:s (field application engineers). It's a bit
like a guild.

I tried to find a real mail address to them but failed.

Yours,
Linus Walleij
