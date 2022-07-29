Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501B258532F
	for <lists+linux-iio@lfdr.de>; Fri, 29 Jul 2022 18:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237207AbiG2QI5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Jul 2022 12:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236390AbiG2QI4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Jul 2022 12:08:56 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5413E88CC0;
        Fri, 29 Jul 2022 09:08:53 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id rq15so3328945ejc.10;
        Fri, 29 Jul 2022 09:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=6JrbP87qPML6gdz0M7zzqoCICKgMk1yhSuaXzOlt+r4=;
        b=jCeB1he7guhO6KaegICp7gQBT9+y6lVHo9UWhFxN/kh2mSa+KstiJJMo0EdZk0IA3j
         11aEOqIqIhnF5gQNFJoTFV6jmgL6o8SAL3W9TC3WyoUeVfHedxSuxviHeV41YgGIbK9H
         /1SWoOK4enWBNlOnLT774oqTw8S9LRKzlL/RI01nD0nil2XaY+ROyliSlJEVVVH/mVEU
         9YQ5RnIR3jFQJUd/qIYu5dHBQV3bextUly+L5WcbXje43LabWIqCGdXMfuspR2Lgg6KD
         DHbwIBvVIiZTzHy7EY4b644zTh/y8XETwNKOOoXvtMMEkFmN7Plh+CY8G8Bbp6pIJYfz
         gmWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=6JrbP87qPML6gdz0M7zzqoCICKgMk1yhSuaXzOlt+r4=;
        b=AsztvBfv6wgfa/41p/LSoDwdi8dCRdT1AVrpZpGamfHMzvwfcE+84MBMHcPwPLbsuu
         gIbtmVHOQoceDuRZ25s9+wPR0z+QVI+g3WNGyTeew5QBEnMTnv0voI93OwtWgkc+3Gk1
         xYyKyqPx37t7xmxjGtyZwJwigwNNFySLYBFiVdJdZHNfyETnScfddaLl4BLSJB1L5OWK
         23ly6Qq/5pH9FvV8ATVddvfA3ZkCb0SYCa0IgXg2Vp27TePdDarIuHcHcuOZnaTTnAOj
         T5b6411X2rB/FTK4Gmd3Sw4JvwoS55JydoYE4fTEbWrkqmQCHgdYIkrRWurcmSUwkfz6
         GFUQ==
X-Gm-Message-State: AJIora9/5FsSz/ZWmtNzpYQko2blmjlim+odWQV0kUkrsVdDKBrKeZiH
        LWDWTFtl2t/t3cxFwjpEubERozTsYvCoThifsHQnES1NXWo=
X-Google-Smtp-Source: AGRyM1sCzErWIkVt4KAg8gNL8hv8TT2TmEaXsHBiOYWKLPzQ/Eud17aZEiLaHPjit4p/EdW9KNpViEOqKpQ4cyaJTPE=
X-Received: by 2002:a17:907:c06:b0:701:eb60:ded with SMTP id
 ga6-20020a1709070c0600b00701eb600dedmr3538217ejc.178.1659110931590; Fri, 29
 Jul 2022 09:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656883851.git.jahau@rocketmail.com> <28a2a9ec27c6fb4073149b897415475a8f04e3f7.1656883851.git.jahau@rocketmail.com>
 <CAHp75VfGqk_q1iDyj06tEuTNoG35xjOL0_5HgokFauUz_aAwFQ@mail.gmail.com>
 <8639301c-ae9e-54ac-919d-baeb8760a31b@rocketmail.com> <CAHp75VecjLe67XfK6qgM4eZfKiTJ-UabD40i6Q_YmMpyWAWMkg@mail.gmail.com>
 <c52e34f1-1cc3-4351-e03b-6b9bf83481b6@rocketmail.com>
In-Reply-To: <c52e34f1-1cc3-4351-e03b-6b9bf83481b6@rocketmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 29 Jul 2022 18:08:15 +0200
Message-ID: <CAHp75Vc9cYNOTmpr+NeQQEUVtkL6hnsjToiMBa2_NGnr2zuFtQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] iio: magnetometer: yas530: Introduce "chip_info" structure
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jul 29, 2022 at 1:06 AM Jakob Hauser <jahau@rocketmail.com> wrote:
> On 27.07.22 19:39, Andy Shevchenko wrote:
> > On Wed, Jul 27, 2022 at 12:01 AM Jakob Hauser <jahau@rocketmail.com> wrote:

...

> Instead I end up at a longer comment again.

It's fine!

> Though this also offers the chance to add some additional information
> where the values were taken from.
>
> Is it appropriate to include this to kernel doc? Generally I'm unsure on
> kernel doc but I guess yes...

I'm unsure if it's appropriate for static (integer) arrays, you may
run kernel doc script yourself and check man, html and pdf formats to
see if it's rendered correctly.

...

> > Again, you are the author and my point is just to make you look at
> > this from different angles. If you see no better way, go with the
> > current approach, but just spend a half an hour and perhaps we may
> > have a cleaner solution?
>
> Indeed, to my own surprise I found a solution with the 2D array:

It looks better!

...

>         dev_info(dev, "detected %s %s\n",
>                  yas5xx->chip_info->product_name,
>                  yas5xx->chip_info->version_name[yas5xx->version]);

Very good!

-- 
With Best Regards,
Andy Shevchenko
