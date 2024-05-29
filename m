Return-Path: <linux-iio+bounces-5459-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9334F8D3BA3
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 18:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C45381C23A8A
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 16:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01C4184124;
	Wed, 29 May 2024 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="TnOZ2jGc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53861836EF;
	Wed, 29 May 2024 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998491; cv=none; b=mP1eO5Ii4aw1h0WWBzcWQr4g1EakKRxrqeEq5amMhSZhZoDu/HfEtA9mIF1tJ02OR+2l6Hjci4aW9865yFyubJU+SaH+VE34i/8tQI7YycAyLRvp1x6bSNjQh9IWSkFWFzJWXsW7Fc8jqxy6GhM2P6SATpB+FfcIxa1uwBdb0yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998491; c=relaxed/simple;
	bh=MWoBClLeIZ/X4EuwScEqbMFCxUZuHMlhDDgwPq2blEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljfiIXd0PKHVdyFFQRNhWQKNmwNcjItaYYjRp4dI63JNE7Js6wjUtQytpI0iF17B3/hUnHczhnQmY5K6BWy7AWo4BDEi4eEVFgU0LXtj1aNNTCFtVfiu69kiVMXrkFQ2IlSyAJQIWUPJnpPM8PyihRE5hohJJqLkuavyFEM6KJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=TnOZ2jGc; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=v9dTNFNbDEvopER9/lAdaZC8NXm4BEiiYqgBsC4Hxlw=; b=TnOZ2jGcxfirGQkG
	bWU6Nb740WtaybeQIRrhGULemY4dvxOnwrN2mBKi99Rl5wPOs20LPOjYedlPsmUUDXac9l3DIgq29
	LFb/rkSmKv0cj4JpMWyVV/HnsRbWk6aAwz/AOjFpkm6QDhjirhd6PyZUXKOy5mutLX4bayvzscx3i
	q1+twSjrp8OhQb41djrLc+zD09sTLMS7dF1H/W1VRQywiv/6zfTrDZ8uQfR5HQx+AnIdvcYD5WETQ
	5uFzjjEyDBCcGrE1ozqvltgh8goBoAR7UfGSyYqdNuJAZ4laNVVqrk6+PPnMrVkUUD04Lw3uzFYMq
	03919vkgZ1g8Bz8Jxw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sCLjw-003Drb-0q;
	Wed, 29 May 2024 16:01:24 +0000
Date: Wed, 29 May 2024 16:01:24 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: adt7316: remove unused struct
 'adt7316_limit_regs'
Message-ID: <ZldRVBPi4utAfRd8@gallifrey>
References: <20240528233008.191403-1-linux@treblig.org>
 <d9a3c974-8a13-43f8-a0d1-0e55f6e1f3ef@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <d9a3c974-8a13-43f8-a0d1-0e55f6e1f3ef@moroto.mountain>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 16:01:00 up 21 days,  3:15,  1 user,  load average: 0.16, 0.08, 0.02
User-Agent: Mutt/2.2.12 (2023-09-09)

* Dan Carpenter (dan.carpenter@linaro.org) wrote:
> On Wed, May 29, 2024 at 12:30:08AM +0100, linux@treblig.org wrote:
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
> > ---
> >  drivers/staging/iio/addac/adt7316.c | 8 --------
> >  1 file changed, 8 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> > index 79467f056a05..23d036d2802c 100644
> > --- a/drivers/staging/iio/addac/adt7316.c
> > +++ b/drivers/staging/iio/addac/adt7316.c
> > @@ -209,14 +209,6 @@ struct adt7316_chip_info {
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
> >  
> 
> Could you delete the blank line as well?  Otherwise we have two blank
> lines in a row and checkpatch will complain.

Sure, v2 sent.
(checkpatch didn't moan at me with or without).

Dave

> regards,
> dan carpenter
> 
> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

