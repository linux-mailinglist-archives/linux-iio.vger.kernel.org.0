Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2079477917
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 17:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhLPQa4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Dec 2021 11:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239114AbhLPQaz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 11:30:55 -0500
Received: from balrog.mythic-beasts.com (balrog.mythic-beasts.com [IPv6:2a00:1098:0:82:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBAAC061574
        for <linux-iio@vger.kernel.org>; Thu, 16 Dec 2021 08:30:55 -0800 (PST)
Received: from [81.101.6.87] (port=48036 helo=jic23-huawei)
        by balrog.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1mxteb-0001z0-75; Thu, 16 Dec 2021 16:30:53 +0000
Date:   Thu, 16 Dec 2021 16:36:14 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Marc Titinger <mtitinger@baylibre.com>,
        Matt Ranostay <mranostay@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: as3935: Remove unnecessary cast
Message-ID: <20211216163606.2590bcc3@jic23-huawei>
In-Reply-To: <CAHp75VdDB92KGALRhBoepmBZQiXqUK7n4AmpM4mbSxKDku0f8Q@mail.gmail.com>
References: <20211209161730.396848-1-lars@metafoo.de>
        <CAHp75VdDB92KGALRhBoepmBZQiXqUK7n4AmpM4mbSxKDku0f8Q@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 4
X-Spam-Status: No, score=0.4
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 10 Dec 2021 00:13:49 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thursday, December 9, 2021, Lars-Peter Clausen <lars@metafoo.de> wrote:
> 
> > `buf` is cast to a const char *, but `buf` is already a const char *, so
> > the case is unnecessary.
> >
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > ---
> >  drivers/iio/proximity/as3935.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/
> > as3935.c
> > index d62766b6b39e..51f4f92ae84a 100644
> > --- a/drivers/iio/proximity/as3935.c
> > +++ b/drivers/iio/proximity/as3935.c
> > @@ -133,7 +133,7 @@ static ssize_t as3935_sensor_sensitivity_store(struct
> > device *dev,
> >         unsigned long val;
> >         int ret;
> >
> > -       ret = kstrtoul((const char *) buf, 10, &val);
> > +       ret = kstrtoul(buf, 10, &val);
> >         if (ret)
> >                 return -EINVAL;  
> 
> 
> 
> A bit out of scope, but this eventually should be
> 
Agreed this could do with a follow up, as should the other one you
point out, but in the spirit of single purpose series I've applied
this set to the togreg branch of iio.git - pushed out as testing
and look forward to the follow ups ;)

Jonathan

>   return ret;
> 
> 
> 
> >
> > --
> > 2.30.2
> >
> >  
> 

