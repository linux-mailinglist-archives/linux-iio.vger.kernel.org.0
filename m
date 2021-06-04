Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7270A39B473
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jun 2021 09:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhFDIA1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Jun 2021 04:00:27 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:35751 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhFDIA0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Jun 2021 04:00:26 -0400
Received: by mail-lf1-f42.google.com with SMTP id i10so12765336lfj.2
        for <linux-iio@vger.kernel.org>; Fri, 04 Jun 2021 00:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qWNZl0ucUIFZHgJOXmZoNpmqFeVWv1dfIUYGYZtyZq8=;
        b=YD41o4Wr7a/idp56ZpEObm2CwwqDUbY6drvE+mOzLOoa03PV9n0xEWRiLqclW/FBmq
         OwgpJOvtMM2iQWxnV9Wq37NdNjn1GOCUkjL11lWt5DL1f4+9NeQ85sBrigTlrl5I1FMJ
         Or/dIdmWn1Y1NGbgwGrOsKdr5fjhmRe8VzNurNXxGb6B1GJ3G+06SiJEmD4xYeJw2Adq
         wjAY+P4e6ZXgaDLFUm3Azmey6S8C5JKflGOGxt7ZTqN+AegnhOCEpSaWlTXoHFBBli+P
         8MKJQyqtV9hy57lnpE6PIFu2pVsxCqYyIeGKdHGGnV9EOwAs9DjquQUBRDJ/d0ik0pVl
         G3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qWNZl0ucUIFZHgJOXmZoNpmqFeVWv1dfIUYGYZtyZq8=;
        b=uh0OcHjm233e9iNft4okXxzFHFBRRz9wrTbgaE0LWSKbf0sOY9gtU+uBSEgAlT5G3I
         Ih5OQHCSA0R0LDddfiP3qvZIU7oe5wBm4/uyn71UUEL99pQKJzDyeB6kZoi7EYsIizE+
         WDpletonPuTeLcnxwwTVxoB/D4IRU296HLhGItcnln4mFwnH2/jyhXfxdZdg99ItTC7U
         jJXmMXKptKy8cPMjqc4+WCmpX/kRSNcODyO7SS0DBQ7KIByv04nDAD3p2Rv+4YHSGqNX
         r7qJVck6nG5yrQT3JkV2Cs2mGlgXIlqQwNt+0A6G+DpR/iCYx42i9CKifjum/zoOpoNn
         Kkiw==
X-Gm-Message-State: AOAM533wgmsIwL9vzC10CCBMplCE3nZxtjsQriP16WljlRVc/sKEL93u
        I3UT8EFHbnooIynqy4Pq84gaQi7HjhcEqWDcE3T4Ig==
X-Google-Smtp-Source: ABdhPJx0ULxCX6SCAwwI3mb1mIE7P0r4Xk0r6A4r9Zloif3dr7zKdVFKCOGnzSehgzMNGf1y0g/gZKGgh4W6IkPtmu8=
X-Received: by 2002:a19:f616:: with SMTP id x22mr1894859lfe.291.1622793447872;
 Fri, 04 Jun 2021 00:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210601142605.3613605-1-yangyingliang@huawei.com>
In-Reply-To: <20210601142605.3613605-1-yangyingliang@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Jun 2021 09:57:16 +0200
Message-ID: <CACRpkdZQjfCsPYGFz7S_Nc=1oBqPnznhfnXTUsNYe1WNQJCR4g@mail.gmail.com>
Subject: Re: [PATCH -next] iio: frequency: adf4350: disable reg and clk on
 error in adf4350_probe()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 1, 2021 at 4:21 PM Yang Yingliang <yangyingliang@huawei.com> wrote:

> Disable reg and clk when devm_gpiod_get_optional() fails in adf4350_probe().
>
> Fixes:4a89d2f47ccd ("iio: adf4350: Convert to use GPIO descriptor")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
