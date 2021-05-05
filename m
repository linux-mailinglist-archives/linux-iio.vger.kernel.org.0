Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC263736B9
	for <lists+linux-iio@lfdr.de>; Wed,  5 May 2021 11:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbhEEJFZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 May 2021 05:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbhEEJFZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 May 2021 05:05:25 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC2DC06174A;
        Wed,  5 May 2021 02:04:29 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id fa21-20020a17090af0d5b0290157eb6b590fso477679pjb.5;
        Wed, 05 May 2021 02:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UR6pLT82MvBPpTBxMD4qnCZSm5lvjqbURbGKB/uGa0o=;
        b=RD1HdyFeiID1WJ4ZpSwuZIBxaaupGQiOuDajgFgRIf3qQGLTM2rtM/8xz744gv1kc0
         Pzdlb8qBOvpctFhIjUwrc4pyxl/g7rkaVMBHNtlqwvSpswFZKbrmwngo9kteNihtzog+
         Qha0FIEPdhDaqRcUu0MDb18uWK1HEV37kfluacBI5Xu1dWS2mqGrSsfiX7L+SLNmHMVh
         zHGGV+gjRUIvZ8/241NAR6To9f8odlGFuyRK+obkec4e7hpSU9NjxsixLnYvOljWBl2H
         99f2Vs5PsF8wsbyIFoT0e6an3octbXrdopOO3kkLoYYBoiNTUv8Xd9HdQO5UweQSEhLF
         4M3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UR6pLT82MvBPpTBxMD4qnCZSm5lvjqbURbGKB/uGa0o=;
        b=DFwx3M8GKtkHh2bTfXWMLxbSXBgA/UipMbKzbUJYHsErodDjhXXbGPRJfNXQvuf88j
         TxYvsoP3O7Q8w5yJ339sPu4Fa5/vc5Cqmw+XPtbF1EbTXK0jTYWuyfjSsUGjasM4W3lc
         1DUhSyaLO51gT8gLPixvW8HlL5XXMGgDohKC60qxFLuD3Dx4xaYN+Bd1ICMDjopsjA41
         AkcUFaycigp3zPIY3NK0t2g1Ci352Qpkb7HkCcCgb3CYOxhcLHjBgErCU0yGvIWlKqlC
         +kN/uJqetDnuKBqw1Kjr1DMoR74AZ/1ZhiUfiNWJZifXrtThwwBWnD5IZky5RzXsIIyk
         U3Mg==
X-Gm-Message-State: AOAM530LPvu9l16/VDOGLKh57S0MhgKSh+QyBHlw8m51TJbiO6qLUox9
        wkmlHqFlMpOasYoMD9nMaZM4G/cgnCK0YQsHLFQ=
X-Google-Smtp-Source: ABdhPJy37MFUZIfct1ayEPii9ckUJevLQQQw8cYUNVCvhdgivFGprKV3GNbnYYiHkIXu+08hF6OzglgL+xtL+yoD020=
X-Received: by 2002:a17:902:ecc6:b029:ee:af8f:899e with SMTP id
 a6-20020a170902ecc6b02900eeaf8f899emr24609444plh.21.1620205468592; Wed, 05
 May 2021 02:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210504174019.2134652-1-linux@roeck-us.net> <CAHp75Vd-iTkA5Y6tEHtfcqLxxmHaaU8nLQSL7eWb-gaa-c8AJg@mail.gmail.com>
 <8f8b6f33-4308-bfda-2238-9a54e19c3f9f@roeck-us.net> <20210505093235.00007c38@Huawei.com>
In-Reply-To: <20210505093235.00007c38@Huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 5 May 2021 12:04:12 +0300
Message-ID: <CAHp75Vdy2DTQ_GG6f7zY3WtgoC7D-Kq-XomfV8+L6NNLMtLJuw@mail.gmail.com>
Subject: Re: [PATCH] iio: bme680_i2c: Make bme680_acpi_match depend on CONFIG_ACPI
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, May 5, 2021 at 11:34 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> On Tue, 4 May 2021 11:00:52 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> > On 5/4/21 10:44 AM, Andy Shevchenko wrote:
> > > On Tue, May 4, 2021 at 8:40 PM Guenter Roeck <linux@roeck-us.net> wrote:

> > I'll resend and let you add the tag, and send a similar patch
> > for STK8312. I'll wait until tomorrow, though - I sent a number of
> > patches today already, and I want to avoid yet another "account
> > suspended" notice from gmail.
>
> If you find some valid ACPI entries that are hitting this problem,
> I'd prefer we just got rid of the ACPI_PTR() usecases rather than
> added IFDEF magic.

Agree,

> The space wasted by having these is trivial and I'd rather not
> introduce ifdef around any of these tables.

> Dropping the ones we are fairly sure are spurious is even better!

For the record, I have checked all three Guenter pointed out and to me
all of them sounds like fake (two from the same author). So, I can
deduce that if we have same author for a few looking very suspicious
ACPI IDs, they are quite likely fake and must be removed sooner than
later.

-- 
With Best Regards,
Andy Shevchenko
