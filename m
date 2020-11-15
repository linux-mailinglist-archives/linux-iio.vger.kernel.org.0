Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1F02B3498
	for <lists+linux-iio@lfdr.de>; Sun, 15 Nov 2020 12:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgKOLVy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Nov 2020 06:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgKOLVx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Nov 2020 06:21:53 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033A5C0613D1
        for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2020 03:21:52 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id u18so20544899lfd.9
        for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2020 03:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JuoFcYRzxno1R+mkSa3yuiT6ppL1chVX5uyk3tVh8gQ=;
        b=mGtyVlmA/USdL7vLnh/hFxtTylKNdRE/mqJkMu3AduYwrcQXXAISdOcZwzI62Fe/Sm
         muZioa0I6tRWvp71rTurhbeOvKyPTpzjwQ7stKTTxpqTy57NgWb/vzcivWizjMPGrUwb
         3qCRAsoC5M7n5mf+Ll4YfKamRbfjVk+dUc9ejKTS99HHUMzS6Jr1qfZfvYAOfbNF3kKd
         uz+uyIheH6Yn3Bn2FQ8T8Uqr5G2zypMK+9Ej3ypXkmbRtvtqOpX68mtIPgwfHtAe1ai7
         H/EUAvf/Ah+x5iLureoT3ooDMzJEPMIxZ+IOWLoIlffx4cCjZM3DAk604taFu/egwQ5N
         gsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JuoFcYRzxno1R+mkSa3yuiT6ppL1chVX5uyk3tVh8gQ=;
        b=MHe9ABZznZNpd95MldLJpDTEskL/yh3sGZJvIM8k36tMaszjHKQMaAag07jmfm+WEi
         HD7JBGxbDxcwqD82shJqCXA7+XDkX4HMrDZ8tkOh3wvSU3UQ/SVZQdiF98Rn9ptiqOod
         YlMA/WUNvI0v5x9ZtV5X0d0WDf90XiNEqSBhUGpdelq7la30rnL/TjO125sQUfp7V6/D
         Vg4DWgJPZmddFrJuCs/cUcTBxf8o2ZAtT3Ol4e9HKxIb0K/RhkmgEJEifw3oMWfrRAsl
         8EMLUGabYEmT23ddEnfWLFgnYZtiw+0Ptqcci91HCyLvt4kCZU7bYpnDH6Ph5mu0AXf6
         Ofbw==
X-Gm-Message-State: AOAM533LW5Lsort+DnH02j/TX0KW2XXUARbpfUO3BAxP9sw688esRY4/
        Ks+EHZ/3utLN7sEJiNk9uUqY7GBjbWd/t7/7F9uwHHxOZx0=
X-Google-Smtp-Source: ABdhPJzTVSnIDWWb2P/8VzPwLvlSefKPQY1AyURuL51r56wqLcwmUemArGmlUONaHiYH1jhpXbQZH367C4irW5tRdKI=
X-Received: by 2002:a19:8686:: with SMTP id i128mr3572485lfd.333.1605439310461;
 Sun, 15 Nov 2020 03:21:50 -0800 (PST)
MIME-Version: 1.0
References: <20201101232211.1194304-1-linus.walleij@linaro.org>
In-Reply-To: <20201101232211.1194304-1-linus.walleij@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 15 Nov 2020 12:21:39 +0100
Message-ID: <CACRpkdacs=6QxjGbK4MbV0ib8rMn2gxcFr9AX+n1FmXFn=JZzQ@mail.gmail.com>
Subject: Re: [PATCH] iio: afe: iio-rescale: Support processed channels
To:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Peter Rosin <peda@axentia.se>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Nov 2, 2020 at 12:22 AM Linus Walleij <linus.walleij@linaro.org> wrote:

> It happens that an ADC will only provide raw or processed
> voltage conversion channels. (adc/ab8500-gpadc.c).
> On the Samsung GT-I9070 this is used for a light sensor
> and current sense amplifier so we need to think of something.
>
> The idea is to allow processed channels and scale them
> with 1/1 and then the rescaler can modify the result
> on top.
>
> Cc: Peter Rosin <peda@axentia.se>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Any comments on this? The reason the AB8500 does not
provide any scaling is that it is not linear so what can I do.
Processed is what we can provide...

Yours,
Linus Walleij
