Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D1C400F53
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 13:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237589AbhIELd7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Sep 2021 07:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhIELd6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Sep 2021 07:33:58 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D416CC061575
        for <linux-iio@vger.kernel.org>; Sun,  5 Sep 2021 04:32:55 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id c17so3795170pgc.0
        for <linux-iio@vger.kernel.org>; Sun, 05 Sep 2021 04:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RbYXyP4onx8zCKpFSeYGMSOw6u39A1Mo7kgHJ7GwBlU=;
        b=Y3mEmHg+6rBOVxQqYIDNwOuBWCWlH4BJ4p9+iFfR0PVlbuuKkkvBT+bnZUMXICEbYA
         UCnYSuP5hks/OA7IGOuceZcmWAgWklNMdMqI+hjtiR/+8IDPHuwSMXGdXhGuaZVkA8Ls
         YHpWfiNgP3nv6342xjGJERneU7paSR/ShGi/GMue1hHNtChIB5ELBdewvQ59EFpZnRDU
         OCV0L2mLLdQkXNwAMV4WDtqBVYYwVE9rXb3aomx5ZYmw3rFd8o7etuVOekx21pTTNQvI
         D581bFsyYX0alLBX+vy4MLp6KYNj0rgV3RHMoO5bVaQSVnVUF46QbKJYP6wqGnZGf2cf
         Ixsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RbYXyP4onx8zCKpFSeYGMSOw6u39A1Mo7kgHJ7GwBlU=;
        b=F2S0ZoNL43eAtdjWl4wtjVwx3Oy2BlwFsmBWL5u3JK1uswcvn3X9iklwfFq1Sdrxk0
         6Lt9Tvc/WFkwcp4zKIZYKqmK8pe50+BUMtamZ621CHOZT4Rr2FyoAk97qTRfgtX2YhLF
         sq9LPJ8Dx0M/Rh1Mxs/ooNHstIgm1G4gVkP9wSKolAixNYUEn+Nu9wf3Q8Jks+zzvscs
         4DqOz6xbRgZvitbckuIH+n3HhLILPiUI8MO39TQLaZSK8KRrc3URbChWj+FESBEvbk02
         gwGs9bRybUnr2LB6OOpkAJoLgwkWDhtuOsvCUcLSik073HaX1ZP9TaCdq9uGeE9T3T3W
         CyaQ==
X-Gm-Message-State: AOAM533gmV2sto2J/DoULfRzJ0SGVByPEXMyLMI90X7fjjne6WOj60hr
        0g3qVumtyoqOMQLg3xdemyJ7rlIUdGxam8WgMuoNTfYr6bmm/Q==
X-Google-Smtp-Source: ABdhPJyL18V003kFWTPyS+72gmwwLhx5um/1kMGRseklD9nCqCJrxLSwc08iOzE5PEYeXGiGmiOpvJ+vNjmUVPoiOxA=
X-Received: by 2002:a63:ed17:: with SMTP id d23mr7299872pgi.29.1630841575309;
 Sun, 05 Sep 2021 04:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210830145934.11024-1-florian.boor@kernelconcepts.de>
In-Reply-To: <20210830145934.11024-1-florian.boor@kernelconcepts.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 5 Sep 2021 14:32:18 +0300
Message-ID: <CAHp75VdHsez3iFiNOeKV0g6eNYWaP-P4CMDnAz6TB72gCaUTxw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad799x: Implement selecting external reference
 voltage input on AD7991, AD7995 and AD7999.
To:     Florian Boor <florian.boor@kernelconcepts.de>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 30, 2021 at 6:38 PM Florian Boor
<florian.boor@kernelconcepts.de> wrote:
>
> Make use of the AD7991_REF_SEL bit and support using the external
> reference voltage by setting the 'vref-external' property in devicetree.

...

> +               of_property_read_u32(client->dev.of_node, "vref-external",
> +                       &vref_external);

Please, use device property API instead in the code you are submitting to IIO.

-- 
With Best Regards,
Andy Shevchenko
