Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB042DC3D8
	for <lists+linux-iio@lfdr.de>; Wed, 16 Dec 2020 17:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgLPQQO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Dec 2020 11:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgLPQQO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Dec 2020 11:16:14 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815FDC061794
        for <linux-iio@vger.kernel.org>; Wed, 16 Dec 2020 08:15:34 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id w5so17187214pgj.3
        for <linux-iio@vger.kernel.org>; Wed, 16 Dec 2020 08:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2PGmCcZ5RabcdUP1zgSfZrbHaWSgFj4kMy2RDtFKg4Q=;
        b=P9Mah9Gsgjg945DLHraQ8GxTnXzurXlIHBvM6Ao7ywzAVaFAueN3omArtW7yLl3S0T
         dhtCKuOhUpOtomT7GFWD2JlbYZ6Y6GB2iFb1ZGaLI3mPE7I4Qzz1gDTmm5BmQ+IIQUNa
         VjC9Gph7MLrSvZBjKfGpOho5L1zh2DvxNJnsnZzRXvMWQaHH7rhlujgGXzdeFTq0VOZc
         QsDYqTyrBU+iPfgwjFEjFBxrueB4fC4GaQHU3css897P3svypU7MhUc/jbRFj3FaAYUC
         40IWE+hywMrY5GQq0DYd/0Nrcip3sKbYsYGYIUVCldze1CAO2RgBsG8WmndRDX2ZMABl
         /NNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2PGmCcZ5RabcdUP1zgSfZrbHaWSgFj4kMy2RDtFKg4Q=;
        b=YECR4VcoHLU+QJ0D1N+HvBvQRhWtsTntuvT6izNPRfDEgJEUiY7mFzd3pO4OVxHaLO
         3YnM1Jc5RJyeVqhYrwujh5jINSbtoOHtkCHLXOK5PKr5G6MiLk/7kd7GnU6Yl1j49kvS
         dj8YeL2Y6zPHwb4ccKm3aL4+b9EJaKs4d5UB5i7EOm1Jl7S2jRCrXe4MyuFKj6BedWrQ
         W8p65oADfYpnFI+kylH2JHcfaQZJmfKo25YMkv/MCAhgR7KIJV4jspKcgvSdQgwbA3FS
         OnCB0OkW9OiCoyrVsfrQzz93nw9iS89dqtl2+nYsqH2zpcZ6+48HrXsceRVeV3ZG4y+z
         o2uw==
X-Gm-Message-State: AOAM5301ItktM5V1MbWg9r46k2QRJymuueybjr99RlakttcDjnuru/Vm
        UqMQce9O+CyGVVZWwm7192zhqEcwuqACWxuW5Ik=
X-Google-Smtp-Source: ABdhPJwGXGKjeuvAZ2awwz9hKlRFZQv5G+/62qSakxvN+XBBLy48p5x1RSYALTSFDdsJmzx3CbcyrZuOKO76boCVmhI=
X-Received: by 2002:a63:b1e:: with SMTP id 30mr33728685pgl.203.1608135333969;
 Wed, 16 Dec 2020 08:15:33 -0800 (PST)
MIME-Version: 1.0
References: <20201216115720.12404-1-sis@melexis.com>
In-Reply-To: <20201216115720.12404-1-sis@melexis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 16 Dec 2020 18:16:22 +0200
Message-ID: <CAHp75VepZXexqSbP7P5xyUDQk_8jbuuwW93ne051Nhn1F_J=Cg@mail.gmail.com>
Subject: Re: [PATCH v5 0/1] Add delay after the addressed reset command in mlx90632.c
To:     Slaveyko Slaveykov <sis@melexis.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Crt Mori <cmo@melexis.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 16, 2020 at 1:58 PM Slaveyko Slaveykov <sis@melexis.com> wrote:
>
> The MLX90632 needs some time to reset properly after an I2C addressed reset
> command. Thus a delay is added in the mlx90632.c.
>
> v2 adds comments as advised by Andy Shevchenko.
>
> v3 changes the comments style so that it matches the preferred style
> for multi-line comments as suggested by Lars-Peter Clausen.
>
> v4 fixes the comments style and it uses the appropriate usleep_range()
> as suggested by Lars-Peter Clausen.
>
> v5 Commit message and comments stylefixing as suggested by
> Andy Shevchenko.

LGTM, thanks!
For the future it's not necessary to have a cover letter for a single patch.

-- 
With Best Regards,
Andy Shevchenko
