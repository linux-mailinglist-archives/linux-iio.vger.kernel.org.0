Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAA03A4AC3
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 23:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhFKVuz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 17:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhFKVuy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Jun 2021 17:50:54 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB713C061574
        for <linux-iio@vger.kernel.org>; Fri, 11 Jun 2021 14:48:55 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id r14so11453747ljd.10
        for <linux-iio@vger.kernel.org>; Fri, 11 Jun 2021 14:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PD9oxdAhW8JoQLtMzcwKRmdqmEvyn8PD2SQ4GYyH4BY=;
        b=fE1X5cLYpLTQw873Lx4yLJyTgyk8VTt6ZPMyp2fyQMwWsYhjR2Pk5xm9eY6L52iSr5
         z0FYaJNZhDhD3ctDO3mEv/BR24b0hdNaUVnkEiUBeNLw6qt7eD+Uw9eXvIAcsbasyupO
         xTA1lwZawGf3ANVm0qbiYZuqt3M+X65rzp5XQ8Up/L9VZi10GBNcE6xhDUFoZ12uskjf
         olr+M85cJkrY+uNoo6fJgCqpGY+/MES0OYRfYod1XQ04easIIoiiFYvnO7fa7z70JrdN
         1omYM95kV6YwWBHxraMhOTCdly7BkYnxBkPhEpkY6KmPhP6pQromKb+ZGijo+HAxF1GF
         YTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PD9oxdAhW8JoQLtMzcwKRmdqmEvyn8PD2SQ4GYyH4BY=;
        b=ZJRj2u0xvMQg1cK9Ub4KOsGUSuoPxUKFREAru4465RVA0VL1BIE6c8LpcAvB+e/NEV
         CBN+6mZMwhnPzMB7x+CPuxknF6L30z/xiywJUlJmVIWBDGlAKfBcvKhPOUzW4F8olHbs
         uqaj4KzptgnYO7Ph8m+6O99PW2CCwV0v96rZDuqjBdD65uecIuE2WKuPbdqdjnGj1SFO
         lM9cQWVITpKio+/FmiaiKubyttD6Od4uh8Mpe6g1yYe5df06Hblz/r5N8LFTY4RXQIkc
         c9EnPY7tzEL8Iw2fskzGhHZbP41kb+OpC2y2Vb3j6XvUClthJzWQguK4QCXIbbAOvaCd
         IBHg==
X-Gm-Message-State: AOAM530naMQezGfRFg1V6XaaYLAkcwmzVf8po7TCnScXRF1AqcjEyN4Z
        UVqFRx7k0pTH9RJOFgFjNQ+VZLfwzjAUfij1CKPOn9Hkk/Y=
X-Google-Smtp-Source: ABdhPJycpkLvy3W1ZemM69qJagLw176NAZD3e7ctON9FCX9x54QXXo735KAGJNUqs5PWirlXSxQQQ7u/rtvIOjP2FGg=
X-Received: by 2002:a05:651c:1057:: with SMTP id x23mr4391073ljm.467.1623448134076;
 Fri, 11 Jun 2021 14:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210611171355.202903-1-jic23@kernel.org> <20210611171355.202903-3-jic23@kernel.org>
In-Reply-To: <20210611171355.202903-3-jic23@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Jun 2021 23:48:42 +0200
Message-ID: <CACRpkdaBc1oJ3AeBwgDEQ=oTNHUw2itaSVm-bi+yNAV2j05=4w@mail.gmail.com>
Subject: Re: [PATCH 02/12] iio:accel:bma180: Use generic device properties.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Bakker <xc-racer2@live.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jun 11, 2021 at 7:12 PM Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Whilst doing header cleanup I noticed this driver makes very superficial
> use of of_* interfaces.  Hence move to the generic firmware forms.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Jonathan Bakker <xc-racer2@live.ca>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Looks correct!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
