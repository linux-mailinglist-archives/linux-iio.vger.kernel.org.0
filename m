Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBEC411F905
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2019 17:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfLOQbL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Dec 2019 11:31:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:45514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfLOQbK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Dec 2019 11:31:10 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61AAD206D8;
        Sun, 15 Dec 2019 16:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576427469;
        bh=ktyZ/NUBXxF+ma0Le443TdiIJHqPYVPSGT5eOza8uqI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L+WoZdCmm5LMRzwz4zR4g1Ti3mhatn96qsmpPNqBsFyUBpYYSCGoRHnV8nIdNmAZX
         BZsbhawqYisPXqRxdyVnJdjSiceDTfgYGlFSkV7dNgt7j0GOaEvtDdp0kJ5bGt6Dvj
         RV/ghdgshYlEBUlMXhwim7yLiaTtEz1mfXDKNVmU=
Date:   Sun, 15 Dec 2019 16:31:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dan Robertson <dan@dlrobertson.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v6 2/2] iio: (bma400) add driver for the BMA400
Message-ID: <20191215163103.17cee7d4@archlinux>
In-Reply-To: <CAHp75VezHcGwwWZ8tSf6FKoYQ_c4=WhYE2ag6OtcAJ2Z9M3ZOA@mail.gmail.com>
References: <20191211010308.1525-1-dan@dlrobertson.com>
        <20191211010308.1525-3-dan@dlrobertson.com>
        <CAHp75VdAJwMkPZQLLQrOk4HABjG-parEOmH8S-6kU+zyYnnfww@mail.gmail.com>
        <20191212001735.GA4667@nessie>
        <CAHp75VezHcGwwWZ8tSf6FKoYQ_c4=WhYE2ag6OtcAJ2Z9M3ZOA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 12 Dec 2019 11:41:45 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Dec 12, 2019 at 2:33 AM Dan Robertson <dan@dlrobertson.com> wrote:
> > On Wed, Dec 11, 2019 at 03:21:56PM +0200, Andy Shevchenko wrote:  
> > > On Wed, Dec 11, 2019 at 3:20 AM Dan Robertson <dan@dlrobertson.com> wrote:  
> 
> > > > +#define BMA400_LP_OSR_SHIFT         0x05
> > > > +#define BMA400_NP_OSR_SHIFT         0x04
> > > > +#define BMA400_SCALE_SHIFT          0x06  
> > >
> > > I'm not sure why this is being defined as hex number instead of plain decimal...  
> >
> > Sounds good.
> >  
> > > > +#define BMA400_TWO_BITS_MASK        GENMASK(1, 0)
> > > > +#define BMA400_LP_OSR_MASK          GENMASK(6, BMA400_LP_OSR_SHIFT)
> > > > +#define BMA400_NP_OSR_MASK          GENMASK(5, BMA400_NP_OSR_SHIFT)
> > > > +#define BMA400_ACC_ODR_MASK         GENMASK(3, 0)
> > > > +#define BMA400_ACC_SCALE_MASK       GENMASK(7, BMA400_SCALE_SHIFT)  
> > >
> > > And here simple better to put same numbers. It will help to read.  
> >
> > Do you mean for the shift or for the mask?  
> 
> SHIFTs -> plain decimals
> 
> > > > +EXPORT_SYMBOL(bma400_regmap_config);  
> > >
> > > I'm not sure I got the idea why this one is being exported.  
> >
> > It needs to be exported so that it can be used in the bma400_i2c module and the
> > future bma400_spi module. In theory, if we _really_ do not want to export this,
> > then we can define separate regmap configs in each of the bma400_i2c and
> > (future) bma400_spi modules, but then we would have to export the is_volitile_reg
> > and is_writable_reg functions. As a result, I do not see any benefits to that
> > method over exporting the config, but I could be convinced otherwise.  
> 
> I think there might be better way to do this.
> But I leave it to you and maintainer to agree on (I will be fine with
> any solution you will come to).

This does always feel a bit silly.  We have plenty of cases of both
the suggested options (replicate vs export). I don't really care either way.


> 
> > > > +               if (uhz || hz % BMA400_ACC_ODR_MIN_WHOLE_HZ)
> > > > +                       return -EINVAL;
> > > > +
> > > > +               val = hz / BMA400_ACC_ODR_MIN_WHOLE_HZ;
> > > > +               idx = __ffs(val);
> > > > +  
> > >  
> > > > +               if (val ^ BIT(idx))  
> > >
> > > Seems like funny way of checking is_power_of_2(). But it's up to maintainers.
> > > And your variant may even be better here (in code generation perspective)...
> > >
> > > However, the whole idea here is, IIUC, to have something like
> > >
> > >   hz = 2^idx * BMA400_ACC_ODR_MIN_WHOLE_HZ
> > >
> > > I think you may do it without divisions, i.e. call __ffs() first and then do
> > >    idx = __ffs(...);
> > >    val = hz >> idx;
> > >    if (val != BMA400_ACC_ODR_MIN_WHOLE_HZ)
> > >     return -EINVAL;
> > >
> > > or something like above.  
> >
> > It would be more obvious what is being done here with is_power_of_two. I'll
> > revisit this function with your suggestions. If I can make it simpler, I'll
> > go this route.  
> 
> The main point here to get rid of divisions. Is it achievable?
> 
> > > > +                       return -EINVAL;  
> > >
> > > ...  
> 
> > > > +       ret = regmap_read(data->regmap, BMA400_ACC_CONFIG0_REG, &val);
> > > > +       if (ret < 0)  
> > >
> > > I'm wondering if in all of these regmap_read()...
> > >  
> > > > +               return ret;  
> > >  
> > > > +       ret = regmap_write(data->regmap, BMA400_ACC_CONFIG0_REG,
> > > > +                          mode | (val & ~BMA400_TWO_BITS_MASK));
> > > > +       if (ret < 0) {  
> > >
> > > ...and regmap_write() calls you ever can get a positive returned code.  
> >
> > From the regmap_read/regmap_write docs:
> >  
> > > * A value of zero will be returned on success, a negative errno will
> > > * be returned in error cases.  
> >
> > So I assume ret <= 0  
> 
> There is no positive codes mentioned at all. And you assume right.
> But why we care about positive codes if they never can be returned?
Agreed, for regmap calls, definitely prefer the driver to check with
if (ret)
	...
> 

