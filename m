Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998633953C4
	for <lists+linux-iio@lfdr.de>; Mon, 31 May 2021 03:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhEaBuX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 May 2021 21:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbhEaBuX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 May 2021 21:50:23 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0BFC061574;
        Sun, 30 May 2021 18:48:43 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id c31-20020a056830349fb02903a5bfa6138bso2748307otu.7;
        Sun, 30 May 2021 18:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o9uHZUYuo+yV5/DqSfe9QUFOUckyCZOcmcmbsp3ZHvs=;
        b=iQyrLyU6d+GL0TV5DxOk5BD5wFRKanmvccuXNUBmeU8Id/MWAtIYzWmhoI7eDB7yw5
         NUGnox704j/V5aswtLjS+6ZLp/qAcK9lfFea2bnNRAQKTnZXUpxmdx0FUVM1yjPu/EeS
         4RMXse3J10yl+z13FEoVVC+kvyJn30at/kNSW4B/Gk+DlnVpHD02Uwp7vgmzbLHrmOEZ
         KRmkqMExcOH1UOmFzLwwquSxQ6CLJlAjGiGIrS/FlSddUTt6DkCV6rsaGWJ3pZCL+MF3
         IHtZIJoWwz+mSiYYNhg835nO6pY00sRtn3InJviWGHH8m5MlmaZQcfpk9Nkyoxqm4s3g
         HyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o9uHZUYuo+yV5/DqSfe9QUFOUckyCZOcmcmbsp3ZHvs=;
        b=qZJWogn7iKYGR8O5Zw+pM4o7KS3o9tKYgENaYK8qmdDQeOVbeGbAZqNp2/Se8MGUh0
         ThDuAGI5NLhX7OeVH6TZlpFd3NS0O9NPkiU8I8KgudSBIh0OiyoJzEztGe2TvAC3zuOL
         ZFrl86p6pY195GYmLNnzbcBMo/VUKdJwe5116mS60AiilBqKo4qTN2NZf5qoSMbmtwm3
         sJKSN6cgac+F/NXh5IsffkDzBENwCPcTMhwJEHvtlOk+2SGAUXOo608X09usTynZoM6g
         R8vC3obrwefjJWPyNiJCPod2j76nF5exp1YZoqccKn3i1CMyJcdHj91/wn+yXGmBX1xG
         gUww==
X-Gm-Message-State: AOAM531xyNx/RSY5GneiyWjNj+mLMC+u7r/kCsTWXLrS8diNu3tU5BAt
        58GMa9fQoAFqgal0jy2Hkv6I9F3JGr1nxqC99rM=
X-Google-Smtp-Source: ABdhPJyl8cG9i1nvWMuvpFnAKKYEmtdZZPT6V+TyQqwXeIvGUcYHhT2ZPwQnB2p2U7NNtPQ3JFSi4f5q1z446ZQqiBs=
X-Received: by 2002:a9d:7a9:: with SMTP id 38mr6428408oto.362.1622425722686;
 Sun, 30 May 2021 18:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621786036.git.lucas.p.stankus@gmail.com> <20210526180717.23d13296@jic23-huawei>
In-Reply-To: <20210526180717.23d13296@jic23-huawei>
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
Date:   Sun, 30 May 2021 22:48:06 -0300
Message-ID: <CACKVXZA5jLLUugreowQJYndgN8+zG8T99ubkpu6utVC4GwADzw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] staging: iio: cdc: ad7746: initial effort to move
 out of staging
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, May 26, 2021 at 2:05 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sun, 23 May 2021 14:11:35 -0300
> Lucas Stankus <lucas.p.stankus@gmail.com> wrote:
>
> > Tidy up driver code by removing vague comments, simplifying probe
> > return, and extracting capdac register write to a separate function.
> >
> > These small patches are a starting point for improving the ad7746 driver,
> > hopefully to a point where it's possible to get it out of staging. I'm
> > looking up to feedback on what could be improved to accomplish that.
> Usually the easiest way to get such feedback is to propose moving it out of
> staging, (with move detection turned off in git format-patch).
> Then we'll review it in a similar fashion to a new driver.

Oh okay, sorry for the unconventional patch set then and thanks for
giving me the heads up about the format-patch flag, I'd probably get
that wrong if you didn't =/

>
> Starting point though for any review is ABI.  Looks like there is some
> custom stuff in here which either needs to go away or be properly
> proposed and documented.

Nice, I'll look into that.


>
> This series applied to the togreg branch of iio.git - initially
> pushed out as testing to let 0-day poke at it.
>
> Thanks,
>
> Jonathan
>
> >
> > changelog v1 -> v2:
> > - Dropped num_channels fixup patch (applied from previous series).
> > - Split general code style patch into several atomic ones.
> > - New patch to catch capdac write boilerplate into a single function.
> >
> > Lucas Stankus (3):
> >   staging: iio: cdc: ad7746: remove ordinary comments
> >   staging: iio: cdc: ad7746: clean up probe return
> >   staging: iio: cdc: ad7746: extract capac setup to own function
> >
> >  drivers/staging/iio/cdc/ad7746.c | 58 +++++++++++++-------------------
> >  1 file changed, 23 insertions(+), 35 deletions(-)
> >
>
