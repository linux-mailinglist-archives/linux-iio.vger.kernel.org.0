Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90F4811C175
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2019 01:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfLLAdO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Dec 2019 19:33:14 -0500
Received: from sender4-op-o11.zoho.com ([136.143.188.11]:17124 "EHLO
        sender4-op-o11.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfLLAdO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2019 19:33:14 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1576110779; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=X03i3V/8EUcM4luIhZRpY/0odgc75H4FDcR6CcpcWIyBuQ4f6rr08GUvv0bfI/UA9GvqiJinK18u9ID0gk0yJ20jws6uLu1DVLoOTYHCkyHxyfaYACg2rtZZO+CV8tCuLXoPbz3u9NyTc7eyz9AWjLLwMTzxORygeif2v1g9ens=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1576110779; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=52I5t2+RJ1d8gIfMJ4FqE43LzPcw+pznymfSad4xjbk=; 
        b=UTy/00hBxJFLgKpMC2jspMD9+G+mxdNxljNzSH6woTSn5TO4M3YQUoLxQYmRijQ1AsBgol8hrvScE94rdtCuH+0XG4+6j6loVv49ts4KeL5JmUnt7csCXGjVhNrm1d6ERSjJVyb2vwAV4sU5v2M+gBliWzROWzEvmyyGDRVcn9A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from nessie (pool-173-73-58-202.washdc.fios.verizon.net [173.73.58.202]) by mx.zohomail.com
        with SMTPS id 1576110778099739.3714501720381; Wed, 11 Dec 2019 16:32:58 -0800 (PST)
Date:   Thu, 12 Dec 2019 00:17:35 +0000
From:   Dan Robertson <dan@dlrobertson.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
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
Message-ID: <20191212001735.GA4667@nessie>
References: <20191211010308.1525-1-dan@dlrobertson.com>
 <20191211010308.1525-3-dan@dlrobertson.com>
 <CAHp75VdAJwMkPZQLLQrOk4HABjG-parEOmH8S-6kU+zyYnnfww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdAJwMkPZQLLQrOk4HABjG-parEOmH8S-6kU+zyYnnfww@mail.gmail.com>
X-ZohoMailClient: External
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 11, 2019 at 03:21:56PM +0200, Andy Shevchenko wrote:
> On Wed, Dec 11, 2019 at 3:20 AM Dan Robertson <dan@dlrobertson.com> wrote:
> >
> > Add a IIO driver for the Bosch BMA400 3-axes ultra-low power accelerometer.
> > The driver supports reading from the acceleration and temperature
> > registers. The driver also supports reading and configuring the output data
> > rate, oversampling ratio, and scale.
> 
> > +#define BMA400_LP_OSR_SHIFT         0x05
> > +#define BMA400_NP_OSR_SHIFT         0x04
> > +#define BMA400_SCALE_SHIFT          0x06
> 
> I'm not sure why this is being defined as hex number instead of plain decimal...

Sounds good.

> > +#define BMA400_TWO_BITS_MASK        GENMASK(1, 0)
> > +#define BMA400_LP_OSR_MASK          GENMASK(6, BMA400_LP_OSR_SHIFT)
> > +#define BMA400_NP_OSR_MASK          GENMASK(5, BMA400_NP_OSR_SHIFT)
> > +#define BMA400_ACC_ODR_MASK         GENMASK(3, 0)
> > +#define BMA400_ACC_SCALE_MASK       GENMASK(7, BMA400_SCALE_SHIFT)
> 
> And here simple better to put same numbers. It will help to read.

Do you mean for the shift or for the mask?

> > +const struct regmap_config bma400_regmap_config = {
> > +       .reg_bits = 8,
> > +       .val_bits = 8,
> > +       .max_register = BMA400_CMD_REG,
> > +       .cache_type = REGCACHE_RBTREE,
> > +       .writeable_reg = bma400_is_writable_reg,
> > +       .volatile_reg = bma400_is_volatile_reg,
> > +};
> > +EXPORT_SYMBOL(bma400_regmap_config);
> 
> I'm not sure I got the idea why this one is being exported.

It needs to be exported so that it can be used in the bma400_i2c module and the
future bma400_spi module. In theory, if we _really_ do not want to export this,
then we can define separate regmap configs in each of the bma400_i2c and
(future) bma400_spi modules, but then we would have to export the is_volitile_reg
and is_writable_reg functions. As a result, I do not see any benefits to that
method over exporting the config, but I could be convinced otherwise.

> > +               if (odr < BMA400_ACC_ODR_MIN_RAW ||
> > +                   odr > BMA400_ACC_ODR_MAX_RAW) {
> 
> One line?

It is too long if I simplify to one line.

> > +               if (uhz || hz % BMA400_ACC_ODR_MIN_WHOLE_HZ)
> > +                       return -EINVAL;
> > +
> > +               val = hz / BMA400_ACC_ODR_MIN_WHOLE_HZ;
> > +               idx = __ffs(val);
> > +
> 
> > +               if (val ^ BIT(idx))
> 
> Seems like funny way of checking is_power_of_2(). But it's up to maintainers.
> And your variant may even be better here (in code generation perspective)...
> 
> However, the whole idea here is, IIUC, to have something like
> 
>   hz = 2^idx * BMA400_ACC_ODR_MIN_WHOLE_HZ
> 
> I think you may do it without divisions, i.e. call __ffs() first and then do
>    idx = __ffs(...);
>    val = hz >> idx;
>    if (val != BMA400_ACC_ODR_MIN_WHOLE_HZ)
>     return -EINVAL;
> 
> or something like above.

It would be more obvious what is being done here with is_power_of_two. I'll
revisit this function with your suggestions. If I can make it simpler, I'll
go this route.

> 
> > +                       return -EINVAL;
> 
> ...
> 
> > +       odr = (~BMA400_ACC_ODR_MASK & val) | idx;
> 
> I'm wondering why Yoda style is being used here.

I guess I think like Yoda :) I can update this. I typically do prefer
new_mask | old_mask, but I do not feel too strongly about it.

> > +static void bma400_accel_scale_from_raw(int raw, unsigned int *val)
> > +{
> > +       *val = BMA400_SCALE_MIN * (1 << raw);
> 
> Isn't it the same as
>     *val = BMA400_SCALE_MIN << raw;
> ?

Yes. Good catch. Not sure what I was thinking :)

> 
> > +               return -EINVAL;
> 
> ...
> 
> > +       ret = regmap_read(data->regmap, BMA400_ACC_CONFIG0_REG, &val);
> > +       if (ret < 0)
> 
> I'm wondering if in all of these regmap_read()...
> 
> > +               return ret;
> 
> > +       ret = regmap_write(data->regmap, BMA400_ACC_CONFIG0_REG,
> > +                          mode | (val & ~BMA400_TWO_BITS_MASK));
> > +       if (ret < 0) {
> 
> ...and regmap_write() calls you ever can get a positive returned code.

From the regmap_read/regmap_write docs:

> * A value of zero will be returned on success, a negative errno will
> * be returned in error cases.

So I assume ret <= 0

Cheers,

 - Dan

