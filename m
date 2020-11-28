Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783D52C7690
	for <lists+linux-iio@lfdr.de>; Sun, 29 Nov 2020 00:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgK1XTC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 18:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgK1XTC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Nov 2020 18:19:02 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B578C0613D2
        for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2020 15:18:22 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id k11so7294481pgq.2
        for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2020 15:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gOwlx47gYt1W3MHWgz8KjiuA/bNiWbFgmz/p6n60JAQ=;
        b=Iz4dxEsexNDmWSnYCNL9jaoFPZVDnPYi6fH/J6KWRQnvKMsPh2eZryNFz8qCYDngJ1
         ILcWj8lrsw8Eyh7oDe2wPV5yK7Kcnh0RY59sfVt0Qu3OSYpIo7q+ugO4tzncy3ptUzCd
         8pnV9UqHYzCR1Pi8PlJ9QW6b0IpxKud84Df4N7K2YSglZqO33kXeOoX+TTNS1zODw5EH
         kna7ZQQX/UWr5jtT4NgLFVXNeqfXEhN0FR3vBQYESo9REJ289ekdzdZVwpPVtO5mwb3m
         1AItDag8nX7j9Afm489MFTKYnWR9KP8w4VoZOMYV84wx/vF8YiBfAoexbOZccRKOMFbM
         zm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gOwlx47gYt1W3MHWgz8KjiuA/bNiWbFgmz/p6n60JAQ=;
        b=ElLJmJ6cOJNZH7SEKF2B8PhHdkMofIIsPQwkR8+CY4u11qE6lScBkiB91+EM/TcS1e
         S7ZHYTZao7b7kdP4wI0FIXw7WimpnrGBRog12Lgx5dWzfE+G/U0uJcSv1W0tneGIxK4H
         xPH8fuFl/vWLTRGCBXKEFRi6SSjtmXXuGYQwSQxK20nhGeqaDa985cK5WvfmbUK1pBOz
         xQddVaIj+fo9C8dDB7o0zQWZYy6xps1WgCcj/Zi7IrFJo4DCzyz4UKVcSz1Wv0LoOUpc
         vJ0LLALqupyKbiXPl7ijkjlz0XnvCbAx5SmSI0eKcyJqadtg9UOH+5hYbW/a0nF8jpAX
         9lnQ==
X-Gm-Message-State: AOAM531CVGKZpbQmxAZtUm6z6A1rtX0GpAOoQT8+2dB1nuYQYgkU/eDh
        tRsAyoLzbYUdn6kY5wL9xJSSQxnZO/D341551Xs=
X-Google-Smtp-Source: ABdhPJxQEJNzSr9jRBCfyGBGirQRlMnEou7J1L25RO53CZhccoMEsqg3Bg7eBZCtxgjvJ+yfMp408xBg4Y0RncjT2Sc=
X-Received: by 2002:aa7:9597:0:b029:198:50a8:a6cf with SMTP id
 z23-20020aa795970000b029019850a8a6cfmr12820267pfj.40.1606605501879; Sat, 28
 Nov 2020 15:18:21 -0800 (PST)
MIME-Version: 1.0
References: <20201128185156.428327-1-jic23@kernel.org> <CACRpkdaA5yhgd4+BgFN6WeC7pmoKPj8kYabD7TtFyEieiNVZfw@mail.gmail.com>
In-Reply-To: <CACRpkdaA5yhgd4+BgFN6WeC7pmoKPj8kYabD7TtFyEieiNVZfw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 29 Nov 2020 01:18:05 +0200
Message-ID: <CAHp75VcKOrjLBwRBZ0gi0S8tL2QK7+3i2dhABbaQaBW8O=_6iA@mail.gmail.com>
Subject: Re: [PATCH] iio:gyro:mpu3050 Treat otp value as a __le64 and use
 FIELD_GET() to break up
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Nov 29, 2020 at 12:22 AM Linus Walleij <linus.walleij@linaro.org> w=
rote:
> On Sat, Nov 28, 2020 at 7:54 PM Jonathan Cameron <jic23@kernel.org> wrote=
:
>
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Inspired by Andy Shevchenko's proposal to use get_unaligned_leXX().
> >
> > The whole one time programable memory is treated as a single 64bit
> > little endian value.  Thus we can avoid a lot of messy handling
> > of fields overlapping byte boundaries by just loading and manipulating
> > it as an __le64 converted to a u64.  That lets us just use FIELD_GET()
> > and GENMASK() to extract the values desired.
> >
> > Note only build tested.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
>
> Are there any specific prerequisites? linux-next?
>
> When I apply this and try to compile for an ARMv7 target I get
> a lot of noise and an error:
>
> In file included from <command-line>:0:0:
> ../drivers/iio/gyro/mpu3050-core.c: In function =E2=80=98mpu3050_hw_init=
=E2=80=99:
> ../include/linux/bits.h:36:11: warning: right shift count is negative
> [-Wshift-count-negative]
>    (~UL(0) >> (BITS_PER_LONG - 1 - (h))))

I think GENMASK_ULL() has to be used.

--=20
With Best Regards,
Andy Shevchenko
