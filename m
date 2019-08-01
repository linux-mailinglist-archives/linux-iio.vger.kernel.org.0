Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFBCB7D8B2
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2019 11:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbfHAJhd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Aug 2019 05:37:33 -0400
Received: from onstation.org ([52.200.56.107]:49252 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfHAJhd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 1 Aug 2019 05:37:33 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id AEA9D3E910;
        Thu,  1 Aug 2019 09:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1564652252;
        bh=bSREQHe0K6R3ACsHI8onhePS75HmOgPd/6TZve63MgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nj95LxDaFriwiQaSAsOJb7M1D+sCBezKlRMBw0ZBe3WQ1vgmtEF6M1lVy5yBF385X
         NThk1/24wo/YdDGOnvl2OnZ67NcOi7SsYZcJqDrH3ZNUo0UofDMgAYJC0vq9YvIoA3
         8ZZhEZ7KfNsuLfSx6EeRvavP5EE2Rlobb1uijBro=
Date:   Thu, 1 Aug 2019 05:37:31 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] iio: tsl2772: Use devm_add_action_or_reset
Message-ID: <20190801093731.GC27653@onstation.org>
References: <20190801073557.9578-1-hslester96@gmail.com>
 <20190801093347.GA27653@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801093347.GA27653@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 01, 2019 at 05:33:47AM -0400, Brian Masney wrote:
> On Thu, Aug 01, 2019 at 03:35:57PM +0800, Chuhong Yuan wrote:
> > Use devm_add_action_or_reset to remove the call to
> > tsl2772_disable_regulators_action to simplify the error path.
> > 
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> 
> For the whole series:
> 
> Reviewed-by: Brian Masney <masneyb@onstation.org>

Oops, I forgot to add this as well:

Tested-by: Brian Masney <masneyb@onstation.org>

I tested this on a Nexus 5 phone.

Brian


> 
> I forgot to mention this before, but next time please use a cover letter
> if you're sending more than one patch: git format-patch --cover-letter.
> 
> Brian
> 
> 
> > ---
> > Changes in v4:
> >   - Split v3 into three patches.
> >   - Revise description to make it more precise.
> > 
> >  drivers/iio/light/tsl2772.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> > index 83cece921843..29cfd8ae2700 100644
> > --- a/drivers/iio/light/tsl2772.c
> > +++ b/drivers/iio/light/tsl2772.c
> > @@ -1807,10 +1807,10 @@ static int tsl2772_probe(struct i2c_client *clientp,
> >  		return PTR_ERR(chip->vdd_supply);
> >  	}
> >  
> > -	ret = devm_add_action(&clientp->dev, tsl2772_disable_regulators_action,
> > -			      chip);
> > +	ret = devm_add_action_or_reset(&clientp->dev,
> > +					tsl2772_disable_regulators_action,
> > +					chip);
> >  	if (ret < 0) {
> > -		tsl2772_disable_regulators_action(chip);
> >  		dev_err(&clientp->dev, "Failed to setup regulator cleanup action %d\n",
> >  			ret);
> >  		return ret;
> > -- 
> > 2.20.1
