Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB83387E6F
	for <lists+linux-iio@lfdr.de>; Tue, 18 May 2021 19:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351154AbhERRfJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 18 May 2021 13:35:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351147AbhERRfJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 18 May 2021 13:35:09 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2151860E0C;
        Tue, 18 May 2021 17:33:49 +0000 (UTC)
Date:   Tue, 18 May 2021 18:35:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v4] iio: adis16480: support burst read function
Message-ID: <20210518183507.6d6a2e48@jic23-huawei>
In-Reply-To: <PH0PR03MB6366E94DF97823BE26BD0EBC992C9@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210422103735.136367-1-nuno.sa@analog.com>
        <20210424123216.317e9b34@jic23-huawei>
        <PH0PR03MB6366E7F728971DAF5B867898995A9@PH0PR03MB6366.namprd03.prod.outlook.com>
        <20210508155709.38eaaa7b@jic23-huawei>
        <PH0PR03MB6366E94DF97823BE26BD0EBC992C9@PH0PR03MB6366.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 18 May 2021 14:21:08 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> Hi Jonathan,
> 
> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Saturday, May 8, 2021 4:57 PM
> > To: Sa, Nuno <Nuno.Sa@analog.com>
> > Cc: linux-iio@vger.kernel.org; Hennerich, Michael
> > <Michael.Hennerich@analog.com>; Lars-Peter Clausen
> > <lars@metafoo.de>
> > Subject: Re: [PATCH v4] iio: adis16480: support burst read function
> > 
> > [External]
> > 
> > On Tue, 4 May 2021 07:16:46 +0000
> > "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
> >   
> > > > -----Original Message-----
> > > > From: Jonathan Cameron <jic23@kernel.org>
> > > > Sent: Saturday, April 24, 2021 1:32 PM
> > > > To: Sa, Nuno <Nuno.Sa@analog.com>
> > > > Cc: linux-iio@vger.kernel.org; Hennerich, Michael
> > > > <Michael.Hennerich@analog.com>; Lars-Peter Clausen
> > > > <lars@metafoo.de>
> > > > Subject: Re: [PATCH v4] iio: adis16480: support burst read function
> > > >
> > > > On Thu, 22 Apr 2021 12:37:35 +0200
> > > > Nuno Sa <nuno.sa@analog.com> wrote:
> > > >  
> > > > > Some supported devices support burst read function. This  
> > provides a  
> > > > method  
> > > > > for reading a batch of data (status, temperature, gyroscopes,
> > > > > accelerometers, time stamp/data counter, and CRC code), which  
> > > > does not  
> > > > > require a stall time between each 16-bit segment and only  
> > requires  
> > > > one  
> > > > > command on the DIN line to initiate. Devices supporting this  
> > mode  
> > > > > are:
> > > > >
> > > > >  * adis16495-1
> > > > >  * adis16495-2
> > > > >  * adis16495-3
> > > > >  * adis16497-1
> > > > >  * adis16497-2
> > > > >  * adis16497-3
> > > > >
> > > > > Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
> > > > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>  
> > > >
> > > > Looks good to me.  Give me a poke if I seem to have lost it when
> > > > the dependency is in place.
> > > >  
> > >
> > > poking :) ...  
> > Thanks :)
> > Applied to the togreg branch of iio.git and pushed out as testing for
> > all the normal reasons.
> >   
> 
> Was this patch somehow lost? I was trying to sync up ADI internal tree and
> I cannot see this patch either in testing or togreg...
Odd.  Sorry about that. Now applied and pushed out as testing.

Jonathan

> 
> Thanks,
> - Nuno Sá

