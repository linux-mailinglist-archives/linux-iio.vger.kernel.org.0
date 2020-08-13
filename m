Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E3724392F
	for <lists+linux-iio@lfdr.de>; Thu, 13 Aug 2020 13:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgHMLOc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Aug 2020 07:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgHMLOa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Aug 2020 07:14:30 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FE6C061757
        for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2020 04:14:29 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id q14so1762719ilm.2
        for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2020 04:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Drw0mASaMxjwlc+v1sEJiZJDPjdekVV/QXUc/HktK+E=;
        b=g9q7mJIbn3hrQSrv9YwGoI4XhEzdCzVWGnEUw5xoILnYYN3Ttz7J/Q62eH435j0rzE
         n958oIBgnA7/jlXprmT92J8OOROvm+Z2jYMbl5NJonSzQILJVQ5B1JeO2JJFyTFJXVS5
         NjPgUvdEK48UsonLlcxIxMB35ZnY+YYMa8Tci/vKsSKvMirvq/t/YdYOuQtcW9J8W8RF
         PR4JNyv9rgtvMd6rpEaipaiK6f4h5sCCeHB4UNbItLmioP2wFoGiAT8WslEGljc8FfyZ
         iiaYUVD7oqYxf3v4JynFgR/Zxwwx7v0GDs59u4Qein+KaBaDBp4ELWuF/Xu7N6xqIulE
         8gOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Drw0mASaMxjwlc+v1sEJiZJDPjdekVV/QXUc/HktK+E=;
        b=X5a95eqjZe0P44UQKTwGMuweDWC1uubmXLZEG4i5weYAdao7GhIQN6pDzU9qy0C/7Y
         0tEotO7+kqcSmIG80KUhVUeINbSal+FFnuyj4PqIwNwWoKXYygp+lpkdiiaUzAmr340y
         6ZtVFgPKmFevWlN/M871nP+XmWG51EesVjmty0AaQVByGQlWIHNKT4K7AnUK8BmBnLdE
         ZLgRanjajjnMNi37msYt/ZgSKRDAteIbEI5nCeF3M18eySDzgYzIj4kMP1v3NNiiAJQL
         ZjX95FGgS89xVgRVaG5wyu52LMmdbMk/bJksaBhS4j4XAOWkce3TWiXdav3kWF8j49J0
         fdPw==
X-Gm-Message-State: AOAM531HIz2eYUmUKpqJaajj86zRpuqA5ctV2FK0lD9FGM6ePso1SkzX
        i0VankCKSwQyVnoNLhtgnCkvVlLAQtz3w55QkFWZu1ZfiZo=
X-Google-Smtp-Source: ABdhPJxQJaTwk24Deg909+rNRs4gJtrwkVRx3wGKds6s8xZVwl91JieQoWJUaqj7PAbFGBdU34jMZlWE+yz6FKL/xug=
X-Received: by 2002:a92:cb12:: with SMTP id s18mr4341576ilo.13.1597317268867;
 Thu, 13 Aug 2020 04:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200813075125.4949-1-cmo@melexis.com> <20200813075125.4949-4-cmo@melexis.com>
 <CAHp75VfNwb5uBp=H0295LEJjXy1+=V5yvSN1PHbtMYzgg=_EAA@mail.gmail.com>
In-Reply-To: <CAHp75VfNwb5uBp=H0295LEJjXy1+=V5yvSN1PHbtMYzgg=_EAA@mail.gmail.com>
From:   Crt Mori <cmo@melexis.com>
Date:   Thu, 13 Aug 2020 13:13:53 +0200
Message-ID: <CAKv63uv=b60B9RXBJF4HEhMOowu-qbGrv7LsmJVvkkERSida-A@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] iio:temperature:mlx90632: Convert polling while
 loop to do-while
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 13 Aug 2020 at 13:03, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Thu, Aug 13, 2020 at 10:53 AM Crt Mori <cmo@melexis.com> wrote:
> >
> > Reduce number of lines and improve readability to convert polling while
> > loops to do-while. The iopoll.h interface was not used, because we
> > require more than 20ms timeout, because time for sensor to perform a
> > measurement is around 10ms and it needs to perform measurements for each
> > channel (which currently is 3).
>
> I don't see how it prevents using iopoll.h. It uses usleep_range()
> under the hood in the same way you did here, but open coded.
>

One loop is indeed 10ms and that is not the problem, the problem is
that timeout is at least 3 calls of this data ready (3 channels), so
that is at minimum 30ms of timeout, or it could even be 4 in worse
case scenario and that is outside of the range for usleep to measure.
So in case of the other loop, where we wait 200ms for channel refresh
it is also out of scope. Timeout should be in number of tries or in
msleep range if you ask me.

> ...
>
> > -       while (tries-- > 0) {
> > +       do {
> >                 ret = regmap_read(data->regmap, MLX90632_REG_STATUS,
> >                                   &reg_status);
> >                 if (ret < 0)
> >                         return ret;
> > -               if (reg_status & MLX90632_STAT_DATA_RDY)
> > -                       break;
> >                 usleep_range(10000, 11000);
> > -       }
> > +       } while (!(reg_status & MLX90632_STAT_DATA_RDY) && tries--);
> >
> >         if (tries < 0) {
> >                 dev_err(&data->client->dev, "data not ready");
>
> --
> With Best Regards,
> Andy Shevchenko
