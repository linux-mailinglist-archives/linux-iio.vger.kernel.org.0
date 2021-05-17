Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0D738299F
	for <lists+linux-iio@lfdr.de>; Mon, 17 May 2021 12:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbhEQKR2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 06:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236363AbhEQKR0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 May 2021 06:17:26 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C32DC06174A
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 03:15:43 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id j10so7945966lfb.12
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 03:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4m3qHB6DdeBCgoxgHbY3XDj1zI1b/LO5LBOHI4piLpw=;
        b=G2KJ6mR3z3Vja/dFYcv0aFFaREIcBCSjVvQdhqzYDLDZdiZVTIjSp0uy5ZfTKnCsFY
         U/GBXf16RAoY+fdhHGJKmb4Bzh/5BVyOgcEE39MOdY8Hjx9RPoNqACx+sET9iJ4S9bV9
         m5b8Y1MfxPoGQlw69tA0k8Bi9eGx5DDe6BuuxnL9u1tJotrip2RWRAwgStzAblYwoPwE
         O0m+/2d1xdILkBg2+z9x04wra89EfEgkMu5KoXAtWuKahZf5wUPJZ4lrPCNmUxpZJdqn
         j7b0xrD4pyIDEW7+YxAP2nxea+iO16h7A7iF3ANqXQ4uT8UsQU+gT0KgWNXG1T1dgSrM
         vtqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4m3qHB6DdeBCgoxgHbY3XDj1zI1b/LO5LBOHI4piLpw=;
        b=EVTfIAC5Y04LI2kxdjB4meHaBK1dbSSVQI7lcr0mUg2ITi/rVWzV0tGGzOBkRhMmEC
         dj6mpQKlxG3XVuuiHsKHCBStC+dWCn1LxwHkdyLkmCPN+ZkSDz/JvEGAuy7ms3fK62tM
         qX/JTfIjS3P/bPuvAZ+fPZVoXQPOaeQXGcEDoq8hJwktRR8t4aK1pekjRIfwPQIz3hgE
         WfcB22I++YcXXw/Jw3ju7fTwbHV1wXRhIhCaR1qx0mtsc4MwMcsKqIvur3oIgTw3EHcv
         dEpUIfmOK8+w1sMoyXUOvnfZOHGE8nGiuYpuQKJeHBhm8D6v1mGvccxt4rFbyDlBOtnn
         5hLg==
X-Gm-Message-State: AOAM532vCK1py6Mr85SWA8fBBOdX0hD/hggSCE0lvXkP3mlDKO9hJ1+f
        ZHaN/0z0eTsM5PRk97nHemOsqTaIA2I4YXJ8JccbKwEMikU=
X-Google-Smtp-Source: ABdhPJwWUdpTKIcthk6Q0h7UdJhgQ4NeOqSOnJz40Y1DW6sj8aqEP2P5keMCs8Hzjt/B7e0rt29UUlrNsQavrrVWIcY=
X-Received: by 2002:ac2:5e36:: with SMTP id o22mr42783604lfg.529.1621246541851;
 Mon, 17 May 2021 03:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210515000058.204601-1-linus.walleij@linaro.org>
 <CAHp75Ve-dNqKprs-qsEDbKtZAh74Tdvbggwj5p6W9Akt1=01FQ@mail.gmail.com> <fc19cd14-6909-c88b-3fa1-84128b86221a@redhat.com>
In-Reply-To: <fc19cd14-6909-c88b-3fa1-84128b86221a@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 May 2021 12:15:31 +0200
Message-ID: <CACRpkdZ9TMYeJrNKU-nhd30-K7sRMu=7Eh9hOsSORU8p++fqdA@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: st_sensors: Support generic mounting matrix
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Daniel Drake <drake@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Hans,

thanks for looking into this.

On Mon, May 17, 2021 at 11:23 AM Hans de Goede <hdegoede@redhat.com> wrote:

> So now we to this devm_kmalloc both in apply_acpi_orientation() if it succeeds
> as well as here if apply_acpi_orientation() fails. It would be better to just
> stop kmallocing it all together in both places and just embed the struct in adata,
> iow make adata->mount_matrix be the actual iio_mount_matrix struct, rather then
> a pointer to it.

The reason it is just a pointer (IIUC) is that adata is shared across all ST
sensors, including accelerometers, gyro and magnetometer (which may
indeed use it) but also including pressure sensors, so there it is surplus.

That said, I don't think it's a big deal, a few bytes less or more, so let's
take that approach.

Yours,
Linus Walleij
