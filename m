Return-Path: <linux-iio+bounces-5492-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9E28D48D8
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 11:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF0D1C21CA2
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 09:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D1417618F;
	Thu, 30 May 2024 09:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="qCKBPvXr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Io9/L6Sl"
X-Original-To: linux-iio@vger.kernel.org
Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEED1482F1;
	Thu, 30 May 2024 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717062301; cv=none; b=TEPy1fYdWTqGv4J39PLKeYFVBIyukvEPr5ez4P4E22ZIuYmY+UsDPsfurj06tVpu5qk5dcXNCLxXk94pmX6kaH/c3UG/iRd1/XJ/qgXY2K+N3BWC/x9RDX33JHqw/0ypa2DjBLlUctOoAlRFf7KDQhXUdLJyE5x4Yf0MXiecvqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717062301; c=relaxed/simple;
	bh=45Zwg9DgZghxI7ptVhk8WNm4u73Vh0h462KoZAA/+Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7lIivPMk5Bg6XbvOWH6BluPzWb45NCyJ2fRYinKILVlef3ywt1yPrdyZuS+lpzrNC4833ibydbR96UP4NDYcDkxt6nBH0CPYjQcjnFL6e0xEscrXrCIHvhhHwRA6dpcz5uMTjUNB3CAVbZ3b2uQFGKj34poBdV9T4EJeXO9lrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=qCKBPvXr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Io9/L6Sl; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 6FBE518000FA;
	Thu, 30 May 2024 05:44:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 30 May 2024 05:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717062298; x=1717148698; bh=vNMVNuaWek
	S6eTivwMmlyaG4mzIb2gEf+EB3oXFipww=; b=qCKBPvXrrGDBaxGbKi70yi5+zW
	SEgbhNI2r2sh2iDj+/1VyFxtTi5FNdNZwqTaDl5yYxR68fYVZKi/X7srZ9LwRULz
	OcjwsZXdTvl+qzp53hziR/PpHadSM3EKmvJMrpa3h7PsoabmOfq5pAOdjNIcIQLn
	S0T2nYl0t8aRKU/Jw51WdqTpwBeWE/wdYrM39t190zm0e4DWLfPe9b5phYi5QCE9
	lMNnLC/De8d1QC3t/+fldRFV4tjhdYjKPQp0OE0y2uX7nQCCt3KN9fJxaj235X8I
	lLxE5iBudGeewRhVAwCoWsLAaVIOE82jJ4nBXeDiN/iiZsp0OFjf3g4ADDNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717062298; x=1717148698; bh=vNMVNuaWekS6eTivwMmlyaG4mzIb
	2gEf+EB3oXFipww=; b=Io9/L6Sl5JvJ/O9EbcAjk9tOOWhupWSyAM7+KM0Bcc7F
	B0ldUBx+gtxpdOQ55AGw3M056QQi1oHPYxwwWaqErojdpluMAEKkddQ5ThIz7McE
	gjwbc9rC1xSx0ImdxOfXAW7IsULU5gaHFpKU8vS38J2y1b3CCAw+Uu70A7khaH74
	H1+B04xF/W2KyVZbM46X9KqjjO3WoVva7/M7nmegYlDRssjdH6DfTPiDrG2kqfSW
	mCdOzJQz84xV4q0SgQVjlaiL43Dy5TR5e/xRcA5APUrsCnEMJzv7lQzMym3jKEAe
	q2fTZcaGOMc1jBU4tG8vIEx4Jc0Xu9YhkGBftpJQMg==
X-ME-Sender: <xms:mUpYZrnuaCw9wKng4hYzTd26oH4vnbU2eEVOjB8Lw6CZbY4pjauVEA>
    <xme:mUpYZu32qfez0nO8vHiPP190T7_EZViRhpILLwy72EZUVJVemBZ4wSvu6_G_Q9_er
    S8bDLWttK4Aug>
X-ME-Received: <xmr:mUpYZhppE0d8FeFgl9MmKtmRif0Q2ZeV8ysYhByXp_wmsYmZbPev9yl6rlUh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucggtffrrghtthgvrhhnpeehgedvvedvleejuefgtdduudfhkeeltdeihfevjeekje
    euhfdtueefhffgheekteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:mUpYZjmIjGgWj58tZf6X_n_Ug1FuA0v0SExSKRC8QaxQpHFfSRhsWg>
    <xmx:mUpYZp36CAUM2okC8xDMZDRISthUruTuIGn8R6IR0xzqf6UcPmPPsw>
    <xmx:mUpYZitfnuWdZ-brJUUrYqUcuHAElGLtdnwuU-p0PJplVcqt_E8oyg>
    <xmx:mUpYZtW4MIbLxGiwA8mt-SACvBPfZYkW3IjwPwjwcWQon5pgYZZSnA>
    <xmx:mkpYZjPptq01Kl3IRxPTBkYVqu78atWivYpM0W_le3n8GLUkQz4Ct_th>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 05:44:57 -0400 (EDT)
Date: Thu, 30 May 2024 11:45:03 +0200
From: Greg KH <greg@kroah.com>
To: linux@treblig.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: iio: adt7316: remove unused struct
 'adt7316_limit_regs'
Message-ID: <2024053049-repossess-moonwalk-4235@gregkh>
References: <20240529160055.28489-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529160055.28489-1-linux@treblig.org>

On Wed, May 29, 2024 at 05:00:55PM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'adt7316_limit_regs' has never been used since the original
> commit 35f6b6b86ede ("staging: iio: new ADT7316/7/8 and ADT7516/7/9
> driver").
> 
> The comment above it is a copy-and-paste from a different struct.
> 
> Remove both the struct and the comment.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/staging/iio/addac/adt7316.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 79467f056a05..f4260786d50a 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -209,15 +209,6 @@ struct adt7316_chip_info {
>  #define ADT7316_TEMP_AIN_INT_MASK	\
>  	(ADT7316_TEMP_INT_MASK)
>  
> -/*
> - * struct adt7316_chip_info - chip specific information
> - */
> -
> -struct adt7316_limit_regs {
> -	u16	data_high;
> -	u16	data_low;
> -};
> -
>  static ssize_t adt7316_show_enabled(struct device *dev,
>  				    struct device_attribute *attr,
>  				    char *buf)
> -- 
> 2.45.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

