Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26CD585B4B
	for <lists+linux-iio@lfdr.de>; Sat, 30 Jul 2022 18:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbiG3Qgq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Jul 2022 12:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbiG3Qgq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jul 2022 12:36:46 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAA5DEFF;
        Sat, 30 Jul 2022 09:36:45 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id e15so9030297edj.2;
        Sat, 30 Jul 2022 09:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=c0rmBHoewW1xRohMAusxg/RJwL514da7tUlL9yKqGtk=;
        b=keoB8qGmgcuPQopUoTW4jwVpzxjpmLJ8PHMHW/ji3SgZyIJTLrYdMHWTpNMGJeFciz
         Ca8gHu/bB5xRqTA/gNjAIRedKuAZqrmwmajLKYMrGohtqrffR2Cx8fIDQjznKuDfZOEV
         p/D73k6ztH+4bBaMYCyxxwFFjd0FzWW6C4+ZjFjrCLMln9lWmFaeLmRnUfLwRfo6dfY0
         wyiuFOBIIpqeL0EQ5InTYEe6niTUL6k/I5XvJN9lOnvwqRnj1zAFEQVzHRsvPjfcpYTt
         sabUru5DY6CXYK8ZQwanaxDyAfk+0lDhpbm7sSnHgwMUcsns9UfnFmaQz21NotK6F2W4
         eBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=c0rmBHoewW1xRohMAusxg/RJwL514da7tUlL9yKqGtk=;
        b=qE8TA5zVg+X8CmX5qTtGe7tvPoL5x5Cr3DV7b/J94gofio2CbQN1aUewDk/XuMR/+B
         ZQ5cQFBs0VmNuajh+Nnkn1X6ZISAGCEQoRgYCADy3Fg+zcBvQRjzgb3M8R3KhKIzRUKI
         h22cT3eVCrLs7yBeWuRNWhU9pN6cBATrnmC+QV+zeSAxzGZNu797wrdqcI7CV38hAUjM
         O9lx4kv20VV8bJrefL45dNbrzF6RFwnMljkLyZPZDXNpxRRMwRqo7BUj12P8/hBMgDJu
         pj+OroG4dtrQOoSS1jqMX05xDMeth9+pETCFEfGAb9SEIfk0dfNwrJCQYd3UHa/BPlh3
         36gg==
X-Gm-Message-State: AJIora9StZrwfdtav0qCAPl2INXk7yUaq4oxy6WKNUbVHKAnxI5IPt1G
        jFTL3wQmwyCCroA1pz5FEb2YthTM+MNQZGvzlM0=
X-Google-Smtp-Source: AGRyM1tkxmA0pb7AOBBKrO+3a+32GXoqO7wpqCf30Nv84zq02f7RaCyvg6lsi6zGNSlL6Dt13Qfp7STpOpDz+O99oPc=
X-Received: by 2002:a05:6402:40c3:b0:43b:d65a:cbf7 with SMTP id
 z3-20020a05640240c300b0043bd65acbf7mr8474040edb.380.1659199003673; Sat, 30
 Jul 2022 09:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656883851.git.jahau@rocketmail.com> <69a512cf5b62b34415d5983a6406c3d5ba438a1d.1656883851.git.jahau@rocketmail.com>
 <CAHp75Ve5Z9OOx94FtXY77_Fwkp27D32Hn7bAG+Da++HXmupytA@mail.gmail.com>
 <c5643cee-8491-3fae-b9d4-ac03d86c1e8a@rocketmail.com> <CAHp75VdDdKo7rt+cik4J+_4tDRgBXhgZYc8p+dOSH4s_gtCOUg@mail.gmail.com>
 <6e13daf2-179f-d37f-ace4-db5cd37be8d3@rocketmail.com> <CAHp75VdLBowZ7=6g4aFVr5zkN5Pkv7ir68vPCdkRmoFysqRz9Q@mail.gmail.com>
 <f8071532-14c5-c2a8-ca75-f4327066817b@rocketmail.com> <CAHp75VcPMZSpDS_S_4mM2bfq4154HVMHzZHvdJnP6oUA7RtpiQ@mail.gmail.com>
 <fa6c77e9-1d22-de2f-4cad-4afadf8c6a2a@rocketmail.com>
In-Reply-To: <fa6c77e9-1d22-de2f-4cad-4afadf8c6a2a@rocketmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 30 Jul 2022 18:36:07 +0200
Message-ID: <CAHp75VcsFmzvmk93eSNUwZCDoUN8-7gRkZZ1V4vbFHgnweq5uw@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] iio: magnetometer: yas530: Add YAS537 variant
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jul 30, 2022 at 3:32 PM Jakob Hauser <jahau@rocketmail.com> wrote:
> On 30.07.22 13:32, Andy Shevchenko wrote:
> > On Sat, Jul 30, 2022 at 1:10 AM Jakob Hauser <jahau@rocketmail.com> wrote:
> >> On 29.07.22 19:24, Andy Shevchenko wrote:
> >>> On Fri, Jul 29, 2022 at 1:13 AM Jakob Hauser <jahau@rocketmail.com> wrote:

...

> >>> To the 4100 denominator:
> >>> https://github.com/XPerience-AOSP-Lollipop/android_kernel_wingtech_msm8916/blob/xpe-11.1/drivers/input/misc/yas_mag_drv-yas537.c#L235,
> >>> seems you can find a lot by browsing someone's code and perhaps a Git
> >>> history.
> >>
> >> I've seen that comment before but I don't understand its meaning.
> >
> > It points out that there is a SMPLTIM, which I decode as Sample Time,
> > which is in 4.1 msec steps (up to 255 steps).
>
> Also thanks for this interpretation, that makes sense. Then the
> denominator consists of factor 1000 to convert microseconds back to
> milliseconds and a factor of 4.1 milliseconds per step. The value
> "intrvl", which is written into the YAS537_MEASURE_INTERVAL register,
> would then be the number of steps of the sample time.
>
> However, I wouldn't add anything of this into the driver as a comment or
> as a name, because we're just guessing.

Or we can precisely tell that this is guesswork. Up to you.

...

> I think the define and the formula both look strange.

Definition is available in units.h, for most of the SI prefixes.

-- 
With Best Regards,
Andy Shevchenko
