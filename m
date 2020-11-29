Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26152C771B
	for <lists+linux-iio@lfdr.de>; Sun, 29 Nov 2020 02:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgK2BL4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 20:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgK2BLz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Nov 2020 20:11:55 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C43CC0613D1
        for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2020 17:11:15 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id l11so13209413lfg.0
        for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2020 17:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lncJEKE/gyy14/IU6bTMZ4irlzUWrJygo+vXpx0Shq4=;
        b=oXOR0p2O4RQf5yq5MwrU5D296MFBn33K6MOiuXkNWz6fICEY8lNiJczFas7/+rOOkz
         5CO/L+YDdtdxzl7g9ak3KjPHMVLt8GlYLek4aG1PrvipYNXa1FvrcOD5o8po/LVPtb42
         ha04a+oB6Zk2J8M7msqFmPqxGkamtw/08jyKD5CzfdtWPI2T3ltSVnVukcfqnxk4ghW7
         eujZPR2IpNNCVi4SE9UxKDP52iCorfFGK/Oo1Uhu5wp2dyPeJgA3Pt8Dyxym8mbp8A+Q
         gCGCH6IO1P5yhh7aNv9zX01LHO5NJ6AIoNi+4Ta92MpeFufiu8S6qAKLHEF+RZl7D7Ro
         QYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lncJEKE/gyy14/IU6bTMZ4irlzUWrJygo+vXpx0Shq4=;
        b=EBbgxhf4NTlhoyKVmSfEbEEATC/RBBLoIgfbbgTGTGxtoG3SQvtDBf7IKeOr/3irWU
         +ekut6ifW4mon+UJqWP8ZBQXa/VgfxMdnf5fRZNZBFMdMUejrRnTxkbMioAHzp2WV5nT
         zO9AYBTB0v+gs2rXyWe5HvHGV8pnhOXw06qE2LUYQKc3NF20xk+I4MjVQkauWvEwy8hh
         6aZNFsu9TDwbrNGECCKU98GPYMcw3eYYWQ3rbiz55E4iZxYLmXE68buE5dUIBt41O8ET
         4vLzOyl20z5b82PtbX9A64vk7GQXnM52rwLhclmNql0XZNY4Zuhuuu+aWS50a5kv+7ug
         H6og==
X-Gm-Message-State: AOAM531mf7K9xj3nPyzXw83wwsWB+rn7A3PiCNUZ7UhSswaop0GdMbcs
        wc58k1T+wIw1pbUHrBDxr1z7n0i/H67nK4S757KN9g==
X-Google-Smtp-Source: ABdhPJwv7JY6EdIH0nKqy4orpCNpWqpnmR2Ivz1ONytI/WuV54EdZFUJHgdYrU1N3Ho5R0YbZHaPkCEg3Rvz7mEjRzA=
X-Received: by 2002:a19:8d8:: with SMTP id 207mr6095669lfi.441.1606612273030;
 Sat, 28 Nov 2020 17:11:13 -0800 (PST)
MIME-Version: 1.0
References: <20201128185156.428327-1-jic23@kernel.org> <CACRpkdaA5yhgd4+BgFN6WeC7pmoKPj8kYabD7TtFyEieiNVZfw@mail.gmail.com>
 <CAHp75VcKOrjLBwRBZ0gi0S8tL2QK7+3i2dhABbaQaBW8O=_6iA@mail.gmail.com>
In-Reply-To: <CAHp75VcKOrjLBwRBZ0gi0S8tL2QK7+3i2dhABbaQaBW8O=_6iA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 29 Nov 2020 02:11:01 +0100
Message-ID: <CACRpkdZrSyASctLFfN-8GZRnyfEUPretCXHiD-G+z+cvsDJLww@mail.gmail.com>
Subject: Re: [PATCH] iio:gyro:mpu3050 Treat otp value as a __le64 and use
 FIELD_GET() to break up
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Nov 29, 2020 at 12:18 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sun, Nov 29, 2020 at 12:22 AM Linus Walleij <linus.walleij@linaro.org>=
 wrote:
> > On Sat, Nov 28, 2020 at 7:54 PM Jonathan Cameron <jic23@kernel.org> wro=
te:
> >
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > Inspired by Andy Shevchenko's proposal to use get_unaligned_leXX().
> > >
> > > The whole one time programable memory is treated as a single 64bit
> > > little endian value.  Thus we can avoid a lot of messy handling
> > > of fields overlapping byte boundaries by just loading and manipulatin=
g
> > > it as an __le64 converted to a u64.  That lets us just use FIELD_GET(=
)
> > > and GENMASK() to extract the values desired.
> > >
> > > Note only build tested.
> > >
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Cc: Linus Walleij <linus.walleij@linaro.org>
> >
> > Are there any specific prerequisites? linux-next?
> >
> > When I apply this and try to compile for an ARMv7 target I get
> > a lot of noise and an error:
> >
> > In file included from <command-line>:0:0:
> > ../drivers/iio/gyro/mpu3050-core.c: In function =E2=80=98mpu3050_hw_ini=
t=E2=80=99:
> > ../include/linux/bits.h:36:11: warning: right shift count is negative
> > [-Wshift-count-negative]
> >    (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
>
> I think GENMASK_ULL() has to be used.

Oh indeed. It works as long as one just try to test-compile it on a 64bit
machine of course :D

Yours,
Linus Walleij
