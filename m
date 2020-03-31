Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED6EB199CBA
	for <lists+linux-iio@lfdr.de>; Tue, 31 Mar 2020 19:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgCaRVv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Mar 2020 13:21:51 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35055 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgCaRVv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Mar 2020 13:21:51 -0400
Received: by mail-pl1-f196.google.com with SMTP id c12so5528488plz.2;
        Tue, 31 Mar 2020 10:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j8+rN5Pcf/ZHU8Cu3r+wRUAZeIw7Y2aVcFS/ElbbMOI=;
        b=dsnEmK4q/by3MkmFJhH0P/IVqXj7TDb7Hm6j3iCBEVjxXKY+lZe2I+cTrb68qyXvuy
         bceqOLlgZq9hTbN34dH1CeuVDAkjrJRxToThEbkWCpeb11og7BjNjcJnGtYUn4620fVK
         V5dTQVrwLK/x49cUhD1VywJueVWQZwy/rWewefQbKBDtpeoN6s1JzGyzJqVVu72sQY+u
         aFxvleeO2cOwRNwO/g2dtEf5UiyS/GSoxwE3qwu4nxBzVdkYBcG63jLnYgF2ESejMlhK
         85YX5FO0s6p+68i9iFAHbNFsAdJAqfSELs8gRjKtkW88GpEbWm3EXB4+UY87U6I/Ht5C
         AVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j8+rN5Pcf/ZHU8Cu3r+wRUAZeIw7Y2aVcFS/ElbbMOI=;
        b=dFls0DNSWJMD/gaNxV6vGieXQjvHpXqbfUVenSAxcNQruHTqAuzVOtGZbnkfm2pXiQ
         IbXFotWn+6jPxhan7L2OcOgwPyC6s71HNN1iekJxbvSVDE6IaUUP7mYay4BSnF0SdIX8
         FHyxlZTs0MNnWCXOS9j75cgxlPckPbaVKCSUC3EFCZzdMKOiPbwjSI3BX+OzW2k/EQeS
         9DulpkkAm8uG/J9NPyVjOQFIy1s3tSPpsOz0ICaFIEsj+2rN6D4pbTJ7zkRJK1PwFtBZ
         Miv9z7N/gho+yAcQXyl2x+bHbua7HjIe4dGOWHDp1VaH5Wj6+dNUCC31ge/JJyXCA0xz
         ljHQ==
X-Gm-Message-State: AGi0PuaUVZY5nYg/jNqI/6z7kVgDZ16kvjO13xxEYJDqfo0D5kq1DaJk
        7uhzWy7RFk0TTJi68LwJCUKnghxvKZY5fk1uD3w=
X-Google-Smtp-Source: APiQypLNlur1V4Vx/h/n/lkPdNk23r1zBF8l8EQLRooU7NS8cwaG6IdemE4gwpPaHNz4xB7hKRYdoIBj6SmNLb6UsRE=
X-Received: by 2002:a17:90a:e982:: with SMTP id v2mr3121357pjy.1.1585675310212;
 Tue, 31 Mar 2020 10:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200330152711.8769-1-i.mikhaylov@yadro.com> <20200330152711.8769-3-i.mikhaylov@yadro.com>
 <CAHp75VeLtPkb0e4uNP+1LGgtquBXkb5=bPi54O1U92uaO5jqvw@mail.gmail.com>
 <5cb43513906e1175801ea4e753c855623fcd11d1.camel@yadro.com>
 <CAHp75VexS-iVeDXsCFqgzCKokgzzeH=BFtUqOJdY+kS8O6B9bw@mail.gmail.com> <86186f02c630a05cf7254a38e0f15d726e2f440b.camel@yadro.com>
In-Reply-To: <86186f02c630a05cf7254a38e0f15d726e2f440b.camel@yadro.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 31 Mar 2020 20:21:43 +0300
Message-ID: <CAHp75VfAEpuNKpCKdN7cFPX6+OQ9h0vFvhKmeLpO9DS1SCbEkA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] iio: proximity: Add driver support for vcnl3020
 proximity sensor
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 31, 2020 at 7:56 PM Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
> On Tue, 2020-03-31 at 14:00 +0300, Andy Shevchenko wrote:
> > > > Why not to use standard pattern, i.e.
> > > >
> > > >   if (rc)
> > > >     return rc;
> > > >   ...
> > > >   rc = regmap_write(...);
> > > >
> > > > ?
> > >
> > > Optional parameter. There exists a lot of ways to do it:
> >
> > I'm simple reading the code. And I believe the above I suggested is
> > cleaner equivalent.
> > Is it?
> >
> > > rc = device_property_read_u32(dev, "milliamp", &led_current);
> > > rc = regmap_write(regmap, VCNL_LED_CURRENT, (!rc) : led_current ? 0);
> >
> > This seems not equal to above.
>
> Yes, it is not equal. Error will be returned in case of non existent parameter
> in vcnl3020_init but parameter is optional. rc shouldn't be checked

Ah it makes sense.

> or should
> return 0 with your suggestion.
>
> rc = device_property_read_u32(...);
> if (rc)
>         return 0;
> rc = regmap_write(...);
> if (rc)
>         dev_err(...);
> return rc;

In case we would like to have more optional parameters above will be a burden.
Perhaps

static int get_and_apply_property_x(...)
{
  ...Above code...
}

...and in the function

rc = get_and_apply_property_x(...)
if (rc)
  return rc;

or if it's the last one,

return get_and_apply_property_x(...);

-- 
With Best Regards,
Andy Shevchenko
