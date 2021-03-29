Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5FA834CEE9
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 13:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbhC2L1i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 07:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbhC2L1V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Mar 2021 07:27:21 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80083C061574
        for <linux-iio@vger.kernel.org>; Mon, 29 Mar 2021 04:27:21 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id s21so5853698pjq.1
        for <linux-iio@vger.kernel.org>; Mon, 29 Mar 2021 04:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fea0T+kp9PJm2F7JvXw9i7GBNgxMnOXjaSH/51wmHB4=;
        b=Ay2kxv4od9DwFAbmppq7qXTFRd2Xps4rWruPGQGPdluGlfH8SqHg4iFIMWGt35o5Tv
         ftChp40/VP3L166ALQf2pj8VAOO0McDLuhpl4XFNGO1Kl9ufpftBFwQfrAsn9rkV1cuV
         65AC0D2tBaAoXj4tiGLNJ4WInxciOxiNs5elwG3nEwszS7Enpcocvulh4+Whskfxwoky
         ekJB4PzI1Qd+NHT9EqcvCwzdakQIJzjflY0GbSn3CtPWUe+qIib88LXYUiP1UEgyqAPs
         GzdugDHqc8Rmxa+zt6TMC/GdcYuebtfSxq9QbpasNezGLaDcTUeHMkTVO+jkLVCcw5Tc
         p3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fea0T+kp9PJm2F7JvXw9i7GBNgxMnOXjaSH/51wmHB4=;
        b=khUVRcg1zgGJJgwUQIMP3LNBlbW5YVgS/ssUfz0DbiQbhxPVUrWVX7mUMknF1akch/
         vLm8qHrUPtJwI4YRaywmoYJjt4Jl7QfGbJT171TfYooiiLFR9uuSDGTBqaSKlqF66Zh6
         CsvvWvTz20H2Vd+K1fpQPgVtw8GjUVZ9h/XGJ9m2w1qgcQa8Ny9WZU0a7imriy3N4zS5
         dyIIatc3FJ6nTS+ROB/KyLOvdgOBe93qXAZVBpUoMZJAtmEhnCfBcN+pl++dFgc/J+uX
         bzPcwhGO1YPISW0ssg/2djwhQPxAzQ2wFmmbdSJDkPjlFDvIU8kDHTqPLuZebTTc1aBs
         CSxQ==
X-Gm-Message-State: AOAM5324bz516vLBZOEnJeSfxVubodxbbP7xutBVcTuI15amSrRb/Zrc
        2zBchP3D4nReECGvTITtIVyQCXGOJeEpsBvRtLA1g2iLGj1wRA==
X-Google-Smtp-Source: ABdhPJxnLYo4WJ632UDHZOHO4gYTortFCtwccCeqqDklTnxZ8ZTCs0xV267JflJpU5AAXyDMTUvPKNjFLlh8Lg9kA8I=
X-Received: by 2002:a17:90a:b311:: with SMTP id d17mr26639750pjr.228.1617017241104;
 Mon, 29 Mar 2021 04:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210320071405.9347-1-lars@metafoo.de> <20210320071405.9347-5-lars@metafoo.de>
In-Reply-To: <20210320071405.9347-5-lars@metafoo.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Mar 2021 14:27:04 +0300
Message-ID: <CAHp75Ve2Xv8RzxdYWjq7=RL3zQSSd1fo4__NWkk8DL92y7X9PQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] iio: dac: Convert powerdown read callbacks to sysfs_emit()
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>, Joe Perches <joe@perches.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Mar 20, 2021 at 1:26 PM Lars-Peter Clausen <lars@metafoo.de> wrote:

One side note for the future improvements.

> +       return sysfs_emit(buf, "%d\n",
> +                         !(st->pwr_down_mask & (1 << chan->channel)));

> +       return sysfs_emit(buf, "%d\n",
> +                         !!(st->pwr_down_mask & (1 << chan->channel)));

> -       return sprintf(buf, "%d\n", !!(st->pwr_down_mask &
> +       return sysfs_emit(buf, "%d\n", !!(st->pwr_down_mask &
>                                        (0x3 << (chan->channel * 2))));

Converting above to use BIT() / GENMASK() will help to avoid potential
UB when it will try to set the last (31st) bit.

> +       return sysfs_emit(buf, "%d\n",
> +                         (bool)(st->pwr_down & (1 << chan->channel)));

> +       return sysfs_emit(buf, "%d\n",
> +                         !!(st->powerdown_cache_mask & (1 << chan->channel)));

...

> -       return sprintf(buf, "%d\n", ret ? 0 : 1);
> +       return sysfs_emit(buf, "%d\n", ret ? 0 : 1);

Useless ternary, may be ret == 0 or !ret. (Yes, I know that compiler
optimizes this away)

-- 
With Best Regards,
Andy Shevchenko
