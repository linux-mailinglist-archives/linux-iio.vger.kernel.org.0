Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4292A66BD
	for <lists+linux-iio@lfdr.de>; Wed,  4 Nov 2020 15:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbgKDOvX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Nov 2020 09:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgKDOvW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Nov 2020 09:51:22 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37F6C061A4A
        for <linux-iio@vger.kernel.org>; Wed,  4 Nov 2020 06:51:18 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id 2so23221934ljj.13
        for <linux-iio@vger.kernel.org>; Wed, 04 Nov 2020 06:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z17mmwOTy1eEBA4B+RCirdyBT8gSpjRUP+rqJWi1tIs=;
        b=JLAjDB5yvfKX3xUTe+cQS+tl/XRnTF1T/KSzJk4EYe7509WienesG0E6O7TkPcyuZN
         A9XCFGsrryeM3NAKAmCoGLFskmUhKzZUn2Hf0YfdvSWijLYLjImjB3Xonil4JXVnMv+A
         o1Zf8Tr12ijlHA2MO8LlIUY80ivxzZYr8/Tfap1osbP12elScExYDmokpRRD7AxQGegq
         sK5kXR7IfNM5bhvzv3DoyKxrmbHTU3PCHoq0W0cRpxVujLXBNhxSDBUMQOtF2lkFPYlx
         55ft2BnF9JXGqERZO5+qR5ELaHHN0q+mUzYoQSdxvW6wMG0lXmHjrDh6GemluVQo6y5l
         mJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z17mmwOTy1eEBA4B+RCirdyBT8gSpjRUP+rqJWi1tIs=;
        b=R+JpjgRRhesSWwenmF03N6AnmC/e/Al6AEQu5zEoQobByX1NFIG917lVioi3GXXdRh
         8SuMrtHg5YXpeOMPE8WKQAoFNYh1HWO1TpgzkXBj7OsE0zjBJaKZ9j2WZtqgNGPl4htc
         0UwP4GeT5pIVmWdldd2xcF5uI3Gq5FZB6FAIxhPl875H4/t6g8NwEqHmpPAc7vcZ99OO
         c2jluDtfMPmolxRu2HE3lmijInVm391wHoahk7hGCbWc06uv64OIZoiSgm1cVKhGc5TH
         5lASdgPiOBB3nlL6tWYWsF2WqF5mKCdGMPWFPue/pMqxZyTFgHMl2dpfcU85JC66YxNM
         LU2w==
X-Gm-Message-State: AOAM530FvPyab9YCxCQP4mZuuQxW2MlUGuB3hxYXfiHmY0Cfsv6/RfPI
        YAwviVyDlChoFQVUgIjvou5rwkOKl9u2EKeoser8fQ==
X-Google-Smtp-Source: ABdhPJy2KPBJbx6MQ1DjWjYa6MbyS2OJtTAI3nc9M5LV/GQ6JMYBTsfBFC0p4qXoHMbTPJZVzfO02xlBntVolwIZ4eA=
X-Received: by 2002:a2e:8905:: with SMTP id d5mr10448468lji.144.1604501477314;
 Wed, 04 Nov 2020 06:51:17 -0800 (PST)
MIME-Version: 1.0
References: <20201031184854.745828-1-jic23@kernel.org> <20201031184854.745828-36-jic23@kernel.org>
In-Reply-To: <20201031184854.745828-36-jic23@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 4 Nov 2020 15:51:06 +0100
Message-ID: <CACRpkdYTvKCQNyn=CtVZ8KRhGFXM0Bi-416ThMdBCAU=93WHZQ@mail.gmail.com>
Subject: Re: [PATCH 35/46] dt-bindings:iio:adc:qcom,pm8018-adc: yaml
 conversion and rename.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 31, 2020 at 7:52 PM Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Renamed to match a listed compatible rather than relying on wildcards
> with all their usual problems.
>
> Dropped the reference supply as a requirement as at least one dtsi doesn't
> include it and the example never did.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Looks good:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
