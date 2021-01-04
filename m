Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83AD82E978F
	for <lists+linux-iio@lfdr.de>; Mon,  4 Jan 2021 15:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbhADOqA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Jan 2021 09:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbhADOp7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jan 2021 09:45:59 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E5BC061574
        for <linux-iio@vger.kernel.org>; Mon,  4 Jan 2021 06:45:19 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 23so64782015lfg.10
        for <linux-iio@vger.kernel.org>; Mon, 04 Jan 2021 06:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XAIBa07AbDxyQykwJ3TkVwV3dGOjJR1n9+qkMdpUpXM=;
        b=pndZ4LyunCSLHZzHDkx3BhsXcDOpclFwnSdqzs4lVEYH7yaglIewtRKSWjfvTk5MGU
         YAybZZ5rGj0s9ju+5VftWGNrl9y8wzqfY+IE8QczTD5YArrN3b3QMKQcE7zTc7Q2bQ//
         yfonV3u9HIAhLc6zllkA3JDKkdGSMdtXnhfY7TUWYDUsU5DFKk/x6C+q9v3f01xSjQIQ
         rjUfAF3DNEmutvitxejRclHSXoGWOwY7YWlfoqMnwfCbaVjU3s+KO5WuEmYoPakJ3ByP
         Axz6vpbo135nexsxFBgOOh6vpa4xWLiholdiSDsNwgJMxl7pV2fCSa1cWPP4atgP10BX
         VILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XAIBa07AbDxyQykwJ3TkVwV3dGOjJR1n9+qkMdpUpXM=;
        b=lKPhLXkXCAHW3bHvoDyyyZNItXHOtnoBlcU9PozDRDbFWaSLlZvJCjMtms0Y1y49U+
         eEdVtUFmvK1YItnU5IgEl5LidXKSkI8z39E44VzF66QWvdIbRqD0byUq8+x18yLzw49f
         t/bFpyN5HU/gMM6/yR3hgIho5cYVSJHDPyO5DI80pjBC+1SUPhpnWqstMzAizSUqYogh
         /FFXyzkYn+4jEWqEU1e/hF2T0cYxSs3aVNVGqLbQCZG9s06x98tLSYd99FVPuG160eQH
         grA+gamJ1MJBJUmKJCAm+2eqGZSVmh0a8vK7i3oRIBaCWo98YIWSZwFxgiTJ0qqLwt3e
         mk4w==
X-Gm-Message-State: AOAM5306teH8/rTfylq817u/8CbMqn+Fg2DAr2gq8QlYrj4USJStUq9L
        9xJjWtLdvAHAo2ptAihOU69XFBt2eeh3t8qmBsCqTGGi8xo=
X-Google-Smtp-Source: ABdhPJzUEYopr5cgQNm5B87kRtAYf/6qlBtI1nkcUUvVQjVQFlpK6e+1ai9Yvobu5h7f6wq/eRoZa0IRRVYhKIo/Bck=
X-Received: by 2002:a2e:586:: with SMTP id 128mr38362085ljf.273.1609771517956;
 Mon, 04 Jan 2021 06:45:17 -0800 (PST)
MIME-Version: 1.0
References: <20201101232211.1194304-1-linus.walleij@linaro.org>
 <CACRpkdZc=qGasbsL7DWbbRGyvxaX8hh2iU-QfLpkYGCD3UrqOw@mail.gmail.com>
 <435ebb1b-431c-fdeb-023e-39c6f6102e22@axentia.se> <20201213121615.55a86f77@archlinux>
 <c34cc481-0244-a68e-8ae4-75e8e62b18bb@axentia.se> <20201214150728.00001fa7@Huawei.com>
 <e755c671-a212-e93c-427c-66ab031289c3@axentia.se> <20201214163423.00005e6c@Huawei.com>
In-Reply-To: <20201214163423.00005e6c@Huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Jan 2021 15:45:07 +0100
Message-ID: <CACRpkdbOx0AiFOejZ5gtjQwQNo-qzuRRNVDhjAbAk1pGLMj8Yw@mail.gmail.com>
Subject: Re: [PATCH] iio: afe: iio-rescale: Support processed channels
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Dec 14, 2020 at 5:34 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> On Mon, 14 Dec 2020 16:30:22 +0100 Peter Rosin <peda@axentia.se> wrote:

> > >> And that gets transformed by the
> > >> rescaler into the processed values being presented as raw, with rescaling
> > >> added on top, but with the read_avail info for this new raw channel being
> > >> completely wrong.
> > >>
> > >> For the intended driver (ab8500-gpadc) this is not the case (it has no
> > >> read_avail for its raw channel). But it does have a raw channel, so adding
> > >> read_avail seems easy and I can easily see other drivers already doing it.
> > >> Haven't checked that though...
> > >
> > > Drat. I'd failed to register this is one of those corner cases.
> >
> > I'm not sure, I just browsed the code. Maybe I misread it?
>
> It's doing both - you were right.  I think there are only a small number of
> drivers that have that history.
>
> Looks superficially like it's easy enough to catch this corner case and
> block it - so lets do that.

Sorry if I am a bit confused here. I don't understand what I am supposed
to do to proceed with using this driver with the ab8500 GPADC...

Shall I fix something in the AB8500 GPADC as a prerequisite?
In that case I think I need some more pointers...

Yours,
Linus Walleij
