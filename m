Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 899EA1274CB
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2019 05:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfLTEsQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Dec 2019 23:48:16 -0500
Received: from sender4-op-o11.zoho.com ([136.143.188.11]:17102 "EHLO
        sender4-op-o11.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfLTEsQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Dec 2019 23:48:16 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1576817274; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Uhi6saMEWIF0W4SD6a/cVY+ZqyC7nFUsZkDlAhSFmL+10LBQStxb8XuQz8o7RldZP1hrzR2lniJR3Ih+6ZxkS9QoDOLPAvLxfHPcyG/Yj1bX/WvC9M92HyhVfxGImiLJ+pRt+uWDpQKZpRanDySa9lFvOphTivFJPikdzFDokoM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1576817274; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=WqQYmIHqakoWmZLNCLRr/lqEXOvRhny8BmoO3hRYEBE=; 
        b=Bx4erN8TJRQnJjaS/dVim0hWZiyITIUfcb1Qm9i3cbmmFnFVb43Rw5MZPzYgEWHY6fcDFgnXPoBgiCkdM1l1OoRTB2V966Nejs6bX7/v5xSzITFigmx9OMvinqslxg/Dyus9hjcYiqwS8BG44llIaNpChzHEOPOIGUhinvn6aIQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from nessie (pool-173-73-58-202.washdc.fios.verizon.net [173.73.58.202]) by mx.zohomail.com
        with SMTPS id 1576817271424413.5772173135234; Thu, 19 Dec 2019 20:47:51 -0800 (PST)
Date:   Fri, 20 Dec 2019 04:32:20 +0000
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
        Joe Perches <joe@perches.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v7 2/3] iio: (bma400) add driver for the BMA400
Message-ID: <20191220043220.GA16415@nessie>
References: <20191219041039.23396-1-dan@dlrobertson.com>
 <20191219041039.23396-3-dan@dlrobertson.com>
 <CAHp75VdVmfAi5hSp23Gn8nm6LmX-Mr5Tnxcbus90DrRL+gVFRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdVmfAi5hSp23Gn8nm6LmX-Mr5Tnxcbus90DrRL+gVFRA@mail.gmail.com>
X-ZohoMailClient: External
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 19, 2019 at 01:02:28PM +0200, Andy Shevchenko wrote:
> On Thu, Dec 19, 2019 at 6:27 AM Dan Robertson <dan@dlrobertson.com> wrote:
> > Add a IIO driver for the Bosch BMA400 3-axes ultra-low power accelerometer.
> > The driver supports reading from the acceleration and temperature
> > registers. The driver also supports reading and configuring the output data
> > rate, oversampling ratio, and scale.
> 
> ...
> 
> > +static int bma400_set_accel_output_data_rate(struct bma400_data *data,
> > +                                            int hz, int uhz)
> > +{
> > +       unsigned int idx;
> > +       unsigned int odr;
> > +       unsigned int val;
> > +       int ret;
> > +
> > +       if (hz >= BMA400_ACC_ODR_MIN_WHOLE_HZ) {
> > +               if (uhz || hz % BMA400_ACC_ODR_MIN_WHOLE_HZ)
> > +                       return -EINVAL;
> > +
> > +               val = hz / BMA400_ACC_ODR_MIN_WHOLE_HZ;
> 
> Again, AFAICS division may be avoided in both cases (% and / above)
> because of is_power_of_2() check below.
> Can you revisit this?

Yeah I can update this in the next patchset, but I don't know if it is much more
readable this way.

> > +               if (!is_power_of_2(val))
> > +                       return -EINVAL;
> > +
> > +               idx = __ffs(val) + BMA400_ACC_ODR_MIN_RAW + 1;
> > +       } else if (hz == BMA400_ACC_ODR_MIN_HZ && uhz == 500000) {
> > +               idx = BMA400_ACC_ODR_MIN_RAW;
> > +       } else {
> > +               return -EINVAL;
> > +       }
> > +
> > +       ret = regmap_read(data->regmap, BMA400_ACC_CONFIG1_REG, &val);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /* preserve the range and normal mode osr */
> 
> > +       odr = idx | (~BMA400_ACC_ODR_MASK & val);
> 
> Yoda style?

Fixed in v8.

> > +
> > +       ret = regmap_write(data->regmap, BMA400_ACC_CONFIG1_REG, odr);
> > +       if (ret)
> > +               return ret;
> > +
> > +       bma400_output_data_rate_from_raw(idx, &data->sample_freq.hz,
> > +                                        &data->sample_freq.uhz);
> > +       return 0;
> > +}
> ...
> 
> > +int bma400_accel_scale_to_raw(struct bma400_data *data, unsigned int val)
> > +{
> > +       int scale = val / BMA400_SCALE_MIN;
> > +       int raw;
> > +
> > +       if (scale == 0)
> > +               return -EINVAL;
> > +
> > +       raw = __ffs(scale);
> > +
> > +       if (val % BMA400_SCALE_MIN || !is_power_of_2(scale))
> > +               return -EINVAL;
> 
> Ditto.
> 
> > +
> > +       return raw;
> > +}
> 
> ...
> 
> > +out:
> 
> Make a little sense. Why not return directly?

Mostly setup for the next patch in this patchset.

> > +       return ret;
> 
> ...
> 
> > +       ret = bma400_init(data);
> > +       if (ret < 0)
> 
> May it be positive value returned?

Fixed in v8.

Cheers,

 - Dan

