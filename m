Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E086372CD2
	for <lists+linux-iio@lfdr.de>; Tue,  4 May 2021 17:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhEDPQ4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 May 2021 11:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhEDPQz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 May 2021 11:16:55 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA590C061574;
        Tue,  4 May 2021 08:16:00 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id i13so7820559pfu.2;
        Tue, 04 May 2021 08:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kqv0fhqlvdT4HC/bTQQAPq9XoH8d+dFq8TFrOsCO/WU=;
        b=r5E3zJ6La6zJTHM1iEZAJeYu5w+SRwgW3T7MRGjZR0lCo68LitrV9SyN4o+AU2+phx
         ZVqAO2RBr68uL6JVWrja33S41Afn8BfbIsPByO3paXkqN2b2/kELqhOAhPk6uCiZNISu
         oiJMWJ3IsCz2WSuVo6KIn51bv7Bj83xd/ubG+Treqpk+EMSPVW4zgBEZZfICoeiKftM4
         cszYXUDR18Rmo8gDgfvPs/L1728ePGkQvKiQGEbsSfGo7oM7RuglQRjI6d+7GMhsWOHU
         zLDrW3KsMOpKZygvhQ9h/d0CRJpEgNMbfXiHu9fvfAWVZJDIjyB1Agi4PzFSIufqSWZT
         UPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kqv0fhqlvdT4HC/bTQQAPq9XoH8d+dFq8TFrOsCO/WU=;
        b=tGJVq1TOgI0QD9xVVna9XFFAcdeTKu/MSd414l9CJg0GdqBt7kcwN+tSQmrkJQynGu
         gK0q9Rq+gjr70P3D7pIHIVJGfwAN2bJ2e7IwwexAH6UhclW0IZreVJ/xcIv8pVgTB6qv
         ajSHc1Kfqx3DKQ7ww21SKlajgJpFaCKlHvVpnCmJwt0ONVZw3yCNe46zSaAbzgdA7pvb
         0m8b/SdPd/y7Z2BWa4soRk4Smi4rRZt2WnZ0OtoM8LA3+/sluv7KyCEaFGWZ/YGHMNlT
         Gj4OuEtVWfNCmt+VZ1iFewKdAwBKqNBIdBkUM98Zzu0l+5h9zKZjdSd2yNWi+Lm8d/qM
         T96A==
X-Gm-Message-State: AOAM533uORcc9ocqlzLbTYtvacZNsq9BukCXV/2iU5YDh1upqMagmzl2
        XQx3E0kxFKFfNS2F7s+6iXbQSO9kDlelHRYmm1E=
X-Google-Smtp-Source: ABdhPJxtfHO9/J3snqSFgj3ku3CQv2B6D7NpgSm47B6NnqOGRzghIxSyP/4ufB+qf6N9TE8m+DlM1Kns7vrL9DN4q78=
X-Received: by 2002:a17:90a:d90c:: with SMTP id c12mr5840557pjv.129.1620141360218;
 Tue, 04 May 2021 08:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210504143019.2085111-1-linux@roeck-us.net> <CAHp75Vc99LzOpe1EeTwoM+wkwyZkTamj6-=MSe_MBZ1+XUcebg@mail.gmail.com>
In-Reply-To: <CAHp75Vc99LzOpe1EeTwoM+wkwyZkTamj6-=MSe_MBZ1+XUcebg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 May 2021 18:15:44 +0300
Message-ID: <CAHp75VeLyxbwbDtCca5goCEWn7vbQ9d_Fb01dWj1CP8eBb9jJA@mail.gmail.com>
Subject: Re: [PATCH] iio: am2315: Make am2315_acpi_id depend on CONFIG_ACPI
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 4, 2021 at 6:11 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, May 4, 2021 at 5:41 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > With CONFIG_ACPI=n and -Werror, 0-day reports:
> >
> > drivers/iio/humidity/am2315.c:259:36: error:
> >         'am2315_acpi_id' defined but not used
>
> ...
>
> > +#ifdef CONFIG_ACPI
> >  static const struct acpi_device_id am2315_acpi_id[] = {
> >         {"AOS2315", 0},
>
> This is a fake ID according to the specification. Do we have any proof
> that it's being used in the wild?
> If no, I prefer to drop this ID section entirely.
>
> If yes, needs a comment which device is using it (however it may be
> out of the scope of this fix).

Googling shows zarro results.

(Yes, I know about meta-acpi project and I may fix it there, but it
may not be considered as a "being in the wild")

So, please, remove the entire section.

Feel free to add any tag from me (Rb, Ack)

> >         {}
> >  };
> > -
> >  MODULE_DEVICE_TABLE(acpi, am2315_acpi_id);
> > +#endif


-- 
With Best Regards,
Andy Shevchenko
