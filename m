Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A005027CCEB
	for <lists+linux-iio@lfdr.de>; Tue, 29 Sep 2020 14:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732333AbgI2Mk2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Sep 2020 08:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbgI2Mk1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Sep 2020 08:40:27 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C86C061755
        for <linux-iio@vger.kernel.org>; Tue, 29 Sep 2020 05:40:27 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id w11so5348600lfn.2
        for <linux-iio@vger.kernel.org>; Tue, 29 Sep 2020 05:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9bUHhnubUfQotEQH3D11QFoTpQexEbcVvHbq6bkeH+k=;
        b=da+sNvxIpNIjpSl4OCxDqicbNhPUJ53bM5x8dHgoIKh4MX7GFDjZM2lA3mIDr9TPU9
         kt4eiOoE1VxDvMCnMFa7iRNqUiJODTbszbq08mEAN8dGOK6OJvsJDsyv9FWpovz4GaFQ
         kFgmHZdf8Davm/k05Mqoja9uh4tNTwKUMVRtdXeo5vhPupL0YSjc0YgZF9I2lqS71SYI
         XyFcG1oGsvu0EHICnkss87OltsPEC5t8mbxcQef87za49RR9qK+JWaicp2p1BVYggy4h
         UX6syRQ6BCijnCzfVy3VAFSNdmVE3hCa68zLRmWm6mlhxQiKVpu77Z2pHHb89kvuPNQP
         h48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9bUHhnubUfQotEQH3D11QFoTpQexEbcVvHbq6bkeH+k=;
        b=DH9AF7av43pTt26aTxALRJqLnY8j3aF60Bhi4F6MoWaeEH2kO+Bx5HMxbrg2SR4izW
         4xZG+njvV54W9Yargpppx/wPvnzMU9qoQ1mvouKGNv7cNqr+u4nGtpNGfd7OSeAQ960r
         8556hcEaaL+WcCIF5zdqaTnOLuQ8TLo29vm7+6tugxlsoOk5sJBnhkTu+dLTcfzU1lMW
         dLwAOh7elWquLKeU3lVyjlHtUzvTSsRpd3FW48tsBBK2gK4tTA1+ObAnxka+Jpp3IACL
         DVoNOMzNGqN95zAig703BQJWpL7jd0y50jCf0aAs23AYS2rthoI5k9ihh31yMsDxWWBY
         ZSEw==
X-Gm-Message-State: AOAM533DmxePw9Kv540z/5zM0S8L+YH89z7Gp8ld3tvsuP+yMiYperyV
        QkPz8rp12tpyTtNJOaKyyqivZEZPvXzeI8OwpLNj9A==
X-Google-Smtp-Source: ABdhPJznTp/rM3xakD/x4BDcWOb3Aa3l79WDH4TagLMQHGkeIErLTgzjIN/519Hrze2tb2/GgKjvlfSXIbppWVCXvjE=
X-Received: by 2002:a19:6c2:: with SMTP id 185mr1061759lfg.441.1601383225861;
 Tue, 29 Sep 2020 05:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200910173242.621168-1-jic23@kernel.org> <20200910173242.621168-36-jic23@kernel.org>
In-Reply-To: <20200910173242.621168-36-jic23@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 29 Sep 2020 14:40:15 +0200
Message-ID: <CACRpkdZP9pMdcAEciuo32ZtnmD40b7djfE8fJJT54nWmLHvt+Q@mail.gmail.com>
Subject: Re: [PATCH 35/38] iio:magn:ak8974: Drop of_match_ptr protection
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 10, 2020 at 7:36 PM Jonathan Cameron <jic23@kernel.org> wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This prevents use of this driver with ACPI via PRP0001 and is
> an example of an anti pattern I'm trying to remove from IIO.
> Hence drop from this driver.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
