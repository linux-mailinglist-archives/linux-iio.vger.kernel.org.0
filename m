Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B0932414F
	for <lists+linux-iio@lfdr.de>; Wed, 24 Feb 2021 17:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbhBXPqi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Feb 2021 10:46:38 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:45206 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232673AbhBXPUn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 24 Feb 2021 10:20:43 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 1A5B6412C6;
        Wed, 24 Feb 2021 15:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-transfer-encoding:mime-version:user-agent:content-type
        :content-type:organization:references:in-reply-to:date:date:from
        :from:subject:subject:message-id:received:received:received; s=
        mta-01; t=1614180000; x=1615994401; bh=UsooEfiw12ky/7CVTzXlfFlCQ
        3hLw6JhXGizQ85nozA=; b=thydKF/eaLgoKENVZVKWUPa2YT6Trh0BClrxgud4R
        +IKvw90cQGIAllxwWCOJ/etJYzO8kCQmNFm5luMrBC3bB7AB8pkjC5q6pm43DHzK
        /md2v8ILq9Ul+Mi7m0yLtSQWWczHWtyA2WFRIqM4ULNhxGAVXBeRuuv3M4vPvINt
        KQ=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zvprq06JOzZ2; Wed, 24 Feb 2021 18:20:00 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 215CE41243;
        Wed, 24 Feb 2021 18:20:00 +0300 (MSK)
Received: from localhost.localdomain (10.199.0.44) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 24
 Feb 2021 18:19:59 +0300
Message-ID: <ac9ae3793329e2f3f267c6106b538c4e080be2af.camel@yadro.com>
Subject: Re: [PATCH 1/2] iio: proximity: vcnl3020: add proximity rate
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Date:   Wed, 24 Feb 2021 18:27:07 +0300
In-Reply-To: <CAHp75VeFE3BMB+siM4xfnmsgW8=67bgOSmYHseAY++3_ds16XA@mail.gmail.com>
References: <20210216145346.18304-1-i.mikhaylov@yadro.com>
         <20210216145346.18304-2-i.mikhaylov@yadro.com>
         <CAHp75VeFE3BMB+siM4xfnmsgW8=67bgOSmYHseAY++3_ds16XA@mail.gmail.com>
Organization: YADRO
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.199.0.44]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 2021-02-21 at 22:34 +0200, Andy Shevchenko wrote:
> 
> 
> On Tuesday, February 16, 2021, Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
> > Add the proximity rate optional option and handling of it for
> > vishay vcnl3020.
> > 
> > Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
> > ---
> >  drivers/iio/proximity/vcnl3020.c | 123 ++++++++++++++++++++++++++++++-
> >  1 file changed, 120 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/proximity/vcnl3020.c
> > b/drivers/iio/proximity/vcnl3020.c
> > index 37264f801ad0..833c5d5ac0a1 100644
> > --- a/drivers/iio/proximity/vcnl3020.c
> > +++ b/drivers/iio/proximity/vcnl3020.c
> > @@ -40,6 +40,17 @@
> >  #define VCNL_ON_DEMAND_TIMEOUT_US      100000
> >  #define VCNL_POLL_US                   20000
> > 
> > +static const int vcnl3020_prox_sampling_frequency[][2] = {
> > +       {1, 950000},
> 
> Can you confirm that’s the correct value and shan’t be 953125?

Yes, It is described in the documentation for vcnl3020, also vcnl4000.c driver
has same sampling frequency values for vcnl4020.

> > +       {3, 906250},
> > +       {7, 812500},
> > +       {16, 625000},
> > +       {31, 250000},
> > +       {62, 500000},
> > +       {125, 0},
> > +       {250, 0},
> > +};
> > +
> >  /**
> >   * struct vcnl3020_data - vcnl3020 specific data.
> >   * @regmap:    device register map.
> > @@ -75,12 +86,37 @@ static u32 microamp_to_reg(u32 *val)
> >         return *val /= 10000;
> >  };
> > 

