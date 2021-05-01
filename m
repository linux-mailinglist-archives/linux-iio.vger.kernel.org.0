Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BAD3708BC
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 21:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbhEATPY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 15:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbhEATPY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 May 2021 15:15:24 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF82C06174A
        for <linux-iio@vger.kernel.org>; Sat,  1 May 2021 12:14:33 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id m6-20020a17090a8586b02901507e1acf0fso1061109pjn.3
        for <linux-iio@vger.kernel.org>; Sat, 01 May 2021 12:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uMLGCAS1CQtQZj7YzosVGSQP7dUCBzfSKpIqJnh23XI=;
        b=cmG6Z1ct4qauIhsHrwK1Git9eXJWLmGaacGq3mXBF6EW0Ll7SXIN3IUE7rnWIL3Ixo
         zjERtmMeDh2dnlRkJiGE7JI2H7H8H0rhbUBS3ZnPd8UcZVRlfxgWiLfUt2j5WM4pIghK
         c/3Tzyx/sXSGW6KaMN5zNCerqiuf7tJMjBk/DRQn4CBAsy7q0qBk6pdOKloVmnV/2xXw
         q5teUfgjI5yoPuckDGv34EX0jtNX1gP0BUcY5jhe2FMEGlcFz46qGeFXBbh8bn5Ek3JP
         cX7caEa/Q/bYWrnCzU5mZdxtX8wollK0VIfA/3HBP0bHdKKPG1Vs37I1ARWYnyKWNyGn
         V3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uMLGCAS1CQtQZj7YzosVGSQP7dUCBzfSKpIqJnh23XI=;
        b=ANr77yGr5FowNUhF6bYqVzI3sXcdg9DCjsLgUded73rRzpBgnbMIia/I9sbTP4XHBY
         PQbAm88QG0xf9UjzZI8h7AYFfAQ5I1J3qfcJr02/fbvIRPk4z0UNuC/+/XlgVQGMIePO
         rz/ExY0FO+y13YHu4U5foqvNwTtpfu7YqlaA5W43MD/UGt2txQo/UGNldV2g4zXC4wvj
         p26dLvgEjO7DDf35MeUiO3Ou1LPRZa4DAJFD+NgWLHzGzNKujHCp8qJ4eM3EhFvNToPu
         76R0hOpA40RYdRmr0WQSjabhc07OKgb59Vq0mm2h7b6UlTiRMrE6cS6cEoJxV7fNxdwG
         EqYw==
X-Gm-Message-State: AOAM533OyKlf025MK2/5Ths9FxU0nbhGYWVhCBgR9bmeTdXGtFVSGqkU
        rOBoceC7Cjnaq3LhDao4S839AnHWXAvvV8ne5mbN91F+Zp402A==
X-Google-Smtp-Source: ABdhPJyego/jflHo1xHq9MC4kMYH9L/ajhIweYzzag9sjBLDCyvi0xc/5WOyKhQLEW10eCtsBXq6wSxKLJ5mIqy06sc=
X-Received: by 2002:a17:902:a406:b029:e6:78c4:71c8 with SMTP id
 p6-20020a170902a406b02900e678c471c8mr11617812plq.17.1619896472969; Sat, 01
 May 2021 12:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210501165314.511954-1-jic23@kernel.org>
In-Reply-To: <20210501165314.511954-1-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 1 May 2021 22:14:16 +0300
Message-ID: <CAHp75VefwPWqZfqCT0HmPgoer6_dvnR+VJ0mnOSvF-_tHqq4GA@mail.gmail.com>
Subject: Re: [PATCH 0/2] IIO: Alignment fixes part 1 - sizes too small as well.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Daniel Junho <djunho@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 1, 2021 at 7:55 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> I finally got around to do a manual audit of all the calls to
> iio_push_to_buffers_with_timestamp() which has the somewhat odd requirements
> of:
> 1. 8 byte alignment of the provided buffer.
> 2. space for an 8 byte naturally aligned timestamp to be inserted at the
>    end.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> As discussed previous in
> https://lore.kernel.org/linux-iio/20200920112742.170751-1-jic23@kernel.org/
> it is not easy to fix the alignment issue without requiring a bounce buffer
> (see part 4 of the alignment fixes for a proposal for that where it is
> absolutely necessary).
>
> In these cases the buffer is neither big enough, nor correctly aligned
> so fix both issues in one go.
>
> Cc: Daniel Junho <djunho@gmail.com>
>
> Jonathan Cameron (2):
>   iio: adc: ad7768-1: Fix too small buffer passed to
>     iio_push_to_buffers_with_timestamp()
>   iio: adc: ad7923: Fix undersized rx buffer.
>
>  drivers/iio/adc/ad7768-1.c | 8 ++++++--
>  drivers/iio/adc/ad7923.c   | 4 +++-
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> --
> 2.31.1
>


-- 
With Best Regards,
Andy Shevchenko
