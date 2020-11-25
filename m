Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCDF2C406E
	for <lists+linux-iio@lfdr.de>; Wed, 25 Nov 2020 13:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgKYMo1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Nov 2020 07:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgKYMo1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Nov 2020 07:44:27 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA9CC0613D4
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2020 04:44:22 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id t21so2372579pgl.3
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2020 04:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ywcVJatUuR5UWaR/3vVasVTBCzxthcvSyMHrH4f8K7Q=;
        b=Cz4hqakR4D2uKqgLnZS3CQcD7dm+en5EbNdzDayjh1q1xQZidE6C6dP6jOoXq6vwjC
         ZazCIoAROSOLSeEImk5KuY6xkZUOMErL1fEOx4KxtnLFwUr2Cimec8GZF5qGtPBebmHO
         5uaPr6S2LBZntwHXMrU6rEvOrHcS9bnXl9AXHeryBWqQVjiatCpBbwIXYwUfqAENV2Cg
         mTpByHJGUsZNkZh78GrIHX+ZryWiZgvdXv7W4b5k78d/2L1W22iG+X0AAtv93djXbtM4
         njTlpaywzIK6B3vA+hBGI6l8JLt0Njr21X8dxofjh4XYIGTUgmDfgrDUPBGb8waO75ZC
         CDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ywcVJatUuR5UWaR/3vVasVTBCzxthcvSyMHrH4f8K7Q=;
        b=MfYo61hA6wrC41yJ8CZELuG71WRmV5AJW0pPM+C6/66gkZmCGsNbwH2FM0C40I0yVP
         70RA6lB46IN9JyrG3VT4jCFB08pUV1lxD2VGol7TeqngePYsuWE7kL+kkwVhx4rwQ560
         PKHZ9SIx5K6ZVYpNz4r5Ys5KHcaL3o9z5prjiAyerwiapbDeEzswteoKQl9mbsbt8I3q
         uULClbBftp3K0pGlz3mV9GYf3+0aTs9HqpwfSCVb68HSEYVxUiXSxVxWAzb/R9P2/2j5
         VYL+TX8c43NI1LBUF/K+JBq2jvkdc9GFhM99h3sDmIZeEeTjILIgnfOvbwtMOLnI3p1N
         6uag==
X-Gm-Message-State: AOAM531ipJieXEa5aRet3v4GA/Z8Ldvey2WsNvIF3mYihrXD8zW9LhQO
        BNwe3TUHgeOMORvWnUuQNSgDih8H2nWCMUVuUdE=
X-Google-Smtp-Source: ABdhPJwuMYyO92Ey5Oo0fSeqthTCVS60uOM7cVF8VQvoKNoeuNTzgrIEhcAnGsPIRTa/28ChAohcxaTBF6jq0CVp5J0=
X-Received: by 2002:a17:90a:d90a:: with SMTP id c10mr4009867pjv.129.1606308262412;
 Wed, 25 Nov 2020 04:44:22 -0800 (PST)
MIME-Version: 1.0
References: <CAHp75Vfz2P=U6CFY4824hPLSSDQNh4wATE_=JjA63fXyYCpsrQ@mail.gmail.com>
 <857bbb6c-1025-df6d-871d-f0fbcafb6ad8@metafoo.de> <CAHp75VdZ1qG1yht_Wa_Npn8jv61ux+mWBeayd5x8uLOj2JarcA@mail.gmail.com>
 <57a87648-b329-6c79-21bb-629a7f4e43e0@metafoo.de>
In-Reply-To: <57a87648-b329-6c79-21bb-629a7f4e43e0@metafoo.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 25 Nov 2020 14:45:11 +0200
Message-ID: <CAHp75VdUdi4rP9wE0nHa9zmsD4rCVFudHMOt5Y62CBFe3GCPkQ@mail.gmail.com>
Subject: Re: fake ACPI IDs in the drivers
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Nov 25, 2020 at 2:05 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
>
> On 11/25/20 1:00 PM, Andy Shevchenko wrote:
> >> I'd assume that most drivers that have a acpi_device_id table do have
> >> hardware that uses that ID and were not just cargo culted.
> >>
> >> For new drivers we should push back on unregistered IDs, but if there is
> >> hardware that uses them we have to take the patches.
> > Right. But at the same time we have to push the idea of proper IDs to
> > the vendor companies, so they won't abuse ACPI specification anymore.
>
> The last couple of years have made me very cynical on this. Vendors will
> ship whatever works, not what is correct.

Yes, but with some vendors (esp. if they have their record in ACPI/PNP
registry) we may insist to follow the process.

-- 
With Best Regards,
Andy Shevchenko
