Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C1D3755AE
	for <lists+linux-iio@lfdr.de>; Thu,  6 May 2021 16:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbhEFOcQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 May 2021 10:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbhEFOcQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 May 2021 10:32:16 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CB3C061574;
        Thu,  6 May 2021 07:31:18 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id v20so3481756plo.10;
        Thu, 06 May 2021 07:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PfMG85y3NNkF3WR1u0K030EwBkIRCcwJqZ68DfA6EiE=;
        b=oMUbgL1lJ9crD6AA9lazwUC5aUdIoXgU5Q0AhOoj+EDntIuhnEfIN/Tvs0ghlDHUe5
         2ySsiLg0CyBRgdEgq5JmPZTpYI+6dTllH1blAIO/g8Ec6A7nNLgXEMlRbetPxuXdBKOP
         /C0Kp2PdJuBDNVUGxn810o+bIJFRPfZRLh1mKknrqbeUBU7OZk6uvd32uZcmiQZZ5DBP
         ThVlc8R++6Qq9fc+uckPDLyHKiro65JyioT7AEpZoooiSzNByvaxLwhzZP9+zbcwrz1U
         upU9AHNgvAyjE+asZEtIZsbKPDhZzFGMoh1/8gTpQn8JVfTmaxFw0pkfSSu1KZyRSzSe
         9mzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PfMG85y3NNkF3WR1u0K030EwBkIRCcwJqZ68DfA6EiE=;
        b=BL9CPzJ/BIW9hDW08oNqKWTz4FATWfbX6g+Iu7z/PG+py4rZxOooF7EXEm2z+iMl9d
         tcrxhfTUFkAbUymGEJTbyXBwtCnw652t7/phFmU/FWgnDAoN06cCTFhQcALjPTUmDXN1
         73RcScFrBVX06RYF5CsXfIavFa3kTYQg83qD2MXEMZoWHVEFJwEve0fhnT0vnH/HZRcg
         FriNDQ0fzDcnErRq1HrzY9dpFQ1LHKBtUmooH70+UpYm0y5LVApBKSHxDxi9TN0gYB3C
         5zt4AZgx5y+E3LBqun/Tj/XnjwuY5VAmdtzjrgAR6muW3MgspYoFWiSPsJtDHscZaJIL
         Ma3w==
X-Gm-Message-State: AOAM531awEt1ARV8LlEko4IaQMYWdjiLEEhkrf6dWNTZ4/rYuudWrjhO
        gyR2RrwjjINgBeSmiaW4neu6GbxDr2qfLGGrIxs=
X-Google-Smtp-Source: ABdhPJweQkAs2pF5EkdRD/+LHDXyW/4Ghso4VXQL2BICZIGHgyJmv+85bftu5ZEzKHvUJAmFaV1vbdkD3KwGzv7VpRA=
X-Received: by 2002:a17:902:a406:b029:e6:78c4:71c8 with SMTP id
 p6-20020a170902a406b02900e678c471c8mr4569392plq.17.1620311477576; Thu, 06 May
 2021 07:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210506034332.752263-1-linux@roeck-us.net> <CAHp75Vd0N5s=D9LFiVU75gYCLnpqOwfBogbWUTwZNC1CV2n88Q@mail.gmail.com>
 <20210506133754.GA2266661@roeck-us.net> <768c06ff-663c-eacb-fd3c-628b4e4ba449@redhat.com>
 <20210506135052.GB2267050@roeck-us.net>
In-Reply-To: <20210506135052.GB2267050@roeck-us.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 6 May 2021 17:31:01 +0300
Message-ID: <CAHp75VdHMm+WYA2Nfiz1g3B5Sj14Rq601aSyQ_puynudg9ZiZw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: bme680_i2c: Remove ACPI support
To:     Guenter Roeck <linux@roeck-us.net>, Joe Perches <joe@perches.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, May 6, 2021 at 4:50 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On Thu, May 06, 2021 at 03:42:08PM +0200, Hans de Goede wrote:
> > On 5/6/21 3:37 PM, Guenter Roeck wrote:

...

> > We (mostly Andy and me) are not even 100% sure this one is
> > a fake ACPI ID, but we do pretty strongly believe that it is.
> >
>
> What a mess :-(

What we can do is a checkpatch-alike check for vendor ID to be
registered in [1] and issue a warning if not. At least it alerts
maintainers. Joe, do you think it is doable or we should have a
separate tool for that? (Because I have no clue how checkpatch
cohabits with internet connection, otherwise the problem with
synchronisation of that registry might be a problem)

[1]: https://uefi.org/PNP_ACPI_Registry


-- 
With Best Regards,
Andy Shevchenko
