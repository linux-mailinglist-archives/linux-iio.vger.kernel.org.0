Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3C07196586
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 12:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgC1LGd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 07:06:33 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37129 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbgC1LGa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2020 07:06:30 -0400
Received: by mail-pj1-f66.google.com with SMTP id o12so4904064pjs.2;
        Sat, 28 Mar 2020 04:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xwqIvEeP3Vt3fTQGzaeqWDuGXBUR2dpVD8iwb1hKRFg=;
        b=BlQDoAVcKEIX+ETSBr03c2Puity6qf9d6K9OBD3OtsxsQZLxW5IhSDKjVrPEBfNk10
         CwyHZ3nCrFC52cW9XrOPw9iBUu5CkzfmshjLxSuB7NuOEsWYCWt0NTif/MD7DFh19ipM
         msgL3vMzJkgTC10KlD1f0NsmVIH0WKuuZ1oT1YEpXRDUo75cHdA+LoCYdtfSY02D3vdw
         HWCXdFCcCIT0pO4i2UqnSjpSN5wwGBzBqkwNpdzCgtzvhch5qojUKRD4+QiBP/xLNrib
         O108y4Bfpw5fYpW4tTBlSvKY1g6WQ9Rmaoi3syW0FQZf2BNj21lpiKG+IFbLtSS2v2n7
         Uq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xwqIvEeP3Vt3fTQGzaeqWDuGXBUR2dpVD8iwb1hKRFg=;
        b=aSFTgRbQ8S3C/epn8V+C/7R9bTJLM7oINBkiSZhRF0ytB7A3ccbw5FypU39HRT1JiL
         3T+fG0I5dfQZJUeGBI9aJl1PkH7TJxahOoSHgSTScAO9Q1Mr3uX95U48QK85sEnqy2Dq
         P83t3WkOrlgmj9ooxU5BzzmYYyicnhkLp38GqPzUsVxfw467sSU6r0LOmbyZwfINLzKb
         RESRYO3n19OkpGug36BwahA33O+axZd92pFiieY6HThUEMYsYqDQzeJXzoHA5K1M1E2Z
         SI0HPWdfOxNJ28CsC67L6YW5+9bqzXiyZzhpMzuE/5gbv6efCT/stPCWrQBh/HJmDGaf
         Mvrw==
X-Gm-Message-State: ANhLgQ0q57exw0PObnDgOyKt89/4r3E0JF1PE3kT+I4TIVgI6y01n6rW
        KFFbWjReXzpIZRCgqOfRzJ5LnCpilgLskJDYyPI=
X-Google-Smtp-Source: ADFU+vsuOxLwPs1LAFXP4cwwIfR7SDP2dGQkWujS045o80/7BRwgtQyckb3WD2wg8wY/W9HD7HKLYfi4zo6W4CJOZCE=
X-Received: by 2002:a17:902:5acb:: with SMTP id g11mr3566387plm.18.1585393589055;
 Sat, 28 Mar 2020 04:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200328001154.17313-1-sravanhome@gmail.com> <20200328001154.17313-3-sravanhome@gmail.com>
 <CAHp75Vdc4MxMnmd_h6eFfZAji=4fir7x7bq2MX1q50nAQ1eJ=Q@mail.gmail.com> <23c39834-c2d9-5634-b9d7-8f9e16194752@gmail.com>
In-Reply-To: <23c39834-c2d9-5634-b9d7-8f9e16194752@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 28 Mar 2020 13:06:17 +0200
Message-ID: <CAHp75VcAh07Kb+G5HoZfgWwKTCfRHLcX7nD=g8r3+z5sm4u-dQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] mfd: mp2629: Add support for mps battery charger
To:     saravanan sekar <sravanhome@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Sebastian Reichel <sre@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Mar 28, 2020 at 12:51 PM saravanan sekar <sravanhome@gmail.com> wrote:
>
> Hi Andy,
>
> On 28/03/20 11:45 am, Andy Shevchenko wrote:
> > On Sat, Mar 28, 2020 at 2:12 AM Saravanan Sekar <sravanhome@gmail.com> wrote:
> >> mp2629 is a highly-integrated switching-mode battery charge management
> >> device for single-cell Li-ion or Li-polymer battery.
> >>
> >> Add MFD core enables chip access for ADC driver for battery readings,
> >> and a power supply battery-charger driver
> > ...
> >
> >> +#ifndef __MP2629_H__
> >> +#define __MP2629_H__
> >> +#include <linux/device.h>
> >> +#include <linux/regmap.h>
> >> +#include <linux/types.h>
> > None of these header is in use here.
> >
> > struct device;
> > struct regmap;
> >
> > would be enough.
>
> Yesterday I conveyed to you that Lee is not recommended to use forward
> declaration and asked me
>
> to use includes, then you agreed with the same. Again same comments !!
> sorry I am lost.

Ah, okay. I missed that.
But types.h is still not needed, all data types are provided either by
C or by rest two headers.

> >> +struct mp2629_info {
> >> +       struct device *dev;
> >> +       struct regmap *regmap;
> >> +};
> >> +
> >> +#endif

-- 
With Best Regards,
Andy Shevchenko
