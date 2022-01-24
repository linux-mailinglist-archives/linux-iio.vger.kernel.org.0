Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07BF4978C2
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jan 2022 07:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbiAXGA7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Jan 2022 01:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiAXGA7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Jan 2022 01:00:59 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BE8C06173B
        for <linux-iio@vger.kernel.org>; Sun, 23 Jan 2022 22:00:59 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id a18so12942588ilq.6
        for <linux-iio@vger.kernel.org>; Sun, 23 Jan 2022 22:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8JffJJFrBnzhGwDiFeFwSxkXPBMfPK+AIrTzAFlar64=;
        b=YlWZUzeupRcbiEBD1zJRRGRqMDQsWwGzNv1GJI5+8dNlEZ71QpTpNgMVsTWYQ43CM6
         9duNpl3qYNt/cI/lfumtlJti3vWy5V4IMz8aZ1OhQlc7tSEBG+/gO0EgyfxStgqujnJw
         Ps08jI0gc/bi7oF8Neb3/DKuWoSvrcTfptH1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8JffJJFrBnzhGwDiFeFwSxkXPBMfPK+AIrTzAFlar64=;
        b=SaeA0C/bIs9iuuWsFEnQY/gjDuQZMO4xWboiukeqPxY3HderNf5PG0ws5TyU6j+lfl
         x/J5y9UxTCLkWeLWstI9OAN6TMIv/hKXbND86k9UHSpYhFlGU4b/7mPRtImNsB+pSJsd
         lrfhxXqxlrfm1JfDPZRuU+51yh+SNelZYGJsqy8ANbF5BVyLfJ9g9whmTr/mA+5I21f7
         WS567zox7cEbU7YMnfxoJPSieLvSie5z3wKQu0E+le88tGMVdLpPBq07Hnrvx9iG7GSN
         laFwkc5o89ZHpbmu1UJbZxOm/wSBAAX01vsQwtH2Mp6p076V7YADB1XC9owSyflR9nM9
         ZNgw==
X-Gm-Message-State: AOAM530fRcDpCjRot1yxpgC7uVFFeQpIxjJPuUFllOjA1ykAXvnuYQlp
        +vZTJuBZcub7doF50UG+v913m8nBoZU5SZEIwkYozI8bT+qBQQ==
X-Google-Smtp-Source: ABdhPJyDkrtUHY3PfY7tcxvrlO7LSlI9l1Ja7Oqg9eJvGMQyWWPiigq0Di0z+sz+noisAat+lc+ZCPgtbVqBgX6jLLM=
X-Received: by 2002:a05:6e02:1183:: with SMTP id y3mr7393232ili.289.1643004058265;
 Sun, 23 Jan 2022 22:00:58 -0800 (PST)
MIME-Version: 1.0
References: <20220118212504.832429-1-gwendal@chromium.org> <20220122172940.125d8033@jic23-huawei>
 <CAHp75VcRFRVOPvgGROiNM4wQurTDn+D-DSc0oU1YsrgkkNOF6g@mail.gmail.com> <20220122191403.22364523@jic23-huawei>
In-Reply-To: <20220122191403.22364523@jic23-huawei>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Sun, 23 Jan 2022 22:00:47 -0800
Message-ID: <CAPUE2usUT5dkKE0+gJ3EAmFMrzrAVK0=TEFPQtJWGBb0t-nr6w@mail.gmail.com>
Subject: Re: [PATCH] iio: sx9360: enable push iio event
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        jongpil19.jung@samsung.com, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jan 22, 2022 at 11:08 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat, 22 Jan 2022 20:15:57 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> > On Sat, Jan 22, 2022 at 7:23 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > > On Tue, 18 Jan 2022 13:25:04 -0800
> > > Gwendal Grignou <gwendal@chromium.org> wrote:
> >
> > ...
> >
> > > > Fixes: f75095753 ("iio:proximity:sx9360: Add sx9360 support")
> > > This is part of the tag block so should appear.
Done: The patch is at
https://lore.kernel.org/all/20220122213444.745152-1-gwendal@chromium.org/.
Given the title change, it is not automatically connected to this
patch. I should have added a  --in-reply-to argument to my git
send-mail command, will do better next time.

Gwendal.
> >
> >
> > > fixes tag should be here.
> > > > Signed-off-by: Jongpil Jung <jongpil19.jung@samsung.com>
> > > > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> >
> > ...and the submitter's SoB must be last (according to the documentation).
> >
> Hi Andy,
>
> If it's a handling chain, rather that about co development etc then
> I'd expect it to be in this order to indicate that Gwendal was on the
> route to upstream.
>
> "Any further SoBs (Signed-off-by:'s) following the author's SoB are from
> people handling and transporting the patch, but were not involved in its
> development. SoB chains should reflect the **real** route a patch took
> as it was propagated to the maintainers and ultimately to Linus, with
> the first SoB entry signalling primary authorship of a single author."
>
> Jonathan
