Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD8C387F1A
	for <lists+linux-iio@lfdr.de>; Tue, 18 May 2021 19:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344931AbhERR7m convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 18 May 2021 13:59:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:52586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344568AbhERR7h (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 18 May 2021 13:59:37 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C931611B0;
        Tue, 18 May 2021 17:58:16 +0000 (UTC)
Date:   Tue, 18 May 2021 18:59:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     tangbin <tangbin@cmss.chinamobile.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: cdc: ad7746: Fix unnecessary check
 andassignment in ad7746_probe()
Message-ID: <20210518185933.7839f848@jic23-huawei>
In-Reply-To: <dfb7d829-94e6-2051-8795-79402160afdb@cmss.chinamobile.com>
References: <20210517150006.8436-1-tangbin@cmss.chinamobile.com>
        <20210518075254.GN1955@kadam>
        <dfb7d829-94e6-2051-8795-79402160afdb@cmss.chinamobile.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 18 May 2021 17:27:07 +0800
tangbin <tangbin@cmss.chinamobile.com> wrote:

> Hi Dan：
> 
> On 2021/5/18 15:52, Dan Carpenter wrote:
> > On Mon, May 17, 2021 at 11:00:06PM +0800, Tang Bin wrote:  
> >> @@ -730,11 +730,7 @@ static int ad7746_probe(struct i2c_client *client,
> >>   	if (ret < 0)
> >>   		return ret;
> >>   
> >> -	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
> >> -	if (ret)
> >> -		return ret;
> >> -
> >> -	return 0;
> >> +	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
> >>   }  
> > This sort of thing is done deliberately as a style choice...  I probably
> > wouldn't have written it that way myself, but there really isn't a
> > downside to leaving it as-is.
> >
> > The unused "int ret = 0;" just introduces a static checker warning about
> > unused assignments and disables the static checker warning for
> > uninitialized variables so we want to remove that.
> >  
> Got it, I will send this patch for you.

I fall a bit different on this and would consider the above a cleanup
though one I'd prefer to get with more significant stuff rather
than on it's own.  However, there is already a patch in revision
that includes the same change from Lucas Stankus.

> 
> Thanks
> 
> Tang Bin
> 
> 
> 

