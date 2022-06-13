Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6015549C0B
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jun 2022 20:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiFMSp1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jun 2022 14:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344062AbiFMSnB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jun 2022 14:43:01 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E675B10D;
        Mon, 13 Jun 2022 08:01:57 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u12so11701688eja.8;
        Mon, 13 Jun 2022 08:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aC1QbH3cTFng1BzfntnEn+PULL88pquYCHmXaXqLlCA=;
        b=Yv7gccA6UP1oUNzigw0pjhJTHhxYmKiOj+fdTBOZYsp82HJoOCTV5/FkMdVw6xlW8d
         pbe4A0OJbIVlkd4VLD+TlXfyy1ETZEcbf1kNg9oF6BAO9+aXctOsxcXNzAL3+KMrXghE
         wCSND3Ima44JoRmGxm9FTgZGX/JJjY2SsEY9KWfmLXKhXxvArMubUSeeGlBiKYSxViuB
         nrRXQ6LJz2M5vF5NDzy5xxx2GszwLIRUxPOv/FbaXEK2PYcVAHPL+2S33X5b44lTY6Ry
         YGf2x9skXv/YNSsj880I+uLiGArx+zT93PhdhOK+gEJDQGrxX2KppXI4Ji51fuPbT7uk
         sdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aC1QbH3cTFng1BzfntnEn+PULL88pquYCHmXaXqLlCA=;
        b=uC0y/7vIrRbgHBbHnfrn+uQo4ds3UcrlM7FC5VGkM4SNE0e/JVvX20OLkgbK5KaZAc
         tkgFXv4DXweA5qJNZc9bJDD+eyzDDZYBvq3Kn2m5ORrTSTCWFSTGBqliGmg3duBBv5cI
         sLExe1W4cgFWW6yAwYS/Yf9UB/VWXjple0yhWSrGoY3b+4NoWboiTwqNXYxPeGwLlVsh
         RiZZ+7VDKrgAw+XVlTRaFegcbQ5yAiB4tSvQnG9+LS7HZXAMd9n0VcdEUFH9UX8R5fYb
         KqGueKV+utyQL+5C1DtWijtTwgQGjmqzQtx8NOIzPDBXV49FJ7NPBGesZiJzm9fGanWc
         +Pwg==
X-Gm-Message-State: AOAM532+VEQ1ztY+lA8M2FCCr5FI6EbTVqAQTxMOswJ1Dcam6zdfqbXH
        dI4DaX2CeM765SqxRWq3PVOz6DQtTCQTrbapJ5w=
X-Google-Smtp-Source: ABdhPJxz0ZuL628j9gnwJEGtcjxDFvahegf3oC4oXMZBZ8/QKQ0YyWTjN5khTBbhoholOWHw348fexjya0Xe9EzFYg4=
X-Received: by 2002:a17:906:c7c1:b0:711:d2e9:99d0 with SMTP id
 dc1-20020a170906c7c100b00711d2e999d0mr223768ejb.639.1655132516327; Mon, 13
 Jun 2022 08:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1655081082.git.jahau@rocketmail.com> <2e4622b2c98eda75c262d460533162f74cfb8605.1655081082.git.jahau@rocketmail.com>
In-Reply-To: <2e4622b2c98eda75c262d460533162f74cfb8605.1655081082.git.jahau@rocketmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 13 Jun 2022 17:01:20 +0200
Message-ID: <CAHp75VeHJnuSe+2r8LvN4watFt1q5FZefUvsZokz0SA1NZ6nmw@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] iio: magnetometer: yas530: Correct temperature handling
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy
        Shevchenko <andy.shevchenko@gmail.com>," 
        <~postmarketos/upstreaming@lists.sr.ht>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jun 13, 2022 at 3:17 AM Jakob Hauser <jahau@rocketmail.com> wrote:
>
> The raw temperature value is a number of counts from a certain starting
> point. The resolution of the temperature counts is different for the YAS
> variants.
>
> Temperature compensation for YAS532 version AC seems to be handled differently.
> It uses the deviation from 20 degree Celsius [1] whereas YAS530 and older
> versions of YAS532 apply solely the t value as a multiplier [2][3].
>
> In funtion yas5xx_read_raw(), add case IIO_CHAN_INFO_PROCESSED. Remove scale
> of temperature as this isn't applied.
>
> Additionally correct sign of temperature channel in iio_chan_spec. It's already
> defined that way in yas5xx_get_measure() function.

in the

...

Please add default cases into switches.

-- 
With Best Regards,
Andy Shevchenko
