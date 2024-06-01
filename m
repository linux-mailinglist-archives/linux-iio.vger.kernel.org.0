Return-Path: <linux-iio+bounces-5591-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 380618D71E6
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 22:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8A1281709
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 20:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540BD154C00;
	Sat,  1 Jun 2024 20:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="AY1J70zv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484BA1CAA6;
	Sat,  1 Jun 2024 20:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717275065; cv=none; b=njmk14sppV/IIFPSpFevC9hAXfEz7YIeOiWesZtRF1390IT+5z7f98x4ZstWSyFi0vRkDoyzbxRN/C6Rq7XPL81c1usOHoEA/9kM4b+X/23eEW8WFEPylUOkZctWZo4h8MUtaBnuX4Bcmfvpqgo+RtNtQPKUphydIBLUQYxgVUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717275065; c=relaxed/simple;
	bh=NP/r89WxcSHiG32+OPN4wVDkmqX2CPWxzvihewvyHAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQ3dgQbFXlHdGtsNJU9FmGP0/rdopsn5Uw2R1UFwQ2YomXkwXozJLpfXSZuB3gcpjtj+zQD4/59x7yneyFKkAE2XXPSvyvboZBgHUDIyFDO37abTOkTTkO4/DdLusJIZyj02tmWxhTHoD/ANTO7Yfi+IyhH0veshS+e451FVO00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=AY1J70zv; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=WscMFS7a4CeJw0zsLY2pLYSCPzFoN90vk/QWypLw3pM=; b=AY1J70zvdlqs7izN
	VcbE9s52IV9X9U7B+mp/1LMrAFAjZ9QleqdE5W9tZwOqKw0cwYp+YuQcDsW5ZQBvgCCJFCLjk5V4v
	kOszt8wtTi3n4VPIHnk2FlU6T4MrGPRakY914LVDg1/r3Zv8PrhtCLZ72/nmp+mK8p3bORW7asCeW
	nSY1qiMGYytIzM/J80tcko6xVAT4ohBHb98Oz+xVS6/NrJ5oFmNXiQTF3X7yl7uvWlc+tKulSsOsl
	sjGxRqoLzH8qsEwbJRKfqs9EweTyzl/IWJcceeyPsB3j+g9E+NeHXBGo2MsqkUs6UgmKOMQ1zU18t
	RzyUrBTmyqcbsjESBg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sDV0s-003l0n-1I;
	Sat, 01 Jun 2024 20:07:38 +0000
Date: Sat, 1 Jun 2024 20:07:38 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Greg KH <greg@kroah.com>, lars@metafoo.de, Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: iio: adt7316: remove unused struct
 'adt7316_limit_regs'
Message-ID: <Zlt_iqhNZpPNkTEn@gallifrey>
References: <20240529160055.28489-1-linux@treblig.org>
 <2024053049-repossess-moonwalk-4235@gregkh>
 <20240601202426.0f667a0d@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240601202426.0f667a0d@jic23-huawei>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 20:07:26 up 24 days,  7:21,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Jonathan Cameron (jic23@kernel.org) wrote:
> On Thu, 30 May 2024 11:45:03 +0200
> Greg KH <greg@kroah.com> wrote:
> 
> > On Wed, May 29, 2024 at 05:00:55PM +0100, linux@treblig.org wrote:
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > 
> > > 'adt7316_limit_regs' has never been used since the original
> > > commit 35f6b6b86ede ("staging: iio: new ADT7316/7/8 and ADT7516/7/9
> > > driver").
> > > 
> > > The comment above it is a copy-and-paste from a different struct.
> > > 
> > > Remove both the struct and the comment.
> > > 
> > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> Greg's bot is correct, but meh, not worth a v3.
> 
> I picked up Nuno's tag from v1 though. I don't think that came
> in after you'd sent this, so I guess you missed that one.
> 
> Applied.

Thanks!

Dave

> Jonathan
> 
> > > ---
> > >  drivers/staging/iio/addac/adt7316.c | 9 ---------
> > >  1 file changed, 9 deletions(-)
> > > 
> > > diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> > > index 79467f056a05..f4260786d50a 100644
> > > --- a/drivers/staging/iio/addac/adt7316.c
> > > +++ b/drivers/staging/iio/addac/adt7316.c
> > > @@ -209,15 +209,6 @@ struct adt7316_chip_info {
> > >  #define ADT7316_TEMP_AIN_INT_MASK	\
> > >  	(ADT7316_TEMP_INT_MASK)
> > >  
> > > -/*
> > > - * struct adt7316_chip_info - chip specific information
> > > - */
> > > -
> > > -struct adt7316_limit_regs {
> > > -	u16	data_high;
> > > -	u16	data_low;
> > > -};
> > > -
> > >  static ssize_t adt7316_show_enabled(struct device *dev,
> > >  				    struct device_attribute *attr,
> > >  				    char *buf)
> > > -- 
> > > 2.45.1
> > > 
> > >   
> > 
> > Hi,
> > 
> > This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> > a patch that has triggered this response.  He used to manually respond
> > to these common problems, but in order to save his sanity (he kept
> > writing the same thing over and over, yet to different people), I was
> > created.  Hopefully you will not take offence and will fix the problem
> > in your patch and resubmit it so that it can be accepted into the Linux
> > kernel tree.
> > 
> > You are receiving this message because of the following common error(s)
> > as indicated below:
> > 
> > - This looks like a new version of a previously submitted patch, but you
> >   did not list below the --- line any changes from the previous version.
> >   Please read the section entitled "The canonical patch format" in the
> >   kernel file, Documentation/process/submitting-patches.rst for what
> >   needs to be done here to properly describe this.
> > 
> > If you wish to discuss this problem further, or you have questions about
> > how to resolve this issue, please feel free to respond to this email and
> > Greg will reply once he has dug out from the pending patches received
> > from other developers.
> > 
> > thanks,
> > 
> > greg k-h's patch email bot
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

