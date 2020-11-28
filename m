Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6552C752F
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbgK1Vt0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731483AbgK1Sw6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Nov 2020 13:52:58 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D15C02A181
        for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2020 03:44:38 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id y10so8967837ljc.7
        for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2020 03:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JjI6jX2POrDX2Xe9vfJOZBcrPDMsHD4ZvzB5g8jo58c=;
        b=Y8JG3qk1GMOjBQWuS/2x2Y6SgWUsuoaBXQbwkuOYw8X+41qAQFiTyTwjbbn8Uk5TSW
         XQKOBAwsSCyyC+NxcSRbwmUdDdlwoQCYn6Y4VFCKHe4sXUtPBxfLXVbs6dXkX0WbfLp4
         9BmFf9GV33IJGwyWv+tVHFGgS0tDSReumydu0KXGSLU1qzX4WiMzWNZid/Y+XYLUV9rt
         OmrbNbbU/etMWzrud2j4IB+sT0gfk7ojz1YFE4bM/tHBCSFht61bdtK7pk4M37RqRTzx
         4S3l0RVyqtAMZPQT9YTlYdXVYDoGlmm1Pu/pMuD/8im7cxF1J7Eaw690EzzmcjgM+VjJ
         Fpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JjI6jX2POrDX2Xe9vfJOZBcrPDMsHD4ZvzB5g8jo58c=;
        b=Kn2Z8EtZpGFBEnix3zzzS4TTpaDz9SyZZ9zdIjt5l1kA2tUjBAwHMpuab4Z8jLw+Ug
         gZqKBFF6xMaP+eBzGD7q4g/06rfOoACTMYEnCnEH3M1U3gBLmBr/nHESwraslo+gPQO9
         eMZ2F3C6UOEhcJ0BdXMYQ0gresgzxvSfayQlwVDBMaCDFSsxim8Orr1exDZiYViJqfdX
         FvREtpESMYTnOfMRVvwpXiQazyGD6PdJEZazqPBs1PdCaEIQ0/V0Cc5yEX534PoxqTQF
         QZsiBzI10HGg7RW2Zk3oxqT0yaTQYJng5qEDAGgBh4J7z3IYpTRAT0yS2kVbnKqaczPW
         pUVQ==
X-Gm-Message-State: AOAM533cU38VG4Z4Nv3uQK1ZemsPtMhnme8NfGsmRC00d3jToMaac0Pt
        rzPnjPwqWNc/xDzqiZJ70QITxwtUkIo6Bx/m9y16Pg==
X-Google-Smtp-Source: ABdhPJw9wiMGdZC3WiQQA7TFZf40grr1B9eqDrzjTy7O/dpNvF4XTM+uulSzmravgG21gbMsU6yG51fMhnLvVeCdNxQ=
X-Received: by 2002:a2e:998e:: with SMTP id w14mr5924842lji.100.1606563877267;
 Sat, 28 Nov 2020 03:44:37 -0800 (PST)
MIME-Version: 1.0
References: <20201115205745.618455-1-linus.walleij@linaro.org>
 <20201115205745.618455-3-linus.walleij@linaro.org> <20201121164505.30767f9f@archlinux>
In-Reply-To: <20201121164505.30767f9f@archlinux>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 28 Nov 2020 12:44:26 +0100
Message-ID: <CACRpkdbP3ccrEK47jaQ=r8sYkFuXBcH=+LTKC1xz+kgXmkwomg@mail.gmail.com>
Subject: Re: [PATCH 3/3 v3] iio: accel: bmc150-accel: Add rudimentary
 regulator support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Nov 21, 2020 at 5:45 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Sun, 15 Nov 2020 21:57:45 +0100
> Linus Walleij <linus.walleij@linaro.org> wrote:
>
> > These Bosch accelerometers have two supplies, VDD and VDDIO.
> > Add some rudimentary support to obtain and enable these
> > regulators during probe() and disable them during remove()
> > or on the errorpath.
> >
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

> All looks good to me.  Will leave it for a bit longer though to let
> Rob have a chance to look at the dt binding doc.
>
> As ever, if it seems to have gotten lost it is probably worth
> poking me.

It's been another week and the bindings are simple enough
I think? There has been plenty of time to review these
bindings as they are now in v3 even, but it's a soft measure,
I know there is usually this YAML-bot that complains if
something is way out of line at least.

Yours,
Linus Walleij
