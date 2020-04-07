Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EED851A0C2C
	for <lists+linux-iio@lfdr.de>; Tue,  7 Apr 2020 12:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgDGKmT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Apr 2020 06:42:19 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35925 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbgDGKmS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Apr 2020 06:42:18 -0400
Received: by mail-pj1-f68.google.com with SMTP id nu11so576246pjb.1;
        Tue, 07 Apr 2020 03:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bzqwAdtYLxklcbi4bn5nRW3WLK1NuZfWMg1sbkIYXsg=;
        b=d8OuWtLiXi07adgKhX0vDHo0HDoUXA5WsMgaLztYSFxXDcmZElyNE9Qy7gdt/hjfEi
         28TdKiW/JkTQTCisP+VTlpjlRAxu30MzB/46cIsc6Q9TPiaOmdfmdngyIJfbTKT2wmgK
         3iByKJc7ukrbZlClFzw3AN6uf9IRJn0Cl3cIK45oSgPpm3tDn2ufpH8k35MOpiH/bENE
         8UdPf8lPh65rvPxeVeXaS8Ca/XBjdT4fJ/odZXz9LtSQoX7lPLQ+9VaJvGSmzOVx4cB+
         TkQq8XSlaO4bB08UqpIe2HVn3bt7G5NgFW9b19KdrXfDkdSJHoMxPzIsKaCEBTnfE7ei
         zbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bzqwAdtYLxklcbi4bn5nRW3WLK1NuZfWMg1sbkIYXsg=;
        b=rxALRLj2UWybCJho8Ha+Qw95D7j8e6IdSGtJlbNSnh/RG355B0o7jz4Hs9vIpS2sCZ
         jJdCVRm2o4OBgCpMJzIS5MvZre24f+26pH7+413pI7twUEUgfSbySssrNxxyit7CXIUd
         C2pvOfIJMen99ASrJFS81dbK1PjBVrUudSITDHc5tYydJdRNScTTcdjeyEAmnI3ec3d2
         nNbWQ1M40xqdQ5+fFvVu5xBc7OlrmEhS4D2UuiNcOOFdi4fk7DGC/9NLfbheODuNIo65
         Dbh/RvKfCSTvmgb/VuSHq2aE/2MUdkHBKGyVZ8uyD9LhiWigyhaJR9dX6EIIWu3XjzOb
         i9qQ==
X-Gm-Message-State: AGi0PuYQzz14zZdXj9PAsil8ciKsAMnCHmHm783ngL29wH7LMjvCEU97
        HBhoh1kDm5PCnKDfslPv0HOThbx2fbASp47s3eI=
X-Google-Smtp-Source: APiQypKCY6KcZDQToqX4Nu8arPCYMVSCWsGEwnkNm84wgwLYQRInlV9cAqzJlmLoXg1hlQUeNm2NKRuzzYInrxQR/zs=
X-Received: by 2002:a17:90a:8546:: with SMTP id a6mr2050407pjw.8.1586256137543;
 Tue, 07 Apr 2020 03:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200406150846.878-1-nuno.sa@analog.com> <20200406150846.878-6-nuno.sa@analog.com>
 <CAHp75VeK8K0WHK3gDwyT3ZAaMaVdfZ5xVG94JY4O8fd2U0HEHg@mail.gmail.com>
 <BN6PR03MB33476ECFB3F8454CC6C67F0E99C30@BN6PR03MB3347.namprd03.prod.outlook.com>
 <CAHp75VcOxjnNRetQxUR=8Z-WA=V6rzAFwCfhjNCmjQE3hgAEEA@mail.gmail.com>
 <BN6PR03MB33475380CFB1AD5B50026A6A99C30@BN6PR03MB3347.namprd03.prod.outlook.com>
 <CAHp75VeAOKXNU+FEYsXBZ65sM1AWxB2zA+LJ2diAxyiJPk60mQ@mail.gmail.com> <BN6PR03MB3347A09B7760F6F34086303899C30@BN6PR03MB3347.namprd03.prod.outlook.com>
In-Reply-To: <BN6PR03MB3347A09B7760F6F34086303899C30@BN6PR03MB3347.namprd03.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 7 Apr 2020 13:42:10 +0300
Message-ID: <CAHp75VdOnk7gbkmvR37O-4mLY1jV2A1qw_iX2roerqaq6PVAzg@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] iio: imu: Add support for adis16475
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 7, 2020 at 1:38 PM Sa, Nuno <Nuno.Sa@analog.com> wrote:

> > > > > > > +       irq_type = irqd_get_trigger_type(desc);

> > > > For the sake of consistency I would assign irq_flag here as well.
> > > >
> > >
> > > The library will do it by default, But that's me using "inside" info... or maybe
> > if
> > > I document that in patch 2 (the struct kernel docs) we would not really
> > need to
> > > assign it here?
> >
> > I see now. From my point of view the library here does an ill turn
> > because it hides some details which driver needs to do anyway.
> > I prefer explicit over implicit at least here.
> >
>
> Let's explicitly assign the irq_flag then...
>
> > I would say okay, if there is no such code (like below) would be
> > present in the driver.
>
> Now that I think about, this is actually code that, probably, could go inside the
> library since this is pretty standard for this kind of devices. Anyways, that's
> another story...

It would be awesome if you can do that!
Yes, it probably will require a separate series.

-- 
With Best Regards,
Andy Shevchenko
