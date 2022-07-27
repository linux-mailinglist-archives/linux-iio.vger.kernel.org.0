Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2559458326B
	for <lists+linux-iio@lfdr.de>; Wed, 27 Jul 2022 20:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237443AbiG0Sw0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Jul 2022 14:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234515AbiG0Svf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 Jul 2022 14:51:35 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EAB8C5BB;
        Wed, 27 Jul 2022 10:47:25 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id a89so1699075edf.5;
        Wed, 27 Jul 2022 10:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V0L5AWHt0bV3SDhHbsVIxSbM57Z8DP+iuEiLSXmQC/I=;
        b=P3Xamf3U2iZYskFha2ONWfAztZxdzgk599C944EadcyaJTY7OPo9UVU3gQrqs7qYid
         45yznp+KLx/lYwFgQAziKJCmJrsPQgXbCy7fVTgWsLLJO41AV6DA2gTGkOlPb1VHWB9+
         PpJQKdYRm1TbR9BZhNoV1tqnroU082DC6yIPmXW7SLzIfAQDTMcOymQUC4X5nZjLd7Dv
         3JDmdiBUa0YyEKzzSjEkpkPTfYxwsNrmntEq5VtyZ359M4TtToqaQevNsWHVJPGjH5uC
         ADh9Unx0UCH96ombieMmf/K4BN60gT9KQbqB/gK+NZwjEsikREzPzWJAmr4Ujm0iFRYb
         HzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V0L5AWHt0bV3SDhHbsVIxSbM57Z8DP+iuEiLSXmQC/I=;
        b=P/mA+wZIpBKOIHzu5yi7E7RsTdv2oooJCjIwp2hUk1no/IJOQEZfahyS3dcS/yLLVi
         eAOkE6pWLwWJHrmMIXaBTHYyO+DJ7kwSczV8q8Ykq+U7Q1EnqYVt26e0SZ4qKmPjfmlc
         uN0iiQOaI8esaShu5JBVB65iS2Y/1Hwa4mxlWD5TIi9xHoVlP0PYRfW1e68cEqj+8D63
         MJbOfxnJhcnwwlY+cVYYt1kEsUXH0diozKdy8lDiZRU9LzJedBPuquX083o+oMT9jCGP
         h7rN6Is1+HMOSOxHxuuWUL8bHI02IMovp++fyWODMbDEaKVO6Nnhuq1BAljjF6+4jh5B
         X/0Q==
X-Gm-Message-State: AJIora+/ZZ5Hwy5faY8s0qhNl5ABHoi/Zu7lt7hDxLP3mPZp4mk9HuVK
        eY8+Q2lxwJpwefexZPQHDS3Q2okmvPv6gPYZMlrDdznCks0=
X-Google-Smtp-Source: AGRyM1taB1Rzispj7fe1jzGdNDhaQPG5/zfR5i4V+fBBpub8fw8SGHgMFoqsF+99hdbVByyBHK+F8F9mxhHvQN0TktM=
X-Received: by 2002:a05:6402:4414:b0:434:f58c:ee2e with SMTP id
 y20-20020a056402441400b00434f58cee2emr23803215eda.362.1658944043438; Wed, 27
 Jul 2022 10:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656883851.git.jahau@rocketmail.com> <69a512cf5b62b34415d5983a6406c3d5ba438a1d.1656883851.git.jahau@rocketmail.com>
 <CAHp75Ve5Z9OOx94FtXY77_Fwkp27D32Hn7bAG+Da++HXmupytA@mail.gmail.com> <c5643cee-8491-3fae-b9d4-ac03d86c1e8a@rocketmail.com>
In-Reply-To: <c5643cee-8491-3fae-b9d4-ac03d86c1e8a@rocketmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 27 Jul 2022 19:46:46 +0200
Message-ID: <CAHp75VdDdKo7rt+cik4J+_4tDRgBXhgZYc8p+dOSH4s_gtCOUg@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] iio: magnetometer: yas530: Add YAS537 variant
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

On Wed, Jul 27, 2022 at 12:13 AM Jakob Hauser <jahau@rocketmail.com> wrote:
> On 04.07.22 21:47, Andy Shevchenko wrote:
> > On Mon, Jul 4, 2022 at 12:05 AM Jakob Hauser <jahau@rocketmail.com> wrote:

...

> >> +       /* Write registers according to Android driver */
> >
> > Would be nice to elaborate in the comment what exactly the flow is
> > here, like "a) setting value of X;  b) ...".
>
> Unfortunately, I don't know more than what the code already says. In the
> Yamaha Android driver, this part looks like this:
> https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas537.c#L345-L350
>
> The comment "Write registers according to Android driver" actually says
> "I don't know what I'm doing here, this is copy-paste from Android".
>
> I can remove the comment if you find it inappropriate. Though from my
> point of view the comment is ok.

The comment is okay for you, but for me it needs elaboration. So,
something like above in compressed format (couple of short sentences
to explain that nobody knows what the heck is that) will be
appreciated.

...

> >> +       ret = regmap_write(yas5xx->map, YAS537_ADCCAL, GENMASK(1, 0));
> >> +       if (ret)
> >> +               return ret;
> >> +       ret = regmap_write(yas5xx->map, YAS537_ADCCAL + 1, GENMASK(7, 3));
> >> +       if (ret)
> >> +               return ret;
> >
> > Can bulk write be used here?
>
> Technically yes. But in this case I strongly would like to keep the
> single regmap_write as we go through different registers step by step
> and write them. That way it's much better readable. And it's just these
> two that are neighboring each other. As this happens in
> yas537_power_on(), it isn't done very often, thus doesn't cost much
> resources.

You seems program the 16-bit register with a single value, I don't
think it's a good idea to split a such. When it's a bulk write and
value defined with __be16 / __le16 it makes much more clear what
hardware is and what it expects.

...

> >> +       /* The interval value is static in regular operation */
> >> +       intrvl = (YAS537_DEFAULT_SENSOR_DELAY_MS * 1000
> >
> > MILLI ?
>
> What do you mean by this comment?
>
> The suffixes _MS and _US were proposed by you in v2. I think they are fine.

1000 --> MILLI ?

10^-3 sec * 10^-3 = 10^-6 sec.

...

> >> -       ret = yas5xx->chip_info->measure_offsets(yas5xx);
> >> -       if (ret)
> >> -               goto assert_reset;
> >
> >> +       if (yas5xx->chip_info->measure_offsets) {
> >
> > This can be done when you introduce this callback in the chip_info
> > structure, so this patch won't need to shuffle code again. I.o.w. we
> > can reduce ping-pong development in this series.
>
> I did this change in this patch on purpose because it's the introduction
> of YAS537 variant that's causing this change. YAS537 is the first
> variant that doesn't use yas5xx->chip_info->measure_offsets.
>
> Shall I move it to patch 9 nonetheless?

It's a bit hard to answer yes or no, I think after you try to resplit,
we will see what is the best for this part.

> >> +               ret = yas5xx->chip_info->measure_offsets(yas5xx);
> >> +               if (ret)
> >> +                       goto assert_reset;
> >> +       }

-- 
With Best Regards,
Andy Shevchenko
