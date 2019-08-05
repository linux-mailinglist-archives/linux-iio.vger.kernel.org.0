Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8AA82009
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 17:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbfHEPZf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 11:25:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728468AbfHEPZf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Aug 2019 11:25:35 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3435120880;
        Mon,  5 Aug 2019 15:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565018734;
        bh=46qT1njeA/amYMLiDTb4zMUL3B7EVT91q/FztoHlmQA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wvIANRTPX4AeyxmqbYyqGn8M07hRGn27gjj7WdBTWhCwLVSLFMFz58SxBw056LF6j
         +yI/mGvRv4rNTARY5C/UDPUjEeAWOZq418bXkyhEfL9A5n98sg9JWTnTGV+KtXWUr5
         1TeDBRT2rJz+LRpauU6dPCyXcvUf3G/ny79IW4z4=
Date:   Mon, 5 Aug 2019 16:25:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] iio: tsl2772: Use devm_add_action_or_reset
Message-ID: <20190805162530.4c24df1c@archlinux>
In-Reply-To: <20190801093731.GC27653@onstation.org>
References: <20190801073557.9578-1-hslester96@gmail.com>
        <20190801093347.GA27653@onstation.org>
        <20190801093731.GC27653@onstation.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 1 Aug 2019 05:37:31 -0400
Brian Masney <masneyb@onstation.org> wrote:

> On Thu, Aug 01, 2019 at 05:33:47AM -0400, Brian Masney wrote:
> > On Thu, Aug 01, 2019 at 03:35:57PM +0800, Chuhong Yuan wrote:  
> > > Use devm_add_action_or_reset to remove the call to
> > > tsl2772_disable_regulators_action to simplify the error path.
> > > 
> > > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>  
> > 
> > For the whole series:
> > 
> > Reviewed-by: Brian Masney <masneyb@onstation.org>  
> 
> Oops, I forgot to add this as well:
> 
> Tested-by: Brian Masney <masneyb@onstation.org>
> 
> I tested this on a Nexus 5 phone.
> 
> Brian
> 
Applied to the togreg branch of iio.git and pushed out as testing.

Now the fact we have a fix in the middle of this series is
a bit unfortunate as it'll mean we need an explicit backport to
take that for stable.

Oh well, if anyone wants it up to them to do the work ;)

Thanks,

Jonathan

> 
> > 
> > I forgot to mention this before, but next time please use a cover letter
> > if you're sending more than one patch: git format-patch --cover-letter.
> > 
> > Brian
> > 
> >   
> > > ---
> > > Changes in v4:
> > >   - Split v3 into three patches.
> > >   - Revise description to make it more precise.
> > > 
> > >  drivers/iio/light/tsl2772.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> > > index 83cece921843..29cfd8ae2700 100644
> > > --- a/drivers/iio/light/tsl2772.c
> > > +++ b/drivers/iio/light/tsl2772.c
> > > @@ -1807,10 +1807,10 @@ static int tsl2772_probe(struct i2c_client *clientp,
> > >  		return PTR_ERR(chip->vdd_supply);
> > >  	}
> > >  
> > > -	ret = devm_add_action(&clientp->dev, tsl2772_disable_regulators_action,
> > > -			      chip);
> > > +	ret = devm_add_action_or_reset(&clientp->dev,
> > > +					tsl2772_disable_regulators_action,
> > > +					chip);
> > >  	if (ret < 0) {
> > > -		tsl2772_disable_regulators_action(chip);
> > >  		dev_err(&clientp->dev, "Failed to setup regulator cleanup action %d\n",
> > >  			ret);
> > >  		return ret;
> > > -- 
> > > 2.20.1  

