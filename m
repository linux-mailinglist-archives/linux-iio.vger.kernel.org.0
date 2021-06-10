Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D80A3A2C41
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 14:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhFJNBN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 09:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhFJNBE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 09:01:04 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC37C061574;
        Thu, 10 Jun 2021 05:59:08 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id k15so1557136pfp.6;
        Thu, 10 Jun 2021 05:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kZv55UI1lotbt6zxOJeYG+FLk45h3yJ74p2M096WCtA=;
        b=U5+g07bCY5xpjLYOIJ95c7kfKcGWVCukCh/hkexG2hfL8FpBgSB2XB8hPvcoWyzQs6
         os0gvieM9b0xaQO9vUMjxpBrTVs8ZIw3qa2i3t1VYFGaucT+heTHWAUEC+S92Jseeuy0
         oaRMs2pljiVgfpiDW6SVLfmtwmW8CLEheAZYFgJO1wPY4vEHxJ7W199QenpeogQ01hV3
         bsROdqbznE8iyA41F1p0rUYUmBZb3jyQgqhA8dNQD87SY5uxD1lnqGJEUpjymBvoCjze
         rlx1x/mzU7lwHMIH02MNxW5KCU19eKlsFHcrvV3w/e/ZzqV5WissAfj1LnNB9v1YI5Uz
         FyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kZv55UI1lotbt6zxOJeYG+FLk45h3yJ74p2M096WCtA=;
        b=ti3wBWLL3ARZCLsSyCNDe4JxqN4A2yXplPVKt3w/D0Y49V2rXB6CXCt0KM/pkBbIUR
         QPjt3JRH4GhDyZso5S+l9xfaUh9ww24/4F56QRj3R3AzeVJ0N0i3Xbuf3d56DykB4nKd
         OKzqyyMI/tUwZ84wIhnXhTk2j5H9W/dk9kSyUqHDYmw9rLm+pI2NkvJr0r851mPNvxkx
         Cr+zIpKI1pKVSKW80NrhMOILKymek0a+OBwrQWXadRjpOSiOzBJiPauSmwqLfJ/MfPp2
         JfP6e2QVOXmfgPvpisEJZ9Z7ENRFEgHSohuvZqVzeSHbFqe3vsraYzZAbrZwl7F4+JE0
         0tNg==
X-Gm-Message-State: AOAM532T37Msae4dwLhYLe43r29nFvlcVNk8eLijRQ9zx9jAbQayzGqt
        yzeYVD6fjMBl2SEm1IpcPFnOHK6O1H6D+YbMr5k=
X-Google-Smtp-Source: ABdhPJxo0dArsVVa15jkG0z2+o8+BBtD16pdCH9utQQm9Rioi2HgsM5klfnl10H0RraA/MDpcBijswWHv4naDqeCFVE=
X-Received: by 2002:a63:b507:: with SMTP id y7mr4905365pge.74.1623329947859;
 Thu, 10 Jun 2021 05:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210610124556.34507-1-paul@crapouillou.net> <20210610124556.34507-2-paul@crapouillou.net>
In-Reply-To: <20210610124556.34507-2-paul@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Jun 2021 15:58:51 +0300
Message-ID: <CAHp75VfR5jjMjDhFRvtT01EbuSTwDBi3HERDKi306mRK22+Fnw@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: core: Support removing extended name in
 attribute filename
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <michael.hennerich@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 10, 2021 at 3:47 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> By default, when a channel has an extended name, it will appear in the
> filename of channel attributes. E.g. if the extended name is "aux", the
> filename of a "sample_rate" attribute will be something like:
> in_voltage0_aux_sample_rate
>
> Add a mechanism to disable this feature. This will be used to add a
> "extended_name" channel attribute.

I'm afraid, NAK. Otherwise, please put an explanation that clearly
shows that it will be no ABI breakage.
I.o.w. users for the existing drivers and devices will always get
those attributes at the same platform configuration(s).

-- 
With Best Regards,
Andy Shevchenko
