Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA64B2D866D
	for <lists+linux-iio@lfdr.de>; Sat, 12 Dec 2020 13:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgLLM2B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Dec 2020 07:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgLLM1w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Dec 2020 07:27:52 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597D5C0613D3
        for <linux-iio@vger.kernel.org>; Sat, 12 Dec 2020 04:27:11 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id a8so18318783lfb.3
        for <linux-iio@vger.kernel.org>; Sat, 12 Dec 2020 04:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=THlAPkY8diJSscV8Zy7Rc3aHs/Jusxj8M5TipOpSKcA=;
        b=IPf+mzvm5hWL4JfgpTL8yqKehFt1JhXioqll/pUvitKIctR8sBfg8FZlvVq9fVOvrd
         hLGq+TbRkS1v0D/QogiByIccM9YAl3Y2HwQvwFGXe8WekjmSdgOAfaeIDIQWyKjNnrFj
         +TKXfoohF6OUOnyEM3HCNstl8lYrTvbQ5T+ohLwEpaXkXTvFygp9xUplaUliOqg3+3Ih
         0A8TNQ+GpxZ+SWgXWaumv96xDsXnMTaCbDke1mRzDzRuq0Dt77mj6RDb/WLvUGcLhG7H
         gu5kB4fb5vmqw2nEScjPETBV7veNog0ravsosL7TWYjq+QvpJp7RNJOsYpFTLCnl9G3n
         Jcqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=THlAPkY8diJSscV8Zy7Rc3aHs/Jusxj8M5TipOpSKcA=;
        b=dyvE57ucnKN2PD1pcw4hTCFCe0it2jzDxfZZ0uKo7aqVXhypZ88GzvSvVn+Qysk4SM
         1pQHtcX+Ijw/4bOUOGssoEM+LDC9EzNh2+VvuAwdM4zIqld2Igqs8Gmc5Uf62sfF+BH6
         6IniOV7pf+eiyzsIc5DykB4rr3e59m4ESWw3SoBzz1qzElZteSsgOq0Kpj4oQLWZXMNf
         qAlC8PLNMbcfOATvKaWwHfSlkXiQ8goJOeFuxW1bWF3iEb7NRTZVoqe8lyis2kCUPJ05
         eXqBQxAj3VBudc3y3YrSma/WLhR7P/Sxex2nPqAMxJJ6kL6vqJM0GFrlcoQl9Lw3H85w
         WnsA==
X-Gm-Message-State: AOAM531tIcfx4ptc1DLX9impmLMPq8iOn6LDCeBAL0a7yV02NvWm9aXa
        W1e2MBkMck5WhjeS7qKZK8KNLWSsSeXO2qVpcGVr6w==
X-Google-Smtp-Source: ABdhPJyk4LTK7JGbqCImyQs/3J/lfFu4UXpLEh/Xl2BcR5YXEmeHpO4y5O7Dm8CE5zj3qWxfbprI+fCeBEC772EHB+I=
X-Received: by 2002:a19:7d84:: with SMTP id y126mr6461566lfc.586.1607776029899;
 Sat, 12 Dec 2020 04:27:09 -0800 (PST)
MIME-Version: 1.0
References: <20201101232211.1194304-1-linus.walleij@linaro.org>
In-Reply-To: <20201101232211.1194304-1-linus.walleij@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 12 Dec 2020 13:26:59 +0100
Message-ID: <CACRpkdZc=qGasbsL7DWbbRGyvxaX8hh2iU-QfLpkYGCD3UrqOw@mail.gmail.com>
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

Did we reach any conclusion on this? I really need to use
the rescaler on an ADC that only handles processed channels...

I'm sorry that I can't make this ADC disappear :D

Yours,
Linus Walleij
