Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA652554C8
	for <lists+linux-iio@lfdr.de>; Fri, 28 Aug 2020 09:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgH1HDU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Aug 2020 03:03:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbgH1HDT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 28 Aug 2020 03:03:19 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A10D8214DB;
        Fri, 28 Aug 2020 07:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598598198;
        bh=4faSGkxwde2dUgjoJLxEPngM/PNDuiR7AsduftolHIs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sx7QHngCjfwrj5EpTWFj8h72BUzgxBMBKywR+k595Wk3fByAORr3jVBGDZLwGksw0
         PYNKYbUpEnueECWfETWbOSoHpehiGjPGGdGrQ1xkURBaro59NTzuZqovK+ftZZdWmw
         BIoHuIn6C7rK8aWGwpap/DKCec5A9wvC81kDbajc=
Received: by mail-ej1-f41.google.com with SMTP id d11so108999ejt.13;
        Fri, 28 Aug 2020 00:03:18 -0700 (PDT)
X-Gm-Message-State: AOAM530xspcHh02fOCnYcpu+pEaZfgTuO3YftEMnW6YqSQJLP8coGynN
        FfZwslcwId8hf8v6/WuJ3pMAsgVOo+ma1icz9NA=
X-Google-Smtp-Source: ABdhPJxeqj21bGrdAgawvMqE4DUECkHszI8hRw0tB+YmvQTkV+0igeB3UuUCefttjGSqXjyZ8z82C9AEfK2QoACQnCo=
X-Received: by 2002:a17:906:3e0a:: with SMTP id k10mr409528eji.148.1598598197045;
 Fri, 28 Aug 2020 00:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200827192642.1725-1-krzk@kernel.org> <20200827192642.1725-9-krzk@kernel.org>
 <f4a5777e-fe85-9f3f-4818-f7539f223adc@axentia.se> <20200828062443.GA17343@pi3>
 <3a5cb59b-454e-2c3f-9f31-43147e843c66@axentia.se>
In-Reply-To: <3a5cb59b-454e-2c3f-9f31-43147e843c66@axentia.se>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 28 Aug 2020 09:03:06 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcqNE5U82UThzBTPCvucCf2LsCVSfAHE1vnecJGCKCaig@mail.gmail.com>
Message-ID: <CAJKOXPcqNE5U82UThzBTPCvucCf2LsCVSfAHE1vnecJGCKCaig@mail.gmail.com>
Subject: Re: [PATCH v2 09/18] iio: afe: iio-rescale: Simplify with dev_err_probe()
To:     Peter Rosin <peda@axentia.se>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Beniamin Bia <beniamin.bia@analog.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-amlogic@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 28 Aug 2020 at 08:58, Peter Rosin <peda@axentia.se> wrote:
> >> I'm not a huge fan of adding *one* odd line breaking the 80 column
> >> recommendation to any file. I like to be able to fit multiple
> >> windows side by side in a meaningful way. Also, I don't like having
> >> a shitload of emptiness on my screen, which is what happens when some
> >> lines are longer and you want to see it all. I strongly believe that
> >> the 80 column rule/recommendation is still as valid as it ever was.
> >> It's just hard to read longish lines; there's a reason newspapers
> >> columns are quite narrow...
> >>
> >> Same comment for the envelope-detector (3/18).
> >>
> >> You will probably never look at these files again, but *I* might have
> >> to revisit them for one reason or another, and these long lines will
> >> annoy me when that happens.
> >
> > Initially I posted it with 80-characters wrap. Then I received a comment
> > - better to stick to the new 100, as checkpatch accepts it.
> >
> > Now you write, better to go back to 80.
> >
> > Maybe then someone else will write to me, better to go to 100.
> >
> > And another person will reply, no, coding style still mentions 80, so
> > keep it at 80.
> >
> > Sure guys, please first decide which one you prefer, then I will wrap it
> > accordingly. :)
> >
> > Otherwise I will just jump from one to another depending on one person's
> > personal preference.
> >
> > If there is no consensus among discussing people, I find this 100 line
> > more readable, already got review, checkpatch accepts it so if subsystem
> > maintainer likes it, I prefer to leave it like this.
>
> I'm not impressed by that argument. For the files I have mentioned, it
> does not matter very much to me if you and some random person think that
> 100 columns might *slightly* improve readability.
>
> Quoting coding-style
>
>   Statements longer than 80 columns should be broken into sensible chunks,
>   unless exceeding 80 columns significantly increases readability and does
>   not hide information.
>
> Notice that word? *significantly*

Notice also checkpatch change...

First of all, I don't have a preference over wrapping here. As I said,
I sent v1 with 80 and got a response to change it to 100. You want me
basically to bounce from A to B to A to B.

> Why do I even have to speak up about this? WTF?

Because we all share here our ideas...

> For the patches that touch files that I originally wrote [1], my
> preference should be clear by now.

I understood your preference. There is nothing unclear here. Other
person had different preference. I told you my arguments that it is
not reasonable to jump A->B->A->B just because each person has a
different view. At the end it's the subsystem maintainer's decision as
he wants to keep his subsystem clean.

Best regards,
Krzysztof
