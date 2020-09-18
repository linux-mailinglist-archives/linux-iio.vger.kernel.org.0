Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41DC026FF8B
	for <lists+linux-iio@lfdr.de>; Fri, 18 Sep 2020 16:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgIROFs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Sep 2020 10:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgIROFs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Sep 2020 10:05:48 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33642C0613CE
        for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2020 07:05:48 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 34so3523749pgo.13
        for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2020 07:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vg4HS5x44NsYLIVbhXmvTqGjvDVy5nLpkg2qw/Zmuzo=;
        b=TaacylG8E1o4FK8cOaduPHfCwc+qPCtBvB+drCduAHHGOLWiBucqo5Sp/ymHL9Fhxq
         Yh7LDKLOmt+Vtc4zXEq/xZxZxfS1hGehlOjFDg3qao8H2nwMWuqEKgg3TJFT3T+/JzYH
         Ohduq5rCWEsFGhGUlXP/CJgQbCg7fC2JvIxlEf6q00Xsll+OaVC0T2DataVhzey6oCfz
         YarpW+H6Tdy+4Xa9AOaCj8VzOU3NlRh6ow5x8ANqi1CnFuP8lJssomG8Z7XSZ5wdV8d8
         lFETY0/GeG1xV1mQ4cD47UVWxy/3NpqmWjVxui/lTTnGdCW07oSmwl49qHP2yZJauiOf
         wdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vg4HS5x44NsYLIVbhXmvTqGjvDVy5nLpkg2qw/Zmuzo=;
        b=DSShSvdLXzymhvEsjOQiQqhlcHuZgxELkjHRQvt57zxD4qB3ZMHajQqZKRqUfMmah7
         o7hjf4ru6Ha4fxOYuMMioTPveMM/71Ct433sW3wVXc0ZdTOu5KD1tcDw24pc/6TR856q
         WDKiEDIl0kFReOeCjrLwf0kddQb3jULSRkD1Q3gKc7ralZqHxbbHJQccpYq/cabSOJRb
         t2adzHvEDWWYI9dDkQfdrnn5Os8i8SfAaIj7I9lOUaCzQZ7qPFiyMBYsv596HSinHfdH
         7BPm0ypcKqQ4uKMMiO5M4vL9OTp87bFfkK/Iv1pMuiQUfO9Y38YqNDWrw9cy4aRRQZlo
         N0+w==
X-Gm-Message-State: AOAM531kL5fkQr6WkElGa7Pw7dbCqFaof9QPznpjXY9yaWzfh7NgMQJz
        Kszmd9kL0vi+Edr/wKw9s9CK33NDVx11iO89im4ZNZIM7nE/tQ==
X-Google-Smtp-Source: ABdhPJxzU+wyQGvJ8qn6H+j2dJBFEKZ2XVXTjXZUc1dSNFUC9H+DiWjssA25Q+PJZnF6eMbuJs4XTnEELx6TqzcrjuU=
X-Received: by 2002:a63:ec4c:: with SMTP id r12mr26239779pgj.74.1600437947653;
 Fri, 18 Sep 2020 07:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200918133357.0ed56512@archlinux>
In-Reply-To: <20200918133357.0ed56512@archlinux>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 18 Sep 2020 17:05:29 +0300
Message-ID: <CAHp75VfEAA7QeFz1uEVoX6fsuO9kGEmLTCZkHaCk8_rOWigtbQ@mail.gmail.com>
Subject: Re: IIO: Review request.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Sep 18, 2020 at 3:34 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> Hi All,
>
> Classic being the maintainer problem, is that there is no one specific to pester
> when you can't get reviews on your own patches.  Hence if anyone has some
> time I'd appreciate sanity checks on:
>
> [PATCH 2/3] iio: Add __printf() attributes to various allocation functions
> https://lore.kernel.org/linux-iio/20200913132115.800131-3-jic23@kernel.org/
>

Examples show that rather
static __printf() for the first occurrence. Otherwise the entire list
of these patches LGTM. You may put my Rb tag.

> [PATCH 3/3] iio:core: Tidy up kernel-doc.
> https://lore.kernel.org/linux-iio/20200913132115.800131-4-jic23@kernel.org/
>
> [PATCH] iio:magn:hmc5843: Fix passing true where iio_shared_by enum required.
> https://lore.kernel.org/linux-iio/20200913112546.715624-1-jic23@kernel.org/
>
> [PATCH] iio:accel:bma180: Fix use of true when should be iio_shared_by enum
> https://lore.kernel.org/linux-iio/20200913121227.764626-1-jic23@kernel.org/
>
> For those last 2 I forgot I'd previously sent effectively the same fixes out
> earlier in the year but didn't get any reviews then either :(
>
> Note I've randomly picked a few people who have done reviews or posted a lot
> of patches recently for the cc list.  I'm more than happy if anyone else
> wants to join in with the fun :)  Reviews are always appreciated for any
> code submitted to IIO from anyone.  If you are unsure about something in
> a review, it is fine to say so.  Hence even relatively new people can
> offer great value.  We all started somewhere!
>
> Thanks,
>
> Jonathan



-- 
With Best Regards,
Andy Shevchenko
