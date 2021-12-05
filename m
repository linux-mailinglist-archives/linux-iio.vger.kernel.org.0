Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BA7468D25
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 21:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238431AbhLEUNl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 15:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238388AbhLEUNl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 15:13:41 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3CAC061714
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 12:10:13 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id y13so34321036edd.13
        for <linux-iio@vger.kernel.org>; Sun, 05 Dec 2021 12:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ANlA1zxmh57zw9U4IYtmvqPFV80zulYfsEL/JkpPPbE=;
        b=Quclzzygpmswxu/sFq2u0Enie9iTB4J9ai3Z7kdBfuRbtBfWjYH40JXgTIRWyXM8Y6
         A4X0AXEOTeyKRDL8xkkop3gDFEx17/Ni1T9OPUh8uuVJjj6/AAycZqy0bYIGweltC100
         sk6Rtlqboetano+tT1Iyhkc7ZakgFTU/+O20Q73Xv2/rhiw04VwXxr338vR76tEg1hLr
         SVT6MaCROkA+U2fVc7WwlZ8jSg9oSIzBb6aP86UH4BBPraDzp3/r7s2Tc9RK4jxmI4z7
         xU0kiDgfRF1MYpzMc1JNfUxHXYkZs/RuiXVusOmnBoKuO9vThKUV1BJooQyTZDaXi/m+
         GSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ANlA1zxmh57zw9U4IYtmvqPFV80zulYfsEL/JkpPPbE=;
        b=5iAT9YIzLgRAC8flr9b12CaNJOuimTtNExkXEfy0itNS+6GLkrTPPbr8h45fAWjJ+g
         hGy2BNOBGZbsoQk44vCLwHs55rgpMl00S/arx/2y68pjt7NHzgjXl9ejSMaLtlbKwLGF
         hOAR02tIhg+26EimmcHyNUVSIDh/TEWdSfuqvdj5mP9kOWUZpkzCXpMQsuWu+1cAkm8r
         geRjpTVsqSgkC4BZJ+x16JpuFajV9ODFyVOUy7Xkc3/3qInmW7x1uT2YT4YF+OUIMOl1
         t6w+OlyovvfKZaNfVIr746G8OeqkesDhsQSRU9ATKVFWkkFh49F3ncTH00Pl15GJlfc4
         0QAA==
X-Gm-Message-State: AOAM5325qcwmVY2v2o/3vrK30kbnJzyl1m9b6SWwbpvyvNjAbMvzTAUs
        dSe0lr+aRU1mp5Ity5P6MdfEiQC2wDrBFcPDlAeHsIm50hgLqA==
X-Google-Smtp-Source: ABdhPJwtXaPDgVi4rjdr+h0BWfzLgqxp3dBiOgtuC1CXpFvS6gmR6Gkww3lb2UMjlBaLRcesK3ZC6bG2hmR1TCKJ2Rw=
X-Received: by 2002:aa7:db8d:: with SMTP id u13mr46003421edt.111.1638735012345;
 Sun, 05 Dec 2021 12:10:12 -0800 (PST)
MIME-Version: 1.0
References: <20211205170140.2783914-1-jic23@kernel.org> <20211205170140.2783914-2-jic23@kernel.org>
In-Reply-To: <20211205170140.2783914-2-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 5 Dec 2021 22:09:36 +0200
Message-ID: <CAHp75VenfEMhYjjst4VwZDorwr0Be6CBOH6zhciQSD1AmUbSTA@mail.gmail.com>
Subject: Re: [PATCH v3 01/12] iio:dac:ad5755: Switch to generic firmware
 properties and drop pdata
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Dec 5, 2021 at 6:56 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Lars pointed out that platform data can also be supported via the
> generic properties interface, so there is no point in continuing to
> support it separately.  Hence squish the linux/platform_data/ad5755.h
> header into the c file and drop accessing the platform data directly.
>
> Done by inspection only.  Mostly completely mechanical with the
> exception of a few places where default value handling is
> cleaner done by first setting the value, then calling the
> firmware reading function but and not checking the return value,
> as opposed to reading firmware then setting the default if an error
> occurs.
>
> Part of general attempt to move all of IIO over to generic
> device properties, both to enable other firmware types and
> to remove drivers that can be the source of of_ specific
> behaviour in new drivers.

I was looking again into these enums thinking that it might be a good
place for them in include/dr-bindings/ but after reading the schema I
realized that they are rather encoded, while the schema is using
decoded values. So, scratch this. But I have noticed one more thing
(see below).

...

>         devm_kfree(dev, pdata);
>         return NULL;

Sorry, haven't noticed this one, do we really need this devm_kfree() call?
Shouldn't there be better error reporting then? (Note, it's just
thoughts for further improvements).

-- 
With Best Regards,
Andy Shevchenko
