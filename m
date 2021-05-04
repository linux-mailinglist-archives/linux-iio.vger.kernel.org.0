Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C33372CCB
	for <lists+linux-iio@lfdr.de>; Tue,  4 May 2021 17:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhEDPNE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 May 2021 11:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhEDPNE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 May 2021 11:13:04 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30B1C061574;
        Tue,  4 May 2021 08:12:09 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id y32so7261423pga.11;
        Tue, 04 May 2021 08:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x9tO99wYmUPUL8e5HvCoeHBJ4bw+/HvN6akOU6g8NTM=;
        b=ElfQg2pki3F8R+EWtBgQdKxdDAtzXU7CvPoJ23bPBLPb+Xqu7YEvGX5jxQEcj00OQh
         ntnVy6ggDcDtm2xpd/n5cs3gNp/IMLvv/fBdScdgae82F5aVhX/VuzLSPgCtq9h0WZ9N
         WeIbzAPQklM1E/FMG1GECms62k2kajBZznl9OplIR5TQ2eQvnAieIjPDOr+Ya8G0i3HF
         yyfH5+5faDLNXaA0YqdYgJ9GoUXKum+O4N35qAD07rJtMbui/cj73GhxMory6n2F2Vj9
         DD3O/O8Jm12Qyvdzwm46SLZSYEC6VParW2sOuEPB5KSOTjA63HxsZDHHjDCdmoUhMOFC
         l93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x9tO99wYmUPUL8e5HvCoeHBJ4bw+/HvN6akOU6g8NTM=;
        b=sNYL0IgSI6IfRO/iSd8ghmmv2qytWHlSBCREzrbOfRyhQ0K9N0mKnibfEJHFCUrIIQ
         M8LJhPvres670c0gqhHqXHm3w/PV2lMIqhR0dkwzybE1EEvO007js1dHUR2x0YKLHLv1
         xdMBlCHMo1yQVXJwCwL4SJgRP1wCKVs7cRCTBdFqbzQOMrFDhrLe32cSU6Q3wMatPIsI
         4NjumLktoQ2LOSDIafP3HYqGKbi3eZtAEd0ZnWHveUcYA4G/n8zentT0aAvjC13n75Ne
         TlHCoBkk5CU1O76xrj1fDoO7wwFRfkZ8+OcuI7FfQSrHHB7cnWjn8M2wUq9A0Wt41gUQ
         daUQ==
X-Gm-Message-State: AOAM530GkHKGUt7x0jOdyFixYCkWsSZjYGeVeyJzS0mTEiQKWXoB7UsD
        UuTfszIwLcBKfedQXAJ31e+f6h/xJ68CyzvSaCs=
X-Google-Smtp-Source: ABdhPJywDhvVxVOAzIDP34AGM9Fyu/0mrR4V6lPnqtCnAKgIquwxJiUj0LO0AxR6HFJ589/7DWlR9eJilihJV+JHE+k=
X-Received: by 2002:a17:90a:bd13:: with SMTP id y19mr5917480pjr.181.1620141129232;
 Tue, 04 May 2021 08:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210504143019.2085111-1-linux@roeck-us.net>
In-Reply-To: <20210504143019.2085111-1-linux@roeck-us.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 May 2021 18:11:53 +0300
Message-ID: <CAHp75Vc99LzOpe1EeTwoM+wkwyZkTamj6-=MSe_MBZ1+XUcebg@mail.gmail.com>
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

On Tue, May 4, 2021 at 5:41 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> With CONFIG_ACPI=n and -Werror, 0-day reports:
>
> drivers/iio/humidity/am2315.c:259:36: error:
>         'am2315_acpi_id' defined but not used

...

> +#ifdef CONFIG_ACPI
>  static const struct acpi_device_id am2315_acpi_id[] = {
>         {"AOS2315", 0},

This is a fake ID according to the specification. Do we have any proof
that it's being used in the wild?
If no, I prefer to drop this ID section entirely.

If yes, needs a comment which device is using it (however it may be
out of the scope of this fix).

>         {}
>  };
> -
>  MODULE_DEVICE_TABLE(acpi, am2315_acpi_id);
> +#endif

-- 
With Best Regards,
Andy Shevchenko
