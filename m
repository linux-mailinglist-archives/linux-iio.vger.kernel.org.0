Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E371D546863
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jun 2022 16:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349567AbiFJOcw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jun 2022 10:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349577AbiFJOca (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jun 2022 10:32:30 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87B515437C;
        Fri, 10 Jun 2022 07:31:49 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id g25so7354405ejh.9;
        Fri, 10 Jun 2022 07:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3+fVfsr56ZNJ1kBWhEwk9U5dk2NYN/r0Jkvc4FKoC3s=;
        b=MpnTpaZQ2mrRSxgivSG8oKX2lVNdrvs60JxH0aP5yhsBKEcONFGe56Yx/PxwQPNJMP
         gQqQsYQgHcK85aZJzVkzSQAzBW+01NSuOAPYyqmR7F/MpE6aRMYaGtk6/yx4P4pB8rMd
         gdd0a3fVJzguqbsgLNDxZZnooviKFIfNx6g1aCt1LA1JyvnK36ax4G4KBwAPsZq71tAp
         ugfPrviuOyQNHJmmruLMEwf6Dv5krmeogv9r/x1DoZ5ZMIcT22uXWnUF6bcBj9cIhvwT
         TOkeYklKqAyIcyorMrp0nJW8ojpl7PWMmEkRglIn6+VAGbTrldAy3k2CU2yBGacWhbTO
         aq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3+fVfsr56ZNJ1kBWhEwk9U5dk2NYN/r0Jkvc4FKoC3s=;
        b=KGQ5Lpr4rw9nRoEnNFSIXlW9e+eInMoKW1NixWlEXCXSC7pLXkPDpeXIthXnn3lDpR
         e/3OviLfJtgt6jukXPJneWXDgBMUk/I8cl3qPP6Ss26JBZ5MenSqQtNsScRyGlvqoN1p
         cfKxneR4rXXErvkFqn5JnSQkC7P9KaE1aBChsSo718a/6Sh9F9hCKvrzhewPP0DoiNNe
         yUqA6NBNfXcwOkMDlS0Q0NhZoYZKreZN55KcJVe4XZJcWxxhwZGjrmLN4/BNs/Kkl06/
         jfXKzxgqMeIZTtjhHug8a1WMwH5nYBlfcJ/8usWYCIstAwfZhkikOxfHJKZreCp3ulwq
         QdBg==
X-Gm-Message-State: AOAM532t/TAD0hDj/Ki1U3JlUmcMi/G6cXRbqYUPL5vN5Mf7UIvB0Qic
        e8z3E3peKUcUx0JgxS3WHH+ngCgaAlOCYTmNm8U=
X-Google-Smtp-Source: ABdhPJydggPrmBwsUxSYNblLfPfIBMZLyji/UAM4KEjCxFK5F2wy2msFrxmOaHx0xW/0II3DoX1y3LoNwlCuCKHHrDg=
X-Received: by 2002:a17:906:c7c1:b0:711:d2e9:99d0 with SMTP id
 dc1-20020a170906c7c100b00711d2e999d0mr22961166ejb.639.1654871507604; Fri, 10
 Jun 2022 07:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1654727058.git.jahau@rocketmail.com> <a914ca0ea6f0149cd2941d60ae6fa2f49927f66a.1654727058.git.jahau@rocketmail.com>
In-Reply-To: <a914ca0ea6f0149cd2941d60ae6fa2f49927f66a.1654727058.git.jahau@rocketmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Jun 2022 16:31:10 +0200
Message-ID: <CAHp75Vdg2i8NjrFn5gtKBKNbYrWd49nq31Exy=4K2RsxHeQ1hw@mail.gmail.com>
Subject: Re: [PATCH 7/7] iio: magnetometer: yas530: Add YAS537 variant
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        phone-devel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy
        Shevchenko <andy.shevchenko@gmail.com>," 
        <~postmarketos/upstreaming@lists.sr.ht>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 9, 2022 at 1:44 AM Jakob Hauser <jahau@rocketmail.com> wrote:
>
> This adds support for the magnetometer Yamaha YAS537. The additions are based
> on comparison of Yamaha Android kernel drivers for YAS532 [1] and YAS537 [2].
>
> Functions used by YAS530 & YAS532 only were renamed from yas5xx to yas530_532.
> Registers were renamed accordingly.
>
> In the Yamaha YAS537 Android driver, there is an overflow/underflow control
> implemented. For regular usage, this seems not necessary. A similar overflow/
> underflow control of Yamaha YAS530/532 Android driver isn't integrated in the
> mainline driver. It is therefore skipped for YAS537 in mainline too.
>
> Also in the Yamaha YAS537 Android driver, at the end of the reset_yas537()
> function, a measurement is saved in "last_after_rcoil". Later on, this is
> compared to current measurements. If the difference gets too big, a new
> reset is intialized. The difference in measurements needs to be quite big,

initialized

> it's hard to say if this is necessary for regular operation. Therefore this
> isn't integrated in the mainline driver either.

I understand that Linus knows well this code and may review this, but
can you please split register renaming (at least, maybe something else
can be split as well as preparatory change) to the separate patch?

...

> +                               regmap_read(yas5xx->map, i, &val);
> +                               dev_dbg(yas5xx->dev, "register 0x%02x: %u\n",
> +                                       i, val);

Please, drop all these value reads/writes debug messages, they are
quite expensive (by resource consuming), noisy (may spam logs), and
most important duplicative. regmap API has tracepoints, use them!

Perhaps it would require an additional patch to clean this up, if
anything like this is present in the current code base..

-- 
With Best Regards,
Andy Shevchenko
