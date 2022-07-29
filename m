Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D75585471
	for <lists+linux-iio@lfdr.de>; Fri, 29 Jul 2022 19:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237691AbiG2RZD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Jul 2022 13:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiG2RZC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Jul 2022 13:25:02 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B0F804B8;
        Fri, 29 Jul 2022 10:25:00 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id rq15so3676516ejc.10;
        Fri, 29 Jul 2022 10:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=4laNZAtM9UQoK50hUrsnaSLB5COXOVPbe4bGdepdqVU=;
        b=UxwBq8wKonDiuUeC+zkaHsJkUzaI5gHDzBbRwDRlaU8AOn8uBzLMFaJazquPzjKTXe
         6qOKfevoLn9s25oPDPxdXhdnJDCsYALd5VZZRhOJvX/RronE8G9fxDqKXWKRVTy93pBR
         Gd8FovFFduSbJVDvZ6fcdqEi9wCZR/BLqWp3MDTaxU9m7EE0FYV00jgo2fc9r+qi9iic
         ESBON2eTTprRhA7/cSin2mSEUYpaGLvGxEInbaEBJXZzPllOHbkE8qw2QHxCc3AiPn+E
         aABFYTPBINPd8lFo42enzoe8fLRLpcCu0snsqSEMkPkqenVxSFy4Wtx7392QVVClFn7E
         broQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=4laNZAtM9UQoK50hUrsnaSLB5COXOVPbe4bGdepdqVU=;
        b=r30z9oWc2Ovklc+BKLmiuY2Oe5OLJu8Jo3QS0PUtLTXiNdXbn345st0F6phaTwhFuX
         BuFkOqFeKTKfW1cKTT7LPDhu00P4HriTA45g5K2QhWiCsnlEeO6imDvQVVertgmp8cYZ
         1S6cynutSVttlol1/ztosY5k5V3QtIeVy1DjVoNobgC7Gnk4FDv6aFcJ3ZVZZwrD3dAw
         M/o+T/dI1LK7fUB/S1qS+9COz3tNS80kUC8RHJ4vYWqTeSY+jYdvFlA4oMrGdaCLShaT
         MCDQvBDrEagH/RrBBxh/ADBFCQjDuwEpAaSkLOgiQyrxP1gj9+Ndwuz+PnEsNkVrFyyy
         gQ3A==
X-Gm-Message-State: AJIora9aG/AO/JccUj4uHaUwSVWRLUrjE2uVjB9IVHI0yUHUxHeDoLtZ
        S/rkj+LkvuyrcrLVc9Hxug1z5qLvND+NqWYbEvo=
X-Google-Smtp-Source: AGRyM1sLjJrYRIgEttBfvVKsd+UfoYSq5qmowbj6dggBNYAFIwODMnP04L8c9lv2xErVuN5N00AjyYhAtJL/UF1yfyQ=
X-Received: by 2002:a17:906:9b14:b0:72b:313b:2df4 with SMTP id
 eo20-20020a1709069b1400b0072b313b2df4mr3606230ejc.99.1659115499099; Fri, 29
 Jul 2022 10:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656883851.git.jahau@rocketmail.com> <69a512cf5b62b34415d5983a6406c3d5ba438a1d.1656883851.git.jahau@rocketmail.com>
 <CAHp75Ve5Z9OOx94FtXY77_Fwkp27D32Hn7bAG+Da++HXmupytA@mail.gmail.com>
 <c5643cee-8491-3fae-b9d4-ac03d86c1e8a@rocketmail.com> <CAHp75VdDdKo7rt+cik4J+_4tDRgBXhgZYc8p+dOSH4s_gtCOUg@mail.gmail.com>
 <6e13daf2-179f-d37f-ace4-db5cd37be8d3@rocketmail.com>
In-Reply-To: <6e13daf2-179f-d37f-ace4-db5cd37be8d3@rocketmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 29 Jul 2022 19:24:22 +0200
Message-ID: <CAHp75VdLBowZ7=6g4aFVr5zkN5Pkv7ir68vPCdkRmoFysqRz9Q@mail.gmail.com>
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

On Fri, Jul 29, 2022 at 1:13 AM Jakob Hauser <jahau@rocketmail.com> wrote:
> On 27.07.22 19:46, Andy Shevchenko wrote:

...

> /*
>  * Write registers according to Android driver, the exact meaning
>  * is unknown

With a period at the end :-)

>  */

> This reminded me of another location where I first had a comment
> "Writing SRST register, the exact meaning is unknown". There you
> criticized the part "the exact meaning is unknown", so I changed it to
> simply "Writing SRST register".

Yeah, but that is different, SRST seems like easy to deduce to "soft
reset" (taking into account where it's programmed in the run flow).

> Accordingly, I would choose the following comment here:
>
> /* Writing ADCCAL and TRM registers */

Fine with me!

...

> > You seem to program the 16-bit register with a single value, I don't
> > think it's a good idea to split a such. When it's a bulk write and
> > value defined with __be16 / __le16 it makes much more clear what
> > hardware is and what it expects.
>
> We don't know for sure whether it is a 16-bit register or an incomplete
> register naming.

By the values you write into it seems to be a __be16 calibration
register. The value to write is 0x3f8 which might ring a bell to you
if you know what other values related to ADC.

> Not all the registers are properly named in the original driver. E.g.
> there is a register called "YAS537_REG_MTCR" [1] with no names for the
> following registers. Further down, this and the following 11 registers
> are written by just counting up the register number [2].

12 (8-bit) registers, which may suggest 6 __be16, in any case looks
like a mount matrix or so, with X,Y,Z values programmed.

This is interesting as well...
https://software-dl.ti.com/simplelink/esd/plugins/sail/1.10.00.06/exports/docs/sail/doxygen/html/structyas537__t.html

(Btw, it also suggest that ADC calibration is 16-bit register)

> It looks similar to the situation at register "YAS537_REG_ADCCALR",
> where the numerically following register (0x92) doesn't have a name [3].
> It could be because of a 16-bit register, as you say, but it could also
> be a naming thing.
>
> At the location in discussion, the original driver uses two single
> writes [4]. I'd stick to that.
>
> [1]
> https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas537.c#L38
> [2]
> https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas537.c#L277-L279
> [3]
> https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas537.c#L37
> [4]
> https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas537.c#L345-L348

It's all the joy of reverse engineering...

To the 4100 denominator:
https://github.com/XPerience-AOSP-Lollipop/android_kernel_wingtech_msm8916/blob/xpe-11.1/drivers/input/misc/yas_mag_drv-yas537.c#L235,
seems you can find a lot by browsing someone's code and perhaps a Git
history.

...

> Still I didn't get your comment. Is your intention to change the "50
> milliseconds * 1000" to "50000 microseconds" in the define?
>
> It would look like ...
>
>         #define YAS537_DEFAULT_SENSOR_DELAY_US  50000
>
> ... though I would prefer to keep current define, as it is implemented
> now and stated above:
>
>         #define YAS537_DEFAULT_SENSOR_DELAY_MS  50

No, just to show in the actual calculation that you convert MS to US
using MILLI.

-- 
With Best Regards,
Andy Shevchenko
