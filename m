Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A00550D92
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jun 2022 01:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiFSXYV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Jun 2022 19:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbiFSXYS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jun 2022 19:24:18 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403BD64DD
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 16:24:17 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id y19so17944620ejq.6
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 16:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VHt4iXf9wPUSIJ1DU4CegV9U7JOG+R9nPN1pzuPhCaA=;
        b=Hol9lRUXLU+7qz4FH7JLlWb8qYB4+I3c+FFrlZHBLt7xcjVqTBNUYk5Ffvv4lcncAs
         pNlOeTPYnfQFHUKxXrOJu3IpcN2fK47Oz8oxby6pATsQXP6zP1X5k5ydtQYkpVxS5eGx
         xuQcmjcAmq/j2IoPZkAjsJSEWfBIt2pCF2/bv4DdWrcutXTR6qyDR9lISkZBuRqZTDlk
         1cS/DlkXBHj4a7gCRFb6pmnGNF8vw220t6n1zvlMBkvfwL/hWZ4RQSanGTdiB9+bPhFW
         1gGnBRNsbz3l+LajyTVFoSFINy/l2Om/wE5a/gweZMS+E73vgPcBMc2xpkl3enuhnJns
         u+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VHt4iXf9wPUSIJ1DU4CegV9U7JOG+R9nPN1pzuPhCaA=;
        b=LilitGVJRASFbcTNKZvySMYdOMmMrmHLTAq0ZYKrgpbA1Exe7hhfkj6jHI2HhZCChr
         lgD2CA8JppnRtGWf6sTznlr3nXiZV7m5usFoK+d3LRjqQxxEgg/uhkn3lzyjOP5ALxXT
         J5zDr7OdlfPK91XUKXA+4uHSn7EUIm1YIoVeGNfjVT5ta29+FpRgLIwb+5WgaQiOncjt
         NiG4hLzPykOeaj69cqh2Vdr3TQ06OrM3Z4RP3iN1c7GQrsB5WzX/Ob5PZ/ajOUbXbVcS
         6kw4vS4c2lenFI1ElE0NITXwX3Po89f/2u3HgSRGmYFZ2EFdM0dxbtqsTUmUWp5DArsd
         c3Ow==
X-Gm-Message-State: AJIora9gNadKxPEAan5cvPGFYZmoqE1vMnNL0pZe2dSta1qYLsyh9K0f
        TN+oqHG3O5BqXw1r4qVE+0bwLmuUY3zC3QWVwEw=
X-Google-Smtp-Source: AGRyM1v38KuWvM/qRUW26QhDZdRDMYg16unUZaUj6mstttkJ0OUum4Z1YM9LqxdxTdTu3AvorFshzeQdX4f230p8gyc=
X-Received: by 2002:a17:906:d9d9:b0:710:f2ae:b455 with SMTP id
 qk25-20020a170906d9d900b00710f2aeb455mr19102905ejb.77.1655681055834; Sun, 19
 Jun 2022 16:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220619185839.1363503-1-jic23@kernel.org>
In-Reply-To: <20220619185839.1363503-1-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 20 Jun 2022 01:23:39 +0200
Message-ID: <CAHp75VdjNuXeNPsjV4owGt5yg9N9kN8iYMKUX8rn=PRFpLKa+A@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] staging/iio: Clean up AD7746 CDC driver and move
 from staging.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

On Sun, Jun 19, 2022 at 8:58 PM Jonathan Cameron <jic23@kernel.org> wrote:

> Vincent: I'm getting some instability with roadtest after forwards porting to
> current mainline. Tests run 'sometimes'.  Other times I get a crash
> in um_set_signal.  Seems unrelated to the test this series adds.
>
> Changes since v1: Thanks to Andy and Peter for reviews.
> - Use sizeof(data) for be24 buffer data[3]
> - Make the precision patch fall back to old maths if overflow would
>   have occured.
>
> This started out as an experiment with Vincent Whitchurch's roadtest
> testing framework [1] and that worked well so I carried on cleaning up the
> driver.
>
> Mostly this is standard tidy up, move to new interfaces, then move the driver
> out of staging, but there are a few other things in here.
>
> 1) Precision improvement for IIO_VAL_FRACTIONAL_LOG2.
>    The ad7746 is a 24 bit sensor and this highlighted that 9 decimal
>    places wasn't enough to keep the error introduced by
>    _raw * _scale from growing too large over the whole range (I couldn't
>    write a sensible test for it).  So I've proposed increasing the precision
>    of the calculation used to provide the sysfs attributes with this value
>    type and printing a few more decimal places (12), but only if overflow
>    will not occur due to val[0] > ULLONG_MAX / PICO
> 2) _inputoffset ABI addition.  This driver had an odd use of _offset for
>    the case of differential channels that applied the offset to both
>    of the differential pair (hence usespace shouldn't not apply it when

userspace?

>    converting to the base units. That isn't inline with the existing
>    documentation for _offset and it wasn't clear to me that it made sense
>    at all.  To avoid confusion I've added this new ABI (_inputoffset) for t
> 3) roadtest file - note this is not a complete test set for the driver and
>    mainly focused on the main channel reads and places I thought I might
>    have broken things whilst working on the driver.
>
> My conclusion on roadtest - Very useful indeed. I'd encourage others to
> consider developing some basic sanity tests for drivers they are working on.
> Hopefully my python code isn't too hideous to understand at least!
> Vincent, it might be worth thinking about some generic code to handle the
> 'variants' on correct ABI like I introduce here because I switched from
> a shared by type scale to an individual one per channel for the voltages.
> Both were ABI compliant so that sort of change is fine most of the time
> though we have to be careful with it.
>
> All comments welcome.  Note there may be changes that make more sense
> to do after moving this out of staging as long as there are no ABI changes involved
> etc.  Feel free to highlight those sorts of changes as well as anything more
> significant.

Overall it looks good to me. One Q though, do you plan to switch it to
regmap APIs?

...

>   staging: iio: cdc: ad7746: Drop usused i2c_set_clientdata()

unused

-- 
With Best Regards,
Andy Shevchenko
