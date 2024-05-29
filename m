Return-Path: <linux-iio+bounces-5462-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F1F8D3C63
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 18:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDF9C1F217FE
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 16:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8235918410F;
	Wed, 29 May 2024 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="guea9sdN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F941836E0
	for <linux-iio@vger.kernel.org>; Wed, 29 May 2024 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000093; cv=none; b=Lb47gFXUYj7IJlno5fBD+L7WKWWzCdeYF+PwVzpH5iZSe+5CD9cReAbjcUu4kLHSn+hXTcPr0VCli/OMIxNo0jq1UVTKIMMbIcNVnel3q+0vZ5ubNW34zAlr3qCi2LpJ7FmZC66amvKY7Of3Imraq9rhZfMdsZAjzTYM67ZHBd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000093; c=relaxed/simple;
	bh=vNJiDOu1HJQcTh2QoH0ZF6EeoU/vMa/maD5ym7acze8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+YbD7pu8xZx8e5c/6DpZJStKxJaBkQE4jj6LJNvNz1XUotI+lSauW4pUOehDlRpgunx0UCsv/ZqvptwflO+sPS6r7ma5mkDUNrjtdGpu4BP6+SkcVHfmvaoHQGTcumuglVfZLJf3WF3KG+4abiM8Sfp1yMVFj2ZNf/X05DfUfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=guea9sdN; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e95a1d5ee2so8305331fa.0
        for <linux-iio@vger.kernel.org>; Wed, 29 May 2024 09:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717000090; x=1717604890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NEJH+7+vj6ruF1GbLbgob2BE38yHKh8JHlHGL8KdovU=;
        b=guea9sdNPBp2+nH2CwK0kuAmxX84BW8S6340QSc4xEFZnpdR+AIISSsoZP3ilcwh/8
         W1Xs1+bN2zkeAWzlAWBZa48MpUlC9TYXxOk18PuiMcKYZvQKUrOj6j9KYEZfeFrYViNa
         oPJttLcbj7UefRTjWchYzSCyRHf2gkbzKeVynXLB/iaDD8t0X9CYQvMdQTL+bHzALPEK
         /CzRBu3CvK2gEse5Xd8XPrqDTncDxNfe++Sk5bLHdLjSfiEEIHSp+M203xdoFzrlRN2m
         e/AliR3tZKSAGbAosEVBJD6bTi+I6S1ba4ZMUWADTzpxbVm2lax7G9wEX7pYXj5hThCK
         /bjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717000090; x=1717604890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEJH+7+vj6ruF1GbLbgob2BE38yHKh8JHlHGL8KdovU=;
        b=A1pKdVaoqxyjdE5QDhw+mJL9/73Gv0fnrLs08a7lAGnPe64D9cX4kYhYcV8YbfVSIq
         AZ9gpAX+2Ka3N9QJv8H3gFpaXje89juX3avnY0EWgPhkYJt+Npz+UG17onNl9CYV14tR
         AOc3sJ2q7A9/+5kUJlBTp0F51xFj724jMn3N0zOyPKRz6/DDokezXKcNgFUonuFBvzK/
         9jjZKx4EVgS+sbREGk1PMS9ejwb+9DX/spHnqUfUqM6lX0qHxEUZKIJHN5JCffWJASPS
         h5v0XmJkIxuPD9dRkXik7J+DocbPjynfH9xRw9iPWWb6w5Qh85a0wokZ8+lh0MfOYENj
         uCJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkHnWp6ZB8Wxr6NFIoOzqY1fnEzZuJEla6s5Pv9eUdIFGkTnm9RdlsIM82iGfQ8S2p1w6LEjn4TK57LC2lZlHOdtZrIntGWxJ2
X-Gm-Message-State: AOJu0YwuTVZsX/N3jPfqv3lVPUNRNiBaWQUl5UdEafTS7WDveZ4rla3K
	LJ7vEZK/yEb10noXHd2yl/hZz0pRycAV6vXP/a+he/W+Ri0IS3RegO5sdNJPZg8=
X-Google-Smtp-Source: AGHT+IFmYVGVDhXJ/UgzgklvENZdHrtaQJwa288W1cA8geS62OGiVwASpA0S4D47EdPq0VKN1MsXJw==
X-Received: by 2002:a2e:9d91:0:b0:2e9:821a:82fb with SMTP id 38308e7fff4ca-2e9821a837cmr55797371fa.6.1717000087636;
        Wed, 29 May 2024 09:28:07 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c93a828sm735495666b.83.2024.05.29.09.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 09:28:07 -0700 (PDT)
Date: Wed, 29 May 2024 19:28:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: adt7316: remove unused struct
 'adt7316_limit_regs'
Message-ID: <c0bcb7b5-3155-445f-94ff-4020fe05109d@moroto.mountain>
References: <20240528233008.191403-1-linux@treblig.org>
 <d9a3c974-8a13-43f8-a0d1-0e55f6e1f3ef@moroto.mountain>
 <ZldRVBPi4utAfRd8@gallifrey>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZldRVBPi4utAfRd8@gallifrey>

On Wed, May 29, 2024 at 04:01:24PM +0000, Dr. David Alan Gilbert wrote:
> * Dan Carpenter (dan.carpenter@linaro.org) wrote:
> > On Wed, May 29, 2024 at 12:30:08AM +0100, linux@treblig.org wrote:
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
> > > ---
> > >  drivers/staging/iio/addac/adt7316.c | 8 --------
> > >  1 file changed, 8 deletions(-)
> > > 
> > > diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> > > index 79467f056a05..23d036d2802c 100644
> > > --- a/drivers/staging/iio/addac/adt7316.c
> > > +++ b/drivers/staging/iio/addac/adt7316.c
> > > @@ -209,14 +209,6 @@ struct adt7316_chip_info {
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
> > >  
> > 
> > Could you delete the blank line as well?  Otherwise we have two blank
> > lines in a row and checkpatch will complain.
> 
> Sure, v2 sent.
> (checkpatch didn't moan at me with or without).

Thanks.  You'd need to apply the patch and re-run checkpatch.pl with the
-f option.  It's not something that's obvious.

regards,
dan carpenter


