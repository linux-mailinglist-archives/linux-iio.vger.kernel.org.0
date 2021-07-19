Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359ED3CD58F
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 15:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236973AbhGSMdX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 08:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236855AbhGSMdX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jul 2021 08:33:23 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A86C061574;
        Mon, 19 Jul 2021 05:34:08 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id q10so16414488pfj.12;
        Mon, 19 Jul 2021 06:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=HM1yQ9OZiA5BvPd15lf0pR2zhQOnuRWUNkrRFdXMxsM=;
        b=fXJCTJJxQfPcxBpLQm+LniFYdC38w9KkzO9FucZHmRQstximGwq5wuEg3IBZGdcJMF
         cVAlsT7qT4GQHGu3yhSeqnWGms5izzcRPn/vqyuv7Mem6rPkemTr70KPe2lFAnIOpyyy
         +pyWHILG4SxC84mYYMDupxutl/IJH35Jbftcqv+3ZGF7qq/z/yu7adTLFkY7Ns8m+Kcd
         8iBmZC3i84ritXh28wwitGfMX+8CTUJTJd1aarCUDuzn+amxWH8eVIw51zqIvhIm0mB7
         HQ0YGzgIFwqwhwJDAPYuI4sE7f34E5gHjHBaxApGbj1fAjq/WWmTgimYeUubS3K3CTdr
         LerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=HM1yQ9OZiA5BvPd15lf0pR2zhQOnuRWUNkrRFdXMxsM=;
        b=Q8GMwt463PBATBEGR7y3Kaewz6kgCyjtqTQvxztCkgQ++d5zAcdduWPfSnCtlZKBWE
         kN/ITjFY2/0ZpxtM93+mQjJ/83jKYWC7mQDrCH8gITpasK2wMli2UFAP4qBqE3wc7M+S
         NIdw3ZkYMREWUjwW7nxlQBXox19ANzxSY7U2oK9J2lZdO2YtJ5Z7bm2f2v7UmBlN0MuF
         LTOpmRiPwm4xnesFJMuTSN59yu7ezDFSncAgq2Ye2e/xNYuDTiQzj0qvn3XxcE9G+QE3
         Y64s8AHcY1QIaBV3CpwSgQh2mIwe742KNrSzxn8DqlWuyhatYTv6jppU7Vt0FlhiTs3b
         JIuQ==
X-Gm-Message-State: AOAM532/SQQSCMxprGFG0w0JBPjagJbk/e9pT0NrEC6kB7VtfPp1jWNr
        TkNWdwafMs4+46yVn2yXSpkIot1L/dto5gz1zaQwRKTF89S5mA==
X-Google-Smtp-Source: ABdhPJzN9FN7DueRz/7CHqmuooWBW9AAfmu/6lbvthCmrFO5HG8RT1G93HbXlfWmb4QCkOJ1OuJXjVbrqrFaPoGirPQ=
X-Received: by 2002:a63:ae48:: with SMTP id e8mr4325241pgp.0.1626700441918;
 Mon, 19 Jul 2021 06:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20210715141742.15072-3-andrea.merello@gmail.com> <CAHp75Vf_Og2wjRy2j0gC37DgR0x9B_F5iSUj8VOtWkhWjgiOag@mail.gmail.com>
 <CAN8YU5MFMqh3wZo-yOOE8och3x089kYWjtrr83Jt8wCQTKFE8Q@mail.gmail.com> <YPVmgpmWkagk+ngf@smile.fi.intel.com>
In-Reply-To: <YPVmgpmWkagk+ngf@smile.fi.intel.com>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Mon, 19 Jul 2021 15:13:49 +0200
Message-ID: <CAN8YU5Om5C0SrKpJ3h+OKF5FeJs_pW3kFDOVGsjyx1+zFtJjrw@mail.gmail.com>
Subject: Re: [PATCH 2/4] iio: imu: add Bosch Sensortec BNO055 core driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Andrea Merello <andrea.merello@iit.it>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Il giorno lun 19 lug 2021 alle ore 13:48 Andy Shevchenko
<andy.shevchenko@gmail.com> ha scritto:
>
> On Mon, Jul 19, 2021 at 11:02:07AM +0200, Andrea Merello wrote:
> > Il giorno gio 15 lug 2021 alle ore 18:50 Andy Shevchenko
> > <andy.shevchenko@gmail.com> ha scritto:
> >
> > >
> > > > +/* must be called in configuration mode */
> > > > +int bno055_calibration_load(struct bno055_priv *priv, const struct firmware *fw)
> > > > +{
> > > > +       int i;
> > > > +       unsigned int tmp;
> > > > +       u8 cal[BNO055_CALDATA_LEN];
> > > > +       int read, tot_read = 0;
> > > > +       int ret = 0;
> > > > +       char *buf = kmalloc(fw->size + 1, GFP_KERNEL);
> > > > +
> > > > +       if (!buf)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       memcpy(buf, fw->data, fw->size);
> > >
> > > kmemdup() ?
> > >
> >
> > As a second thought: no, the whole point of reallocating and copying
> > here, is that we want to allocate an extra byte; kmemdup() will
> > allocate and copy only the very same amount of memory
>
> kmemdup_nul() then.

That's one seems suitable. Thank you.

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
