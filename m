Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 229EE11C9AF
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2019 10:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbfLLJl6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Dec 2019 04:41:58 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42054 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbfLLJlz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Dec 2019 04:41:55 -0500
Received: by mail-pf1-f195.google.com with SMTP id 4so456832pfz.9;
        Thu, 12 Dec 2019 01:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nqldGoReHAqAk+cCLWay8D5xD350FZnLqhYpYXAhHH8=;
        b=u5SBg2z8I1z6zoptoyt6jacu8N12W2nd3dbifd6S7GkMnSTSjCEiQvh5vJsnRQ+g7j
         fINT2UX1NBiHZM3W2BpO2Zvn7GNYZ3cg2qu0gvCgVMWef0rVn1i9W5k0WCsKWeDTYLMA
         DMJldK8o52HZEw1ko+313+V2B7LLOWP7+4GzRkWyWz4TG0ttF+/Sn8JAHsuiI7aDX9G5
         XWj7mG/x5lEDCxcHkxRO8JgXgd7z/P081ojMzNkG0K6eWElzwJn2iNM3oCN9oZ5qxJNe
         bzSc3S+5IC6aUsRXtipHOSCDkILXmncLffLi/z7Ru9qHy7yDR54fOsLiFuOSialwOMCz
         B3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nqldGoReHAqAk+cCLWay8D5xD350FZnLqhYpYXAhHH8=;
        b=oxH7v3aQCLe2tyzLPTz9+7sRH4QLBY1jlcZleU3IahjQs7vgFPa7zJl3Fv6NBTEzmN
         o25gv3SHCLGNBsQDEYT4WSdOReCWFeXErCQRrxZzalRkveTlHbMvxnIi6+EYMtYX396/
         nXEMkUYkONdYwDMiwurLISPgUCA5ztdzg/a4WxCBcS+QYUCR/7wxt2Dgru7KylgwaZku
         38SD6nOCFDeybmPLPf1Upnoor43HSYnxIRYUEjCqlz5fz/EBkNPOgTM0K0c/7z1JiBeJ
         uklC5FFUh/uCG34OxJ6Tj4zuulhXqmX8zz0REVy8iF4t0Co/G5wqfHEHdOqChFLOWenC
         yKdw==
X-Gm-Message-State: APjAAAXX3AX0+baRfKSdYads9R5JF5t6j8Bl/45q5fQC9keI2NtNwsSp
        hGbUvxzuyrMCvT7+qo6PXwjgCPHmCcjlQmjS06I=
X-Google-Smtp-Source: APXvYqyaJri9LBw5453s33quy2tAl+OdZHJ+fpc3dBR/CqpUX9/bqt4NhAXnxiT/xG0qm1LXP2+Uj/cdyawHqOhL8rU=
X-Received: by 2002:a63:e14a:: with SMTP id h10mr9241444pgk.74.1576143714981;
 Thu, 12 Dec 2019 01:41:54 -0800 (PST)
MIME-Version: 1.0
References: <20191211010308.1525-1-dan@dlrobertson.com> <20191211010308.1525-3-dan@dlrobertson.com>
 <CAHp75VdAJwMkPZQLLQrOk4HABjG-parEOmH8S-6kU+zyYnnfww@mail.gmail.com> <20191212001735.GA4667@nessie>
In-Reply-To: <20191212001735.GA4667@nessie>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 12 Dec 2019 11:41:45 +0200
Message-ID: <CAHp75VezHcGwwWZ8tSf6FKoYQ_c4=WhYE2ag6OtcAJ2Z9M3ZOA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] iio: (bma400) add driver for the BMA400
To:     Dan Robertson <dan@dlrobertson.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 12, 2019 at 2:33 AM Dan Robertson <dan@dlrobertson.com> wrote:
> On Wed, Dec 11, 2019 at 03:21:56PM +0200, Andy Shevchenko wrote:
> > On Wed, Dec 11, 2019 at 3:20 AM Dan Robertson <dan@dlrobertson.com> wrote:

> > > +#define BMA400_LP_OSR_SHIFT         0x05
> > > +#define BMA400_NP_OSR_SHIFT         0x04
> > > +#define BMA400_SCALE_SHIFT          0x06
> >
> > I'm not sure why this is being defined as hex number instead of plain decimal...
>
> Sounds good.
>
> > > +#define BMA400_TWO_BITS_MASK        GENMASK(1, 0)
> > > +#define BMA400_LP_OSR_MASK          GENMASK(6, BMA400_LP_OSR_SHIFT)
> > > +#define BMA400_NP_OSR_MASK          GENMASK(5, BMA400_NP_OSR_SHIFT)
> > > +#define BMA400_ACC_ODR_MASK         GENMASK(3, 0)
> > > +#define BMA400_ACC_SCALE_MASK       GENMASK(7, BMA400_SCALE_SHIFT)
> >
> > And here simple better to put same numbers. It will help to read.
>
> Do you mean for the shift or for the mask?

SHIFTs -> plain decimals

> > > +EXPORT_SYMBOL(bma400_regmap_config);
> >
> > I'm not sure I got the idea why this one is being exported.
>
> It needs to be exported so that it can be used in the bma400_i2c module and the
> future bma400_spi module. In theory, if we _really_ do not want to export this,
> then we can define separate regmap configs in each of the bma400_i2c and
> (future) bma400_spi modules, but then we would have to export the is_volitile_reg
> and is_writable_reg functions. As a result, I do not see any benefits to that
> method over exporting the config, but I could be convinced otherwise.

I think there might be better way to do this.
But I leave it to you and maintainer to agree on (I will be fine with
any solution you will come to).

> > > +               if (uhz || hz % BMA400_ACC_ODR_MIN_WHOLE_HZ)
> > > +                       return -EINVAL;
> > > +
> > > +               val = hz / BMA400_ACC_ODR_MIN_WHOLE_HZ;
> > > +               idx = __ffs(val);
> > > +
> >
> > > +               if (val ^ BIT(idx))
> >
> > Seems like funny way of checking is_power_of_2(). But it's up to maintainers.
> > And your variant may even be better here (in code generation perspective)...
> >
> > However, the whole idea here is, IIUC, to have something like
> >
> >   hz = 2^idx * BMA400_ACC_ODR_MIN_WHOLE_HZ
> >
> > I think you may do it without divisions, i.e. call __ffs() first and then do
> >    idx = __ffs(...);
> >    val = hz >> idx;
> >    if (val != BMA400_ACC_ODR_MIN_WHOLE_HZ)
> >     return -EINVAL;
> >
> > or something like above.
>
> It would be more obvious what is being done here with is_power_of_two. I'll
> revisit this function with your suggestions. If I can make it simpler, I'll
> go this route.

The main point here to get rid of divisions. Is it achievable?

> > > +                       return -EINVAL;
> >
> > ...

> > > +       ret = regmap_read(data->regmap, BMA400_ACC_CONFIG0_REG, &val);
> > > +       if (ret < 0)
> >
> > I'm wondering if in all of these regmap_read()...
> >
> > > +               return ret;
> >
> > > +       ret = regmap_write(data->regmap, BMA400_ACC_CONFIG0_REG,
> > > +                          mode | (val & ~BMA400_TWO_BITS_MASK));
> > > +       if (ret < 0) {
> >
> > ...and regmap_write() calls you ever can get a positive returned code.
>
> From the regmap_read/regmap_write docs:
>
> > * A value of zero will be returned on success, a negative errno will
> > * be returned in error cases.
>
> So I assume ret <= 0

There is no positive codes mentioned at all. And you assume right.
But why we care about positive codes if they never can be returned?

-- 
With Best Regards,
Andy Shevchenko
