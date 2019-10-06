Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6131CCF89
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 10:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfJFIvk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 04:51:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbfJFIvj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 04:51:39 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC1022084B;
        Sun,  6 Oct 2019 08:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570351898;
        bh=OEy3qiPp0T0JkUeadJHy0tCKf+Te/pLWe5aMTNCMgu8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hgxawF7NwQi3Mg4pkByB7as1AmOyuVM3oUQNgkg8TS4UcNYjp9d8wRAPIOQSna+03
         psv0UYt4yFP2cvvA5dntCKchcc4g1LbOj+ZSg85QIWuWQ9Ss+dald7tRh8MIeyl3EU
         k/1Oucd3YaDpt/dSUVgc1lWL5qyDZ6UgL0icdUWU=
Date:   Sun, 6 Oct 2019 09:51:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH] iio: imu: adis16480: clean up a condition
Message-ID: <20191006095133.24fb89be@archlinux>
In-Reply-To: <20190926113630.GF27389@kadam>
References: <20190926081016.GA2332@mwanda>
        <9e40c550310d6f30e6481329e01061beb474bc33.camel@analog.com>
        <20190926113630.GF27389@kadam>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 26 Sep 2019 14:36:30 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> On Thu, Sep 26, 2019 at 11:06:39AM +0000, Ardelean, Alexandru wrote:
> > On Thu, 2019-09-26 at 11:10 +0300, Dan Carpenter wrote:  
> > > [External]
> > > 
> > > The "t" variable is unsigned so it can't be less than zero.  We really
> > > are just trying to prevent divide by zero bugs so just checking against
> > > zero is sufficient.

I'm not sure that true.  It if were signed we'd be detecting that the
input from userspace was negative.  That is clearly garbage for a frequency
control..  I'll hazard a guess that it was intended to catch that
as well as the divide by 0 case. 

This would be clearer if we first checked that val and val2 are both not
negative, then did the zero test on t.

If people agree, anyone want to spin a patch to do that?

Thanks,

Jonathan

> > > 
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > ---
> > >  drivers/iio/imu/adis16480.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> > > index b99d73887c9f..e144e567675d 100644
> > > --- a/drivers/iio/imu/adis16480.c
> > > +++ b/drivers/iio/imu/adis16480.c
> > > @@ -318,7 +318,7 @@ static int adis16480_set_freq(struct iio_dev
> > > *indio_dev, int val, int val2)
> > >  	unsigned int t, reg;  
> > 
> > I would just change the type of "t" to "int".
> > Especially, since "val" & "val2" are "int".
> >   
> 
> Yeah, but negatives or high values are basically fine.  We only care
> zero.
> 
> regards,
> dan carpenter
> 

