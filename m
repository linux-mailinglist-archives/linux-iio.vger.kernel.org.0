Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278AB482A5F
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 07:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbiABG5b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 01:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiABG5a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 01:57:30 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B09C061574
        for <linux-iio@vger.kernel.org>; Sat,  1 Jan 2022 22:57:30 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id h2so58098737lfv.9
        for <linux-iio@vger.kernel.org>; Sat, 01 Jan 2022 22:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jgvINhNLUS9ouJWSXS29IEZEjftN82fIlZJjcxzbPrE=;
        b=e8QR3/EBmQ+H+vvm8HnNMXYb2LiU/upr/aLtZAPt7mPIvkRModbl+XGEED6mIge6bk
         Us1oi4Wr9sUydBDGwC+atfssk8K0/1Tiy3vWLilFbM9drW4IHjl3cvmoVO7J2Qmcb0nB
         Hy6c4HmDqPMuxNWz51KOSDnz5N+rBsf753i6CNYi72HLc+b1DmdCZWc+/F9V9LF8CNhM
         q+Q7bFrOiCdwGy1LIGdLxY7crtG5W9VwhSMKapom0Hyuw0F5+Xja8UtgVtu5+dssbmoj
         cu0iigQviFMsfdwIQpexifEYXwbLpTL9giWgCq40kwjwASM+S2VV7cbNOgeh7BlEujpr
         TsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jgvINhNLUS9ouJWSXS29IEZEjftN82fIlZJjcxzbPrE=;
        b=USd4W1BC6xyLq3h+e8rjLTOBtG+YrKYvocydlTLLSrdPz+7nWGCwRYNfg4Qj4s/Ows
         TdUbD6OmM8B/HjPZ4ozalv+cgu9Fz2tnXxDVw4yfmNdcLXXlPnK2Pg9f4w+wYt0Vapuc
         iZ4+hJDBXU/KKXeLIkWdbgOjvlgCk6PSTHM6ZnO27uIertnneSxOjHV9QaqGDPphZ1t7
         Rgv8HtkecpfPe6ugrV6DUd2HrIvBtloGPF1NBWqM5IEbt+WPg7jXplsrn/E7uHoH+inp
         lQiJ6VLaWJHfRrc9gMEH1U9yUYgVb8p2SBI+QDM0ROEaIZMoh5YW2zi2EPAO36DkLs7f
         Tspw==
X-Gm-Message-State: AOAM531VQVrnL4JLumOuWpSRURH46ftvQEQrHsesqno2M/Pt5s86d/LQ
        NFSqFh8e8rKRDtAy9cg5u5FuKDv58tE4lWuYo3I2Lg==
X-Google-Smtp-Source: ABdhPJzsVlVjZUNwiqYZtZ2Q8HEdxcJ03NDqZ4/bDDHl91429NviVmMx/Ynn4SZ8sR+m3iVXa0Ar8tLe5YzGwTrlWXk=
X-Received: by 2002:a05:6512:2303:: with SMTP id o3mr36890823lfu.362.1641106648659;
 Sat, 01 Jan 2022 22:57:28 -0800 (PST)
MIME-Version: 1.0
References: <20211230193331.283503-1-jic23@kernel.org>
In-Reply-To: <20211230193331.283503-1-jic23@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 07:57:16 +0100
Message-ID: <CACRpkdbRtsZHzPsfLcQCSwSh5mfcbt73asH8wwk3A-t+UZigJA@mail.gmail.com>
Subject: Re: [PATCH 00/13] IIO: accel/st-sensors move into separate symbol namespaces
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Sean Nyekjaer <sean@geanix.com>,
        Denis Ciocca <denis.ciocca@st.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 30, 2021 at 8:27 PM Jonathan Cameron <jic23@kernel.org> wrote:

> https://lwn.net/Articles/760045/ provides a good overview of this feature
> and why it might be used.  In this particular case we fall under the multi
> module case.  For each group of modules, I've moved the exports into
> an independent namespace.
>
> Whilst I'm not entirely sure it is worth the noise of moving the main
> IIO exports into a namespace, it is definitely worthwhile for these small
> clusters of related modules (typically a core + i2c and spi modules).

That's clever. Something similar can be done elsewhere in the kernel
too.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
