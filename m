Return-Path: <linux-iio+bounces-3587-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD4987E960
	for <lists+linux-iio@lfdr.de>; Mon, 18 Mar 2024 13:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2041C1F23211
	for <lists+linux-iio@lfdr.de>; Mon, 18 Mar 2024 12:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64981E532;
	Mon, 18 Mar 2024 12:36:06 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9B338387
	for <linux-iio@vger.kernel.org>; Mon, 18 Mar 2024 12:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710765366; cv=none; b=FRAgyJQYDWoyXlNKd/6ZZUIZmhi8nUlleZ4YbqGCeN4Fcej+6aJmKyJMsrPf6nvgwzc8rMI/ruGQNj3EKWGPqf3GHME1rpnMcmXUGrDtIw3fYpTyr58OrTMnVCikxY3eBvNyy6YB3uEIVEQ0Ya7TqpiRKGVkQp4VBt8VbujmiAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710765366; c=relaxed/simple;
	bh=c0Sg9lYX+H8Gt+txMOrAtKADb9dF3witp695gyfg56Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ggcI7ugIY2EJ1xCwHAg4C1rDOi6Nlh0v/pkGkXRNMvVCCWSJLxBkUP1huaTww/wzbFfaDMIGWlaXFxxE5GRvjm3NcQgKiAhUoJ6Jq3XuU+l22l+TsxbH8V2Fvx/vUGNPH9vCGaNkm1G71NHbNbM0t4jEZrspQxwuwRyQQ8Lo4r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TyvNz0cQZz6K9Wf;
	Mon, 18 Mar 2024 20:31:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D61781417A1;
	Mon, 18 Mar 2024 20:36:01 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 18 Mar
 2024 12:35:40 +0000
Date: Mon, 18 Mar 2024 12:35:39 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Nuno Sa <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>, "Jonathan
 Cameron" <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 3/4] iio: buffer: iio: core: move to the cleanup.h
 magic
Message-ID: <20240318123539.000057b6@Huawei.com>
In-Reply-To: <ZfX1HGqT1LwA2b73@surfacebook.localdomain>
References: <20240229-iio-use-cleanup-magic-v3-0-c3d34889ae3c@analog.com>
	<20240229-iio-use-cleanup-magic-v3-3-c3d34889ae3c@analog.com>
	<ZfX1HGqT1LwA2b73@surfacebook.localdomain>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sat, 16 Mar 2024 21:38:04 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> Thu, Feb 29, 2024 at 04:10:27PM +0100, Nuno Sa kirjoitti:
> > Use the new cleanup magic for handling mutexes in IIO. This allows us to
> > greatly simplify some code paths.  
> 
> ...
> 
> >  	ret = iio_scan_mask_query(indio_dev, buffer, this_attr->address);
> >  	if (ret < 0)
> > -		goto error_ret;
> > -	if (!state && ret) {
> > -		ret = iio_scan_mask_clear(buffer, this_attr->address);
> > -		if (ret)
> > -			goto error_ret;
> > -	} else if (state && !ret) {
> > +		return ret;
> > +
> > +	if (state && ret)
> > +		return len;  
> 
> I would leave the original checks. It's natural pattern
> 
> 	if (foo && !bar)
> 	if (!foo && bar) // or 'else if' depending on the context
> 
> > +	if (state)
> >  		ret = iio_scan_mask_set(indio_dev, buffer, this_attr->address);
> > -		if (ret)
> > -			goto error_ret;
> > -	}
> > +	else
> > +		ret = iio_scan_mask_clear(buffer, this_attr->address);
> > +	if (ret)
> > +		return ret;
> >  
> > -error_ret:
> > -	mutex_unlock(&iio_dev_opaque->mlock);
> > -
> > -	return ret < 0 ? ret : len;
> > +	return len;  
> 
> ...
> 
> >  	/* Already in desired state */
> >  	if (inlist == requested_state)
> > -		goto done;
> > +		return len;  
> 
> Returning error code immediately is fine, but splitting return success seems to
> me a bit too much. It is harder to follow (you really need to understand how many
> "success" variants can be).

The pattern of detecting 'nothing to do' and existing early is pretty common.
I agree that it gets dubious if there are lots of early 'success' exits, but
this one case seems reasonable to me.

Jonathan


> 
> >  	if (requested_state)
> >  		ret = __iio_update_buffers(indio_dev, buffer, NULL);
> >  	else
> >  		ret = __iio_update_buffers(indio_dev, NULL, buffer);
> > +	if (ret)
> > +		return ret;
> >  
> > -done:
> > -	mutex_unlock(&iio_dev_opaque->mlock);
> > -	return (ret < 0) ? ret : len;
> > +	return len;
> >  }  
> 


