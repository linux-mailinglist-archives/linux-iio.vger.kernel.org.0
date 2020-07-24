Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560D022D185
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jul 2020 23:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgGXV41 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Jul 2020 17:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgGXV40 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jul 2020 17:56:26 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB8DC0619D3
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 14:56:26 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id o25so3431643uar.1
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 14:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wu9Z19uRtGtJ0NasFeWEnBkj7jELCMCGAKW7BoOuLmA=;
        b=CpGLRpEhHAWmIvAZYKn0xvAoo10wA4C9CeUytti2gF630AeKnqsyVJEJzVOwEeJheO
         aNgiUp32xACS0QVxGpuCCGANOs2ewM3UJio6fp8tOoFT4Ait2UiUBODk2u6763JCuFqq
         PUmmGifrKE4B8YjocgrEo9u0+Zes/x2Bv2n2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wu9Z19uRtGtJ0NasFeWEnBkj7jELCMCGAKW7BoOuLmA=;
        b=Cmq1LsvVIqFgkjrbWmU2JSB7TOJP/Sb4kQEE43USX0F7f5tiJxhEXCr37xmZ1JHxef
         B1kXxzD7jrFPVkLDKZm2mSoOxNeXjnKPNDybWGoXDyQFI7Bu1NYCmUia3wp70SvvC07W
         sSw38ZBVS4yCymXNt43lCRlZF5HKlmDz6uMAxWvp+3jgA/OmeyspJEP6AIYyvdhu9tfj
         UypoItmiRrliGfUvz/U+vizvIqoaA2FN8ev623o7k7ojSELbpRVJKGvyMpO/q//EDn8i
         IgSN6MmUQmh6A3ZjJuvq8q4UpmD8PqQkfvX2Q1KkyGxX0U5PeR0hXwTpS2ZdJzhfJuWf
         zPag==
X-Gm-Message-State: AOAM533vtrKGSI/16em0Rm17JXt0qWh2/+paM0xmSrb3dyiBdaflk1ii
        O6s7HQ+3w5D2BKYHK/Zf183eIxsM9ts=
X-Google-Smtp-Source: ABdhPJy2Ge5v2cVf7DXQbWwQxNDzkOXnb6UMXAASXO/0KeXmXLLT9pR/G9ddeQbt1nXlUOuC3+CJhw==
X-Received: by 2002:a9f:21a3:: with SMTP id 32mr10031572uac.50.1595627785368;
        Fri, 24 Jul 2020 14:56:25 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id b124sm285598vkb.0.2020.07.24.14.56.24
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 14:56:24 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id b26so1116017vsa.13
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 14:56:24 -0700 (PDT)
X-Received: by 2002:a67:e046:: with SMTP id n6mr9513301vsl.6.1595627783920;
 Fri, 24 Jul 2020 14:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200724213329.899216-1-swboyd@chromium.org> <20200724213329.899216-4-swboyd@chromium.org>
In-Reply-To: <20200724213329.899216-4-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Jul 2020 14:56:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WQUpfjk7r-w5f0uP0Xnx39Mv8WxLfjfwxfNoGa_1XBvw@mail.gmail.com>
Message-ID: <CAD=FV=WQUpfjk7r-w5f0uP0Xnx39Mv8WxLfjfwxfNoGa_1XBvw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] iio: sx9310: whoami is unsigned
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On Fri, Jul 24, 2020 at 2:33 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This is an unsigned value, actually it's a u8 but regmap doesn't handle
> that easily. Let's make it unsigned throughout so that we don't need to
> worry about signed vs. unsigned comparison behavior.
>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Daniel Campello <campello@chromium.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Douglas Anderson <dianders@chromium.org>
> Fixes: 72ad02b15d63 ("iio: Add SEMTECH SX9310/9311 sensor driver")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/iio/proximity/sx9310.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
