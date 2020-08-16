Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808C2245728
	for <lists+linux-iio@lfdr.de>; Sun, 16 Aug 2020 11:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgHPJwL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Aug 2020 05:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgHPJwK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Aug 2020 05:52:10 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCC5C061786
        for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2020 02:52:09 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id g7so4925195plq.1
        for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2020 02:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VL6nq0qaTJ+GRJy40TipwrD+abMEw0hOcrvmfHdWqvI=;
        b=A8Te0aqwzwPCgWYaax2mMUropOCdy/MTbMBs97NSF3yJIcusfszw3FlgnoELgdGclS
         dkpLVaGzF6bUfUUycT8aDmDg+61H+hhfk/jBVXQm64W1ITW9wLhPTnAcJOxgkw6bw5Tx
         dowzKamfxQPCdPWDcgYl24EvDYSxC5qRzdhAMoWw4gZoP9GxExCwai/J8apPrllWcv8x
         6+0KbeE3yKGrxrDh9MK2jItUgK+w1T6sBRobppdt36lRImYxeKL8WS8m+XtuBaNYSUSy
         6k44LFQvaTlvE79kRhXTHRLPPB+wOtsu5aGcoIrniEk9xmo0c9+UIJZRQmK/RKKlrvpv
         m0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VL6nq0qaTJ+GRJy40TipwrD+abMEw0hOcrvmfHdWqvI=;
        b=GLlg9HxCz4VTZD4QPUZRrZT31m30wE+9Fr7LbcJYXhhGiG6xUgp6XN/gKduOh1MYkr
         vs7XNiUzpQrhn4Xsx4ajwFPCWMy9aekL0A+lGbQRrjYzQBFXPeJuLkroEBzMnFotCDVD
         ZVah+RMcozc8VwjP/Tvx8z30rbGe7Pq+PBPetEpXEM2B5dcyWoBDeR7gsK9LkRlFyjhh
         XRgxbXj6ZqNpLHtGxKTuzYGAnBrdlOiJbtaqoe0xxOrYYN/9/u9MRVg9wGegBBXYqper
         9PX2AVLQ3W7zb4cLDmTlARKKufuz1YYCRs7klkVckNTwZaGKnhXhgJWazAdITYCqZN4s
         TGPg==
X-Gm-Message-State: AOAM5337I6cpY+ITNpdIYH2OVO3PLbd5Uz5i6o7GvezOJPGol2VRCS3a
        n/0NwyxXzRDHDQyWrgKseS88r75nJ5aXKQQKMM4=
X-Google-Smtp-Source: ABdhPJz6Og47SJhJZ9IgxtouRJ//rzbqQyJD0Qf1voX09ih2pgbL6F6W3s6MYrwyK/bAECUT1MdvNW80bHxxUN3deA4=
X-Received: by 2002:a17:90a:bc41:: with SMTP id t1mr8181615pjv.181.1597571529328;
 Sun, 16 Aug 2020 02:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200814134941.10576-1-matt.ranostay@konsulko.com>
In-Reply-To: <20200814134941.10576-1-matt.ranostay@konsulko.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 16 Aug 2020 12:51:53 +0300
Message-ID: <CAHp75VeP24wrWk49Gic-fR72kU+1sBQD-OCW88ji1ZYShSsNXQ@mail.gmail.com>
Subject: Re: [PATCH] iio: health: max30102: update author's email
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Aug 16, 2020 at 1:06 AM Matt Ranostay
<matt.ranostay@konsulko.com> wrote:
>
> Update email to author's current employer

> - * Copyright (C) 2017 Matt Ranostay <matt@ranostay.consulting>
> + * Copyright (C) 2017 Matt Ranostay <matt.ranostay@konsulko.com>

> -MODULE_AUTHOR("Matt Ranostay <matt@ranostay.consulting>");
> +MODULE_AUTHOR("Matt Ranostay <matt.ranostay@konsulko.com>");

This is actually an interesting question, had you been working already
for your current employer?
If no, I don't think this is a proper change in the code (of course it
might require your new contract, then it's probably fine, I dunno). It
would be a good change for MAINTAINERS, though.
If yes, the commit message doesn't clarify this.

In any case, just my 2 cents for the future changes like this, since
the patch already applied.

-- 
With Best Regards,
Andy Shevchenko
