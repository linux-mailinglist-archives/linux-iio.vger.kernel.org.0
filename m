Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D183185BF8
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 11:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgCOKd7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 06:33:59 -0400
Received: from onstation.org ([52.200.56.107]:38084 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728247AbgCOKd7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Mar 2020 06:33:59 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 7CCAF3E9FD;
        Sun, 15 Mar 2020 10:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1584268438;
        bh=ck55uNYScn7NP8oBNgNFD+lyQRvJgEekOPCBFjDlO+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sDnevCUtB9FKpYLrFUr3f1qELnKmkL1QML1WHIDAdpUeCiVcSTFAuiI2g/QDsDuDd
         27uSxUfCbA96aGmZa3EM90NVohTwHMs+1JFiGlL7zXbC1ymKDVSHX92MRgr8hzI84l
         OwOTz4A7T2XgfeyiiuRd4DnA36g5HMwgiQFGrjWI=
Date:   Sun, 15 Mar 2020 06:33:58 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: tsl2772: Use scnprintf() for avoiding potential
 buffer overflow
Message-ID: <20200315103358.GA4674@onstation.org>
References: <20200311074325.7922-1-tiwai@suse.de>
 <20200311074325.7922-3-tiwai@suse.de>
 <20200315095834.76f50454@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315095834.76f50454@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 15, 2020 at 09:58:34AM +0000, Jonathan Cameron wrote:
> On Wed, 11 Mar 2020 08:43:25 +0100
> Takashi Iwai <tiwai@suse.de> wrote:
> 
> > Since snprintf() returns the would-be-output size instead of the
> > actual output size, the succeeding calls may go beyond the given
> > buffer limit.  Fix it by replacing with scnprintf().
> > 
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> 
> This one is printing a short well defined list of values.  No way they go
> anywhere near the smallest possible PAGE_SIZE buffer that it's printing
> into.
> 
> Which is handy given the remaining space isn't adjusted as we add items
> to the string.  Hence even with scnprintf it would overflow.
> 
> Brian, can you take a look at this when you get a moment?

I also agree that this won't overflow in practice, however we should fix
this up. Maybe the scnprintf() calls should be this:

    offset += scnprintf(buf + offset, PAGE_SIZE - offset, ...);

Brian


> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/light/tsl2772.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> > index be37fcbd4654..44a0b56a558c 100644
> > --- a/drivers/iio/light/tsl2772.c
> > +++ b/drivers/iio/light/tsl2772.c
> > @@ -986,7 +986,7 @@ static ssize_t in_illuminance0_lux_table_show(struct device *dev,
> >  	int offset = 0;
> >  
> >  	while (i < TSL2772_MAX_LUX_TABLE_SIZE) {
> > -		offset += snprintf(buf + offset, PAGE_SIZE, "%u,%u,",
> > +		offset += scnprintf(buf + offset, PAGE_SIZE, "%u,%u,",
> >  			chip->tsl2772_device_lux[i].ch0,
> >  			chip->tsl2772_device_lux[i].ch1);
> >  		if (chip->tsl2772_device_lux[i].ch0 == 0) {
> > @@ -1000,7 +1000,7 @@ static ssize_t in_illuminance0_lux_table_show(struct device *dev,
> >  		i++;
> >  	}
> >  
> > -	offset += snprintf(buf + offset, PAGE_SIZE, "\n");
> > +	offset += scnprintf(buf + offset, PAGE_SIZE, "\n");
> >  	return offset;
> >  }
> >  
