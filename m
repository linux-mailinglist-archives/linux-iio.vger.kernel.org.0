Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE8C25C383
	for <lists+linux-iio@lfdr.de>; Thu,  3 Sep 2020 16:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbgICOwk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Sep 2020 10:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729165AbgICOMm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Sep 2020 10:12:42 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A81C0610E5;
        Thu,  3 Sep 2020 06:57:05 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id o2so1338190qvk.6;
        Thu, 03 Sep 2020 06:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lx7VsLoD8VC63Gr8ZZSKJBlFfCXU3C8e2HzYdq7Pt7A=;
        b=Qdr1dvq7HlK50SUTVEW4IeGNjBI0jJHlGaEv3Oy1gC7eoZBdvBHSz6nq+gOVS5P2dd
         qry3D8+mN5r+UOenzMKY4A4A+ft4IY71PFUizEBGXB4SPYRb6WzLLY5ZWUorQuWnPusY
         Hg+ewfvZpfD1PjvFVSfxbdyMbQZiCqjRw0yXWkdJkC3/MKxpXIZvVavXzLvvJ0IpItmf
         GqtBhGruKreK3wKBY25sRDhDzLZ6qezR52AZ+8rAY1AsJFCrmc9Kp+aGH3VjmSxCSNKg
         Rqvmd365Jb6usnU0jpZedzrMubIPR81jTT+Rq/wXDd+f1es41CEsuSpiegWVFStpO59t
         emJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lx7VsLoD8VC63Gr8ZZSKJBlFfCXU3C8e2HzYdq7Pt7A=;
        b=rcONyDA2IRG5BfmsDFdgm2snzXwP7kZQ178dTXNVxGG0VtyMCLIMVfw0jumND0vUVW
         yQbVTVGZXiJg5yRr8W8BHs8nt04jatZzMLxO67DeUfC9h9e2yKvJK2xvbjTAmxsuEJDW
         2Bqb8hSbpcqP5FEx9ycKUEL4anNz/M4ipFSHvdT8Z5EfuoN+g4pDmI6YJ77kse0EdFxh
         CFOGiLsZ9XxYs3Z1QAet015/S1pVnSu01185dFzGJwW9OgBk0oLodhgdjSkVL65pt1AM
         Rkmkt8StzaH8jBDDn7/eJB3s2PWd+sCXIEWEhn4zgyBjpQBRZPBvgGbAk7hVUDAompXI
         0AwA==
X-Gm-Message-State: AOAM531k8/Ok1L+an+oh40cgebLuikO/afWF0wxP5zzNhM609q//QSq5
        5oIqBNgYZ7eLwJsgNAoXeZQV8kYvXUevEJMglEm6PSKo
X-Google-Smtp-Source: ABdhPJxfq4ecie6/ajqMa8tNecTHNjT1t6BdLTsjZAmur5vj3MHpkwsWLR404smqL5YCugvUq96sorgqVphGPVvDQj4=
X-Received: by 2002:a05:6214:289:: with SMTP id l9mr3070302qvv.137.1599141424567;
 Thu, 03 Sep 2020 06:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200903130950.6274-1-nish.malpani25@gmail.com>
 <20200903130950.6274-4-nish.malpani25@gmail.com> <CAHp75VfReT-EjCV=cW8mV1MmoMPPdY9q1scoPwbD_DEHpQHd3g@mail.gmail.com>
In-Reply-To: <CAHp75VfReT-EjCV=cW8mV1MmoMPPdY9q1scoPwbD_DEHpQHd3g@mail.gmail.com>
From:   Nishant Malpani <nish.malpani25@gmail.com>
Date:   Thu, 3 Sep 2020 19:26:53 +0530
Message-ID: <CAEtfd9ZPkyk9_GV3h-CXFT_j=PYU66SHoYaaE7tytQxb+Q5rVA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] iio: gyro: adxrs290: Add debugfs register access support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        Darius <darius.berghe@analog.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

On Thu, Sep 3, 2020 at 6:55 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Sep 3, 2020 at 4:10 PM Nishant Malpani <nish.malpani25@gmail.com> wrote:
> >
> > Extend support to read/write byte data from/to the device using
> > debugfs iio interface.
>
> ...
>
> > +static int adxrs290_reg_access(struct iio_dev *indio_dev, unsigned int reg,
> > +                              unsigned int writeval, unsigned int *readval)
> > +{
> > +       struct adxrs290_state *st = iio_priv(indio_dev);
> > +       int ret;
> > +
> > +       if (!readval)
> > +               return adxrs290_spi_write_reg(st->spi, reg, writeval);
> > +
> > +       ret = spi_w8r8(st->spi, ADXRS290_READ_REG(reg));
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       *readval = ret;
> > +
> > +       return 0;
> > +}
>
> Hmm... I would suggest to have it like
>
> adxrs290_reg_access_rw()
> {
>  ...
>  return 0;
> }
>
> adxrs290_reg_access()
> {
>  if (readval)
>   return adxrs290_reg_access_rw();
>  else // it's redundant, but someone can use for better formatting
>   return adxrs290_spi_write_reg();
> }

Umm, I'm sorry, I don't see why'd it be favourable for us to do it
this way. Also, I *think* Jonathan is fine with how it's being done
now.

With regards,
Nishant Malpani

>
> --
> With Best Regards,
> Andy Shevchenko
