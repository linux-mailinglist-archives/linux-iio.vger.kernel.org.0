Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A063EC3B2
	for <lists+linux-iio@lfdr.de>; Sat, 14 Aug 2021 18:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhHNQBh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 14 Aug 2021 12:01:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:58714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232131AbhHNQBg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Aug 2021 12:01:36 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96FD360295;
        Sat, 14 Aug 2021 16:01:05 +0000 (UTC)
Date:   Sat, 14 Aug 2021 17:04:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: ad5770r: make devicetree property reading
 consistent
Message-ID: <20210814170204.387bf394@jic23-huawei>
In-Reply-To: <PH0PR03MB63665918437E96CAF35B7CD799FA9@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210811074827.21889-1-nuno.sa@analog.com>
        <CAHp75VeLfxyLG-zTdVVnwB+PR2v=LW-PcvM4ZkEoLq+Ht0-iCg@mail.gmail.com>
        <PH0PR03MB6366283246B9D4925BFA444C99F99@PH0PR03MB6366.namprd03.prod.outlook.com>
        <CAHp75VeZLKN0C_+PopKfYtPMqEzGLd4paSKYnrHr1B2Y1Nk9=w@mail.gmail.com>
        <PH0PR03MB636647F75955CF0C5E6D5A3D99F99@PH0PR03MB6366.namprd03.prod.outlook.com>
        <CAL_Jsq+V0++aO8cTcd3A-nBiG_X4wzJ+ZXWnXeRMPb=2QYOUhw@mail.gmail.com>
        <PH0PR03MB63662507607DD7E06995B7EE99FA9@PH0PR03MB6366.namprd03.prod.outlook.com>
        <CAHp75Ve=C62FmC20qkLsMVFkc-rbhHqmY2StDtrYqG0=mjtcTw@mail.gmail.com>
        <PH0PR03MB63665918437E96CAF35B7CD799FA9@PH0PR03MB6366.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Aug 2021 10:05:17 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > -----Original Message-----
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Sent: Friday, August 13, 2021 10:05 AM
> > To: Sa, Nuno <Nuno.Sa@analog.com>
> > Cc: Rob Herring <robh+dt@kernel.org>; linux-iio <linux-  
> > iio@vger.kernel.org>; Jonathan Cameron <jic23@kernel.org>;  
> > Hennerich, Michael <Michael.Hennerich@analog.com>; Lars-Peter
> > Clausen <lars@metafoo.de>
> > Subject: Re: [PATCH] iio: ad5770r: make devicetree property reading
> > consistent
> > 
> > On Fri, Aug 13, 2021 at 10:47 AM Sa, Nuno <Nuno.Sa@analog.com>
> > wrote:  
> > > > From: Rob Herring <robh+dt@kernel.org>
> > > > Sent: Thursday, August 12, 2021 5:11 PM
> > > > On Thu, Aug 12, 2021 at 3:14 AM Sa, Nuno <Nuno.Sa@analog.com>
> > > > wrote:  
> > 
> > ...
> >   
> > > > > Could you give your input on this one?  
> > > >
> > > > There's no context, but I'm assuming this is in channel nodes. Keep  
> > >
> > > Sorry about that. Your assumption is correct, the binding is for a  
> > channel  
> > > node [1]. The driver just get's it as 'num' [2] which is not consistent.
> > > Naively, I just though changing the driver to use reg would be  
> > enough  
> > > but Andy nicely raised the question of someone being already relying
> > > on 'num'...
> > >  
> > > > the binding 'reg' and make the driver support both if needed.
> > > > Considering the author of the binding also changed the binding  
> > from  
> > > > num to reg shortly after adding the binding, I don't think 'num'
> > > > support is needed. If someone used 'num' and didn't run  
> > validation,  
> > > > well, that's their problem.
> > > >  
> > >
> > > So I guess the solution here is just to change the driver to support  
> > both  
> > > reg and num.  
> > 
> > As far as I got Rob's answer, if the binding never had the 'num',
> > dropping it from the driver is what we want now (actually your
> > original patch) and users, who are 'too much clever' :-) should have
> > had run validation for their DTs before production.
> > 
> > Taking this into account, I'm fine with the patch (but update a commit
> > message to summarize this discussion)
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >   
> 
> You're right... 
> Jonathan, do you want a v2 with an updated commit message?

Please do. Also please add a fixes tag given we are treating it
as a fix.  If we discover someone is using the num variant then
we'll just have to support both values as a fix to the fix.
Not ideal, but as observed, hopefully people are validating the
DTs (which basically means no one is using this in production or
it would have been pointed out before).

Jonathan


> 
> - Nuno Sá

