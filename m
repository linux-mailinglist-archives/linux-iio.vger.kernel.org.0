Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D929A3E8B95
	for <lists+linux-iio@lfdr.de>; Wed, 11 Aug 2021 10:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbhHKIMQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Aug 2021 04:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbhHKIMP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Aug 2021 04:12:15 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6568BC06179B;
        Wed, 11 Aug 2021 01:11:50 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id oa17so2181307pjb.1;
        Wed, 11 Aug 2021 01:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=49LZp3X8rq2JjBuSPYq9SGlPT2VFV8uGCsrCxh95J6s=;
        b=hxHlZrytexT1dlasaEVtzDPIhUb/CuQ27umx88g0hMVx7sWD89Ynww35yzOyrmyAeB
         aMnhTFZ0EJ1ZPCGYUqet2mCpwAHpS5tAULse2NMPsgtFLIGwtK4MdMSrZYGUhjMD8DcD
         76VyVIkJqF3LbRkNwIKv98EWmXr06nGmYyoxPGEnF1YPmyvoh/Olncp1oYZNMYuKER/v
         jk/TlroXaGrIipp7/NMXvZGZ+WSiLWxiZB4+BE2RqBqtU3cCuprPXOO3NY9eS6+W9n2l
         UkAlWC8r8KAp6JsFPctAV96zItaO89xW089F8jsOk93ii77eFSykGlpCI7xacqcadh3x
         WntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=49LZp3X8rq2JjBuSPYq9SGlPT2VFV8uGCsrCxh95J6s=;
        b=SmK1z938YjnEvYDDD/bTCYehT/NKbs6f4/bVKb2FbT+UwC9V8b+7RwScihqxR8n/45
         v3swKpjRLTy1v5RZcmqAjnegxrd5tBdCpLUDDejU8oTHDoucK4Hl/z7GGzpHVnfNP6W3
         ipURlqUtrUdNw8Pm+cQapMGpZ8wfPMwTZ2cD6KR49DVE4w4jO1JxwurvXmjG1WSWhPo2
         gbB2RZovs0dMJDMhu9knuhjoOFQMqRYAa+imhiIlIGk6KBCHlchIncEen4QGbnmKivdH
         szfagz2I+EA1Zl+YRxW7/aDxe1ZeviSFUtQfqKxi+xxGCYdSKWGmnagBu20NGizv6jgJ
         fvVw==
X-Gm-Message-State: AOAM531e+9MeouMijtKOdp4Uz8VlJhLiL+WqbhuL4Je3ybNBitKTuB3n
        IRvj2EkexPwbUK0a4fSqr5c=
X-Google-Smtp-Source: ABdhPJzGyB3LJEAM4djQHII9goeLaI5mNFi+aEfmFFSpXNV+7yd8Z8ujKBJkGapY9oJA1NDEayAmLA==
X-Received: by 2002:a17:902:6507:b029:12d:2292:f750 with SMTP id b7-20020a1709026507b029012d2292f750mr13649601plk.54.1628669509742;
        Wed, 11 Aug 2021 01:11:49 -0700 (PDT)
Received: from mugil-Nitro-AN515-52 ([2409:4072:6d8a:236c:368e:64f7:f411:e650])
        by smtp.gmail.com with ESMTPSA id v7sm26074433pfu.39.2021.08.11.01.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 01:11:49 -0700 (PDT)
Date:   Wed, 11 Aug 2021 13:41:38 +0530
From:   Mugilraj Dhavachelvan <dmugil2000@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        Darius <Darius.Berghe@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Slawomir Stepien <sst@poczta.fm>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: potentiometer: Add driver support for AD5110
Message-ID: <20210811081138.GA4951@mugil-Nitro-AN515-52>
References: <20210809075745.160042-1-dmugil2000@gmail.com>
 <20210809075745.160042-3-dmugil2000@gmail.com>
 <CAHp75Ve=D1d5wFZgNseP=wGpteEkZHnmAi7j9ykKC+u_NrR5xw@mail.gmail.com>
 <20210811054558.GA3826@mugil-Nitro-AN515-52>
 <CAHp75VfaeEzodmPPmxxDoScPQzE2+5D_czEHfF0pq6oOVh-6nw@mail.gmail.com>
 <CAHp75VdqM+XVCkkE+GXCytBUqgT5QLNq5=68KOzfs92t-Vb7ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdqM+XVCkkE+GXCytBUqgT5QLNq5=68KOzfs92t-Vb7ww@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 11, 2021 at 10:05:41AM +0300, Andy Shevchenko wrote:
> On Wed, Aug 11, 2021 at 10:03 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Wed, Aug 11, 2021 at 8:46 AM Mugilraj Dhavachelvan
> > <dmugil2000@gmail.com> wrote:
> > > On Tue, Aug 10, 2021 at 03:49:52PM +0300, Andy Shevchenko wrote:
> > > > On Mon, Aug 9, 2021 at 10:59 AM Mugilraj Dhavachelvan
> > > > <dmugil2000@gmail.com> wrote:
> >
> > ...
> >
> > > > > +       data->tol = data->cfg->kohms * (val & GENMASK(6, 0)) * 10 / 8;
> > > > > +       if (!(val & BIT(7)))
> > > > > +               data->tol *= -1;
> > > >
> > > > Shouldn't you simple use corresponding sign_extend*()?
> > > >
> > > I'm not able see any sign_extend for 16 bit. Is there any other way?
> >
> > So, then add it in bitops.h the same way it's done for s32 and s64.
> 
> In case you are afraid that this will delay patches and you are in a
> hurry, you may define it locally (but in the very same way, so
> somebody can make it generic). Nevertheless, I think this one can be
> added directly to the generic header, it will definitely have more
> than one user.
> 
It seems like we can use sign_extend32() for 16 and 8 bit as well.
> > ...
> >
> > > > > +       if (!data->cfg)
> > > > > +               data->cfg = &ad5110_cfg[i2c_match_id(ad5110_id, client)->driver_data];
> > > >
> > > > Not sure this is not a dead code since you are using ->probe_new().
> > > >
> > > Even I'm suspecting that and also removing id_table. But I'm not sure of
> > > it so just left as it is.
> >
> > I²C ID table is good to have without direct use, but ->probe_new() is
> > called if and only if there is a compatible string or ACPI ID match.
> > In such case data->cfg may be NULL if and only if the corresponding
> > table missed it, but this will be a bug anyway, so the above code will
> > rather hide the bug. Hence, please remove it.
> 
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
