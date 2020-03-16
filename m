Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79F8D186A5C
	for <lists+linux-iio@lfdr.de>; Mon, 16 Mar 2020 12:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730884AbgCPLun (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Mar 2020 07:50:43 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2563 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730882AbgCPLun (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Mar 2020 07:50:43 -0400
Received: from lhreml701-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 8F000CF25293E0C9BB17;
        Mon, 16 Mar 2020 11:50:42 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml701-cah.china.huawei.com (10.201.108.42) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 16 Mar 2020 11:50:41 +0000
Received: from localhost (10.47.94.88) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 16 Mar
 2020 11:50:42 +0000
Date:   Mon, 16 Mar 2020 11:50:40 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Takashi Iwai <tiwai@suse.de>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Brian Masney <masneyb@onstation.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: tsl2772: Use scnprintf() for avoiding
 potential buffer overflow
Message-ID: <20200316115040.00003fa5@Huawei.com>
In-Reply-To: <s5hd09c209t.wl-tiwai@suse.de>
References: <20200311074325.7922-1-tiwai@suse.de>
        <20200311074325.7922-3-tiwai@suse.de>
        <20200315095834.76f50454@archlinux>
        <20200315103358.GA4674@onstation.org>
        <20200315131008.587ba23a@archlinux>
        <s5hd09c209t.wl-tiwai@suse.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.94.88]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Mar 2020 09:04:46 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> On Sun, 15 Mar 2020 14:10:08 +0100,
> Jonathan Cameron wrote:
> > 
> > On Sun, 15 Mar 2020 06:33:58 -0400
> > Brian Masney <masneyb@onstation.org> wrote:
> >   
> > > On Sun, Mar 15, 2020 at 09:58:34AM +0000, Jonathan Cameron wrote:  
> > > > On Wed, 11 Mar 2020 08:43:25 +0100
> > > > Takashi Iwai <tiwai@suse.de> wrote:
> > > >     
> > > > > Since snprintf() returns the would-be-output size instead of the
> > > > > actual output size, the succeeding calls may go beyond the given
> > > > > buffer limit.  Fix it by replacing with scnprintf().
> > > > > 
> > > > > Signed-off-by: Takashi Iwai <tiwai@suse.de>    
> > > > 
> > > > This one is printing a short well defined list of values.  No way they go
> > > > anywhere near the smallest possible PAGE_SIZE buffer that it's printing
> > > > into.
> > > > 
> > > > Which is handy given the remaining space isn't adjusted as we add items
> > > > to the string.  Hence even with scnprintf it would overflow.
> > > > 
> > > > Brian, can you take a look at this when you get a moment?    
> > > 
> > > I also agree that this won't overflow in practice, however we should fix
> > > this up. Maybe the scnprintf() calls should be this:
> > > 
> > >     offset += scnprintf(buf + offset, PAGE_SIZE - offset, ...);  
> > 
> > Agreed.  
> 
> Oh indeed, that must be.  This was the totally overlooked point.
> So the code has to be corrected altogether.
> 
> Shall I respin the patch with that change?

That would be great!

It's always amazing what turns up once you start looking closely at
a few lines of code :)

Jonathan

> 
> 
> thanks,
> 
> Takashi
> 
> > 
> > Jonathan
> >   
> > > 
> > > Brian
> > > 
> > >   
> > > > 
> > > > Thanks,
> > > > 
> > > > Jonathan
> > > >     
> > > > > ---
> > > > >  drivers/iio/light/tsl2772.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> > > > > index be37fcbd4654..44a0b56a558c 100644
> > > > > --- a/drivers/iio/light/tsl2772.c
> > > > > +++ b/drivers/iio/light/tsl2772.c
> > > > > @@ -986,7 +986,7 @@ static ssize_t in_illuminance0_lux_table_show(struct device *dev,
> > > > >  	int offset = 0;
> > > > >  
> > > > >  	while (i < TSL2772_MAX_LUX_TABLE_SIZE) {
> > > > > -		offset += snprintf(buf + offset, PAGE_SIZE, "%u,%u,",
> > > > > +		offset += scnprintf(buf + offset, PAGE_SIZE, "%u,%u,",
> > > > >  			chip->tsl2772_device_lux[i].ch0,
> > > > >  			chip->tsl2772_device_lux[i].ch1);
> > > > >  		if (chip->tsl2772_device_lux[i].ch0 == 0) {
> > > > > @@ -1000,7 +1000,7 @@ static ssize_t in_illuminance0_lux_table_show(struct device *dev,
> > > > >  		i++;
> > > > >  	}
> > > > >  
> > > > > -	offset += snprintf(buf + offset, PAGE_SIZE, "\n");
> > > > > +	offset += scnprintf(buf + offset, PAGE_SIZE, "\n");
> > > > >  	return offset;
> > > > >  }
> > > > >      
> >   


