Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D7E342169
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 17:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhCSQAL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 12:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhCSP7j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 11:59:39 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305AAC06174A
        for <linux-iio@vger.kernel.org>; Fri, 19 Mar 2021 08:59:39 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id x184so6194560pfd.6
        for <linux-iio@vger.kernel.org>; Fri, 19 Mar 2021 08:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rMFmyuCkEUWBooj86yRGyWDShFeOV2hGlv8wDM3g/vE=;
        b=FWXqFatYKJ8Iz6eKPjCIXNac5sgN0ds/UgjwTsGLgZBCLMMpzJAcQnFvtcD+rM/VMj
         FqS6CI3ROboJJdDfBrO8g8nC9RLNT4u0QX/iC0HliWcIzBr34xI10DDB0TOYCVRfIFS9
         0FkPxWIJxpgmExR/EWf1oYBO7KCIb9rIsxqN+TkxZGMeC/2hQU1RWiVGRWs+CEPH18n5
         fMTd2/ArxpP+zrvlRVRB3mLc7YPc1pbHA/m4z/4aaLvCPynYGJzXoMEvuf5NkoK8yWDC
         +owcliTJxoOLhaZ2Q228sF9+Y+T5cyi8ikQVDcwwWiqXCwoC/ZCRoSNWYDjMKmHLZ7Xe
         DxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rMFmyuCkEUWBooj86yRGyWDShFeOV2hGlv8wDM3g/vE=;
        b=cXPr16B41kOTGGwiN8m+ZIPEga9lrAOgqEdcztwTO0LKn+uQ0vPZI8vKHTKV+NBq0D
         e+vFbH475ErUJyoFL3vXezd6liyS/SZUjeUxWUJmt4tZixDwIiCIYvwIFfJ89K6qrnQp
         FNFt8k1zv2JOTAdrXpIuZjfprAmdpXMuNj8a95tOejylHCSsxn/B2HxVWLKCKk0GT9ik
         uUVwb6YQ96LIqMZHhsvTmpasWVUKNvNem3LixRKWk2jboBy6L2qigISijjfCSAq/X+CP
         2FxiWz7JJG9bPyWnuaH4fl5NeSpn+88s5LFlaONhLLOHWRMrUAk5kgK+BaQ2xSi9BlNG
         GIAg==
X-Gm-Message-State: AOAM532KtH4+K3XURSAN17S27Q1Aqk7+t5UZtbBlY25TnmqbXXBjbisL
        YQ85XhBrkrTzuxbXL73aFypncZYCn/7StdC1m2g=
X-Google-Smtp-Source: ABdhPJyqxbH7edCxaHqkV1JhvUN8QDn+DBBWzgTzq5b8YJhUw0y9eHw8sZj5gJiCTkw7aDAiQ+s0wN6cKws02pKeDh0=
X-Received: by 2002:a65:4c08:: with SMTP id u8mr11792110pgq.203.1616169578555;
 Fri, 19 Mar 2021 08:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <77dd5cfb-1215-e929-24cf-2b773f33d2ef@cern.ch> <c41ae3c7-ce3d-9036-280c-b25354bea22b@metafoo.de>
In-Reply-To: <c41ae3c7-ce3d-9036-280c-b25354bea22b@metafoo.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Mar 2021 17:59:22 +0200
Message-ID: <CAHp75Vep4q3J1YFscFyZM18ECBx1f1rGj7_mbwcSha9TpwHT7A@mail.gmail.com>
Subject: Re: IIO advise + help
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Michel Arruat <michel.arruat@cern.ch>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Mar 13, 2021 at 12:56 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 3/12/21 5:54 PM, Michel Arruat wrote:

...

> > So far we are using our framework named ZIO which was developed more than 10
> > years ago, when IIO was not mature enough to handle high speed constraints,
> > large DMA transfer(>256MB) and zero copy.
> > Out of curiosity https://ohwr.org/project/zio
>
> I did have a few discussions with Frederico and Alessandro back in the day
> (maybe 6-7 years now) about what can be done to combine IIO and ZIO.
> Unfortunately we couldn't quite get agreement on whether it is better to have
> one or two frameworks.
>
> One thing where IIO and ZIO differ is that IIO is more around streaming data,
> while ZIO is around packetized data. In ZIO when you capture data you get a
> header with metadata.
>
> But having support for packetized data with metadata in addition to streaming
> data is something we wanted to have for IIO for a while now. Just nobody has
> implemented it yet.
>
> I know that there are a few people that use IIO with packetized data, but it is
> sort of in a hacky way where the userspace application uses the streaming
> interface but captures exactly the number of bytes that are in a packet. This
> sort of works, but having proper packetized data support would be nice.

I'm wondering if there could be some industrial standard for that,
like the MIPI standard for tracing data.

-- 
With Best Regards,
Andy Shevchenko
