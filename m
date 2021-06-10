Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C678A3A2C17
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 14:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhFJM5F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 08:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhFJM5E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 08:57:04 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2B2C061574;
        Thu, 10 Jun 2021 05:55:08 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g4so3631225pjk.0;
        Thu, 10 Jun 2021 05:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W9MR7VyfjbAVQKovizeaQVfhcaf1Wuct3oROAX9gJfI=;
        b=dDQolY7xmu8sb3hUQbo4q+R/+R2dkPcje2f7+aRWYBMHZl4h6P6Iau939h2h8MiNRd
         5kuEHPclM+RNwZYF2WZlUzypH/ibLUDUxGNOj3iAePbXfMhv1Z8b+aqPisPUb4JVa/Y+
         E1fzzkrHWk/pu4OALL0kQq5NytWQpyMZpX9phghxw4g3M6AXN5LUAKXQI6doNCiIk5Ek
         2lhPyKlFzDuDTGp2UDhH7EiELMrrx+/PZokUmMyMyqC94pHQa7KgFXzongxWlsYOZaL4
         5qSCZvUn2J1JOEi12v6XFWeC69O6BxgunkI4OD27vY8xL9P9JkDNEz7KmXctSQXduZqS
         zSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W9MR7VyfjbAVQKovizeaQVfhcaf1Wuct3oROAX9gJfI=;
        b=haVJ+KQBZouZvotr9zDHoyYKk4IkNB6CNlNQEejvr9zy9nBDI+cPlt0HO5eBQLhW58
         7qKY7flJqNW9fK041kOZpUL8G+2L3F4XQkpzHovdv0my1Xr1QWPO7YJohB8DrxlI5OYk
         +xe+wy41ehwLLYiJfmEl3vZgMSUYtC90yfZGN0L0Sg4lCNYWOB1rpqwh5lRAkjxQIxOe
         +W66XNfhgC5x3oAMYdt0k+EhTEh1Fk7GzDoWdjIhdnf2Stqu8Z2O5uoyQ2qJtLTLnNHN
         DucGsH2Q7udFcoKKyiYsDVyf4pKfSPfncChN2bUUhpX8P9wCnPr2CVrXheZnoE48fgQF
         lfTA==
X-Gm-Message-State: AOAM533m80Gdvw2kbVBegSE5Eksk55rW10Eojef3IAvwss4Amn3hEJkU
        OJojUiogABqNQPPvE1MEIvPU6p1Qn/vPFg634E4=
X-Google-Smtp-Source: ABdhPJyR41nlqSbu3PH+3jeD6jWrov1oPPkf0n3CdL4OsmIwHViPtdUgpjEuvSCxBBWHVZZ+B03HSf5gJpvPd8grqrg=
X-Received: by 2002:a17:902:c784:b029:104:9a21:262a with SMTP id
 w4-20020a170902c784b02901049a21262amr4650065pla.21.1623329708212; Thu, 10 Jun
 2021 05:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210610122126.50504-1-stephan@gerhold.net> <20210610122126.50504-10-stephan@gerhold.net>
In-Reply-To: <20210610122126.50504-10-stephan@gerhold.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Jun 2021 15:54:52 +0300
Message-ID: <CAHp75VensmLxN-1biCRGyz2vSsNe5Sd6YKGNbZz-m0+c6ACHeg@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] iio: accel: bma180/bmc150: Move BMA254 to
 bmc150-accel driver
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 10, 2021 at 3:24 PM Stephan Gerhold <stephan@gerhold.net> wrote:
>
> Commit c1d1c4a62db5 ("iio: accel: bma180: BMA254 support") added
> BMA254 support to the bma180 driver and changed some naming to BMA25x
> to make it easier to add support for BMA253 and BMA255.
>
> Unfortunately, there is quite some overlap between the bma180 driver
> and the bmc150-accel driver. Back when the commit was made, the
> bmc150-accel driver actually already had support for BMA255, and
> adding support for BMA254 would have been as simple as adding a new
> compatible to bmc150-accel.
>
> The bmc150-accel driver is a bit better for BMA254 since it also
> supports the motion trigger/interrupt functionality. Fortunately,
> moving BMA254 support over to bmc150-accel is fairly simple because
> the drivers have compatible device tree bindings.
>
> Revert most of the changes for BMA254 support in bma180 and move
> BMA254 over to bmc150-accel. This has the following advantages:
>
>   - Support for motion trigger/interrupt
>   - Fix incorrect scale values (BMA254 currently uses the same as
>     BMA250 but actually they're different because of 10 vs 12 bits
>     data size)
>   - Less code than before :)
>
> BMA250 could be potentially also moved but it's more complicated
> because its chip_id conflicts with the one for BMA222 in bmc150-accel.
> Perhaps there are also other register differences, I did not investigate
> further yet (and I have no way to test it).

...

>           Say Y here if you want to build a driver for the Bosch BMA023, BMA150
> -         BMA180, SMB380, or BMA25x triaxial acceleration sensor.
> +         BMA180, SMB380, or BMA250 triaxial acceleration sensor.

Unsorted before and after.

...

> -               .name = "BMC150/BMI055/BMA253/BMA255",
> +               .name = "BMC150/BMI055/BMA253/BMA254/BMA255",

Ditto.

-- 
With Best Regards,
Andy Shevchenko
