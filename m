Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12757339909
	for <lists+linux-iio@lfdr.de>; Fri, 12 Mar 2021 22:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbhCLVXs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Mar 2021 16:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbhCLVXq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Mar 2021 16:23:46 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE042C061574
        for <linux-iio@vger.kernel.org>; Fri, 12 Mar 2021 13:23:46 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id f10so3883102ilq.5
        for <linux-iio@vger.kernel.org>; Fri, 12 Mar 2021 13:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m4dUhRPgwvR6514Yqwy95xcRdtxSJsYD6PiYtKpsc6k=;
        b=lSq4S3+IwqMbfHhfNyqK4OtaSKgVhsQ1SAfZ6ThWxskkCfec5K85zfC9e8Pngrog/l
         SMt6UPt7oFTMDT444LkDL/ybE4h5DB7D9FD1GsXgAXhGMF5z9PZUu7d07UWhP6L/aymf
         medNVfjqDIBiC543XfHpDWgmJhtswlTr10Yas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m4dUhRPgwvR6514Yqwy95xcRdtxSJsYD6PiYtKpsc6k=;
        b=L3rHkCNUu5oS3VjxglHb98DI0Erp9R2/l5KFl+2Pim1btIEpFM4KKK/gxk8JLF1hIb
         mDOQVa1XDO/0iItSjzOPgoo3g0Cm6OhlwZwuw2gPSqRkbJTd4bmIZdFKnPPqFCeJA3De
         2U8VA/5lQrRhW2gxMJzeQcrwFTbHqi3zLNWupkHCq1Wirl851f2sprf0B45aq9KbX3zn
         Py84iVaYKok0oNkkA5CGNgZyQhv84QSXhbKunRsFf8s0dp4uYHVqMtyXef5QKf8KLX0d
         pBKHTZWYZio78Az1Cz9vSlQ9L64vXpc/Ra8jFkqjyX6naxBRYnM0uNQdPvIysanznBt4
         Hk5w==
X-Gm-Message-State: AOAM532o82FEXDU0pDZ7b5AFSnQye/hoFRp9o4+3R4rJcYy/foQf30ze
        RGZyw6KBooTP2dIKiLM1IVJ7M/5h0CfwgNgjHDpjNU9C37ukdg==
X-Google-Smtp-Source: ABdhPJzab4zZ/ouHYzM7t59+GY64/Gxc/rhhlHYCUT+THom3AyuTi4frDzmJnTc45UlC26Nyje29GRVmam+CukQOJww=
X-Received: by 2002:a92:d5d2:: with SMTP id d18mr3927676ilq.50.1615584226260;
 Fri, 12 Mar 2021 13:23:46 -0800 (PST)
MIME-Version: 1.0
References: <20210211024601.1963379-1-swboyd@chromium.org> <20210211024601.1963379-4-swboyd@chromium.org>
 <20210214124809.4abfa363@archlinux> <161333519805.1254594.18000613822693540497@swboyd.mtv.corp.google.com>
 <20210221155314.56f55e85@archlinux>
In-Reply-To: <20210221155314.56f55e85@archlinux>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Fri, 12 Mar 2021 13:23:35 -0800
Message-ID: <CAPUE2uu90ySZu6iyanakBZ+Oy-1YSTaHwBaeZdnUxK3ncW9BZA@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] iio: proximity: Add a ChromeOS EC MKBP proximity driver
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Feb 21, 2021 at 7:53 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sun, 14 Feb 2021 12:39:58 -0800
> Stephen Boyd <swboyd@chromium.org> wrote:
>
> > Quoting Jonathan Cameron (2021-02-14 04:48:09)
> > > On Wed, 10 Feb 2021 18:46:01 -0800
> > > Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > > Add support for a ChromeOS EC proximity driver that exposes a "front"
> > > > proximity sensor via the IIO subsystem. The EC decides when front
> > > > proximity is near and sets an MKBP switch 'EC_MKBP_FRONT_PROXIMITY' to
> > > > notify the kernel of proximity. Similarly, when proximity detects
> > > > something far away it sets the switch bit to 0. For now this driver
> > > > exposes a single sensor, but it could be expanded in the future via more
> > > > MKBP bits if desired.
> > > >
> > > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > Cc: Benson Leung <bleung@chromium.org>
> > > > Cc: Guenter Roeck <groeck@chromium.org>
> > > > Cc: Douglas Anderson <dianders@chromium.org>
> > > > Cc: Gwendal Grignou <gwendal@chromium.org>
> > > > Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > >
> > > I'm fine with this, but want to leave a little time for others to take
> > > one last look.  We've missed the coming merge window now anyway.
> > >
> > > If I seem to have forgotten this in a couple of weeks, feel free to
> > > give me a bump.
> > >
> >
> > Ok no problem. Gwendal had some comments on v5 that may be applicable
> > here too but I think they mostly mean that the resume handler may not be
> > needed if cros ec is fixed. Having the resume handler shouldn't hurt
> > though unless I missed something. Gwendal?
>
> @Gwendal, could you take a quick glance at this, or alternatively let
> us know if you need more time to get to it.
It will work as is.

Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
>
> Thanks,
>
> Jonathan
>
>
