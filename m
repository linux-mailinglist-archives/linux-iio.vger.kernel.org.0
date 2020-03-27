Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7F1C195642
	for <lists+linux-iio@lfdr.de>; Fri, 27 Mar 2020 12:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgC0LYf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 07:24:35 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55048 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgC0LYf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2020 07:24:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id c81so11014049wmd.4
        for <linux-iio@vger.kernel.org>; Fri, 27 Mar 2020 04:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NEKo1+Ks52CKrgqp13o2semhHLME73XljK+CspwLPrY=;
        b=Jtw4HczpGtExse/Jed/9i2XrjLsmX3A8SK85csRKWjvyV7FYnyDWaK8osGBUNIh4IT
         SXyF2Inx9f76wiysMcdpRB24m3bU94HFjU9zXmvZsK+rxp96pezRZeLD4AKgMLcX7I6t
         AE0n5YdCM9yiRHauKSO14tA1SwGtP39L7lbsBOvqC2Tl5xCDaXZBKDcBwmNEd9k+gA0a
         K6Fxy5inzLVO95/7z3fX98ZxfcOv5+WuZo3Bl8ZPbXBlA5aswDEs0VuqqwPmkMCfayvV
         6j4uOqJZcjd38vtVnCaXo6geSVe/5BMRbzNACDHgTCBtqfua9IxT+Yq/ksnegy9Xw7X+
         A8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NEKo1+Ks52CKrgqp13o2semhHLME73XljK+CspwLPrY=;
        b=q1NIM6/1752ovMJY6WaEt7VLtMJU9SUF7SdQEFtZFekSBPagvmsab81WD3OaXeBFVm
         8B1KaJRAK+dLjCEsYc8NhKl3/RznU3o4g3C2cqjEc67eltGKwXv5oBOtT4sfOmSzCGpG
         pLHhxHOefQeK5Pr+L8wjOKxACj9iALs0ECz86vCVBIgtL/T6dhx0Svs/3wzp0hHDVkFW
         Q8MMDS7KW2W7KEk6op9/hMJ/B0lu+r6CLMdnlnMENA8vLWTkRwnnfeg5M0JI2LUO74Ou
         WjueQ50Y6gJOsE76mDqeoPrN7NSZ8eEcRa7iyNrBBoXbYcm9n3y8acEzonVWl0JgX0My
         MsKQ==
X-Gm-Message-State: ANhLgQ0Sq+gHEnqWXLgBkgb22URQ6oQa75lcvvFJElM4K3XYJNQ6YwKt
        wbLQDmw6da/8Gb0Tmj5ziNGYu6knEWw=
X-Google-Smtp-Source: ADFU+vukihyFjfwUuPh25SnSXHqq3y8g/HlHxFrHniP9gGajGvwecjChMSKb0wlOCy8D3fuAaLaRiA==
X-Received: by 2002:a7b:c408:: with SMTP id k8mr4876391wmi.11.1585308272376;
        Fri, 27 Mar 2020 04:24:32 -0700 (PDT)
Received: from dell ([95.149.164.95])
        by smtp.gmail.com with ESMTPSA id q17sm8213043wrp.11.2020.03.27.04.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 04:24:31 -0700 (PDT)
Date:   Fri, 27 Mar 2020 11:25:23 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     saravanan sekar <sravanhome@gmail.com>
Cc:     robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 2/5] mfd: mp2629: Add support for mps battery charger
Message-ID: <20200327112523.GC3383@dell>
References: <20200322224626.13160-1-sravanhome@gmail.com>
 <20200322224626.13160-3-sravanhome@gmail.com>
 <20200327075541.GF603801@dell>
 <a6098b6a-2b2f-5279-f9fc-85201b9aabde@gmail.com>
 <20200327102221.GA3383@dell>
 <a679aba5-4cfb-1b6c-8cb0-dab3a644f3e7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a679aba5-4cfb-1b6c-8cb0-dab3a644f3e7@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 27 Mar 2020, saravanan sekar wrote:
> On 27/03/20 11:22 am, Lee Jones wrote:
> > Saravanan, Jonathan,
> > 
> > On Fri, 27 Mar 2020, saravanan sekar wrote:
> > > On 27/03/20 8:55 am, Lee Jones wrote:
> > > > On Sun, 22 Mar 2020, Saravanan Sekar wrote:
> > > > 
> > > > > mp2629 is a highly-integrated switching-mode battery charge management
> > > > > device for single-cell Li-ion or Li-polymer battery.
> > > > > 
> > > > > Add MFD core enables chip access for ADC driver for battery readings,
> > > > > and a power supply battery-charger driver
> > > > > 
> > > > > Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> > > > > ---
> > > > >    drivers/mfd/Kconfig        |   9 +++
> > > > >    drivers/mfd/Makefile       |   2 +
> > > > >    drivers/mfd/mp2629.c       | 116 +++++++++++++++++++++++++++++++++++++
> > > > >    include/linux/mfd/mp2629.h |  22 +++++++
> > > > >    4 files changed, 149 insertions(+)
> > > > >    create mode 100644 drivers/mfd/mp2629.c
> > > > >    create mode 100644 include/linux/mfd/mp2629.h

[...]

> > > > > +#ifndef __MP2629_H__
> > > > > +#define __MP2629_H__
> > > > > +
> > > > > +#include <linux/types.h>
> > > > > +
> > > > > +struct device;
> > > > > +struct regmap;
> > > > Why not just add the includes?
> > > Some more shared enum added in ADC driver
> > Sorry?
> 
> I misunderstood your previous question that you are asking to remove this
> mp2629.h file
> 
> "No user here. (Hint: Use forward declaration of struct device instead)" -
> review comments on V1 from Andy Shevchenko.
> So remove the includes

So Andy has reviewed, but you still don't have him on Cc?

How are we meant to continue the discussion?

As a general rule I'm not a fan of forward declarations.

I think they should be avoided if at all possible.

> > > > > +struct mp2629_info {
> > > > > +	struct device *dev;
> > > > > +	struct regmap *regmap;
> > > > > +};
> > > > > +
> > > > > +#endif

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
