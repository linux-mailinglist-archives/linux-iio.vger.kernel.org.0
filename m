Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA0B3FAC2C
	for <lists+linux-iio@lfdr.de>; Sun, 29 Aug 2021 16:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbhH2OUv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Aug 2021 10:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhH2OUu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Aug 2021 10:20:50 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99EDC061575;
        Sun, 29 Aug 2021 07:19:58 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j1so7744844pjv.3;
        Sun, 29 Aug 2021 07:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UlLyk71kSEDz++nRlIIiul3TZnWo800S1HISqkvgvDM=;
        b=iIn9GNYU6QYHkzSHdRQLwNHxRtPgAEsMXRsNcHNFSstv/O+vj7ir5rDLjh1mvuxGPe
         HSznWS48JV53tjrMI/F7JQf9bsFOcsF8x6kc6poyulNjXxB3jup2JHLUmwEUcwZvxabf
         OrMIJZxhkhaV8vQpx6DMimtyr+zUiDThAAowKD+eQqmiiwp3kgq5RYYlb8mZ9C7i3uJA
         aiXcNZPUdtqlTsB0MifT0R+b9i1tlrNLPe+WweqQJfCZRDPJyqujbYZmlyJpwAAxIW8D
         zACelAdMZNDPcJbZNrnjmi2mN1sQGq4MSd5jmpNqpQzCmBEpo5fu7vskKQPIea4pzM6t
         d3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UlLyk71kSEDz++nRlIIiul3TZnWo800S1HISqkvgvDM=;
        b=W1jrDD8FnR+EbL7/raTZfm6J6uV2/XXgIa9nKtNagJWHPRnuLfEw7tpQ9O7yuZsdBK
         0GDK5QX2fhbwHjL2Uradjn61NOK2/TS/6FJexhGOKRZbcfAehtsHjUg4Va/hqhcZ9fB+
         vouE5gir91Nn7FB+t7F4CVzuP3sdBQkrmOQLkMwYa+Diq4E+NdxtCH9OI6Urp0K7otkC
         hspeG1GUKdR9F9qt6z27lQs2B0XzG30f1d0GBMC472PZJ0beYw1jbg+xKSjWECwhiURY
         4fcQpoSPBItglJmDgWNob97kXHj8ulXlu5i8ROYp37Xa0WqsXym9yeaGsPe5x/L9VFT0
         ehlQ==
X-Gm-Message-State: AOAM532W3JkdaTU/Iv09cTdv5vVgpnvkCdVzSLhSclfDFAHXLMgYFbUK
        jmIg7k7v7lcun7SoSef1V4pObENyICClr5yCAU0=
X-Google-Smtp-Source: ABdhPJykVytKwexdidofE4PS1ZEmdQZnqNiPKlk7QyjoN4C0oteQUDTmbhOrHWNmKrIICJ1VwmffoB2Wy97CmxLJtAU=
X-Received: by 2002:a17:903:120e:b0:138:d732:3b01 with SMTP id
 l14-20020a170903120e00b00138d7323b01mr1661797plh.21.1630246798164; Sun, 29
 Aug 2021 07:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628713039.git.lucas.p.stankus@gmail.com>
 <69f3b83eaf31d657cdb522839dc0102384d50681.1628713039.git.lucas.p.stankus@gmail.com>
 <CAHp75VeTWmegWR6viGOV=QYxTFnPcntG6pdKn=rVyvniHGTAog@mail.gmail.com> <CACKVXZDpBXK-RRQy4OJ=i+mCFxP=LVBZe0GjAkg_GXZ8hCiSng@mail.gmail.com>
In-Reply-To: <CACKVXZDpBXK-RRQy4OJ=i+mCFxP=LVBZe0GjAkg_GXZ8hCiSng@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 29 Aug 2021 17:19:19 +0300
Message-ID: <CAHp75Vcmg91+cC6st41yTezhV_xQgDkSCprGirEARhETJT=LOQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: accel: Add driver support for ADXL313
To:     Lucas Stankus <lucas.p.stankus@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        Darius <Darius.Berghe@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 18, 2021 at 11:02 PM Lucas Stankus
<lucas.p.stankus@gmail.com> wrote:
> On Thu, Aug 12, 2021 at 8:06 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Thu, Aug 12, 2021 at 12:19 AM Lucas Stankus
> > <lucas.p.stankus@gmail.com> wrote:

...

> > > +       return regmap_update_bits(data->regmap, ADXL313_REG_BW_RATE,
> > > +                                 ADXL313_RATE_MSK,
> >
> > > +                                 FIELD_PREP(ADXL313_RATE_MSK,
> > > +                                            ADXL313_RATE_BASE + i));
> >
> > One line?
> >
>
> Line to long, 87 chars =/

I think it's fine in this case. It will keep the entire FIELD_PREP()
on one line.

-- 
With Best Regards,
Andy Shevchenko
