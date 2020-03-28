Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68C6119683E
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 18:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgC1RvW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 13:51:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbgC1RvW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Mar 2020 13:51:22 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 874EE20714;
        Sat, 28 Mar 2020 17:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585417881;
        bh=R6KoaEnQ216q4GA1ys0ah1T7EU57N7ZOKvH4fWy6MDE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X+t8Haw8bRSHyIODxOddObNMHHzTC4A/gIgrmlA8G4FJX+96HIPkjD0njXTo8iIJH
         7v6ti+BJudpolLJZIuyhN1qhDYPTiVIGizpZqnN/K/5receeAFe1iHybrtzyRn/eSg
         tZafwQty9zCxiOMZgtwgMjZCqHtPzSktGtbBYMAA=
Date:   Sat, 28 Mar 2020 17:51:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Saravanan Sekar <sravanhome@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Sebastian Reichel <sre@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v5 3/5] iio: adc: mp2629: Add support for mp2629 ADC
 driver
Message-ID: <20200328175116.13c2bae3@archlinux>
In-Reply-To: <CAHp75Vd+m=1eaDY1JLvtNKbBPXsaTFmpewG=Vn+v-=+GMBCs2w@mail.gmail.com>
References: <20200328001154.17313-1-sravanhome@gmail.com>
        <20200328001154.17313-4-sravanhome@gmail.com>
        <CAHp75Vd+m=1eaDY1JLvtNKbBPXsaTFmpewG=Vn+v-=+GMBCs2w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 28 Mar 2020 12:52:11 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, Mar 28, 2020 at 2:12 AM Saravanan Sekar <sravanhome@gmail.com> wrote:
> >
> > Add support for 8-bit resolution ADC readings for input power
> > supply and battery charging measurement. Provides voltage, current
> > readings to mp2629 power supply driver.  
> 
> ...
> 
> > +               ret = regmap_read(info->regmap, chan->address, &rval);
> > +               if (ret < 0)  
> 
> ' < 0' is not needed for regmap call.
> 
> ..
> 
> > +               case MP2629_INPUT_CURRENT:
> > +                       *val = 133;
> > +                       *val2 = 10;
> > +                       return IIO_VAL_FRACTIONAL;
> > +
> > +               default:
> > +                       return -EINVAL;
> > +               }
> > +
> > +       default:
> > +               return -EINVAL;
> > +       }  
> 
> > +
> > +       return 0;  
> 
> Do you really need this? Looks to me as dead code.
> 
> ...
> 
> > +       indio_dev->name = dev_name(dev);  
> 
> Shouldn't be this a part number?
> I heard something, so, I might be mistaken, but I hope maintainers
> will help here.

It should indeed.  I have a nasty habit of missing this in
review so thanks for pointing it out!

Jonathan

