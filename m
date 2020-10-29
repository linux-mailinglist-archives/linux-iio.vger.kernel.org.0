Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F383F29F2AF
	for <lists+linux-iio@lfdr.de>; Thu, 29 Oct 2020 18:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbgJ2RLA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Oct 2020 13:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgJ2RLA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Oct 2020 13:11:00 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E602AC0613CF
        for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2020 10:10:58 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id k9so1179198pgt.9
        for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2020 10:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0p5yeYImJ2kqyqzkAbCSH4bqWmkAls+JhWqNDtOXP6k=;
        b=RD6or7uYvlTnqzFrhtuh8H7JnHoFZocI9XySD7LEMWBzaxFmlyOgwzaYUWw7XEGhk2
         rXxGPXCvPs4O8Q81VPRfWXmDhwt0hQL/H9P14/9p/SIlIiDM5bgb0LsJ+P+U0/0LsUoi
         psye2SJDT+1KjjTgjNAtIFXw+uSMnvdiaV6uqJduslEAyEmXXNSAwOz2X3wzL4VPRZw5
         7hkNRqmjGA7zi91EFxXEL2KLmZAXnczjZZ9hq37t2NqZsaGWlUDPgUUZ4I3M7rIVnlhm
         mkY4NIorkmsAr14zTnnKil5BL3QnjmxzVOA7zkHhjp/jOwCJhzLNreN0tvH2MC6cmym1
         jJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0p5yeYImJ2kqyqzkAbCSH4bqWmkAls+JhWqNDtOXP6k=;
        b=sZxSuPFeOPg62jxIWC3j8L1iNUFxdK2SnQvK6c9s9qtFijSrALAu95rUz44N12R1Ie
         xQSvTGOV/B7h5fX8fyiG+m1xi8SwYnGWQtrOzP8Dw9YBDBVV9EJE9f2umsNoroAdJQfT
         w++ELzNZCPofSJWSiZ4Ze8fAIzGDNveFKTRdXvcdiSjEUOjP1hSoAGbWF1fLb3MVAUjM
         VoXZC3AmOSUUEVcTGPiIUNEk4l0OovSh3aLMvFwEKHz9d9wEV4k4T2zHE/Y+7WC9RP9z
         O9Np7sUPmbzCGBczguD/iRQNyaiqtZIOvn8KUSloR0YEnwa2tJe+7sYwP3emxHQCZ7gS
         Ge8Q==
X-Gm-Message-State: AOAM532KWBl5H0EzBmDO28C+RJlt+hqxfDMn5KAeFE3RkOAy+YbWB+Cv
        Zv2w8vk3qFqgD071GNTC9RRk9r+YnLkWXxPF/EPBqqW66S8=
X-Google-Smtp-Source: ABdhPJzIOdvsgxdHFxtdX8NYjsjtejW43TxpiHL5Y5CQk79olQiDhB5uZdAeAw6UFywX050Wg5xZBXa55Zoo8ZS2Ddc=
X-Received: by 2002:aa7:942a:0:b029:164:a853:f0fc with SMTP id
 y10-20020aa7942a0000b0290164a853f0fcmr5009940pfo.40.1603991458535; Thu, 29
 Oct 2020 10:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201026175340.19570-1-andriy.shevchenko@linux.intel.com> <20201029150444.28f4e18d@archlinux>
In-Reply-To: <20201029150444.28f4e18d@archlinux>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 29 Oct 2020 19:10:42 +0200
Message-ID: <CAHp75VfzV=VY5R1oVx+2mtbdNj97rJCh6tqeUnzYt=MDGpCsfQ@mail.gmail.com>
Subject: Re: [PATCH v1] iio: gyro: mpu3050: Use get_unaligned_leXX()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Oct 29, 2020 at 5:05 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 26 Oct 2020 19:53:40 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> > This makes the driver code slightly easier to read.
> >
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> What you have is good, but could we do better?
>
> Why not use an __le64 to grab the whole thing, convert it to a local
> cpu endian u64 then use FIELD_GET or similar to pull out the right bits.
> Would be fairly self documenting as well which is always nice.
>
> Or am I missing something?

My laziness. I shared this as a leftover from a big series of
converting a lot of drivers to get_unligned_.eXX(). If you consider
this is not good enough, just don't apply (no hard feelings :-) I will
drop it from my local branches.

-- 
With Best Regards,
Andy Shevchenko
