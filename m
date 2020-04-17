Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34931ADE1E
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 15:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbgDQNSF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 09:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729799AbgDQNSF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 09:18:05 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574D3C061A0C;
        Fri, 17 Apr 2020 06:18:05 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w65so1039763pfc.12;
        Fri, 17 Apr 2020 06:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EyqXQt/bpi42az8Mxxe8eEqoldsWFIN5K83wF16CGz4=;
        b=Zqaz1WUGKBycpFWhVHETthTkgsZVN48lh+U3RX2zfriIvleOxjwZwoYp01U75WqvXR
         P8Konx9cqKsFYmRuezduXioahFLCqt+z6sPvoAvdpsf7SIwK+Mgc8i3lDMIGZd2kV2+B
         5xr09Yum6W68kxcImqzqxb250U5S4pn9gXenDTneIOYlhv5x6RVchiJxNRX7TOHURMGq
         S6hL3foS38woJ/dM4b2Q/rkvm3n47Veuqx/kBi3mokdgv7L95t+75mVnB2Gu0WyHAQ8u
         3DFQCSanw2dhUoiziKSxwXTg6B9jekjT+TfROrI+8BnrpblKymnbZmH8gMBqVKD4X5Av
         UG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EyqXQt/bpi42az8Mxxe8eEqoldsWFIN5K83wF16CGz4=;
        b=RiYYcO1S81oDn6NraZ+bYek51WrJIc1JQrBdsE/IwFr3kh0XAjN1RuBZqEbQ/b2CAm
         wJWCNYgFFFBZwKYDtqAe35ewLWWmgySZlV03su1VfYXLDYBBZv9Nqr3UwlntsyEWNptq
         lPqcHV23w23zNp5GBGFzMDUzr3euoWE6UfEf3s0F7tJBhNcyQSRg0XK1eStDshTni5ks
         DGmTaAZlsC1LpXz8++dWzwbrqLwHAG0eJJlA6o5li4d3LTMzPO+bCE2cub0IwJQa/z3F
         87OwSYZBg01I2bnfsQZnOTsDCZFD25gkfCfft/eF8oc5d9DWPMi/OdznQj3Ddc8gzong
         zQlA==
X-Gm-Message-State: AGi0PubJQ7xXpG6xVQ6yhQiRJoKXu3AKhiDWnZkdquAP4KdCeXOj4uOx
        V/5G5PYrYyKuKiT/gJoOgKL7Y+itA5bZU5rPbpAtowgwFq1t9Q==
X-Google-Smtp-Source: APiQypJnjl9IyZ1p9D2X9xDXZzRldBFxU2elnVbHVwCerO9iOW06TYb+zxQGFrtbI0gEPj0h9k5RUMK48B1KnCgVhh0=
X-Received: by 2002:a63:1c1:: with SMTP id 184mr3118804pgb.203.1587129484791;
 Fri, 17 Apr 2020 06:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200417114020.31291-1-linus.walleij@linaro.org> <20200417114020.31291-2-linus.walleij@linaro.org>
In-Reply-To: <20200417114020.31291-2-linus.walleij@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Apr 2020 16:17:57 +0300
Message-ID: <CAHp75VeprFiBed=QZEYGaqJAu3g3Cq+_6oUbNbxLPPFequGVog@mail.gmail.com>
Subject: Re: [PATCH 2/3 v3] iio: magnetometer: ak8974: Break out measurement
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input <linux-input@vger.kernel.org>,
        Nick Reitemeyer <nick.reitemeyer@web.de>,
        Stephan Gerhold <stephan@gerhold.net>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 17, 2020 at 2:42 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> This breaks out the measurement code to its own function
> so we can handle this without swirling it up with the
> big switch() statement inside ak8974_read_raw().
>
> Keep a local s16 helper variable for the signed value
> coming out of the measurement before assigning it to the
> integer *val. The local variable makes the code easier
> to read and the compiler will optimize it if possible.

> +       /*
> +        * This explicit cast to (s16) is necessary as the measurement
> +        * is done in 2's complement with positive and negative values.
> +        * The follwing assignment to *val will then convert the signed
> +        * s16 value to a signed int value.
> +        */
> +       outval = (s16)le16_to_cpu(hw_values[address]);
> +       *val = outval;

I'm wondering if you may use sign_extend32() here.

-- 
With Best Regards,
Andy Shevchenko
