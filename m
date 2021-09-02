Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948023FEBD0
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 12:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhIBKFE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Sep 2021 06:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhIBKFD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 06:05:03 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A285C061575
        for <linux-iio@vger.kernel.org>; Thu,  2 Sep 2021 03:04:04 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id j1so994212pjv.3
        for <linux-iio@vger.kernel.org>; Thu, 02 Sep 2021 03:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E0fxn3pWH+DKMJyXjNqIIXWzSXdhWhpMug9a1qzlGDQ=;
        b=Cvs6UURxOc5jZ2PZoeBGR8Aa9DO5xJMLyimPs6LlrDmuki57VWeXBviusSFTeCHVS4
         Ktb0hu6hg0O17sTi+YK0vxJrpL9d6hiQNAt6FbxhDL6NS5j9CzJ8XNA5G5DBKDos5U+G
         ssUkTOW9BD4uuxO304JxjKtJa0MDzUivXdAPEXoAYN952BxnzBwKStmOiCDFEQUJdG8x
         TRQssSKFboibbcCTg3fj5pB6ZGlQFWjZaOudWKzOhfFRMwAiNNTdkN+9dafBJ2MDYJPd
         Io9gOiLX0wIX/nd3O1YWJ+R+sKwFE8+f+Jg3z1jR+bQ/U5Y9oFr+5JxS44VZybCknGVn
         e87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E0fxn3pWH+DKMJyXjNqIIXWzSXdhWhpMug9a1qzlGDQ=;
        b=LfI5DK0it/tbEzNHVpCoCwfqY03jo7Cq4mMi7fjkjkTxoGvnV8amc6U7zIkXMivfWt
         jAjtJNjZPAtHsWhWUKJaKRgae1ROReP3c7ibhuGx3K9AYk+YCj5ls9I+Jyebg1Pz0wPk
         REOHiuYDQ0Sy4VPABfREUb9OUvSSlJk1sNgxGgZFwtbTy9Yyllek0BsOvnZBCPG5xwZk
         PMaPAiXM/FRdPU5r5wMwqFuBhx15lIjMYgwN+U62CGB4L5k8LbphAnibEZYnvIpYvEy9
         ZDbQxwLtF7My4EFGwRn8ZZw0l/dmg19XckW6rBXS8GHHBaWzRBIefoSPtBS2u1+74gOK
         6OSA==
X-Gm-Message-State: AOAM533RP/UxN0TeEoZcJN5PkbDQfQIuLMuaq9PuJhGcGWQTQsvwxoDR
        mVB/xHtc2yzMNpZMigR05NuJU3w9HNAROUeZkEnDk+JzH26AcA==
X-Google-Smtp-Source: ABdhPJxmCBi1h57IPRTndKNGH8E+TdX1MjmIQstFwpi2QAkY0p1S9M0j9GqxHWCOfq8Y8jjSW74hWfz3H4fioVd32bc=
X-Received: by 2002:a17:90a:6502:: with SMTP id i2mr3060742pjj.129.1630577042917;
 Thu, 02 Sep 2021 03:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200721171444.825099-1-jic23@kernel.org> <20200721171444.825099-3-jic23@kernel.org>
 <20210902102324.0000327d@Huawei.com>
In-Reply-To: <20210902102324.0000327d@Huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 2 Sep 2021 13:03:26 +0300
Message-ID: <CAHp75Vc0wqnFOk4FW-oqDRZUfLcBLZr-miZbfm7WfA3=Oi34Rg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] iio:adc:ti-adc081c: Drop ACPI ids that seem very
 unlikely to be official.
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>, Kunyang_Fan@aaeon.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 2, 2021 at 12:23 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> On Tue, 21 Jul 2020 18:14:41 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > We have no known users of these in the wild.
> > it seems very unlikely these are real IDS having the form ADCXXXX
> > as that ID is owned by Achnor Datacomm not TI.
> >
> > Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Kunyang reports that ACPI ID ADC081C is out in the wild on some
> AAEON boards.

Can AAEON clarify about all IDs in the kernel they have been (ab)using
so far? Then we probably need some comments. Also I would like to be
assured by AAEON that they won't make such mistakes in the future.

> I'll send out a partial revert soon to bring back that ID with appropriate
> comments on where it was used.

Yes, please.

> Key thing in future for these sorts of IDs is we need clarity
> on who is using them before agreeing to take them. In this particular
> my undestanding is the driver came first and as it worked the AAEON
> firmware team used the ID.

Yes, because it's definitely not an officially registered one.

-- 
With Best Regards,
Andy Shevchenko
