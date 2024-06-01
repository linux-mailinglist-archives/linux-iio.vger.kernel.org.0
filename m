Return-Path: <linux-iio+bounces-5588-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6C48D71AE
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 21:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386FB2820E0
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 19:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE54A154C0C;
	Sat,  1 Jun 2024 19:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abna+zd2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8389A171A5;
	Sat,  1 Jun 2024 19:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717269879; cv=none; b=b/AXFAD/5uq7gUU+pvMjaNc2bT4g8VdU4FCZ9XfHqLtApsF6fXGJMY5XSLrYPjxAXbqX2eEyw4ODRXyanhOtAYDrVYj+XEqMchpJpsc+ywWcM/YQbf8t0C8xRUXzeXvygz0CetzRAC+BeDhKyijjJ+4bN3ikkyiWYomykMQ9uaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717269879; c=relaxed/simple;
	bh=lJsSCZd98JRXceVU+lNuxRSqXxc0iQ2E6diITqpWoGY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=entFIAt+bcAnWr6O4D6J4SwoMhD55RDoRXvxYoCalVKtq45LPARUOZajiBxutbdD2ARE7TwzhC0ynAHk4THGqUpe4XzQiGQcumXkQrsoo1yLrsiKcLYY1aCgxtqoCP3cEXAlG8nQpocqSgkQhr0yf7GTWDuWB4A/AfYW1afBeiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abna+zd2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4829FC116B1;
	Sat,  1 Jun 2024 19:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717269879;
	bh=lJsSCZd98JRXceVU+lNuxRSqXxc0iQ2E6diITqpWoGY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=abna+zd2u9t/Q0MDsblVaYLJ//OznWHXRywOnSKJ/3LPDRC/L0xt0STFav3miY0uI
	 j6Qgh2gkf7aTgXhzfB5bXUtsgJz8WNZ9ztQv392bKltsrbstYoracJiYO7Dc3Tw5As
	 2wdzRJLuuyvCqHLiXoVF6cX/2sJvqZKpWIZpHP9bqZZmC+s7e9mLrHL2X8Xpll7NBL
	 0AUEfZv7V+Py2rhxnalDYGMCXdSH2qGTu93gOP/1A5vWDMyCc3e/yZP5lPaweXbei4
	 bJKkoMoxdRETJ6hztUbjkw3fCpjSIgY8Wsf5HAjvEHZOjnmRj3Yuif0WNFJgfLr6eM
	 2BbjNU/I2rLGA==
Date: Sat, 1 Jun 2024 20:24:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Greg KH <greg@kroah.com>
Cc: linux@treblig.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: iio: adt7316: remove unused struct
 'adt7316_limit_regs'
Message-ID: <20240601202426.0f667a0d@jic23-huawei>
In-Reply-To: <2024053049-repossess-moonwalk-4235@gregkh>
References: <20240529160055.28489-1-linux@treblig.org>
	<2024053049-repossess-moonwalk-4235@gregkh>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 May 2024 11:45:03 +0200
Greg KH <greg@kroah.com> wrote:

> On Wed, May 29, 2024 at 05:00:55PM +0100, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > 'adt7316_limit_regs' has never been used since the original
> > commit 35f6b6b86ede ("staging: iio: new ADT7316/7/8 and ADT7516/7/9
> > driver").
> > 
> > The comment above it is a copy-and-paste from a different struct.
> > 
> > Remove both the struct and the comment.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Greg's bot is correct, but meh, not worth a v3.

I picked up Nuno's tag from v1 though. I don't think that came
in after you'd sent this, so I guess you missed that one.

Applied.

Jonathan

> > ---
> >  drivers/staging/iio/addac/adt7316.c | 9 ---------
> >  1 file changed, 9 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> > index 79467f056a05..f4260786d50a 100644
> > --- a/drivers/staging/iio/addac/adt7316.c
> > +++ b/drivers/staging/iio/addac/adt7316.c
> > @@ -209,15 +209,6 @@ struct adt7316_chip_info {
> >  #define ADT7316_TEMP_AIN_INT_MASK	\
> >  	(ADT7316_TEMP_INT_MASK)
> >  
> > -/*
> > - * struct adt7316_chip_info - chip specific information
> > - */
> > -
> > -struct adt7316_limit_regs {
> > -	u16	data_high;
> > -	u16	data_low;
> > -};
> > -
> >  static ssize_t adt7316_show_enabled(struct device *dev,
> >  				    struct device_attribute *attr,
> >  				    char *buf)
> > -- 
> > 2.45.1
> > 
> >   
> 
> Hi,
> 
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
> 
> You are receiving this message because of the following common error(s)
> as indicated below:
> 
> - This looks like a new version of a previously submitted patch, but you
>   did not list below the --- line any changes from the previous version.
>   Please read the section entitled "The canonical patch format" in the
>   kernel file, Documentation/process/submitting-patches.rst for what
>   needs to be done here to properly describe this.
> 
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
> 
> thanks,
> 
> greg k-h's patch email bot


