Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613B83D1521
	for <lists+linux-iio@lfdr.de>; Wed, 21 Jul 2021 19:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbhGUQxS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Jul 2021 12:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234914AbhGUQxL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Jul 2021 12:53:11 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1405FC061575;
        Wed, 21 Jul 2021 10:33:46 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id nt18-20020a17090b2492b02901765d605e14so506414pjb.5;
        Wed, 21 Jul 2021 10:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oXUQWH6HmtXfpfz+pg25s2FSI+kvsYhIjDKLLY5hzig=;
        b=q8DEvYroo4XqbTKEr7fs8MlxIT7xT3gVcq5HyrOGAvZMOxHfY7NCTCYsIqjLTmnJ/Z
         0WAChNXy0W3DZ1VMJxhe2qVXzk0S+Adqx0VWBq+LIFZbcYNBBk2y45B2Gu1L9doGPCfV
         Rt7GPx6k4DI6BBA9RUu/lHyT36Ji7wbKuhYGDUjJqkBidCgssyUBrFtBGoB+o5hh1gcJ
         wOAwwaZkBtKwXRR/FNAiUtKdcIwb1geK0a3Qov0t+TQ1C3/+3zNWL1wvIBzVutNv+VEE
         Q5AS6/eNgRVxjpTzRIXORZHq0FiojBUiQEtJN3nygWnty12gnCZdwfNT0EwUO854PZJr
         A1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oXUQWH6HmtXfpfz+pg25s2FSI+kvsYhIjDKLLY5hzig=;
        b=s+05+KdXbVAJDiffT0PtBkkWNZqAA1zSifqDcNHNeeU1KBvr7M3SgckI4CKLYqNFtb
         33LmzQWJcTvWj8azT+oBKbFlYa/4Zc6y+aSgJdtW9yKTOqXxt8tsuP1Kc3tyuAs6S603
         Wb+nhNxnfYQYWev3I4ZlINpQT/eB4ISquguq8iGzFZeNKSMidqdqKMq/l2cEaTA/cR3f
         41zi3ckjkmy7BJdUStjeNzGsRz9GdNVU6xIxkEriEGgW5cT+gk0eLhxJ8atFEUEB8H/F
         LO8jU5AMDIPvXZWYZKsCwyXAyFFcy6gIfFPLoGPVWzLou6waWpE6+CFCR4YCHW1Ik059
         wKyA==
X-Gm-Message-State: AOAM533YoZhFRSPfMpXfRNERO7OtS/sI2OWZTd7DMUZlwvvF3MDfWNrL
        Uog+GgnlRygnURaufs+VYBoY8ZhETtwMnBCZf20=
X-Google-Smtp-Source: ABdhPJyW8PfcFLwQfUJQUVe9CsxL3hRfqVgHDdLZkYLQsE8cN9friKPr6qtcxDzeEeKc3UJBGF4HGo77xavdz4umStU=
X-Received: by 2002:a17:90b:1194:: with SMTP id gk20mr4866507pjb.181.1626888825591;
 Wed, 21 Jul 2021 10:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210721151330.2176653-1-arnd@kernel.org> <CAHp75VeWSfBek+m6hQoc6G7wP+JNN-V3S0kfcGBESZLR+6QAxg@mail.gmail.com>
 <CAK8P3a0wU+yAm0X_URFVuM=GragqQnvz2Reto5e09fzqCVrUqQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0wU+yAm0X_URFVuM=GragqQnvz2Reto5e09fzqCVrUqQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 21 Jul 2021 20:33:05 +0300
Message-ID: <CAHp75VfQLGX4ir8XxMZBMkPaK2SoazJwr3axsk-5p1ok6uf6jg@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: fxls8962af: fix i2c dependency
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Sean Nyekjaer <sean@geanix.com>, Arnd Bergmann <arnd@arndb.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 21, 2021 at 7:12 PM Arnd Bergmann <arnd@kernel.org> wrote:
> On Wed, Jul 21, 2021 at 5:52 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Wed, Jul 21, 2021 at 6:13 PM Arnd Bergmann <arnd@kernel.org> wrote:

...

> > >  config FXLS8962AF
> > >         tristate
> > > +       depends on I2C || !I2C # cannot be built-in for modular I2C
> >
> > Can you enlighten me how this will not be a no-op?
>
> This part does nothing, it only causes a warning when FXLS8962AF
> gets selected =y when I2C=m.

This is something new to me. But shouldn't the other chunk guarantee
that warning won't happen?

> The important bit is the other hunk that adds the same dependency
> to the FXLS8962AF_SPI symbol, which enforces that either I2C
> is completely disabled, or treated as a dependency that prevents
> the user from setting FXLS8962AF_SPI=y when that would cause
> a link failure.

This part I understand and neither object to nor comment on.

> The effect is similar to a 'depends on SND_SOC_I2C_AND_SPI',
> except we only need it on the SPI symbol here because the SPI
> core cannot be in a module itself.

I see. Thanks for elaboration.

-- 
With Best Regards,
Andy Shevchenko
