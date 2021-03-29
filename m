Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E399234CEC2
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 13:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhC2LWR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 07:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbhC2LWF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Mar 2021 07:22:05 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20D7C061574
        for <linux-iio@vger.kernel.org>; Mon, 29 Mar 2021 04:22:04 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id v8so4237303plz.10
        for <linux-iio@vger.kernel.org>; Mon, 29 Mar 2021 04:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X5I7cQl/B+onBos6Wm1/Hq/8e2kB1Nx7PskdQnflnbQ=;
        b=Yfsv+coRKIMkTep/QRRJkSd/0QwXlnGWUEVlt/kr1RuXU09OeF/CegLzFiPZouOI+e
         p9PyAzxjCjUFXkSRhpztiRz50AFo6Xt+eSFxg2rHYKdBz4WS0Q9N/4zuQFOr49XOaaG1
         6aSaGDoaPvGc9bB+Ev7YKn0a+wyQD+KDqwdWylG26suFnZcxnT/961022CMX44qSeULE
         w2S3Nprn3z+gG/47jw6FWcGVwgECVpfH5znHod1r6SczqnGwJUTpE3mDwCCIqD6e0Uxh
         zg0E98fX+Im6S4Huf872e8XjGZse920UXDiAI1SpvCwLOzjRGWQSmKQ9Rbiq3ZdcsIhK
         BMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X5I7cQl/B+onBos6Wm1/Hq/8e2kB1Nx7PskdQnflnbQ=;
        b=JsjtY5dYYZsKlVdzog45jJ/5v9u5TN5SVCusmuo8Vscv3bDfBu8hrwiV8OcfLcxk0x
         gh9o+m//T9qIXYfKY9LLIW9Fiu+3G8YpCZVKfifbR/Q5qmUJ3xRwFhwv6Ynn28FyaR8i
         8/vn9BF2W54icFJS5pBbhXQ49UBcmbCUxzA7fuRjf66DEV1j9qfpnXW/7nZ9LNbi4AfG
         DLOgmzRvQ+aZ/zkihIJJ6V+56gi0OQiS81D1XnaYJnd8Gd0LHOeZVMuBG6bHvkHw+nSC
         CZqbDM7cBVrY9Ln99EmfClolFqBzJghUAwD7BIPacQbjV0Je4TIf9li4aD+xByMRga/2
         NvSQ==
X-Gm-Message-State: AOAM531feFKaNDMqFj3LBbU6s70hmWqndLcdS7hvd038OBo68/g2jPv8
        DoU1y0rmG6fZB4a6OCqI/W1yDGES+5YTc2wAmpv8ncqoqN8Lgg==
X-Google-Smtp-Source: ABdhPJwRu0ZAGjgXGZyV9mOd9QKxngfNDgesas9NOI5MNn8KpZ6PhXMa/XMEElZc10Vy+nyOWETzxb/Dq82UURywJjg=
X-Received: by 2002:a17:902:7883:b029:e7:32bd:6b97 with SMTP id
 q3-20020a1709027883b02900e732bd6b97mr15794664pll.0.1617016924388; Mon, 29 Mar
 2021 04:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210320071405.9347-1-lars@metafoo.de> <20210320071405.9347-5-lars@metafoo.de>
 <733be1879f059f87fc03df79b33cf5560f3dfcaf.camel@perches.com> <3e26d657-4f03-5284-8cfe-73131a65e33f@metafoo.de>
In-Reply-To: <3e26d657-4f03-5284-8cfe-73131a65e33f@metafoo.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Mar 2021 14:21:48 +0300
Message-ID: <CAHp75VdV0YjL2uBWS5SQsH=PfLkWRu5_bTWbfLFUO+hEc0B2OA@mail.gmail.com>
Subject: Re: [PATCH 4/4] iio: dac: Convert powerdown read callbacks to sysfs_emit()
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Joe Perches <joe@perches.com>, Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Mar 20, 2021 at 2:54 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 3/20/21 12:01 PM, Joe Perches wrote:
> > On Sat, 2021-03-20 at 08:14 +0100, Lars-Peter Clausen wrote:
> >> Update DAC drivers powerdown attribute show callback to use the new
> >> sysfs_emit() function.
> >>
> >> sysfs_emit() is preferred over raw s*printf() for sysfs attributes since it
> >> knows about the sysfs buffer specifics and has some built-in sanity checks.
> > Thanks.
> >
> > unrelated trivia:
> >
> >> diff --git a/drivers/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c
> > []
> >> @@ -255,7 +255,7 @@ static ssize_t ad5360_read_dac_powerdown(struct device *dev,
> >>      struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> >>      struct ad5360_state *st = iio_priv(indio_dev);
> >>
> >> -    return sprintf(buf, "%d\n", (bool)(st->ctrl & AD5360_SF_CTRL_PWR_DOWN));
> >> +    return sysfs_emit(buf, "%d\n", (bool)(st->ctrl & AD5360_SF_CTRL_PWR_DOWN));
> > rather than cast to bool, perhaps standardize to use !!(val & test)
> I very much prefer the cast to bool since it semantically stronger.

It's a mistake here. You have no special type for bool and you do
transition int -> bool -> int.
Why? !! is a proper way to deal with this.

> You
> don't have to know that the !! idiom is used to cast an int to bool.

As Joe said.


-- 
With Best Regards,
Andy Shevchenko
