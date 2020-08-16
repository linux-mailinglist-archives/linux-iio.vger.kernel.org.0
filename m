Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22BEF245729
	for <lists+linux-iio@lfdr.de>; Sun, 16 Aug 2020 11:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgHPJzs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Aug 2020 05:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbgHPJzr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Aug 2020 05:55:47 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2E8C061786
        for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2020 02:55:47 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id x6so6622405pgx.12
        for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2020 02:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+y2GCS92Ae8m/tD9Xhcmw/4TjcV71r3C073aG56k5+Q=;
        b=Ds72LMrRjA3sC9dkOH7fDpkNbbl6Fh/ELdmHIVA42e9izmeWTX7YQ7Fj9+H1dZAsjs
         Je8c6vupzKtn1z44/FKSWF3hSLarh6Uo3oJ5iT9EgNsh1pLMOT42pVR+DAd9OPYX79NH
         orNf6+Bx6NgKJXCLwVPd3E64Q4dAshvanJ5Ta56+tmbWpqJUwXfsJRS+pIh4ko40wUWX
         lRriO8OaSCq4GZvCIBn0B521Idx6AO8j13cQnxxgDKXtFCX5CxchjWP20RGZnFUtB4A7
         LyhNlrsH3DzUF6ksZwTdpRRYrLUYTiiAKSdJe0XTDJ1QyPJJTVibDewm4pB+tHFlqvX6
         t8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+y2GCS92Ae8m/tD9Xhcmw/4TjcV71r3C073aG56k5+Q=;
        b=WYKl/UY7H7yL9J+8NQBlL4j8VPj1mCgoKCWdU6DOCuQN+kcbe4QtPlNhztamv6s7XK
         iOzqmJg4qXSVZY5U3hT//ACfi0P3EUx5FVKkuvHxJD+4F+abkNZOSRnCU/Ih7ts8hjNf
         hm/9VSnlrL4e/GspSENPJoCL65/rzPX85SgsSaXyZXd8mYD/sAeJA2ZNTZV8o/OCXjch
         HzXZhVLdeSmX49hoOl4Rg4iXpYKVT9pxzRJBhxYvh9uZnmfIoqwraM6mV42NUhO8fyuP
         QLvjK4t3McmP3M2vkNlYFmnXpIK8v315eKyjoqi5O9fN783BzJN7W7j8OOhzuZzwe7Ks
         dp7w==
X-Gm-Message-State: AOAM532TPbA57GbbjcbKO2c9HokT4/hzBIQOR6740DsdQz6JXfDdlxyS
        4qdq7RbN/DbnfW5dp0w0tm9AAeYvVauLdcPBXybfUasCeR+zsQ==
X-Google-Smtp-Source: ABdhPJywSoIGJLZC7uT0F7PA2MJt/yUQsNnl/l5hAT/IRu48jMnNWk+ZseRKxi9Ntiq3m5TANPNFrZJ0tjNbD+FIMbE=
X-Received: by 2002:a62:758f:: with SMTP id q137mr7465236pfc.170.1597571745696;
 Sun, 16 Aug 2020 02:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200811134846.3981475-1-daniel@0x0f.com> <20200811134846.3981475-3-daniel@0x0f.com>
In-Reply-To: <20200811134846.3981475-3-daniel@0x0f.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 16 Aug 2020 12:55:29 +0300
Message-ID: <CAHp75VcreDeik-pCQPXV2RQVAEPFNRjGS8Mutvxwog1khVka4g@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] iio: st-accel: Add support for Silan SC7A20 and SC7A30E
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 11, 2020 at 4:51 PM Daniel Palmer <daniel@0x0f.com> wrote:
>
> This chips are not from ST but seem to be clones of the ST parts.
> The register and bit settings in the datasheets match those in the
> LIS2DH datasheet.

No SoB tag?! Hint: `git commit -a -s --amend` would fix this if you
have properly configured Git.

On top of that, can you add Datasheet: tag with links to the actual
component datasheets?

-- 
With Best Regards,
Andy Shevchenko
