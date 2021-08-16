Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2603ECFF3
	for <lists+linux-iio@lfdr.de>; Mon, 16 Aug 2021 10:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbhHPIIL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Aug 2021 04:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbhHPIIK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Aug 2021 04:08:10 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E41C061764;
        Mon, 16 Aug 2021 01:07:39 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id qe12-20020a17090b4f8c00b00179321cbae7so15540999pjb.2;
        Mon, 16 Aug 2021 01:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O8F6M7XCciMyzXQ0IpVQmcllwu2H30RY2XKUPdTtsxM=;
        b=KKxzbpgHYvBYZVkwbHROQdBJCls/Z6TZUyEUF5mjsRr6aIRAhJgXzAeE+RixnjYC4Z
         apCM5V48jEdJ0TUhESlbgWgRSbhVXdgRpcMOneA/tPUVG3uh/ytrrPk849hcy7k9P5aO
         9uWQZppnxuPe1ThEXBY12S9HIMUthWoha1JSsd4/8nbE0lWGjDnHbgUEdNsmFHj4hBKA
         rZFm3nlpzxzlBC3mOpun0RTt8LshpRa9W3ZHPImAZmjtJBCPxt78sEGGIjzg/QjhPrxO
         FgaqKGtOlLYc+U4qF0C0bokQrRWZMEzCirRsQ/MhW5F4ltHTniyqXBDeWSq/zT+hLUdL
         d7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O8F6M7XCciMyzXQ0IpVQmcllwu2H30RY2XKUPdTtsxM=;
        b=HJM5OzcQhhB706AyyAEyhmVWc5YLiAYACxnhXOJRqnld6jYS87vDsutQeLBJpwMWxb
         FQmA92j5VNoDNPhrGQAQ9CbJ3u3WxnMJlPaZOBXstSPb9m5B/lkXn+jbjGnF6i8cx+78
         EnKpIaQrGkRYlmPZyuu119+Ihs0LZ1ucV8W2t0/qbkXeUJLVP8lqKxcwV9hIwXSI6wjQ
         Zt8rOHv39oOPzDwObQsJYvgVZjejn+zb9ieMdeZ/l5Bz9iITpjYBkxoDC3sxrc3yEX3D
         1NO2igm0xMK59cim6Nvj6OWzWbc+wTLDkuzWPO3PzlRXCQ2iUdbanHexhmuwNIilBhGm
         5k0w==
X-Gm-Message-State: AOAM531ygssqjm0h4vOrRUTooDUxIUdBflJU7G0ZAPaGst/3IlZNFj1a
        Lgsw4czXrYrueJcEfZPAU0P8aUUZBI7M/LU/Hk8=
X-Google-Smtp-Source: ABdhPJwTmpB6MI8lz7oeijfNhU7K/Gzky9ezn1Pnsajl2Jks/HAKIPsJFFmjI78DUMzI13sVS8ysjC0ck3LmTsbCRw4=
X-Received: by 2002:aa7:800b:0:b029:330:455f:57a8 with SMTP id
 j11-20020aa7800b0000b0290330455f57a8mr15000536pfi.7.1629101259273; Mon, 16
 Aug 2021 01:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210808015659.2955443-1-liambeguin@gmail.com>
 <20210808015659.2955443-4-liambeguin@gmail.com> <20210808173630.5c384a4b@jic23-huawei>
 <CDEHT583QT0A.2QAXX9AC2FMLO@shaak> <20210809204253.357f97b2@jic23-huawei> <CDIOK6DFUNE0.2P8L2AL8MDAK1@shaak>
In-Reply-To: <CDIOK6DFUNE0.2P8L2AL8MDAK1@shaak>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 16 Aug 2021 11:07:00 +0300
Message-ID: <CAHp75VeNJ1fuo5dVfhk+w9H+0angfJEDPUVHUKk=Kgc=zNP8Fw@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] iio: adc: ad7949: add support for internal vref
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <Nuno.Sa@analog.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Aug 13, 2021 at 11:51 PM Liam Beguin <liambeguin@gmail.com> wrote:
> On Mon Aug 9, 2021 at 3:42 PM EDT, Jonathan Cameron wrote:

...

> > > > > +       /* Read channel specific information form the devicetree */

from

> > > > > +       device_for_each_child_node(dev, child) {
> > > > > +               ret = fwnode_property_read_u32(child, "reg", &i);
> > > > > +               if (ret) {
> > > > > +                       dev_err(dev, "missing reg property in %pfw\n", child);
> > > > > +                       fwnode_handle_put(child);
> > > > > +                       return ret;
> > > > > +               }
> > > > > +
> > > > > +               ad7949_chan = &ad7949_adc->channels[i];
> > > > > +
> > > > > +               ret = fwnode_property_read_u32(child, "adi,internal-ref-microvolt", &tmp);
> > > > > +               if (ret < 0 && ret != -EINVAL) {
> > > > > +                       dev_err(dev, "invalid internal reference in %pfw\n", child);
> > > > > +                       fwnode_handle_put(child);
> > > > > +                       return ret;
> > > > > +               }

> After getting access to another setup to run more tests, I noticed
> that setting the reference per channel isn't really feasible.

Is it a hardware limitation?

-- 
With Best Regards,
Andy Shevchenko
