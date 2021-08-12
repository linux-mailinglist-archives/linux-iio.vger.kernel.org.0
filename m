Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814593EA8CE
	for <lists+linux-iio@lfdr.de>; Thu, 12 Aug 2021 18:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbhHLQyO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Aug 2021 12:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbhHLQyH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Aug 2021 12:54:07 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FADC061756;
        Thu, 12 Aug 2021 09:53:42 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so16288422pjs.0;
        Thu, 12 Aug 2021 09:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6VeB2NYn9eofqF8nKLlfBx5n8WuLurLWCP0jk+U/zuA=;
        b=ghY/Y1TQp4mbwP3V8+T9dU92Ev6OQB08h8E15tZpjc0UaFPXq68bNfe6aco9QHEyPw
         Y2imqp0byCXMCOuDMEH2vZQAGWNXKZ10V2R6SohOnx5zZEfoH4PAuu7KtapgMMIcIBYr
         i7AkSDIWe6l5B5nW3ZJPQEqz9Pe5p+9GRcf7MdHF0TqUpFh7VU7Ysj7NJJ3krV5S6THq
         tVACBPm/xjbTy9ftkShGWGBras8mNu0LWxfDa3TEfyAQHqc3qoCGiwbKqPMzJolW9rwv
         QG6kT3o3LH32Hh1krZWX9Zv7hUNuBn7Zc30xnxrKK7fezWBwpu4BQp7tSXgdh6IQvTve
         f6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6VeB2NYn9eofqF8nKLlfBx5n8WuLurLWCP0jk+U/zuA=;
        b=tdK22KdPvvtWZsHtobJhQL7XWx1WqJZxjfcMPcm3EQ8bjZcPcnVE0Kgh7k5Nb8Yooa
         vx/ah/4qBAYvtyBqLgJibon/GE8P2jUaLro2bfqd3lindQl5YbXv0q9iCBuxNbwEJJXk
         ZnXhkvEyn4Hy8HrClZpYNK4K0O4se9B0otM0tbv21gZHISe4Hln7qFN18lBpqXFGMHzg
         yLWWN1qDLgqWid8uPNvLzjDUnbie3ZAnazvEYBcRizfta/p39BRCyEz98CnpATsdAwH0
         X+ubJHgAWe1hL2TcH8Z/ebJvAm3YZ23aMMToFG59uufPhKXtSrjf9Nv4CjDceJs2DtSO
         QZLw==
X-Gm-Message-State: AOAM5315sKz44YiXfRTB8NyOKPV6ITXvcU5zd+9wjcaVC22CJ0AxkVUU
        A2U3a7jXRyQKtRQH05b55GI=
X-Google-Smtp-Source: ABdhPJyTZxtpKatLvcazxWC9/KNpb82sDg0Pwo/xBqwHOhpj2iitbsBTpNb5bEg0e4sOgzGmkaIQzg==
X-Received: by 2002:a17:90b:1b0c:: with SMTP id nu12mr5199932pjb.163.1628787221448;
        Thu, 12 Aug 2021 09:53:41 -0700 (PDT)
Received: from mugil-Nitro-AN515-52 ([2409:4072:60f:dfd:8405:dea5:a2d4:3c2c])
        by smtp.gmail.com with ESMTPSA id u13sm4015501pfh.123.2021.08.12.09.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 09:53:40 -0700 (PDT)
Date:   Thu, 12 Aug 2021 22:23:27 +0530
From:   Mugilraj Dhavachelvan <dmugil2000@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        Darius <Darius.Berghe@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Slawomir Stepien <sst@poczta.fm>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: potentiometer: Add driver support for AD5110
Message-ID: <20210812165327.GA4542@mugil-Nitro-AN515-52>
References: <20210809075745.160042-1-dmugil2000@gmail.com>
 <20210809075745.160042-3-dmugil2000@gmail.com>
 <CAHp75Ve=D1d5wFZgNseP=wGpteEkZHnmAi7j9ykKC+u_NrR5xw@mail.gmail.com>
 <013bcb79-c496-44d8-2e93-57eb57834ee0@metafoo.de>
 <CAHp75VcvA=dDOJXSFzgz69JVgbez4Lz27EGOEF7JWUehyrwQrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcvA=dDOJXSFzgz69JVgbez4Lz27EGOEF7JWUehyrwQrA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 11, 2021 at 07:06:43PM +0300, Andy Shevchenko wrote:
> On Wed, Aug 11, 2021 at 11:15 AM Lars-Peter Clausen <lars@metafoo.de> wrote:
> > On 8/10/21 2:49 PM, Andy Shevchenko wrote:
> > >
> > >> +       data->tol = data->cfg->kohms * (val & GENMASK(6, 0)) * 10 / 8;
> > >> +       if (!(val & BIT(7)))
> > >> +               data->tol *= -1;
> > > Shouldn't you simple use corresponding sign_extend*()?
> > The data is encoded a sign-magnitude. sign_extend() works for two's
> > complement numbers.
> 
> Good catch!
> I'm wondering if it's a good idea to have a sign_magnitude_to_int()
> helper or so?
>
So, What should I do now?

> -- 
> With Best Regards,
> Andy Shevchenko
