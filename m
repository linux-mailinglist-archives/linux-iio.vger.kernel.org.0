Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C843367664
	for <lists+linux-iio@lfdr.de>; Thu, 22 Apr 2021 02:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344013AbhDVAjm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Apr 2021 20:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239761AbhDVAjj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Apr 2021 20:39:39 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DA9C06138A
        for <linux-iio@vger.kernel.org>; Wed, 21 Apr 2021 17:39:04 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id j4so29980249lfp.0
        for <linux-iio@vger.kernel.org>; Wed, 21 Apr 2021 17:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YtZuY+Qe3tPYFoELBmvxSJOd7sSfQjqqJhXvG/Slrwk=;
        b=Itbw7CndvF5ZKecqeCy8pddawQ6qg/Vl0A8SYW2+djcLLsGOvRxHR3O1pZW4p0rSuZ
         q9jShETfEwMuKX85xvCTIn4w98BR1G7Jmmy8zh3jaB5pu1EQBM+uvvWJEVV0uBw/xDtH
         eEIUXOmEl1xehACaVc6T4RTLFsx6i3k1aQIUPeRFR/CivpXT4VSSkLbkp6HZhAtfjerG
         blUSuuLcENqfKMI50mLbg9bgDFTKgbtayFnRtvQElnA41vftU2l8TXUpkuldJeqEeqxy
         y486OIMgN28IZJRzg6vraEqEzdR8agCzdK36K01U9SMHZqy2LBnrybMdb18NPYDtYOtW
         SmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YtZuY+Qe3tPYFoELBmvxSJOd7sSfQjqqJhXvG/Slrwk=;
        b=cNbPbxe+r62F4SViFbESrd6B2ju0dg7fhrAevhq7XpT2g1lRRgGYfV4c/ORGHDgPhh
         28M4xp7ynwuUGJMiBxCB4svhvek5Pgs6/1f0COsKbRKPXRMZpCOP0pBfzixyjQ5NfzoU
         vev6tp3oNz7AkmfvpwysMst32ujlNCTslFfQjS3v47jHXtZXYTjmjQ6flk0JIRFW9J2G
         f9X4aD2NcLrO6OgY/17bicYiUNEv28ubcHanpBBYcRNO5EKteZzqTv+7a8Cz3p/JJWEf
         k3m9O1wkA5Qw2rRlnjpEd3RlBb73y1/LrEdcRqhcLnzJVZe0W6wLzUd3huBq3sbwYywY
         QMUw==
X-Gm-Message-State: AOAM531wK98CiZPSuXz6ZT61XYbJgSrEJ0Vf7E/IhhFdqjmjnTPzTtRl
        vfq4HHJ/v7TbPfdCx6jXaZVnMaafp79uw0R6i3CJcA==
X-Google-Smtp-Source: ABdhPJzJMRjp/2v0gT0Psu0Qt1Ah73A49pOXUCbvI1fLocklY+PxwLeDkxSEqzCYYgbpLOVCppUc2MZB9h1jtatLRKU=
X-Received: by 2002:a19:c38c:: with SMTP id t134mr604670lff.29.1619051943391;
 Wed, 21 Apr 2021 17:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210421234820.32211-1-digetx@gmail.com>
In-Reply-To: <20210421234820.32211-1-digetx@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 22 Apr 2021 02:38:52 +0200
Message-ID: <CACRpkda_tfuXH=kE+SbY1BC1rXsYUkQigtkWQ8Dz29JX-SaemA@mail.gmail.com>
Subject: Re: [PATCH v1] iio: gyro: mpu3050: Fix reported temperature value
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 22, 2021 at 1:49 AM Dmitry Osipenko <digetx@gmail.com> wrote:

> The raw temperature value is a signed 16bit integer. The sign casting
> is missed in the code, which results in a wrong temperature reported by
> userspace tools, fix it.
>
> Cc: stable@vger.kernel.org
> Link: https://www.cdiweb.com/datasheets/invensense/mpu-3000a.pdf
> Tested-by: Maxim Schwalm <maxim.schwalm@gmail.com> # Asus TF700T
> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Asus TF201
> Reported-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

+/- Andy's comments:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I never thought this driver would have so many users (3 people signed
testing it!) but I realize it is more widely deployed than I thought.

I have totally ignored the MPU3050's ability to act as a "sensor hub"
and talk to accelerometers and magnetometers directly. I always
thought it would be better to just route the I2C right through it and
put Linux in direct control, but I realize this was not Invensese's
intention. I don't know if it can be actually utilized in some generic
way, all kernels using that have separate hacky drivers for all the
sub-sensors duplicating the kernel drivers we already have ...

Yours,
Linus Walleij
