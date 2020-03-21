Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84ED918E3A1
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 19:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgCUSVt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 14:21:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:58432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727224AbgCUSVt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Mar 2020 14:21:49 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9FDB20753;
        Sat, 21 Mar 2020 18:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584814908;
        bh=7Cr82fnl4hRYwQw+nRYSB4ZktK9lbGM4lbrVfLIhIkU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Um87fBdDnGpJM3jFYh5e/12x21VeO4cpNnWJLEeyn0luLdMzzNN8cwh5J14XF3d85
         JPU9n+hIgw3glqCGZ67uOBOZEriY3i/9Vn1+pbQN8g9vsGq7BQ8WcvNnG7vy2YhA2o
         jy5NvXEKr351yLa/EMU8bsDTo/hSMTF9we5S46eY=
Date:   Sat, 21 Mar 2020 18:21:44 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [RFC][PATCH] iio: buffer: Don't allow buffers without any
 channels enabled to be activated
Message-ID: <20200321182144.4c3226ee@archlinux>
In-Reply-To: <3c2ea62e060ae260536766c3ebdd7fe6a1ab5725.camel@analog.com>
References: <20200320104031.31701-1-alexandru.ardelean@analog.com>
        <253007c8-38ed-acd8-a506-b22f34d03997@metafoo.de>
        <3c2ea62e060ae260536766c3ebdd7fe6a1ab5725.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 20 Mar 2020 11:16:12 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Fri, 2020-03-20 at 11:55 +0100, Lars-Peter Clausen wrote:
> > On 3/20/20 11:40 AM, Alexandru Ardelean wrote:  
> > > From: Lars-Peter Clausen <lars@metafoo.de>
> > > 
> > > Before activating a buffer make sure that at least one channel is enabled.
> > > Activating a buffer with 0 channels enabled doesn't make too much sense and
> > > disallowing this case makes sure that individual driver don't have to add
> > > special case code to handle it.
> > > 
> > > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > > ---
> > > 
> > > * Found this relic-patch in our tree, from 6 years ago:
> > >    https://github.com/analogdevicesinc/linux/commit/6d680e49d459c
> > >    It got moved around a bit, and this is the current form in the ADI tree.
> > >    So, this is also a bit of an RFC, but if the idea is valid, maybe it's
> > >    worth considering upstream. I don't know of any arguments against it,
> > >    but I could be surprised.  
> > 
> > Hm, a bit weird that this one never made it upstream considering how 
> > simple it is.
> > 
> > Did you check that the issue still occurs? I can't see anything in the 
> > code that prevents it, but who knows, maybe it was fixed by something else.  
> 
> i did not think to check behavior/issues;
> i'll try to make some time for that;

I can't immediately think of anything that would stop this case.

However, good if you could confirm it.  (I don't have a setup running
right now to test against)


> i caught this one while diff-ing the upstream & ADI trees, and i needed to dig a
> bit more into the ADI git history on it;
> 
> i was a bit puzzled for a while, because some rework patches were upstreamed
> without this patch:
> 
> https://lore.kernel.org/linux-iio/55585CAA.6000506@kernel.org/
> https://lore.kernel.org/linux-iio/5560685A.5060504@kernel.org/
> 
> i also did not find any discussions/upstream attempt for this patch particularly
> 
> so, it was easier for me just to RFC this
> 
> >   
> > >   drivers/iio/industrialio-buffer.c | 6 ++++++
> > >   1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-
> > > buffer.c
> > > index 4ada5592aa2b..f222a118d0d3 100644
> > > --- a/drivers/iio/industrialio-buffer.c
> > > +++ b/drivers/iio/industrialio-buffer.c
> > > @@ -1031,6 +1031,12 @@ static int __iio_update_buffers(struct iio_dev
> > > *indio_dev,
> > >   		return ret;
> > >   
> > >   	if (insert_buffer) {
> > > +		if (bitmap_empty(insert_buffer->scan_mask,
> > > +			indio_dev->masklength)) {
> > > +			ret = -EINVAL;
> > > +			goto err_free_config;
> > > +		}  
> > 
> > Since the check is so simple it might make sense to do it as the very 
> > first thing before iio_verify_update().  
> 
> works for me;
> 
> >   
> > > +
> > >   		ret = iio_buffer_request_update(indio_dev, insert_buffer);
> > >   		if (ret)
> > >   			goto err_free_config;
> > >   

