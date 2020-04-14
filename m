Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4135B1A76EC
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 11:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437361AbgDNJFY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 05:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437356AbgDNJFW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Apr 2020 05:05:22 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7049CC0A3BD0;
        Tue, 14 Apr 2020 02:05:22 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id np9so5006901pjb.4;
        Tue, 14 Apr 2020 02:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F107NiRVAgQ23qg6alA+b2hmVPaDBWwXKGbC/6Kd1Ds=;
        b=iPkJTp44SIdd8vyikAwhCDs+sHWOHLZ78+E8SBIxuZq285eqxNF9d2SS2o8+mIJG9+
         bj+Ono74KZ67j91z2wgqvEPw6rRN8yvfKpvOHFvP1j1Fa4X93fCqFI+4g8q5k3BUnr76
         Xh2PlVy406/b6FfP+bM49JHBBUPVp+sSQ4AGj25e2KaTwAjbrYWigzPSCYuN904rzINZ
         b5ON0ysRUVmysJ5LoohGlP/9/kOs7Pjep80Uqc0M1wHHLZFIAXl7ZgTTFYDcQGs0gRhk
         +oncynKLpp+dW+7w349p+icF5PZGiOOc2ZSEOzhES4+/RifvTaFOFW9nehAiNcgLNLIq
         yMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F107NiRVAgQ23qg6alA+b2hmVPaDBWwXKGbC/6Kd1Ds=;
        b=mGpSDd/8n3MHJh596hxfgIXMSb8xEwoKYGIU5/j0l3bHqmSQD+ykxbQR2PfJVUzRqL
         4XrqLpg3Nrokacp9ngGw6JXuXtHvZHZB1HWPeBR+DzloFLXGm2b3zERSMRP05aM5FSf9
         Bj8fgZzbMNtO1Zk2UzqpzMH7RykD4Mv/wfIEjf90WqXGa241BqxvxsuY7iTkhUBD9FlL
         Hl2FBmEbp2Z1ySdf2+PT0QDSijoYZ3f34zBsov7XZZTUKjtlsoZbW5YhukGXbrvz2O/6
         lM4oRfIUCjHMJyaoOtqnCljvPaF2LTLNqHBxa8hxYgtc0JeOCQ1UtVzEq5LBVdZpyp97
         x55w==
X-Gm-Message-State: AGi0PubwUnWVtyHt+bS/fCk7kZypufxhAD+TYzpem6vKAnszQD0U1eIm
        m0gY+5q3Kg9n++6cOhicspBsBlNk7vcaQBB0miI=
X-Google-Smtp-Source: APiQypItJnd7xLSTDEuRf+mho4kdhPUComrhtelzkg62uCTrDAdfkoWo8cE1BKvSyx/C/m0v8G/RQo6NBn3pXMMcGmc=
X-Received: by 2002:a17:902:aa09:: with SMTP id be9mr14890031plb.18.1586855121908;
 Tue, 14 Apr 2020 02:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200413173656.28522-1-sravanhome@gmail.com> <20200413173656.28522-5-sravanhome@gmail.com>
 <CAHp75VeYFY1CW4AH+D4HAgzppMZ5J8dL8kKPYmcwsXNVGNSYjQ@mail.gmail.com>
 <6cfab0a6-c3eb-bd9b-6572-b49e3205524f@gmail.com> <20200413204847.ni7dsrn5tslrorqn@earth.universe>
In-Reply-To: <20200413204847.ni7dsrn5tslrorqn@earth.universe>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Apr 2020 12:05:15 +0300
Message-ID: <CAHp75VdRXWVtveRnvR-k8wqH5R_P7owfQvFf7YT3qM_oVEY3vg@mail.gmail.com>
Subject: Re: [PATCH v8 4/6] power: supply: Add support for mps mp2629 battery charger
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     saravanan sekar <sravanhome@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 13, 2020 at 11:48 PM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
> On Mon, Apr 13, 2020 at 10:28:19PM +0200, saravanan sekar wrote:
> > On 13/04/20 10:10 pm, Andy Shevchenko wrote:
> > > On Mon, Apr 13, 2020 at 8:37 PM Saravanan Sekar <sravanhome@gmail.com> wrote:

...

> > > > +       irq = platform_get_irq(to_platform_device(pdev->dev.parent), 0);
> > > Why not to use temporary variable dev?
> > >
> > > This should be platform_get_irq_optional().
> >
> > Platform_get_irq in turn calls platform_get_irq_optional. It was suggested
> > by Lee and is it mandatory to change it?
>
> platform_get_irq is fine.

I don't think so. It will spill an error in case there is no IRQ or
error happened.

So, either is should be _optional, or below conditional simply wrong, should be
  if (irq < 0)
    return irq;

> > > > +       if (irq) {
>
> But this must be
>
> if (irq > 0)
>
> or you will also try to continue with error codes.
>
> > > > +               ret = devm_request_irq(dev, irq, mp2629_irq_handler,
> > > > +                                IRQF_TRIGGER_RISING, "mp2629-charger",
> > > > +                                charger);
> > > > +               if (ret) {
> > > > +                       dev_err(dev, "failed to request gpio IRQ\n");
> > > > +                       goto iio_fail;
> > > > +               }
> > > > +       }
> > > > +}

-- 
With Best Regards,
Andy Shevchenko
