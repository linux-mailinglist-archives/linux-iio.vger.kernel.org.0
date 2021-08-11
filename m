Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECCF3E957D
	for <lists+linux-iio@lfdr.de>; Wed, 11 Aug 2021 18:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhHKQFM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Aug 2021 12:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbhHKQFL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Aug 2021 12:05:11 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B2FC061765
        for <linux-iio@vger.kernel.org>; Wed, 11 Aug 2021 09:04:48 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id k2so3258664plk.13
        for <linux-iio@vger.kernel.org>; Wed, 11 Aug 2021 09:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LCN7bU5G9ZHsL79ejXTb1wITEAeEVwbuPWV5Wx3qO9s=;
        b=vSfoIPu7VtLaOF2LVw1MEWtU4gQjFrryl63Fygjha44mx2fcu2RprJqcCR1GKrC0yB
         yZ7e+Odz2OkDxhZA9cElFEiuSqJ/gU5gx1RPGnkJpfainLJpVy8ZyhpJaqW0KTzkFDNL
         L35SQ3F2Tv+EHaOgRl2gMh2XngVrDaufuu+BGn+swdULQKT9d9QdzisqfkiUPxky/hZp
         VAkbThnkeTkY8Kh0Df0WsJWSAFbwc3Qq9aoOTh6GJ8gzlDsYOfTPljcjsApyH9+UrsdO
         HNXKy4Dwn+o7daxAu5xHva74wBXaNuzAxxfvEfWjukTvWBKTy31XiXs+5dSZrHjCbdeP
         iONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LCN7bU5G9ZHsL79ejXTb1wITEAeEVwbuPWV5Wx3qO9s=;
        b=pSdHVe7fOOvbSzC4As1lNVFgT3IkN0nWnbFWJB+v9b9OPTnE5DProwPk964vOnLLQ/
         x2wWW6wDVV9kB4oqXlVbbvdEQA2YIAGf3NQfC8SXW5K5BvitTLzbv5+WqwOg4kfHIYhZ
         PoSuz1V6pOEoZMRl/nMB3CGLeUOtBYAc+ITW9xLYiQyNkxlyj9Q4CArJOX1OlxF5/mVS
         fhDhldaC9hASU993LOsuMBsEKRccAn/OHE75gVBTNbH665uvBNb9cgx/J5SWxo73hRMg
         K144egewNX+WKkVx6YrGXOc6Jd5lXEsCnlpdxFldjiZsEwxs8a95m66u4qb52g20NNIQ
         +5EQ==
X-Gm-Message-State: AOAM532mgbKxyz5TQaZScTRYDFnDyfcwW6dgaGlbKeoIZaH9pwjBDkm9
        aGnMfDSTzMzDD8olzXYPqkxNpNmVArAw0/MRyN4=
X-Google-Smtp-Source: ABdhPJxIhKvjjB2k0wNsZ1EDeAPc3olDW6xsopnIsU91En48N4mFyk+qLsF2n+l2fJ7NHAZbDfCewDq5duP4gT0l6Y8=
X-Received: by 2002:a17:902:e786:b029:12d:2a7:365f with SMTP id
 cp6-20020a170902e786b029012d02a7365fmr4803344plb.21.1628697887381; Wed, 11
 Aug 2021 09:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210811074827.21889-1-nuno.sa@analog.com>
In-Reply-To: <20210811074827.21889-1-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 11 Aug 2021 19:04:07 +0300
Message-ID: <CAHp75VeLfxyLG-zTdVVnwB+PR2v=LW-PcvM4ZkEoLq+Ht0-iCg@mail.gmail.com>
Subject: Re: [PATCH] iio: ad5770r: make devicetree property reading consistent
To:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 11, 2021 at 10:46 AM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>
> The bindings file for this driver is defining the property as 'reg' but
> the driver was reading it with the 'num' name. This patches makes the

"This patches makes the..." --> "Make the..."

> driver consistent with what is defined in the bindings.

While it seems okay, it may be now a chicken-egg issue (somebody
created a DT with "num" property).

--=20
With Best Regards,
Andy Shevchenko
