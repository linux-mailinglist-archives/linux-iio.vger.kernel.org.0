Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B8937559E
	for <lists+linux-iio@lfdr.de>; Thu,  6 May 2021 16:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbhEFO2o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 May 2021 10:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbhEFO2o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 May 2021 10:28:44 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41143C061574;
        Thu,  6 May 2021 07:27:46 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id p17so3465409plf.12;
        Thu, 06 May 2021 07:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RJg7kjOyxMe1+24UWPr9CSoiWVwTJKzcOx8ur7RnyaI=;
        b=BasLSkjJ7myyUVG44THg+QLwWfACeiC61rkNjd0FPoz/Sb6Ik3wg5/desJWVdiRz2e
         I4fRp0PrFGzdXcSN52d5yp8NpPC4dUePQ2nhLr5kMKbC8WOowqI3XS/EIBVQ2iu3qNtz
         J/u5I28frojtCNMJoaRLYsFi+UnOKscG2P0wpjuY1N1WmGaiJ0iYEcnCEoYMbEBWHWax
         5gZcaZB9W/qDeIlyow1P8BOc1xqbKsOSWDW/5TmTO+s01+bYDgYHeUis0PCa6oFW4SGe
         zsuU3PqYKjRiZWkHD4zDmtaIiKNVodoPxkaUVxxsqFPzwaDLXNlwRXMpYbQfDTdoucxt
         hDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RJg7kjOyxMe1+24UWPr9CSoiWVwTJKzcOx8ur7RnyaI=;
        b=ZQPA4DKOYBgh52zE/abrwopsfXUDmWag+829Qn7YV/8hHHwuOc04IZGidVSQeNxLZL
         23u94PitcQKIdr3J+053rAhvAvHt7WJ3MTDqfSNYUMxPDWkCai289IMKq1v4pEksUrd2
         uamQ4WjQnXFyA9782HVGIVwjvMaGSZtLXPeCI47Fj5fxJwGkyi9u7U9WjpRK3Vud/K95
         rPOc6WI3SswG3eH/LnO+nDi1Pw7EgAb/A+xChN2vhJIeh+VKYKEh0o+ku57236o2WQcE
         yuq7HXFQ9d+mHmdljaxStEaVWS7jUBYu8Nelg0SbVbrOTaIvkjTUQT6BTEumd+a7j5E0
         0ySw==
X-Gm-Message-State: AOAM530WwstjLs5ch1LCq1+vYRwdwrhKNI5TZH+iIdb+5jqNZaay1BZz
        C4caPraSLpXbY1rkDzJ58U9kc3nxb4NsLTtSbaE=
X-Google-Smtp-Source: ABdhPJyzNWWgU1trDwKAa5gNve1qXCtfuyeKQ0wA0Jn9VaTERCZmZySDj9wOhAdAephM2A5iPg8vpkVoq+QpFJeW0Ng=
X-Received: by 2002:a17:902:ecc6:b029:ee:af8f:899e with SMTP id
 a6-20020a170902ecc6b02900eeaf8f899emr5021970plh.21.1620311265815; Thu, 06 May
 2021 07:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210506034332.752263-1-linux@roeck-us.net> <CAHp75Vd0N5s=D9LFiVU75gYCLnpqOwfBogbWUTwZNC1CV2n88Q@mail.gmail.com>
 <20210506133754.GA2266661@roeck-us.net>
In-Reply-To: <20210506133754.GA2266661@roeck-us.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 6 May 2021 17:27:29 +0300
Message-ID: <CAHp75VfqJUFk0++9j07OiSEO6Eowg1gq=nwuaMVFymmHA+CLEA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: bme680_i2c: Remove ACPI support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, May 6, 2021 at 4:37 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On Thu, May 06, 2021 at 12:28:40PM +0300, Andy Shevchenko wrote:
> > On Thu, May 6, 2021 at 6:43 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > With CONFIG_ACPI=n and -Werror, 0-day reports:
> > >
> > > drivers/iio/chemical/bme680_i2c.c:46:36: error:
> > >         'bme680_acpi_match' defined but not used
> > >
> > > Apparently BME0680 is not a valid ACPI ID. Remove it and with it
> > > ACPI support from the bme680_i2c driver.
> >
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >
> > with the SPI part amended in the same way.
> >
> Right. I just sent a patch doing that. Oddly enough 0-day didn't complain
> about that one to me, nor about many other drivers with the same problem.
> No idea how it decides if and when to make noise.

randconfig I believe.

> Is there a way to determine invalid ACPI IDs ? I could write a coccinelle
> script to remove the code automatically.

As Hans said...

My understanding that most of the fake IDs come into life due to:
 - people apply similar rules to them as they knew about OF case (and
certain maintainers blindly allowed that)
 - people in big companies need to quickly prototype something without
giving a crap about ACPI specification and / or process

The last part (I believe the smallest one) is vendors who heard about
ACPI, but haven't enough knowledge about the process.

-- 
With Best Regards,
Andy Shevchenko
