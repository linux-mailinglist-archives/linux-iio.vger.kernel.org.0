Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1443F58C7D2
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 13:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242653AbiHHLs0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 07:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbiHHLsZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 07:48:25 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB735FB4;
        Mon,  8 Aug 2022 04:48:25 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id o3so4884722qkk.5;
        Mon, 08 Aug 2022 04:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=zIqDpdqnGlhD43JrBpe3UlPZJCsSnG6kUEyydwktWnI=;
        b=NOIvAaNxS7KILFcF3jsqSJp+xMRTETK4S8eIt0/TMyycywbhFlpMFjydJdKCqWQqNT
         n5TOdc6bc68Nrr/K401ttEHk/ZIJipwJVQTLtu9JaBvnWTn2+YkGTm1na8w3ysP8z1Sy
         mC5MB1t1h6coIQyP0p9AwRBBBErbmatX9zKBiSVJHDeC0RzYFm9JK5yhZ6gH5EZdBpu7
         8vM33jmNRE7yr781TuoKmJe9cPdXMS124Fq2+YLcHPF5Fg3MAlreAOZ9A2qTG5hyDEYT
         P7+LSUtZZ77cyI/uWlftOBV5Z7rCg3UJd3yP9ROxjNFD7Z4fquW2ZXS6OVe3+FgMLW3Z
         rcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=zIqDpdqnGlhD43JrBpe3UlPZJCsSnG6kUEyydwktWnI=;
        b=0Zw8zXxSc/46x6WT7OMW2ft5JGBpcRVrF8nTJtzs2ZQA805WK35pQuJejYGKFC5d2Z
         YFGoIohrXWjW5F1zFeSZ78t126hynlv+ZIFm9Yq9+6i2U/n6eUjY9f7mctfJmt1qeDt/
         LXZOzpn5DVkBVCzruHG7fU6tLn0xa0UGxSwSAQ94o3BfbAW3lPBwA5ubNn5GLNtKkAEh
         SwsY1inpchPIX4K+SpQZ4k1e+FrZyOJULl4TDAf/ztVHxf/keOMDx+oYFC3GTHeCKdmD
         Zz+VRyRgYbf5xWhH1xO6y+ZeyIcXjz2qt61tRXAAh1HZZvw0OITOKIyONPUe1m4NsD3O
         GIcg==
X-Gm-Message-State: ACgBeo3ArnGGn4vJ6uaaWaPCGEw5dtmofzfXNssNvyfsKBvPj/p8ZPsR
        lzYetMsmCkHX8iI7ND2ax8ioPCWoHwsuH0EzRn0=
X-Google-Smtp-Source: AA6agR7PrdQS2PvNBAr/cqXl12HZwDEHZHyClmVK4pF5hc2Bp5spaeBD+JXh3fF1HneDnTMsVmwVUgHwYinJjB7tX8g=
X-Received: by 2002:a05:620a:254d:b0:6ab:84b8:25eb with SMTP id
 s13-20020a05620a254d00b006ab84b825ebmr13618349qko.383.1659959304307; Mon, 08
 Aug 2022 04:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1659909060.git.jahau@rocketmail.com> <a7bc9d7a7bb12a76fb217a1709fb09abd2b45892.1659909060.git.jahau@rocketmail.com>
In-Reply-To: <a7bc9d7a7bb12a76fb217a1709fb09abd2b45892.1659909060.git.jahau@rocketmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 13:47:48 +0200
Message-ID: <CAHp75VegA6zzvQXEi_9-K3832o+j48Af3X8LivYY47Xav+w-xQ@mail.gmail.com>
Subject: Re: [PATCH v5 14/14] iio: magnetometer: yas530: Add YAS537 variant
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 8, 2022 at 1:12 AM Jakob Hauser <jahau@rocketmail.com> wrote:
>
> This adds support for the magnetometer Yamaha YAS537. The additions are based

Add support

> on comparison of Yamaha Android kernel drivers for YAS532 [1] and YAS537 [2].
>
> In the Yamaha YAS537 Android driver, there is an overflow/underflow control
> implemented. For regular usage, this seems not necessary. A similar overflow/
> underflow control of Yamaha YAS530/532 Android driver isn't integrated in the
> mainline driver. It is therefore skipped for YAS537 in mainline too.

the mainline

> Also in the Yamaha YAS537 Android driver, at the end of the reset_yas537()
> function, a measurement is saved in "last_after_rcoil". Later on, this is
> compared to current measurements. If the difference gets too big, a new
> reset is initialized. The difference in measurements needs to be quite big,
> it's hard to say if this is necessary for regular operation. Therefore this
> isn't integrated in the mainline driver either.

...

>         help
>           Say Y here to add support for the Yamaha YAS530 series of
> -         3-Axis Magnetometers. Right now YAS530, YAS532 and YAS533 are
> -         fully supported.
> +         3-Axis Magnetometers. YAS530, YAS532, YAS533 and YAS537 are
> +         supported.

So, after this change the rest become partially supported?

Perhaps you want to leave the original and add a new sentence like:

  "The YAS537 is partially supported."

?

...

> - * For YAS532/533, this value is known from the Android driver. For YAS530,

It seems this comma is unneeded in the original comment.

> - * it was approximately measured.
> + * For YAS532/533, this value is known from the Android driver. For YAS530
> + * and YAS537, it was approximately measured.

P.S. Do you see now how your series and the end result become better?

-- 
With Best Regards,
Andy Shevchenko
