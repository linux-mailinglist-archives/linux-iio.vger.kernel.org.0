Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20242CBC84
	for <lists+linux-iio@lfdr.de>; Wed,  2 Dec 2020 13:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgLBMJv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Dec 2020 07:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbgLBMJv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Dec 2020 07:09:51 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4BBC0613D4
        for <linux-iio@vger.kernel.org>; Wed,  2 Dec 2020 04:09:10 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id z21so4243187lfe.12
        for <linux-iio@vger.kernel.org>; Wed, 02 Dec 2020 04:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Vw8se40+ZwpHjC4c0VnUFf9R1QwmzeDK7Zkwd9o0xQ=;
        b=OTpxZpqWl+NMvKw8bWRa6FwBMc3zEPZ3xt39draLB4xHmSwLsT+VFFzl7YD2Z9YWFh
         wzGvN2SXAuvQHmKK9IeJfBOX1WbbNu28EyNNWzVqynD/a/OmEjAl4zWDm/U3wM+A0k1n
         PKmuAP85+V3ySN2bT9Tmj3kH6mWBOdTwgoG7WuCjoRWWLzaBGBNoV7IPLGU4ZhbGqGsc
         qc7n/rNwqIWERHY5urXWjxmyX9zEPohbNDgm3WvuWjrrDkjjmPEyftNPpMR9K+GmmCQF
         IhNx0HxWitKcwALDcBVSwsT7hRzUzAwx6xJM1BL4mUA4avWTX5ZVjZperNd1xG27hO8w
         qivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Vw8se40+ZwpHjC4c0VnUFf9R1QwmzeDK7Zkwd9o0xQ=;
        b=ZoDxmCxkpXMt5AsDR9VWqBFZeR/R9ARAUJ19WkhbTLsjksKREXTIunw2lUb2asaBAG
         ffL3IaLuaMa5E7H4dLWuIzBUwEtvz4bdgznhoK8jvdhX7rRi2IK88RO6AXdsT3FAVI1w
         ZyJ5puXb/cH/I+OEGRGyLeQbDDRbRkvoHF/34qY04F44NzzlkvCEzX6HXoznXKHk/S+a
         CqtrcSe9PoGLk+gwgGwWuX2g8jAg9BN63C+aobGy7SJZnY4sHYRcwvsCcGkdBToIKn2d
         3h0GpgvPjoKaG5aravjH+PGblxdPRjJWwyLCMMA6o6PHWI1eEldzGzk1rDKGuzEON3/R
         WcQQ==
X-Gm-Message-State: AOAM5331a+SYwUhCzPV5Pzvfn6QWSTkQpMqhxpsAB8L3OmdHapmK9UCe
        wIckXGh+a6NMvnfaoveMDPXXiyBFeq6t4T9eXaldmw==
X-Google-Smtp-Source: ABdhPJy98X2zklHyHmNrWzOgs6AnCCZpoEoW+PrQch8G0MCdLsvzyJrcj25SXLwa5HzRRWIZAEkv8tFlyCA2mxfv+gA=
X-Received: by 2002:a19:8d8:: with SMTP id 207mr1031573lfi.441.1606910948682;
 Wed, 02 Dec 2020 04:09:08 -0800 (PST)
MIME-Version: 1.0
References: <20201202083551.7753-1-stephan@gerhold.net>
In-Reply-To: <20201202083551.7753-1-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 2 Dec 2020 13:08:57 +0100
Message-ID: <CACRpkdYu77Tcv9bk8q_BfKmien0S2sRg3Kicd_AeSrzrKD+Ywg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: iio: accel: bma255: Fix bmc150/bmi055 compatible
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 2, 2020 at 9:36 AM Stephan Gerhold <stephan@gerhold.net> wrote:

> The bmc150-accel-i2c.c driver has an "_accel" suffix for the
> compatibles of BMC150 and BMI055. This is necessary because BMC150
> contains both accelerometer (bosch,bmc150_accel) and magnetometer
> (bosch,bmc150_magn) and therefore "bosch,bmc150" would be ambiguous.
>
> However, the binding documentation suggests using "bosch,bmc150".
> Add the "_accel" suffix for BMC150 and BMI055 so the binding docs
> match what is expected by the driver.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Fixes: 496a39526fce8 ("iio: accel: bmc150-accel: Add DT bindings")
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

I see this pattern elsewhere so by tradition:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I suppose this is one of those situations where the two parts of the
component are on the same physical I2C bus, and phsycially inside
the same package, but accessed at two different I2C addresses?

These components are kind of ambiguous by nature. Technically
both devices could have the same compatible (by the label on the
package) but then we would need some other property on the node
to say which compatible is for which part of the component,
so tagging on "_function" like bmc150_accel and bmc150_magn
is one way to solve this, and I don't know anything better.

Yours,
Linus Walleij
