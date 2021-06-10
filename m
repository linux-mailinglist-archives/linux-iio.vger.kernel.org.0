Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0712A3A29A7
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 12:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhFJKxt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 06:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhFJKxt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 06:53:49 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AF3C061574;
        Thu, 10 Jun 2021 03:51:40 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id b12so790059plg.11;
        Thu, 10 Jun 2021 03:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iOZjrnTQKdLuq6yNh6hslwB5mPBoj7FOHG7ACINDzzI=;
        b=fN5ZFJvyAL6ez3437hZ96vON2263h7SxJwkhRv+wPVK9wZzW3AzA0xSn3YwGtz3Kft
         Qd4NYhAOm2aXNu6xBSYv3sOH3+WMH63JWZDglskv2L1kfmXvxDLiBjLwoZa2kVcPWDBO
         cYonFqY6/jQvIcIiB7w9QwFHDFI6msYlk0sfzPs2zPZStgJLMQPfjRo6faVO6ND74YPH
         Zf0oVMyt2xtxw2BupIO+iYRXNt+4oumIQpeIlrHd5/jaPcIRjHwIBbIJBNUjYpSZQ60T
         T+SaW450QwS8pTwcVQiF0YnH1TvBFDtvffI74Dq+eMUoMvofdSTw44dSnN89l0dd0Ezq
         iNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iOZjrnTQKdLuq6yNh6hslwB5mPBoj7FOHG7ACINDzzI=;
        b=JLBveCg8rCKKEInPi5R93n0QqrqcQVwNFeoCodnXRqcQ0nlgmUXLDcnR5WR2G047kb
         Zdqx+f8VAgKDJcEYhTy+7MzejOfzFpbCKd78nTrWZ1slXtZ7V9iXHGIUbrUrdjeLunaQ
         liJG/I8xxde9q1zOgd+QeHn1NtQ3UB5zcY17xWZXq1mPRKq7xGElD1BzwHzEboqpJw+j
         Cc7h/7/fQclKtH5kdfuEaAEbJqmdNUys/BZhSl5C3KqTAN1kHD1KvsWcNqcj9MJpbBX8
         GBkGD+zVqn0P/KZS74z47wgcYPy/X7U+7njAPS+e+TEw9fmfGvCYzltgxqQPz0QAacj/
         MPCw==
X-Gm-Message-State: AOAM531N1uVNJ0HtlFvMuFVnWrOj/2X9IViIsa02XefWnQ9b4hAecjEH
        TfRwIQJ3bE4ViWOqLe+x+rxn4oYEapT87lA2+HI=
X-Google-Smtp-Source: ABdhPJyHw3Du/38IHyWKdGE9ypc2EUBjdVXOUfHkzxJeo5DsASa+jvqKgsqyt887WkkhlDz5hrJtRRBgvNt5sqxR5bY=
X-Received: by 2002:a17:90b:818:: with SMTP id bk24mr2781255pjb.228.1623322298836;
 Thu, 10 Jun 2021 03:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210610095300.3613-1-stephan@gerhold.net> <CAHp75Vc2c3GX5jESbGexnwJ-WUtZHCjVNsqTVykCrViCjH77+Q@mail.gmail.com>
 <YMHt1Z1QKUGMPDZX@gerhold.net>
In-Reply-To: <YMHt1Z1QKUGMPDZX@gerhold.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Jun 2021 13:51:22 +0300
Message-ID: <CAHp75Vervzi9zXdWef8vpGZwM5wS3LtuKTY9f5j9QA0Asbea2Q@mail.gmail.com>
Subject: Re: [PATCH 0/6] iio: accel: bmc150: Add support for BMA253/BMA254
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 10, 2021 at 1:48 PM Stephan Gerhold <stephan@gerhold.net> wrote:
> On Thu, Jun 10, 2021 at 01:29:26PM +0300, Andy Shevchenko wrote:
> > On Thu, Jun 10, 2021 at 12:56 PM Stephan Gerhold <stephan@gerhold.net> wrote:
> > >
> > > The Bosch BMA253 accelerometer is very similar to both BMA254 and BMA255.
> > > The current situation is very confusing: BMA254 is supported by the bma180
> > > driver, but BMA255 is supported by the bmc150-accel driver.
> > >
> > > It turns out the bma180 and bmc150-accel drivers have quite some overlap,
> > > and BMA253/BMA254 would be a bit better supported in bmc150
> > > (which has support for the motion trigger/interrupt).
> > >
> > > This series adds BMA253 support to bmc150-accel and also moves BMA254
> > > over to bmc150, removing some unnecessary code from the bma180 driver.
> > >
> > > I asked Linus Walleij to test these patches on BMA254 a while ago
> > > and he suggested that I already add his Reviewed-by.
> >
> > I add
> >
> >
> > After addressing comments per patch 1, feel free to add my
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > to the series.
> >
>
> Thanks for the review!
>
> I think the re-ordering should be a separate commit to make the diff not
> too confusing. Is it fine for you if I send that as a follow-up patch?
> I already have two more patches that would conflict with the reordering,
> so it would be easier to include that in the next series.
>
> But I can also re-send the entire series with the extra patch if you
> prefer that, just let me know. :)

I think that doing the reordering first (if there are no fixes so far)
is a good idea.

-- 
With Best Regards,
Andy Shevchenko
