Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C522CBC55
	for <lists+linux-iio@lfdr.de>; Wed,  2 Dec 2020 13:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbgLBMEE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Dec 2020 07:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbgLBMED (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Dec 2020 07:04:03 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846FAC0613D4
        for <linux-iio@vger.kernel.org>; Wed,  2 Dec 2020 04:03:22 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id u18so4240087lfd.9
        for <linux-iio@vger.kernel.org>; Wed, 02 Dec 2020 04:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JrDxXawKFmfpC0PtwoTfICjU4fGQp1m9XOEUHodRjh4=;
        b=Jh/GPoSevt3SV5RTaTwsaYQj/V/NpTGVQ3t2qKS6vUGGD7/pTECzTRoxKeELr0B6Rk
         LzYQFvUHkFufV1RTkLkcaD5H3Qb8Enb+Uo3wGL8Ht0OC1x93y1MY6QbYdC0jgRh1hJ99
         WQN7urB/BiCmG3Xwm6GHNyP0jUcAfLHEVAqbQofZbzr7xjUOBkx0+32G6WGaLnyqyRnG
         qXZeXNhYFWSunVN5xBCJ0ZQXYMqw+kjEp/5IQgBAWU0Zts63QXdNW338WQuR6+cd/maW
         8tX488nHz6Sy/LJtorpFMSyJdhXnuA9vIZ68PUWr6KfTU8+1QFeFDCPbaiAQHU+MY2DB
         EOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JrDxXawKFmfpC0PtwoTfICjU4fGQp1m9XOEUHodRjh4=;
        b=poIfm8ye9BO35rInAK6HNVJcq7+VjMkoPvO3ygkjB/ydbPzTLuz/imYlJVaJxyOQs6
         1JN8TdV5zZVg48hzDxMCFEqq1Mqq/7XIvs4dA+lRSFwvyQdsJJZYaSDaDxdxOuoXdZFp
         e4nHwBmhUAzh8zbe2sYftdtbVgVweQgIFAcD+0qXdo5/TvkbmuGQ3SUeymP3kabfmZnb
         30u3Jmt7Ak6ArlvFaJo5qANWL5gY2ffaPIKxvvW05uPCslKbL/+7AHuY0yEKxsoR1U+A
         vUhgLJc4Et0UgOEdkLmR1Gb+GZrorNzpihH0v0UXEK1pYWyZvbZGcPiu6ku63zns2XWw
         xHrQ==
X-Gm-Message-State: AOAM532QQvM7J9/RAkPoudgqmeZtYBpPjdeoPSNwwFY7BEmUVVu+BpG1
        xeOVLM2uNiqJsiw0oamzx9U2PDTwPUF95bYIYoJxjQ==
X-Google-Smtp-Source: ABdhPJw7g4cvh7G0ozEBAQSqX9C4nQr6bZEWkCOmw7+SjxIub91liuDU293pDkzEei2xmCSi1V1nY2t7JtcuqqXZOxY=
X-Received: by 2002:a19:ad41:: with SMTP id s1mr723702lfd.571.1606910601052;
 Wed, 02 Dec 2020 04:03:21 -0800 (PST)
MIME-Version: 1.0
References: <20201202093322.77114-1-stephan@gerhold.net> <20201202093322.77114-4-stephan@gerhold.net>
In-Reply-To: <20201202093322.77114-4-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 2 Dec 2020 13:03:10 +0100
Message-ID: <CACRpkdb7-sa+9fqa4zuEmvTBKNDR4Nw2pPbeWDu6GhWfUTUNpQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] iio: gyro: bmg160: Add rudimentary regulator support
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "H . Nikolaus Schaller" <hns@goldelico.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 2, 2020 at 10:33 AM Stephan Gerhold <stephan@gerhold.net> wrote:

> BMG160 needs VDD and VDDIO regulators that might need to be explicitly
> enabled. Add some rudimentary support to obtain and enable these
> regulators during probe() and disable them during remove()
> or on the error path.
>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Reviewed-by: Linus Walleij <linus.walleij@linar.org>

Yours,
Linus Walleij
