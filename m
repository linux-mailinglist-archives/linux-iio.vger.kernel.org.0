Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1291E10E77E
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2019 10:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfLBJQz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Dec 2019 04:16:55 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40653 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfLBJQz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Dec 2019 04:16:55 -0500
Received: by mail-lf1-f65.google.com with SMTP id y5so14623800lfy.7
        for <linux-iio@vger.kernel.org>; Mon, 02 Dec 2019 01:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xha0gflto9mpKTwQNwXdkL8Gx0gwtG/dapmJU1f7Nhc=;
        b=J31iqNiVUayxr904LurNTrkeEsNMUg0DLPrY2nGBpDHooQ9vG+ku05c8h5jENUYUKs
         GOu0x5EPjyQL1nRytlA35zFv/eWnwjKZpXq8dkwN+aOIKYHKd3ul6+1my6HP4HGrzzCY
         ScpdJazZ4RNdDdOsI+6XCJ6fmiRo7WeFbU/5PFcWoz3jgkQ+aWLqApmN2kxfNT0PEN7S
         UZsTKP2ZoIsPoC31ZLYB8qoQPu1+fuE2nhY7gowd26Cko+0nWyn2LB4rp9BIaxBKSIsz
         lqUo/bKBBCwZQ422r2Xww5YTdj5DeUpYXHo0xVfhheA0ch1jy43yt9mevOBPdKOlG+8Z
         d5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xha0gflto9mpKTwQNwXdkL8Gx0gwtG/dapmJU1f7Nhc=;
        b=cL++hpVJbYAAPzlTtgTX4SXbmbcQbZBFPywPMK/EMU4Nse1EDiz/C4Hug5xQ4IROsN
         V3N2iOxS4qMzp1gd7vMeLsMg3fgGfkY8gBM2+Iiz6Sj5ITwxTus7pNFgwz5kQK+dT4aX
         h66KdxM1O9UcpI4BTjE3pgVenAOiEajgs8YoCrXgb2y1plrg0IKBe75eDYOm3f4YAJmJ
         166+O/NKKrx2iTdPsSR2Tdqiw68POTj1v92bIoL2F6qo51jBFagIaS31ZxMYKTbvCBh/
         bi20viLbEoBVX/dPtw4IfkWXFLPKsPG2d6+LKVaFHxXMsqUXVSut9NFaykGusoQ6/yLI
         ZT/g==
X-Gm-Message-State: APjAAAWMNj0l0PRv2VzUxeB/fgiulvnek4v34B8735jzFyoFOJMVGF5m
        beyXSM5OymQueQXTTkvkUtPu8KF/Y+G6h0nZkhIPRA==
X-Google-Smtp-Source: APXvYqzDf51p+UiFGsqBFJfTbbGIBgb+bTsZ+hSZetx0uzlElTDSJwVjUlMy69qWbQ05wXRXyS7VWNzZDAmykpMr5Kk=
X-Received: by 2002:ac2:410a:: with SMTP id b10mr15133534lfi.135.1575278213514;
 Mon, 02 Dec 2019 01:16:53 -0800 (PST)
MIME-Version: 1.0
References: <20191202083830.71572-1-linus.walleij@linaro.org> <a1be250ce3e9a89e5a352390e16504ce8e017dbe.camel@analog.com>
In-Reply-To: <a1be250ce3e9a89e5a352390e16504ce8e017dbe.camel@analog.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 2 Dec 2019 10:16:42 +0100
Message-ID: <CACRpkdYUz0yrJ_cB9rq1u+KUFUw_DOCwzAec340BgaHV_cdcuA@mail.gmail.com>
Subject: Re: [PATCH] iio: adf4350: Convert to use GPIO descriptor
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Dec 2, 2019 at 9:50 AM Ardelean, Alexandru
<alexandru.Ardelean@analog.com> wrote:

> > +     st->lock_detect_gpiod = devm_gpiod_get_optional(&spi->dev, NULL,
>
> Would it make sense to name the GPIO here?
> Maybe name it "lock-detect"?
>
> I do realize that this goes into the realm of changing some default
> behavior.
> And I am not sure how acceptable this is [generally].

You can't name it in the devm_gpiod_get_optional() call as this
indicates the name the GPIO lines have in the device tree.

What you can do is add a call to
gpiod_set_consumer_name(gpiod, "name");
to explicitly name the line.

This will only affect the name assigned to the line
in debugfs and in the userspace tools like "lsgpio".

Yours,
Linus Walleij
