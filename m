Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59E4877E92
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2019 10:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbfG1Ibm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jul 2019 04:31:42 -0400
Received: from onstation.org ([52.200.56.107]:60198 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbfG1Ibm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jul 2019 04:31:42 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 677C43E910;
        Sun, 28 Jul 2019 08:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1564302701;
        bh=AWKgQKrrvDNiwarsZqzB/zOZ+odDStBIqipGpwB/cb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PkPOV222FnMi9TEHjWgqDBD+keBEuoPt4lf5fkQ4rAdDytDHQRD4Qjhht+mslgDu8
         WOHjytkf4k6+W31WEqzqs9aSb51JA2FG77lVTX6l+sgz0YlLv97+RCIPxLdUyHb0fh
         QMhTQGSReBk/tNkwXFn8hftHOwOFKn7HJtOvmOlI=
Date:   Sun, 28 Jul 2019 04:31:41 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Chuhong Yuan <hslester96@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: tsl2772: Use device-managed API
Message-ID: <20190728083141.GA14194@onstation.org>
References: <20190726123058.22915-1-hslester96@gmail.com>
 <20190727125749.63297c28@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190727125749.63297c28@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jul 27, 2019 at 12:57:49PM +0100, Jonathan Cameron wrote:
> On Fri, 26 Jul 2019 20:30:58 +0800
> Chuhong Yuan <hslester96@gmail.com> wrote:
> 
> > Use devm_iio_device_register to simplify
> > the code.
> > 
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> 
> Please try to pick up on likely reviewers in your cc list.  In this case
> Brian did a lot of work cleaning these drivers up so I've added him.
> Not everyone keeps up with the linux-iio list for some reason ;)
> 
> Immediate thought was that you had broken the ordering but turns out
> it is already buggy.
> 
> As things stand, we remove the userspace interfaces (iio_device_unregister)
> after turning off the power.   This is obviously a bad idea and also
> form a purely "obviously correct" stand point, we aren't doing the reverse
> of probe.
> 
> So, I 'think' the right option is to reorder remove so that the power left
> on until after the iio_device_unregister call. At that point, we can't
> use devm_iio_device_register as we'll have the same incorrect ordering
> we currently have.
> 
> Brian, you looked at this driver most recently.  Thoughts?

devm_add_action() could be used in the probe function to schedule the call
to tsl2772_chip_off(). That would eliminate the need for
tsl2772_remove(). See tsl2772_disable_regulators_action() for an example in
that driver.

Chuhong: Another potential cleanup to shrink the size of this driver is
to move it over to the regulator_bulk_() API. I didn't realize that API
existed at the time I introduced the regulator support. If you're
interested in taking on that cleanup as well, I can test those changes
for you if you don't have the hardware.

Brian


> > ---
> >  drivers/iio/light/tsl2772.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> > index 83cece921843..aa5891d105e8 100644
> > --- a/drivers/iio/light/tsl2772.c
> > +++ b/drivers/iio/light/tsl2772.c
> > @@ -1877,7 +1877,7 @@ static int tsl2772_probe(struct i2c_client *clientp,
> >  	if (ret < 0)
> >  		return ret;
> >  
> > -	ret = iio_device_register(indio_dev);
> > +	ret = devm_iio_device_register(&clientp->dev, indio_dev);
> >  	if (ret) {
> >  		tsl2772_chip_off(indio_dev);
> >  		dev_err(&clientp->dev,
> > @@ -1928,8 +1928,6 @@ static int tsl2772_remove(struct i2c_client *client)
> >  
> >  	tsl2772_chip_off(indio_dev);
> >  
> > -	iio_device_unregister(indio_dev);
> > -
> >  	return 0;
> >  }
> >  
