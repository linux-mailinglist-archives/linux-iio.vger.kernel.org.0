Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9A63A48C6
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 20:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhFKSkR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 14:40:17 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:34657 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhFKSkQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Jun 2021 14:40:16 -0400
Received: by mail-pg1-f181.google.com with SMTP id l1so3173260pgm.1
        for <linux-iio@vger.kernel.org>; Fri, 11 Jun 2021 11:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5k8bn0sFTUYQb035TWpM6wj6EEiLNqlGHTKkbNBxXCo=;
        b=Uj8XTqZG1pmXThrcwxqG+VG5/XOwAScExxjBW1QgRiC7H7XixsaTKMa27fQXiF5YFy
         4t6kWOrMU6XyMx35JaF6jI+R49FesAlMe/ptAYCDdm2k5KbeIa09MKDVNaXsv/uKjrnb
         iivyu+WuxdEU+PrIQADWMkxxwvd79IfQ3IcZ0fNYscRNpUmmqbl0qGdPRuV/CIhPQELx
         xGuGfblnaVYoVnreusTPUtV2anu6E0dc6SlrSK32sLuIX2VnvT7qyz38NzofwLhAXD59
         xRcUsXSDxxCcHWVZC0Ghex2pTBNZqUYc875rPwLGxJDmlRTOLMpCR7NIDoijUdstAje6
         IYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5k8bn0sFTUYQb035TWpM6wj6EEiLNqlGHTKkbNBxXCo=;
        b=py9x5wuccMHs++RxCchFlWlds2KDgb/2N8WLQocCHS1zQeo62PPSJZiu/wtaF3OC4J
         hDw8WZQ0nj4Qe/CFsG+fLIUquSqUrrq5TWlJt9mqTniKtPYtqQnN3XSfMOakHftKaqcq
         f4EMmIicaRuuFPKpqWI0dJmFt9wQmX92vj3rTEEFNUC8AlCNx84q0DzXbpS5cXWmkEqZ
         /hy4ryyLx5D2/0NlrmZtXtUdCpZQSkmUV0qRl0msEKO4IzNp31kVVmnIxiwrCuaX5Njm
         fn2A7IXNkHYc2gs9vOXEfWoS1wnqYxCsCMkto/jESKElV5m9GKy9DJmnjghmEJriOT6k
         r+yA==
X-Gm-Message-State: AOAM5311KZMnlDW5+70rl+xRrxaWsDPhF7eXosspLKG7UA4brQaX7WyW
        NXPFSyAmhXuvhje/zwsaRzs98Vd0UXSlKB5ebnU=
X-Google-Smtp-Source: ABdhPJzk0Ihjd3S4rODFzMYV7hiarXbTnBZSIWGB2Ilkh2YDoNnWN9dEpb92YQHw2HiDHrtrlPV09syhfJPWNX77Yhk=
X-Received: by 2002:a62:e404:0:b029:2ee:f086:726f with SMTP id
 r4-20020a62e4040000b02902eef086726fmr9495575pfh.7.1623436624451; Fri, 11 Jun
 2021 11:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210611152614.109361-1-jic23@kernel.org> <CAHp75VfN93-B-UYCEMfxym-_XS_Edr+G07P6xO+83+gkMeC1LQ@mail.gmail.com>
 <20210611191403.14d676a9@jic23-huawei>
In-Reply-To: <20210611191403.14d676a9@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 11 Jun 2021 21:36:48 +0300
Message-ID: <CAHp75Vfvtyg+uXDhDte5w==eaaW-P4+8J8ac2kL2GYAbFrB3sA@mail.gmail.com>
Subject: Re: [PATCH 0/7] staging:iio: Header cleanup
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jun 11, 2021 at 9:12 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Fri, 11 Jun 2021 20:45:03 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Fri, Jun 11, 2021 at 6:25 PM Jonathan Cameron <jic23@kernel.org> wrote:

...

> The reason for kernel.h includes when being added is almost always ARRAY_SIZE
> or container_of as you identified.

Give me some time. I will cook a couple of patches for ya to test
(splitting those from kernel.h).

-- 
With Best Regards,
Andy Shevchenko
